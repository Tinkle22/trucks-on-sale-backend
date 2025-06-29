<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

require_once 'config/database.php';

// Function to sanitize input
function sanitizeInput($input) {
    return htmlspecialchars(strip_tags($input));
}

// Get search parameters
$category = isset($_GET['category']) ? sanitizeInput($_GET['category']) : null;
$condition = isset($_GET['condition']) ? sanitizeInput($_GET['condition']) : null;
$price = isset($_GET['price']) ? sanitizeInput($_GET['price']) : null;
$year = isset($_GET['year']) ? sanitizeInput($_GET['year']) : null;
$region = isset($_GET['region']) ? sanitizeInput($_GET['region']) : null;
$make = isset($_GET['make']) ? explode(',', sanitizeInput($_GET['make'])) : [];
$model = isset($_GET['model']) ? sanitizeInput($_GET['model']) : null;
$mileage = isset($_GET['mileage']) ? sanitizeInput($_GET['mileage']) : null;
$transmission = isset($_GET['transmission']) ? sanitizeInput($_GET['transmission']) : null;
$fuelType = isset($_GET['fuelType']) ? sanitizeInput($_GET['fuelType']) : null;

try {
    // Build the SQL query
    $sql = "SELECT * FROM vehicles WHERE 1=1";
    $params = [];

    if ($category) {
        $sql .= " AND category = ?";
        $params[] = $category;
    }

    if ($condition) {
        $sql .= " AND condition = ?";
        $params[] = $condition;
    }

    if ($price) {
        if (strpos($price, 'Under') !== false) {
            $priceValue = (int) preg_replace('/[^0-9]/', '', $price);
            $sql .= " AND price <= ?";
            $params[] = $priceValue;
        } elseif (strpos($price, 'Over') !== false) {
            $priceValue = (int) preg_replace('/[^0-9]/', '', $price);
            $sql .= " AND price >= ?";
            $params[] = $priceValue;
        } else {
            $priceRange = explode(' - ', $price);
            if (count($priceRange) === 2) {
                $minPrice = (int) preg_replace('/[^0-9]/', '', $priceRange[0]);
                $maxPrice = (int) preg_replace('/[^0-9]/', '', $priceRange[1]);
                $sql .= " AND price BETWEEN ? AND ?";
                $params[] = $minPrice;
                $params[] = $maxPrice;
            }
        }
    }

    if ($year) {
        $sql .= " AND year = ?";
        $params[] = $year;
    }

    if ($region) {
        $sql .= " AND region = ?";
        $params[] = $region;
    }

    if (!empty($make)) {
        $placeholders = str_repeat('?,', count($make) - 1) . '?';
        $sql .= " AND make IN ($placeholders)";
        $params = array_merge($params, $make);
    }

    if ($model) {
        $sql .= " AND model = ?";
        $params[] = $model;
    }

    if ($mileage) {
        $sql .= " AND mileage <= ?";
        $params[] = $mileage;
    }

    if ($transmission) {
        $sql .= " AND transmission = ?";
        $params[] = $transmission;
    }

    if ($fuelType) {
        $sql .= " AND fuel_type = ?";
        $params[] = $fuelType;
    }

    // Prepare and execute the query
    $stmt = $conn->prepare($sql);
    $stmt->execute($params);
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Format the response
    $response = [
        'status' => 'success',
        'count' => count($results),
        'vehicles' => $results
    ];

    echo json_encode($response);

} catch(PDOException $e) {
    // Handle errors
    $response = [
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage()
    ];
    
    http_response_code(500);
    echo json_encode($response);
}
?> 