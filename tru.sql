-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 26, 2025 at 06:59 PM
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
-- Database: `truc_tos`
--

-- --------------------------------------------------------

--
-- Table structure for table `auctions`
--

CREATE TABLE `auctions` (
  `auction_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `starting_bid` decimal(12,2) NOT NULL,
  `current_bid` decimal(12,2) DEFAULT NULL,
  `reserve_price` decimal(12,2) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` enum('upcoming','active','ended','cancelled') DEFAULT 'upcoming',
  `winner_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auction_bids`
--

CREATE TABLE `auction_bids` (
  `bid_id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `bidder_id` int(11) NOT NULL,
  `bid_amount` decimal(12,2) NOT NULL,
  `bid_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_key` varchar(50) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL DEFAULT 'fas fa-tag',
  `listing_label` varchar(100) NOT NULL,
  `mileage_label` varchar(50) DEFAULT 'Mileage (KM)',
  `engine_label` varchar(50) DEFAULT 'Engine Type',
  `show_transmission` tinyint(1) DEFAULT 1,
  `show_fuel_type` tinyint(1) DEFAULT 1,
  `show_year` tinyint(1) DEFAULT 1,
  `transmission_options` text DEFAULT NULL,
  `fuel_options` text DEFAULT NULL,
  `additional_fields` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_key`, `category_name`, `icon`, `listing_label`, `mileage_label`, `engine_label`, `show_transmission`, `show_fuel_type`, `show_year`, `transmission_options`, `fuel_options`, `additional_fields`, `status`, `created_at`, `updated_at`) VALUES
(1, 'trucks', 'Trucks', 'fas fa-truck', 'Truck', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 'manual,automatic,semi-automatic', 'diesel,petrol,hybrid,electric,lpg,cng', '{\"axle_config\":\"Axle Configuration\",\"gvw\":\"GVW (tons)\",\"payload\":\"Payload Capacity\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(2, 'machinery', 'Heavy Machinery', 'fas fa-cogs', 'Heavy Machine', 'Operating Hours', 'Engine Power (HP)', 1, 1, 1, 'hydraulic,powershift,torque_converter,direct_drive', 'diesel,electric,hybrid', '{\"operating_weight\":\"Operating Weight (tons)\",\"bucket_capacity\":\"Bucket Capacity (m³)\",\"max_reach\":\"Max Reach (m)\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(3, 'trailers', 'Trailers', 'fas fa-trailer', 'Trailer', 'Total KM', 'N/A', 0, 0, 1, '', '', '{\"payload_capacity\":\"Payload Capacity (tons)\",\"length\":\"Length (m)\",\"width\":\"Width (m)\",\"axles\":\"Number of Axles\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(4, 'buses', 'Buses', 'fas fa-bus', 'Bus', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 'manual,automatic,semi-automatic', 'diesel,petrol,hybrid,electric,cng', '{\"seating_capacity\":\"Seating Capacity\",\"wheelchair_accessible\":\"Wheelchair Accessible\",\"air_conditioning\":\"Air Conditioning\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(5, 'commercial', 'Commercial Vehicles', 'fas fa-tools', 'Commercial Vehicle', 'Mileage (KM)', 'Engine Type', 1, 1, 1, 'manual,automatic,semi-automatic', 'diesel,petrol,hybrid,electric,lpg', '{\"cargo_volume\":\"Cargo Volume (m³)\",\"max_load\":\"Max Load (kg)\",\"special_equipment\":\"Special Equipment\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(6, 'spares', 'Spares & Accessories', 'fas fa-wrench', 'Spare Part/Accessory', 'N/A', 'Part Number', 0, 0, 0, '', '', '{\"condition\":\"Condition\",\"compatibility\":\"Compatible Models\",\"warranty_period\":\"Warranty Period\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(7, 'farm_equipment', 'Farm Equipment', 'fas fa-tractor', 'Farm Equipment', 'Operating Hours', 'Engine Power (HP)', 1, 1, 1, 'manual,powershift,cvt,hydraulic', 'diesel,petrol,electric,hybrid', '{\"pto_hp\":\"PTO Horsepower\",\"hydraulic_capacity\":\"Hydraulic Capacity (L/min)\",\"working_width\":\"Working Width (m)\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16'),
(8, 'animal_farming', 'Animal Farming Equipment', 'fas fa-cow', 'Animal Farming Equipment', 'N/A', 'Power Requirements', 0, 0, 1, '', '', '{\"capacity\":\"Capacity\",\"power_consumption\":\"Power Consumption (kW)\",\"dimensions\":\"Dimensions (L×W×H)\"}', 'active', '2025-06-06 06:02:16', '2025-06-06 06:02:16');

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
(1, 1, 'Mercedes Benz', 'active', '2025-06-06 06:02:16'),
(2, 1, 'Fuso', 'active', '2025-06-06 06:02:16'),
(3, 1, 'Scania', 'active', '2025-06-06 06:02:16'),
(4, 1, 'Volvo', 'active', '2025-06-06 06:02:16'),
(5, 1, 'MAN', 'active', '2025-06-06 06:02:16'),
(6, 1, 'DAF', 'active', '2025-06-06 06:02:16'),
(7, 1, 'Isuzu', 'active', '2025-06-06 06:02:16'),
(8, 1, 'Hino', 'active', '2025-06-06 06:02:16'),
(9, 1, 'Freightliner', 'active', '2025-06-06 06:02:16'),
(10, 1, 'Peterbilt', 'active', '2025-06-06 06:02:16'),
(11, 2, 'Caterpillar', 'active', '2025-06-06 06:02:16'),
(12, 2, 'Komatsu', 'active', '2025-06-06 06:02:16'),
(13, 2, 'Hitachi', 'active', '2025-06-06 06:02:16'),
(14, 2, 'Volvo', 'active', '2025-06-06 06:02:16'),
(15, 2, 'JCB', 'active', '2025-06-06 06:02:16'),
(16, 2, 'Case', 'active', '2025-06-06 06:02:16'),
(17, 2, 'New Holland', 'active', '2025-06-06 06:02:16'),
(18, 2, 'Liebherr', 'active', '2025-06-06 06:02:16'),
(19, 2, 'Doosan', 'active', '2025-06-06 06:02:16'),
(20, 2, 'Hyundai', 'active', '2025-06-06 06:02:16'),
(21, 3, 'Krone', 'active', '2025-06-06 06:02:16'),
(22, 3, 'Schmitz', 'active', '2025-06-06 06:02:16'),
(23, 3, 'Wielton', 'active', '2025-06-06 06:02:16'),
(24, 3, 'Kogel', 'active', '2025-06-06 06:02:16'),
(25, 3, 'Fruehauf', 'active', '2025-06-06 06:02:16'),
(26, 3, 'Great Dane', 'active', '2025-06-06 06:02:16'),
(27, 3, 'Utility', 'active', '2025-06-06 06:02:16'),
(28, 3, 'Wabash', 'active', '2025-06-06 06:02:16'),
(29, 3, 'Hyundai', 'active', '2025-06-06 06:02:16'),
(30, 3, 'Steelbro', 'active', '2025-06-06 06:02:16'),
(31, 4, 'Mercedes Benz', 'active', '2025-06-06 06:02:16'),
(32, 4, 'Volvo', 'active', '2025-06-06 06:02:16'),
(33, 4, 'Scania', 'active', '2025-06-06 06:02:16'),
(34, 4, 'MAN', 'active', '2025-06-06 06:02:16'),
(35, 4, 'Iveco', 'active', '2025-06-06 06:02:16'),
(36, 4, 'Yutong', 'active', '2025-06-06 06:02:16'),
(37, 4, 'King Long', 'active', '2025-06-06 06:02:16'),
(38, 4, 'Golden Dragon', 'active', '2025-06-06 06:02:16'),
(39, 4, 'Isuzu', 'active', '2025-06-06 06:02:16'),
(40, 4, 'Hino', 'active', '2025-06-06 06:02:16'),
(41, 5, 'Ford', 'active', '2025-06-06 06:02:16'),
(42, 5, 'Mercedes Benz', 'active', '2025-06-06 06:02:16'),
(43, 5, 'Iveco', 'active', '2025-06-06 06:02:16'),
(44, 5, 'Fiat', 'active', '2025-06-06 06:02:16'),
(45, 5, 'Peugeot', 'active', '2025-06-06 06:02:16'),
(46, 5, 'Renault', 'active', '2025-06-06 06:02:16'),
(47, 5, 'Volkswagen', 'active', '2025-06-06 06:02:16'),
(48, 5, 'Isuzu', 'active', '2025-06-06 06:02:16'),
(49, 5, 'Nissan', 'active', '2025-06-06 06:02:16'),
(50, 5, 'Toyota', 'active', '2025-06-06 06:02:16'),
(51, 6, 'OEM', 'active', '2025-06-06 06:02:16'),
(52, 6, 'Bosch', 'active', '2025-06-06 06:02:16'),
(53, 6, 'Continental', 'active', '2025-06-06 06:02:16'),
(54, 6, 'ZF', 'active', '2025-06-06 06:02:16'),
(55, 6, 'Sachs', 'active', '2025-06-06 06:02:16'),
(56, 6, 'Knorr-Bremse', 'active', '2025-06-06 06:02:16'),
(57, 6, 'Wabco', 'active', '2025-06-06 06:02:16'),
(58, 6, 'Hella', 'active', '2025-06-06 06:02:16'),
(59, 6, 'Valeo', 'active', '2025-06-06 06:02:16'),
(60, 6, 'Gates', 'active', '2025-06-06 06:02:16'),
(61, 7, 'John Deere', 'active', '2025-06-06 06:02:16'),
(62, 7, 'Case IH', 'active', '2025-06-06 06:02:16'),
(63, 7, 'New Holland', 'active', '2025-06-06 06:02:16'),
(64, 7, 'Massey Ferguson', 'active', '2025-06-06 06:02:16'),
(65, 7, 'Fendt', 'active', '2025-06-06 06:02:16'),
(66, 7, 'Kubota', 'active', '2025-06-06 06:02:16'),
(67, 7, 'Claas', 'active', '2025-06-06 06:02:16'),
(68, 7, 'Deutz-Fahr', 'active', '2025-06-06 06:02:16'),
(69, 7, 'Valtra', 'active', '2025-06-06 06:02:16'),
(70, 7, 'McCormick', 'active', '2025-06-06 06:02:16'),
(71, 8, 'DeLaval', 'active', '2025-06-06 06:02:16'),
(72, 8, 'GEA', 'active', '2025-06-06 06:02:16'),
(73, 8, 'Lely', 'active', '2025-06-06 06:02:16'),
(74, 8, 'BouMatic', 'active', '2025-06-06 06:02:16'),
(75, 8, 'Fullwood', 'active', '2025-06-06 06:02:16'),
(76, 8, 'SAC', 'active', '2025-06-06 06:02:16'),
(77, 8, 'Dairymaster', 'active', '2025-06-06 06:02:16'),
(78, 8, 'Milkplan', 'active', '2025-06-06 06:02:16'),
(79, 8, 'Waikato', 'active', '2025-06-06 06:02:16'),
(80, 8, 'InterPuls', 'active', '2025-06-06 06:02:16'),
(81, 1, 'Shacman', 'active', '2025-06-24 21:08:39');

-- --------------------------------------------------------

--
-- Table structure for table `finance_applications`
--

CREATE TABLE `finance_applications` (
  `application_id` int(11) NOT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `annual_income` decimal(12,2) DEFAULT NULL,
  `loan_amount` decimal(12,2) DEFAULT NULL,
  `loan_term` int(11) DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT NULL,
  `credit_score_range` varchar(20) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `finance_applications`
--

INSERT INTO `finance_applications` (`application_id`, `vehicle_id`, `full_name`, `email`, `phone`, `annual_income`, `loan_amount`, `loan_term`, `employment_status`, `credit_score_range`, `status`, `created_at`) VALUES
(1, NULL, 'Brian Kasongo', 'admin@truckonsale.co.za', '0776828793', 3699.00, 8000.00, 12, 'employed', 'excellent', 'pending', '2025-06-24 01:26:29');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `inquiry_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `status` enum('new','contacted','closed') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`inquiry_id`, `vehicle_id`, `dealer_id`, `full_name`, `email`, `phone`, `message`, `status`, `created_at`) VALUES
(1, 6, 5, 'Tembo Felix', 'brianmwilakasongo@gmail.com', '0776828793', 'I am interested in this  Hella compactor. Please contact me with more information.', 'new', '2025-06-24 00:46:00'),
(2, 6, 5, 'Tembo Felix', 'admin@truckonsale.co.za', '0776828793', 'I am interested in this  Hella compactor. Please contact me with more information.', 'new', '2025-06-24 01:25:50'),
(3, 7, 5, 'Tembo Felix', 'admin@truckonsale.co.za', '260776828793', 'I am interested in this 2013 Krone S Trailers. Please contact me with more information.', 'new', '2025-06-24 01:35:30'),
(4, 7, 5, 'Brian Kasongo', 'brianmwilakasongo@gmail.com', '0776828793', 'I am interested in this 2013 Krone S Trailers. Please contact me with more information.', 'new', '2025-06-24 01:36:39'),
(5, 7, 5, 'Brian Kasongo', 'brianmwilakasongo@gmail.com', '0776828793', 'I am interested in this 2013 Krone S Trailers. Please contact me with more information.', 'new', '2025-06-24 01:45:20'),
(6, 6, 5, 'Xxx', 'admin@gmail.com', '07770812503', 'I am interested in this  Hella compactor. Please contact me with more information.', 'new', '2025-06-24 05:06:35'),
(7, 3, 5, 'Luapula', 'b@gmail.com', '0776828796', 'I am interested in this 2021 Toyota Hilux Legend . Please contact me with more information.', 'new', '2025-06-24 08:18:55'),
(8, 6, 5, 'Tembo Felix', 'brianmwilakasongo@gmail.com', '260776828793', 'I am interested in this  Hella compactor. Please contact me with more information.', 'new', '2025-06-24 09:23:15');

-- --------------------------------------------------------

--
-- Table structure for table `premium_backgrounds`
--

CREATE TABLE `premium_backgrounds` (
  `bg_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `advertiser_name` varchar(100) DEFAULT NULL,
  `advertiser_contact` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `priority` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `premium_backgrounds`
--

INSERT INTO `premium_backgrounds` (`bg_id`, `image_path`, `title`, `advertiser_name`, `advertiser_contact`, `start_date`, `end_date`, `status`, `priority`, `created_at`) VALUES
(4, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Premium Background 1', NULL, NULL, NULL, NULL, 'active', 1, '2025-06-24 10:27:02'),
(5, 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80', 'Premium Background 2', NULL, NULL, NULL, NULL, 'active', 2, '2025-06-24 10:27:02');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `subcategory_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_key` varchar(50) NOT NULL,
  `subcategory_name` varchar(100) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`subcategory_id`, `category_id`, `subcategory_key`, `subcategory_name`, `status`, `created_at`) VALUES
(1, 1, 'long_haul', 'Long Haul Trucks', 'active', '2025-06-06 06:02:16'),
(2, 1, 'medium_duty', 'Medium Duty Trucks', 'active', '2025-06-06 06:02:16'),
(3, 1, 'heavy_duty', 'Heavy Duty Trucks', 'active', '2025-06-06 06:02:16'),
(4, 1, 'tipper', 'Tipper Trucks', 'active', '2025-06-06 06:02:16'),
(5, 1, 'tanker', 'Tanker Trucks', 'active', '2025-06-06 06:02:16'),
(6, 1, 'refrigerated', 'Refrigerated Trucks', 'active', '2025-06-06 06:02:16'),
(7, 1, 'flatbed', 'Flatbed Trucks', 'active', '2025-06-06 06:02:16'),
(8, 1, 'box_truck', 'Box Trucks', 'active', '2025-06-06 06:02:16'),
(9, 1, 'concrete_mixer', 'Concrete Mixer Trucks', 'active', '2025-06-06 06:02:16'),
(10, 1, 'garbage_truck', 'Garbage Trucks', 'active', '2025-06-06 06:02:16'),
(11, 1, 'tow_truck', 'Tow Trucks', 'active', '2025-06-06 06:02:16'),
(12, 2, 'excavator', 'Excavators', 'active', '2025-06-06 06:02:16'),
(13, 2, 'bulldozer', 'Bulldozers', 'active', '2025-06-06 06:02:16'),
(14, 2, 'wheel_loader', 'Wheel Loaders', 'active', '2025-06-06 06:02:16'),
(15, 2, 'backhoe_loader', 'Backhoe Loaders', 'active', '2025-06-06 06:02:16'),
(16, 2, 'skid_steer', 'Skid Steer Loaders', 'active', '2025-06-06 06:02:16'),
(17, 2, 'motor_grader', 'Motor Graders', 'active', '2025-06-06 06:02:16'),
(18, 2, 'compactor', 'Compactors', 'active', '2025-06-06 06:02:16'),
(19, 2, 'crane', 'Mobile Cranes', 'active', '2025-06-06 06:02:16'),
(20, 2, 'forklift', 'Forklifts', 'active', '2025-06-06 06:02:16'),
(21, 2, 'telehandler', 'Telehandlers', 'active', '2025-06-06 06:02:16'),
(22, 2, 'drilling_rig', 'Drilling Rigs', 'active', '2025-06-06 06:02:16'),
(23, 3, 'flatbed_trailer', 'Flatbed Trailers', 'active', '2025-06-06 06:02:16'),
(24, 3, 'lowboy_trailer', 'Lowboy Trailers', 'active', '2025-06-06 06:02:16'),
(25, 3, 'tipper_trailer', 'Tipper Trailers', 'active', '2025-06-06 06:02:16'),
(26, 3, 'refrigerated_trailer', 'Refrigerated Trailers', 'active', '2025-06-06 06:02:16'),
(27, 3, 'tank_trailer', 'Tank Trailers', 'active', '2025-06-06 06:02:16'),
(28, 3, 'car_carrier', 'Car Carrier Trailers', 'active', '2025-06-06 06:02:16'),
(29, 3, 'livestock_trailer', 'Livestock Trailers', 'active', '2025-06-06 06:02:16'),
(30, 3, 'container_trailer', 'Container Trailers', 'active', '2025-06-06 06:02:16'),
(31, 3, 'curtain_side', 'Curtain Side Trailers', 'active', '2025-06-06 06:02:16'),
(32, 3, 'logging_trailer', 'Logging Trailers', 'active', '2025-06-06 06:02:16'),
(33, 4, 'city_bus', 'City Buses', 'active', '2025-06-06 06:02:16'),
(34, 4, 'intercity_bus', 'Intercity Buses', 'active', '2025-06-06 06:02:16'),
(35, 4, 'school_bus', 'School Buses', 'active', '2025-06-06 06:02:16'),
(36, 4, 'tourist_bus', 'Tourist Buses', 'active', '2025-06-06 06:02:16'),
(37, 4, 'minibus', 'Minibuses', 'active', '2025-06-06 06:02:16'),
(38, 4, 'shuttle_bus', 'Shuttle Buses', 'active', '2025-06-06 06:02:16'),
(39, 4, 'articulated_bus', 'Articulated Buses', 'active', '2025-06-06 06:02:16'),
(40, 4, 'double_decker', 'Double Decker Buses', 'active', '2025-06-06 06:02:16'),
(41, 5, 'panel_van', 'Panel Vans', 'active', '2025-06-06 06:02:16'),
(42, 5, 'water_pump', 'Water Pumps', 'active', '2025-06-06 06:02:16'),
(43, 5, 'winch_truck', 'Winch Trucks', 'active', '2025-06-06 06:02:16'),
(44, 5, 'fuel_pump', 'Fuel Pumps', 'active', '2025-06-06 06:02:16'),
(45, 5, 'fire_truck', 'Fire Trucks', 'active', '2025-06-06 06:02:16'),
(46, 5, 'ambulance', 'Ambulances', 'active', '2025-06-06 06:02:16'),
(47, 5, 'food_truck', 'Food Trucks', 'active', '2025-06-06 06:02:16'),
(48, 5, 'mobile_workshop', 'Mobile Workshops', 'active', '2025-06-06 06:02:16'),
(49, 5, 'vacuum_truck', 'Vacuum Trucks', 'active', '2025-06-06 06:02:16'),
(50, 5, 'street_sweeper', 'Street Sweepers', 'active', '2025-06-06 06:02:16'),
(51, 5, 'cherry_picker', 'Cherry Pickers', 'active', '2025-06-06 06:02:16'),
(52, 6, 'engine_parts', 'Engine Parts', 'active', '2025-06-06 06:02:16'),
(53, 6, 'transmission_parts', 'Transmission Parts', 'active', '2025-06-06 06:02:16'),
(54, 6, 'brake_parts', 'Brake Parts', 'active', '2025-06-06 06:02:16'),
(55, 6, 'electrical_parts', 'Electrical Parts', 'active', '2025-06-06 06:02:16'),
(56, 6, 'body_parts', 'Body Parts', 'active', '2025-06-06 06:02:16'),
(57, 6, 'tires_wheels', 'Tires & Wheels', 'active', '2025-06-06 06:02:16'),
(58, 6, 'filters', 'Filters', 'active', '2025-06-06 06:02:16'),
(59, 6, 'batteries', 'Batteries', 'active', '2025-06-06 06:02:16'),
(60, 6, 'lights', 'Lights & Signals', 'active', '2025-06-06 06:02:16'),
(61, 6, 'mirrors', 'Mirrors', 'active', '2025-06-06 06:02:16'),
(62, 6, 'seats', 'Seats', 'active', '2025-06-06 06:02:16'),
(63, 7, 'tractor', 'Tractors', 'active', '2025-06-06 06:02:16'),
(64, 7, 'combine_harvester', 'Combine Harvesters', 'active', '2025-06-06 06:02:16'),
(65, 7, 'plough', 'Ploughs', 'active', '2025-06-06 06:02:16'),
(66, 7, 'harrow', 'Harrows', 'active', '2025-06-06 06:02:16'),
(67, 7, 'planter', 'Planters', 'active', '2025-06-06 06:02:16'),
(68, 7, 'sprayer', 'Sprayers', 'active', '2025-06-06 06:02:16'),
(69, 7, 'mower', 'Mowers', 'active', '2025-06-06 06:02:16'),
(70, 7, 'baler', 'Balers', 'active', '2025-06-06 06:02:16'),
(71, 7, 'cultivator', 'Cultivators', 'active', '2025-06-06 06:02:16'),
(72, 7, 'thresher', 'Threshers', 'active', '2025-06-06 06:02:16'),
(73, 7, 'irrigation_equipment', 'Irrigation Equipment', 'active', '2025-06-06 06:02:16'),
(74, 8, 'milking_equipment', 'Milking Equipment', 'active', '2025-06-06 06:02:16'),
(75, 8, 'feeding_equipment', 'Feeding Equipment', 'active', '2025-06-06 06:02:16'),
(76, 8, 'livestock_trailer', 'Livestock Trailers', 'active', '2025-06-06 06:02:16'),
(77, 8, 'water_systems', 'Water Systems', 'active', '2025-06-06 06:02:16'),
(78, 8, 'fencing', 'Fencing & Gates', 'active', '2025-06-06 06:02:16'),
(79, 8, 'barn_equipment', 'Barn Equipment', 'active', '2025-06-06 06:02:16'),
(80, 8, 'manure_spreader', 'Manure Spreaders', 'active', '2025-06-06 06:02:16'),
(81, 8, 'cattle_crush', 'Cattle Crushes', 'active', '2025-06-06 06:02:16'),
(82, 8, 'sheep_equipment', 'Sheep Equipment', 'active', '2025-06-06 06:02:16'),
(83, 8, 'poultry_equipment', 'Poultry Equipment', 'active', '2025-06-06 06:02:16'),
(84, 1, 'truck', 'Truck', 'active', '2025-06-24 20:56:48'),
(85, 1, 'truck_tractors', 'Truck Tractors', 'active', '2025-06-24 20:58:00'),
(86, 1, 'dropside_trucks', 'Dropside Trucks', 'active', '2025-06-24 20:59:40'),
(87, 1, 'chassis_cab_trucks', 'Chassis Cab Trucks', 'active', '2025-06-24 21:00:53'),
(88, 1, 'water_bowser', 'Water Bowser Trucks', 'active', '2025-06-24 21:02:42'),
(89, 1, 'crane_trucks', 'Crane Trucks', 'active', '2025-06-24 21:03:38'),
(90, 1, 'curtain_side_truck', 'Curtain Side Truck', 'active', '2025-06-24 21:05:17'),
(91, 1, 'roll_back_truck', 'Rollback Truck', 'active', '2025-06-24 21:06:36');

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
  `user_type` enum('customer','dealer','admin') DEFAULT 'customer',
  `status` enum('pending','active','suspended','rejected') DEFAULT 'active',
  `registered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `phone`, `company_name`, `user_type`, `status`, `registered_at`) VALUES
(2, 'bmk', 'brianmwilakasongo@gmail.com', '$2y$10$TzZF8fP/7.bDqUnjRdM0jOaFoTnLlqY4ja3xaXJ5mLYlVLcSZxI0W', '0776828793', 'BMK Marketing', 'dealer', 'active', '2025-06-23 19:24:45'),
(3, '0', 'a@za', '$2y$10$Io9N4uI4PyIJSJsnDzqYr.Fc6mCL658HaNpdRaQ6Y2lVTg07MjFA2', '0776828793', 'BMK Marketing G', 'admin', 'active', '2025-06-23 20:34:28'),
(5, '88', 't@gmail.com', '$2y$10$YsBEb09zwGqdq7SULAlsNubPUa2m8gfDYCqsZAdWE1vtFmjjF/MCG', '0776828793', 'Jelumu Zambia Trucks ', 'dealer', 'suspended', '2025-06-23 20:41:05'),
(6, 'shacman', 'shacman@bizlive.co.za', '$2y$10$/GmVMudBr8Y5f6/Q3Stg8.YMdS88hi3BqprdkmTzopVCzUDQYqS4W', '+27-83-247-4026', 'Shacman TnT', 'dealer', 'active', '2025-06-24 20:49:16'),
(7, 'sinoplant', 'sinoplant@bizlive.co.za', '$2y$10$hKpVOHTtn7It1gcq9x3iB.zMCKJWv8.OOA1XBgKsXQyMe9p9VjOq2', '+27-83-247-4026', 'Sino Plant', 'dealer', 'active', '2025-06-24 22:41:59'),
(8, 'truckstore', 'truckstore@bizlive.co.za', '$2y$10$6PmTvn6zEsclLPhfQvi2UeT1zBRN6BqkrKGqk504emEkMp3w2rUyu', '+27-83-247-4026', 'Truck Store Centurion', 'dealer', 'active', '2025-06-24 23:21:39');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` int(11) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `subcategory` varchar(50) DEFAULT NULL,
  `make` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `mileage` int(11) DEFAULT 0,
  `engine_type` varchar(50) DEFAULT NULL,
  `transmission` varchar(50) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `region` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `no_accidents` tinyint(1) DEFAULT 0,
  `warranty` tinyint(1) DEFAULT 0,
  `finance_available` tinyint(1) DEFAULT 0,
  `trade_in` tinyint(1) DEFAULT 0,
  `service_history` tinyint(1) DEFAULT 0,
  `roadworthy` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `status` enum('available','sold','reserved') DEFAULT 'available',
  `views` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vehicle_id`, `dealer_id`, `category`, `subcategory`, `make`, `model`, `year`, `price`, `mileage`, `engine_type`, `transmission`, `fuel_type`, `color`, `region`, `city`, `no_accidents`, `warranty`, `finance_available`, `trade_in`, `service_history`, `roadworthy`, `description`, `featured`, `status`, `views`, `created_at`) VALUES
(3, 5, 'commercial', 'food_truck', 'Toyota', 'Hilux Legend ', 2021, 680000.00, 6800, '66', 'automatic', 'diesel', 'Blue', 'Gauteng', 'Lusaka ', 0, 0, 0, 0, 0, 0, NULL, 0, 'available', 10, '2025-06-23 21:43:25'),
(4, 5, 'trailers', 'livestock_trailer', 'Kogel', 'UD330 Compactor', 2012, 53210.00, 8000, NULL, NULL, NULL, 'Brown ', 'Gauteng', 'Lusaka ', 0, 1, 0, 1, 1, 1, NULL, 0, 'available', 5, '2025-06-23 21:45:16'),
(5, 5, 'machinery', 'bulldozer', 'Doosan', 'bbb', 2012, 6988.00, 80, '66', 'torque_converter', 'diesel', 'Brown ', 'Gauteng', 'Lusaka ', 0, 1, 0, 1, 0, 1, NULL, 0, 'available', 11, '2025-06-23 21:49:00'),
(6, 5, 'spares', 'brake_parts', 'Hella', 'compactor', NULL, 80000.00, 69, '76', NULL, NULL, 'Brown ', 'Gauteng', 'Lusaka ', 1, 1, 1, 1, 1, 1, NULL, 0, 'available', 37, '2025-06-24 00:32:15'),
(7, 5, 'trailers', 'flatbed_trailer', 'Krone', 'S Trailers', 2013, 2300.00, 32, '66', NULL, NULL, 'Brown ', 'Gauteng', 'yy', 1, 1, 1, 1, 1, 1, NULL, 0, 'available', 13, '2025-06-24 01:34:17'),
(8, 6, 'trucks', 'truck', 'Shacman', 'X3000', 2025, 900000.00, 0, NULL, 'automatic', 'diesel', 'White', 'Gauteng', 'Kempton Park', 1, 1, 1, 1, 1, 1, NULL, 0, 'available', 4, '2025-06-24 21:37:23'),
(9, 6, 'trucks', 'truck', 'Shacman', 'X3000', 2025, 950000.00, 0, '430', 'semi-automatic', 'diesel', 'White', 'Gauteng', 'Kempton Park', 1, 1, 1, 1, 1, 1, NULL, 0, 'available', 2, '2025-06-24 21:55:05'),
(10, 6, 'trucks', 'truck', 'Shacman', 'X3000', 2025, 1200000.00, 5, '450', 'semi-automatic', 'diesel', 'White', 'Gauteng', 'Kempton Park', 1, 1, 1, 1, 0, 1, NULL, 0, 'available', 6, '2025-06-24 22:02:06'),
(11, 6, 'trucks', 'truck', 'Shacman', 'X3000', 2025, 1300000.00, 0, '600', 'semi-automatic', 'diesel', 'White', 'Gauteng', 'Kempton Park', 1, 1, 1, 1, 1, 1, NULL, 0, 'available', 7, '2025-06-24 22:10:56'),
(12, 7, 'trailers', 'logging_trailer', 'Fruehauf', 'Refurbished Aircraft K Loader', NULL, 350000.00, 0, NULL, NULL, NULL, 'White', 'Gauteng', 'Kempton Park', 0, 1, 1, 0, 0, 1, NULL, 0, 'available', 3, '2025-06-24 23:05:18'),
(13, 7, 'trailers', 'lowboy_trailer', 'Utility', 'Used Droptail Loadbody ', NULL, 359999.00, 0, NULL, NULL, NULL, 'White', 'Gauteng', 'Pretoria', 0, 0, 0, 0, 0, 0, NULL, 0, 'available', 2, '2025-06-24 23:14:06'),
(14, 7, 'trailers', 'tank_trailer', 'Fruehauf', 'Used Fiber glass water trailer 910 L', NULL, 9500.00, 0, NULL, NULL, NULL, NULL, 'Gauteng', 'Pretoria', 0, 0, 0, 0, 0, 0, NULL, 0, 'available', 2, '2025-06-24 23:17:55');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_documents`
--

CREATE TABLE `vehicle_documents` (
  `document_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `document_path` varchar(255) NOT NULL,
  `document_type` varchar(10) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `vehicle_documents`
--

INSERT INTO `vehicle_documents` (`document_id`, `vehicle_id`, `document_name`, `document_path`, `document_type`, `uploaded_at`) VALUES
(1, 4, 'PG_Application_Form.pdf', 'uploads/6859caec58a4e_PG_Application_Form.pdf', 'pdf', '2025-06-23 21:45:16'),
(2, 6, 'PG_Application_Form.pdf', 'uploads/6859f20f8779f_PG_Application_Form.pdf', 'pdf', '2025-06-24 00:32:15'),
(3, 7, 'PG_Application_Form.pdf', 'uploads/685a0099f0618_PG_Application_Form.pdf', 'pdf', '2025-06-24 01:34:17'),
(4, 9, 'Shacman.pdf', 'uploads/685b1eb994ba2_Shacman.pdf', 'pdf', '2025-06-24 21:55:05'),
(5, 10, 'Shacman.pdf', 'uploads/685b205e88dda_Shacman.pdf', 'pdf', '2025-06-24 22:02:06'),
(6, 11, 'Shacman.pdf', 'uploads/685b22701f782_Shacman.pdf', 'pdf', '2025-06-24 22:10:56');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_images`
--

CREATE TABLE `vehicle_images` (
  `image_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `vehicle_images`
--

INSERT INTO `vehicle_images` (`image_id`, `vehicle_id`, `image_path`, `is_primary`, `uploaded_at`) VALUES
(3, 3, 'uploads/6859ca7d0fc9e_FB_IMG_17488500528105831.jpg', 1, '2025-06-23 21:43:25'),
(4, 3, 'uploads/6859ca7d13c88_FB_IMG_17488500528065593.jpg', 0, '2025-06-23 21:43:25'),
(5, 3, 'uploads/6859ca7d145f5_FB_IMG_17488486925255030.jpg', 0, '2025-06-23 21:43:25'),
(6, 3, 'uploads/6859ca7d16ba7_FB_IMG_17488486785651324.jpg', 0, '2025-06-23 21:43:25'),
(7, 4, 'uploads/6859caec55fc4_FB_IMG_17488486925255030.jpg', 1, '2025-06-23 21:45:16'),
(8, 4, 'uploads/6859caec585fa_FB_IMG_17488486785651324.jpg', 0, '2025-06-23 21:45:16'),
(9, 5, 'uploads/6859cbccc679b_IMG-20250623-WA0007.jpg', 1, '2025-06-23 21:49:00'),
(10, 6, 'uploads/6859f20f8653a_FB_IMG_17507212006559575.jpg', 1, '2025-06-24 00:32:15'),
(11, 7, 'uploads/685a0099edf65_bharatbenz-5028tt-50-ton-heavy-duty-haulage-truck.jpg', 1, '2025-06-24 01:34:17'),
(12, 7, 'uploads/685a0099eeea5_download7.jpeg', 0, '2025-06-24 01:34:17'),
(13, 7, 'uploads/685a0099ef21a_images2.jpeg', 0, '2025-06-24 01:34:17'),
(14, 8, 'uploads/685b1a93c8881_6x4-configuration.jpg', 1, '2025-06-24 21:37:23'),
(15, 8, 'uploads/685b1a93cc121_Fuel-Capacity-980.jpg', 0, '2025-06-24 21:37:23'),
(16, 8, 'uploads/685b1a93cc9b5_Gallery_1.jpg', 0, '2025-06-24 21:37:23'),
(17, 8, 'uploads/685b1a93cce91_Gallery_2.jpg', 0, '2025-06-24 21:37:23'),
(18, 8, 'uploads/685b1a93ce604_Gallery_3.jpg', 0, '2025-06-24 21:37:23'),
(19, 8, 'uploads/685b1a93cf006_Gallery_5.jpg', 0, '2025-06-24 21:37:23'),
(20, 8, 'uploads/685b1a93cfe09_Gallery_6.jpg', 0, '2025-06-24 21:37:23'),
(21, 8, 'uploads/685b1a93d0984_Gallery_7.jpg', 0, '2025-06-24 21:37:23'),
(22, 8, 'uploads/685b1a93d0ead_Gallery_8.jpg', 0, '2025-06-24 21:37:23'),
(23, 8, 'uploads/685b1a93d19c7_Gallery_10.jpg', 0, '2025-06-24 21:37:23'),
(24, 8, 'uploads/685b1a93d1ebd_Gallery_11.jpg', 0, '2025-06-24 21:37:23'),
(25, 8, 'uploads/685b1a93d2a8b_Gallery_12.jpg', 0, '2025-06-24 21:37:23'),
(26, 8, 'uploads/685b1a93d3e4b_Gallery_13.jpg', 0, '2025-06-24 21:37:23'),
(27, 8, 'uploads/685b1a93d56b0_Gallery_15.jpg', 0, '2025-06-24 21:37:23'),
(28, 8, 'uploads/685b1a93d677b_GVM-34000-1.jpg', 0, '2025-06-24 21:37:23'),
(29, 8, 'uploads/685b1a93d751e_Tare-9020.jpg', 0, '2025-06-24 21:37:23'),
(30, 8, 'uploads/685b1a93d7f1b_X3000-420-Specs-1024x9871.jpg', 0, '2025-06-24 21:37:23'),
(31, 8, 'uploads/685b1a93d8f33_X3000-420-Specs-1024x987.jpg', 0, '2025-06-24 21:37:23'),
(32, 8, 'uploads/685b1a93d9d72_X3000-560-image-2.png', 0, '2025-06-24 21:37:23'),
(33, 8, 'uploads/685b1a93db552_X3000-560-image-full-4-1024x385.jpg', 0, '2025-06-24 21:37:23'),
(34, 9, 'uploads/685b1eb98be81_Gallery_1.jpg', 1, '2025-06-24 21:55:05'),
(35, 9, 'uploads/685b1eb98cbe0_Gallery_2.jpg', 0, '2025-06-24 21:55:05'),
(36, 9, 'uploads/685b1eb98cf41_Gallery_3.jpg', 0, '2025-06-24 21:55:05'),
(37, 9, 'uploads/685b1eb98d1ec_Gallery_5.jpg', 0, '2025-06-24 21:55:05'),
(38, 9, 'uploads/685b1eb98d454_Gallery_6.jpg', 0, '2025-06-24 21:55:05'),
(39, 9, 'uploads/685b1eb98d765_Gallery_7.jpg', 0, '2025-06-24 21:55:05'),
(40, 9, 'uploads/685b1eb98fb30_Gallery_8.jpg', 0, '2025-06-24 21:55:05'),
(41, 9, 'uploads/685b1eb98fee2_Gallery_10.jpg', 0, '2025-06-24 21:55:05'),
(42, 9, 'uploads/685b1eb990240_Gallery_11.jpg', 0, '2025-06-24 21:55:05'),
(43, 9, 'uploads/685b1eb99063b_Gallery_12.jpg', 0, '2025-06-24 21:55:05'),
(44, 9, 'uploads/685b1eb991894_Gallery_15.jpg', 0, '2025-06-24 21:55:05'),
(45, 9, 'uploads/685b1eb99267a_GVM-34000-1.jpg', 0, '2025-06-24 21:55:05'),
(46, 9, 'uploads/685b1eb993030_X3000-560-image-2.png', 0, '2025-06-24 21:55:05'),
(47, 10, 'uploads/685b205e82856_Gallery_6.jpg', 1, '2025-06-24 22:02:06'),
(48, 10, 'uploads/685b205e85641_Gallery_8.jpg', 0, '2025-06-24 22:02:06'),
(49, 10, 'uploads/685b205e85f54_Gallery_11.jpg', 0, '2025-06-24 22:02:06'),
(50, 10, 'uploads/685b205e863b8_Gallery_13.jpg', 0, '2025-06-24 22:02:06'),
(51, 10, 'uploads/685b205e8666f_Gallery_15.jpg', 0, '2025-06-24 22:02:06'),
(52, 10, 'uploads/685b205e86920_GVM-34000-1.jpg', 0, '2025-06-24 22:02:06'),
(53, 10, 'uploads/685b205e86f84_Tare-9020.jpg', 0, '2025-06-24 22:02:06'),
(54, 10, 'uploads/685b205e871cd_X3000-420-Specs-1024x9871.jpg', 0, '2025-06-24 22:02:06'),
(55, 10, 'uploads/685b205e880c3_X3000-420-Specs-1024x987.jpg', 0, '2025-06-24 22:02:06'),
(56, 10, 'uploads/685b205e8843e_X3000-560-image-2.png', 0, '2025-06-24 22:02:06'),
(57, 11, 'uploads/685b22701d23f_GVM-34000-1.jpg', 1, '2025-06-24 22:10:56'),
(58, 11, 'uploads/685b22701dbbc_Tare-9020.jpg', 0, '2025-06-24 22:10:56'),
(59, 12, 'uploads/685b2f2edb174__id_95122489_type_main.jpg', 1, '2025-06-24 23:05:18'),
(60, 12, 'uploads/685b2f2eddfea__id_95122502_type_main.jpg', 0, '2025-06-24 23:05:18'),
(61, 12, 'uploads/685b2f2ede396__id_95122503_type_main.jpg', 0, '2025-06-24 23:05:18'),
(62, 13, 'uploads/685b313ebdbce__id_95121975_type_main.jpg', 1, '2025-06-24 23:14:06'),
(63, 13, 'uploads/685b313ec0182__id_95121976_type_main.jpg', 0, '2025-06-24 23:14:06'),
(64, 13, 'uploads/685b313ec08f7__id_95121977_type_main.jpg', 0, '2025-06-24 23:14:06'),
(65, 13, 'uploads/685b313ec0daa__id_95121978_type_main.jpg', 0, '2025-06-24 23:14:06'),
(66, 14, 'uploads/685b322396257__id_73862217_type_main.jpg', 1, '2025-06-24 23:17:55'),
(67, 14, 'uploads/685b322398f3b__id_73862218_type_main.jpg', 0, '2025-06-24 23:17:55'),
(68, 14, 'uploads/685b3223993f4__id_73862219_type_main.jpg', 0, '2025-06-24 23:17:55'),
(69, 14, 'uploads/685b32239ae35__id_73862220_type_main.jpg', 0, '2025-06-24 23:17:55');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_videos`
--

CREATE TABLE `vehicle_videos` (
  `video_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `video_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `vehicle_videos`
--

INSERT INTO `vehicle_videos` (`video_id`, `vehicle_id`, `video_path`, `uploaded_at`) VALUES
(1, 7, 'uploads/685a0099ef967_VID-20250623-WA0005.mp4', '2025-06-24 01:34:17'),
(2, 9, 'uploads/685b1eb994009_TheImpressiveShacmanX3000.mp4', '2025-06-24 21:55:05'),
(3, 10, 'uploads/685b205e886f1_TheImpressiveShacmanX3000.mp4', '2025-06-24 22:02:06'),
(4, 11, 'uploads/685b22701e059_TheImpressiveShacmanX3000.mp4', '2025-06-24 22:10:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`auction_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `winner_id` (`winner_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_start_time` (`start_time`),
  ADD KEY `idx_end_time` (`end_time`);

--
-- Indexes for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD PRIMARY KEY (`bid_id`),
  ADD KEY `idx_auction` (`auction_id`),
  ADD KEY `idx_bidder` (`bidder_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_key` (`category_key`);

--
-- Indexes for table `category_makes`
--
ALTER TABLE `category_makes`
  ADD PRIMARY KEY (`make_id`),
  ADD UNIQUE KEY `unique_make` (`category_id`,`make_name`);

--
-- Indexes for table `finance_applications`
--
ALTER TABLE `finance_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`inquiry_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  ADD PRIMARY KEY (`bg_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`subcategory_id`),
  ADD UNIQUE KEY `unique_subcategory` (`category_id`,`subcategory_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_region` (`region`),
  ADD KEY `idx_dealer` (`dealer_id`),
  ADD KEY `idx_featured` (`featured`);
ALTER TABLE `vehicles` ADD FULLTEXT KEY `idx_search` (`make`,`model`,`description`);

--
-- Indexes for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`);

--
-- Indexes for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_vehicle` (`vehicle_id`),
  ADD KEY `idx_primary` (`is_primary`);

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
-- AUTO_INCREMENT for table `auctions`
--
ALTER TABLE `auctions`
  MODIFY `auction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auction_bids`
--
ALTER TABLE `auction_bids`
  MODIFY `bid_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=288;

--
-- AUTO_INCREMENT for table `category_makes`
--
ALTER TABLE `category_makes`
  MODIFY `make_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `finance_applications`
--
ALTER TABLE `finance_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hire_bookings`
--
ALTER TABLE `hire_bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `premium_backgrounds`
--
ALTER TABLE `premium_backgrounds`
  MODIFY `bg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `subcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `vehicle_documents`
--
ALTER TABLE `vehicle_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vehicle_images`
--
ALTER TABLE `vehicle_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `vehicle_videos`
--
ALTER TABLE `vehicle_videos`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auctions`
--
ALTER TABLE `auctions`
  ADD CONSTRAINT `auctions_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auctions_ibfk_2` FOREIGN KEY (`winner_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD CONSTRAINT `auction_bids_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`auction_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auction_bids_ibfk_2` FOREIGN KEY (`bidder_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `category_makes`
--
ALTER TABLE `category_makes`
  ADD CONSTRAINT `category_makes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `finance_applications`
--
ALTER TABLE `finance_applications`
  ADD CONSTRAINT `finance_applications_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE SET NULL;

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
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

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
