-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2025 at 08:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `radiantdreams1`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Mattress'),
(2, 'Pillow'),
(3, 'Bed'),
(4, 'Bedding');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `first_name`, `last_name`, `username`, `dob`, `gender`, `email`, `phone`, `password`, `address`, `image`) VALUES
(3, 'Milon', 'Dhakal', 'aaa', '2000-11-11', 'male', 'aa@aaaa.com', '9823148709', 'sUPOlSe+Q09GhBp+x9y/u6PfPRG4RjVrZLa5QxNWoNKrxg809ToAl1YbyVhZJIM4RLIjyXSo', 'Gongabu', '/resources/images/profiles/432eecc2-803a-4c3d-abfd-991db2f86b1f.jpg'),
(5, 'Munal', 'Pandey', 'munal', '2000-11-12', 'male', 'munal@gmail.com', '9823148789', '08P9NoWX4wItDyPuOn2ZArTKmI6Cpq4o100i18Q3Y9jVmAbwVqNH/68ZlyogPUO8YOCaQyw9', 'Gongabu', '/resources/images/profiles/060ac3f1-19ff-45ed-b632-e3409ac713ff.png'),
(6, 'Bimarsha', 'Raut', 'bims', '2003-11-12', 'male', 'bimarshaa@gmail.com', '9831248709', 'elOTJI1+p2HmbHETlYy89/+UwHuDHxAWfDk5xrqPZs+eaIocxQjEP4Chh6NuKA9PSdiR6hVV', 'Bhaktapur', '/resources/images/default.png'),
(9, 'Manish', 'Pandey', 'manish', '2005-10-28', 'male', 'manishdhakal12345@gmail.com', '9823148709', 'AshxchZR80vxLo8uvBGsKyk5U4cbaHIcd6Zrz7dMqd4JsiW/3lEv006yQjKtCPIBLocZgQbv', 'Samakhusi', '/resources/images/profiles/3c41c0d5-4cb4-4c92-9ba5-90d0ead81f3d.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_username` varchar(50) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_username`, `order_date`) VALUES
(13, 'manish', '2025-05-16 12:19:39'),
(14, 'manish', '2025-05-16 17:22:56'),
(15, 'manish', '2025-05-16 17:23:10'),
(16, 'manish', '2025-05-16 17:23:13'),
(17, 'manish', '2025-05-16 17:23:21'),
(18, 'manish', '2025-05-16 17:23:27'),
(19, 'munal', '2025-05-16 17:23:56'),
(20, 'munal', '2025-05-16 17:24:04'),
(21, 'munal', '2025-05-16 17:24:12'),
(22, 'manish', '2025-05-18 12:13:35');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`, `status`) VALUES
(13, 13, 2, 3, 'Delivered'),
(14, 14, 4, 2, 'Cancelled'),
(15, 15, 6, 2, 'Out for Delivery'),
(16, 16, 2, 3, 'Cancelled'),
(17, 17, 8, 1, 'Processing'),
(18, 18, 18, 3, 'Processing'),
(19, 19, 2, 1, 'Delivered'),
(20, 20, 16, 1, 'Delivered'),
(21, 21, 26, 1, 'Processing'),
(22, 22, 2, 1, 'Delivered');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT 1,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `category`, `availability`, `image_url`, `quantity`) VALUES
(1, 'DreamCo Mattress', 'Comfortable memory foam mattress.', 15999.00, 'Mattress', 1, '/resources/images/profiles/7c7fafab-cdb0-4a39-9fa9-67e304d4c856.jpeg', 5),
(2, 'CloudRest Pillow', 'Ultra-soft microfiber pillow.', 999.00, 'Pillow', 1, '/resources/images/profiles/ac6bf5eb-5b99-4e27-936f-8c17817e3226.jpg', 5),
(3, 'Royal Bed', 'King size wooden bed with storage.', 25999.00, 'Bed', 1, '/resources/images/profiles/360c941c-22db-4e06-b4da-fa39c8c1871d.jpg', 4),
(4, 'Cotton Beddings Set', 'Pure cotton double bedding set.', 3499.00, 'Bedding', 1, '/resources/images/profiles/55a37c7c-4d4b-46e7-ab28-0a7250a35000.jpg', 13),
(5, 'Orthopedic Mattress', 'Firm orthopedic mattress for back support.', 18999.00, 'Mattress', 1, '/resources/images/profiles/6c715d94-1851-47e9-8c5b-3c64114786f0.jpg', 7),
(6, 'Feather Touch Pillow', 'Feather-filled luxury pillow.', 1499.00, 'Pillow', 1, '/resources/images/profiles/233161be-fbdd-42b7-81ae-8b2dfd4d4774.jpg', 10),
(7, 'Queen Bed', 'Classic queen-sized bed frame.', 19999.00, 'Bed', 1, '/resources/images/profiles/21e19f03-7f52-4f1f-a88f-9e1b0674adaf.webp', 4),
(8, 'Silk Beddings Set', 'Silky-smooth bedding with premium finish.', 4999.00, 'Bedding', 1, '/resources/images/profiles/4bb0d872-e0c2-4825-b543-f9c4635e6bad.jpg', 8),
(9, 'Cooling Gel Mattress', 'Infused with cooling gel for better sleep.', 17999.00, 'Mattress', 1, '/resources/images/profiles/8dadd4a8-7380-47e9-b3a4-b8ed26bc41a9.webp', 6),
(10, 'Ergo Pillow', 'Ergonomic contour pillow.', 1199.00, 'Pillow', 1, '/resources/images/profiles/b7c49601-2f74-4a83-9631-c7c88efd2b22.jpg', 14),
(11, 'Bunk Bed', 'Space-saving bunk bed for kids.', 16999.00, 'Bed', 1, '/resources/images/profiles/2c436b77-74bb-4cf6-a4ca-e09e0c077695.jpeg', 2),
(12, 'Luxury Beddings', 'Egyptian cotton luxury bedding.', 6999.00, 'Bedding', 1, '/resources/images/profiles/be03f614-50ce-494b-8fc4-21676b910ad2.webp', 7),
(13, 'Spring Mattress', 'Medium-soft spring mattress.', 13999.00, 'Mattress', 1, '/resources/images/profiles/839711d1-d4d4-45d3-96c3-36780c60893a.webp', 11),
(14, 'Travel Pillow', 'Compact pillow for travel.', 599.00, 'Pillow', 1, '/resources/images/profiles/b497d358-19aa-4e80-91f7-8f8ec62b97a8.webp', 25),
(15, 'Modern Bed', 'Minimalist modern style bed.', 22999.00, 'Bed', 1, '/resources/images/profiles/50e50958-c33c-47c3-8570-f5bc168bc533.webp', 3),
(16, 'Floral Beddings', 'Colorful floral-printed bedding.', 3999.00, 'Bedding', 1, '/resources/images/profiles/3f19c927-ee46-4f9a-a998-4d64b6d61fa9.jpg', 12),
(17, 'Dual Comfort Mattress', 'Two-sided mattress with soft and firm sides.', 16499.00, 'Mattress', 1, '/resources/images/profiles/f9f6a465-55ac-4c89-8e71-1ef2c4692d33.jpg', 6),
(18, 'Neck Support Pillow', 'Pillow with neck support technology.', 1899.00, 'Pillow', 1, '/resources/images/profiles/5e6a7a07-2e49-44a6-a8bf-64bb9fb5ca54.jpg', 7),
(19, 'Vintage Bed', 'Classic vintage iron bed.', 14999.00, 'Bed', 1, '/resources/images/profiles/eb33d0cc-e37e-4173-b42d-6e1a5c4932d3.webp', 5),
(20, 'Organic Beddings', 'Eco-friendly organic bedding.', 4299.00, 'Bedding', 1, '/resources/images/profiles/50e9ead1-7114-447c-8286-f63512afef12.jpeg', 4),
(21, 'Hybrid Mattress', 'Hybrid mattress with foam and coils.', 17999.00, 'Mattress', 1, '/resources/images/profiles/8314ea0f-7df9-4104-befc-5e1af0e14a7c.jpg', 3),
(22, 'Baby Pillow', 'Soft baby pillow with extra safety.', 499.00, 'Pillow', 1, '/resources/images/profiles/b9f435b8-0313-441e-a2c2-03bb8d8e6c72.jpg', 18),
(23, 'Storage Bed', 'Hydraulic lift bed with storage.', 23999.00, 'Bed', 1, '/resources/images/profiles/7fa518e7-4e65-4e37-83b1-3501006f4ebf.webp', 6),
(24, 'Stripe Beddings', 'Striped pattern double bedding.', 3199.00, 'Bedding', 1, '/resources/images/profiles/e50dfa2d-daa7-4f2e-aeda-901980c62491.jpeg', 10),
(25, 'Roll-Up Mattress', 'Portable roll-up mattress.', 10999.00, 'Mattress', 1, '/resources/images/profiles/97ac4853-850e-446b-8a21-3ec0684d49d4.jpg', 7),
(26, 'Cooling Pillow', 'Pillow with cooling technology.', 1299.00, 'Pillow', 1, '/resources/images/profiles/25ecd0b1-e4b6-4d34-a69a-569c033ebc0f.jpg', 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_username` (`customer_username`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_username`) REFERENCES `customer` (`username`) ON DELETE CASCADE;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
