<?php
header('Content-Type: text/html; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Include database configuration
require_once 'config.php';

// Get parameters from URL
$type = $_GET['type'] ?? 'generic';
$title = $_GET['title'] ?? 'Trucks On Sale';
$description = $_GET['description'] ?? 'South Africa\'s premier truck marketplace';
$id = $_GET['id'] ?? null;
$ids = $_GET['ids'] ?? null;
$price = $_GET['price'] ?? null;
$location = $_GET['location'] ?? null;
$route = $_GET['route'] ?? 'Home';
$category = $_GET['category'] ?? null;
$dealer_id = $_GET['dealer_id'] ?? null;
$listing_type = $_GET['listing_type'] ?? null;
$limit = min(intval($_GET['limit'] ?? 20), 50); // Max 50 vehicles

// Base URL for the website
$base_url = 'https://trucksonsale.co.za';
$logo_url = $base_url . '/assets/logo.jpg';
$app_url = 'https://trucksonsale.co.za/native'; // Link to download the app

// Initialize variables
$page_title = htmlspecialchars($title);
$page_description = htmlspecialchars($description);
$og_image = $logo_url; // Default to logo
$canonical_url = $base_url . '/share.php?' . $_SERVER['QUERY_STRING'];
$vehicle_data = null;
$dealership_data = null;
$vehicles_list = [];

// Fetch data based on type
try {
    if ($type === 'vehicle' && $id) {
        // Fetch single vehicle data
        $stmt = $db->prepare("
            SELECT v.*, u.company_name, u.username, u.phone, u.email,
                   (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
            FROM vehicles v
            LEFT JOIN users u ON v.dealer_id = u.user_id
            WHERE v.vehicle_id = ? AND v.status = 'available'
        ");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $vehicle_data = $result->fetch_assoc();

        if ($vehicle_data) {
            $page_title = ($vehicle_data['year'] ? $vehicle_data['year'] . ' ' : '') .
                         ($vehicle_data['make'] ? $vehicle_data['make'] . ' ' : '') .
                         ($vehicle_data['model'] ? $vehicle_data['model'] : '');
            $page_description = "View this " . ($vehicle_data['category'] ?? 'vehicle') .
                              " for " . ($vehicle_data['listing_type'] === 'hire' ? 'hire' : 'sale');

            if ($vehicle_data['price']) {
                $page_description .= " - R" . number_format($vehicle_data['price']);
            } elseif ($vehicle_data['daily_rate']) {
                $page_description .= " - R" . number_format($vehicle_data['daily_rate']) . "/day";
            }

            // Use vehicle image if available
            if ($vehicle_data['primary_image']) {
                $og_image = $base_url . '/' . $vehicle_data['primary_image'];
            }
        }

    } elseif ($type === 'dealership' && $id) {
        // Fetch dealership data
        $stmt = $db->prepare("
            SELECT u.*, COUNT(v.vehicle_id) as vehicle_count
            FROM users u
            LEFT JOIN vehicles v ON u.user_id = v.dealer_id AND v.status = 'available'
            WHERE u.user_id = ? AND u.user_type = 'dealer' AND u.status = 'active'
            GROUP BY u.user_id
        ");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $dealership_data = $result->fetch_assoc();

        if ($dealership_data) {
            $page_title = $dealership_data['company_name'] ?: $dealership_data['username'];
            $page_description = "View vehicles from " . $page_title .
                              " - " . $dealership_data['vehicle_count'] . " vehicles available";
        }

    } elseif ($type === 'list' && $ids) {
        // Fetch multiple vehicles
        $id_array = explode(',', $ids);
        $id_array = array_filter(array_map('intval', $id_array));

        if (!empty($id_array)) {
            $placeholders = str_repeat('?,', count($id_array) - 1) . '?';
            $stmt = $db->prepare("
                SELECT v.*, u.company_name, u.username,
                       (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
                FROM vehicles v
                LEFT JOIN users u ON v.dealer_id = u.user_id
                WHERE v.vehicle_id IN ($placeholders) AND v.status = 'available'
                ORDER BY v.created_at DESC
                LIMIT 10
            ");
            $stmt->bind_param(str_repeat('i', count($id_array)), ...$id_array);
            $stmt->execute();
            $result = $stmt->get_result();
            $vehicles_list = $result->fetch_all(MYSQLI_ASSOC);

            if (!empty($vehicles_list)) {
                $page_description = "Browse " . count($vehicles_list) . " featured vehicles";
                // Use first vehicle's image if available
                if ($vehicles_list[0]['primary_image']) {
                    $og_image = $base_url . '/' . $vehicles_list[0]['primary_image'];
                }
            }
        }
    }

    // Fetch current screen listings based on route and parameters
    if (empty($vehicles_list) && in_array($type, ['home', 'featured', 'latest', 'hire', 'dealerships', 'generic'])) {
        $listing_query = "
            SELECT v.*, u.company_name, u.username,
                   (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
            FROM vehicles v
            LEFT JOIN users u ON v.dealer_id = u.user_id
            WHERE v.status = 'available'
        ";
        $params = [];
        $param_types = "";

        // Apply filters based on screen type and parameters
        if ($type === 'featured') {
            $listing_query .= " AND v.featured = 1";
        } elseif ($type === 'hire') {
            $listing_query .= " AND (v.listing_type = 'hire' OR v.for_hire = 1)";
        } elseif ($type === 'latest') {
            $listing_query .= " AND (v.listing_type != 'hire' AND (v.for_hire IS NULL OR v.for_hire = 0))";
        }

        // Apply category filter if specified
        if ($category && $category !== 'all') {
            if ($category === 'others') {
                $listing_query .= " AND v.category NOT IN ('trucks', 'commercial', 'buses')";
            } else {
                $listing_query .= " AND v.category = ?";
                $params[] = $category;
                $param_types .= "s";
            }
        }

        // Apply dealer filter if specified
        if ($dealer_id) {
            $listing_query .= " AND v.dealer_id = ?";
            $params[] = intval($dealer_id);
            $param_types .= "i";
        }

        // Apply listing type filter if specified
        if ($listing_type) {
            if ($listing_type === 'hire') {
                $listing_query .= " AND (v.listing_type = 'hire' OR v.for_hire = 1)";
            } else {
                $listing_query .= " AND v.listing_type = ?";
                $params[] = $listing_type;
                $param_types .= "s";
            }
        }

        // Order and limit
        if ($type === 'featured') {
            $listing_query .= " ORDER BY v.featured_order ASC, v.created_at DESC";
        } else {
            $listing_query .= " ORDER BY v.created_at DESC";
        }

        $listing_query .= " LIMIT ?";
        $params[] = $limit;
        $param_types .= "i";

        // Execute query
        if (!empty($param_types)) {
            $stmt = $db->prepare($listing_query);
            $stmt->bind_param($param_types, ...$params);
        } else {
            $stmt = $db->prepare($listing_query);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $vehicles_list = $result->fetch_all(MYSQLI_ASSOC);

        // Update page description with actual count
        if (!empty($vehicles_list)) {
            $page_description = "Browse " . count($vehicles_list) . " vehicles";
            if ($type === 'featured') {
                $page_description = "Featured vehicles (" . count($vehicles_list) . ")";
            } elseif ($type === 'latest') {
                $page_description = "Latest vehicles (" . count($vehicles_list) . ")";
            } elseif ($type === 'hire') {
                $page_description = "Vehicles for hire (" . count($vehicles_list) . ")";
            }

            if ($category && $category !== 'all') {
                $page_description .= " in " . ucfirst($category);
            }

            // Use first vehicle's image if available
            if ($vehicles_list[0]['primary_image']) {
                $og_image = $base_url . '/' . $vehicles_list[0]['primary_image'];
            }
        }
    }

} catch (Exception $e) {
    error_log("Share page error: " . $e->getMessage());
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $page_title; ?> | Trucks On Sale</title>

    <!-- SEO Meta Tags -->
    <meta name="description" content="<?php echo $page_description; ?>">
    <meta name="keywords" content="trucks, commercial vehicles, trucks for sale, truck hire, South Africa">
    <meta name="author" content="Trucks On Sale">
    <link rel="canonical" href="<?php echo $canonical_url; ?>">

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php echo $page_title; ?>">
    <meta property="og:description" content="<?php echo $page_description; ?>">
    <meta property="og:image" content="<?php echo $og_image; ?>">
    <meta property="og:url" content="<?php echo $canonical_url; ?>">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Trucks On Sale">

    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<?php echo $page_title; ?>">
    <meta name="twitter:description" content="<?php echo $page_description; ?>">
    <meta name="twitter:image" content="<?php echo $og_image; ?>">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="<?php echo $base_url; ?>/favicon.ico">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #bb1010, #ff4444);
            color: white;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            border: 4px solid white;
            object-fit: cover;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .vehicle-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            background: #fafafa;
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
        }

        .vehicle-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .vehicle-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .vehicle-info h3 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 1.2em;
        }

        .category, .mileage, .dealer {
            font-size: 0.9em;
            color: #666;
            margin: 5px 0;
        }

        .hire-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ff8c00;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8em;
            font-weight: bold;
        }

        .more-vehicles {
            text-align: center;
            margin-top: 30px;
            padding: 20px;
            background: #f0f0f0;
            border-radius: 8px;
        }

        .price {
            color: #bb1010;
            font-size: 1.5em;
            font-weight: bold;
            margin: 10px 0;
        }

        .location {
            color: #666;
            margin: 5px 0;
        }

        .cta-section {
            text-align: center;
            padding: 40px 20px;
            background: #bb1010;
            color: white;
            border-radius: 12px;
            margin-top: 30px;
        }

        .cta-button {
            display: inline-block;
            background: white;
            color: #bb1010;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1.1em;
            margin: 10px;
            transition: transform 0.2s;
        }

        .cta-button:hover {
            transform: translateY(-2px);
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            border-top: 1px solid #e0e0e0;
            margin-top: 40px;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }

            .container {
                padding: 10px;
            }

            .content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header with Logo -->
        <div class="header">
            <img src="<?php echo $logo_url; ?>" alt="Trucks On Sale Logo" class="logo">
            <h1><?php echo $page_title; ?></h1>
            <p><?php echo $page_description; ?></p>
        </div>

        <!-- Main Content -->
        <div class="content">
            <?php if ($type === 'vehicle' && $vehicle_data): ?>
                <!-- Single Vehicle Display -->
                <div class="vehicle-card">
                    <?php if ($vehicle_data['primary_image']): ?>
                        <img src="<?php echo $base_url . '/' . $vehicle_data['primary_image']; ?>"
                             alt="<?php echo $page_title; ?>" class="vehicle-image">
                    <?php endif; ?>

                    <h2><?php echo $page_title; ?></h2>

                    <?php if ($vehicle_data['price']): ?>
                        <div class="price">R<?php echo number_format($vehicle_data['price']); ?></div>
                    <?php elseif ($vehicle_data['daily_rate']): ?>
                        <div class="price">R<?php echo number_format($vehicle_data['daily_rate']); ?>/day</div>
                    <?php endif; ?>

                    <?php if ($vehicle_data['city'] || $vehicle_data['region']): ?>
                        <div class="location">
                            📍 <?php echo $vehicle_data['city'] ? $vehicle_data['city'] : $vehicle_data['region']; ?>
                        </div>
                    <?php endif; ?>

                    <p><strong>Category:</strong> <?php echo ucfirst($vehicle_data['category'] ?? 'Vehicle'); ?></p>
                    <p><strong>Condition:</strong> <?php echo ucfirst($vehicle_data['condition_type'] ?? 'N/A'); ?></p>

                    <?php if ($vehicle_data['mileage']): ?>
                        <p><strong>Mileage:</strong> <?php echo number_format($vehicle_data['mileage']); ?> km</p>
                    <?php endif; ?>

                    <?php if ($vehicle_data['description']): ?>
                        <p><strong>Description:</strong> <?php echo htmlspecialchars(substr($vehicle_data['description'], 0, 200)); ?>...</p>
                    <?php endif; ?>

                    <?php if ($vehicle_data['company_name'] || $vehicle_data['username']): ?>
                        <p><strong>Dealer:</strong> <?php echo $vehicle_data['company_name'] ?: $vehicle_data['username']; ?></p>
                    <?php endif; ?>
                </div>

            <?php elseif ($type === 'dealership' && $dealership_data): ?>
                <!-- Dealership Display -->
                <div class="vehicle-card">
                    <h2><?php echo $dealership_data['company_name'] ?: $dealership_data['username']; ?></h2>
                    <p><strong>Verified Dealership</strong></p>

                    <?php if ($dealership_data['physical_address']): ?>
                        <div class="location">📍 <?php echo htmlspecialchars($dealership_data['physical_address']); ?></div>
                    <?php endif; ?>

                    <p><strong>Available Vehicles:</strong> <?php echo $dealership_data['vehicle_count']; ?></p>

                    <?php if ($dealership_data['phone']): ?>
                        <p><strong>Phone:</strong> <?php echo htmlspecialchars($dealership_data['phone']); ?></p>
                    <?php endif; ?>
                </div>

            <?php elseif (!empty($vehicles_list)): ?>
                <!-- Current Screen Vehicles Display -->
                <h2>
                    <?php
                    if ($type === 'featured') {
                        echo 'Featured Vehicles';
                    } elseif ($type === 'latest') {
                        echo 'Latest Vehicles';
                    } elseif ($type === 'hire') {
                        echo 'Vehicles for Hire';
                    } elseif ($type === 'home') {
                        echo 'Current Listings';
                    } else {
                        echo 'Vehicle Listings';
                    }
                    echo ' (' . count($vehicles_list) . ')';
                    ?>
                </h2>

                <?php if ($category && $category !== 'all'): ?>
                    <p><strong>Category:</strong> <?php echo ucfirst($category === 'others' ? 'Other Vehicles' : $category); ?></p>
                <?php endif; ?>

                <div class="vehicles-grid">
                    <?php foreach ($vehicles_list as $index => $vehicle): ?>
                        <div class="vehicle-card">
                            <?php if ($vehicle['primary_image']): ?>
                                <img src="<?php echo $base_url . '/' . $vehicle['primary_image']; ?>"
                                     alt="<?php echo htmlspecialchars(($vehicle['year'] ? $vehicle['year'] . ' ' : '') .
                                                                    ($vehicle['make'] ? $vehicle['make'] . ' ' : '') .
                                                                    ($vehicle['model'] ? $vehicle['model'] : '')); ?>"
                                     class="vehicle-image">
                            <?php endif; ?>

                            <div class="vehicle-info">
                                <h3><?php echo htmlspecialchars(($vehicle['year'] ? $vehicle['year'] . ' ' : '') .
                                                               ($vehicle['make'] ? $vehicle['make'] . ' ' : '') .
                                                               ($vehicle['model'] ? $vehicle['model'] : '')); ?></h3>

                                <?php if ($vehicle['price']): ?>
                                    <div class="price">R<?php echo number_format($vehicle['price']); ?></div>
                                <?php elseif ($vehicle['daily_rate']): ?>
                                    <div class="price">R<?php echo number_format($vehicle['daily_rate']); ?>/day</div>
                                <?php elseif ($vehicle['weekly_rate']): ?>
                                    <div class="price">R<?php echo number_format($vehicle['weekly_rate']); ?>/week</div>
                                <?php elseif ($vehicle['monthly_rate']): ?>
                                    <div class="price">R<?php echo number_format($vehicle['monthly_rate']); ?>/month</div>
                                <?php endif; ?>

                                <?php if ($vehicle['city'] || $vehicle['region']): ?>
                                    <div class="location">
                                        📍 <?php echo htmlspecialchars($vehicle['city'] ? $vehicle['city'] : $vehicle['region']); ?>
                                    </div>
                                <?php endif; ?>

                                <?php if ($vehicle['category']): ?>
                                    <div class="category">
                                        <strong>Category:</strong> <?php echo htmlspecialchars(ucfirst($vehicle['category'])); ?>
                                    </div>
                                <?php endif; ?>

                                <?php if ($vehicle['mileage']): ?>
                                    <div class="mileage">
                                        <strong>Mileage:</strong> <?php echo number_format($vehicle['mileage']); ?> km
                                    </div>
                                <?php endif; ?>

                                <?php if ($vehicle['company_name'] || $vehicle['username']): ?>
                                    <div class="dealer">
                                        <strong>Dealer:</strong> <?php echo htmlspecialchars($vehicle['company_name'] ?: $vehicle['username']); ?>
                                    </div>
                                <?php endif; ?>

                                <?php if ($vehicle['listing_type'] === 'hire' || $vehicle['for_hire']): ?>
                                    <div class="hire-badge">FOR HIRE</div>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <?php if (count($vehicles_list) >= $limit): ?>
                    <div class="more-vehicles">
                        <p><em>Showing <?php echo count($vehicles_list); ?> vehicles. Visit our app or website to see more!</em></p>
                    </div>
                <?php endif; ?>

            <?php else: ?>
                <!-- Generic Content -->
                <h2>Welcome to Trucks On Sale</h2>
                <p>South Africa's premier marketplace for trucks, commercial vehicles, and more.</p>
                <p>Browse thousands of vehicles from verified dealerships across the country.</p>
            <?php endif; ?>
        </div>

        <!-- Call to Action Section -->
        <div class="cta-section">
            <h2>Get the Trucks On Sale App</h2>
            <p>Download our mobile app for the best browsing experience</p>
            <a href="<?php echo $app_url; ?>" class="cta-button">Download App</a>
            <a href="<?php echo $base_url; ?>" class="cta-button">Visit Website</a>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; <?php echo date('Y'); ?> Trucks On Sale. All rights reserved.</p>
            <p>South Africa's trusted truck marketplace</p>
        </div>
    </div>
</body>
</html>