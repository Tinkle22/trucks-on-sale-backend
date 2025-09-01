<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Version configuration
$current_version = '1.0.0';
$latest_version = '1.0.1';
$minimum_version = '1.0.0';
$force_update = false;
$download_url = 'https://play.google.com/store/apps/details?id=com.lesa2022.trucks24';
$release_notes = 'Bug fixes and performance improvements. Enhanced vehicle search and improved user experience.';

// Get query parameters
$requested_version = $_GET['current_version'] ?? $current_version;
$platform = $_GET['platform'] ?? 'android';
$app_id = $_GET['app_id'] ?? 'com.lesa2022.trucks24';

// Compare versions
function compareVersions($version1, $version2) {
    return version_compare($version1, $version2);
}

$needs_update = compareVersions($latest_version, $requested_version) > 0;
$force_required = compareVersions($requested_version, $minimum_version) < 0;

// Response data
$response = [
    'success' => true,
    'current_version' => $requested_version,
    'latest_version' => $latest_version,
    'minimum_version' => $minimum_version,
    'needs_update' => $needs_update,
    'force_update' => $force_required || $force_update,
    'download_url' => $download_url,
    'release_notes' => $release_notes,
    'platform' => $platform,
    'app_id' => $app_id
];

echo json_encode($response, JSON_PRETTY_PRINT);
?>