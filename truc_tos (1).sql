-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 24, 2025 at 09:43 AM
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
(57, 1, 'CREATE_AD', 'premium_ads', 9, 'Created premium ad: eff', '45.215.255.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-18 22:19:45'),
(58, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 22:25:32'),
(59, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-18 23:20:06'),
(60, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:27:29'),
(61, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:28:11'),
(62, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:35:19'),
(63, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:35:39'),
(64, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:36:48'),
(65, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 2, 'Updated limits for dealer ID: 2', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:37:19'),
(66, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:37:21'),
(67, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 2, 'Updated limits for dealer ID: 2', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:41:04'),
(68, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:41:12'),
(69, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:42:16'),
(70, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:42:19'),
(71, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.46', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Mobile Safari/537.36', '2025-07-18 23:44:13'),
(72, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-19 05:29:35'),
(73, 1, 'SET_FEATURED', 'vehicle', 17, 'Updated featured status', '45.215.253.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-20 04:40:32'),
(74, 1, 'SET_FEATURED', 'vehicle', 28, 'Updated featured status', '45.215.253.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-20 04:40:38'),
(75, 1, 'CREATE_AD', 'premium_ads', 10, 'Created premium ad: Hino', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 12:52:43'),
(76, 1, 'DELETE_AD', 'premium_ads', 10, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 12:54:18'),
(77, 1, 'CREATE_AD', 'premium_ads', 11, 'Created premium ad: az', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 12:54:46'),
(78, 1, 'CREATE_MAKE', 'make', 28, 'Created make: Shacman', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 13:44:53'),
(79, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 13:55:47'),
(80, 1, 'CREATE_MODEL', 'model', 85, 'Created model: F3000', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 14:00:32'),
(81, 1, 'CREATE_VARIANT', 'variant', 71, 'Created variant: 6x6 400hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 14:02:03'),
(82, 1, 'CREATE_AD', 'premium_ads', 12, 'Created premium ad: tru', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-20 20:07:34'),
(83, 1, 'DELETE_AD', 'premium_ads', 11, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-20 20:09:03'),
(84, 1, 'DELETE_AD', 'premium_ads', 2, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:12:02'),
(85, 1, 'DELETE_AD', 'premium_ads', 6, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:12:43'),
(86, 1, 'DELETE_AD', 'premium_ads', 7, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:12:50'),
(87, 1, 'DELETE_AD', 'premium_ads', 9, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:12:57'),
(88, 1, 'DELETE_AD', 'premium_ads', 8, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:13:04'),
(89, 1, 'DELETE_AD', 'premium_ads', 3, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:13:15'),
(90, 1, 'DELETE_AD', 'premium_ads', 4, 'Deleted premium ad', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:13:22'),
(91, 1, 'CREATE_AD', 'premium_ads', 13, 'Created premium ad: fgfg', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:18:00'),
(92, 1, 'CREATE_AD', 'premium_ads', 14, 'Created premium ad: tuyeyrey', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:31:40'),
(93, 1, 'CREATE_AD', 'premium_ads', 15, 'Created premium ad: Hino', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-07-20 20:34:46'),
(94, 1, 'CREATE_AD', 'premium_ads', 16, 'Created premium ad: ggy', '45.215.253.21', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-21 05:54:12'),
(95, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.21', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-21 05:54:15'),
(96, 1, 'CREATE_MODEL', 'model', 87, 'Created model: X3000', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:43:43'),
(97, 1, 'CREATE_MODEL', 'model', 88, 'Created model: X6000', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:44:07'),
(98, 1, 'CREATE_MODEL', 'model', 89, 'Created model: L3000', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:44:19'),
(99, 1, 'CREATE_VARIANT', 'variant', 72, 'Created variant: 420hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:45:48'),
(100, 1, 'CREATE_VARIANT', 'variant', 73, 'Created variant: 430hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:45:59'),
(101, 1, 'CREATE_VARIANT', 'variant', 74, 'Created variant: 450hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:46:09'),
(102, 1, 'CREATE_VARIANT', 'variant', 75, 'Created variant: 480hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:46:24'),
(103, 1, 'CREATE_VARIANT', 'variant', 76, 'Created variant: 560hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:46:33'),
(104, 1, 'CREATE_VARIANT', 'variant', 77, 'Created variant: 480hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:47:05'),
(105, 1, 'CREATE_VARIANT', 'variant', 78, 'Created variant: 560hp', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 14:47:16'),
(106, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-22 18:57:38'),
(107, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 11, 'Updated limits for dealer ID: 11', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 19:55:27'),
(108, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 19:55:31'),
(109, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 19:58:25'),
(110, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 19:58:39'),
(111, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 20:00:38'),
(112, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 20:00:43'),
(113, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-22 20:09:22'),
(114, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 20:22:54'),
(115, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.255.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-22 20:23:00'),
(116, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 3, 'Updated limits for dealer ID: 3', '105.242.228.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-23 06:20:24'),
(117, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.221', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-23 06:56:06'),
(118, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 10, 'Updated limits for dealer ID: 10', '45.215.253.221', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-23 06:56:41'),
(119, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '45.215.253.221', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-23 06:56:44'),
(120, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-26 10:09:07'),
(121, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', '2025-07-26 11:11:11'),
(122, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.206', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-26 11:42:34'),
(123, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.206', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-26 20:08:05'),
(124, 1, 'CREATE_VARIANT', 'variant', 79, 'Created variant: 240', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-27 12:11:40'),
(125, 1, 'CREATE_MAKE', 'make', 29, 'Created make: Powerstar', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-27 12:27:29'),
(126, 1, 'CREATE_MODEL', 'model', 90, 'Created model: 2642', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-27 12:28:11'),
(127, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 05:16:39'),
(128, 1, 'CREATE_SUBCATEGORY', 'subcategory', 10, 'Created subcategory: Bakkies', '105.243.17.142', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-28 05:20:40'),
(129, 1, 'CREATE_MAKE', 'make', 30, 'Created make: Ford', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 05:33:16'),
(130, 1, 'CREATE_SUBCATEGORY', 'subcategory', 12, 'Created subcategory: LDV & Panel Vans', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 07:13:36'),
(131, 1, 'CREATE_MODEL', 'model', 91, 'Created model: Ranger', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-28 09:22:04'),
(132, 1, 'CREATE_MAKE', 'make', 32, 'Created make: Benz', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-28 09:22:44'),
(133, 1, 'CREATE_MODEL', 'model', 92, 'Created model: C200', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-28 09:23:06'),
(134, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-07-28 09:23:34'),
(135, 1, 'CREATE_MAKE', 'make', 33, 'Created make: Mercedes', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 10:24:08'),
(136, 1, 'CREATE_MODEL', 'model', 93, 'Created model: Hilux', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:17:13'),
(137, 1, 'CREATE_MODEL', 'model', 94, 'Created model: Land Cruiser', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:18:13'),
(138, 1, 'CREATE_MODEL', 'model', 96, 'Created model: Fortuner', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:21:56'),
(139, 1, 'CREATE_MODEL', 'model', 97, 'Created model: SUV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:22:06'),
(140, 1, 'CREATE_VARIANT', 'variant', 80, 'Created variant: 2.4GD-6', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:31:43'),
(141, 1, 'CREATE_VARIANT', 'variant', 81, 'Created variant: 2.8GD-6', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:32:03'),
(142, 1, 'CREATE_VARIANT', 'variant', 83, 'Created variant: 2.8GD-6 GR-Sport', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:36:09'),
(143, 1, 'CREATE_VARIANT', 'variant', 84, 'Created variant: 2.8 D-6 RB Raider 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:38:14'),
(144, 1, 'CREATE_VARIANT', 'variant', 85, 'Created variant: 2.8 D-6 4x4 Raider 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:38:39'),
(145, 1, 'CREATE_VARIANT', 'variant', 86, 'Created variant: 2.8 D-6 RB Legend 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:39:23'),
(146, 1, 'CREATE_VARIANT', 'variant', 87, 'Created variant: 2.8 D-6 RB Legend RS 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:39:53'),
(147, 1, 'CREATE_VARIANT', 'variant', 88, 'Created variant: 2.8 D-6 4x4 Legend RS 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:41:09'),
(148, 1, 'CREATE_VARIANT', 'variant', 89, 'Created variant: 2.8 GD-6 4x4 Legend RS 6AT MHEV', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 11:42:05'),
(149, 1, 'SET_FEATURED', 'vehicle', 8, 'Updated featured status', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 12:29:55'),
(150, 1, 'SET_FEATURED', 'vehicle', 19, 'Updated featured status', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 12:30:07'),
(151, 1, 'SET_FEATURED', 'vehicle', 9, 'Updated featured status', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-28 12:30:24'),
(152, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', '2025-07-28 19:45:01'),
(153, 1, 'UPDATE_CATEGORY', 'category', 1, 'Updated category: Trucks', '102.208.220.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-31 10:20:29'),
(154, 1, 'CREATE_AD', 'premium_ads', 17, 'Created premium ad: test', '102.208.220.202', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-31 10:22:11'),
(155, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-31 10:22:36'),
(156, 1, 'UPDATE_DEALER_LIMITS', 'dealer', 13, 'Updated limits for dealer ID: 13', '102.208.220.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-07-31 10:32:50'),
(157, 1, 'DELETE_LISTING', 'vehicle', 2, 'Deleted vehicle listing', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-08-01 03:32:31'),
(158, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-08-01 03:34:58'),
(159, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', '2025-08-02 09:01:17'),
(160, 1, 'CREATE_SUBCATEGORY', 'subcategory', 13, 'Created subcategory: Truck Tractors', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 15:57:38'),
(161, 1, 'CREATE_SUBCATEGORY', 'subcategory', 14, 'Created subcategory: Dropside Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 15:59:17'),
(162, 1, 'CREATE_SUBCATEGORY', 'subcategory', 15, 'Created subcategory: Tipper Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:00:20'),
(163, 1, 'CREATE_SUBCATEGORY', 'subcategory', 16, 'Created subcategory: Chassis Cab Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:01:20'),
(164, 1, 'CREATE_SUBCATEGORY', 'subcategory', 17, 'Created subcategory: Truck', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:02:45'),
(165, 1, 'CREATE_SUBCATEGORY', 'subcategory', 18, 'Created subcategory: Box Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:03:25'),
(166, 1, 'CREATE_SUBCATEGORY', 'subcategory', 19, 'Created subcategory: Refrigerated Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:05:06'),
(167, 1, 'CREATE_SUBCATEGORY', 'subcategory', 20, 'Created subcategory: Water Bowser Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:06:25'),
(168, 1, 'CREATE_SUBCATEGORY', 'subcategory', 21, 'Created subcategory: Crane Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:07:13'),
(169, 1, 'CREATE_SUBCATEGORY', 'subcategory', 22, 'Created subcategory: Curtain Side Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:07:58'),
(170, 1, 'CREATE_SUBCATEGORY', 'subcategory', 23, 'Created subcategory: Garbage Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:08:46'),
(171, 1, 'CREATE_SUBCATEGORY', 'subcategory', 24, 'Created subcategory: Other Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:09:32'),
(172, 1, 'CREATE_SUBCATEGORY', 'subcategory', 25, 'Created subcategory: Rollback Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:10:46'),
(173, 1, 'CREATE_SUBCATEGORY', 'subcategory', 26, 'Created subcategory: Flatbed Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:11:23'),
(174, 1, 'CREATE_SUBCATEGORY', 'subcategory', 27, 'Created subcategory: Concrete Mixer Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:12:24'),
(175, 1, 'CREATE_SUBCATEGORY', 'subcategory', 28, 'Created subcategory: Rigid Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:13:09'),
(176, 1, 'CREATE_SUBCATEGORY', 'subcategory', 29, 'Created subcategory: Skip Bin Loader Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:14:24'),
(177, 1, 'CREATE_SUBCATEGORY', 'subcategory', 30, 'Created subcategory: Tanker Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:15:25'),
(178, 1, 'CREATE_SUBCATEGORY', 'subcategory', 31, 'Created subcategory: Cattle Body Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:16:09'),
(179, 1, 'CREATE_SUBCATEGORY', 'subcategory', 32, 'Created subcategory: Fire Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:17:13'),
(180, 1, 'CREATE_SUBCATEGORY', 'subcategory', 33, 'Created subcategory: Honey Sucker Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:18:16'),
(181, 1, 'CREATE_SUBCATEGORY', 'subcategory', 34, 'Created subcategory: Personnel Carrier Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:25:46'),
(182, 1, 'CREATE_SUBCATEGORY', 'subcategory', 35, 'Created subcategory: Cherry Picker Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:27:03'),
(183, 1, 'CREATE_SUBCATEGORY', 'subcategory', 36, 'Created subcategory: Hooklift Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:27:44'),
(184, 1, 'CREATE_SUBCATEGORY', 'subcategory', 37, 'Created subcategory: Recovery Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:28:34'),
(185, 1, 'CREATE_SUBCATEGORY', 'subcategory', 38, 'Created subcategory: Cage Bodies Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:29:59'),
(186, 1, 'CREATE_SUBCATEGORY', 'subcategory', 39, 'Created subcategory: Water Sprinkler Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:30:48'),
(187, 1, 'CREATE_SUBCATEGORY', 'subcategory', 40, 'Created subcategory: Gas Cylinder Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:31:44'),
(188, 1, 'CREATE_SUBCATEGORY', 'subcategory', 41, 'Created subcategory: Mass Side Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:32:30'),
(189, 1, 'CREATE_SUBCATEGORY', 'subcategory', 42, 'Created subcategory: Crew Cab', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:33:23'),
(190, 1, 'CREATE_SUBCATEGORY', 'subcategory', 43, 'Created subcategory: Double Cab Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:34:18'),
(191, 1, 'CREATE_SUBCATEGORY', 'subcategory', 44, 'Created subcategory: Bullnose Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:35:09'),
(192, 1, 'CREATE_SUBCATEGORY', 'subcategory', 45, 'Created subcategory: Concrete Pump Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:35:52'),
(193, 1, 'CREATE_SUBCATEGORY', 'subcategory', 46, 'Created subcategory: Horse Box Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:36:44'),
(194, 1, 'CREATE_SUBCATEGORY', 'subcategory', 47, 'Created subcategory: Road Sweeper Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:37:29'),
(195, 1, 'CREATE_SUBCATEGORY', 'subcategory', 48, 'Created subcategory: Car Carrier Trucks', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:38:23'),
(196, 1, 'CREATE_SUBCATEGORY', 'subcategory', 49, 'Created subcategory: Tail Lifts', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-08 16:39:21'),
(197, 1, 'CREATE_SUBCATEGORY', 'subcategory', 50, 'Created subcategory: Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 02:53:41'),
(198, 1, 'CREATE_SUBCATEGORY', 'subcategory', 51, 'Created subcategory: Side Tipper', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 02:58:11'),
(199, 1, 'CREATE_SUBCATEGORY', 'subcategory', 52, 'Created subcategory: Fuel Tanker', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 02:59:17'),
(200, 1, 'CREATE_SUBCATEGORY', 'subcategory', 53, 'Created subcategory: Diesel Bowser Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:01:54'),
(201, 1, 'CREATE_SUBCATEGORY', 'subcategory', 54, 'Created subcategory: Drawbar', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:03:09'),
(202, 1, 'CREATE_SUBCATEGORY', 'subcategory', 55, 'Created subcategory: Superlink', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:04:08'),
(203, 1, 'CREATE_SUBCATEGORY', 'subcategory', 56, 'Created subcategory: Tautliner Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:05:13'),
(204, 1, 'CREATE_SUBCATEGORY', 'subcategory', 57, 'Created subcategory: Box Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:06:00'),
(205, 1, 'CREATE_SUBCATEGORY', 'subcategory', 58, 'Created subcategory: Lowbeds', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:08:21'),
(206, 1, 'CREATE_SUBCATEGORY', 'subcategory', 59, 'Created subcategory: Stepdeck', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:09:20'),
(207, 1, 'CREATE_SUBCATEGORY', 'subcategory', 60, 'Created subcategory: Water Bowser Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:10:43'),
(208, 1, 'CREATE_SUBCATEGORY', 'subcategory', 61, 'Created subcategory: Diesel Tankers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:11:56'),
(209, 1, 'CREATE_SUBCATEGORY', 'subcategory', 62, 'Created subcategory: Tri-Axel Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:14:52'),
(210, 1, 'CREATE_SUBCATEGORY', 'subcategory', 63, 'Created subcategory: Two-Axel Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:16:17'),
(211, 1, 'CREATE_SUBCATEGORY', 'subcategory', 64, 'Created subcategory: Fuel Bowsers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:17:22'),
(212, 1, 'CREATE_SUBCATEGORY', 'subcategory', 65, 'Created subcategory: Cattle Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:18:08'),
(213, 1, 'CREATE_SUBCATEGORY', 'subcategory', 66, 'Created subcategory: Interlink', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:18:43'),
(214, 1, 'CREATE_SUBCATEGORY', 'subcategory', 67, 'Created subcategory: Truck Bodies', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:20:54'),
(215, 1, 'CREATE_SUBCATEGORY', 'subcategory', 68, 'Created subcategory: Welldeck', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:21:53'),
(216, 1, 'CREATE_SUBCATEGORY', 'subcategory', 69, 'Created subcategory: Farm Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:22:41'),
(217, 1, 'CREATE_SUBCATEGORY', 'subcategory', 70, 'Created subcategory: Advertising Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:28:43'),
(218, 1, 'CREATE_SUBCATEGORY', 'subcategory', 71, 'Created subcategory: Goose Neck', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:29:38'),
(219, 1, 'CREATE_SUBCATEGORY', 'subcategory', 72, 'Created subcategory: Cold Room Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:31:58');
INSERT INTO `admin_activity_log` (`id`, `admin_id`, `action`, `target_type`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`) VALUES
(220, 1, 'CREATE_SUBCATEGORY', 'subcategory', 73, 'Created subcategory: General Purpose Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:33:08'),
(221, 1, 'CREATE_SUBCATEGORY', 'subcategory', 74, 'Created subcategory: Pantech Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:34:10'),
(222, 1, 'CREATE_SUBCATEGORY', 'subcategory', 75, 'Created subcategory: Car Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:34:57'),
(223, 1, 'CREATE_SUBCATEGORY', 'subcategory', 76, 'Created subcategory: Game Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:35:32'),
(224, 1, 'CREATE_SUBCATEGORY', 'subcategory', 77, 'Created subcategory: Generator Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:36:50'),
(225, 1, 'CREATE_SUBCATEGORY', 'subcategory', 78, 'Created subcategory: LPG Tanker', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:38:26'),
(226, 1, 'CREATE_SUBCATEGORY', 'subcategory', 79, 'Created subcategory: Luggage Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:39:32'),
(227, 1, 'CREATE_SUBCATEGORY', 'subcategory', 80, 'Created subcategory: Rigid Reefers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:40:48'),
(228, 1, 'CREATE_SUBCATEGORY', 'subcategory', 81, 'Created subcategory: Sheep Trailers', '105.243.17.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2025-08-09 03:41:42'),
(229, 1, 'DELETE_DEALER', 'dealer', 12, 'Permanently deleted dealer: B', '102.208.220.206', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-08-09 07:02:47'),
(230, 1, 'DELETE_LISTING', 'vehicle', 14, 'Deleted vehicle listing', '102.208.220.206', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2025-08-09 07:03:12'),
(231, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-09 16:46:16'),
(232, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-10 09:31:44'),
(233, 1, 'CREATE_AD', 'premium_ads', 18, 'Created premium ad: lesa', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-10 10:43:56'),
(234, 1, 'DELETE_AD', 'premium_ads', 18, 'Deleted premium ad', '102.208.220.204', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-10 13:03:23'),
(235, 1, 'CREATE_AD', 'premium_ads', 19, 'Created premium ad: io', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-10 13:04:52'),
(236, 1, 'CREATE_AD', 'premium_ads', 20, 'Created premium ad: glams', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-10 13:16:20'),
(237, 1, 'DELETE_AD', 'premium_ads', 19, 'Deleted premium ad', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-10 15:45:51'),
(238, 1, 'DELETE_AD', 'premium_ads', 20, 'Deleted premium ad', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-10 15:46:04'),
(239, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-11 06:28:22'),
(240, 1, 'DELETE_DEALER', 'dealer', 13, 'Permanently deleted dealer: Lesa', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-12 14:54:23'),
(241, 1, 'DELETE_LISTING', 'vehicle', 17, 'Deleted vehicle listing', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-12 14:55:01'),
(242, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-12 14:58:23'),
(243, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-16 16:30:41'),
(244, 1, 'LOGOUT', NULL, NULL, 'Admin logged out', '102.208.220.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:55:36');

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
  `category_image` varchar(255) DEFAULT NULL,
  `image_alt_text` varchar(255) DEFAULT NULL,
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

INSERT INTO `categories` (`category_id`, `category_key`, `category_name`, `parent_category`, `listing_type`, `icon`, `category_image`, `image_alt_text`, `listing_label`, `mileage_label`, `engine_label`, `show_transmission`, `show_fuel_type`, `show_year`, `show_hours`, `transmission_options`, `fuel_options`, `additional_fields`, `category_order`, `status`, `created_at`, `updated_at`, `is_premium`) VALUES
(1, 'trucks', 'Trucks', NULL, 'sale', 'fas fa-truck', 'uploads/categories/trucks_1753957229.jpeg', 'Commercial trucks and heavy duty vehicles', 'List Your Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 1, 'active', '2025-07-07 03:09:28', '2025-07-31 10:20:29', 0),
(2, 'trailers', 'Trailers', NULL, 'sale', 'fas fa-trailer', 'uploads/categories/trailers.jpg', 'Trailers and transport equipment', 'List Your Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 2, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(3, 'buses', 'Buses', NULL, 'sale', 'fas fa-bus', 'uploads/categories/buses.jpg', 'Buses and passenger transport', 'List Your Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 3, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(4, 'commercial_vehicles', 'Commercial Vehicles', NULL, 'sale', 'fas fa-van-shuttle', 'uploads/categories/commercial_vehicles.jpg', 'Commercial vehicles and delivery trucks', 'List Your Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 4, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(5, 'farm_equipment', 'Farm Equipment', NULL, 'sale', 'fas fa-tractor', 'uploads/categories/farm_equipment.jpg', 'Farm equipment and agricultural machinery', 'List Your Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 5, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(6, 'heavy_machinery', 'Heavy Machinery', NULL, 'sale', 'fas fa-cogs', 'uploads/categories/heavy_machinery.jpg', 'Heavy machinery and construction equipment', 'List Your Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 6, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(7, 'animal_farming_equipment', 'Animal Farming Equipment', NULL, 'sale', 'fas fa-cow', 'uploads/categories/animal_farming.jpg', 'Animal farming equipment and livestock tools', 'List Your Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 7, 'active', '2025-07-07 03:09:28', '2025-07-30 15:04:03', 0),
(8, 'rent-to-own_trucks', 'Trucks (Rent To Own)', NULL, 'rent-to-own', 'fas fa-truck', NULL, NULL, 'Rent To Own: Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 8, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(9, 'rent-to-own_trailers', 'Trailers (Rent To Own)', NULL, 'rent-to-own', 'fas fa-trailer', NULL, NULL, 'Rent To Own: Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 9, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(10, 'rent-to-own_buses', 'Buses (Rent To Own)', NULL, 'rent-to-own', 'fas fa-bus', NULL, NULL, 'Rent To Own: Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 10, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(11, 'rent-to-own_commercial_vehicles', 'Commercial Vehicles (Rent To Own)', NULL, 'rent-to-own', 'fas fa-van-shuttle', NULL, NULL, 'Rent To Own: Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 11, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(12, 'rent-to-own_farm_equipment', 'Farm Equipment (Rent To Own)', NULL, 'rent-to-own', 'fas fa-tractor', NULL, NULL, 'Rent To Own: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 12, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(13, 'rent-to-own_heavy_machinery', 'Heavy Machinery (Rent To Own)', NULL, 'rent-to-own', 'fas fa-cogs', NULL, NULL, 'Rent To Own: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 13, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(14, 'rent-to-own_animal_farming_equipment', 'Animal Farming Equipment (Rent To Own)', NULL, 'rent-to-own', 'fas fa-cow', NULL, NULL, 'Rent To Own: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 14, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(15, 'hire_trucks', 'Trucks (Hire)', NULL, 'hire', 'fas fa-truck', NULL, NULL, 'Hire: Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 15, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(16, 'hire_trailers', 'Trailers (Hire)', NULL, 'hire', 'fas fa-trailer', NULL, NULL, 'Hire: Trailer', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 16, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(17, 'hire_buses', 'Buses (Hire)', NULL, 'hire', 'fas fa-bus', NULL, NULL, 'Hire: Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 17, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(18, 'hire_commercial_vehicles', 'Commercial Vehicles (Hire)', NULL, 'hire', 'fas fa-van-shuttle', NULL, NULL, 'Hire: Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 18, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(19, 'hire_farm_equipment', 'Farm Equipment (Hire)', NULL, 'hire', 'fas fa-tractor', NULL, NULL, 'Hire: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 19, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(20, 'hire_heavy_machinery', 'Heavy Machinery (Hire)', NULL, 'hire', 'fas fa-cogs', NULL, NULL, 'Hire: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 20, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(21, 'hire_animal_farming_equipment', 'Animal Farming Equipment (Hire)', NULL, 'hire', 'fas fa-cow', NULL, NULL, 'Hire: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 21, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(26, 'auction_farm_equipment', 'Farm Equipment (Auction)', NULL, 'auction', 'fas fa-tractor', NULL, NULL, 'Auction: Farm Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 26, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(27, 'auction_heavy_machinery', 'Heavy Machinery (Auction)', NULL, 'auction', 'fas fa-cogs', NULL, NULL, 'Auction: Heavy Machinery', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 1, NULL, NULL, NULL, 27, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(28, 'auction_animal_farming_equipment', 'Animal Farming Equipment (Auction)', NULL, 'auction', 'fas fa-cow', NULL, NULL, 'Auction: Animal Farming Equipment', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 28, 'active', '2025-07-07 03:09:28', '2025-07-07 03:09:28', 0),
(29, 'premium-ads', 'Premium Ads', NULL, 'sale', 'fas fa-tag', NULL, NULL, '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1),
(30, 'banner-ads', 'Banner Ads', NULL, 'sale', 'fas fa-tag', NULL, NULL, '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1),
(31, 'box-ads', 'Box Ads', NULL, 'sale', 'fas fa-tag', NULL, NULL, '', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 0, NULL, NULL, NULL, 0, 'active', '2025-07-09 03:29:20', '2025-07-09 03:29:20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category_analytics`
--

CREATE TABLE `category_analytics` (
  `analytics_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `views` int(11) DEFAULT 0,
  `listings_added` int(11) DEFAULT 0,
  `inquiries` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(27, 2, 'double pick', 'active', '2025-07-07 07:34:11'),
(28, 1, 'Shacman', 'active', '2025-07-20 13:44:53'),
(29, 1, 'Powerstar', 'active', '2025-07-27 12:27:29'),
(30, 4, 'Ford', 'active', '2025-07-28 05:33:16'),
(32, 4, 'Benz', 'active', '2025-07-28 09:22:44'),
(33, 4, 'Mercedes', 'active', '2025-07-28 10:24:08');

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
(84, 26, 'XCN 3000', 'active', '2025-07-07 05:57:45'),
(85, 28, 'F3000', 'active', '2025-07-20 14:00:32'),
(87, 28, 'X3000', 'active', '2025-07-22 14:43:43'),
(88, 28, 'X6000', 'active', '2025-07-22 14:44:07'),
(89, 28, 'L3000', 'active', '2025-07-22 14:44:19'),
(90, 29, '2642', 'active', '2025-07-27 12:28:11'),
(91, 30, 'Ranger', 'active', '2025-07-28 09:22:04'),
(92, 32, 'C200', 'active', '2025-07-28 09:23:06'),
(93, 24, 'Hilux', 'active', '2025-07-28 11:17:13'),
(94, 24, 'Land Cruiser', 'active', '2025-07-28 11:18:13'),
(96, 24, 'Fortuner', 'active', '2025-07-28 11:21:56'),
(97, 24, 'SUV', 'active', '2025-07-28 11:22:06');

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
(70, 79, 'legend 50', 'very powerful', 'active', '2025-07-07 05:54:57'),
(71, 85, '6x6 400hp', '400 Horse Power', 'active', '2025-07-20 14:02:03'),
(72, 87, '420hp', NULL, 'active', '2025-07-22 14:45:48'),
(73, 87, '430hp', NULL, 'active', '2025-07-22 14:45:59'),
(74, 87, '450hp', NULL, 'active', '2025-07-22 14:46:09'),
(75, 87, '480hp', NULL, 'active', '2025-07-22 14:46:24'),
(76, 87, '560hp', NULL, 'active', '2025-07-22 14:46:33'),
(77, 88, '480hp', NULL, 'active', '2025-07-22 14:47:05'),
(78, 88, '560hp', NULL, 'active', '2025-07-22 14:47:16'),
(79, 89, '240', '240 Horse power', 'active', '2025-07-27 12:11:40'),
(80, 96, '2.4GD-6', 'with options for 4x4 and automatic transmissions. Some models are also available as a 48V mild hybrid. ', 'active', '2025-07-28 11:31:43'),
(81, 96, '2.8GD-6', 'with options for 4x4 and automatic transmissions. Some models are also available as a 48V mild hybrid. ', 'active', '2025-07-28 11:32:03'),
(83, 96, '2.8GD-6 GR-Sport', 'with options for 4x4 and automatic transmissions. Some models are also available as a 48V mild hybrid. ', 'active', '2025-07-28 11:36:09'),
(84, 93, '2.8 D-6 RB Raider 6AT MHEV', NULL, 'active', '2025-07-28 11:38:14'),
(85, 93, '2.8 D-6 4x4 Raider 6AT MHEV', NULL, 'active', '2025-07-28 11:38:39'),
(86, 93, '2.8 D-6 RB Legend 6AT MHEV', NULL, 'active', '2025-07-28 11:39:23'),
(87, 93, '2.8 D-6 RB Legend RS 6AT MHEV', NULL, 'active', '2025-07-28 11:39:53'),
(88, 93, '2.8 D-6 4x4 Legend RS 6AT MHEV', NULL, 'active', '2025-07-28 11:41:09'),
(89, 93, '2.8 GD-6 4x4 Legend RS 6AT MHEV', NULL, 'active', '2025-07-28 11:42:05');

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
(2, 2, 25, 1, 1, '2025-08-09 07:02:57', -1, 0, -1, 4, 'h'),
(9, 4, 5, 0, 1, '2025-07-14 00:26:02', 1, 0, 50, 0, 'dc'),
(10, 5, 2, 0, NULL, '2025-07-09 11:46:21', 1, 0, 50, 0, NULL),
(11, 6, 2, 0, NULL, '2025-08-10 09:31:32', 1, 0, 50, 0, NULL),
(14, 3, -1, 1, 1, '2025-08-24 09:27:07', -1, 0, -1, 17, 'Bnj'),
(27, 9, 2, 0, 1, '2025-07-09 11:59:42', 1, 0, 50, 0, NULL),
(58, 10, -1, 0, 1, '2025-07-23 07:05:36', -1, 0, -1, 0, 'hh'),
(125, 11, 2, 0, 1, '2025-07-22 19:55:27', 0, 0, 10, 0, '');

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

--
-- Dumping data for table `dealer_branches`
--

INSERT INTO `dealer_branches` (`branch_id`, `dealer_id`, `branch_name`, `address`, `city`, `region`, `postal_code`, `phone`, `email`, `is_main_branch`, `status`, `created_at`) VALUES
(1, 2, 'Katete', 'Katetr', 'Lusaka', 'KwaZulu-Natal', '2000', '0776828796', 'admin@truckonsale.co.za', 0, 'active', '2025-07-18 22:35:25'),
(3, 3, 'trucks', 'Matero, Lusaka, Zambia', 'kimberely', 'Free State', '10019', '0770812506', 'chisalaluckyk5@gmail.com', 1, 'active', '2025-08-02 09:34:26'),
(4, 3, 'best trucks', '2 Central Park S #2', 'New York', 'Limpopo', '10019', '0770812506', 'chisalaluckyk5@gmail.com', 0, 'active', '2025-08-02 10:51:03'),
(5, 3, 'shacman tnt', 'durban ', 'durban', 'Free State', '10019', '0770812506', 'isalaluckyk5@gmail.com', 0, 'active', '2025-08-02 11:23:17');

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
(3, 3, 'Luckaon chisala ', 'Sales team manager ', '0771355473', 'chisalaluckyk5@gmail.com', '0771355473', 'uploads/6873797fc802d_1000005028.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-13 09:16:47'),
(4, 3, 'vish', NULL, '+27-83-247-4026', 'payghostwebservices@gmail.com', NULL, '../uploads/6884b81b64491_events.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-26 11:12:27');

-- --------------------------------------------------------

--
-- Table structure for table `featured_vehicles`
--

CREATE TABLE `featured_vehicles` (
  `featured_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `featured_by` int(11) NOT NULL,
  `featured_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `featured_until` date DEFAULT NULL,
  `featured_position` int(11) DEFAULT 0,
  `featured_type` enum('homepage','category','premium') DEFAULT 'homepage',
  `status` enum('active','expired','removed') DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_vehicles`
--

INSERT INTO `featured_vehicles` (`featured_id`, `vehicle_id`, `featured_by`, `featured_date`, `featured_until`, `featured_position`, `featured_type`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 53, 1, '2025-07-30 15:04:04', '2025-08-29', 1, 'homepage', 'active', 'Auto-featured during system setup', '2025-07-30 15:04:04', '2025-07-30 15:04:04'),
(2, 21, 1, '2025-07-30 15:04:04', '2025-08-29', 2, 'homepage', 'active', 'Auto-featured during system setup', '2025-07-30 15:04:04', '2025-07-30 15:04:04'),
(3, 9, 1, '2025-07-30 15:04:04', '2025-08-29', 3, 'homepage', 'active', 'Auto-featured during system setup', '2025-07-30 15:04:04', '2025-07-30 15:04:04'),
(4, 4, 1, '2025-07-30 15:04:04', '2025-08-29', 4, 'homepage', 'active', 'Auto-featured during system setup', '2025-07-30 15:04:04', '2025-07-30 15:04:04');

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

--
-- Dumping data for table `hire_bookings`
--

INSERT INTO `hire_bookings` (`booking_id`, `vehicle_id`, `customer_name`, `email`, `phone`, `start_date`, `end_date`, `pickup_location`, `daily_rate`, `total_cost`, `status`, `created_at`) VALUES
(2, 56, 'Chisla', 'wawa@gmail.com', '077777790', '2025-09-05', '2025-10-02', 'kimberely, Gauteng', '0.07', '1.89', 'cancelled', '2025-08-24 09:26:10');

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
(3, 15, 2, 'finance', 'Mafuleka', 'm@m.com', '0977278550', 'I am interested in this 2024 Volvo FH. Please contact me with more information.', 'email', 'new', 'medium', NULL, NULL, '2025-07-07 18:52:10', NULL),
(5, 15, 2, 'general', 'Mutale ', 'mutalemattlesa@gmail.com', '0770967132', 'Stuff', 'phone', 'new', 'medium', NULL, NULL, '2025-07-08 09:32:58', NULL),
(9, 4, 3, 'general', 'ghh jj', 'chisalaluckyk5@gmail.com', '563', 'I\\\'m interested in this 2018 Scania Macopolo. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-13 07:34:42', NULL),
(14, 21, 3, 'general', 'gg', 'chisalaluckyk5@gmail.com', '5', 'I\\\'m interested in this 2015 Iveco Eurocargo. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-16 12:19:06', NULL),
(16, 8, 3, 'general', 'xghh', 'chisalaluckyk5@gmail.com', '23', 'I\\\'m interested in this 2018 Isuzu GXR. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-16 12:51:46', NULL),
(18, 4, 3, 'general', 'Mutale Lesa', 'mutalemattlesa@gmail.com', '846649404664', 'Testing enquiry ', 'phone', 'new', 'medium', NULL, NULL, '2025-07-19 07:54:32', NULL),
(19, 38, 3, 'general', 'gg', 'chisalaluckyk5@gmail.com', '508', 'I\\\'m interested in this 2025 Shacman X3000. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-26 20:15:20', NULL),
(20, 21, 3, 'general', 'Hej', 'mutalemattlesa@gmail.com', '85669494', 'Gsjsjen', 'phone', 'new', 'medium', NULL, NULL, '2025-07-28 14:02:07', NULL),
(21, 46, 3, 'general', 'need this', 'chisalaluckyk5@gmail.com', '09966', 'I\\\'m interested in this 2025 Shacman L3000. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-07-31 13:28:38', NULL),
(22, 47, 3, 'general', 'lucky', 'chisalaluckyk5@gmail.com', '0771355473', 'I\\\'m interested in this 2021 Powerstar 2642. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-08-01 03:31:16', NULL),
(23, 21, 3, 'general', 'check', 'chisalaluckyk5@gmail.com', '63', 'I\\\'m interested in this 2015 Iveco Eurocargo. Please contact me with more details.', 'phone', 'contacted', 'medium', NULL, NULL, '2025-08-02 09:11:23', NULL),
(24, 21, 3, 'general', 'Mutale ', 'mutalemattlesa@gmail.com', '0797976766', 'Hsjjd sjnsjs jdke sdm', 'phone', 'contacted', 'medium', NULL, NULL, '2025-08-16 16:33:06', NULL),
(25, 56, 3, 'general', 'chicken', 'chisalaluckyk5@gmail.com', '.9', 'I\\\'m interested in this 2024 Toyota Hulix. Please contact me with more details.', 'phone', 'new', 'medium', NULL, NULL, '2025-08-23 18:03:20', NULL);

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
  `status` enum('active','inactive') DEFAULT 'active',
  `display_order` int(11) DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `click_count` int(11) DEFAULT 0,
  `impression_count` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `premium_ads`
--

INSERT INTO `premium_ads` (`id`, `title`, `image_url`, `link_url`, `ad_type`, `position`, `status`, `display_order`, `start_date`, `end_date`, `click_count`, `impression_count`, `created_by`, `created_at`, `updated_at`) VALUES
(5, 'Finance Solutions Available', 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=600&q=80', '?page=finance', 'box', 'homepage', 'active', 1, NULL, NULL, 4, 317, NULL, '2025-07-16 07:46:22', '2025-08-24 09:42:59'),
(12, 'tru', 'uploads/ads/687d4c8671ba0_bannersize1test.jpg', NULL, 'banner', 'homepage', 'active', 0, NULL, NULL, 15, 1364, 1, '2025-07-20 20:07:34', '2025-08-24 09:43:35'),
(13, 'fgfg', 'uploads/ads/687d4ef8e6ac7_BANNER_06_2600x.webp', NULL, 'banner', 'homepage', 'active', 2, NULL, NULL, 2, 1383, 1, '2025-07-20 20:18:00', '2025-08-24 09:43:47'),
(14, 'tuyeyrey', 'uploads/ads/687d522c4d0d7_bannersize1test.png', NULL, 'banner', 'homepage', 'active', 3, '2025-07-20', '2025-07-31', 0, 0, 1, '2025-07-20 20:31:40', '2025-07-20 20:31:40'),
(15, 'Hino', 'uploads/ads/687d52e6a4ed5_20220713-5-Hino-truck-min.jpg', NULL, 'banner', 'homepage', 'active', 0, NULL, NULL, 15, 1437, 1, '2025-07-20 20:34:46', '2025-08-24 09:43:41'),
(16, 'ggy', 'uploads/ads/687dd60412fab_Screenshot_20250719-120017_Chrome.jpg', 'https://trucksonsale.co.za/listings/admin.php?action=manage_ads', 'box', 'homepage', 'active', 1, '2025-07-21', '2025-07-31', 0, 0, 1, '2025-07-21 05:54:12', '2025-07-21 05:54:12'),
(17, 'test', 'uploads/ads/688b43d3599ad_trucks_1753888417.jpeg', 'https://glams.co.za', 'banner', 'homepage', 'active', 1, '2025-07-31', '2025-08-08', 0, 0, 1, '2025-07-31 10:22:11', '2025-07-31 10:22:11');

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
(4, 'https://images.unsplash.com/photo-1519003722824-194d4455a60c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11'),
(5, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Default Background', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'active', 0, '2025-07-14 08:20:11');

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
(10, 4, 'Bakkies', 'Bakkies', 0, 'active', '2025-07-28 05:20:40'),
(12, 4, 'LDV-PanelVans', 'LDV & Panel Vans', 0, 'active', '2025-07-28 07:13:36'),
(13, 1, 'truck-tractors', 'Truck Tractors', 0, 'active', '2025-08-08 15:57:38'),
(14, 1, 'dropside-trucks', 'Dropside Trucks', 0, 'active', '2025-08-08 15:59:17'),
(15, 1, 'tipper-trucks', 'Tipper Trucks', 0, 'active', '2025-08-08 16:00:20'),
(16, 1, 'chassis-cab-trucks', 'Chassis Cab Trucks', 0, 'active', '2025-08-08 16:01:20'),
(17, 1, 'truck', 'Truck', 0, 'active', '2025-08-08 16:02:45'),
(18, 1, 'box-trucks', 'Box Trucks', 0, 'active', '2025-08-08 16:03:25'),
(19, 1, 'refrigerated-trucks', 'Refrigerated Trucks', 0, 'active', '2025-08-08 16:05:06'),
(20, 1, 'water-bowser-trucks', 'Water Bowser Trucks', 0, 'active', '2025-08-08 16:06:25'),
(21, 1, 'crane-trucks', 'Crane Trucks', 0, 'active', '2025-08-08 16:07:13'),
(22, 1, 'curtain-side-trucks', 'Curtain Side Trucks', 0, 'active', '2025-08-08 16:07:58'),
(23, 1, 'garbage-trucks', 'Garbage Trucks', 0, 'active', '2025-08-08 16:08:45'),
(24, 1, 'other-trucks', 'Other Trucks', 0, 'active', '2025-08-08 16:09:32'),
(25, 1, 'rollback-trucks', 'Rollback Trucks', 0, 'active', '2025-08-08 16:10:46'),
(26, 1, 'flatbed-trucks', 'Flatbed Trucks', 0, 'active', '2025-08-08 16:11:23'),
(27, 1, 'concrete-mixer-trucks', 'Concrete Mixer Trucks', 0, 'active', '2025-08-08 16:12:24'),
(28, 1, 'rigid-trucks', 'Rigid Trucks', 0, 'active', '2025-08-08 16:13:09'),
(29, 1, 'skip-bin-loader-trucks', 'Skip Bin Loader Trucks', 0, 'active', '2025-08-08 16:14:24'),
(30, 1, 'tanker-trucks', 'Tanker Trucks', 0, 'active', '2025-08-08 16:15:25'),
(31, 1, 'cattle-body-trucks', 'Cattle Body Trucks', 0, 'active', '2025-08-08 16:16:09'),
(32, 1, 'fire-trucks', 'Fire Trucks', 0, 'active', '2025-08-08 16:17:13'),
(33, 1, 'honey-sucker-trucks', 'Honey Sucker Trucks', 0, 'active', '2025-08-08 16:18:16'),
(34, 1, 'personnel-carrier-trucks', 'Personnel Carrier Trucks', 0, 'active', '2025-08-08 16:25:46'),
(35, 1, 'cherry-picker-trucks', 'Cherry Picker Trucks', 0, 'active', '2025-08-08 16:27:03'),
(36, 1, 'hooklift-trucks', 'Hooklift Trucks', 0, 'active', '2025-08-08 16:27:44'),
(37, 1, 'recovery-trucks', 'Recovery Trucks', 0, 'active', '2025-08-08 16:28:34'),
(38, 1, 'cage-body-trucks', 'Cage Bodies Trucks', 0, 'active', '2025-08-08 16:29:59'),
(39, 1, 'water-sprinkler-trucks', 'Water Sprinkler Trucks', 0, 'active', '2025-08-08 16:30:48'),
(40, 1, 'gas-cylinder-trucks', 'Gas Cylinder Trucks', 0, 'active', '2025-08-08 16:31:44'),
(41, 1, 'mass-side-trucks', 'Mass Side Trucks', 0, 'active', '2025-08-08 16:32:30'),
(42, 1, 'crew-cab', 'Crew Cab', 0, 'active', '2025-08-08 16:33:23'),
(43, 1, 'double-cab-trucks', 'Double Cab Trucks', 0, 'active', '2025-08-08 16:34:18'),
(44, 1, 'bullnose-trucks', 'Bullnose Trucks', 0, 'active', '2025-08-08 16:35:09'),
(45, 1, 'concrete-pump-trucks', 'Concrete Pump Trucks', 0, 'active', '2025-08-08 16:35:52'),
(46, 1, 'horse-box-trucks', 'Horse Box Trucks', 0, 'active', '2025-08-08 16:36:44'),
(47, 1, 'road-sweeper-trucks', 'Road Sweeper Trucks', 0, 'active', '2025-08-08 16:37:29'),
(48, 1, 'car-carrier-trucks', 'Car Carrier Trucks', 0, 'active', '2025-08-08 16:38:23'),
(49, 1, 'tail-lifts', 'Tail Lifts', 0, 'active', '2025-08-08 16:39:21'),
(50, 2, 'trailer', 'Trailers', 0, 'active', '2025-08-09 02:53:41'),
(51, 2, 'side-tipper', 'Side Tipper', 0, 'active', '2025-08-09 02:58:11'),
(52, 2, 'fuel-tanker', 'Fuel Tanker', 0, 'active', '2025-08-09 02:59:17'),
(53, 2, 'diesel-bowser-trailers', 'Diesel Bowser Trailers', 0, 'active', '2025-08-09 03:01:54'),
(54, 2, 'drawbar', 'Drawbar', 0, 'active', '2025-08-09 03:03:09'),
(55, 2, 'superlink', 'Superlink', 0, 'active', '2025-08-09 03:04:08'),
(56, 2, 'tautliner-trailers', 'Tautliner Trailers', 0, 'active', '2025-08-09 03:05:13'),
(57, 2, 'box-trailers', 'Box Trailers', 0, 'active', '2025-08-09 03:06:00'),
(58, 2, 'lowbeds', 'Lowbeds', 0, 'active', '2025-08-09 03:08:21'),
(59, 2, 'stepdeck', 'Stepdeck', 0, 'active', '2025-08-09 03:09:20'),
(60, 2, 'water-bowser-trailers', 'Water Bowser Trailers', 0, 'active', '2025-08-09 03:10:43'),
(61, 2, 'diesel-tankers', 'Diesel Tankers', 0, 'active', '2025-08-09 03:11:56'),
(62, 2, 'tri-axel-trailers', 'Tri-Axel Trailers', 0, 'active', '2025-08-09 03:14:52'),
(63, 2, 'two-axel-trailers', 'Two-Axel Trailers', 0, 'active', '2025-08-09 03:16:17'),
(64, 2, 'fuel-bowsers', 'Fuel Bowsers', 0, 'active', '2025-08-09 03:17:22'),
(65, 2, 'cattle-trailers', 'Cattle Trailers', 0, 'active', '2025-08-09 03:18:08'),
(66, 2, 'interlink', 'Interlink', 0, 'active', '2025-08-09 03:18:43'),
(67, 2, 'truck-bodies', 'Truck Bodies', 0, 'active', '2025-08-09 03:20:54'),
(68, 2, 'welldeck', 'Welldeck', 0, 'active', '2025-08-09 03:21:53'),
(69, 2, 'farm-trailers', 'Farm Trailers', 0, 'active', '2025-08-09 03:22:41'),
(70, 2, 'advertising-trailer', 'Advertising Trailers', 0, 'active', '2025-08-09 03:28:43'),
(71, 2, 'goose-neck', 'Goose Neck', 0, 'active', '2025-08-09 03:29:38'),
(72, 2, 'cold-rooms', 'Cold Room Trailers', 0, 'active', '2025-08-09 03:31:58'),
(73, 2, 'general-purpose-trailers', 'General Purpose Trailers', 0, 'active', '2025-08-09 03:33:08'),
(74, 2, 'pantech', 'Pantech Trailers', 0, 'active', '2025-08-09 03:34:10'),
(75, 2, 'car-trailers', 'Car Trailers', 0, 'active', '2025-08-09 03:34:57'),
(76, 2, 'game-trailers', 'Game Trailers', 0, 'active', '2025-08-09 03:35:32'),
(77, 2, 'generator-trailers', 'Generator Trailers', 0, 'active', '2025-08-09 03:36:50'),
(78, 2, 'lpg-tanker', 'LPG Tanker', 0, 'active', '2025-08-09 03:38:26'),
(79, 2, 'luggage-trailers', 'Luggage Trailers', 0, 'active', '2025-08-09 03:39:32'),
(80, 2, 'rigid-reefers', 'Rigid Reefers', 0, 'active', '2025-08-09 03:40:48'),
(81, 2, 'sheep-trailers', 'Sheep Trailers', 0, 'active', '2025-08-09 03:41:42');

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
(6, 6, 'max_videos_per_listing', '5', 'number', 'Maximum videos per vehicle listing', '2025-07-09 04:04:01', '2025-07-14 00:51:31', 1);

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
  `logo` varchar(255) DEFAULT NULL COMMENT 'Dealership logo file path/URL',
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
(1, 'admin', 'a@za', '$2y$10$/ft2uEtY8eKkeQ43HoamgOCBP6muuCQ7DwwlOJISp3FIZohAHOi66', '0000000000', 'TrucksONSale Admin', NULL, NULL, NULL, NULL, 'admin', 'active', '2025-07-07 03:09:28', '2025-08-21 17:52:31', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(2, 'John ', 'j@gmail.com', '$2y$10$K1OkSEjcbImuejIp788bh.NyqadticnRzP8OUv/13Y5OYJeIlrfaO', '0776828793', 'BmK Zambia ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 03:20:27', '2025-07-18 23:41:17', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(3, 'Shacman', 'shacman@bizlive.co.za', '$2y$10$1CiCxzIEtcOSQXdnBrdNCedqhBA2r.Sid3PlZtl5bwI.7MyZX5vc6', '0771355473', 'Shacman TNT', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 05:52:34', '2025-08-23 08:28:54', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(4, 't@gmail.com', 'd@d.com', '$2y$10$uvgXck9JSpifzwGmG08M6eGK76x0ogGMw25kPYjhjHw6pFnRFrr4K', '0977278550', 'B Cars', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 07:21:55', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(5, 't@gmail.comm', 'brianmwilakasongo@gmail.com', '$2y$10$/RLfu22uda/brebt.7dfMOwSW7nMW8cXAmAYAx0TqDz73zc6f72se', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 08:43:14', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 1, NULL),
(6, 'aas', 'admin@truckonsale.co.za', '$2y$10$jWj0fy0BooaqCpwE4IMllODctHygqQ/UNZuYKzf7srXFmSufEq81i', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-07 08:48:02', '2025-07-07 08:48:41', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 4, NULL),
(8, 'a', 'm@m.comm', '$2y$10$ejDf5DgNyCxxAktLAUYFTeziytgW0aX7vNQQiX2Gh/UqRbkUm6Azm', '0776828793', 'BMK Marketing', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-09 03:13:38', '2025-07-09 03:15:16', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(9, 'op', 'a@zaa', '$2y$10$EmWj87.r4kkUe93BMRE4ne.15kl2MZ65mJtEH.aPsJUmhH2WbmsV.', '260776828793', 'Jelumu Zambia ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-09 11:59:13', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(10, 'mwansa ', 'n@gmail.com', '$2y$10$DXM9Le1k.S9vOUlqLR3W4uIfEtvK9azm2d31g78Na/tDyQspTqbuC', '0776828793', 'Bmmk', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-14 00:29:38', '2025-07-23 06:56:47', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(11, 'opp', 'b@outlook.com', '$2y$10$FYfGxd8YDFEJoj3JhOGhwedNuy2QaxVxHcU9Ku4UbyoftMz7dQiOa', '0776828793', 'James ', NULL, NULL, NULL, NULL, 'dealer', 'active', '2025-07-14 00:39:09', '2025-07-22 19:55:36', NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(14, 'tinkle', 'muts@gmail.com', '$2b$10$502tIsRb74XNEQVeJm3HkOMmF356em8gI5mUhu1uibfe3jqnr.klq', '098466131566', 'Lesa', NULL, NULL, NULL, NULL, 'dealer', 'rejected', '2025-07-18 16:50:02', NULL, NULL, 0, 0, NULL, NULL, 10, 2, NULL, 0, NULL),
(15, 'superadmin', 'payghostwebservices@gmail.com', '$2y$10$5QaMv.QullTznU0Z.3yisuTpuIMF2pQ/yRheDXM1AYI06a.MbEM.C', '+27123456789', 'PayGhost Web Services', NULL, NULL, NULL, NULL, 'admin', 'active', '2025-07-31 10:25:03', '2025-08-21 17:56:30', NULL, 1, 0, NULL, NULL, 999999, 999999, NULL, 0, NULL);

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
(4, 3, 'buses', NULL, 'sale', 'new', 'Scania', 'Macopolo', 'other', 2018, '200000.00', 887, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Eastern Cape', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'j,', '89o8o', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-06', 0, NULL, 'available', 25, 0, '2025-07-07 06:18:09', '2025-08-12 17:58:51', NULL, 0),
(8, 3, 'trucks', NULL, 'sale', 'used', 'Isuzu', 'GXR', 'other', 2018, '300000.00', 255777, 0, 'v8 turbo', NULL, 500, NULL, NULL, 'white', NULL, NULL, 'Gauteng', 'TEC', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'f7f77gr', '77re7r7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, 'available', 23, 0, '2025-07-07 07:39:37', '2025-08-08 14:24:55', NULL, 0),
(9, 2, 'commercial_vehicles', NULL, 'rent-to-own', 'used', 'Toyota', 'Landcruseir', 'other', 2022, '50888.00', 56499, 0, 'V8', NULL, 693, 'manual', 'diesel', 'green ', NULL, NULL, 'Eastern Cape', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'ghhhh', 'hhjkuh', NULL, '500.00', '66.00', '250.00', NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, 'available', 18, 0, '2025-07-07 07:41:38', '2025-08-12 13:14:23', NULL, 0),
(15, 2, 'trucks', NULL, 'hire', 'used', 'Volvo', 'FH', 'Premium', 2024, '580.00', 88, 0, '1ZR', NULL, 74, 'manual', 'diesel', 'Brown ', NULL, NULL, 'Free State', 'yy', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'ggbhug', 'ggjutgb', NULL, '58.00', '80.00', '90.00', NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 22, 0, '2025-07-07 16:03:48', '2025-08-01 14:12:20', NULL, 0),
(16, 2, 'commercial_vehicles', NULL, 'rent-to-own', 'new', 'Toyota', 'Hulix', 'legend 50', 2022, '2995.00', 888, 0, 'v6', NULL, 58, 'automatic', 'petrol', 'green ', NULL, NULL, 'Limpopo', 'Lusaka ', NULL, 'good', 1, 1, NULL, 1, 1, 1, 1, 'gghyf', 'fghyrd', NULL, '80.00', '36.00', '47.00', NULL, NULL, NULL, NULL, 0, '2025-08-06', 0, NULL, 'available', 11, 0, '2025-07-07 16:07:57', '2025-07-21 08:30:44', NULL, 0),
(21, 3, 'trucks', NULL, 'auction', 'used', 'Iveco', 'Eurocargo', NULL, 2015, '23423.00', 434433, 0, 'v6', NULL, 2342, 'manual', 'petrol', 'white', NULL, NULL, 'Western Cape', 'Demo City', NULL, 'good', 1, 1, NULL, 0, 0, 1, 1, 'werwerwe', 'wdsadasd', NULL, NULL, NULL, NULL, '2025-07-14 19:25:00', '2025-07-02 19:25:00', '52121.00', NULL, 1, '2025-08-22', 0, NULL, 'available', 20, 0, '2025-07-12 17:26:17', '2025-08-12 16:26:45', NULL, 0),
(38, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X3000', '420hp', 2025, '1250000.00', 0, 0, 'X3000', NULL, 420, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman\r\nX3000 420hp\r\nThe X3000 products have been a customer favorite since their introduction. The platform combines performance, durability, comfort, efficiency, and security in a single package. The X3000 trucks have proven to be reliable and versatile, supporting the success of many businesses around the globe. Whether you need to transport goods, deliver services, or travel long distances, the X3000 trucks can meet your needs and exceed your expectations.\r\nThe X3000 has demonstrated its remarkable quality by working over 2 million kilometers without major repairs. We have always believed that reliability can only be proven by time, and the X3000 is the ultimate proof of our dependability and excellence.\r\n', 'Configuration 4 x 2 \r\nCab Low\r\nGearbox AMT F16JZ24 \r\nRear Axle  Single Reduction \r\nEngine Brake Jacobs \r\nRetarder NA \r\nFront Suspension 3 Leaf \r\nRear Suspension 4 Leaf \r\nWheelbase (mm) 3600 \r\nExhaust Horizontal, Right hand Exit \r\nWheels Steel \r\nFuel Capacity 700 \r\nGVM (kg) 20 500 \r\nGCM (kg) 49 000 \r\nTare (kg) 6860 \r\nEngine 420hp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-25', 0, NULL, 'available', 8, 0, '2025-07-26 11:44:34', '2025-07-27 11:36:00', NULL, 0),
(39, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X3000', '430hp', 2025, '1300000.00', 0, 0, 'X3000', NULL, 430, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman\r\nX3000 430hp\r\nThe X3000 products have been a customer favorite since their introduction. The platform combines performance, durability, comfort, efficiency, and security in a single package. The X3000 trucks have proven to be reliable and versatile, supporting the success of many businesses around the globe. Whether you need to transport goods, deliver services, or travel long distances, the X3000 trucks can meet your needs and exceed your expectations.\r\nThe X3000 has demonstrated its remarkable quality by working over 2 million kilometers without major repairs. We have always believed that reliability can only be proven by time, and the X3000 is the ultimate proof of our dependability and excellence.', 'Configuration 4 x 2 \r\nCab Low\r\nGearbox AMT F16JZ24 \r\nRear Axle  Single Reduction \r\nEngine Brake Jacobs \r\nRetarder NA \r\nFront Suspension 3 Leaf \r\nRear Suspension 4 Leaf \r\nWheelbase (mm) 3600 \r\nExhaust Horizontal, Right hand Exit \r\nWheels Steel \r\nFuel Capacity 700 \r\nGVM (kg) 20 500 \r\nGCM (kg) 49 000 \r\nTare (kg) 6860 \r\nEngine 430hp\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-25', 0, NULL, 'available', 2, 0, '2025-07-26 12:12:45', '2025-08-12 19:31:59', NULL, 0),
(40, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X3000', '450hp', 2025, '1400000.00', 0, 0, 'X3000', NULL, 450, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 0, 0, 1, 'Shacman\r\nX3000 450hp\r\nThe X3000 products have been a customer favorite since their introduction. The platform combines performance, durability, comfort, efficiency, and security in a single package. The X3000 trucks have proven to be reliable and versatile, supporting the success of many businesses around the globe. Whether you need to transport goods, deliver services, or travel long distances, the X3000 trucks can meet your needs and exceed your expectations.\r\nThe X3000 has demonstrated its remarkable quality by working over 2 million kilometers without major repairs. We have always believed that reliability can only be proven by time, and the X3000 is the ultimate proof of our dependability and excellence.\r\n', 'Configuration 6 x 4 \r\nCab High or Low \r\nGearbox AMT F16JZ26 \r\nRear Axle Type Single Reduction \r\nEngine Brake Jacobs\r\nRetarder FHB400 \r\nFront Suspension 3 Leaf \r\nRear Suspension 4 Leaf \r\nWheelbase (mm) 3825 \r\nExhaust Horizontal, Right hand Exit \r\nWheels Steel \r\nFuel Capacity 980 \r\nGVM (kg) 34 000 \r\nGCM (kg) 75 000 \r\nTare (kg) 9020 \r\nEngine 450hp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-25', 0, NULL, 'available', 2, 0, '2025-07-26 12:17:07', '2025-08-12 18:27:51', NULL, 0),
(42, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X3000', '560hp', 2025, '1600000.00', 0, 0, 'X3000', NULL, 560, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman\r\nX6000 560hp\r\nThe X6000 is a state-of-the-art vehicle that offers unparalleled features and benefits for drivers, operators, and customers. It is equipped with a powerful and reliable engine that delivers high torque and low fuel consumption, a smooth and responsive transmission that adapts to any driving condition, a durable and lightweight chassis that supports heavy loads and reduces emissions, and a sophisticated and comfortable cabin that provides a safe and luxurious driving experience.\r\nThe X6000 is more than just a truck. It is a masterpiece of engineering and design, a symbol of innovation and excellence, and a partner of trust and value. The X6000 series is ready to take you to the next level.\r\n', 'Configuration 6 x 4 \r\nCab High or Low \r\nGearbox AMT F16JZ26 \r\nRear Axle Type Single Reduction \r\nEngine Brake Jacobs \r\nRetarder FHB400 \r\nFront Suspension 3 Leaf Rear \r\nSuspension 4 Leaf \r\nWheelbase (mm) 3825 \r\nExhaust Horizontal, Right hand Exit \r\nWheels Alloy \r\nFuel Capacity 980 \r\nGVM (kg) 34 000 \r\nGCM (kg) 75 000 \r\nTare (kg) 9020 \r\nEngine 560hp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-25', 0, NULL, 'available', 3, 0, '2025-07-26 14:04:23', '2025-08-12 14:18:37', NULL, 0),
(43, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X3000', '480hp', 2025, '1600000.00', 0, 0, 'X3000', NULL, 480, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-26', 0, NULL, 'available', 1, 0, '2025-07-27 11:41:19', '2025-08-12 17:29:51', NULL, 0),
(44, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X6000', '480hp', 2025, '2000000.00', 0, 0, 'X6000', NULL, 480, NULL, NULL, 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman X6000 480hp The X6000 is a state-of-the-art vehicle that offers unparalleled features and benefits for drivers, operators, and customers. It is equipped with a powerful and reliable engine that delivers high torque and low fuel consumption, a smooth and responsive transmission that adapts to any driving condition, a durable and lightweight chassis that supports heavy loads and reduces emissions, and a sophisticated and comfortable cabin that provides a safe and luxurious driving experience.\r\nThe X6000 is more than just a truck. It is a masterpiece of engineering and design, a symbol of innovation and excellence, and a partner of trust and value. The X6000 series is ready to take you to the next level.\r\n', 'Key Features and Specifications: Powerful Engine: The X6000 boasts a powerful engine, with some models reaching 700 horsepower and 3200 Nm of torque. Fuel Efficiency: The truck incorporates energy-saving technologies, including vehicle power matching, vehicle integration, and intelligent shift control, resulting in industry-leading fuel consumption. Comfortable Cab: The X6000\'s cab is designed to provide a comfortable and luxurious driving experience, comparable to a car, with features like tablet-style screens for the instrument cluster and infotainment. Advanced Technology: The truck includes features like anti-lock braking, traction control, stability control, adaptive cruise control, and lane keeping assist. Durable Construction: The X6000 features a durable and lightweight chassis designed to support heavy loads and reduce emissions. Safety Features: The X6000 includes a range of safety features such as anti-lock braking, stability control, and collision warning. Retarder: The truck is equipped with a Fast FHB400 4000Nm retarder for enhanced braking performance. Air Suspension: The rear suspension can be either air suspension or leaf suspension. Engine Brake: The X6000 features a Wabco EBS engine brake.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-26', 0, NULL, 'available', 1, 0, '2025-07-27 11:51:50', '2025-08-12 19:51:50', NULL, 0),
(45, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'X6000', '560hp', 2025, '2100000.00', 0, 0, 'X6000', NULL, 560, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman\r\nX6000 560hp\r\nThe X6000 is a state-of-the-art vehicle that offers unparalleled features and benefits for drivers, operators, and customers. It is equipped with a powerful and reliable engine that delivers high torque and low fuel consumption, a smooth and responsive transmission that adapts to any driving condition, a durable and lightweight chassis that supports heavy loads and reduces emissions, and a sophisticated and comfortable cabin that provides a safe and luxurious driving experience.\r\nThe X6000 is more than just a truck. It is a masterpiece of engineering and design, a symbol of innovation and excellence, and a partner of trust and value. The X6000 series is ready to take you to the next level.\r\nConfiguration 6 x 4 Cab High or Low Gearbox AMT F16JZ26 Rear Axle Type Single Reduction Engine Brake Jacobs Retarder FHB400 Front Suspension 3 Leaf Rear Suspension 4 Leaf Wheelbase (mm) 3825 Exhaust Horizontal, Right hand Exit Wheels Alloy Fuel Capacity 980 GVM (kg) 34 000 GCM (kg) 75 000 Tare (kg) 9020 Engine 560hp\r\nKey Features and Specifications: Powerful Engine: The X6000 boasts a powerful engine, with some models reaching 700 horsepower and 3200 Nm of torque. Fuel Efficiency: The truck incorporates energy-saving technologies, including vehicle power matching, vehicle integration, and intelligent shift control, resulting in industry-leading fuel consumption. ', 'Comfortable Cab: The X6000\'s cab is designed to provide a comfortable and luxurious driving experience, comparable to a car, with features like tablet-style screens for the instrument cluster and infotainment. Advanced Technology: The truck includes features like anti-lock braking, traction control, stability control, adaptive cruise control, and lane keeping assist. Durable Construction: The X6000 features a durable and lightweight chassis designed to support heavy loads and reduce emissions. Safety Features: The X6000 includes a range of safety features such as anti-lock braking, stability control, and collision warning. Retarder: The truck is equipped with a Fast FHB400 4000Nm retarder for enhanced braking performance. Air Suspension: The rear suspension can be either air suspension or leaf suspension. Engine Brake: The X6000 features a Wabco EBS engine brake.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-26', 0, NULL, 'available', 1, 0, '2025-07-27 11:55:46', '2025-08-12 12:42:35', NULL, 0),
(46, 3, 'trucks', NULL, 'sale', 'new', 'Shacman', 'L3000', '240', 2025, '550000.00', 0, 0, 'L3000', NULL, 240, 'automatic', 'diesel', 'Optional', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 1, NULL, 1, 1, 0, 1, 'Shacman\r\nL3000 240hp\r\n\r\nThe Shacman L series, specifically the L3000 model, is a versatile medium-duty truck known for its suitability for intercity logistics and various specialized applications. It\'s designed with a highly adaptable chassis and a focus on maneuverability, making it well-suited for navigating urban environments. \r\nKey Features and Characteristics of the Shacman L3000:\r\nVersatility:\r\nThe L3000\'s chassis is designed for high compatibility, allowing for modifications into various specialized vehicles like water spraying trucks, fuel oil tankers, and truck-mounted cranes. \r\nManeuverability:\r\n', 'It features a 100mm large bore steering gear, enabling a maximum turning angle of 46 degrees and a minimum turning radius of 8.4 meters, enhancing its agility in tight spaces. \r\nEngine Options:\r\nThe L3000 can be equipped with either Weichai or Cummins engines, with Cummins offering potentially better performance but potentially more challenging maintenance. \r\nTransmission:\r\nIt utilizes either FAST manual or Eaton AMT gearboxes. \r\nCab:\r\nThe cab design includes features like hydraulic seats, a piano-style rocker switch, and a car-like air conditioning controller, prioritizing driver comfort and ergonomics. \r\nApplications:\r\nThe L3000 is well-suited for various tasks including intercity logistics, municipal sanitation, light construction, and specialized applications. \r\nOverall, the Shacman L3000 is a robust and adaptable medium-duty truck designed to handle a variety of tasks with efficiency and maneuverability, particularly in urban settings. \r\n\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-26', 0, NULL, 'available', 1, 0, '2025-07-27 12:20:55', '2025-08-12 15:55:04', NULL, 0),
(47, 3, 'trucks', NULL, 'sale', 'used', 'Powerstar', '2642', 'other', 2021, '825000.00', 170349, 0, NULL, NULL, NULL, 'manual', 'diesel', 'White', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'Powerstar Tipper trucks 2642 10 Cube Tipper 2021\r\nLow Mileage\r\nBrand-New Bin\r\nNew Hydraulics\r\nExcellent Mechanical Condition', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-26', 0, NULL, 'available', 2, 0, '2025-07-27 12:33:18', '2025-08-12 18:53:12', NULL, 0),
(49, 3, 'commercial_vehicles', NULL, 'sale', 'used', 'Toyota', 'Hilux', '2.8 D-6 4x4 Legend RS 6AT MHEV', 2019, '469900.00', 107000, 0, '2.4GD-6', NULL, NULL, 'manual', 'diesel', 'White', NULL, NULL, 'Gauteng', 'Kempton Park', NULL, 'good', 1, 0, NULL, 1, 1, 0, 1, ' Finance available, trade ins welcome.\r\n       \r\n•	Backed by Toyota\r\n•	Seven day exchange plan', 'Vehicle specifications\r\nGeneral\r\nMake\r\nToyota\r\nModel\r\nHilux\r\nVariant\r\n2.4GD-6 Double Cab 4x4 SRX\r\nIntroduction date\r\n15/08/2018\r\nEnd date\r\n24/06/2019\r\nService interval distance\r\n10 000 km\r\nWarranty distance\r\n100 000 km\r\nWarranty duration (years)\r\n3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-27', 0, NULL, 'available', 5, 0, '2025-07-28 11:55:11', '2025-08-12 19:41:23', NULL, 0),
(50, 3, 'trailers', NULL, 'sale', 'new', 'SA Truck Bodies', 'Flatdeck', 'Standard', 2019, '111000.00', 0, 0, NULL, NULL, NULL, NULL, NULL, 'Blue ', NULL, NULL, 'North West', 'Kimberly ', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'Very good for almost everything should be tomatoes heavy things ', '10 wheels ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-27', 0, NULL, 'available', 6, 0, '2025-07-28 14:29:36', '2025-08-12 19:53:29', NULL, 0),
(51, 3, 'trailers', NULL, 'sale', 'new', 'Afrit', 'others', 'other', 2020, '150000.00', 0, 0, NULL, NULL, NULL, NULL, NULL, 'White', NULL, NULL, 'Free State', 'Free state', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'Very good', 'Has a freezer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-08-27', 0, NULL, 'available', 1, 0, '2025-07-28 14:31:24', '2025-08-12 19:12:40', NULL, 0),
(53, 3, 'trailers', NULL, 'sale', 'new', 'Henred', 'Maxitrans', NULL, 2017, '120000.00', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Limpopo', 'Kimberly ', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-08-27', 0, NULL, 'available', 5, 0, '2025-07-28 14:39:29', '2025-08-15 09:07:34', NULL, 0),
(56, 3, 'commercial_vehicles', NULL, 'hire', 'new', 'Toyota', 'Hulix', 'legend 50', 2024, '120000.00', 0, 0, 'v8 turbo', NULL, 1200, 'automatic', 'petrol', 'orange', NULL, NULL, 'Gauteng', 'kimberely', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'very good', 'yhh', NULL, '0.07', '0.08', '-0.05', NULL, NULL, NULL, NULL, 0, '2025-09-09', 0, NULL, 'available', 2, 0, '2025-08-10 09:20:28', '2025-08-17 13:21:49', NULL, 0),
(58, 3, 'commercial_vehicles', NULL, 'sale', 'new', 'Toyota', 'Hulix', 'legend 50', 2023, '120000.00', 433, 0, 'v8', NULL, 500, 'automatic', 'petrol', 'white', '153546', '7578657835', 'Free State', 'kimberely', NULL, 'good', 0, 0, NULL, 0, 0, 0, 0, 'ffcxxcrggt', 'tttff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-09-09', 0, NULL, 'available', 0, 0, '2025-08-10 14:34:18', '2025-08-10 14:40:24', NULL, 0);

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
(3, 9, 'uploads/686b7a32d7540_Academic_Report_631.pdf', 'Academic_Report_63 (1).pdf', 'pdf', 1054413, '2025-07-07 07:41:38'),
(6, 38, '../uploads/6884bfa21cc99_X3000420hp.pdf', 'X3000  420hp.pdf', 'pdf', 128103, '2025-07-26 11:44:34'),
(7, 39, '../uploads/6884c63d5130f_X3000430HP.pdf', 'X3000 430HP.pdf', 'pdf', 104934, '2025-07-26 12:12:45'),
(8, 40, '../uploads/6884c7433f8ad_X3000450HP.pdf', 'X3000 450HP.pdf', 'pdf', 105914, '2025-07-26 12:17:07'),
(10, 42, '../uploads/6884e06736134_X3000560HP.pdf', 'X3000 560HP.pdf', 'pdf', 106274, '2025-07-26 14:04:23'),
(11, 43, '../uploads/6886105f95d4d_X3000480HP.pdf', 'X3000 480HP.pdf', 'pdf', 105983, '2025-07-27 11:41:19'),
(12, 44, '../uploads/688612d66fe96_X6000480HP.pdf', 'X6000 480HP.pdf', 'pdf', 560277, '2025-07-27 11:51:50'),
(13, 45, '../uploads/688613c2952f8_X6000560HP.pdf', 'X6000 560HP.pdf', 'pdf', 196523, '2025-07-27 11:55:46'),
(14, 46, '../uploads/688619a79c35e_ShacmanLseries.pdf', 'Shacman L series.pdf', 'pdf', 529560, '2025-07-27 12:20:55');

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
(9, 4, 'uploads/686b66a166d56_cq5dam.web.1280.1280.jpeg', 'cq5dam.web.1280.1280.jpeg', 210549, 0, 1, '2025-07-07 06:18:09'),
(14, 8, 'uploads/686b79b9052d3_R.jpeg', 'R.jpeg', 416485, 0, 1, '2025-07-07 07:39:37'),
(15, 9, 'uploads/686b7a32d5788_FB_IMG_17507212006559575.jpg', 'FB_IMG_17507212006559575.jpg', 511478, 0, 1, '2025-07-07 07:41:38'),
(21, 15, 'uploads/686befe42a5ff_istockphoto-805734800-612x612.jpg', 'istockphoto-805734800-612x612.jpg', 47630, 0, 1, '2025-07-07 16:03:48'),
(22, 16, 'uploads/686bf0dd76b18_FB_IMG_17507212033362385.jpg', 'FB_IMG_17507212033362385.jpg', 528389, 0, 1, '2025-07-07 16:07:57'),
(29, 21, 'uploads/68729ab96e2b4_truck.jpeg', 'truck.jpeg', 6636, 0, 1, '2025-07-12 17:26:17'),
(56, 38, '../uploads/6884bfa219aef_1.jpg', '1.jpg', 290580, 0, 1, '2025-07-26 11:44:34'),
(57, 38, '../uploads/6884bfa21a709_2.jpg', '2.jpg', 290670, 1, 0, '2025-07-26 11:44:34'),
(58, 38, '../uploads/6884bfa21aaa9_3.jpg', '3.jpg', 345920, 2, 0, '2025-07-26 11:44:34'),
(59, 38, '../uploads/6884bfa21ae8c_4.jpg', '4.jpg', 294008, 3, 0, '2025-07-26 11:44:34'),
(60, 38, '../uploads/6884bfa21b327_5.jpg', '5.jpg', 261122, 4, 0, '2025-07-26 11:44:34'),
(61, 38, '../uploads/6884bfa21bdf5_6.jpg', '6.jpg', 172557, 5, 0, '2025-07-26 11:44:34'),
(62, 39, '../uploads/6884c63d4e9da_1.jpg', '1.jpg', 78131, 0, 1, '2025-07-26 12:12:45'),
(63, 39, '../uploads/6884c63d4f51a_2.jpg', '2.jpg', 26482, 1, 0, '2025-07-26 12:12:45'),
(64, 39, '../uploads/6884c63d4f87a_3.jpg', '3.jpg', 48245, 2, 0, '2025-07-26 12:12:45'),
(65, 39, '../uploads/6884c63d4fda4_4.jpg', '4.jpg', 80626, 3, 0, '2025-07-26 12:12:45'),
(66, 39, '../uploads/6884c63d50620_5.jpg', '5.jpg', 391657, 4, 0, '2025-07-26 12:12:45'),
(67, 40, '../uploads/6884c7433c747_1.jpg', '1.jpg', 80626, 0, 1, '2025-07-26 12:17:07'),
(68, 40, '../uploads/6884c7433d4fe_2.jpg', '2.jpg', 26482, 1, 0, '2025-07-26 12:17:07'),
(69, 40, '../uploads/6884c7433dba7_3.jpg', '3.jpg', 78131, 2, 0, '2025-07-26 12:17:07'),
(70, 40, '../uploads/6884c7433e2c8_4.jpg', '4.jpg', 391367, 3, 0, '2025-07-26 12:17:07'),
(71, 40, '../uploads/6884c7433eb55_5.jpg', '5.jpg', 48245, 4, 0, '2025-07-26 12:17:07'),
(77, 42, '../uploads/6884e06733058_1.jpg', '1.jpg', 390720, 0, 1, '2025-07-26 14:04:23'),
(78, 42, '../uploads/6884e06734638_2.jpg', '2.jpg', 80626, 1, 0, '2025-07-26 14:04:23'),
(79, 42, '../uploads/6884e06734a5e_3.jpg', '3.jpg', 26482, 2, 0, '2025-07-26 14:04:23'),
(80, 42, '../uploads/6884e06734efa_4.jpg', '4.jpg', 78131, 3, 0, '2025-07-26 14:04:23'),
(81, 42, '../uploads/6884e06735201_5.jpg', '5.jpg', 48245, 4, 0, '2025-07-26 14:04:23'),
(82, 43, '../uploads/6886105f900a1_11.jpeg', '1 (1).jpeg', 7428, 0, 1, '2025-07-27 11:41:19'),
(83, 43, '../uploads/6886105f92569_11.webp', '1 (1).webp', 29336, 1, 0, '2025-07-27 11:41:19'),
(84, 43, '../uploads/6886105f92bb2_12.jpeg', '1 (2).jpeg', 8246, 2, 0, '2025-07-27 11:41:19'),
(85, 43, '../uploads/6886105f92ed7_13.jpeg', '1 (3).jpeg', 10979, 3, 0, '2025-07-27 11:41:19'),
(86, 43, '../uploads/6886105f93208_1.jpg', '1.jpg', 80626, 4, 0, '2025-07-27 11:41:19'),
(87, 43, '../uploads/6886105f93d55_2.jpg', '2.jpg', 26482, 5, 0, '2025-07-27 11:41:19'),
(88, 43, '../uploads/6886105f9409a_3.jpg', '3.jpg', 48245, 6, 0, '2025-07-27 11:41:19'),
(89, 43, '../uploads/6886105f94307_4.jpg', '4.jpg', 78131, 7, 0, '2025-07-27 11:41:19'),
(90, 43, '../uploads/6886105f94901_5.jpg', '5.jpg', 391295, 8, 0, '2025-07-27 11:41:19'),
(91, 44, '../uploads/688612d66921b_1.jpg', '1.jpg', 411644, 0, 1, '2025-07-27 11:51:50'),
(92, 44, '../uploads/688612d66a521_2.jpg', '2.jpg', 394786, 1, 0, '2025-07-27 11:51:50'),
(93, 44, '../uploads/688612d66ae5c_3.jpg', '3.jpg', 386245, 2, 0, '2025-07-27 11:51:50'),
(94, 44, '../uploads/688612d66b69d_4.jpg', '4.jpg', 483751, 3, 0, '2025-07-27 11:51:50'),
(95, 45, '../uploads/688613c291ab0_09-33-25-696_shacman_x6000_8003.jpg', '09-33-25-696_shacman_x6000_8003.jpg', 58314, 0, 1, '2025-07-27 11:55:46'),
(96, 45, '../uploads/688613c2920c8_main.jpg', 'main.jpg', 390521, 1, 0, '2025-07-27 11:55:46'),
(97, 45, '../uploads/688613c2924f9_maxresdefault6000.jpg', 'maxresdefault6000.jpg', 179008, 2, 0, '2025-07-27 11:55:46'),
(98, 45, '../uploads/688613c292c1a_Shacman-X6000-3.jpg', 'Shacman-X6000-3.jpg', 146326, 3, 0, '2025-07-27 11:55:46'),
(99, 46, '../uploads/688619a796e01_1.jpg', '1.jpg', 353752, 0, 1, '2025-07-27 12:20:55'),
(100, 46, '../uploads/688619a7979f4_2.jpg', '2.jpg', 432595, 1, 0, '2025-07-27 12:20:55'),
(101, 46, '../uploads/688619a798067_3.jpg', '3.jpg', 339881, 2, 0, '2025-07-27 12:20:55'),
(102, 46, '../uploads/688619a7983d5_4.jpg', '4.jpg', 356994, 3, 0, '2025-07-27 12:20:55'),
(103, 46, '../uploads/688619a799e42_5.jpg', '5.jpg', 278119, 4, 0, '2025-07-27 12:20:55'),
(104, 47, '../uploads/68861c8ed9611_1.jpg', '1.jpg', 353752, 0, 1, '2025-07-27 12:33:18'),
(105, 47, '../uploads/68861c8ed9fc4_2.jpg', '2.jpg', 432595, 1, 0, '2025-07-27 12:33:18'),
(106, 47, '../uploads/68861c8eda44f_3.jpg', '3.jpg', 339881, 2, 0, '2025-07-27 12:33:18'),
(107, 47, '../uploads/68861c8eda99c_4.jpg', '4.jpg', 356994, 3, 0, '2025-07-27 12:33:18'),
(108, 47, '../uploads/68861c8edb28d_5.jpg', '5.jpg', 278119, 4, 0, '2025-07-27 12:33:18'),
(110, 49, '../uploads/6887651f8f3af_1.jpeg', '1.jpeg', 61819, 0, 1, '2025-07-28 11:55:11'),
(111, 49, '../uploads/6887651f91614_2.jpeg', '2.jpeg', 55548, 1, 0, '2025-07-28 11:55:11'),
(112, 49, '../uploads/6887651f91b26_3.jpeg', '3.jpeg', 53378, 2, 0, '2025-07-28 11:55:11'),
(113, 49, '../uploads/6887651f91e9d_4.jpeg', '4.jpeg', 56582, 3, 0, '2025-07-28 11:55:11'),
(114, 49, '../uploads/6887651f92a2f_5.jpeg', '5.jpeg', 70310, 4, 0, '2025-07-28 11:55:11'),
(115, 49, '../uploads/6887651f938b8_6.jpeg', '6.jpeg', 70142, 5, 0, '2025-07-28 11:55:11'),
(116, 49, '../uploads/6887651f951df_7.jpeg', '7.jpeg', 57189, 6, 0, '2025-07-28 11:55:11'),
(117, 49, '../uploads/6887651f95b2e_8.jpeg', '8.jpeg', 74923, 7, 0, '2025-07-28 11:55:11'),
(118, 49, '../uploads/6887651f95f7e_9.jpeg', '9.jpeg', 61819, 8, 0, '2025-07-28 11:55:11'),
(119, 49, '../uploads/6887651f962b0_10.jpeg', '10.jpeg', 55548, 9, 0, '2025-07-28 11:55:11'),
(120, 50, '../uploads/688789500ce9b_1000026768.jpg', '1000026768.jpg', 72617, 0, 1, '2025-07-28 14:29:36'),
(121, 51, '../uploads/688789bc5688a_1000026764.jpg', '1000026764.jpg', 45707, 0, 1, '2025-07-28 14:31:24'),
(122, 51, '../uploads/688789bc56ff4_1000026765.jpg', '1000026765.jpg', 42361, 1, 0, '2025-07-28 14:31:24'),
(124, 53, '../uploads/68878ba1a9727_1000026766.jpg', '1000026766.jpg', 6564, 0, 1, '2025-07-28 14:39:29'),
(127, 56, '../uploads/6898645c4e963_2019-Toyota-Hilux--Legend-50-GD6-109-2155027_1.jpg', '2019-Toyota-Hilux--Legend-50-GD6-109-2155027_1.jpg', 87636, 0, 1, '2025-08-10 09:20:28'),
(129, 58, '../uploads/6898adead072f_2019-Toyota-Hilux--Legend-50-GD6-109-2155027_1.jpg', '2019-Toyota-Hilux--Legend-50-GD6-109-2155027_1.jpg', 87636, 0, 1, '2025-08-10 14:34:18');

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
(4, 38, '../uploads/6884bfa21c130_X3000.mp4', 'X3000.mp4', 1167891, NULL, '2025-07-26 11:44:34'),
(5, 39, '../uploads/6884c63d50a56_X3000.mp4', 'X3000.mp4', 1167891, NULL, '2025-07-26 12:12:45'),
(6, 40, '../uploads/6884c7433f05d_X3000.mp4', 'X3000.mp4', 1167891, NULL, '2025-07-26 12:17:07'),
(8, 42, '../uploads/6884e0673553e_X3000.mp4', 'X3000.mp4', 1167891, NULL, '2025-07-26 14:04:23'),
(9, 43, '../uploads/6886105f94e27_X3000.mp4', 'X3000.mp4', 1167891, NULL, '2025-07-27 11:41:19'),
(10, 44, '../uploads/688612d66c1a1_ShacmanAfrica6000.mp4', 'Shacman Africa 6000.mp4', 5099232, NULL, '2025-07-27 11:51:50'),
(11, 44, '../uploads/688612d66f32a_ShacmanAfricaFleet.mp4', 'Shacman Africa Fleet.mp4', 1944092, NULL, '2025-07-27 11:51:50'),
(12, 45, '../uploads/688613c292f1e_ShacmanAfrica6000.mp4', 'Shacman Africa 6000.mp4', 5099232, NULL, '2025-07-27 11:55:46'),
(13, 45, '../uploads/688613c29459f_ShacmanAfricaFleet.mp4', 'Shacman Africa Fleet.mp4', 1944092, NULL, '2025-07-27 11:55:46'),
(14, 46, '../uploads/688619a79aaf9_ShacmanAfricaTruck-ReadilyAvailableStock.mp4', 'Shacman Africa Truck - Readily Available Stock.mp4', 1101243, NULL, '2025-07-27 12:20:55');

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
-- Indexes for table `category_analytics`
--
ALTER TABLE `category_analytics`
  ADD PRIMARY KEY (`analytics_id`),
  ADD UNIQUE KEY `unique_category_date` (`category_id`,`date`),
  ADD KEY `idx_date` (`date`),
  ADD KEY `idx_category_id` (`category_id`);

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
-- Indexes for table `dealership_limits`
--
ALTER TABLE `dealership_limits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dealership` (`dealership_id`),
  ADD KEY `idx_dealership` (`dealership_id`);

--
-- Indexes for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_region` (`region`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `featured_vehicles`
--
ALTER TABLE `featured_vehicles`
  ADD PRIMARY KEY (`featured_id`),
  ADD KEY `featured_by` (`featured_by`),
  ADD KEY `idx_vehicle_id` (`vehicle_id`),
  ADD KEY `idx_featured_date` (`featured_date`),
  ADD KEY `idx_featured_until` (`featured_until`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_featured_type` (`featured_type`);

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
-- Indexes for table `premium_ads`
--
ALTER TABLE `premium_ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ad_type` (`ad_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_position` (`position`),
  ADD KEY `idx_display_order` (`display_order`);

--
-- Indexes for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  ADD PRIMARY KEY (`bg_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT for table `auction_bids`
--
ALTER TABLE `auction_bids`
  MODIFY `bid_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6455;

--
-- AUTO_INCREMENT for table `category_analytics`
--
ALTER TABLE `category_analytics`
  MODIFY `analytics_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_makes`
--
ALTER TABLE `category_makes`
  MODIFY `make_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `category_models`
--
ALTER TABLE `category_models`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `category_variants`
--
ALTER TABLE `category_variants`
  MODIFY `variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `dealership_limits`
--
ALTER TABLE `dealership_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=655;

--
-- AUTO_INCREMENT for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `featured_vehicles`
--
ALTER TABLE `featured_vehicles`
  MODIFY `featured_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `premium_ads`
--
ALTER TABLE `premium_ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  MODIFY `bg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rent_to_own_bookings`
--
ALTER TABLE `rent_to_own_bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `subcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8053;

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
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `vehicle_videos`
--
ALTER TABLE `vehicle_videos`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD CONSTRAINT `auction_bids_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `category_analytics`
--
ALTER TABLE `category_analytics`
  ADD CONSTRAINT `category_analytics_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

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
-- Constraints for table `dealer_branches`
--
ALTER TABLE `dealer_branches`
  ADD CONSTRAINT `dealer_branches_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `dealer_sales_team`
--
ALTER TABLE `dealer_sales_team`
  ADD CONSTRAINT `dealer_sales_team_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `featured_vehicles`
--
ALTER TABLE `featured_vehicles`
  ADD CONSTRAINT `featured_vehicles_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `featured_vehicles_ibfk_2` FOREIGN KEY (`featured_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

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
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vehicles_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `dealer_branches` (`branch_id`) ON DELETE SET NULL;

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
