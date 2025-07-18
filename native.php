<?php
require_once 'config.php';

// Function to sanitize input
function sanitizeInput($input) {
    return htmlspecialchars(strip_tags($input));
}

// Function to get vehicle by ID with images
function getVehicleByIdWithImages($vehicle_id) {
    global $db;

    // Get vehicle details using existing function
    $vehicle = get_vehicle_by_id($vehicle_id);

    if ($vehicle) {
        // Get vehicle images using existing function
        $images_result = get_vehicle_images($vehicle_id);
        $images = [];

        if ($images_result) {
            while ($image = $images_result->fetch_assoc()) {
                $images[] = $image['image_path'];
            }
        }

        $vehicle['images'] = $images;
        $vehicle['dealer_name'] = $vehicle['company_name'];
        $vehicle['dealer_phone'] = $vehicle['phone'];
        $vehicle['dealer_email'] = $vehicle['email'];
    }

    return $vehicle;
}

// Function to search vehicles using existing functions
function searchVehiclesWithFilters($params) {
    // Convert parameters to the format expected by existing functions
    $filters = [];

    if (!empty($params['category']) && $params['category'] !== 'all') {
        $filters['category'] = $params['category'];
    }

    if (!empty($params['region']) && $params['region'] !== 'All Regions') {
        $filters['region'] = $params['region'];
    }

    if (!empty($params['make'])) {
        $filters['make'] = $params['make'];
    }

    if (!empty($params['price'])) {
        if (strpos($params['price'], 'Under') !== false) {
            $priceValue = (int) preg_replace('/[^0-9]/', '', $params['price']);
            $filters['max_price'] = $priceValue;
        } elseif (strpos($params['price'], 'Over') !== false) {
            $priceValue = (int) preg_replace('/[^0-9]/', '', $params['price']);
            $filters['min_price'] = $priceValue;
        } else {
            $priceRange = explode(' - ', $params['price']);
            if (count($priceRange) === 2) {
                $filters['min_price'] = (int) preg_replace('/[^0-9]/', '', $priceRange[0]);
                $filters['max_price'] = (int) preg_replace('/[^0-9]/', '', $priceRange[1]);
            }
        }
    }

    // Set limit for search results
    $filters['limit'] = 50;

    // Use existing get_vehicles function
    $result = get_vehicles($filters);
    $vehicles = [];

    if ($result) {
        while ($vehicle = $result->fetch_assoc()) {
            $vehicles[] = $vehicle;
        }
    }

    return $vehicles;
}

// Get parameters
$vehicleId = isset($_GET['vehicle']) ? sanitizeInput($_GET['vehicle']) : null;
$searchParams = [
    'category' => isset($_GET['category']) ? sanitizeInput($_GET['category']) : null,
    'condition' => isset($_GET['condition']) ? sanitizeInput($_GET['condition']) : null,
    'price' => isset($_GET['price']) ? sanitizeInput($_GET['price']) : null,
    'minYear' => isset($_GET['minYear']) ? sanitizeInput($_GET['minYear']) : null,
    'maxYear' => isset($_GET['maxYear']) ? sanitizeInput($_GET['maxYear']) : null,
    'region' => isset($_GET['region']) ? sanitizeInput($_GET['region']) : null,
    'make' => isset($_GET['make']) ? sanitizeInput($_GET['make']) : null,
    'model' => isset($_GET['model']) ? sanitizeInput($_GET['model']) : null,
    'mileage' => isset($_GET['mileage']) ? sanitizeInput($_GET['mileage']) : null,
    'transmission' => isset($_GET['transmission']) ? sanitizeInput($_GET['transmission']) : null,
    'fuelType' => isset($_GET['fuelType']) ? sanitizeInput($_GET['fuelType']) : null,
];

$vehicle = null;
$searchResults = [];
$pageTitle = "Trucks On Sale";
$pageDescription = "Find the best trucks, commercial vehicles, and buses for sale in South Africa";

