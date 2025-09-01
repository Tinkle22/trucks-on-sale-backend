<?php
header('Content-Type: text/html; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Include database configuration
$db = new mysqli('localhost', 'truc_brian24', 'Brian0776828793', 'truc_tos24');
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

// Get parameters from URL
$dealer_id = $_GET['dealer_id'] ?? null;
$limit = min(intval($_GET['limit'] ?? 20), 50); // Max 50 dealers
$search = $_GET['search'] ?? null;
$location = $_GET['location'] ?? null;

// Base URL for the website
$base_url = 'https://trucks24.co.za';
$logo_url = $base_url . '/assets/logo.jpg';
$app_url = 'https://trucks24.co.za/native'; // Link to download the app

// Initialize variables
$page_title = 'Dealer Listings';
$page_description = 'Browse verified dealerships on Trucks On Sale';
$og_image = $logo_url; // Default to logo
$canonical_url = $base_url . '/dealers.php?' . $_SERVER['QUERY_STRING'];
$dealer_data = null;
$dealers_list = [];
$dealer_vehicles = [];

// Fetch data based on parameters
try {
    if ($dealer_id) {
        // Fetch specific dealer data and their vehicles
        $stmt = $db->prepare("
            SELECT u.*, COUNT(v.vehicle_id) as vehicle_count
            FROM users u
            LEFT JOIN vehicles v ON u.user_id = v.dealer_id AND v.status = 'available'
            WHERE u.user_id = ? AND u.user_type = 'dealer' AND u.status = 'active'
            GROUP BY u.user_id
        ");
        $stmt->bind_param("i", $dealer_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $dealer_data = $result->fetch_assoc();

        if ($dealer_data) {
            $page_title = $dealer_data['company_name'] ?: $dealer_data['username'];
            $page_description = "View vehicles from " . $page_title . 
                              " - " . $dealer_data['vehicle_count'] . " vehicles available";
            
            // Fetch dealer's vehicles
            $stmt = $db->prepare("
                SELECT v.*, 
                       (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
                FROM vehicles v
                WHERE v.dealer_id = ? AND v.status = 'available'
                ORDER BY v.created_at DESC
                LIMIT ?
            ");
            $stmt->bind_param("ii", $dealer_id, $limit);
            $stmt->execute();
            $result = $stmt->get_result();
            $dealer_vehicles = $result->fetch_all(MYSQLI_ASSOC);
        }
    } else {
        // Fetch all dealers
        $dealers_query = "
            SELECT u.*, COUNT(v.vehicle_id) as vehicle_count
            FROM users u
            LEFT JOIN vehicles v ON u.user_id = v.dealer_id AND v.status = 'available'
            WHERE u.user_type = 'dealer' AND u.status = 'active'
        ";
        $params = [];
        $param_types = "";

        // Apply search filter if specified
        if ($search) {
            $dealers_query .= " AND (u.company_name LIKE ? OR u.username LIKE ?)";
            $search_param = "%" . $search . "%";
            $params[] = $search_param;
            $params[] = $search_param;
            $param_types .= "ss";
        }

        // Apply location filter if specified
        if ($location) {
            $dealers_query .= " AND (u.physical_address LIKE ? OR u.city LIKE ? OR u.region LIKE ?)";
            $location_param = "%" . $location . "%";
            $params[] = $location_param;
            $params[] = $location_param;
            $params[] = $location_param;
            $param_types .= "sss";
        }

        $dealers_query .= " GROUP BY u.user_id ORDER BY vehicle_count DESC, u.company_name ASC LIMIT ?";
        $params[] = $limit;
        $param_types .= "i";

        $stmt = $db->prepare($dealers_query);
        if (!empty($params)) {
            $stmt->bind_param($param_types, ...$params);
        }
        $stmt->execute();
        $result = $stmt->get_result();
        $dealers_list = $result->fetch_all(MYSQLI_ASSOC);

        if (!empty($dealers_list)) {
            $page_description = "Browse " . count($dealers_list) . " verified dealerships";
            if ($search) {
                $page_description .= " matching '" . htmlspecialchars($search) . "'";
            }
            if ($location) {
                $page_description .= " in " . htmlspecialchars($location);
            }
        }
    }

} catch (Exception $e) {
    error_log("Error in dealers.php: " . $e->getMessage());
    $page_description = "Error loading dealer information";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($page_title); ?> - Trucks On Sale</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="<?php echo htmlspecialchars($page_description); ?>">
    <meta name="keywords" content="truck dealers, commercial vehicle dealers, South Africa, trucks for sale">
    <meta name="author" content="Trucks On Sale">
    <link rel="canonical" href="<?php echo htmlspecialchars($canonical_url); ?>">
    
    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php echo htmlspecialchars($page_title); ?> - Trucks On Sale">
    <meta property="og:description" content="<?php echo htmlspecialchars($page_description); ?>">
    <meta property="og:image" content="<?php echo htmlspecialchars($og_image); ?>">
    <meta property="og:url" content="<?php echo htmlspecialchars($canonical_url); ?>">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Trucks On Sale">
    
    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<?php echo htmlspecialchars($page_title); ?> - Trucks On Sale">
    <meta name="twitter:description" content="<?php echo htmlspecialchars($page_description); ?>">
    <meta name="twitter:image" content="<?php echo htmlspecialchars($og_image); ?>">
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="<?php echo $base_url; ?>/favicon.ico">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 30px 20px;
            text-align: center;
        }

        .logo {
            max-width: 150px;
            height: auto;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .content {
            padding: 40px 20px;
        }

        .dealers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .dealer-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border: 1px solid #e0e0e0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dealer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .dealer-card h3 {
            color: #1e3c72;
            font-size: 1.4em;
            margin-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 10px;
        }

        .dealer-info {
            margin-bottom: 10px;
        }

        .dealer-info strong {
            color: #555;
        }

        .vehicle-count {
            background: #1e3c72;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            display: inline-block;
            font-weight: bold;
            margin-top: 10px;
        }

        .location {
            color: #666;
            margin: 10px 0;
            font-style: italic;
        }

        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .vehicle-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border: 1px solid #e0e0e0;
            transition: transform 0.3s ease;
        }

        .vehicle-card:hover {
            transform: translateY(-3px);
        }

        .vehicle-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .vehicle-info {
            padding: 20px;
        }

        .vehicle-info h4 {
            color: #1e3c72;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .price {
            font-size: 1.3em;
            font-weight: bold;
            color: #e74c3c;
            margin: 10px 0;
        }

        .cta-section {
            background: #f8f9fa;
            padding: 40px 20px;
            text-align: center;
            border-top: 1px solid #e0e0e0;
        }

        .cta-button {
            display: inline-block;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
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

            .dealers-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header with Logo -->
        <div class="header">
            <img src="<?php echo $logo_url; ?>" alt="Trucks On Sale Logo" class="logo">
            <h1><?php echo htmlspecialchars($page_title); ?></h1>
            <p><?php echo htmlspecialchars($page_description); ?></p>
        </div>

        <!-- Main Content -->
        <div class="content">
            <?php if ($dealer_id && $dealer_data): ?>
                <!-- Single Dealer Display -->
                <div class="dealer-card">
                    <h2><?php echo htmlspecialchars($dealer_data['company_name'] ?: $dealer_data['username']); ?></h2>
                    <p><strong>✅ Verified Dealership</strong></p>

                    <?php if ($dealer_data['physical_address']): ?>
                        <div class="location">📍 <?php echo htmlspecialchars($dealer_data['physical_address']); ?></div>
                    <?php endif; ?>

                    <div class="dealer-info">
                        <strong>Available Vehicles:</strong> <?php echo $dealer_data['vehicle_count']; ?>
                    </div>

                    <?php if ($dealer_data['phone']): ?>
                        <div class="dealer-info">
                            <strong>Phone:</strong> <?php echo htmlspecialchars($dealer_data['phone']); ?>
                        </div>
                    <?php endif; ?>

                    <?php if ($dealer_data['email']): ?>
                        <div class="dealer-info">
                            <strong>Email:</strong> <?php echo htmlspecialchars($dealer_data['email']); ?>
                        </div>
                    <?php endif; ?>
                </div>

                <?php if (!empty($dealer_vehicles)): ?>
                    <h3 style="margin-top: 30px; color: #1e3c72;">Available Vehicles (<?php echo count($dealer_vehicles); ?>)</h3>
                    <div class="vehicles-grid">
                        <?php foreach ($dealer_vehicles as $vehicle): ?>
                            <div class="vehicle-card">
                                <?php if ($vehicle['primary_image']): ?>
                                    <img src="<?php echo $base_url . '/' . $vehicle['primary_image']; ?>"
                                         alt="<?php echo htmlspecialchars(($vehicle['year'] ? $vehicle['year'] . ' ' : '') .
                                                                        ($vehicle['make'] ? $vehicle['make'] . ' ' : '') .
                                                                        ($vehicle['model'] ? $vehicle['model'] : '')); ?>"
                                         class="vehicle-image">
                                <?php endif; ?>

                                <div class="vehicle-info">
                                    <h4><?php echo htmlspecialchars(($vehicle['year'] ? $vehicle['year'] . ' ' : '') .
                                                                   ($vehicle['make'] ? $vehicle['make'] . ' ' : '') .
                                                                   ($vehicle['model'] ? $vehicle['model'] : '')); ?></h4>

                                    <?php if ($vehicle['price']): ?>
                                        <div class="price">R<?php echo number_format($vehicle['price']); ?></div>
                                    <?php elseif ($vehicle['daily_rate']): ?>
                                        <div class="price">R<?php echo number_format($vehicle['daily_rate']); ?>/day</div>
                                    <?php endif; ?>

                                    <?php if ($vehicle['city'] || $vehicle['region']): ?>
                                        <div class="location">
                                            📍 <?php echo htmlspecialchars($vehicle['city'] ? $vehicle['city'] : $vehicle['region']); ?>
                                        </div>
                                    <?php endif; ?>

                                    <?php if ($vehicle['category']): ?>
                                        <div class="dealer-info">
                                            <strong>Category:</strong> <?php echo htmlspecialchars(ucfirst($vehicle['category'])); ?>
                                        </div>
                                    <?php endif; ?>

                                    <?php if ($vehicle['mileage']): ?>
                                        <div class="dealer-info">
                                            <strong>Mileage:</strong> <?php echo number_format($vehicle['mileage']); ?> km
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>

            <?php elseif (!empty($dealers_list)): ?>
                <!-- All Dealers Display -->
                <h2 style="color: #1e3c72; margin-bottom: 20px;">
                    Verified Dealerships (<?php echo count($dealers_list); ?>)
                </h2>

                <div class="dealers-grid">
                    <?php foreach ($dealers_list as $dealer): ?>
                        <div class="dealer-card">
                            <h3><?php echo htmlspecialchars($dealer['company_name'] ?: $dealer['username']); ?></h3>
                            
                            <?php if ($dealer['physical_address']): ?>
                                <div class="location">📍 <?php echo htmlspecialchars($dealer['physical_address']); ?></div>
                            <?php endif; ?>

                            <div class="vehicle-count">
                                <?php echo $dealer['vehicle_count']; ?> Vehicles Available
                            </div>

                            <?php if ($dealer['phone']): ?>
                                <div class="dealer-info">
                                    <strong>📞 Phone:</strong> <?php echo htmlspecialchars($dealer['phone']); ?>
                                </div>
                            <?php endif; ?>

                            <?php if ($dealer['email']): ?>
                                <div class="dealer-info">
                                    <strong>📧 Email:</strong> <?php echo htmlspecialchars($dealer['email']); ?>
                                </div>
                            <?php endif; ?>

                            <div style="margin-top: 15px;">
                                <a href="<?php echo $base_url; ?>/dealers.php?dealer_id=<?php echo $dealer['user_id']; ?>" 
                                   class="cta-button" style="font-size: 0.9em; padding: 10px 20px;">
                                    View Vehicles
                                </a>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <?php if (count($dealers_list) >= $limit): ?>
                    <div style="text-align: center; margin-top: 30px; color: #666;">
                        <p><em>Showing <?php echo count($dealers_list); ?> dealerships. Visit our app or website to see more!</em></p>
                    </div>
                <?php endif; ?>

            <?php else: ?>
                <!-- No Dealers Found -->
                <div style="text-align: center; padding: 40px;">
                    <h2>No Dealerships Found</h2>
                    <p>We couldn't find any dealerships matching your criteria.</p>
                    <p>Try adjusting your search or browse all available vehicles.</p>
                </div>
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