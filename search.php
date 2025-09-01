<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection (same as vehicle.php)
$db = new mysqli('localhost', 'truc_brian24', 'Brian0776828793', 'truc_tos24');
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

// Function to sanitize input
function sanitizeInput($input) {
    return htmlspecialchars(strip_tags($input));
}

// Get search parameters
$category = isset($_GET['category']) ? sanitizeInput($_GET['category']) : '';
$condition = isset($_GET['condition']) ? sanitizeInput($_GET['condition']) : '';
$price_min = isset($_GET['price_min']) ? intval($_GET['price_min']) : '';
$price_max = isset($_GET['price_max']) ? intval($_GET['price_max']) : '';
$year_min = isset($_GET['year_min']) ? intval($_GET['year_min']) : '';
$year_max = isset($_GET['year_max']) ? intval($_GET['year_max']) : '';
$region = isset($_GET['region']) ? sanitizeInput($_GET['region']) : '';
$make = isset($_GET['make']) ? sanitizeInput($_GET['make']) : '';
$model = isset($_GET['model']) ? sanitizeInput($_GET['model']) : '';
$mileage_max = isset($_GET['mileage_max']) ? intval($_GET['mileage_max']) : '';
$transmission = isset($_GET['transmission']) ? sanitizeInput($_GET['transmission']) : '';
$fuel_type = isset($_GET['fuel_type']) ? sanitizeInput($_GET['fuel_type']) : '';
$listing_type = isset($_GET['listing_type']) ? sanitizeInput($_GET['listing_type']) : '';
$no_accidents = isset($_GET['no_accidents']) ? 1 : '';
$warranty = isset($_GET['warranty']) ? 1 : '';
$service_history = isset($_GET['service_history']) ? 1 : '';
$roadworthy = isset($_GET['roadworthy']) ? 1 : '';

// Build the SQL query
$sql = "SELECT v.*, vi.image_path AS main_image FROM vehicles v 
        LEFT JOIN vehicle_images vi ON v.vehicle_id = vi.vehicle_id AND vi.is_primary = 1 
        WHERE 1=1";
$params = [];
$types = '';

if ($category) {
    $sql .= " AND v.category = ?";
    $params[] = $category;
    $types .= 's';
}

if ($condition) {
    $sql .= " AND v.condition_type = ?";
    $params[] = $condition;
    $types .= 's';
}

if ($price_min) {
    $sql .= " AND v.price >= ?";
    $params[] = $price_min;
    $types .= 'i';
}

if ($price_max) {
    $sql .= " AND v.price <= ?";
    $params[] = $price_max;
    $types .= 'i';
}

if ($year_min) {
    $sql .= " AND v.year >= ?";
    $params[] = $year_min;
    $types .= 'i';
}

if ($year_max) {
    $sql .= " AND v.year <= ?";
    $params[] = $year_max;
    $types .= 'i';
}

if ($region) {
    $sql .= " AND v.region = ?";
    $params[] = $region;
    $types .= 's';
}

if ($make) {
    $sql .= " AND v.make = ?";
    $params[] = $make;
    $types .= 's';
}

if ($model) {
    $sql .= " AND v.model LIKE ?";
    $params[] = "%$model%";
    $types .= 's';
}

if ($mileage_max) {
    $sql .= " AND v.mileage <= ?";
    $params[] = $mileage_max;
    $types .= 'i';
}

if ($transmission) {
    $sql .= " AND v.transmission = ?";
    $params[] = $transmission;
    $types .= 's';
}

if ($fuel_type) {
    $sql .= " AND v.fuel_type = ?";
    $params[] = $fuel_type;
    $types .= 's';
}

if ($listing_type) {
    $sql .= " AND v.listing_type = ?";
    $params[] = $listing_type;
    $types .= 's';
}

if ($no_accidents) {
    $sql .= " AND v.no_accidents = 1";
}

if ($warranty) {
    $sql .= " AND v.warranty = 1";
}

