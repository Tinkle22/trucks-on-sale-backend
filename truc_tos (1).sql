-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 02, 2025 at 07:02 AM
-- Server version: 10.3.39-MariaDB-0ubuntu0.20.04.2
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `truc_tos24`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_log`
--

CREATE TABLE `admin_activity_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `admin_activity_log`
--

INSERT INTO `admin_activity_log` (`id`, `admin_id`, `action`, `target_type`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-09 04:38:57'),
(2, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-09 04:47:28'),
(3, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-09 04:52:57'),
(4, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.99', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-09 04:58:46'),
(5, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '2025-07-09 11:46:03'),
(6, 1, 'SET_PREMIUM', 'vehicle', 3, 'Updated premium status', '45.215.253.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-09 11:49:32'),
(7, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '2025-07-09 11:57:23'),
(8, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '2025-07-09 11:58:41'),
(9, 1, 'APPROVE_DEALER', 'dealer', 9, 'Approved dealer registration', '45.215.253.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '2025-07-09 11:59:42'),
(10, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.212', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-13 09:13:45'),
(11, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.212', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-13 09:16:13'),
(12, 1, 'SET_FEATURED', 'vehicle', 13, 'Updated featured status', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:18:18'),
(13, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 4, 'Updated limits for dealer ID: 4', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:26:02'),
(14, 1, 'APPROVE_DEALER', 'dealer', 10, 'Approved dealer registration', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:30:01'),
(15, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 10, 'Updated limits for dealer ID: 10', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:31:23'),
(16, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 10, 'Updated limits for dealer ID: 10', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:31:43'),
(17, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 2, 'Updated limits for dealer ID: 2', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:32:03'),
(18, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 10, 'Updated limits for dealer ID: 10', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:32:33'),
(19, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:33:02'),
(20, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:38:03'),
(21, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:45:24'),
(22, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:55:47'),
(23, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:56:09'),
(24, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:56:34'),
(25, 1, 'UPDATE_SETTINGS', 'system', NULL, 'Updated system settings', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:56:43'),
(26, 1, 'DELETE_AD', 'premium_ads', 2, 'Deleted premium ad', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 00:57:20'),
(27, 1, 'CREATE_AD', 'premium_ads', 3, 'Created premium ad: uhu', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 01:04:52'),
(28, 1, 'DELETE_AD', 'premium_ads', 1, 'Deleted premium ad', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 01:05:42'),
(29, 1, 'DELETE_AD', 'premium_ads', 1, 'Deleted premium ad', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 01:13:27'),
(30, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 01:36:16'),
(31, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 2, 'Updated limits for dealer ID: 2', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 01:45:44'),
(32, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 01:47:48'),
(33, 1, 'CREATE_AD', 'premium_ads', 4, 'Created premium ad: Ghh', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 01:55:56'),
(34, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 01:58:53'),
(35, 1, 'DELETE_AD', 'premium_ads', 0, 'Deleted premium ad', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 02:04:56'),
(36, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 02:08:03'),
(37, 1, 'CREATE_AD', 'premium_ads', 5, 'Created premium ad: gh', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 02:09:55'),
(38, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 02:12:44'),
(39, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 02:13:48'),
(40, 1, 'DELETE_AD', 'premium_ads', 0, 'Deleted premium ad', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 02:17:23'),
(41, 1, 'CREATE_AD', 'premium_ads', 6, 'Created premium ad: hjbjj', '45.215.253.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 02:18:08'),
(42, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 02:29:58'),
(43, 1, 'CREATE_AD', 'premium_ads', 7, 'Created premium ad: gh', '45.215.253.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-14 02:36:49'),
(44, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 08:26:53'),
(45, 1, 'CREATE_AD', 'premium_ads', 8, 'Created premium ad: swsws', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 08:57:25'),
(46, 1, 'CREATE_AD', 'premium_ads', 1, 'Created premium ad: hjbj', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:09:20'),
(47, 1, 'APPROVE_DEALER', 'dealer', 11, 'Approved dealer registration', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:24:37'),
(48, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:24:42'),
(49, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:26:50'),
(50, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:26:59'),
(51, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 11, 'Updated limits for dealer ID: 11', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:27:58'),
(52, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 11, 'Updated limits for dealer ID: 11', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:28:10'),
(53, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 11, 'Updated limits for dealer ID: 11', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:28:19'),
(54, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:28:23'),
(55, 1, 'DELETE_AD', 'premium_ads', 1, 'Deleted premium ad', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:31:41'),
(56, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-14 09:38:10'),
(57, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '197.212.43.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-01 15:48:09'),
(58, 1, 'APPROVE_DEALER', 'dealer', 15, 'Approved dealer registration', '197.212.43.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-01 15:50:01'),
(59, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '197.212.43.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-01 15:50:05'),
(60, 1, 'CREATE_AD', 'premium_ads', 9, 'Created premium ad: pickandpay', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 06:52:27'),
(61, 1, 'DELETE_AD', 'premium_ads', 3, 'Deleted premium ad', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 06:57:38'),
(62, 1, 'CREATE_AD', 'premium_ads', 10, 'Created premium ad: ad2', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 06:59:18'),
(63, 1, 'DELETE_AD', 'premium_ads', 5, 'Deleted premium ad', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 06:59:27'),
(64, 1, 'DELETE_AD', 'premium_ads', 10, 'Deleted premium ad', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 07:00:56'),
(65, 1, 'CREATE_AD', 'premium_ads', 11, 'Created premium ad: pizza', '102.212.181.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-02 07:02:01');

-- --------------------------------------------------------

--
-- Table structure for table `auction_bids`
--

CREATE TABLE `auction_bids` (
  `bid_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `bidder_name` varchar(100) NOT NULL,
  `bidder_email` varchar(100) NOT NULL,
  `bidder_phone` varchar(15) NOT NULL,
  `bid_amount` decimal(12,2) NOT NULL,
  `bid_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','outbid','winning','withdrawn') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auction_bids`
--

INSERT INTO `auction_bids` (`bid_id`, `vehicle_id`, `bidder_name`, `bidder_email`, `bidder_phone`, `bid_amount`, `bid_time`, `status`) VALUES
(5, 29, 'Mutale', 'mutalemattlesa@gmail.com', '770967132', 821000.00, '2025-09-01 16:24:49', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_key` varchar(50) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `parent_category` varchar(50) DEFAULT NULL,
  `listing_type` enum('sale','rent-to-own','hire','auction') DEFAULT 'sale',
  `icon` varchar(100) NOT NULL DEFAULT 'fas fa-tag',
  `listing_label` varchar(100) NOT NULL,
  `mileage_label` varchar(50) DEFAULT 'Mileage (KM)',
  `engine_label` varchar(50) DEFAULT 'Engine Type',
  `show_transmission` tinyint(1) DEFAULT 1,
  `show_fuel_type` tinyint(1) DEFAULT 1,
  `show_year` tinyint(1) DEFAULT 1,
  `show_hours` tinyint(1) DEFAULT 0,
  `transmission_options` text DEFAULT NULL,
  `fuel_options` text DEFAULT NULL,
  `additional_fields` text DEFAULT NULL,
  `category_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_premium` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_key`, `category_name`, `parent_category`, `listing_type`, `icon`, `listing_label`, `mileage_label`, `engine_label`, `show_transmission`, `show_fuel_type`, `show_year`, `show_hours`, `transmission_options`, `fuel_options`, `additional_fields`, `category_order`, `status`, `created_at`, `updated_at`, `is_premium`) VALUES
(1, 'trucks', 'Trucks', NULL, 'sale', 'fas fa-truck', 'List Your Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 1, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(2, 'trailers', 'Trailers', NULL, 'sale', 'fas fa-trailer', 'List Your Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 2, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(3, 'buses', 'Buses', NULL, 'sale', 'fas fa-bus', 'List Your Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 3, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(4, 'commercial_vehicles', 'Commercial Vehicles', NULL, 'sale', 'fas fa-van-shuttle', 'List Your Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 4, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(5, 'farm_equipment', 'Farm Equipment', NULL, 'sale', 'fas fa-tractor', 'List Your Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 5, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(6, 'heavy_machinery', 'Heavy Machinery', NULL, 'sale', 'fas fa-cogs', 'List Your Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 6, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(7, 'animal_farming_equipment', 'Animal Farming Equipment', NULL, 'sale', 'fas fa-cow', 'List Your Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 7, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(8, 'rent-to-own_trucks', 'Trucks (Rent To Own)', NULL, 'rent-to-own', 'fas fa-truck', 'Rent To Own: Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 8, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(9, 'rent-to-own_trailers', 'Trailers (Rent To Own)', NULL, 'rent-to-own', 'fas fa-trailer', 'Rent To Own: Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 9, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(10, 'rent-to-own_buses', 'Buses (Rent To Own)', NULL, 'rent-to-own', 'fas fa-bus', 'Rent To Own: Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 10, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(11, 'rent-to-own_commercial_vehicles', 'Commercial Vehicles (Rent To Own)', NULL, 'rent-to-own', 'fas fa-van-shuttle', 'Rent To Own: Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 11, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(12, 'rent-to-own_farm_equipment', 'Farm Equipment (Rent To Own)', NULL, 'rent-to-own', 'fas fa-tractor', 'Rent To Own: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 12, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(13, 'rent-to-own_heavy_machinery', 'Heavy Machinery (Rent To Own)', NULL, 'rent-to-own', 'fas fa-cogs', 'Rent To Own: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 13, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(14, 'rent-to-own_animal_farming_equipment', 'Animal Farming Equipment (Rent To Own)', NULL, 'rent-to-own', 'fas fa-cow', 'Rent To Own: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 14, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(15, 'hire_trucks', 'Trucks (Hire)', NULL, 'hire', 'fas fa-truck', 'Hire: Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 15, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(16, 'hire_trailers', 'Trailers (Hire)', NULL, 'hire', 'fas fa-trailer', 'Hire: Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 16, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(17, 'hire_buses', 'Buses (Hire)', NULL, 'hire', 'fas fa-bus', 'Hire: Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 17, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(18, 'hire_commercial_vehicles', 'Commercial Vehicles (Hire)', NULL, 'hire', 'fas fa-van-shuttle', 'Hire: Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 18, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(19, 'hire_farm_equipment', 'Farm Equipment (Hire)', NULL, 'hire', 'fas fa-tractor', 'Hire: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 19, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(20, 'hire_heavy_machinery', 'Heavy Machinery (Hire)', NULL, 'hire', 'fas fa-cogs', 'Hire: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 20, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(21, 'hire_animal_farming_equipment', 'Animal Farming Equipment (Hire)', NULL, 'hire', 'fas fa-cow', 'Hire: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 21, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(26, 'auction_farm_equipment', 'Farm Equipment (Auction)', NULL, 'auction', 'fas fa-tractor', 'Auction: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 26, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(27, 'auction_heavy_machinery', 'Heavy Machinery (Auction)', NULL, 'auction', 'fas fa-cogs', 'Auction: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 27, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(28, 'auction_animal_farming_equipment', 'Animal Farming Equipment (Auction)', NULL, 'auction', 'fas fa-cow', 'Auction: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 28, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(29, 'premium-ads', 'Premium Ads', NULL, 'sale', 'fas fa-tag', '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1),
(30, 'banner-ads', 'Banner Ads', NULL, 'sale', 'fas fa-tag', '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1),
(31, 'box-ads', 'Box Ads', NULL, 'sale', 'fas fa-tag', '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1),
(32, 'animal_farming', 'Animal Farming', NULL, 'sale', 'fas fa-paw', 'List Your Livestock', 'Age (Years)', 'Breed', 0, 0, 1, 0, NULL, NULL, NULL, 32, 'active', '2025-08-29 12:00:00', '2025-08-29 12:00:00', 0),
(33, 'rent-to-own_animal_farming', 'Animal Farming (Rent To Own)', NULL, 'rent-to-own', 'fas fa-paw', 'Rent To Own: Livestock', 'Age (Years)', 'Breed', 0, 0, 1, 0, NULL, NULL, NULL, 33, 'active', '2025-08-29 12:00:00', '2025-08-29 12:00:00', 0),
(34, 'hire_animal_farming', 'Animal Farming (Hire)', NULL, 'hire', 'fas fa-paw', 'Hire: Livestock', 'Age (Years)', 'Breed', 0, 0, 1, 0, NULL, NULL, NULL, 34, 'active', '2025-08-29 12:00:00', '2025-08-29 12:00:00', 0),
(35, 'auction_animal_farming', 'Animal Farming (Auction)', NULL, 'auction', 'fas fa-paw', 'Auction: Livestock', 'Age (Years)', 'Breed', 0, 0, 1, 0, NULL, NULL, NULL, 35, 'active', '2025-08-29 12:00:00', '2025-08-29 12:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `category_makes`
--

CREATE TABLE `category_makes` (
  `make_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `make_name` varchar(100) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_makes`
--

INSERT INTO `category_makes` (`make_id`, `category_id`, `make_name`, `status`, `created_at`) VALUES
(1, 1, 'Mercedes Benz', 'active', '2025-07-07 03:09:28'),
(2, 1, 'Volvo', 'active', '2025-07-07 03:09:28'),
(3, 1, 'Scania', 'active', '2025-07-07 03:09:28'),
(4, 1, 'MAN', 'active', '2025-07-07 03:09:28'),
(5, 1, 'DAF', 'active', '2025-07-07 03:09:28'),
(6, 1, 'Isuzu', 'active', '2025-07-07 03:09:28'),
(7, 1, 'Iveco', 'active', '2025-07-07 03:09:28'),
(8, 2, 'Afrit', 'active', '2025-07-07 03:09:28'),
(9, 2, 'SA Truck Bodies', 'active', '2025-07-07 03:09:28'),
(10, 2, 'Henred', 'active', '2025-07-07 03:09:28'),
(11, 3, 'Mercedes Benz', 'active', '2025-07-07 03:09:28'),
(12, 3, 'Iveco', 'active', '2025-07-07 03:09:28'),
(13, 3, 'Volkswagen', 'active', '2025-07-07 03:09:28'),
(14, 4, 'Brand A', 'active', '2025-07-07 03:09:28'),
(15, 4, 'Brand B', 'active', '2025-07-07 03:09:28'),
(16, 5, 'John Deere', 'active', '2025-07-07 03:09:28'),
(17, 5, 'Case IH', 'active', '2025-07-07 03:09:28'),
(18, 5, 'New Holland', 'active', '2025-07-07 03:09:28'),
(19, 6, 'Caterpillar', 'active', '2025-07-07 03:09:28'),
(20, 6, 'Komatsu', 'active', '2025-07-07 03:09:28'),
(21, 6, 'JCB', 'active', '2025-07-07 03:09:28'),
(22, 7, 'Brand A', 'active', '2025-07-07 03:09:28'),
(23, 7, 'Brand B', 'active', '2025-07-07 03:09:28'),
(24, 4, 'Toyota', 'active', '2025-07-07 05:54:13'),
(25, 3, 'Scania', 'active', '2025-07-07 05:55:24'),
(26, 1, 'Benz', 'active', '2025-07-07 05:57:27'),
(27, 2, 'double pick', 'active', '2025-07-07 07:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `category_models`
--

CREATE TABLE `category_models` (
  `model_id` int(11) NOT NULL,
  `make_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_models`
--

INSERT INTO `category_models` (`model_id`, `make_id`, `model_name`, `status`, `created_at`) VALUES
(1, 1, 'Actros', 'active', '2025-07-07 03:09:28'),
(2, 1, 'Atego', 'active', '2025-07-07 03:09:28'),
(3, 1, 'Axor', 'active', '2025-07-07 03:09:28'),
(4, 1, 'Antos', 'active', '2025-07-07 03:09:28'),
(5, 1, 'Arocs', 'active', '2025-07-07 03:09:28'),
(6, 2, 'FH', 'active', '2025-07-07 03:09:28'),
(7, 2, 'FM', 'active', '2025-07-07 03:09:28'),
(8, 2, 'FE', 'active', '2025-07-07 03:09:28'),
(9, 2, 'FL', 'active', '2025-07-07 03:09:28'),
(10, 2, 'VNL', 'active', '2025-07-07 03:09:28'),
(11, 3, 'R Series', 'active', '2025-07-07 03:09:28'),
(12, 3, 'S Series', 'active', '2025-07-07 03:09:28'),
(13, 3, 'P Series', 'active', '2025-07-07 03:09:28'),
(14, 3, 'G Series', 'active', '2025-07-07 03:09:28'),
(15, 4, 'TGX', 'active', '2025-07-07 03:09:28'),
(16, 4, 'TGS', 'active', '2025-07-07 03:09:28'),
(17, 4, 'TGM', 'active', '2025-07-07 03:09:28'),
(18, 4, 'TGL', 'active', '2025-07-07 03:09:28'),
(19, 5, 'XF', 'active', '2025-07-07 03:09:28'),
(20, 5, 'CF', 'active', '2025-07-07 03:09:28'),
(21, 5, 'LF', 'active', '2025-07-07 03:09:28'),
(22, 5, 'XG', 'active', '2025-07-07 03:09:28'),
(23, 6, 'NPR', 'active', '2025-07-07 03:09:28'),
(24, 6, 'NQR', 'active', '2025-07-07 03:09:28'),
(25, 6, 'FTR', 'active', '2025-07-07 03:09:28'),
(26, 6, 'FVR', 'active', '2025-07-07 03:09:28'),
(27, 6, 'GXR', 'active', '2025-07-07 03:09:28'),
(28, 7, 'Stralis', 'active', '2025-07-07 03:09:28'),
(29, 7, 'Trakker', 'active', '2025-07-07 03:09:28'),
(30, 7, 'Eurocargo', 'active', '2025-07-07 03:09:28'),
(31, 7, 'Daily', 'active', '2025-07-07 03:09:28'),
(32, 8, 'Side Tipper', 'active', '2025-07-07 03:09:28'),
(33, 8, 'Tri-Axle', 'active', '2025-07-07 03:09:28'),
(34, 8, 'Interlink', 'active', '2025-07-07 03:09:28'),
(35, 9, 'Flatdeck', 'active', '2025-07-07 03:09:28'),
(36, 9, 'Curtain Side', 'active', '2025-07-07 03:09:28'),
(37, 9, 'Dropside', 'active', '2025-07-07 03:09:28'),
(38, 10, 'Fruehauf', 'active', '2025-07-07 03:09:28'),
(39, 10, 'Goliath', 'active', '2025-07-07 03:09:28'),
(40, 10, 'Maxitrans', 'active', '2025-07-07 03:09:28'),
(41, 11, 'Sprinter', 'active', '2025-07-07 03:09:28'),
(42, 11, 'Vario', 'active', '2025-07-07 03:09:28'),
(43, 11, 'Marco Polo', 'active', '2025-07-07 03:09:28'),
(44, 12, 'Daily Minibus', 'active', '2025-07-07 03:09:28'),
(45, 12, 'Crossway', 'active', '2025-07-07 03:09:28'),
(46, 12, 'Evadys', 'active', '2025-07-07 03:09:28'),
(47, 13, 'Crafter', 'active', '2025-07-07 03:09:28'),
(48, 13, 'Amarok', 'active', '2025-07-07 03:09:28'),
(49, 14, 'Model 1', 'active', '2025-07-07 03:09:28'),
(50, 14, 'Model 2', 'active', '2025-07-07 03:09:28'),
(51, 14, 'Model 3', 'active', '2025-07-07 03:09:28'),
(52, 15, 'Model X', 'active', '2025-07-07 03:09:28'),
(53, 15, 'Model Y', 'active', '2025-07-07 03:09:28'),
(54, 15, 'Model Z', 'active', '2025-07-07 03:09:28'),
(55, 16, '6R Series', 'active', '2025-07-07 03:09:28'),
(56, 16, '7R Series', 'active', '2025-07-07 03:09:28'),
(57, 16, '8R Series', 'active', '2025-07-07 03:09:28'),
(58, 17, 'Magnum', 'active', '2025-07-07 03:09:28'),
(59, 17, 'Puma', 'active', '2025-07-07 03:09:28'),
(60, 17, 'Maxxum', 'active', '2025-07-07 03:09:28'),
(61, 18, 'T6', 'active', '2025-07-07 03:09:28'),
(62, 18, 'T7', 'active', '2025-07-07 03:09:28'),
(63, 18, 'T8', 'active', '2025-07-07 03:09:28'),
(64, 19, '320D', 'active', '2025-07-07 03:09:28'),
(65, 19, '330D', 'active', '2025-07-07 03:09:28'),
(66, 19, '336D', 'active', '2025-07-07 03:09:28'),
(67, 20, 'PC200', 'active', '2025-07-07 03:09:28'),
(68, 20, 'PC300', 'active', '2025-07-07 03:09:28'),
(69, 20, 'PC400', 'active', '2025-07-07 03:09:28'),
(70, 21, '3CX', 'active', '2025-07-07 03:09:28'),
(71, 21, '4CX', 'active', '2025-07-07 03:09:28'),
(72, 21, 'JS130', 'active', '2025-07-07 03:09:28'),
(73, 22, 'Model 1', 'active', '2025-07-07 03:09:28'),
(74, 22, 'Model 2', 'active', '2025-07-07 03:09:28'),
(75, 22, 'Model 3', 'active', '2025-07-07 03:09:28'),
(76, 23, 'Model X', 'active', '2025-07-07 03:09:28'),
(77, 23, 'Model Y', 'active', '2025-07-07 03:09:28'),
(78, 23, 'Model Z', 'active', '2025-07-07 03:09:28'),
(79, 24, 'Hulix', 'active', '2025-07-07 05:54:25'),
(80, 25, 'Macopolo', 'active', '2025-07-07 05:55:37'),
(81, 24, 'Landcruseir', 'active', '2025-07-07 05:56:26'),
(82, 25, 'wawa', 'active', '2025-07-07 05:56:48'),
(83, 8, 'others', 'active', '2025-07-07 05:57:08'),
(84, 26, 'XCN 3000', 'active', '2025-07-07 05:57:45');

-- --------------------------------------------------------

--
-- Table structure for table `category_variants`
--

CREATE TABLE `category_variants` (
  `variant_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `variant_name` varchar(100) NOT NULL,
  `variant_description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_variants`
--

INSERT INTO `category_variants` (`variant_id`, `model_id`, `variant_name`, `variant_description`, `status`, `created_at`) VALUES
(1, 1, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(2, 1, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(3, 1, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(4, 6, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(5, 6, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(6, 6, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(7, 11, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(8, 11, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(9, 11, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(10, 15, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(11, 15, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(12, 15, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(13, 19, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(14, 19, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(15, 19, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(16, 23, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(17, 23, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(18, 23, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(19, 28, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(20, 28, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(21, 28, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(22, 32, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(23, 32, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(24, 32, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(25, 35, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(26, 35, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(27, 35, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(28, 38, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(29, 38, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(30, 38, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(31, 41, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(32, 41, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(33, 41, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(34, 44, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(35, 44, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(36, 44, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(37, 47, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(38, 47, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(39, 47, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(40, 49, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(41, 49, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(42, 49, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(43, 52, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(44, 52, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(45, 52, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(46, 55, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(47, 55, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(48, 55, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(49, 58, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(50, 58, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(51, 58, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(52, 61, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(53, 61, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(54, 61, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(55, 64, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(56, 64, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(57, 64, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(58, 67, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(59, 67, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(60, 67, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(61, 70, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(62, 70, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(63, 70, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(64, 73, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(65, 73, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(66, 73, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(67, 76, 'Standard', NULL, 'active', '2025-07-07 03:09:28'),
(68, 76, 'Premium', NULL, 'active', '2025-07-07 03:09:28'),
(69, 76, 'Deluxe', NULL, 'active', '2025-07-07 03:09:28'),
(70, 79, 'legend 50', 'very powerful', 'active', '2025-07-07 05:54:57');

-- --------------------------------------------------------

--
-- Table structure for table `comparison_analytics`
--

CREATE TABLE `comparison_analytics` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `comparison_count` int(11) DEFAULT 0,
  `last_compared` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comparison_analytics`
--

INSERT INTO `comparison_analytics` (`id`, `vehicle_id`, `comparison_count`, `last_compared`) VALUES
(1, 21, 2, '2025-09-01 16:24:39'),
(2, 30, 1, '2025-09-01 14:48:30');

-- --------------------------------------------------------

--
-- Table structure for table `dealership_limits`
--

CREATE TABLE `dealership_limits` (
  `id` int(11) NOT NULL,
  `dealership_id` int(11) NOT NULL,
  `featured_limit` int(11) DEFAULT 2,
  `current_featured_count` int(11) DEFAULT 0,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `premium_limit` int(11) DEFAULT 1,
  `current_premium_count` int(11) DEFAULT 0,
  `listing_limit` int(11) DEFAULT 50,
  `current_listing_count` int(11) DEFAULT 0,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `dealership_limits`
--

INSERT INTO `dealership_limits` (`id`, `dealership_id`, `featured_limit`, `current_featured_count`, `updated_by`, `updated_at`, `premium_limit`, `current_premium_count`, `listing_limit`, `current_listing_count`, `notes`) VALUES
(1, 8, 2, 0, NULL, '2025-07-09 03:29:20', 1, 0, 50, 0, NULL),
(2, 2, 2, 2, 1, '2025-07-14 01:45:44', 3, 0, 10, 5, 'h'),
(9, 4, 5, 0, 1, '2025-07-14 00:26:02', 1, 0, 50, 0, 'dc'),
(10, 5, 2, 0, NULL, '2025-07-09 11:46:21', 1, 0, 50, 0, NULL),
(11, 6, 2, 0, NULL, '2025-07-09 11:46:21', 1, 0, 50, 1, NULL),
(14, 3, 2, 0, NULL, '2025-09-01 16:44:39', 1, 1, 50, 14, NULL),
(27, 9, 2, 0, 1, '2025-07-09 11:59:42', 1, 0, 50, 0, NULL),
(58, 10, 25, 0, 1, '2025-07-14 00:32:33', 1, 0, -1, 0, 'hh'),
(125, 11, 0, 0, 1, '2025-07-14 09:28:19', 0, 0, 10, 0, ''),
(177, 15, 2, 0, 1, '2025-09-01 15:51:15', 1, 0, 50, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dealer_ad_analytics`
--

CREATE TABLE `dealer_ad_analytics` (
  `id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `impressions` int(11) DEFAULT 0,
  `clicks` int(11) DEFAULT 0,
  `unique_visitors` int(11) DEFAULT 0,
  `ctr` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealer_ad_limits`
--

CREATE TABLE `dealer_ad_limits` (
  `id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `banner_ads_limit` int(11) DEFAULT 2,
  `box_ads_limit` int(11) DEFAULT 5,
  `monthly_budget` decimal(10,2) DEFAULT 1000.00,
  `auto_approve` tinyint(1) DEFAULT 0,
  `can_upload_banners` tinyint(1) DEFAULT 1,
  `can_upload_box_ads` tinyint(1) DEFAULT 1,
  `priority_level` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `dealer_ad_limits`
--

INSERT INTO `dealer_ad_limits` (`id`, `dealer_id`, `banner_ads_limit`, `box_ads_limit`, `monthly_budget`, `auto_approve`, `can_upload_banners`, `can_upload_box_ads`, `priority_level`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, 15, 2, 5, 1000.00, 0, 1, 1, 1, '2025-09-01 15:51:21', '2025-09-01 15:51:21', NULL),
(2, 3, 2, 5, 1000.00, 0, 1, 1, 1, '2025-09-01 16:40:20', '2025-09-01 16:40:20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dealer_branches`
--

CREATE TABLE `dealer_branches` (
  `branch_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(50) NOT NULL,
  `region` varchar(50) NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `is_main_branch` tinyint(1) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealer_finance_options`
--

CREATE TABLE `dealer_finance_options` (
  `option_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `option_name` varchar(100) NOT NULL,
  `min_loan_amount` decimal(12,2) NOT NULL,
  `max_loan_amount` decimal(12,2) NOT NULL,
  `min_term_months` int(11) NOT NULL,
  `max_term_months` int(11) NOT NULL,
  `base_interest_rate` decimal(5,2) NOT NULL,
  `processing_fee` decimal(8,2) DEFAULT 0.00,
  `admin_fee` decimal(8,2) DEFAULT 0.00,
  `insurance_required` tinyint(1) DEFAULT 0,
  `min_deposit_percentage` decimal(5,2) DEFAULT 10.00,
  `max_deposit_percentage` decimal(5,2) DEFAULT 50.00,
  `credit_score_requirement` int(11) DEFAULT 600,
  `employment_requirement` enum('any','employed_only','permanent_only') DEFAULT 'any',
  `min_income_requirement` decimal(10,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `terms_conditions` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `dealer_finance_options`
--

INSERT INTO `dealer_finance_options` (`option_id`, `dealer_id`, `option_name`, `min_loan_amount`, `max_loan_amount`, `min_term_months`, `max_term_months`, `base_interest_rate`, `processing_fee`, `admin_fee`, `insurance_required`, `min_deposit_percentage`, `max_deposit_percentage`, `credit_score_requirement`, `employment_requirement`, `min_income_requirement`, `description`, `terms_conditions`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Standard Finance Package', 50000.00, 2000000.00, 12, 72, 12.50, 2500.00, 1500.00, 0, 10.00, 50.00, 600, 'any', 0.00, 'Our standard finance package with competitive rates', NULL, 1, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(2, 1, 'Premium Finance Package', 100000.00, 5000000.00, 24, 84, 11.75, 3500.00, 2000.00, 0, 15.00, 50.00, 600, 'any', 0.00, 'Premium finance option with lower rates for qualified buyers', NULL, 1, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(3, 1, 'Commercial Finance', 200000.00, 10000000.00, 36, 96, 13.25, 5000.00, 3000.00, 0, 20.00, 50.00, 600, 'any', 0.00, 'Specialized financing for commercial vehicles', NULL, 1, '2025-09-01 12:37:11', '2025-09-01 12:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `dealer_sales_team`
--

CREATE TABLE `dealer_sales_team` (
  `team_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `whatsapp` varchar(15) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `tiktok_url` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dealer_sales_team`
--

INSERT INTO `dealer_sales_team` (`team_id`, `dealer_id`, `name`, `position`, `phone`, `email`, `whatsapp`, `photo`, `facebook_url`, `twitter_url`, `instagram_url`, `linkedin_url`, `youtube_url`, `tiktok_url`, `website_url`, `status`, `created_at`) VALUES
(1, 2, 'Brian Kasongo', 'Sales Man', '+260776828793', 'brianmwilakasongo@gmail.com', '0776828793', 'uploads/686d7d98dedbe_Screenshot_20250707-183559_WhatsApp.jpg', 'https://trucksonsale.co.za/listing.php?action=manage_sales_team', NULL, NULL, 'https://trucksonsale.co.za/listing.php?action=manage_sales_team', NULL, NULL, NULL, 'active', '2025-07-08 20:20:40'),
(2, 3, 'Brian Kasongo', 'Sales Man', '260776828793', 'brianmwilakasongo@gmail.com', '0776828793', 'uploads/686d7d98dedbe_Screenshot_20250707-183559_W...', 'https://trucksonsale.co.za/listing.php?action=mana...', NULL, NULL, 'https://trucksonsale.co.za/listing.php?action=mana...', NULL, NULL, NULL, 'active', '2025-07-08 20:20:40'),
(3, 3, 'Luckaon chisala ', 'Sales team manager ', '0771355473', 'chisalaluckyk5@gmail.com', '0771355473', 'uploads/6873797fc802d_1000005028.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-13 09:16:47');

-- --------------------------------------------------------

--
-- Table structure for table `finance_applications`
--

CREATE TABLE `finance_applications` (
  `application_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `customer_id_number` varchar(20) NOT NULL,
  `monthly_income` decimal(12,2) NOT NULL,
  `employment_status` enum('employed','self_employed','unemployed','retired') NOT NULL,
  `employer_name` varchar(100) DEFAULT NULL,
  `employment_years` int(11) DEFAULT NULL,
  `vehicle_price` decimal(12,2) NOT NULL,
  `deposit_amount` decimal(12,2) NOT NULL,
  `loan_amount` decimal(12,2) NOT NULL,
  `loan_term_months` int(11) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `monthly_payment` decimal(10,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `application_status` enum('pending','approved','rejected','processing') DEFAULT 'pending',
  `credit_score` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_billing`
--

CREATE TABLE `finance_billing` (
  `billing_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `billing_type` enum('application_fee','processing_fee','admin_fee','commission') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `billing_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_status` enum('pending','paid','overdue','cancelled') DEFAULT 'pending',
  `payment_date` date DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `transaction_reference` varchar(100) DEFAULT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `frontend_submission_images`
--

CREATE TABLE `frontend_submission_images` (
  `image_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `image_order` int(11) DEFAULT 0,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores images for frontend vehicle submissions';

-- --------------------------------------------------------

--
-- Table structure for table `frontend_vehicle_submissions`
--

CREATE TABLE `frontend_vehicle_submissions` (
  `submission_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `make` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `year` int(4) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `mileage` int(11) DEFAULT 0,
  `fuel_type` enum('Diesel','Petrol','Electric','Hybrid','LPG','CNG') DEFAULT 'Diesel',
  `transmission` enum('Manual','Automatic','Semi-Automatic','CVT') DEFAULT 'Manual',
  `engine_size` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `region` varchar(100) NOT NULL,
  `contact_name` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `listing_type` enum('sale','hire','rent-to-own','auction') DEFAULT 'sale',
  `submission_status` enum('pending','approved','rejected','published') DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores vehicle submissions from the frontend sell-your-truck form';

--
-- Dumping data for table `frontend_vehicle_submissions`
--

INSERT INTO `frontend_vehicle_submissions` (`submission_id`, `category`, `make`, `model`, `year`, `price`, `mileage`, `fuel_type`, `transmission`, `engine_size`, `description`, `city`, `region`, `contact_name`, `contact_email`, `contact_phone`, `listing_type`, `submission_status`, `admin_notes`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(1, 'truck', 'Mercedes-Benz', 'Actros', 2019, 850000.00, 125000, 'Diesel', 'Automatic', '12.8L', 'Excellent condition Mercedes-Benz Actros truck. Well maintained with full service history. Perfect for long-haul transportation. Features include air conditioning, power steering, ABS brakes, and comfortable cabin. Ready for immediate use.', 'Johannesburg', 'Gauteng', 'John Smith', 'john.smith@example.com', '011 123 4567', 'sale', 'pending', NULL, NULL, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(2, 'bakkie', 'Toyota', 'Hilux', 2021, 450000.00, 45000, 'Diesel', 'Manual', '2.4L', 'Nearly new Toyota Hilux double cab bakkie. Excellent condition with low mileage. Perfect for both personal and commercial use. Features include air conditioning, power steering, central locking, and canopy. One owner vehicle with full service history.', 'Cape Town', 'Western Cape', 'Sarah Johnson', 'sarah.johnson@example.com', '021 456 7890', 'sale', 'pending', NULL, NULL, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(3, 'bus', 'Volvo', 'B7R', 2018, 1200000.00, 180000, 'Diesel', 'Automatic', '7.2L', 'Volvo B7R luxury coach bus in excellent condition. 49-seater with air conditioning, reclining seats, entertainment system, and luggage compartments. Perfect for tour operators or transport companies. Well maintained with complete service records.', 'Durban', 'KwaZulu-Natal', 'Mike Wilson', 'mike.wilson@example.com', '031 789 0123', 'sale', 'approved', NULL, NULL, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11');

--
-- Triggers `frontend_vehicle_submissions`
--
DELIMITER $$
CREATE TRIGGER `after_submission_insert` AFTER INSERT ON `frontend_vehicle_submissions` FOR EACH ROW BEGIN
    -- Insert notification for new submission
    INSERT INTO `submission_notifications` (
        `submission_id`, `notification_type`, `recipient_email`, 
        `subject`, `message`, `created_at`
    ) VALUES (
        NEW.submission_id, 
        'submitted', 
        NEW.contact_email,
        'Vehicle Listing Submitted Successfully',
        CONCAT('Dear ', NEW.contact_name, ',\n\nThank you for submitting your ', NEW.year, ' ', NEW.make, ' ', NEW.model, ' for listing on our platform.\n\nSubmission ID: ', NEW.submission_id, '\nStatus: Pending Review\n\nWe will review your submission within 24 hours and contact you with updates.\n\nBest regards,\nTrucksONSale Team'),
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_submission_status_update` AFTER UPDATE ON `frontend_vehicle_submissions` FOR EACH ROW BEGIN
    -- Insert notification when status changes
    IF OLD.submission_status != NEW.submission_status THEN
        INSERT INTO `submission_notifications` (
            `submission_id`, `notification_type`, `recipient_email`, 
            `subject`, `message`, `created_at`
        ) VALUES (
            NEW.submission_id, 
            NEW.submission_status, 
            NEW.contact_email,
            CASE NEW.submission_status
                WHEN 'approved' THEN 'Vehicle Listing Approved'
                WHEN 'rejected' THEN 'Vehicle Listing Requires Changes'
                WHEN 'published' THEN 'Vehicle Listing Now Live'
                ELSE 'Vehicle Listing Status Update'
            END,
            CASE NEW.submission_status
                WHEN 'approved' THEN CONCAT('Dear ', NEW.contact_name, ',\n\nGreat news! Your ', NEW.year, ' ', NEW.make, ' ', NEW.model, ' listing has been approved.\n\nSubmission ID: ', NEW.submission_id, '\n\nYour listing will be published shortly and you will receive another notification when it goes live.\n\nBest regards,\nTrucksONSale Team')
                WHEN 'rejected' THEN CONCAT('Dear ', NEW.contact_name, ',\n\nYour ', NEW.year, ' ', NEW.make, ' ', NEW.model, ' listing requires some changes before it can be published.\n\nSubmission ID: ', NEW.submission_id, '\nAdmin Notes: ', COALESCE(NEW.admin_notes, 'Please contact us for details'), '\n\nPlease contact us to discuss the required changes.\n\nBest regards,\nTrucksONSale Team')
                WHEN 'published' THEN CONCAT('Dear ', NEW.contact_name, ',\n\nExcellent! Your ', NEW.year, ' ', NEW.make, ' ', NEW.model, ' is now live on our platform.\n\nSubmission ID: ', NEW.submission_id, '\nListing Price: R', FORMAT(NEW.price, 0), '\n\nYour listing is now visible to thousands of potential buyers. We will notify you of any inquiries.\n\nBest regards,\nTrucksONSale Team')
                ELSE CONCAT('Dear ', NEW.contact_name, ',\n\nYour vehicle listing status has been updated.\n\nSubmission ID: ', NEW.submission_id, '\nNew Status: ', NEW.submission_status, '\n\nBest regards,\nTrucksONSale Team')
            END,
            NOW()
        );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hero_images`
--

CREATE TABLE `hero_images` (
  `image_id` int(11) NOT NULL,
  `image_title` varchar(100) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `image_description` text DEFAULT NULL,
  `category` enum('trucks','commercial','logistics','transport','general') DEFAULT 'general',
  `is_active` tinyint(1) DEFAULT 1,
  `display_order` int(11) DEFAULT 0,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hero_images`
--

INSERT INTO `hero_images` (`image_id`, `image_title`, `image_url`, `image_description`, `category`, `is_active`, `display_order`, `uploaded_by`, `created_at`, `updated_at`) VALUES
(1, 'Truck on Highway', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Professional truck driving on highway', 'trucks', 1, 1, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(2, 'Commercial Fleet', 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Commercial vehicle fleet', 'commercial', 1, 2, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(3, 'Truck Interior', 'https://images.unsplash.com/photo-1586521995568-39abaa0c2311?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Professional truck cab interior', 'trucks', 1, 3, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(4, 'Highway Transport', 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Highway transportation scene', 'transport', 1, 4, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(5, 'Truck Depot', 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Industrial truck depot', 'logistics', 1, 6, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(6, 'Logistics Center', 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Modern logistics facility', 'logistics', 1, 7, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(7, 'Transport Hub', 'https://images.unsplash.com/photo-1520637836862-4d197d17c93a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Commercial transport hub', 'transport', 1, 8, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(8, 'Industrial Vehicles', 'https://images.unsplash.com/photo-1553729459-efe14ef6055d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Heavy-duty industrial vehicles', 'commercial', 1, 9, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11'),
(9, 'Road Transport', 'https://images.unsplash.com/photo-1494412651409-8963ce7935a7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80', 'Professional road transport', 'transport', 1, 10, NULL, '2025-09-01 12:37:11', '2025-09-01 12:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `hire_bookings`
--

CREATE TABLE `hire_bookings` (
  `booking_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `daily_rate` decimal(8,2) DEFAULT NULL,
  `total_cost` decimal(12,2) DEFAULT NULL,
  `status` enum('pending','confirmed','active','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `inquiry_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `inquiry_type` enum('general','finance','trade_in','inspection','test_drive') DEFAULT 'general',
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `preferred_contact` enum('phone','email','whatsapp') DEFAULT 'phone',
  `status` enum('new','contacted','in_progress','closed') DEFAULT 'new',
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `follow_up_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `responded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`inquiry_id`, `vehicle_id`, `dealer_id`, `inquiry_type`, `full_name`, `email`, `phone`, `message`, `preferred_contact`, `status`, `priority`, `follow_up_date`, `notes`, `created_at`, `responded_at`) VALUES
(1, 8, 3, 'general', 'gjj', 'chisalaluckyk5@gmail.com', '26', 'I\\\'m interested in this 2018 Isuzu GXR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-07 07:56:29', NULL),
(2, 14, 6, 'finance', 'Luapula', 'b@gmail.com', '0776828796', 'I am interested in this 2023 Brand A Model 1. Please contact me with more information.', 'email', 'new', 'medium', NULL, NULL, '2025-07-07 09:54:23', NULL),
(3, 15, 2, 'finance', 'Mafuleka', 'm@m.com', '0977278550', 'I am interested in this 2024 Volvo FH. Please contact me with more information.', 'email', 'new', 'medium', NULL, NULL, '2025-07-07 18:52:10', NULL),
(4, 13, 3, 'general', 'chisala', 'chisalaluckyk5@gmail.com', '999', 'nn', 'whatsapp', 'new', 'medium', NULL, NULL, '2025-07-08 08:53:19', NULL),
(5, 15, 2, 'general', 'Mutale ', 'mutalemattlesa@gmail.com', '0770967132', 'Stuff', 'phone', 'new', 'medium', NULL, NULL, '2025-07-08 09:32:58', NULL),
(6, 6, 3, 'general', 'Mutale Lesa', 'mutalemattlesa@gmail.com', '0770967132', '59 ebuebheghe', 'phone', 'new', 'medium', NULL, NULL, '2025-07-08 09:35:54', NULL),
(7, 18, 3, 'general', 'chicken', 'chisalaluckyk5@gmail.com', '86 54', 'I\\\'m interested in this 2024 Isuzu FTR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-08 10:51:48', NULL),
(8, 18, 3, 'general', 'gjjgf', 'chisalaluckyk5@gmail.com', '563', 'I\\\'m interested in this 2024 Isuzu FTR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-08 12:53:00', NULL),
(9, 4, 3, 'general', 'ghh jj', 'chisalaluckyk5@gmail.com', '563', 'I\\\'m interested in this 2018 Scania Macopolo. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-13 07:34:42', NULL),
(10, 7, 3, 'general', 'fgg', 'chisalaluckyk5@gmail.com', '88', 'I\\\'m interested in this 2022 DAF XF. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-13 07:57:17', NULL),
(11, 5, 3, 'general', 'chisala', 'chisalaluckyk5@gmail.com', '9494', 'I\\\'m interested in this 2023 Toyota Landcruseir. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-14 08:28:05', NULL),
(12, 7, 3, 'general', 'nnn', 'chisalaluckyk5@gmail.com', '66', 'I\\\'m interested in this 2022 DAF XF. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-15 10:20:56', NULL),
(13, 18, 3, 'general', 'bna', 'chisalaluckyk5@gmail.com', '979', 'I\\\'m interested in this 2024 Isuzu FTR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-15 11:46:15', NULL),
(14, 21, 3, 'general', 'gg', 'chisalaluckyk5@gmail.com', '5', 'I\\\'m interested in this 2015 Iveco Eurocargo. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-16 12:19:06', NULL),
(15, 7, 3, 'general', 'vh', 'chisalaluckyk5@gmail.com', '866', 'I\\\'m interested in this 2022 DAF XF. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-16 12:51:04', NULL),
(16, 8, 3, 'general', 'xghh', 'chisalaluckyk5@gmail.com', '23', 'I\\\'m interested in this 2018 Isuzu GXR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-16 12:51:46', NULL),
(17, 7, 3, 'general', 'chisal', 'chisalaluckyk5@gmail.com', '99', 'nn', 'email', 'new', 'medium', NULL, NULL, '2025-07-18 09:23:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pickup_locations`
--

CREATE TABLE `pickup_locations` (
  `id` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `location_type` enum('airport','city','depot','hotel','other') DEFAULT 'other',
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `airport_code` varchar(10) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pickup_locations`
--

INSERT INTO `pickup_locations` (`id`, `location_name`, `location_type`, `city`, `province`, `airport_code`, `address`, `latitude`, `longitude`, `is_active`, `created_at`) VALUES
(1, 'OR Tambo International Airport', 'airport', 'Johannesburg', 'Gauteng', 'JNB', 'OR Tambo Airport Rd, Kempton Park, 1627', -26.13920000, 28.24600000, 1, '2025-09-01 14:20:59'),
(2, 'Cape Town International Airport', 'airport', 'Cape Town', 'Western Cape', 'CPT', 'Matroosfontein, Cape Town, 7490', -33.97150000, 18.60210000, 1, '2025-09-01 14:20:59'),
(3, 'King Shaka International Airport', 'airport', 'Durban', 'KwaZulu-Natal', 'DUR', 'La Mercy, KwaZulu-Natal, 4405', -29.61440000, 31.11970000, 1, '2025-09-01 14:20:59'),
(4, 'Lanseria International Airport', 'airport', 'Lanseria', 'Gauteng', 'HLA', 'Lanseria International Airport, 1748', -25.93850000, 27.92610000, 1, '2025-09-01 14:20:59'),
(5, 'Wonderboom Airport', 'airport', 'Pretoria', 'Gauteng', 'PRY', 'Wonderboom Airport, Pretoria, 0182', -25.65390000, 28.22420000, 1, '2025-09-01 14:20:59'),
(6, 'Rand Airport', 'airport', 'Germiston', 'Gauteng', 'QRA', 'Rand Airport, Germiston, 1401', -26.24250000, 28.15110000, 1, '2025-09-01 14:20:59'),
(7, 'George Airport', 'airport', 'George', 'Western Cape', 'GRJ', 'George Airport, George, 6530', -34.00560000, 22.37890000, 1, '2025-09-01 14:20:59'),
(8, 'Pietermaritzburg Airport', 'airport', 'Pietermaritzburg', 'KwaZulu-Natal', 'PZB', 'Oribi Airport, Pietermaritzburg, 3201', -29.64900000, 30.39870000, 1, '2025-09-01 14:20:59'),
(9, 'Richards Bay Airport', 'airport', 'Richards Bay', 'KwaZulu-Natal', 'RCB', 'Richards Bay Airport, Richards Bay, 3900', -28.74100000, 32.09210000, 1, '2025-09-01 14:20:59'),
(10, 'Margate Airport', 'airport', 'Margate', 'KwaZulu-Natal', 'MGH', 'Margate Airport, Margate, 4275', -30.85740000, 30.34310000, 1, '2025-09-01 14:20:59'),
(11, 'Port Elizabeth Airport', 'airport', 'Port Elizabeth', 'Eastern Cape', 'PLZ', 'Allister Miller Dr, Walmer, Port Elizabeth, 6070', -33.98490000, 25.61730000, 1, '2025-09-01 14:20:59'),
(12, 'East London Airport', 'airport', 'East London', 'Eastern Cape', 'ELS', 'Ben Schoeman Airport, East London, 5201', -33.03560000, 27.82590000, 1, '2025-09-01 14:20:59'),
(13, 'Mthatha Airport', 'airport', 'Mthatha', 'Eastern Cape', 'UTT', 'K. D. Matanzima Airport, Mthatha, 5100', -31.54790000, 28.67380000, 1, '2025-09-01 14:20:59'),
(14, 'Bram Fischer International Airport', 'airport', 'Bloemfontein', 'Free State', 'BFN', 'Bram Fischer International Airport, Bloemfontein, 9300', -29.09270000, 26.30240000, 1, '2025-09-01 14:20:59'),
(15, 'Welkom Airport', 'airport', 'Welkom', 'Free State', 'WEL', 'Welkom Airport, Welkom, 9460', -27.99810000, 26.66950000, 1, '2025-09-01 14:20:59'),
(16, 'Kimberley Airport', 'airport', 'Kimberley', 'Northern Cape', 'KIM', 'Kimberley Airport, Kimberley, 8301', -28.80280000, 24.76510000, 1, '2025-09-01 14:20:59'),
(17, 'Upington Airport', 'airport', 'Upington', 'Northern Cape', 'UTN', 'Upington Airport, Upington, 8801', -28.39910000, 21.26030000, 1, '2025-09-01 14:20:59'),
(18, 'Alexander Bay Airport', 'airport', 'Alexander Bay', 'Northern Cape', 'ALJ', 'Alexander Bay Airport, Alexander Bay, 8290', -28.57500000, 16.53330000, 1, '2025-09-01 14:20:59'),
(19, 'Pilanesberg International Airport', 'airport', 'Sun City', 'North West', 'NTY', 'Pilanesberg International Airport, Sun City, 0316', -25.33380000, 27.17330000, 1, '2025-09-01 14:20:59'),
(20, 'Mafikeng Airport', 'airport', 'Mafikeng', 'North West', 'MBD', 'Mafikeng Airport, Mafikeng, 2745', -25.79840000, 25.54790000, 1, '2025-09-01 14:20:59'),
(21, 'Polokwane International Airport', 'airport', 'Polokwane', 'Limpopo', 'PTG', 'Gateway International Airport, Polokwane, 0699', -23.84530000, 29.45840000, 1, '2025-09-01 14:20:59'),
(22, 'Phalaborwa Airport', 'airport', 'Phalaborwa', 'Limpopo', 'PHW', 'Phalaborwa Airport, Phalaborwa, 1390', -23.93720000, 31.15540000, 1, '2025-09-01 14:20:59'),
(23, 'Thohoyandou Airport', 'airport', 'Thohoyandou', 'Limpopo', 'THY', 'Thohoyandou Airport, Thohoyandou, 0950', -22.95190000, 30.32080000, 1, '2025-09-01 14:20:59'),
(24, 'Hoedspruit Air Force Base', 'airport', 'Hoedspruit', 'Limpopo', 'HDS', 'Hoedspruit Air Force Base, Hoedspruit, 1380', -24.36860000, 30.92870000, 1, '2025-09-01 14:20:59'),
(25, 'Kruger Mpumalanga International Airport', 'airport', 'Nelspruit', 'Mpumalanga', 'MQP', 'Kruger Mpumalanga International Airport, Nelspruit, 1200', -25.38320000, 31.10560000, 1, '2025-09-01 14:20:59'),
(26, 'Secunda Airport', 'airport', 'Secunda', 'Mpumalanga', 'ZEC', 'Secunda Airport, Secunda, 2302', -26.52390000, 29.17010000, 1, '2025-09-01 14:20:59'),
(27, 'Witbank Airport', 'airport', 'Witbank', 'Mpumalanga', 'HCS', 'Witbank Airport, Witbank, 1035', -25.83190000, 29.19190000, 1, '2025-09-01 14:20:59'),
(28, 'Skukuza Airport', 'airport', 'Skukuza', 'Mpumalanga', 'SZK', 'Skukuza Airport, Kruger National Park, 1350', -24.96080000, 31.58860000, 1, '2025-09-01 14:20:59'),
(29, 'Sishen Airport', 'airport', 'Sishen', 'Northern Cape', 'SIS', 'Sishen Airport, Sishen, 8472', -27.64860000, 23.00530000, 1, '2025-09-01 14:20:59'),
(30, 'Springbok Airport', 'airport', 'Springbok', 'Northern Cape', 'SBU', 'Springbok Airport, Springbok, 8240', -29.68920000, 17.93950000, 1, '2025-09-01 14:20:59'),
(31, 'Virginia Airport', 'airport', 'Virginia', 'Free State', 'VIR', 'Virginia Airport, Virginia, 9430', -28.10420000, 26.86530000, 1, '2025-09-01 14:20:59');

-- --------------------------------------------------------

--
-- Table structure for table `premium_ads`
--

CREATE TABLE `premium_ads` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `link_url` varchar(500) DEFAULT NULL,
  `ad_type` enum('banner','box') NOT NULL,
  `position` varchar(100) DEFAULT 'homepage',
  `status` enum('active','inactive','pending') DEFAULT 'active',
  `display_order` int(11) DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `click_count` int(11) DEFAULT 0,
  `impression_count` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `ad_owner_type` enum('admin','dealer') DEFAULT 'admin',
  `ad_owner_id` int(11) DEFAULT NULL,
  `target_pages` text DEFAULT NULL,
  `max_impressions` int(11) DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `cost_per_click` decimal(5,2) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `premium_ads`
--

INSERT INTO `premium_ads` (`id`, `title`, `image_url`, `link_url`, `ad_type`, `position`, `status`, `display_order`, `start_date`, `end_date`, `click_count`, `impression_count`, `created_by`, `ad_owner_type`, `ad_owner_id`, `target_pages`, `max_impressions`, `budget`, `cost_per_click`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(2, 'Premium Commercial Vehicles - Best Deals', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=400&q=80', '?category=trucks', 'banner', 'homepage', 'active', 1, NULL, NULL, 0, 0, NULL, 'admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-16 07:46:22', '2025-07-16 07:46:22'),
(4, 'Bus & Coach Solutions', 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=400&q=80', '?category=buses', 'banner', 'homepage', 'active', 3, NULL, NULL, 0, 0, NULL, 'admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-16 07:46:22', '2025-07-16 07:46:22'),
(6, 'Trade-In Your Old Vehicle', 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=600&q=80', '?page=trade-in', 'box', 'homepage', 'active', 2, NULL, NULL, 0, 0, NULL, 'admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-16 07:46:22', '2025-07-16 07:46:22'),
(7, 'Insurance & Warranty Plans', 'https://images.unsplash.com/photo-1551836022-deb4988cc6c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=600&q=80', '?page=insurance', 'box', 'homepage', 'active', 3, NULL, NULL, 0, 0, NULL, 'admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-16 07:46:22', '2025-07-16 07:46:22'),
(8, 'Professional Vehicle Inspections', 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=600&q=80', '?page=inspection', 'box', 'homepage', 'active', 4, NULL, NULL, 0, 0, NULL, 'admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-16 07:46:22', '2025-07-16 07:46:22'),
(9, 'pickandpay', 'uploads/ads/68b6942b4415c_ad1.jpg', NULL, 'banner', 'homepage', 'active', 0, NULL, '2025-10-02', 0, 0, 1, 'admin', 1, NULL, NULL, NULL, NULL, 1, '2025-09-02 04:52:27', '2025-09-02 06:52:27', '2025-09-02 06:52:27'),
(11, 'pizza', 'uploads/ads/68b69669d234e_ad2.jpg', NULL, 'banner', 'homepage', 'active', 2, NULL, '2025-10-02', 0, 0, 1, 'admin', 1, NULL, NULL, NULL, NULL, 1, '2025-09-02 05:02:01', '2025-09-02 07:02:01', '2025-09-02 07:02:01');

-- --------------------------------------------------------

--
-- Table structure for table `premium_backgrounds`
--

CREATE TABLE `premium_backgrounds` (
  `bg_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `advertiser_name` varchar(100) DEFAULT NULL,
  `advertiser_contact` varchar(100) DEFAULT NULL,
  `advertiser_url` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `click_count` int(11) DEFAULT 0,
  `status` enum('active','inactive','expired') DEFAULT 'active',
  `priority` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `premium_backgrounds`
--

INSERT INTO `premium_backgrounds` (`bg_id`, `image_path`, `title`, `description`, `advertiser_name`, `advertiser_contact`, `advertiser_url`, `start_date`, `end_date`, `click_count`, `status`, `priority`, `created_at`) VALUES
(1, 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11'),
(2, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11'),
(3, 'https://images.unsplash.com/photo-1594736797933-d0301ba2fe65?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11'),
(4, 'https://images.unsplash.com/photo-1519003722824-194d4455a60c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11'),
(5, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11');

-- --------------------------------------------------------

--
-- Table structure for table `recently_viewed`
--

CREATE TABLE `recently_viewed` (
  `id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recently_viewed`
--

INSERT INTO `recently_viewed` (`id`, `session_id`, `vehicle_id`, `viewed_at`) VALUES
(1, '6101tns5rqqmktsqg7c1kovf84', 16, '2025-09-01 15:20:46'),
(3, '6101tns5rqqmktsqg7c1kovf84', 15, '2025-09-01 15:39:10'),
(4, '6101tns5rqqmktsqg7c1kovf84', 30, '2025-09-01 15:39:56'),
(5, 'epll0e4d9lp090875dh0rf2b70', 29, '2025-09-01 16:24:49'),
(6, '4avjisqiphf8q5ei6v653fmvvn', 21, '2025-09-01 16:27:10'),
(9, '4avjisqiphf8q5ei6v653fmvvn', 33, '2025-09-01 16:31:49'),
(10, 'im5mfijegsbfrgg9hvp713e01h', 33, '2025-09-01 16:31:55'),
(11, '23edd3felt4igju25q6mf5l4pk', 33, '2025-09-01 16:31:56'),
(12, '4c2frgu95n97g91vechlrgdn8p', 33, '2025-09-01 16:31:58'),
(13, '4avjisqiphf8q5ei6v653fmvvn', 29, '2025-09-01 16:37:51'),
(14, 'btuqoqvr1i60lc224ojen812rp', 28, '2025-09-01 16:39:23'),
(15, '4avjisqiphf8q5ei6v653fmvvn', 16, '2025-09-01 16:51:11'),
(17, '4avjisqiphf8q5ei6v653fmvvn', 20, '2025-09-01 16:50:38'),
(18, '4avjisqiphf8q5ei6v653fmvvn', 32, '2025-09-01 16:50:52'),
(20, '8b47v3amfjqm89n8kq70vucki5', 19, '2025-09-01 16:55:49'),
(21, '8urhi75g41chkjfqjm0iv6pa5c', 29, '2025-09-02 06:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `rent_to_own_bookings`
--

CREATE TABLE `rent_to_own_bookings` (
  `booking_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `monthly_income` decimal(10,2) NOT NULL,
  `employment_status` varchar(100) NOT NULL,
  `employer_name` varchar(255) DEFAULT NULL,
  `preferred_term` int(11) DEFAULT NULL,
  `down_payment` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','approved','active','completed','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `subcategory_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_key` varchar(50) NOT NULL,
  `subcategory_name` varchar(100) NOT NULL,
  `subcategory_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`subcategory_id`, `category_id`, `subcategory_key`, `subcategory_name`, `subcategory_order`, `status`, `created_at`) VALUES
(1, 1, 'light_duty', 'Light Duty Trucks', 0, 'active', '2025-07-07 03:09:28'),
(2, 1, 'heavy_duty', 'Heavy Duty Trucks', 0, 'active', '2025-07-07 03:09:28'),
(3, 1, 'medium_duty', 'Medium Duty Trucks', 0, 'active', '2025-07-07 03:09:28'),
(4, 2, 'flatbed', 'Flatbed Trailers', 0, 'active', '2025-07-07 03:09:28'),
(5, 2, 'enclosed', 'Enclosed Trailers', 0, 'active', '2025-07-07 03:09:28'),
(6, 2, 'refrigerated', 'Refrigerated Trailers', 0, 'active', '2025-07-07 03:09:28'),
(7, 3, 'passenger', 'Passenger Buses', 0, 'active', '2025-07-07 03:09:28'),
(8, 3, 'school', 'School Buses', 0, 'active', '2025-07-07 03:09:28'),
(9, 3, 'charter', 'Charter Buses', 0, 'active', '2025-07-07 03:09:28'),
(10, 32, 'cattle', 'Cattle', 1, 'active', '2025-08-29 12:00:00'),
(11, 32, 'dairy_cows', 'Dairy Cows', 2, 'active', '2025-08-29 12:00:00'),
(12, 32, 'beef_cattle', 'Beef Cattle', 3, 'active', '2025-08-29 12:00:00'),
(13, 32, 'bulls', 'Bulls', 4, 'active', '2025-08-29 12:00:00'),
(14, 32, 'sheep', 'Sheep', 5, 'active', '2025-08-29 12:00:00'),
(15, 32, 'goats', 'Goats', 6, 'active', '2025-08-29 12:00:00'),
(16, 32, 'pigs', 'Pigs', 7, 'active', '2025-08-29 12:00:00'),
(17, 32, 'horses', 'Horses', 8, 'active', '2025-08-29 12:00:00'),
(18, 32, 'donkeys', 'Donkeys', 9, 'active', '2025-08-29 12:00:00'),
(19, 32, 'chickens', 'Chickens', 10, 'active', '2025-08-29 12:00:00'),
(20, 32, 'ducks', 'Ducks', 11, 'active', '2025-08-29 12:00:00'),
(21, 32, 'geese', 'Geese', 12, 'active', '2025-08-29 12:00:00'),
(22, 32, 'turkeys', 'Turkeys', 13, 'active', '2025-08-29 12:00:00'),
(23, 32, 'ostriches', 'Ostriches', 14, 'active', '2025-08-29 12:00:00'),
(24, 32, 'rabbits', 'Rabbits', 15, 'active', '2025-08-29 12:00:00'),
(25, 32, 'game_animals', 'Game Animals', 16, 'active', '2025-08-29 12:00:00'),
(26, 32, 'breeding_stock', 'Breeding Stock', 17, 'active', '2025-08-29 12:00:00'),
(27, 32, 'dairy_animals', 'Dairy Animals', 18, 'active', '2025-08-29 12:00:00'),
(28, 32, 'poultry', 'Poultry', 19, 'active', '2025-08-29 12:00:00'),
(29, 32, 'exotic_animals', 'Exotic Animals', 20, 'active', '2025-08-29 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `submission_notifications`
--

CREATE TABLE `submission_notifications` (
  `notification_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `notification_type` enum('submitted','under_review','approved','rejected','published','contact_request') NOT NULL,
  `recipient_email` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores notifications sent to users about their submissions';

-- --------------------------------------------------------

--
-- Table structure for table `submission_reviews`
--

CREATE TABLE `submission_reviews` (
  `review_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `review_action` enum('approved','rejected','needs_changes') NOT NULL,
  `review_notes` text DEFAULT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tracks admin reviews of vehicle submissions';

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL DEFAULT 0,
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('text','number','boolean','json') DEFAULT 'text',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, 1, 'site_name', 'TrucksONSale', 'text', 'Website name', '2025-07-09 04:04:01', '2025-07-14 00:55:47', 1),
(2, 2, 'default_featured_limit', '2', 'number', 'Default featured listing limit for new dealers', '2025-07-09 04:04:01', '2025-07-14 00:51:31', 1),
(3, 3, 'auto_approve_dealers', '0', 'boolean', 'Automatically approve new dealer registrations', '2025-07-09 04:04:01', '2025-07-14 00:56:34', 1),
(4, 4, 'maintenance_mode', '0', 'boolean', 'Enable maintenance mode', '2025-07-09 04:04:01', '2025-07-14 00:56:43', 1),
(5, 5, 'max_images_per_listing', '40', 'number', 'Maximum images per vehicle listing', '2025-07-09 04:04:01', '2025-07-14 00:51:31', 1),
(6, 6, 'max_videos_per_listing', '5', 'number', 'Maximum videos per vehicle listing', '2025-07-09 04:04:01', '2025-07-14 00:51:31', 1),
(0, 1819, 'site_description', 'Professional Commercial Vehicle Marketplace', 'text', 'Website description', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1820, 'contact_email', 'admin@trucksonsale.com', 'text', 'Main contact email address', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1821, 'support_phone', '+27 11 123 4567', 'text', 'Support phone number', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1822, 'default_premium_limit', '1', 'number', 'Default premium listing limit for new dealers', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1823, 'default_listing_limit', '50', 'number', 'Default total listing limit for new dealers', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1824, 'auto_approve_listings', '0', 'boolean', 'Automatically approve new vehicle listings', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1825, 'require_dealer_verification', '1', 'boolean', 'Require dealer document verification', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1826, 'allow_guest_inquiries', '1', 'boolean', 'Allow non-registered users to make inquiries', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1827, 'max_file_size_mb', '10', 'number', 'Maximum file size in MB for uploads', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1828, 'listing_expiry_days', '90', 'number', 'Days after which listings expire', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1829, 'featured_listing_price', '299.00', 'number', 'Price for featured listing (ZAR)', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1830, 'premium_listing_price', '199.00', 'number', 'Price for premium listing (ZAR)', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1831, 'enable_hire_bookings', '1', 'boolean', 'Enable vehicle hire booking system', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1832, 'enable_rent_to_own', '1', 'boolean', 'Enable rent-to-own applications', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1833, 'enable_finance_calculator', '1', 'boolean', 'Enable finance calculator', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1834, 'default_currency', 'ZAR', 'text', 'Default currency code', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1835, 'timezone', 'Africa/Johannesburg', 'text', 'System timezone', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1836, 'enable_notifications', '1', 'boolean', 'Enable email notifications', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL),
(0, 1837, 'enable_sms_notifications', '0', 'boolean', 'Enable SMS notifications', '2025-09-01 14:23:59', '2025-09-01 14:23:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `system_years`
--

CREATE TABLE `system_years` (
  `year_id` int(11) NOT NULL,
  `year_value` int(11) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_years`
--

INSERT INTO `system_years` (`year_id`, `year_value`, `status`, `created_at`) VALUES
(1, 1970, 'active', '2025-07-07 03:09:28'),
(2, 1971, 'active', '2025-07-07 03:09:28'),
(3, 1972, 'active', '2025-07-07 03:09:28'),
(4, 1973, 'active', '2025-07-07 03:09:28'),
(5, 1974, 'active', '2025-07-07 03:09:28'),
(6, 1975, 'active', '2025-07-07 03:09:28'),
(7, 1976, 'active', '2025-07-07 03:09:28'),
(8, 1977, 'active', '2025-07-07 03:09:28'),
(9, 1978, 'active', '2025-07-07 03:09:28'),
(10, 1979, 'active', '2025-07-07 03:09:28'),
(11, 1980, 'active', '2025-07-07 03:09:28'),
(12, 1981, 'active', '2025-07-07 03:09:28'),
(13, 1982, 'active', '2025-07-07 03:09:28'),
(14, 1983, 'active', '2025-07-07 03:09:28'),
(15, 1984, 'active', '2025-07-07 03:09:28'),
(16, 1985, 'active', '2025-07-07 03:09:28'),
(17, 1986, 'active', '2025-07-07 03:09:28'),
(18, 1987, 'active', '2025-07-07 03:09:28'),
(19, 1988, 'active', '2025-07-07 03:09:28'),
(20, 1989, 'active', '2025-07-07 03:09:28'),
(21, 1990, 'active', '2025-07-07 03:09:28'),
(22, 1991, 'active', '2025-07-07 03:09:28'),
(23, 1992, 'active', '2025-07-07 03:09:28'),
(24, 1993, 'active', '2025-07-07 03:09:28'),
(25, 1994, 'active', '2025-07-07 03:09:28'),
(26, 1995, 'active', '2025-07-07 03:09:28'),
(27, 1996, 'active', '2025-07-07 03:09:28'),
(28, 1997, 'active', '2025-07-07 03:09:28'),
(29, 1998, 'active', '2025-07-07 03:09:28'),
(30, 1999, 'active', '2025-07-07 03:09:28'),
(31, 2000, 'active', '2025-07-07 03:09:28'),
(32, 2001, 'active', '2025-07-07 03:09:28'),
(33, 2002, 'active', '2025-07-07 03:09:28'),
(34, 2003, 'active', '2025-07-07 03:09:28'),
(35, 2004, 'active', '2025-07-07 03:09:28'),
(36, 2005, 'active', '2025-07-07 03:09:28'),
(37, 2006, 'active', '2025-07-07 03:09:28'),
(38, 2007, 'active', '2025-07-07 03:09:28'),
(39, 2008, 'active', '2025-07-07 03:09:28'),
(40, 2009, 'active', '2025-07-07 03:09:28'),
(41, 2010, 'active', '2025-07-07 03:09:28'),
(42, 2011, 'active', '2025-07-07 03:09:28'),
(43, 2012, 'active', '2025-07-07 03:09:28'),
(44, 2013, 'active', '2025-07-07 03:09:28'),
(45, 2014, 'active', '2025-07-07 03:09:28'),
(46, 2015, 'active', '2025-07-07 03:09:28'),
(47, 2016, 'active', '2025-07-07 03:09:28'),
(48, 2017, 'active', '2025-07-07 03:09:28'),
(49, 2018, 'active', '2025-07-07 03:09:28'),
(50, 2019, 'active', '2025-07-07 03:09:28'),
(51, 2020, 'active', '2025-07-07 03:09:28'),
(52, 2021, 'active', '2025-07-07 03:09:28'),
(53, 2022, 'active', '2025-07-07 03:09:28'),
(54, 2023, 'active', '2025-07-07 03:09:28'),
(55, 2024, 'active', '2025-07-07 03:09:28'),
(56, 2025, 'active', '2025-07-07 03:09:28'),
(57, 2026, 'active', '2025-07-07 03:09:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `company_registration` varchar(50) DEFAULT NULL,
  `vat_number` varchar(20) DEFAULT NULL,
  `physical_address` text DEFAULT NULL,
  `billing_address` text DEFAULT NULL,
  `user_type` enum('customer','dealer','admin') DEFAULT 'customer',
  `status` enum('pending','active','suspended','rejected') DEFAULT 'pending',
  `registered_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT 0,
  `phone_verified` tinyint(1) DEFAULT 0,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `password_reset_expires` timestamp NULL DEFAULT NULL,
  `listing_limit` int(11) DEFAULT 10,
  `featured_limit` int(11) DEFAULT 2,
  `premium_until` date DEFAULT NULL,
  `failed_login_attempts` int(11) DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `phone`, `company_name`, `company_registration`, `vat_number`, `physical_address`, `billing_address`, `user_type`, `status`, `registered_at`, `last_login`, `profile_image`, `email_verified`, `phone_verified`, `password_reset_token`, `password_reset_expires`, `listing_limit`, `featured_limit`, `premium_until`, `failed_login_attempts`, `locked_until`) VALUES
(1, 'admin', 'a@za', '$2y$10$/ft2uEtY8eKkeQ43HoamgOCBP6muuCQ7DwwlOJISp3FIZohAHOi66', '0000000000', 'TrucksONSale Admin', NULL, NULL, NULL, NULL, 'admin', 'active', '2025-07-07 03:09:28', '2025-09-02 06:50:48', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(2, 'John ', 'j@gmail.com', '$2y$10$K1OkSEjcbImuejIp788bh.NyqadticnRzP8OUv/13Y5OYJeIlrfaO', '0776828793', 'BmK Zambia ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 03:20:27', '2025-07-13 09:14:47', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(3, 'Shacman', 'shacman@bizlive.co.za', '$2y$10$1CiCxzIEtcOSQXdnBrdNCedqhBA2r.Sid3PlZtl5bwI.7MyZX5vc6', '0771355473', 'Shacman TNT', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 05:52:34', '2025-09-01 16:39:41', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(4, 't@gmail.com', 'd@d.com', '$2y$10$uvgXck9JSpifzwGmG08M6eGK76x0ogGMw25kPYjhjHw6pFnRFrr4K', '0977278550', 'B Cars', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 07:21:55', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(5, 't@gmail.comm', 'brianmwilakasongo@gmail.com', '$2y$10$/RLfu22uda/brebt.7dfMOwSW7nMW8cXAmAYAx0TqDz73zc6f72se', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 08:43:14', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 1, NULL),
(6, 'aas', 'admin@truckonsale.co.za', '$2y$10$jWj0fy0BooaqCpwE4IMllODctHygqQ/UNZuYKzf7srXFmSufEq81i', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 08:48:02', '2025-07-07 08:48:41', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 4, NULL),
(8, 'a', 'm@m.comm', '$2y$10$ejDf5DgNyCxxAktLAUYFTeziytgW0aX7vNQQiX2Gh/UqRbkUm6Azm', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-09 03:13:38', '2025-07-09 03:15:16', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(9, 'op', 'a@zaa', '$2y$10$EmWj87.r4kkUe93BMRE4ne.15kl2MZ65mJtEH.aPsJUmhH2WbmsV.', '260776828793', 'Jelumu Zambia ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-09 11:59:13', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(10, 'mwansa ', 'n@gmail.com', '$2y$10$DXM9Le1k.S9vOUlqLR3W4uIfEtvK9azm2d31g78Na/tDyQspTqbuC', '0776828793', 'Bmmk', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-14 00:29:38', '2025-07-14 00:55:28', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(11, 'opp', 'b@outlook.com', '$2y$10$FYfGxd8YDFEJoj3JhOGhwedNuy2QaxVxHcU9Ku4UbyoftMz7dQiOa', '0776828793', 'James ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-14 00:39:09', '2025-07-14 09:29:00', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(12, 'bbk', 'bv@yahoo.com', '$2y$10$aqOVTOZnEU4kJnx6QK8kC.OHBtP5Num.WeEp1Z/jTY8AA9/Ozew72', '0776828793', 'B', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-14 00:55:18', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(13, 'lesa', 'mutalemattlesa@gmail.com', '$2y$10$z.cywnsZMy3dyQVAFJrt0uP6WgEDWjycBQr/qiCtgrN3FoOhMuv3u', '90000000', 'Lesa', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-18 15:48:49', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(14, 'tinkle', 'muts@gmail.com', '$2b$10$502tIsRb74XNEQVeJm3HkOMmF356em8gI5mUhu1uibfe3jqnr.klq', '098466131566', 'Lesa', NULL, NULL, NULL, NULL, 'dealer', 'rejected', '2025-07-18 16:50:02', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(15, 'loGan', 'logankapulavii@gmail.com', '$2y$10$qlHc8uW.5Vvfcw9tKpHy6.uzP9XIm2q5ZHmMAEg7gZefAralr6mPi', '776900', 'MAN', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-09-01 15:49:13', '2025-09-01 15:50:22', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `subcategory` varchar(50) DEFAULT NULL,
  `listing_type` enum('sale','rent-to-own','hire','auction') DEFAULT 'sale',
  `condition_type` enum('new','used','refurbished') DEFAULT 'used',
  `make` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `variant` varchar(100) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `mileage` int(11) DEFAULT 0,
  `hours_used` int(11) DEFAULT 0,
  `engine_type` varchar(50) DEFAULT NULL,
  `engine_capacity` varchar(20) DEFAULT NULL,
  `horsepower` int(11) DEFAULT NULL,
  `transmission` varchar(50) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `vin_number` varchar(50) DEFAULT NULL,
  `registration_number` varchar(20) DEFAULT NULL,
  `region` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `condition_rating` enum('excellent','very_good','good','fair','poor') DEFAULT 'good',
  `no_accidents` tinyint(1) DEFAULT 0,
  `warranty` tinyint(1) DEFAULT 0,
  `warranty_details` text DEFAULT NULL,
  `finance_available` tinyint(1) DEFAULT 0,
  `trade_in` tinyint(1) DEFAULT 0,
  `service_history` tinyint(1) DEFAULT 0,
  `roadworthy` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `features` text DEFAULT NULL,
  `youtube_video_url` varchar(255) DEFAULT NULL,
  `daily_rate` decimal(8,2) DEFAULT NULL,
  `weekly_rate` decimal(10,2) DEFAULT NULL,
  `monthly_rate` decimal(12,2) DEFAULT NULL,
  `auction_start_date` datetime DEFAULT NULL,
  `auction_end_date` datetime DEFAULT NULL,
  `reserve_price` decimal(12,2) DEFAULT NULL,
  `current_bid` decimal(12,2) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `featured_until` date DEFAULT NULL,
  `premium_listing` tinyint(1) DEFAULT 0,
  `premium_until` date DEFAULT NULL,
  `status` enum('available','sold','reserved','draft','pending_approval') DEFAULT 'pending_approval',
  `views` int(11) DEFAULT 0,
  `leads_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `approved_at` timestamp NULL DEFAULT NULL,
  `display_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vehicle_id`, `dealer_id`, `category`, `subcategory`, `listing_type`, `condition_type`, `make`, `model`, `variant`, `year`, `price`, `mileage`, `hours_used`, `engine_type`, `engine_capacity`, `horsepower`, `transmission`, `fuel_type`, `color`, `vin_number`, `registration_number`, `region`, `city`, `branch_id`, `condition_rating`, `no_accidents`, `warranty`, `warranty_details`, `finance_available`, `trade_in`, `service_history`, `roadworthy`, `description`, `features`, `youtube_video_url`, `daily_rate`, `weekly_rate`, `monthly_rate`, `auction_start_date`, `auction_end_date`, `reserve_price`, `current_bid`, `featured`, `featured_until`, `premium_listing`, `premium_until`, `status`, `views`, `leads_count`, `created_at`, `updated_at`, `approved_at`, `display_order`) VALUES
(2, 2, 'commercial_vehicles', NULL, 'sale', 'new', 'Brand B', 'Model Y', 'other', 2023, 874000.00, 3690, 0, '1ZR', NULL, 53, 'manual', 'hybrid', 'Brown ', NULL, NULL, 'KwaZulu-Natal', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, ':gggggggggg', 'ttfhuytfd', 'https://youtu.be/5xhvvhCD6Yw?si=CkqwV5M4wWNTWeMV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 4, 0, '2025-07-07 05:53:56', '2025-07-13 10:21:00', NULL, 0),
(3, 3, 'commercial_vehicles', NULL, 'sale', 'used', 'Toyota', 'Hulix', 'legend 50', 2024, 5000.00, 123, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Eastern Cape', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'very powerfull', 'nuynunyjnyjny', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 10, 0, '2025-07-07 05:59:25', '2025-07-16 08:20:54', NULL, 0),
(4, 3, 'buses', NULL, 'sale', 'new', 'Scania', 'Macopolo', 'other', 2018, 200000.00, 887, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Eastern Cape', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'j,', '89o8o', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 15, 0, '2025-07-07 06:18:09', '2025-07-18 14:42:08', NULL, 0),
(5, 3, 'commercial_vehicles', NULL, 'sale', 'new', 'Toyota', 'Landcruseir', 'other', 2023, 123.00, 2000, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Gauteng', 'lusaka', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'very powerfull', 'eedd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-07', 0, NULL, 'available', 9, 0, '2025-07-07 07:26:55', '2025-07-16 10:58:34', NULL, 0),
(6, 3, 'trucks', NULL, 'sale', 'used', 'Benz', 'XCN 3000', 'other', 2022, 2344.00, 2000, 0, 'v8 turbo', NULL, 500, 'automatic', 'diesel', 'white', NULL, NULL, 'Free State', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'hhhtbt', 'yyytgg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 7, 0, '2025-07-07 07:30:49', '2025-07-14 03:09:45', NULL, 0),
(7, 3, 'trucks', NULL, 'sale', 'used', 'DAF', 'XF', 'Standard', 2022, 22.00, 22, 0, 'v8 turbo', NULL, 500, 'semi-automatic', 'lpg', 'white', NULL, NULL, 'Northern Cape', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'very good', 'edeed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 16, 0, '2025-07-07 07:37:54', '2025-07-17 11:55:37', NULL, 0),
(8, 3, 'trucks', NULL, 'sale', 'used', 'Isuzu', 'GXR', 'other', 2018, 22.00, 22, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Limpopo', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'f7f77gr', '77re7r7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 15, 0, '2025-07-07 07:39:37', '2025-07-16 09:21:33', NULL, 0),
(9, 2, 'commercial_vehicles', NULL, 'rent-to-own', 'used', 'Toyota', 'Landcruseir', 'other', 2022, 50888.00, 56499, 0, 'V8', NULL, 693, 'manual', 'diesel', 'green ', NULL, NULL, 'Eastern Cape', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'ghhhh', 'hhjkuh', NULL, 500.00, 66.00, 250.00, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 9, 0, '2025-07-07 07:41:38', '2025-07-14 02:48:57', NULL, 0),
(11, 3, 'farm_equipment', NULL, 'sale', 'used', 'Case IH', 'Magnum', NULL, NULL, 55.00, 44, 0, 'v8 turbo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Limpopo', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, '88rgg', '8r88', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 18, 0, '2025-07-07 07:42:12', '2025-07-17 22:13:00', NULL, 0),
(13, 3, 'farm_equipment', NULL, 'sale', 'used', 'John Deere', '6R Series', NULL, 2017, 123.00, 44, 0, 'v8 turbo', NULL, NULL, 'automatic', 'petrol', 'uuu', NULL, NULL, 'Mpumalanga', 'TEC', NULL, 'good', 1, 1, NULL, 0, 0, 1, 1, 'tfhyt', 'ee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, 'available', 8, 0, '2025-07-07 08:55:52', '2025-07-17 16:11:20', NULL, 0),
(14, 6, 'commercial_vehicles', NULL, 'sale', 'new', 'Brand A', 'Model 1', 'Deluxe', 2023, 5.00, 90, 0, 'V6', NULL, 720, 'manual', 'lpg', 'black', NULL, NULL, 'North West', 'k', NULL, 'good', 1, 0, NULL, 0, 0, 1, 0, 'gvg', 'ytf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 8, 0, '2025-07-07 08:57:46', '2025-07-16 14:21:32', NULL, 0),
(15, 2, 'trucks', NULL, 'hire', 'used', 'Volvo', 'FH', 'Premium', 2024, 580.00, 88, 0, '1ZR', NULL, 74, 'manual', 'diesel', 'Brown ', NULL, NULL, 'Free State', 'yy', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'ggbhug', 'ggjutgb', NULL, 58.00, 80.00, 90.00, NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 15, 0, '2025-07-07 16:03:48', '2025-09-01 15:39:10', NULL, 0),
(16, 2, 'commercial_vehicles', NULL, 'rent-to-own', 'new', 'Toyota', 'Hulix', 'legend 50', 2022, 2995.00, 888, 0, 'v6', NULL, 58, 'automatic', 'petrol', 'green ', NULL, NULL, 'Limpopo', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'gghyf', 'fghyrd', NULL, 80.00, 36.00, 47.00, NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 14, 0, '2025-07-07 16:07:57', '2025-09-01 16:51:11', NULL, 0),
(17, 2, 'commercial_vehicles', NULL, 'sale', 'used', 'Toyota', 'Hulix', 'legend 50', 2022, 50000.00, 50, 0, '1ZR', NULL, 580, 'manual', 'diesel', 'White', NULL, NULL, 'Eastern Cape', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'bbjju', 'hhhfty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-30', 0, NULL, 'available', 21, 0, '2025-07-08 08:08:07', '2025-07-16 08:19:19', NULL, 0),
(18, 3, 'trucks', NULL, 'hire', 'new', 'Isuzu', 'FTR', NULL, 2024, 5779.00, 0, 0, 'v6', NULL, 657, 'automatic', 'diesel', 'white', NULL, NULL, 'North West', 'Lusaka', NULL, 'good', 0, 1, NULL, 1, 0, 0, 0, 'this is nice', 'none', NULL, 500.00, 800.00, 5000.00, NULL, NULL, NULL, NULL, 1, '2025-08-14', 1, '2025-08-07', 'available', 12, 0, '2025-07-08 09:28:03', '2025-07-17 19:20:54', NULL, 0),
(19, 3, 'commercial_vehicles', NULL, 'hire', 'new', 'Toyota', 'Landcruseir', 'other', 2021, 123.00, 44, 0, 'v8 turbo', NULL, 4455, 'manual', 'diesel', 'uuu', NULL, NULL, 'Gauteng', 'TEC', NULL, 'good', 1, 1, NULL, 0, 0, 1, 1, 'hthrhr', 'rtt', NULL, 0.12, 0.06, 24.00, NULL, NULL, NULL, NULL, 1, '2025-08-08', 0, NULL, 'available', 7, 0, '2025-07-09 06:53:33', '2025-09-01 16:55:49', NULL, 0),
(20, 3, 'heavy_machinery', NULL, 'rent-to-own', 'used', 'Caterpillar', '330D', 'other', 2017, 31121.00, 3234, 442, 'v6', NULL, 3545, 'manual', 'diesel', 'white', NULL, NULL, 'Free State', 'Lusaka', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'erwerwe', 'edewdwe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-11', 1, '2025-08-17', 'available', 10, 0, '2025-07-12 17:23:19', '2025-09-01 16:50:38', NULL, 0),
(21, 3, 'trucks', NULL, 'auction', 'used', 'Iveco', 'Eurocargo', NULL, 2015, 450000.00, 434433, 0, 'v6', NULL, 2342, 'manual', 'diesel', 'white', NULL, NULL, 'Western Cape', 'Cape Town', NULL, 'good', 1, 1, 'Service history available', 0, 0, 1, 1, 'Well-maintained Iveco Eurocargo truck for auction. Reliable workhorse perfect for medium-duty commercial operations. Regular maintenance and service history available.', 'Commercial registration, Service history, Reliable engine, Good condition', NULL, NULL, NULL, NULL, '2025-08-29 08:00:00', '2025-09-06 17:00:00', 420000.00, 435000.00, 1, '2025-08-11', 0, NULL, 'available', 7, 0, '2025-07-12 17:26:17', '2025-09-01 16:27:10', NULL, 0),
(22, 3, 'buses', NULL, 'sale', 'new', 'Scania', 'Macopolo', NULL, 2021, 25000.00, 15, 0, '27l', NULL, 250, 'semi-automatic', 'lpg', 'grey', NULL, NULL, 'KwaZulu-Natal', 'Lusaka', NULL, 'good', 1, 0, NULL, 1, 0, 0, 0, 'Very good', 'Nmnj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-11', 0, NULL, 'available', 1, 0, '2025-07-12 18:43:49', '2025-07-17 17:54:59', NULL, 0),
(23, 3, 'commercial_vehicles', NULL, 'sale', 'new', 'Toyota', 'Landcruseir', 'other', 2020, 808.00, 89, 0, 'v8', NULL, 5588, 'manual', 'petrol', 'grey', NULL, NULL, 'Northern Cape', 'Lusaka', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'Bjjj', 'Bjjj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-12', 0, NULL, 'available', 7, 0, '2025-07-13 07:37:05', '2025-07-17 18:40:00', NULL, 0),
(25, 3, 'trailers', NULL, 'sale', 'used', 'SA Truck Bodies', 'Flatdeck', NULL, 2020, 50.00, 6, 0, 'Hvv', NULL, 96, 'semi-automatic', 'petrol', 'Red', NULL, NULL, 'Mpumalanga', ' Bn', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'Vbb', 'Bb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-16', 0, NULL, 'available', 0, 0, '2025-07-17 12:06:57', '2025-07-17 12:06:57', NULL, 0),
(26, 3, 'farm_equipment', NULL, 'sale', 'used', 'New Holland', 'T8', NULL, 2019, 5000.00, 500, 9999, 'v8', NULL, NULL, NULL, 'lpg', 'Ghh', NULL, NULL, 'Mpumalanga', 'Lusaka', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, '  Mmm', ' Nnn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-16', 0, NULL, 'available', 0, 0, '2025-07-17 12:09:20', '2025-07-17 12:09:21', NULL, 0),
(27, 3, 'animal_farming_equipment', NULL, 'sale', 'new', 'Brand A', 'Model 2', 'other', 2019, 800.00, 89, 0, 'Bnn', NULL, NULL, NULL, 'hybrid', NULL, NULL, NULL, 'Northern Cape', 'Bbh', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'Bbb', ' Vvb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-16', 0, NULL, 'available', 0, 0, '2025-07-17 12:10:41', '2025-07-17 12:10:42', NULL, 0),
(28, 3, 'heavy_machinery', NULL, 'sale', 'used', 'Caterpillar', '320D', 'Standard', 2015, 123.00, 44, 9999, 'v8 turbo', NULL, NULL, NULL, NULL, 'uuu', NULL, NULL, 'Gauteng', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'k,,klk,klo', 'llllll', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-17', 0, NULL, 'available', 1, 0, '2025-07-18 11:10:13', '2025-09-01 16:39:23', NULL, 0),
(29, 2, 'trucks', NULL, 'auction', 'used', 'Mercedes-Benz', 'Actros', 'Standard', 2020, 850000.00, 125000, 0, 'V6 Turbo', '12.8L', 450, 'automatic', 'diesel', 'White', NULL, NULL, 'Gauteng', 'Johannesburg', NULL, 'excellent', 1, 1, 'Extended warranty until 2026', 1, 1, 1, 1, 'Excellent condition Mercedes-Benz Actros truck for auction. Well maintained with full service history. Perfect for long-haul transportation. Features include air conditioning, power steering, ABS brakes, and comfortable cabin.', 'Air conditioning, Power steering, ABS brakes, Cruise control, GPS navigation, Bluetooth connectivity', NULL, NULL, NULL, NULL, '2025-08-29 10:00:00', '2025-09-05 18:00:00', 800000.00, 821000.00, 0, NULL, 0, NULL, 'available', 4, 0, '2025-08-29 10:00:00', '2025-09-02 06:23:18', NULL, 0),
(30, 3, 'trucks', NULL, 'auction', 'used', 'Volvo', 'FH16', 'Premium', 2019, 750000.00, 180000, 0, 'V8 Turbo', '16.1L', 540, 'automatic', 'diesel', 'Blue', NULL, NULL, 'Western Cape', 'Cape Town', NULL, 'very_good', 1, 1, 'Manufacturer warranty', 1, 1, 1, 1, 'Reliable Volvo FH16 truck available for auction. Perfect for long-haul transportation. Well-maintained engine with excellent fuel efficiency. Professional driver cabin with all modern amenities.', 'Adaptive cruise control, Lane departure warning, Emergency braking, Climate control, Premium sound system', NULL, NULL, NULL, NULL, '2025-08-29 12:00:00', '2025-09-03 20:00:00', 700000.00, 725000.00, 0, NULL, 0, NULL, 'available', 1, 0, '2025-08-29 12:00:00', '2025-09-01 15:39:56', NULL, 0),
(31, 2, 'trucks', NULL, 'auction', 'used', 'Scania', 'R450', 'Highline', 2021, 950000.00, 85000, 0, 'V8 Turbo', '13.0L', 450, 'automatic', 'diesel', 'Red', NULL, NULL, 'KwaZulu-Natal', 'Durban', NULL, 'excellent', 1, 1, 'Full warranty coverage', 1, 1, 1, 1, 'Low mileage Scania R450 truck for auction. Excellent condition with warranty. Premium cabin with advanced driver assistance systems. Ideal for both local and long-distance hauling.', 'Advanced driver assistance, Premium interior, Fuel-efficient engine, Comfortable suspension, Modern dashboard', NULL, NULL, NULL, NULL, '2025-08-29 14:00:00', '2025-09-01 16:00:00', 900000.00, 920000.00, 0, NULL, 0, NULL, 'available', 0, 0, '2025-08-29 14:00:00', '2025-08-29 14:00:00', NULL, 0),
(32, 3, 'commercial_vehicles', NULL, 'auction', 'used', 'Isuzu', 'NPR', 'Standard', 2018, 450000.00, 95000, 0, 'V6', '5.2L', 190, 'manual', 'diesel', 'White', NULL, NULL, 'Mpumalanga', 'Nelspruit', NULL, 'good', 1, 0, NULL, 1, 1, 1, 1, 'Reliable Isuzu NPR commercial vehicle for auction. Perfect for delivery and logistics operations. Well-maintained with regular service history. Ready for immediate commercial use.', 'Cargo area, Loading ramp, Tie-down points, Commercial registration', NULL, NULL, NULL, NULL, '2025-08-29 16:00:00', '2025-09-07 12:00:00', 420000.00, 435000.00, 0, NULL, 0, NULL, 'available', 1, 0, '2025-08-29 16:00:00', '2025-09-01 16:50:52', NULL, 0),
(33, 2, 'heavy_machinery', NULL, 'auction', 'used', 'Caterpillar', '966H', 'Standard', 2017, 1200000.00, 0, 4500, 'V8 Turbo', '18.1L', 350, 'automatic', 'diesel', 'Yellow', NULL, NULL, 'Limpopo', 'Polokwane', NULL, 'good', 1, 1, 'Extended service plan', 1, 0, 1, 1, 'Heavy-duty Caterpillar 966H wheel loader for auction. Excellent for construction and mining operations. Well-maintained hydraulic systems and powerful engine. Professional operator cabin.', 'Hydraulic systems, Air conditioning, Operator comfort, Heavy-duty construction, Mining ready', NULL, NULL, NULL, NULL, '2025-08-29 18:00:00', '2025-09-04 14:00:00', 1150000.00, 1180000.00, 0, NULL, 0, NULL, 'available', 4, 0, '2025-08-29 18:00:00', '2025-09-01 16:31:58', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_comparisons`
--

CREATE TABLE `vehicle_comparisons` (
  `id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_comparisons`
--

INSERT INTO `vehicle_comparisons` (`id`, `session_id`, `vehicle_id`, `added_at`) VALUES
(1, '6101tns5rqqmktsqg7c1kovf84', 21, '2025-09-01 14:48:20'),
(2, '6101tns5rqqmktsqg7c1kovf84', 30, '2025-09-01 14:48:30'),
(3, '4avjisqiphf8q5ei6v653fmvvn', 21, '2025-09-01 16:24:39');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_documents`
--

CREATE TABLE `vehicle_documents` (
  `document_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `document_path` varchar(255) NOT NULL,
  `document_name` varchar(100) NOT NULL,
  `document_type` enum('pdf') NOT NULL DEFAULT 'pdf',
  `file_size` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_documents`
--

INSERT INTO `vehicle_documents` (`document_id`, `vehicle_id`, `document_path`, `document_name`, `document_type`, `file_size`, `uploaded_at`) VALUES
(2, 2, 'uploads/686b60f476b82_Academic_Report_631.pdf', 'Academic_Report_63 (1).pdf', 'pdf', 1054413, '2025-07-07 05:53:56'),
(3, 9, 'uploads/686b7a32d7540_Academic_Report_631.pdf', 'Academic_Report_63 (1).pdf', 'pdf', 1054413, '2025-07-07 07:41:38'),
(5, 17, 'uploads/686cd1e806315_submission_1.pdf', 'submission_1.pdf', 'pdf', 308649, '2025-07-08 08:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_images`
--

CREATE TABLE `vehicle_images` (
  `image_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `image_order` int(11) DEFAULT 0,
  `is_primary` tinyint(1) DEFAULT 0,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_images`
--

INSERT INTO `vehicle_images` (`image_id`, `vehicle_id`, `image_path`, `image_name`, `file_size`, `image_order`, `is_primary`, `uploaded_at`) VALUES
(4, 2, 'uploads/686b60f471da0_FB_IMG_17488500528065593.jpg', 'FB_IMG_17488500528065593.jpg', 820360, 0, 1, '2025-07-07 05:53:56'),
(5, 2, 'uploads/686b60f473813_FB_IMG_17488500528105831.jpg', 'FB_IMG_17488500528105831.jpg', 820360, 1, 0, '2025-07-07 05:53:56'),
(6, 2, 'uploads/686b60f474112_FB_IMG_17488486925255030.jpg', 'FB_IMG_17488486925255030.jpg', 832932, 2, 0, '2025-07-07 05:53:56'),
(7, 2, 'uploads/686b60f475bec_FB_IMG_17488486785651324.jpg', 'FB_IMG_17488486785651324.jpg', 880244, 3, 0, '2025-07-07 05:53:56'),
(8, 3, 'uploads/686b623de3333_hilux50.webp', 'hilux 50.webp', 30534, 0, 1, '2025-07-07 05:59:25'),
(9, 4, 'uploads/686b66a166d56_cq5dam.web.1280.1280.jpeg', 'cq5dam.web.1280.1280.jpeg', 210549, 0, 1, '2025-07-07 06:18:09'),
(10, 5, 'uploads/686b76bf0978c_cruser.webp', 'cruser.webp', 16516, 0, 1, '2025-07-07 07:26:55'),
(11, 6, 'uploads/686b77a9eca19_-Shacman-Truck-X3000-Tractor--1-.jpg', '-Shacman-Truck-X3000-Tractor--1-.jpg', 62325, 0, 1, '2025-07-07 07:30:49'),
(12, 7, 'uploads/686b7952e66fc_OIP2.webp', 'OIP (2).webp', 7946, 0, 1, '2025-07-07 07:37:54'),
(13, 7, 'uploads/686b7952e88d5_daf.webp', 'daf.webp', 9642, 1, 0, '2025-07-07 07:37:54'),
(14, 8, 'uploads/686b79b9052d3_R.jpeg', 'R.jpeg', 416485, 0, 1, '2025-07-07 07:39:37'),
(15, 9, 'uploads/686b7a32d5788_FB_IMG_17507212006559575.jpg', 'FB_IMG_17507212006559575.jpg', 511478, 0, 1, '2025-07-07 07:41:38'),
(17, 11, 'uploads/686b7a54eebc9_th.webp', 'th.webp', 28346, 0, 1, '2025-07-07 07:42:12'),
(19, 13, 'uploads/686b8b984e34e_th.webp', 'th.webp', 28346, 0, 1, '2025-07-07 08:55:52'),
(20, 14, 'uploads/686b8c0aa7822_0_cl7fc6pt1MHjIF4K.png', '0_cl7fc6pt1MHjIF4K.png', 98531, 0, 1, '2025-07-07 08:57:46'),
(21, 15, 'uploads/686befe42a5ff_istockphoto-805734800-612x612.jpg', 'istockphoto-805734800-612x612.jpg', 47630, 0, 1, '2025-07-07 16:03:48'),
(22, 16, 'uploads/686bf0dd76b18_FB_IMG_17507212033362385.jpg', 'FB_IMG_17507212033362385.jpg', 528389, 0, 1, '2025-07-07 16:07:57'),
(23, 17, 'uploads/686cd1e7f0dbe_FB_IMG_17519616312774392.jpg', 'FB_IMG_17519616312774392.jpg', 627983, 0, 1, '2025-07-08 08:08:07'),
(24, 17, 'uploads/686cd1e7f3ad1_FB_IMG_17519616275347046.jpg', 'FB_IMG_17519616275347046.jpg', 873377, 1, 0, '2025-07-08 08:08:07'),
(25, 17, 'uploads/686cd1e8018e5_FB_IMG_17519615062100971.jpg', 'FB_IMG_17519615062100971.jpg', 489878, 2, 0, '2025-07-08 08:08:08'),
(26, 18, 'uploads/686ce4a3c278f_checkout.png', 'checkout.png', 35217, 0, 1, '2025-07-08 09:28:03'),
(27, 19, 'uploads/686e11ed18022_hilux50.webp', 'hilux 50.webp', 30534, 0, 1, '2025-07-09 06:53:33'),
(28, 20, 'uploads/68729a07e85d0_truck2.jpeg', 'truck2.jpeg', 8815, 0, 1, '2025-07-12 17:23:19'),
(29, 21, 'uploads/68729ab96e2b4_truck.jpeg', 'truck.jpeg', 6636, 0, 1, '2025-07-12 17:26:17'),
(30, 22, 'uploads/6872ace5b5932_1000005381.jpg', '1000005381.jpg', 47051, 0, 1, '2025-07-12 18:43:49'),
(31, 23, 'uploads/68736221de019_1000013877.jpg', '1000013877.jpg', 94199, 0, 1, '2025-07-13 07:37:05'),
(33, 25, 'uploads/6878e7611ae75_1000019271.jpg', '1000019271.jpg', 38830, 0, 1, '2025-07-17 12:06:57'),
(34, 26, 'uploads/6878e7f0c45b0_1000017424.jpg', '1000017424.jpg', 88353, 0, 1, '2025-07-17 12:09:20'),
(35, 27, 'uploads/6878e841e97f1_1000017901.png', '1000017901.png', 842090, 0, 1, '2025-07-17 12:10:41'),
(36, 28, 'uploads/687a2b952f305_th.webp', 'th.webp', 28346, 0, 1, '2025-07-18 11:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_videos`
--

CREATE TABLE `vehicle_videos` (
  `video_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `video_path` varchar(255) NOT NULL,
  `video_title` varchar(100) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `duration_seconds` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_videos`
--

INSERT INTO `vehicle_videos` (`video_id`, `vehicle_id`, `video_path`, `video_title`, `file_size`, `duration_seconds`, `uploaded_at`) VALUES
(2, 2, 'uploads/686b60f4765d3_19dce542cfdc3aa90b4c18c71594d46a_1748921604713.mp4', '19dce542cfdc3aa90b4c18c71594d46a_1748921604713.mp4', 8585739, NULL, '2025-07-07 05:53:56'),
(3, 17, 'uploads/686cd1e802a13_19dce542cfdc3aa90b4c18c71594d46a_1748921604713.mp4', '19dce542cfdc3aa90b4c18c71594d46a_1748921604713.mp4', 8585739, NULL, '2025-07-08 08:08:08');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_approved_submissions`
-- (See below for the actual view)
--
CREATE TABLE `v_approved_submissions` (
`submission_id` int(11)
,`category` varchar(50)
,`make` varchar(100)
,`model` varchar(100)
,`year` int(4)
,`price` decimal(15,2)
,`mileage` int(11)
,`fuel_type` enum('Diesel','Petrol','Electric','Hybrid','LPG','CNG')
,`transmission` enum('Manual','Automatic','Semi-Automatic','CVT')
,`engine_size` varchar(50)
,`description` text
,`city` varchar(100)
,`region` varchar(100)
,`contact_name` varchar(100)
,`contact_email` varchar(100)
,`contact_phone` varchar(20)
,`listing_type` enum('sale','hire','rent-to-own','auction')
,`submission_status` enum('pending','approved','rejected','published')
,`admin_notes` text
,`approved_by` int(11)
,`approved_at` timestamp
,`created_at` timestamp
,`updated_at` timestamp
,`image_count` bigint(21)
,`image_paths` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pending_submissions`
-- (See below for the actual view)
--
CREATE TABLE `v_pending_submissions` (
`submission_id` int(11)
,`category` varchar(50)
,`make` varchar(100)
,`model` varchar(100)
,`year` int(4)
,`price` decimal(15,2)
,`mileage` int(11)
,`fuel_type` enum('Diesel','Petrol','Electric','Hybrid','LPG','CNG')
,`transmission` enum('Manual','Automatic','Semi-Automatic','CVT')
,`engine_size` varchar(50)
,`description` text
,`city` varchar(100)
,`region` varchar(100)
,`contact_name` varchar(100)
,`contact_email` varchar(100)
,`contact_phone` varchar(20)
,`listing_type` enum('sale','hire','rent-to-own','auction')
,`submission_status` enum('pending','approved','rejected','published')
,`admin_notes` text
,`approved_by` int(11)
,`approved_at` timestamp
,`created_at` timestamp
,`updated_at` timestamp
,`image_count` bigint(21)
,`image_paths` mediumtext
);

-- --------------------------------------------------------

--
-- Structure for view `v_approved_submissions`
--
DROP TABLE IF EXISTS `v_approved_submissions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_approved_submissions`  AS SELECT `s`.`submission_id` AS `submission_id`, `s`.`category` AS `category`, `s`.`make` AS `make`, `s`.`model` AS `model`, `s`.`year` AS `year`, `s`.`price` AS `price`, `s`.`mileage` AS `mileage`, `s`.`fuel_type` AS `fuel_type`, `s`.`transmission` AS `transmission`, `s`.`engine_size` AS `engine_size`, `s`.`description` AS `description`, `s`.`city` AS `city`, `s`.`region` AS `region`, `s`.`contact_name` AS `contact_name`, `s`.`contact_email` AS `contact_email`, `s`.`contact_phone` AS `contact_phone`, `s`.`listing_type` AS `listing_type`, `s`.`submission_status` AS `submission_status`, `s`.`admin_notes` AS `admin_notes`, `s`.`approved_by` AS `approved_by`, `s`.`approved_at` AS `approved_at`, `s`.`created_at` AS `created_at`, `s`.`updated_at` AS `updated_at`, count(`i`.`image_id`) AS `image_count`, group_concat(`i`.`image_path` order by `i`.`is_primary` DESC,`i`.`image_order` ASC separator ',') AS `image_paths` FROM (`frontend_vehicle_submissions` `s` left join `frontend_submission_images` `i` on(`s`.`submission_id` = `i`.`submission_id`)) WHERE `s`.`submission_status` = 'approved' GROUP BY `s`.`submission_id` ORDER BY `s`.`approved_at` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_pending_submissions`
--
DROP TABLE IF EXISTS `v_pending_submissions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pending_submissions`  AS SELECT `s`.`submission_id` AS `submission_id`, `s`.`category` AS `category`, `s`.`make` AS `make`, `s`.`model` AS `model`, `s`.`year` AS `year`, `s`.`price` AS `price`, `s`.`mileage` AS `mileage`, `s`.`fuel_type` AS `fuel_type`, `s`.`transmission` AS `transmission`, `s`.`engine_size` AS `engine_size`, `s`.`description` AS `description`, `s`.`city` AS `city`, `s`.`region` AS `region`, `s`.`contact_name` AS `contact_name`, `s`.`contact_email` AS `contact_email`, `s`.`contact_phone` AS `contact_phone`, `s`.`listing_type` AS `listing_type`, `s`.`submission_status` AS `submission_status`, `s`.`admin_notes` AS `admin_notes`, `s`.`approved_by` AS `approved_by`, `s`.`approved_at` AS `approved_at`, `s`.`created_at` AS `created_at`, `s`.`updated_at` AS `updated_at`, count(`i`.`image_id`) AS `image_count`, group_concat(`i`.`image_path` order by `i`.`is_primary` DESC,`i`.`image_order` ASC separator ',') AS `image_paths` FROM (`frontend_vehicle_submissions` `s` left join `frontend_submission_images` `i` on(`s`.`submission_id` = `i`.`submission_id`)) WHERE `s`.`submission_status` = 'pending' GROUP BY `s`.`submission_id` ORDER BY `s`.`created_at` DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin` (`admin_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD PRIMARY KEY (`bid_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_bid_time` (`bid_time`),
  ADD KEY `idx_amount` (`bid_amount`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_key` (`category_key`),
  ADD KEY `idx_listing_type` (`listing_type`),
  ADD KEY `idx_parent_category` (`parent_category`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `category_makes`
--
ALTER TABLE `category_makes`
  ADD PRIMARY KEY (`make_id`),
  ADD UNIQUE KEY `unique_make` (`category_id`,`make_name`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `category_models`
--
ALTER TABLE `category_models`
  ADD PRIMARY KEY (`model_id`),
  ADD UNIQUE KEY `unique_model` (`make_id`,`model_name`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `category_variants`
--
ALTER TABLE `category_variants`
  ADD PRIMARY KEY (`variant_id`),
  ADD UNIQUE KEY `unique_variant` (`model_id`,`variant_name`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `comparison_analytics`
--
ALTER TABLE `comparison_analytics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_vehicle` (`vehicle_id`),
  ADD KEY `idx_comparison_count` (`comparison_count`),
  ADD KEY `idx_last_compared` (`last_compared`);

--
-- Indexes for table `dealership_limits`
--
ALTER TABLE `dealership_limits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dealership` (`dealership_id`),
  ADD KEY `idx_dealership` (`dealership_id`);

--
-- Indexes for table `dealer_ad_analytics`
--
ALTER TABLE `dealer_ad_analytics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dealer_ad_date` (`dealer_id`,`ad_id`,`date`),
  ADD KEY `idx_dealer_id` (`dealer_id`),
  ADD KEY `idx_ad_id` (`ad_id`),
  ADD KEY `idx_date` (`date`);

--
-- Indexes for table `dealer_ad_limits`
--
ALTER TABLE `dealer_ad_limits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dealer` (`dealer_id`),
  ADD KEY `idx_dealer` (`dealer_id`);

--
-- Indexes for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_region` (`region`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `dealer_finance_options`
--
ALTER TABLE `dealer_finance_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `dealer_id` (`dealer_id`);

--
-- Indexes for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `finance_applications`
--
ALTER TABLE `finance_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `dealer_id` (`dealer_id`);

--
-- Indexes for table `finance_billing`
--
ALTER TABLE `finance_billing`
  ADD PRIMARY KEY (`billing_id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `dealer_id` (`dealer_id`);

--
-- Indexes for table `frontend_submission_images`
--
ALTER TABLE `frontend_submission_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_submission_id` (`submission_id`),
  ADD KEY `idx_is_primary` (`is_primary`),
  ADD KEY `idx_frontend_images_compound` (`submission_id`,`is_primary`,`image_order`);

--
-- Indexes for table `frontend_vehicle_submissions`
--
ALTER TABLE `frontend_vehicle_submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `idx_submission_status` (`submission_status`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_approved_by` (`approved_by`),
  ADD KEY `idx_frontend_submissions_compound` (`submission_status`,`created_at`,`category`);

--
-- Indexes for table `hero_images`
--
ALTER TABLE `hero_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`inquiry_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_type` (`inquiry_type`);

--
-- Indexes for table `pickup_locations`
--
ALTER TABLE `pickup_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_location_type` (`location_type`),
  ADD KEY `idx_city` (`city`),
  ADD KEY `idx_province` (`province`),
  ADD KEY `idx_airport_code` (`airport_code`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `premium_ads`
--
ALTER TABLE `premium_ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ad_type` (`ad_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_position` (`position`),
  ADD KEY `idx_display_order` (`display_order`),
  ADD KEY `idx_owner` (`ad_owner_type`,`ad_owner_id`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

--
-- Indexes for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  ADD PRIMARY KEY (`bg_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

--
-- Indexes for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session_vehicle` (`session_id`,`vehicle_id`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_vehicle_id` (`vehicle_id`),
  ADD KEY `idx_viewed_at` (`viewed_at`);

--
-- Indexes for table `rent_to_own_bookings`
--
ALTER TABLE `rent_to_own_bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`subcategory_id`),
  ADD UNIQUE KEY `unique_subcategory` (`category_id`,`subcategory_key`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `submission_notifications`
--
ALTER TABLE `submission_notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_submission_id` (`submission_id`),
  ADD KEY `idx_notification_type` (`notification_type`),
  ADD KEY `idx_sent_at` (`sent_at`);

--
-- Indexes for table `submission_reviews`
--
ALTER TABLE `submission_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `idx_submission_id` (`submission_id`),
  ADD KEY `idx_reviewer_id` (`reviewer_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`);

--
-- Indexes for table `system_years`
--
ALTER TABLE `system_years`
  ADD PRIMARY KEY (`year_id`),
  ADD UNIQUE KEY `year_value` (`year_value`),
  ADD KEY `idx_year` (`year_value`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_reset_token` (`password_reset_token`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_listing_type` (`listing_type`),
  ADD KEY `idx_condition_type` (`condition_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_region` (`region`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_featured` (`featured`),
  ADD KEY `idx_premium` (`premium_listing`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_price` (`price`),
  ADD KEY `idx_year` (`year`);
ALTER TABLE `vehicles` ADD FULLTEXT KEY `idx_search` (`make`,`model`,`description`,`features`);

--
-- Indexes for table `vehicle_comparisons`
--
ALTER TABLE `vehicle_comparisons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session_vehicle` (`session_id`,`vehicle_id`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_vehicle_id` (`vehicle_id`),
  ADD KEY `idx_added_at` (`added_at`);

--
-- Indexes for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_type` (`document_type`);

--
-- Indexes for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_primary` (`is_primary`),
  ADD KEY `idx_order` (`image_order`);

--
-- Indexes for table `vehicle_videos`
--
ALTER TABLE `vehicle_videos`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `auction_bids`
--
ALTER TABLE `auction_bids`
  MODIFY `bid_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=623;

--
-- AUTO_INCREMENT for table `category_makes`
--
ALTER TABLE `category_makes`
  MODIFY `make_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `category_models`
--
ALTER TABLE `category_models`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `category_variants`
--
ALTER TABLE `category_variants`
  MODIFY `variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `comparison_analytics`
--
ALTER TABLE `comparison_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dealership_limits`
--
ALTER TABLE `dealership_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `dealer_ad_analytics`
--
ALTER TABLE `dealer_ad_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealer_ad_limits`
--
ALTER TABLE `dealer_ad_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealer_finance_options`
--
ALTER TABLE `dealer_finance_options`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `finance_applications`
--
ALTER TABLE `finance_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_billing`
--
ALTER TABLE `finance_billing`
  MODIFY `billing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frontend_submission_images`
--
ALTER TABLE `frontend_submission_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frontend_vehicle_submissions`
--
ALTER TABLE `frontend_vehicle_submissions`
  MODIFY `submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hero_images`
--
ALTER TABLE `hero_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pickup_locations`
--
ALTER TABLE `pickup_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `premium_ads`
--
ALTER TABLE `premium_ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  MODIFY `bg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `rent_to_own_bookings`
--
ALTER TABLE `rent_to_own_bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `subcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `submission_notifications`
--
ALTER TABLE `submission_notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_reviews`
--
ALTER TABLE `submission_reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2969;

--
-- AUTO_INCREMENT for table `system_years`
--
ALTER TABLE `system_years`
  MODIFY `year_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `vehicle_comparisons`
--
ALTER TABLE `vehicle_comparisons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `vehicle_videos`
--
ALTER TABLE `vehicle_videos`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD CONSTRAINT `auction_bids_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `category_makes`
--
ALTER TABLE `category_makes`
  ADD CONSTRAINT `category_makes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `category_models`
--
ALTER TABLE `category_models`
  ADD CONSTRAINT `category_models_ibfk_1` FOREIGN KEY (`make_id`) REFERENCES `category_makes` (`make_id`) ON DELETE CASCADE;

--
-- Constraints for table `category_variants`
--
ALTER TABLE `category_variants`
  ADD CONSTRAINT `category_variants_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `category_models` (`model_id`) ON DELETE CASCADE;

--
-- Constraints for table `comparison_analytics`
--
ALTER TABLE `comparison_analytics`
  ADD CONSTRAINT `comparison_analytics_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  ADD CONSTRAINT `dealer_branches_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `dealer_finance_options`
--
ALTER TABLE `dealer_finance_options`
  ADD CONSTRAINT `dealer_finance_options_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  ADD CONSTRAINT `dealer_sales_team_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `finance_applications`
--
ALTER TABLE `finance_applications`
  ADD CONSTRAINT `finance_applications_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `finance_applications_ibfk_2` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `finance_billing`
--
ALTER TABLE `finance_billing`
  ADD CONSTRAINT `finance_billing_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `finance_applications` (`application_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `finance_billing_ibfk_2` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `frontend_submission_images`
--
ALTER TABLE `frontend_submission_images`
  ADD CONSTRAINT `frontend_submission_images_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `frontend_vehicle_submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `hero_images`
--
ALTER TABLE `hero_images`
  ADD CONSTRAINT `hero_images_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  ADD CONSTRAINT `hire_bookings_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD CONSTRAINT `inquiries_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inquiries_ibfk_2` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  ADD CONSTRAINT `recently_viewed_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `rent_to_own_bookings`
--
ALTER TABLE `rent_to_own_bookings`
  ADD CONSTRAINT `rent_to_own_bookings_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_notifications`
--
ALTER TABLE `submission_notifications`
  ADD CONSTRAINT `submission_notifications_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `frontend_vehicle_submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_reviews`
--
ALTER TABLE `submission_reviews`
  ADD CONSTRAINT `submission_reviews_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `frontend_vehicle_submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vehicles_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `dealer_branches` (`branch_id`) ON DELETE SET NULL;

--
-- Constraints for table `vehicle_comparisons`
--
ALTER TABLE `vehicle_comparisons`
  ADD CONSTRAINT `vehicle_comparisons_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  ADD CONSTRAINT `vehicle_documents_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  ADD CONSTRAINT `vehicle_images_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicle_videos`
--
ALTER TABLE `vehicle_videos`
  ADD CONSTRAINT `vehicle_videos_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