if ($vehicleId) {
    $vehicle = getVehicleByIdWithImages($vehicleId);
    if ($vehicle) {
        $pageTitle = "{$vehicle['year']} {$vehicle['make']} {$vehicle['model']} - Trucks On Sale";
        $pageDescription = "View this {$vehicle['year']} {$vehicle['make']} {$vehicle['model']} for R" . number_format($vehicle['price']) . " in {$vehicle['city']}, {$vehicle['region']}";
    }
} else {
    $searchResults = searchVehiclesWithFilters($searchParams);
    if (!empty($searchResults)) {
        $pageTitle = "Search Results - " . count($searchResults) . " vehicles found - Trucks On Sale";
        $pageDescription = "Browse " . count($searchResults) . " vehicles matching your search criteria on Trucks On Sale";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($pageTitle); ?></title>
    <meta name="description" content="<?php echo htmlspecialchars($pageDescription); ?>">
    
    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php echo htmlspecialchars($pageTitle); ?>">
    <meta property="og:description" content="<?php echo htmlspecialchars($pageDescription); ?>">
    <meta property="og:type" content="website">
    <meta property="og:url" content="<?php echo htmlspecialchars($_SERVER['REQUEST_URI']); ?>">
    <?php if ($vehicle && !empty($vehicle['images'])): ?>
    <meta property="og:image" content="<?php echo htmlspecialchars($vehicle['images'][0]); ?>">
    <?php else: ?>
    <meta property="og:image" content="https://trucksonsale.co.za/assets/logo.png">
    <?php endif; ?>

    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<?php echo htmlspecialchars($pageTitle); ?>">
    <meta name="twitter:description" content="<?php echo htmlspecialchars($pageDescription); ?>">
    <?php if ($vehicle && !empty($vehicle['images'])): ?>
    <meta name="twitter:image" content="<?php echo htmlspecialchars($vehicle['images'][0]); ?>">
    <?php endif; ?>
    
    <link rel="stylesheet" href="native-styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1><i class="fas fa-truck"></i> Trucks On Sale</h1>
                </div>
                <div class="header-actions">
                    <a href="https://trucksonsale.co.za" class="btn btn-primary">
                        <i class="fas fa-home"></i> Visit Website
                    </a>
                    <a href="#" class="btn btn-secondary" onclick="downloadApp()">
                        <i class="fas fa-mobile-alt"></i> Get App
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="main">
        <div class="container">
            <?php if ($vehicle): ?>
                <!-- Single Vehicle View -->
                <div class="vehicle-detail">
                    <div class="vehicle-header">
                        <h2><?php echo htmlspecialchars("{$vehicle['year']} {$vehicle['make']} {$vehicle['model']}"); ?></h2>
                        <div class="price">R<?php echo number_format($vehicle['price']); ?></div>
                    </div>
                    
                    <?php if (!empty($vehicle['images'])): ?>
                    <div class="vehicle-gallery">
                        <div class="main-image">
                            <img src="<?php echo htmlspecialchars($vehicle['images'][0]); ?>"
                                 alt="<?php echo htmlspecialchars("{$vehicle['year']} {$vehicle['make']} {$vehicle['model']}"); ?>"
                                 id="mainImage">
                        </div>
                        <?php if (count($vehicle['images']) > 1): ?>
                        <div class="image-thumbnails">
                            <?php foreach ($vehicle['images'] as $index => $image): ?>
                            <img src="<?php echo htmlspecialchars($image); ?>"
                                 alt="Image <?php echo $index + 1; ?>"
                                 onclick="changeMainImage('<?php echo htmlspecialchars($image); ?>')"
                                 class="thumbnail <?php echo $index === 0 ? 'active' : ''; ?>">
                            <?php endforeach; ?>
                        </div>
                        <?php endif; ?>
                    </div>
                    <?php endif; ?>
                    
                    <div class="vehicle-info">
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="label">Year:</span>
                                <span class="value"><?php echo htmlspecialchars($vehicle['year']); ?></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Mileage:</span>
                                <span class="value"><?php echo number_format($vehicle['mileage']); ?> km</span>
                            </div>
                            <div class="info-item">
                                <span class="label">Fuel Type:</span>
                                <span class="value"><?php echo htmlspecialchars($vehicle['fuel_type'] ?: 'N/A'); ?></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Transmission:</span>
                                <span class="value"><?php echo htmlspecialchars($vehicle['transmission'] ?: 'N/A'); ?></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Location:</span>
                                <span class="value"><?php echo htmlspecialchars("{$vehicle['city']}, {$vehicle['region']}"); ?></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Condition:</span>
                                <span class="value"><?php echo htmlspecialchars(ucfirst($vehicle['condition_type'])); ?></span>
                            </div>
                        </div>
                        
                        <?php if (!empty($vehicle['description'])): ?>
                        <div class="description">
                            <h3>Description</h3>
                            <p><?php echo nl2br(htmlspecialchars($vehicle['description'])); ?></p>
                        </div>
                        <?php endif; ?>
                        
                        <div class="dealer-info">
                            <h3>Dealer Information</h3>
                            <div class="dealer-details">
                                <p><strong><?php echo htmlspecialchars($vehicle['dealer_name'] ?: 'Trucks On Sale'); ?></strong></p>
                                <?php if ($vehicle['dealer_phone']): ?>
                                <p><i class="fas fa-phone"></i> <?php echo htmlspecialchars($vehicle['dealer_phone']); ?></p>
                                <?php endif; ?>
                                <?php if ($vehicle['dealer_email']): ?>
                                <p><i class="fas fa-envelope"></i> <?php echo htmlspecialchars($vehicle['dealer_email']); ?></p>
                                <?php endif; ?>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <button class="btn btn-primary btn-large" onclick="contactDealer()">
                                <i class="fas fa-phone"></i> Contact Dealer
                            </button>
                            <button class="btn btn-secondary" onclick="shareVehicle()">
                                <i class="fas fa-share"></i> Share
                            </button>
                        </div>
                    </div>
                </div>
            <?php else: ?>
                <!-- Search Results View -->
                <div class="search-results">
                    <div class="results-header">
                        <h2>Search Results</h2>
                        <p><?php echo count($searchResults); ?> vehicles found</p>
                    </div>
                    
                    <?php if (!empty($searchResults)): ?>
                    <div class="vehicles-grid">
                        <?php foreach ($searchResults as $result): ?>
                        <div class="vehicle-card" onclick="viewVehicle(<?php echo $result['vehicle_id']; ?>)">
                            <?php if ($result['primary_image']): ?>
                            <div class="card-image">
                                <img src="<?php echo htmlspecialchars($result['primary_image']); ?>"
                                     alt="<?php echo htmlspecialchars("{$result['year']} {$result['make']} {$result['model']}"); ?>">
                            </div>
                            <?php endif; ?>
                            <div class="card-content">
                                <h3><?php echo htmlspecialchars("{$result['year']} {$result['make']}"); ?></h3>
                                <p class="model"><?php echo htmlspecialchars($result['model']); ?></p>
                                <div class="price">R<?php echo number_format($result['price']); ?></div>
                                <div class="location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <?php echo htmlspecialchars("{$result['city']}, {$result['region']}"); ?>
                                </div>
                                <div class="details">
                                    <span><?php echo number_format($result['mileage']); ?> km</span>
                                    <span><?php echo htmlspecialchars($result['fuel_type'] ?: 'N/A'); ?></span>
                                </div>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>
                    <?php else: ?>
                    <div class="no-results">
                        <i class="fas fa-search"></i>
                        <h3>No vehicles found</h3>
                        <p>Try adjusting your search criteria or browse all vehicles on our main website.</p>
                        <a href="https://trucksonsale.co.za" class="btn btn-primary">Browse All Vehicles</a>
                    </div>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>Trucks On Sale</h4>
                    <p>South Africa's premier platform for buying and selling commercial vehicles.</p>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="https://trucksonsale.co.za">Home</a></li>
                        <li><a href="https://trucksonsale.co.za/trucks">Browse Trucks</a></li>
                        <li><a href="https://trucksonsale.co.za/sell">Sell Your Vehicle</a></li>
                        <li><a href="https://trucksonsale.co.za/contact">Contact Us</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Download Our App</h4>
                    <p>Get the best experience with our mobile app</p>
                    <div class="app-buttons">
                        <button class="btn btn-app" onclick="downloadApp()">
                            <i class="fab fa-android"></i> Android
                        </button>
                        <button class="btn btn-app" onclick="downloadApp()">
                            <i class="fab fa-apple"></i> iOS
                        </button>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Trucks On Sale. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="native-scripts.js"></script>
</body>
</html>