if ($service_history) {
    $sql .= " AND v.service_history = 1";
}

if ($roadworthy) {
    $sql .= " AND v.roadworthy = 1";
}

$sql .= " ORDER BY v.created_at DESC";

// Execute query
$vehicles = [];
if (!empty($params)) {
    $stmt = $db->prepare($sql);
    $stmt->bind_param($types, ...$params);
    $stmt->execute();
    $result = $stmt->get_result();
    $vehicles = $result->fetch_all(MYSQLI_ASSOC);
} else {
    $result = $db->query($sql);
    $vehicles = $result->fetch_all(MYSQLI_ASSOC);
}

// Handle AJAX requests for dynamic dropdowns
if (isset($_GET['ajax'])) {
    header('Content-Type: application/json');
    
    if ($_GET['ajax'] === 'makes' && isset($_GET['category'])) {
        $category = sanitizeInput($_GET['category']);
        if ($category) {
            $stmt = $db->prepare("SELECT DISTINCT make FROM vehicles WHERE category = ? AND make IS NOT NULL ORDER BY make");
            $stmt->bind_param('s', $category);
            $stmt->execute();
            $result = $stmt->get_result();
            $makes = $result->fetch_all(MYSQLI_ASSOC);
        } else {
            $makes = $db->query("SELECT DISTINCT make FROM vehicles WHERE make IS NOT NULL ORDER BY make")->fetch_all(MYSQLI_ASSOC);
        }
        echo json_encode($makes);
        exit;
    }
    
    if ($_GET['ajax'] === 'models' && isset($_GET['category']) && isset($_GET['make'])) {
        $category = sanitizeInput($_GET['category']);
        $make = sanitizeInput($_GET['make']);
        $sql = "SELECT DISTINCT model FROM vehicles WHERE model IS NOT NULL";
        $params = [];
        $types = '';
        
        if ($category) {
            $sql .= " AND category = ?";
            $params[] = $category;
            $types .= 's';
        }
        
        if ($make) {
            $sql .= " AND make = ?";
            $params[] = $make;
            $types .= 's';
        }
        
        $sql .= " ORDER BY model";
        
        if (!empty($params)) {
            $stmt = $db->prepare($sql);
            $stmt->bind_param($types, ...$params);
            $stmt->execute();
            $result = $stmt->get_result();
            $models = $result->fetch_all(MYSQLI_ASSOC);
        } else {
            $models = $db->query($sql)->fetch_all(MYSQLI_ASSOC);
        }
        echo json_encode($models);
        exit;
    }
}

// Get filter options for dropdowns
$categories = $db->query("SELECT DISTINCT category FROM vehicles WHERE category IS NOT NULL ORDER BY category")->fetch_all(MYSQLI_ASSOC);

// Get makes based on selected category
if ($category) {
    $stmt = $db->prepare("SELECT DISTINCT make FROM vehicles WHERE category = ? AND make IS NOT NULL ORDER BY make");
    $stmt->bind_param('s', $category);
    $stmt->execute();
    $result = $stmt->get_result();
    $makes = $result->fetch_all(MYSQLI_ASSOC);
} else {
    $makes = $db->query("SELECT DISTINCT make FROM vehicles WHERE make IS NOT NULL ORDER BY make")->fetch_all(MYSQLI_ASSOC);
}

// Get models based on selected category and make
$models = [];
if ($category || $make) {
    $sql = "SELECT DISTINCT model FROM vehicles WHERE model IS NOT NULL";
    $params = [];
    $types = '';
    
    if ($category) {
        $sql .= " AND category = ?";
        $params[] = $category;
        $types .= 's';
    }
    
    if ($make) {
        $sql .= " AND make = ?";
        $params[] = $make;
        $types .= 's';
    }
    
    $sql .= " ORDER BY model";
    
    if (!empty($params)) {
        $stmt = $db->prepare($sql);
        $stmt->bind_param($types, ...$params);
        $stmt->execute();
        $result = $stmt->get_result();
        $models = $result->fetch_all(MYSQLI_ASSOC);
    }
}

