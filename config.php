<?php
// =============================================
// DATABASE CONFIGURATION AND VEHICLE FUNCTIONS
// =============================================

// Database connection
try {
    $db = new mysqli('localhost', 'truc_brian', 'Brian0776828793', 'truc_tos');
    if ($db->connect_error) {
        throw new Exception("Database connection failed: " . $db->connect_error);
    }
    $db->set_charset("utf8mb4");
} catch (Exception $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Vehicle categories
function get_categories() {
    return [
        'truck' => 'Trucks',
        'car' => 'Cars',
        'suv' => 'SUVs',
        'bakkie' => 'Bakkies',
        'commercial' => 'Commercial Vehicles',
        'machinery' => 'Machinery',
        'trailer' => 'Trailers',
        'bus' => 'Buses',
        'spares' => 'Spares & Parts',
        'farm_equipment' => 'Farm Equipment',
        'animal_farming' => 'Animal Farming',
        'auction' => 'Auctions & Events'
    ];
}

// Get vehicle count by category and region
function get_vehicle_count($category = null, $region = null) {
    global $db;
    
    $query = "SELECT COUNT(*) FROM vehicles WHERE status = 'available'";
    
    if ($category) {
        $query .= " AND category = '" . $db->real_escape_string($category) . "'";
    }
    
    if ($region) {
        $query .= " AND region = '" . $db->real_escape_string($region) . "'";
    }
    
    $result = $db->query($query);
    return $result ? $result->fetch_row()[0] : 0;
}

// Get featured vehicles
function get_featured_vehicles($limit = 6) {
    global $db;
    
    $query = "
        SELECT v.*, u.company_name, u.username,
        (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
        FROM vehicles v
        JOIN users u ON v.dealer_id = u.user_id
        WHERE v.status = 'available' AND v.featured = 1
        ORDER BY v.created_at DESC
        LIMIT " . (int)$limit;
    
    return $db->query($query);
}

// Get all vehicles with filters
function get_vehicles($filters = []) {
    global $db;
    
    $sql = "
        SELECT v.*, u.company_name, u.username,
        (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
        FROM vehicles v
        JOIN users u ON v.dealer_id = u.user_id
        WHERE v.status = 'available'
    ";
    
    $params = [];
    $types = "";
    
    // Apply filters
    if (!empty($filters['category'])) {
        $sql .= " AND v.category = ?";
        $params[] = $filters['category'];
        $types .= "s";
    }
    
    if (!empty($filters['make'])) {
        $sql .= " AND v.make LIKE ?";
        $params[] = "%" . $filters['make'] . "%";
        $types .= "s";
    }
    
    if (!empty($filters['region'])) {
        $sql .= " AND v.region = ?";
        $params[] = $filters['region'];
        $types .= "s";
    }
    
    if (!empty($filters['min_price'])) {
        $sql .= " AND v.price >= ?";
        $params[] = $filters['min_price'];
        $types .= "d";
    }
    
    if (!empty($filters['max_price'])) {
        $sql .= " AND v.price <= ?";
        $params[] = $filters['max_price'];
        $types .= "d";
    }
    
    if (!empty($filters['search'])) {
        $sql .= " AND (v.make LIKE ? OR v.model LIKE ? OR v.description LIKE ?)";
        $searchTerm = "%" . $filters['search'] . "%";
        $params[] = $searchTerm;
        $params[] = $searchTerm;
        $params[] = $searchTerm;
        $types .= "sss";
    }
    
    // Sorting
    $sort = $filters['sort'] ?? 'newest';
    switch ($sort) {
        case 'price_asc':
            $sql .= " ORDER BY v.price ASC";
            break;
        case 'price_desc':
            $sql .= " ORDER BY v.price DESC";
            break;
        case 'year_desc':
            $sql .= " ORDER BY v.year DESC";
            break;
        default:
            $sql .= " ORDER BY v.featured DESC, v.created_at DESC";
            break;
    }
    
    // Pagination
    $page = $filters['page'] ?? 1;
    $limit = $filters['limit'] ?? 12;
    $offset = ($page - 1) * $limit;
    $sql .= " LIMIT $limit OFFSET $offset";
    
    $stmt = $db->prepare($sql);
    
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }
    
    $stmt->execute();
    return $stmt->get_result();
}

// Get vehicle by ID
function get_vehicle_by_id($vehicle_id) {
    global $db;
    
    $stmt = $db->prepare("
        SELECT v.*, u.username, u.company_name, u.phone, u.email 
        FROM vehicles v
        JOIN users u ON v.dealer_id = u.user_id
        WHERE v.vehicle_id = ?
    ");
    
    $stmt->bind_param("i", $vehicle_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

// Get vehicle images
function get_vehicle_images($vehicle_id) {
    global $db;
    
    $stmt = $db->prepare("
        SELECT * FROM vehicle_images 
        WHERE vehicle_id = ? 
        ORDER BY is_primary DESC, uploaded_at ASC
    ");
    
    $stmt->bind_param("i", $vehicle_id);
    $stmt->execute();
    return $stmt->get_result();
}

// Get recent vehicles
function get_recent_vehicles($limit = 6) {
    global $db;
    
    $query = "
        SELECT v.*, u.company_name, u.username,
        (SELECT image_path FROM vehicle_images WHERE vehicle_id = v.vehicle_id AND is_primary = 1 LIMIT 1) as primary_image
        FROM vehicles v
        JOIN users u ON v.dealer_id = u.user_id
        WHERE v.status = 'available'
        ORDER BY v.created_at DESC
        LIMIT " . (int)$limit;
    
    return $db->query($query);
}

// Format price
function format_price($price) {
    return 'R ' . number_format($price, 0);
}

// Get all regions
function get_regions() {
    return [
        'Gauteng',
        'Western Cape',
        'KwaZulu-Natal',
        'Eastern Cape',
        'Free State',
        'Limpopo',
        'Mpumalanga',
        'North West',
        'Northern Cape'
    ];
}

// Search vehicles count
function get_vehicles_count($filters = []) {
    global $db;
    
    $sql = "SELECT COUNT(*) FROM vehicles v WHERE v.status = 'available'";
    $params = [];
    $types = "";
    
    // Apply same filters as get_vehicles but for counting
    if (!empty($filters['category'])) {
        $sql .= " AND v.category = ?";
        $params[] = $filters['category'];
        $types .= "s";
    }
    
    if (!empty($filters['make'])) {
        $sql .= " AND v.make LIKE ?";
        $params[] = "%" . $filters['make'] . "%";
        $types .= "s";
    }
    
    if (!empty($filters['region'])) {
        $sql .= " AND v.region = ?";
        $params[] = $filters['region'];
        $types .= "s";
    }
    
    if (!empty($filters['min_price'])) {
        $sql .= " AND v.price >= ?";
        $params[] = $filters['min_price'];
        $types .= "d";
    }
    
    if (!empty($filters['max_price'])) {
        $sql .= " AND v.price <= ?";
        $params[] = $filters['max_price'];
        $types .= "d";
    }
    
    if (!empty($filters['search'])) {
        $sql .= " AND (v.make LIKE ? OR v.model LIKE ? OR v.description LIKE ?)";
        $searchTerm = "%" . $filters['search'] . "%";
        $params[] = $searchTerm;
        $params[] = $searchTerm;
        $params[] = $searchTerm;
        $types .= "sss";
    }
    
    $stmt = $db->prepare($sql);
    
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }
    
    $stmt->execute();
    return $stmt->get_result()->fetch_row()[0];
}
?>