$regions = $db->query("SELECT DISTINCT region FROM vehicles WHERE region IS NOT NULL ORDER BY region")->fetch_all(MYSQLI_ASSOC);
$transmissions = $db->query("SELECT DISTINCT transmission FROM vehicles WHERE transmission IS NOT NULL ORDER BY transmission")->fetch_all(MYSQLI_ASSOC);
$fuel_types = $db->query("SELECT DISTINCT fuel_type FROM vehicles WHERE fuel_type IS NOT NULL ORDER BY fuel_type")->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Search - TrucksOnSale</title>
    
    <!-- Open Graph Meta Tags for Social Sharing -->
    <meta property="og:title" content="Vehicle Search - TrucksOnSale">
    <meta property="og:description" content="Find your perfect vehicle with our comprehensive search filters. Browse trucks, cars, and commercial vehicles for sale, hire, or rent-to-own.">
    <meta property="og:image" content="https://trucks24.co.za/assets/logo.jpg">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:url" content="https://trucks24.co.za/search.php">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="TrucksOnSale">
    
    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Vehicle Search - TrucksOnSale">
    <meta name="twitter:description" content="Find your perfect vehicle with our comprehensive search filters. Browse trucks, cars, and commercial vehicles for sale, hire, or rent-to-own.">
    <meta name="twitter:image" content="https://trucks24.co.za/assets/logo.jpg">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --dark-blue: #0d1b2a;
            --red: #e63946;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
        }
        
        body {
            background-color: var(--light-gray);
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .search-header {
            background-color: var(--dark-blue);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .filter-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .vehicle-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }
        
        .vehicle-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .vehicle-image {
            height: 200px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }
        
        .price-badge {
            background-color: var(--red);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .feature-badge {
            background-color: var(--medium-gray);
            color: var(--dark-blue);
            padding: 0.25rem 0.5rem;
            border-radius: 12px;
            font-size: 0.75rem;
            margin-right: 0.25rem;
            margin-bottom: 0.25rem;
            display: inline-block;
        }
        
        .btn-primary {
            background-color: var(--dark-blue);
            border-color: var(--dark-blue);
        }
        
        .btn-danger {
            background-color: var(--red);
            border-color: var(--red);
        }
        
        .form-control:focus {
            border-color: var(--dark-blue);
            box-shadow: 0 0 0 0.2rem rgba(13, 27, 42, 0.25);
        }
        
        .form-select:focus {
            border-color: var(--dark-blue);
            box-shadow: 0 0 0 0.2rem rgba(13, 27, 42, 0.25);
        }
        
        .results-header {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .no-image {
            height: 200px;
            background-color: var(--medium-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dark-gray);
            border-radius: 8px 8px 0 0;
        }
    </style>
</head>
<body>
    <div class="search-header">
        <div class="container">
            <h1 class="mb-0"><i class="bi bi-search"></i> Vehicle Search</h1>
            <p class="mb-0">Find your perfect vehicle with our comprehensive search filters</p>
        </div>
    </div>
    
    <div class="container">
        <!-- Search Filters -->
        <div class="filter-card">
            <h5 class="mb-3"><i class="bi bi-funnel text-danger"></i> Search Filters</h5>
            <form method="GET" action="">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">All Categories</option>
                            <?php foreach ($categories as $cat): ?>
                                <option value="<?= htmlspecialchars($cat['category']) ?>" <?= $category === $cat['category'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($cat['category']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Make</label>
                        <select name="make" class="form-select" id="make">
                            <option value="">All Makes</option>
                            <?php foreach ($makes as $mk): ?>
                                <option value="<?= htmlspecialchars($mk['make']) ?>" <?= $make === $mk['make'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($mk['make']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Model</label>
                        <select name="model" class="form-select" id="model">
                            <option value="">All Models</option>
                            <?php foreach ($models as $model_option): ?>
                                <option value="<?= htmlspecialchars($model_option['model']) ?>" <?= $model === $model_option['model'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($model_option['model']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Condition</label>
                        <select name="condition" class="form-select">
                            <option value="">All Conditions</option>
                            <option value="new" <?= $condition === 'new' ? 'selected' : '' ?>>New</option>
                            <option value="used" <?= $condition === 'used' ? 'selected' : '' ?>>Used</option>
                            <option value="certified" <?= $condition === 'certified' ? 'selected' : '' ?>>Certified</option>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Min Price (R)</label>
                        <input type="number" name="price_min" class="form-control" placeholder="0" value="<?= $price_min ?>">
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Max Price (R)</label>
                        <input type="number" name="price_max" class="form-control" placeholder="No limit" value="<?= $price_max ?>">
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Min Year</label>
                        <input type="number" name="year_min" class="form-control" placeholder="1990" value="<?= $year_min ?>">
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Max Year</label>
                        <input type="number" name="year_max" class="form-control" placeholder="<?= date('Y') ?>" value="<?= $year_max ?>">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Region</label>
                        <select name="region" class="form-select">
                            <option value="">All Regions</option>
                            <?php foreach ($regions as $reg): ?>
                                <option value="<?= htmlspecialchars($reg['region']) ?>" <?= $region === $reg['region'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($reg['region']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Max Mileage (km)</label>
                        <input type="number" name="mileage_max" class="form-control" placeholder="No limit" value="<?= $mileage_max ?>">
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Transmission</label>
                        <select name="transmission" class="form-select">
                            <option value="">All Transmissions</option>
                            <?php foreach ($transmissions as $trans): ?>
                                <option value="<?= htmlspecialchars($trans['transmission']) ?>" <?= $transmission === $trans['transmission'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($trans['transmission']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Fuel Type</label>
                        <select name="fuel_type" class="form-select">
                            <option value="">All Fuel Types</option>
                            <?php foreach ($fuel_types as $fuel): ?>
                                <option value="<?= htmlspecialchars($fuel['fuel_type']) ?>" <?= $fuel_type === $fuel['fuel_type'] ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($fuel['fuel_type']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Listing Type</label>
                        <select name="listing_type" class="form-select">
                            <option value="">All Types</option>
                            <option value="sale" <?= $listing_type === 'sale' ? 'selected' : '' ?>>For Sale</option>
                            <option value="hire" <?= $listing_type === 'hire' ? 'selected' : '' ?>>For Hire</option>
                            <option value="rent_to_own" <?= $listing_type === 'rent_to_own' ? 'selected' : '' ?>>Rent to Own</option>
                        </select>
                    </div>
                    
                    <div class="col-md-9 mb-3">
                        <label class="form-label">Features</label>
                        <div class="d-flex flex-wrap gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="no_accidents" id="no_accidents" <?= $no_accidents ? 'checked' : '' ?>>
                                <label class="form-check-label" for="no_accidents">No Accidents</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="warranty" id="warranty" <?= $warranty ? 'checked' : '' ?>>
                                <label class="form-check-label" for="warranty">Warranty</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="service_history" id="service_history" <?= $service_history ? 'checked' : '' ?>>
                                <label class="form-check-label" for="service_history">Service History</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="roadworthy" id="roadworthy" <?= $roadworthy ? 'checked' : '' ?>>
                                <label class="form-check-label" for="roadworthy">Roadworthy</label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
                    <a href="search.php" class="btn btn-outline-secondary"><i class="bi bi-arrow-clockwise"></i> Clear Filters</a>
                </div>
            </form>
        </div>
        
        <!-- Search Results -->
        <div class="results-header">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="bi bi-list-ul text-danger"></i> Search Results</h5>
                <span class="badge bg-primary"><?= count($vehicles) ?> vehicles found</span>
            </div>
        </div>
        
        <?php if (empty($vehicles)): ?>
            <div class="text-center py-5">
                <i class="bi bi-search display-1 text-muted"></i>
                <h4 class="text-muted mt-3">No vehicles found</h4>
                <p class="text-muted">Try adjusting your search filters to find more results.</p>
            </div>
        <?php else: ?>
            <div class="row">
                <?php foreach ($vehicles as $vehicle): ?>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="vehicle-card" onclick="window.location.href='../share.php?id=<?= $vehicle['vehicle_id'] ?>'">
                            <?php if ($vehicle['main_image']): ?>
                                <img src="../<?= htmlspecialchars($vehicle['main_image']) ?>" class="vehicle-image w-100" alt="Vehicle image">
                            <?php else: ?>
                                <div class="no-image">
                                    <i class="bi bi-image display-4"></i>
                                </div>
                            <?php endif; ?>
                            
                            <div class="p-3">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h6 class="mb-0"><?= htmlspecialchars("{$vehicle['year']} {$vehicle['make']} {$vehicle['model']}") ?></h6>
                                    <span class="price-badge">R<?= number_format($vehicle['price']) ?></span>
                                </div>
                                
                                <div class="mb-2">
                                    <small class="text-muted">
                                        <i class="bi bi-geo-alt"></i> <?= htmlspecialchars($vehicle['region'] ?? 'N/A') ?>
                                        <span class="mx-2">•</span>
                                        <i class="bi bi-speedometer2"></i> <?= number_format($vehicle['mileage']) ?> km
                                    </small>
                                </div>
                                
                                <div class="mb-2">
                                    <?php if ($vehicle['no_accidents']): ?>
                                        <span class="feature-badge">No Accidents</span>
                                    <?php endif; ?>
                                    <?php if ($vehicle['warranty']): ?>
                                        <span class="feature-badge">Warranty</span>
                                    <?php endif; ?>
                                    <?php if ($vehicle['service_history']): ?>
                                        <span class="feature-badge">Service History</span>
                                    <?php endif; ?>
                                    <?php if ($vehicle['roadworthy']): ?>
                                        <span class="feature-badge">Roadworthy</span>
                                    <?php endif; ?>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <?= htmlspecialchars($vehicle['transmission'] ?? 'N/A') ?> • 
                                        <?= htmlspecialchars($vehicle['fuel_type'] ?? 'N/A') ?>
                                    </small>
                                    <span class="badge bg-secondary"><?= ucfirst($vehicle['listing_type']) ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const categorySelect = document.querySelector('select[name="category"]');
        const makeSelect = document.getElementById('make');
        const modelSelect = document.getElementById('model');
        
        // Update makes when category changes
        categorySelect.addEventListener('change', function() {
            const category = this.value;
            
            // Clear and disable model select
            modelSelect.innerHTML = '<option value="">All Models</option>';
            
            // Fetch makes for selected category
            fetch(`search.php?ajax=makes&category=${encodeURIComponent(category)}`)
                .then(response => response.json())
                .then(makes => {
                    makeSelect.innerHTML = '<option value="">All Makes</option>';
                    makes.forEach(make => {
                        const option = document.createElement('option');
                        option.value = make.make;
                        option.textContent = make.make;
                        makeSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching makes:', error));
        });
        
        // Update models when make changes
        makeSelect.addEventListener('change', function() {
            const category = categorySelect.value;
            const make = this.value;
            
            // Fetch models for selected category and make
            fetch(`search.php?ajax=models&category=${encodeURIComponent(category)}&make=${encodeURIComponent(make)}`)
                .then(response => response.json())
                .then(models => {
                    modelSelect.innerHTML = '<option value="">All Models</option>';
                    models.forEach(model => {
                        const option = document.createElement('option');
                        option.value = model.model;
                        option.textContent = model.model;
                        modelSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching models:', error));
        });
    });
    </script>
</body>
</html>
<?php $db->close(); ?>