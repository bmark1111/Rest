-- phpMyAdmin SQL Dump
-- version 4.5.0.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 16, 2015 at 11:37 PM
-- Server version: 10.0.17-MariaDB
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bdm_budget`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_data`
--

CREATE TABLE `app_data` (
  `key` varchar(20) NOT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id`, `name`, `is_deleted`, `updated_by`, `updated_at`, `created_by`, `created_at`) VALUES
(1, 'Chase', 0, 2, '2015-09-03 13:36:31', 2, '2015-09-03 20:36:31'),
(2, 'New Bank', 1, 2, '2015-06-02 08:54:26', 2, '2015-06-02 15:54:26');

-- --------------------------------------------------------

--
-- Table structure for table `bank_account`
--

CREATE TABLE `bank_account` (
  `id` int(11) NOT NULL,
  `bank_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_opened` date NOT NULL,
  `date_closed` date DEFAULT NULL,
  `xxbalance` float(10,2) NOT NULL,
  `balance_transaction_id` int(11) UNSIGNED NOT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bank_account`
--

INSERT INTO `bank_account` (`id`, `bank_id`, `name`, `date_opened`, `date_closed`, `xxbalance`, `balance_transaction_id`, `is_deleted`, `updated_by`, `updated_at`, `created_by`, `created_at`) VALUES
(1, 1, 'Premier', '2014-01-01', NULL, 3026.27, 639, 0, 2, '2015-09-03 13:36:31', 2, '2015-10-17 15:20:03'),
(2, 1, 'Business', '2014-01-01', NULL, 158.05, 640, 0, 2, '2015-09-03 13:36:32', 2, '2015-10-17 15:20:10'),
(3, 2, 'Account 1', '2014-01-01', NULL, 100.00, 0, 1, 2, '2015-06-02 08:54:26', 2, '2015-06-02 15:54:26'),
(4, 2, 'Account 2', '2014-01-01', '2015-05-31', 200.00, 0, 1, 2, '2015-06-02 08:54:26', 2, '2015-06-02 15:54:26'),
(5, 2, 'Account 3', '2014-01-01', NULL, 300.00, 0, 1, 2, '2015-06-02 08:54:26', 2, '2015-06-02 15:54:26'),
(6, 1, 'Savings', '2015-01-01', NULL, 0.09, 641, 0, 2, '2015-09-03 13:36:32', 2, '2015-10-17 15:20:16');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `order` int(2) UNSIGNED NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `order`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'Merrielle', NULL, 17, 0, 2, '2015-04-04 10:03:11', 2, '2015-04-07 15:18:59'),
(2, 'Medical', NULL, 16, 0, 2, '2015-04-04 10:03:11', 2, '2015-04-07 15:18:56'),
(3, 'Gas', NULL, 15, 0, 2, '2015-04-04 10:03:42', 2, '2015-04-07 15:18:52'),
(4, 'Misc', NULL, 14, 0, 2, '2015-04-04 10:03:42', 2, '2015-04-07 15:18:49'),
(5, 'Horse', NULL, 13, 0, 2, '2015-04-04 10:03:58', 2, '2015-04-07 15:18:43'),
(6, 'Groceries', NULL, 12, 0, 2, '2015-04-04 10:03:58', 2, '2015-04-07 15:18:36'),
(7, 'Auto', NULL, 11, 0, 2, '2015-04-04 10:05:02', 2, '2015-04-07 15:18:32'),
(8, 'Gift', NULL, 10, 0, 2, '2015-04-04 10:05:02', 2, '2015-04-07 15:18:29'),
(9, 'Bills', NULL, 9, 0, 2, '2015-04-04 10:05:20', 2, '2015-04-07 15:18:23'),
(10, 'Saving', NULL, 4, 0, 2, '2015-04-04 10:05:20', 2, '2015-04-07 15:18:01'),
(11, 'Accounting', 'Accounting expenses', 8, 0, 2, '2015-04-04 10:05:33', 2, '2015-06-16 22:32:20'),
(12, 'Legal', NULL, 7, 0, 2, '2015-04-04 10:05:33', 2, '2015-04-07 15:18:14'),
(13, 'Income', NULL, 1, 0, 2, '2015-04-04 10:05:45', 2, '2015-06-03 21:28:56'),
(14, 'Misc Income', NULL, 2, 0, 2, '2015-04-04 10:41:00', 2, '2015-04-07 15:17:09'),
(15, 'Lease Payments', NULL, 6, 0, 2, '2015-04-04 10:42:00', 2, '2015-06-03 21:29:02'),
(16, 'Rent', NULL, 5, 0, 2, '2015-04-04 10:41:00', 2, '2015-04-07 15:18:08'),
(17, 'Transfer', NULL, 3, 0, 2, '2015-04-04 10:42:00', 2, '2015-04-07 15:17:24'),
(18, 'Child Support', NULL, 4, 0, 2, '2015-04-24 13:04:00', 2, '2015-04-24 21:03:52'),
(19, 'QWS, Inc', 'Quantum Expenses', 7, 0, 2, '2015-05-19 08:13:00', 2, '2015-05-19 15:12:13'),
(20, 'xxxxx', 'wqwqwqw', 2, 1, 2, '2015-06-16 16:26:39', 2, '2015-06-16 23:29:07'),
(21, 'Spectrom Tech', 'SpectrOM Expenses', 7, 0, 2, '2015-07-09 11:16:31', 2, '2015-07-18 04:05:19'),
(22, 'Opening Account Balance', 'Opening Account balance', 0, 0, 1, '2015-10-17 00:00:00', 1, '2015-11-11 02:20:06');

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `value` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` (`id`, `name`, `value`) VALUES
(1, 'budget_mode', 'bi-weekly'),
(2, 'budget_start_date', '2015-01-01'),
(3, 'budget_views', '1');

-- --------------------------------------------------------

--
-- Table structure for table `forecast`
--

CREATE TABLE `forecast` (
  `id` int(11) NOT NULL,
  `type` enum('DEBIT','CREDIT','CHECK','DSLIP') NOT NULL,
  `every` tinyint(2) UNSIGNED NOT NULL,
  `every_unit` enum('Days','Weeks','Months','Years') NOT NULL,
  `every_on` varchar(20) DEFAULT NULL,
  `first_due_date` date NOT NULL,
  `last_due_date` date DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `bank_account_id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `notes` text,
  `xassign` varchar(50) NOT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `forecast`
--

INSERT INTO `forecast` (`id`, `type`, `every`, `every_unit`, `every_on`, `first_due_date`, `last_due_date`, `description`, `amount`, `bank_account_id`, `category_id`, `notes`, `xassign`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'CREDIT', 2, 'Weeks', NULL, '2015-01-02', '2015-03-27', 'PROOVE BIO SCIENCE', '3364.38', 1, 13, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:16'),
(2, 'DEBIT', 9, 'Days', NULL, '2015-01-02', NULL, 'Gas', '40.00', 1, 3, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-11-06 03:02:33'),
(3, 'DEBIT', 1, 'Weeks', NULL, '2015-01-02', NULL, 'Misc', '150.00', 1, 4, '', '', 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:28:01'),
(4, 'DEBIT', 2, 'Weeks', '', '2015-09-21', NULL, 'Cash Savings', '500.00', 1, 17, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-10-17 16:00:16'),
(5, 'DEBIT', 1, 'Weeks', NULL, '2015-01-02', NULL, 'Groceries', '100.00', 1, 6, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:16'),
(6, 'DEBIT', 1, 'Months', '17', '2015-01-17', NULL, 'AMERINOC', '9.95', 2, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:46'),
(7, 'DEBIT', 1, 'Months', '12', '2015-01-12', NULL, 'NETFLIX.COM', '7.99', 2, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:49'),
(8, 'DEBIT', 1, 'Months', '7', '2015-01-02', '2016-01-31', 'JPMorgan Chase', '333.33', 1, 15, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-10-27 06:16:39'),
(9, 'DEBIT', 1, 'Months', '10', '2015-01-10', NULL, 'Cox Communications', '200.00', 1, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-11-02 00:49:27'),
(10, 'DEBIT', 1, 'Months', '1', '2015-02-01', NULL, 'ConService', '50.00', 1, 9, 'Utility Management & Billing', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-10-31 07:01:01'),
(11, 'DEBIT', 1, 'Months', '12', '2015-01-12', NULL, 'SOUTHERN CALIFORNIA EDISON', '40.00', 1, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-11-02 00:59:40'),
(12, 'DEBIT', 1, 'Months', '12', '2015-01-12', NULL, 'VERIZON WIRELESS', '70.00', 1, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-11-02 00:48:57'),
(13, 'DEBIT', 1, 'Months', '1', '2015-01-01', NULL, 'Anacapa Apartments', '2245.00', 1, 16, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:16'),
(14, 'DEBIT', 1, 'Months', '22', '2015-01-22', NULL, 'SOUTHERN CALIFORNIA GAS', '28.00', 1, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:16'),
(15, 'DEBIT', 1, 'Months', '25', '2015-01-25', NULL, 'APL* ITUNES.COM', '0.99', 1, 9, '', '', 0, 2, '2015-04-04 10:47:30', 2, '2015-09-13 15:36:16'),
(16, 'DEBIT', 1, 'Months', '24', '2015-04-24', NULL, 'Car Insurance', '88.00', 1, 7, NULL, '', 0, 2, '2015-04-14 10:00:00', 2, '2015-10-17 15:55:13'),
(17, 'DEBIT', 1, 'Years', '10-25', '2015-01-02', '2015-04-22', 'Car Insurance', '505.00', 1, 7, NULL, '', 1, 2, '2015-04-14 10:00:00', 2, '2015-09-13 15:36:16'),
(18, 'CREDIT', 1, 'Weeks', NULL, '2015-04-05', NULL, 'UI Benefit', '450.00', 1, 14, NULL, '', 1, 2, '2015-04-21 10:50:00', 2, '2015-09-13 15:36:16'),
(19, 'DEBIT', 1, 'Months', '15', '2015-06-15', NULL, 'Child Support', '312.50', 1, 18, NULL, '', 1, 2, '2015-04-24 14:06:00', 2, '2015-09-13 15:36:16'),
(20, 'DEBIT', 1, 'Months', '22', '2015-06-22', NULL, 'Health Insurance', '866.54', 1, 2, NULL, '', 0, 2, '2015-05-15 12:13:00', 2, '2015-10-31 05:27:12'),
(21, 'CREDIT', 1, 'Months', '1', '2015-06-01', '2015-09-01', 'Health Insurance for Nick & Tash', '300.00', 1, 2, 'From Nicole', '', 0, 2, '2015-05-15 12:24:00', 2, '2015-10-03 17:42:15'),
(22, 'DEBIT', 1, 'Weeks', NULL, '2015-04-27', '2015-06-20', 'dfdfdfdfdfdfdf', '111.00', 1, 12, 'nmnmnmnnmmnm', '', 1, 2, '2015-05-18 14:42:03', 2, '2015-09-13 15:36:16'),
(23, 'DEBIT', 1, 'Months', '3', '2015-08-03', '2015-08-31', 'Child Support', '625.00', 1, 18, NULL, '', 0, 2, '2015-05-19 15:53:38', 2, '2015-09-24 15:18:17'),
(24, 'CREDIT', 1, 'Months', '1', '2015-06-01', NULL, 'Health Ins. for Merrielle', '150.00', 1, 2, 'from Nancy', '', 1, 2, '2015-05-25 10:48:28', 2, '2015-09-13 15:36:16'),
(25, 'CREDIT', 2, 'Weeks', '07-07', '2015-07-14', '2015-08-26', 'UI', '900.00', 1, 14, NULL, '', 0, 2, '2015-06-09 08:49:48', 2, '2015-09-13 15:36:16'),
(26, 'CREDIT', 1, 'Months', '1', '2015-08-01', NULL, 'Spectrum', '7000.00', 1, 13, NULL, '', 1, 2, '2015-06-09 08:55:08', 2, '2015-09-13 15:36:16'),
(27, 'CREDIT', 1, 'Months', '15', '2015-07-15', NULL, 'Spectrum', '3500.00', 1, 13, NULL, '', 1, 2, '2015-06-09 08:56:34', 2, '2015-09-13 15:36:16'),
(28, 'DEBIT', 1, 'Years', '07-07', '2015-07-07', NULL, 'AAA Membership', '48.00', 2, 7, NULL, '', 0, 2, '2015-06-19 09:16:36', 2, '2015-09-13 15:38:27'),
(29, 'DEBIT', 1, 'Years', '07-01', '2015-07-01', NULL, 'Costco Membership', '55.00', 1, 4, NULL, '', 0, 2, '2015-06-19 09:22:42', 2, '2015-09-13 15:36:16'),
(30, 'CREDIT', 1, 'Weeks', '', '2015-08-07', '2015-09-25', 'TotalApps', '1716.93', 1, 13, NULL, '', 0, 2, '2015-08-20 08:41:50', 2, '2015-09-25 22:49:35'),
(31, 'DEBIT', 1, 'Weeks', NULL, '2015-08-13', NULL, 'Savings', '500.00', 1, 10, NULL, '', 1, 2, '2015-08-20 09:03:06', 2, '2015-09-13 15:36:16'),
(32, 'DEBIT', 1, 'Months', '15', '2015-08-15', NULL, 'Prescriptions', '45.00', 1, 2, NULL, '', 0, 2, '2015-08-20 09:07:33', 2, '2015-09-13 15:36:16'),
(33, 'DEBIT', 6, 'Weeks', '', '2015-08-15', NULL, '35 For Life', '150.00', 1, 2, NULL, '', 0, 2, '2015-08-20 09:09:49', 2, '2015-10-17 22:18:53'),
(34, 'DEBIT', 1, 'Months', '8', '2016-02-08', NULL, 'Car Payment', '400.00', 1, 7, NULL, '', 0, 2, '2015-08-20 09:12:39', 2, '2015-09-13 15:36:16'),
(35, 'CREDIT', 2, 'Weeks', NULL, '2015-09-18', NULL, 'MLS Technologies', '3790.00', 1, 13, 'Panasonic Avaiation', '', 0, 2, '2015-09-25 15:51:17', 2, '2015-10-17 15:55:29'),
(36, 'CREDIT', 2, 'Weeks', NULL, '2015-09-21', NULL, 'Cash Savings', '500.00', 6, 17, NULL, '', 0, 2, '2015-09-28 16:37:55', 2, '2015-10-17 16:00:05'),
(37, 'DEBIT', 2, 'Weeks', NULL, '2015-10-02', NULL, 'Investment', '500.00', 1, 10, 'Fidelity', '', 0, 2, '2015-10-17 09:01:59', 2, '2015-10-27 07:23:02'),
(38, 'DEBIT', 2, 'Weeks', '', '2015-10-31', NULL, 'TEST', '11.00', 1, 19, 'TEST', '', 1, 2, '2015-10-18 17:30:52', 2, '2015-10-19 01:11:40');

-- --------------------------------------------------------

--
-- Table structure for table `security_permission`
--

CREATE TABLE `security_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `security_permission`
--

INSERT INTO `security_permission` (`id`, `name`, `created`, `modified`) VALUES
(1, '*', '2010-03-23 19:15:17', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `security_role`
--

CREATE TABLE `security_role` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `security_role`
--

INSERT INTO `security_role` (`id`, `name`, `created`, `modified`) VALUES
(1, 'Super User', '2010-05-14 06:03:29', '0000-00-00 00:00:00'),
(2, 'System Administrator', '2010-05-14 06:03:50', '0000-00-00 00:00:00'),
(3, 'Admin', '2010-05-14 06:04:03', '0000-00-00 00:00:00'),
(4, 'Dashboard User', '2010-06-08 15:51:00', '0000-00-00 00:00:00'),
(5, 'Member', '2010-05-14 06:04:33', '0000-00-00 00:00:00'),
(6, 'Registered Member', '2010-06-08 15:49:49', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `security_role_permission`
--

CREATE TABLE `security_role_permission` (
  `id` int(11) NOT NULL,
  `security_role_id` int(11) NOT NULL,
  `security_permission_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `security_role_permission`
--

INSERT INTO `security_role_permission` (`id`, `security_role_id`, `security_permission_id`, `created`, `modified`) VALUES
(1, 1, 1, '2010-03-23 19:15:17', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `type` enum('DEBIT','CREDIT','CHECK','DSLIP') NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(200) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `bank_account_balance` decimal(10,2) DEFAULT NULL,
  `check_num` varchar(50) DEFAULT NULL,
  `category_id` varchar(50) DEFAULT NULL,
  `notes` text,
  `is_uploaded` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `reconciled_date` date DEFAULT NULL,
  `bank_account_id` int(11) UNSIGNED DEFAULT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `type`, `transaction_date`, `description`, `amount`, `bank_account_balance`, `check_num`, `category_id`, `notes`, `is_uploaded`, `reconciled_date`, `bank_account_id`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'CREDIT', '2015-03-27', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.38', '5403.33', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(2, 'CHECK', '2015-03-27', 'CHECK 214 ', '75.00', '5328.33', '214', '1', 'Sophie Abber - Tutoring', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(3, 'DEBIT', '2015-03-26', 'JOHN CHRISPENS, DD NEWPORT BEACH CA          03/25', '305.00', '2075.00', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(4, 'DEBIT', '2015-03-26', 'COSTCO GAS #0454 IRVINE CA           073361  03/26', '36.05', '2038.95', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(5, 'DEBIT', '2015-03-25', 'APL* ITUNES.COM/BILL 866-712-7753 CA         03/25', '0.99', '3407.12', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(6, 'DEBIT', '2015-03-25', 'ATM WITHDRAWAL                       005288  03/2513128 JAM', '1000.00', '2407.12', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(7, 'DEBIT', '2015-03-25', 'TARGET T1 TARGET T1238 IRVINE CA             03/25', '27.12', '2380.00', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(8, 'CREDIT', '2015-03-24', 'Online Transfer from CHK ...9570 transaction#: 4524276620', '1423.99', '3429.57', NULL, '5', 'from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(9, 'DEBIT', '2015-03-24', 'DAPHNE''S IRVINE AT IRVINE CA                 03/23', '21.46', '3408.11', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(10, 'DEBIT', '2015-03-23', 'TARGET T1 TARGET T1238 IRVINE CA             03/21', '33.02', '2994.53', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(11, 'DEBIT', '2015-03-23', 'SUPERCUTS 744 IRVINE CA                      03/21', '18.50', '2976.03', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(12, 'DEBIT', '2015-03-23', 'KOHL''S #1382 18182 IRV TUSTIN CA     715796  03/21', '119.89', '2856.14', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(13, 'DEBIT', '2015-03-23', 'PAYPAL *INTERNATION 402-935-7733 CA          03/22', '450.00', '2406.14', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(14, 'DEBIT', '2015-03-23', 'SPROUTS FARMERS MKT#25 TUSTIN CA     510137  03/23', '23.32', '2382.82', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(15, 'DEBIT', '2015-03-23', 'TARGET T1 TARGET T1238 IRVINE CA             03/23', '29.24', '2353.58', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(16, 'CHECK', '2015-03-23', 'CHECK 213 ', '300.00', '2053.58', '213', '5', 'Havier Franco - Groom', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(17, 'CHECK', '2015-03-23', 'CHECK 215 ', '48.00', '2005.58', '215', '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(18, 'CHECK', '2015-03-20', 'CHECK 210 ', '60.00', '3027.55', '210', '5', 'CPHA Membership', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(19, 'CHECK', '2015-03-19', 'CHECK 208 ', '567.50', '3087.55', '208', '5', 'EE - Del Mar Show Fees', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(20, 'CREDIT', '2015-03-18', 'ANC*Ancestry.com 800-2623787 UT              03/17', '149.00', '3750.05', NULL, '4', 'Ancestry.com - Refund', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(21, 'DEBIT', '2015-03-18', 'K-9 CITY INC 949-364-3300 CA                 03/16', '95.00', '3655.05', NULL, '4', 'K9-City', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(22, 'DEBIT', '2015-03-17', 'AMERINOC COM 877-805-6542 CA                 03/15', '9.95', '22.30', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(23, 'DEBIT', '2015-03-17', 'DOUBLETREE DEL MAR SAN DIEGO CA              03/15', '19.72', '3601.05', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(24, 'DEBIT', '2015-03-16', 'MARY''S TACK & FEED - DE DEL MAR CA           03/13', '1.00', '4092.99', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(25, 'DEBIT', '2015-03-16', 'MARY''S TACK & FEED - DE DEL MAR CA           03/13', '1.00', '4091.99', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(26, 'DEBIT', '2015-03-16', 'IL FORNAIO - DEL MAR - DEL MAR CA            03/15', '107.35', '3984.64', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(27, 'DEBIT', '2015-03-16', 'COSTCO GAS #0454 IRVINE CA           001658  03/16', '37.90', '3946.74', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(28, 'CHECK', '2015-03-16', 'CHECK 212 ', '326.00', '3620.74', '212', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(29, 'CREDIT', '2015-03-16', 'INTEREST PAYMENT', '0.03', '3620.77', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(30, 'DEBIT', '2015-03-16', 'RITE AID CORP. SAN DIEGO CA          332698  03/15', '16.58', '32.25', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(31, 'CREDIT', '2015-03-13', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.40', '4635.25', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(32, 'DEBIT', '2015-03-13', '35 FOR LIFE 714-485-2299 TX                  03/12', '131.26', '4503.99', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(33, 'DEBIT', '2015-03-13', '#06558 ALBERTSONS DANA POINT CA              03/13 Purchase $5.20 Cash Back $40.00', '45.20', '4458.79', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(34, 'DEBIT', '2015-03-13', '#06558 ALBERTSONS DANA POINT CA              03/13 Purchase $9.80 Cash Back $60.00', '69.80', '4388.99', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(35, 'CHECK', '2015-03-13', 'CHECK 211 ', '295.00', '4093.99', '211', '5', 'Del Mar Show - Dan Porter Trailer', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(36, 'DEBIT', '2015-03-12', 'JOHN CHRISPENS, DD NEWPORT BEACH CA          03/11', '140.00', '1375.49', NULL, '1', 'Dr Chrispens - Merrielle', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(37, 'DEBIT', '2015-03-12', 'STARBUCKS #14018 NEW Newport Beach CA        03/11', '6.90', '1368.59', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(38, 'DEBIT', '2015-03-12', 'COSTCO WHSE #0454 IRVINE CA          828140  03/12', '68.12', '1300.47', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(39, 'DEBIT', '2015-03-12', 'COSTCO GAS #0454 IRVINE CA           029527  03/12', '29.62', '1270.85', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(40, 'DEBIT', '2015-03-12', 'NETFLIX.COM NETFLIX.COM CA                   03/12', '7.99', '48.83', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(41, 'DEBIT', '2015-03-11', 'YARD HOUSE    00083030 IRVINE CA             03/10', '20.79', '1701.45', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(42, 'DEBIT', '2015-03-11', 'TARGET T1 TARGET T1238 IRVINE CA             03/11', '25.96', '1675.49', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(43, 'CHECK', '2015-03-11', 'CHECK 207 ', '160.00', '1515.49', '207', '5', 'Matt Switzer - Ferrier', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(44, 'DEBIT', '2015-03-09', 'SUBWAY        03497757 COSTA MESA CA         03/08', '14.20', '56.82', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(45, 'DEBIT', '2015-03-09', 'SQ *MOONSTONE RIDING AC Costa Mesa CA        03/06', '457.60', '2896.25', NULL, '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(46, 'DEBIT', '2015-03-09', 'TARGET T1 TARGET T1238 IRVINE CA             03/07', '23.20', '2873.05', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(47, 'DEBIT', '2015-03-09', 'BIG CHOPSTICKS ORANGE CA                     03/07', '38.94', '2834.11', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(48, 'DEBIT', '2015-03-09', 'TRAVELOCITY.COM 877.270.4536 WA              03/09', '178.88', '2655.23', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(49, 'DEBIT', '2015-03-09', 'TRAVELOCITY.COM 877.270.4536 WA              03/09', '268.88', '2386.35', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(50, 'DEBIT', '2015-03-09', 'SHOE CITY COSTA MESA COSTA MESA CA   165484  03/08', '23.75', '2362.60', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(51, 'DEBIT', '2015-03-09', 'SPROUTS FARMERS MKT#25 TUSTIN CA     476025  03/08', '29.03', '2333.57', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(52, 'DEBIT', '2015-03-09', 'Online Transfer to CHK ...9570 transaction#: 4495281682 03/09', '10.00', '2323.57', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(53, 'DEBIT', '2015-03-09', 'Chase QuickPay Electronic Transfer 4495425068 to Nicholas Markham', '100.00', '2223.57', NULL, '8', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(54, 'DEBIT', '2015-03-09', 'TARGET T1 TARGET T1238 IRVINE CA             03/09', '19.00', '2204.57', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(55, 'DEBIT', '2015-03-09', 'JPMorgan Chase   Ext Trnsfr 4431316853      WEB ID: 9200502231', '333.33', '1871.24', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(56, 'DEBIT', '2015-03-09', 'ANC*Ancestry.com 800-2623787 UT              03/07', '149.00', '1722.24', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(57, 'CREDIT', '2015-03-06', 'Online Transfer from CHK ...9570 transaction#: 4488317679', '440.00', '4614.35', NULL, '5', 'from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(58, 'DEBIT', '2015-03-06', 'Online Payment 4488318018 To Equine Medical Associates, Inc 03/06', '1200.00', '3414.35', NULL, '5', 'Dr Betty - Vet', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(59, 'DEBIT', '2015-03-06', 'RALPHS 13321 JAMBOREE TUSTIN CA      333838  03/05', '20.47', '3393.88', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(60, 'DEBIT', '2015-03-06', 'COSTCO GAS #0454 IRVINE CA           021469  03/06', '40.03', '3353.85', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(61, 'DEBIT', '2015-03-04', 'Online Payment 4483580014 To Equine Medical Associates, Inc 03/04', '191.00', '4194.35', NULL, '5', 'Dr Betty - Vet', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(62, 'DEBIT', '2015-03-04', 'TARGET T1 TARGET T1238 IRVINE CA             03/04', '20.00', '4174.35', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(63, 'CREDIT', '2015-03-03', 'P3 SPORTS CARE HUNTINGTON BE CA              03/02', '130.00', '3545.47', NULL, '2', 'Dr Gonzales - P3 Sports Care', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(64, 'CREDIT', '2015-03-03', 'Online Transfer from CHK ...9570 transaction#: 4482787627', '983.00', '4528.47', NULL, '5', 'from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(65, 'DEBIT', '2015-03-03', 'TARGET T1 TARGET T1238 IRVINE CA             03/03', '87.75', '4440.72', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(66, 'DEBIT', '2015-03-03', 'BARNESNOBLE 13712 Jamb Irvine CA     862920  03/03', '55.37', '4385.35', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(67, 'DEBIT', '2015-03-02', 'AMERICAN HORSE PRODU SAN JUAN CAPI CA151719  02/28', '54.00', '6197.85', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(68, 'DEBIT', '2015-03-02', 'TRADER JOE''S # 210 IRVINE CA         919546  02/28', '65.67', '6132.18', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(69, 'DEBIT', '2015-03-02', 'Online Payment 4477673660 To Cox Communications 03/02', '208.67', '5923.51', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(70, 'DEBIT', '2015-03-02', 'Online Payment 4477673671 To NWP SERVICES CORPORATION 03/02', '48.69', '5874.82', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(71, 'DEBIT', '2015-03-02', 'Online Payment 4477673672 To SOUTHERN CALIFORNIA EDISON 03/02', '43.13', '5831.69', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(72, 'DEBIT', '2015-03-02', 'Online Payment 4477673684 To VERIZON WIRELESS 03/02', '74.02', '5757.67', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(73, 'DEBIT', '2015-03-02', 'THE RANCH RESTAURA ANAHEIM CA                03/01', '50.00', '5707.67', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(74, 'DEBIT', '2015-03-02', 'THE RANCH RESTAURA ANAHEIM CA                03/01', '47.20', '5660.47', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(75, 'DEBIT', '2015-03-02', 'Anacapa Apartmen WEB PMTS   YN1342          WEB ID: 1203874681', '2245.00', '3415.47', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(76, 'CREDIT', '2015-02-27', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.38', '7751.85', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(77, 'DEBIT', '2015-02-27', 'Chase QuickPay Electronic Transfer 4473869753 to Christopher', '1000.00', '6751.85', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(78, 'DEBIT', '2015-02-27', 'Chase QuickPay Electronic Transfer 4474125366 to Natasha Markham', '500.00', '6251.85', NULL, '8', 'Natasha', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(79, 'DEBIT', '2015-02-26', 'Online Payment 4433180261 To SOUTHERN CALIFORNIA GAS 02/26', '27.56', '4387.47', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(80, 'DEBIT', '2015-02-25', 'APL* ITUNES.COM/BILL 866-712-7753 CA         02/24', '0.99', '4450.50', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(81, 'DEBIT', '2015-02-25', 'COSTCO GAS #0454 IRVINE CA           010630  02/25', '35.47', '4415.03', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(82, 'CREDIT', '2015-02-23', 'Online Transfer from CHK ...9570 transaction#: 4462627082', '1400.00', '4585.99', NULL, '5', '$1,200 for Dr Betty - Feb 20 - Feb 27', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(83, 'DEBIT', '2015-02-23', 'Online Transfer to CHK ...9570 transaction#: 4462715054 02/23', '40.00', '4545.99', NULL, '5', '..and $160 for Matt Switzer - ', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(84, 'DEBIT', '2015-02-23', 'EDWARDS MARKET PL STDM IRVINE CA             02/22', '44.50', '4501.49', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(85, 'CHECK', '2015-02-23', 'CHECK 204 ', '50.00', '4451.49', '204', '1', 'Sophie Abber - Tutor', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(86, 'DEBIT', '2015-02-19', 'TRADER JOE''S # 210 IRVINE CA         947360  02/19', '64.53', '4105.99', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(87, 'CHECK', '2015-02-19', 'CHECK 201 ', '500.00', '3605.99', '201', '5', 'Show Fees - OCIEL 2/13/15 - 2/16/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(88, 'CHECK', '2015-02-19', 'CHECK 205 ', '210.00', '3395.99', '205', '5', 'Show Fees - OCIEL 2/13/15 - 2/16/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(89, 'CHECK', '2015-02-19', 'CHECK 206 ', '210.00', '3185.99', '206', '5', 'Show Fees - OCIEL 2/13/15 - 2/16/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(90, 'DEBIT', '2015-02-18', 'METRO FOR MEN INC IRVINE CA                  02/17', '45.00', '5605.52', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(91, 'DEBIT', '2015-02-18', 'WITHDRAWAL 02/18', '1000.00', '4605.52', NULL, '10', 'Savings', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(92, 'DEBIT', '2015-02-18', 'Online Payment 4455148508 To Access Mediquip, LLC 02/18', '250.00', '4355.52', NULL, '2', 'Mediquip', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(93, 'CHECK', '2015-02-18', 'CHECK 202 ', '185.00', '4170.52', '202', '5', 'Moonstone - Training - OCIEL 2/13/15 - 2/16/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(94, 'CREDIT', '2015-02-17', 'Online Transfer from CHK ...9570 transaction#: 4452792365', '760.00', '5684.25', NULL, '5', 'from Nancy - Feb 13 - Feb 19', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(95, 'DEBIT', '2015-02-17', 'TCA FASTRAK R 949-727-4800 CA                02/14', '1.92', '5682.33', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(96, 'DEBIT', '2015-02-17', 'COSTCO GAS #0454 IRVINE CA           007296  02/15', '31.84', '5650.49', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(97, 'CREDIT', '2015-02-17', 'INTEREST PAYMENT', '0.03', '5650.52', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(98, 'DEBIT', '2015-02-17', 'OFF BROADWAY SHOES #50 IRVINE CA     901606  02/14', '18.35', '80.97', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(99, 'DEBIT', '2015-02-17', 'AMERINOC COM 877-805-6542 CA                 02/15', '9.95', '71.02', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(100, 'CREDIT', '2015-02-13', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.40', '5183.46', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(101, 'DEBIT', '2015-02-13', 'HITCHN POST FEED AND TA ORANGE CA            02/11', '66.04', '5117.42', NULL, '5', 'Laloni - Supplies', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(102, 'DEBIT', '2015-02-13', 'ORTEGA TACK AND FEED SAN JUAN CAPI CA        02/13', '43.17', '5074.25', NULL, '5', 'OCIEL - Supplies', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(103, 'CHECK', '2015-02-13', 'CHECK 203 ', '150.00', '4924.25', '203', '5', 'Alexa Rodriguez - Trailer - OCIEL 2/13/15 - 2/16/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(104, 'DEBIT', '2015-02-12', 'NETFLIX.COM NETFLIX.COM CA                   02/12', '7.99', '99.32', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(105, 'CHECK', '2015-02-12', 'CHECK 199 ', '1000.00', '1819.06', '199', '5', 'OC Fairgrounds - Laloni Board', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(106, 'CREDIT', '2015-02-11', 'Online Transfer from CHK ...9570 transaction#: 4441525404', '1040.00', '2824.96', NULL, '5', 'from Nancy - Feb 10 - Feb 12', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(107, 'DEBIT', '2015-02-11', 'TCA FASTRAK R 949-727-4800 CA                02/11', '5.90', '2819.06', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:47'),
(108, 'CHECK', '2015-02-10', 'CHECK 200 ', '40.00', '2134.64', '200', '5', 'Alexa Rodriguez - Laloni Supplements', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(109, 'CHECK', '2015-02-10', 'CHECK 195 ', '100.00', '2034.64', '195', '1', 'Sophie - Tutoring', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(110, 'DEBIT', '2015-02-10', 'TARGET T1 TARGET T1238 IRVINE CA             02/10', '25.00', '2009.64', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(111, 'DEBIT', '2015-02-10', 'TARGET T1 TARGET T1238 IRVINE CA             02/10', '224.68', '1784.96', NULL, '8', 'Christopher', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(112, 'DEBIT', '2015-02-09', 'COSTCO GAS #1001 TUSTIN CA           087379  02/07', '30.02', '2607.97', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(113, 'DEBIT', '2015-02-09', 'Chase QuickPay Electronic Transfer 4438072479 to Natasha Markham', '100.00', '2507.97', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(114, 'DEBIT', '2015-02-09', 'JPMorgan Chase   Ext Trnsfr 4371019371      WEB ID: 9200502231', '333.33', '2174.64', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(115, 'DEBIT', '2015-02-06', 'COSTCO WHSE #0122 TUSTIN CA          036520  02/06', '83.71', '3039.99', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(116, 'CHECK', '2015-02-06', 'CHECK 198 ', '402.00', '2637.99', '198', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(117, 'CREDIT', '2015-02-05', 'Online Transfer from CHK ...9570 transaction#: 4430384491', '669.98', '3123.70', NULL, '5', 'from Nancy - Jan 6 - Feb 10', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(118, 'DEBIT', '2015-02-05', 'LE CAFE COSTA MESA CA                        02/04', '6.82', '125.12', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(119, 'DEBIT', '2015-02-05', 'IRVINE RANCH MK 2651 I COSTA MESA CA 264457  02/05', '17.81', '107.31', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(120, 'DEBIT', '2015-02-04', 'TLT FOOD - IRVINE IRVINE CA                  02/03', '79.38', '131.94', NULL, '4', 'Proove Bio Sciences - Team Luch to welcome new hires', 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(121, 'DEBIT', '2015-02-03', 'TARGET T1238 IRVINE CA               062013  02/03', '27.96', '211.32', NULL, '5', 'Supplies', 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(122, 'DEBIT', '2015-02-04', 'TRADER JOE''S # 210 IRVINE CA         789502  02/04', '60.66', '2453.72', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(123, 'DEBIT', '2015-02-03', 'ROYAL CLEANERS IRVINE CA                     01/31', '34.20', '4759.38', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(124, 'DEBIT', '2015-02-03', 'Anacapa Apartmen WEB PMTS   N2NX22          WEB ID: 1203874681', '2245.00', '2514.38', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(125, 'DEBIT', '2015-02-02', 'COSTCO GAS #1001 TUSTIN CA           055341  01/31', '26.55', '5727.92', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(126, 'DEBIT', '2015-02-02', 'COSTCO WHSE #1001 TUSTIN CA          062354  01/31', '119.23', '5608.69', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(127, 'DEBIT', '2015-02-02', 'Online Payment 4421083844 To Equine Medical Associates, Inc 02/02', '115.00', '5493.69', NULL, '5', 'Equine Medical Associates - Vet', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(128, 'DEBIT', '2015-02-02', 'Online Payment 4421095453 To Stephen R. Gage, C.P.A 02/02', '270.00', '5223.69', NULL, '11', 'Steve Gage', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(129, 'DEBIT', '2015-02-02', 'Online Payment 4421125764 To Cox Communications 02/02', '173.73', '5049.96', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(130, 'DEBIT', '2015-02-02', 'Online Payment 4421125766 To NWP SERVICES CORPORATION 02/02', '46.03', '5003.93', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(131, 'DEBIT', '2015-02-02', 'Online Payment 4421125770 To SOUTHERN CALIFORNIA EDISON 02/02', '45.27', '4958.66', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(132, 'DEBIT', '2015-02-02', 'Online Payment 4421125777 To SOUTHERN CALIFORNIA GAS 02/02', '5.08', '4953.58', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(133, 'DEBIT', '2015-02-02', 'Online Payment 4421161374 To VERIZON WIRELESS 02/02', '70.00', '4883.58', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(134, 'DEBIT', '2015-02-02', 'Online Payment 4421205628 To Newport Irvine Surg. Specialists 02/02', '40.00', '4843.58', NULL, '2', 'Newport Irvine Surgical Specialists', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(135, 'CHECK', '2015-02-02', 'CHECK 197 ', '50.00', '4793.58', '197', '2', 'Bogdan Staucean - Chiropractor', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(136, 'CREDIT', '2015-01-30', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.38', '6754.47', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(137, 'DEBIT', '2015-01-30', 'Chase QuickPay Electronic Transfer 4417095139 to Christopher', '1000.00', '5754.47', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(138, 'DEBIT', '2015-01-29', '35 FOR LIFE 714-485-2299 TX                  01/27', '171.33', '3390.09', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(139, 'DEBIT', '2015-01-27', 'Online Transfer to CHK ...2339 transaction#: 4410360673 01/27', '200.00', '3561.42', NULL, '17', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(140, 'CREDIT', '2015-01-27', 'Online Transfer from CHK ...9657 transaction#: 4410360673', '200.00', '241.53', NULL, '17', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(141, 'DEBIT', '2015-01-27', 'STARBUCKS #05427 IRVINE Irvine CA            01/26', '2.25', '239.28', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(142, 'DEBIT', '2015-01-26', 'EDWARDS MARKET PL STDM IRVINE CA             01/24', '10.00', '41.53', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(143, 'DEBIT', '2015-01-26', 'APL* ITUNES.COM/BILL 866-712-7753 CA         01/24', '0.99', '3961.42', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(144, 'CHECK', '2015-01-26', 'CHECK 196 ', '200.00', '3761.42', '196', '5', 'Matt Switzer - Ferrier', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(145, 'DEBIT', '2015-01-20', 'AMERINOC COM 877-805-6542 CA                 01/15', '9.95', '51.53', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(146, 'DEBIT', '2015-01-20', 'ATM WITHDRAWAL                       002607  01/1713128 JAM', '1000.00', '4131.18', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(147, 'DEBIT', '2015-01-20', 'BEST BUY #774 TUSTIN CA                      01/17', '140.37', '3990.81', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(148, 'DEBIT', '2015-01-20', 'COSTCO GAS #1001 TUSTIN CA           058239  01/20', '28.40', '3962.41', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(149, 'CREDIT', '2015-01-16', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3364.40', '5136.14', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(150, 'DEBIT', '2015-01-16', 'APL* ITUNES.COM/BILL 866-712-7753 CA         01/16', '4.99', '5131.15', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(151, 'CREDIT', '2015-01-16', 'INTEREST PAYMENT', '0.03', '5131.18', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(152, 'CREDIT', '2015-01-14', 'Online Transfer from CHK ...9570 transaction#: 4387113939', '1606.08', '3378.74', NULL, '5', 'from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(153, 'DEBIT', '2015-01-14', 'EQUINE MEDICAL ASSOCI 800-554-3363 CA        01/13', '1247.00', '2131.74', NULL, '5', 'Dr Betty', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(155, 'CHECK', '2015-01-14', 'CHECK 193 ', '185.00', '1946.74', '193', '5', 'Moonstone - Training - OCIEL - 1/9/15 - 1/11/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(156, 'CHECK', '2015-01-14', 'CHECK 192 ', '175.00', '1771.74', '192', '5', 'Sheri - Trailer - OCIEL - 1/9/15 - 1/11/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(157, 'CHECK', '2015-01-12', 'CHECK 191 ', '500.00', '1863.72', '191', '5', 'OCIEL - 1/9/15 - 1/11/15', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(158, 'DEBIT', '2015-01-12', 'NETFLIX.COM NETFLIX.COM CA                   01/12', '7.99', '61.48', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(159, 'DEBIT', '2015-01-12', 'COSTCO GAS #0028 LAGUNA NIGUEL CA    068513  01/10', '25.20', '1838.52', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(160, 'DEBIT', '2015-01-12', 'THE OLIVE GARD00012674 IRVINE CA             01/10', '65.86', '1772.66', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(161, 'CREDIT', '2015-01-09', 'Online Transfer from CHK ...9570 transaction#: 4378454111', '870.39', '2363.72', NULL, '5', 'from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(162, 'DEBIT', '2015-01-08', 'OFFICE DEPOT 00 79 TEC IRVINE CA     057713  01/08', '29.15', '69.47', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(163, 'DEBIT', '2015-01-07', 'JPMorgan Chase   Ext Trnsfr 4310944254      WEB ID: 9200502231', '333.33', '1493.33', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(164, 'CHECK', '2015-01-06', 'CHECK 190 ', '450.00', '1826.66', '190', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(166, 'DEBIT', '2015-01-05', 'Chase QuickPay Electronic Transfer 4363201338 to Natasha Markham', '100.00', '4775.70', NULL, '8', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(167, 'DEBIT', '2015-01-05', 'RITE AID CORP. TUSTIN CA             385011  01/03', '17.81', '4757.89', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(168, 'DEBIT', '2015-01-05', 'Chase QuickPay Electronic Transfer 4364460642 to Natasha Markham', '200.00', '4557.89', NULL, '8', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(169, 'DEBIT', '2015-01-05', 'SPROUTS FARMERS MKT#25 TUSTIN CA     215491  01/05', '36.23', '4521.66', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(170, 'DEBIT', '2015-01-05', 'Anacapa Apartmen WEB PMTS   YKLH12          WEB ID: 1203874681', '2245.00', '2276.66', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(171, 'DEBIT', '2015-01-05', 'SUPERCUTS 744 IRVINE CA                      01/03', '19.50', '138.55', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(172, 'DEBIT', '2015-01-05', 'TARGET T1238 IRVINE CA               028051  01/03', '39.93', '98.62', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(173, 'CREDIT', '2015-01-02', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '3221.44', '3221.44', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(174, 'DEBIT', '2015-01-02', 'EDWARDS WESTPARK 8 IRVINE CA                 01/01', '9.00', '3212.44', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(175, 'DEBIT', '2015-01-02', 'Online Payment 4361331479 To Cox Communications 01/02', '167.45', '3044.99', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(176, 'DEBIT', '2015-01-02', 'Online Payment 4361331514 To SOUTHERN CALIFORNIA EDISON 01/02', '47.58', '2997.41', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(177, 'DEBIT', '2015-01-02', 'Online Payment 4361331500 To NWP SERVICES CORPORATION 01/02', '46.95', '2950.46', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(178, 'DEBIT', '2015-01-02', 'Online Payment 4361331532 To SOUTHERN CALIFORNIA GAS 01/02', '28.59', '2921.87', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(179, 'DEBIT', '2015-01-02', 'Online Payment 4361331542 To VERIZON WIRELESS 01/02', '72.44', '2849.43', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(180, 'DEBIT', '2015-01-02', 'Chase QuickPay Electronic Transfer 4361349829 to Christopher', '1000.00', '1849.43', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-04-04 10:47:30', 1, '2015-11-14 05:21:46'),
(181, 'DEBIT', '2015-04-20', 'WAL-MART CHECK PRINTN 866-925-2432 TX        04/17', '10.49', '115.94', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:28', 1, '2015-11-14 05:21:47'),
(182, 'DEBIT', '2015-04-20', 'PF CHANG''S #8700 LAS VEGAS NV                04/18', '50.00', '65.94', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:29', 1, '2015-11-14 05:21:47'),
(183, 'DEBIT', '2015-04-20', 'M M WORLD LV 0011 LAS VEGAS NV       859079  04/19', '18.18', '47.76', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:29', 1, '2015-11-14 05:21:47'),
(184, 'DEBIT', '2015-04-17', 'AMERINOC COM 877-805-6542 CA                 04/15', '9.95', '126.43', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:29', 1, '2015-11-14 05:21:47'),
(185, 'DEBIT', '2015-04-13', 'NETFLIX.COM NETFLIX.COM CA                   04/12', '7.99', '136.38', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:29', 1, '2015-11-14 05:21:47'),
(186, 'CREDIT', '2015-04-06', 'Online Transfer from CHK ...9657 transaction#: 4550926344', '100.00', '210.30', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:29', 1, '2015-11-14 05:21:47'),
(187, 'DEBIT', '2015-04-06', 'ANSAR GALLERY TUSTIN CA              228886  04/05', '44.38', '165.92', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:30', 1, '2015-11-14 05:21:47'),
(188, 'DEBIT', '2015-04-06', '#06525 ALBERTSONS IRVINE CA          537726  04/05', '21.55', '144.37', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:30', 1, '2015-11-14 05:21:47'),
(189, 'CREDIT', '2015-04-01', 'Online Transfer from CHK ...9657 transaction#: 4540457616', '100.00', '110.30', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:30', 1, '2015-11-14 05:21:47'),
(190, 'DEBIT', '2015-03-31', 'SERVICE FEE', '12.00', '10.30', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 0, '2015-04-22 16:40:30', 1, '2015-11-14 05:21:47'),
(191, 'DEBIT', '2015-04-21', 'APPLEBEES VICT15215262 VICTORVILLE CA        04/20', '38.15', '6271.35', NULL, '4', 'Vegas Trip', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(192, 'DEBIT', '2015-04-20', '35 FOR LIFE 714-485-2299 TX                  04/16', '179.72', '6605.19', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(193, 'DEBIT', '2015-04-20', 'NON-CHASE ATM WITHDRAW               037385  04/183667 LAS', '204.99', '6400.20', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(194, 'DEBIT', '2015-04-20', 'CHINESE LAUNDRY PRIMM NV                     04/19', '64.85', '6335.35', NULL, '4', 'Vegas Trip', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(195, 'DEBIT', '2015-04-20', 'CHEVRON 00212073 LAS VEGAS NV                04/19', '25.85', '6309.50', NULL, '3', 'Vegas Trip', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(196, 'DSLIP', '2015-04-17', 'REMOTE ONLINE DEPOSIT #          1', '205.00', '6662.91', '1', '2', 'Insurance re-imbursement for Dr Chrispens', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(197, 'DSLIP', '2015-04-17', 'REMOTE ONLINE DEPOSIT #          1', '122.00', '6784.91', '1', '2', 'Insurance re-imbursement for Dr Chrispens', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(198, 'CREDIT', '2015-04-16', 'Online Transfer from CHK ...9570 transaction#: 4573165422', '300.00', '6457.91', NULL, '2', 'Merrielle Health Ins for Apr', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:35', 1, '2015-11-14 05:21:47'),
(199, 'CREDIT', '2015-04-15', 'INTEREST PAYMENT', '0.05', '6157.91', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(200, 'DEBIT', '2015-04-13', 'UBER 866-576-1039 CA                         04/11', '14.40', '6157.86', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(201, 'CHECK', '2015-04-09', 'CHECK 217 ', '440.00', '6172.26', '217', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(202, 'DEBIT', '2015-04-08', 'ATM WITHDRAWAL                       001269  04/0813128 JAM', '40.00', '7612.26', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(203, 'CHECK', '2015-04-08', 'CHECK 218', '1000.00', '6612.26', '218', '5', 'OC Fairgrounds for Laloni board', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(204, 'CREDIT', '2015-04-07', 'Online Transfer from CHK ...9570 transaction#: 4554121836', '1440.00', '7989.09', NULL, '5', 'For horse stuff', 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(205, 'CREDIT', '2015-04-07', 'Online Transfer from CHK ...9570 transaction#: 4554156829', '16.50', '8005.59', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(206, 'DEBIT', '2015-04-07', 'TARGET T1 TARGET T1238 IRVINE CA             04/07', '20.00', '7985.59', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:36', 1, '2015-11-14 05:21:47'),
(207, 'DEBIT', '2015-04-07', 'JPMorgan Chase   Ext Trnsfr 4488582401      WEB ID: 9200502231', '333.33', '7652.26', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(208, 'DEBIT', '2015-04-06', 'CHIPOTLE 1026 IRVINE CA                      04/03', '14.47', '8981.63', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(209, 'DEBIT', '2015-04-06', 'COSTCO GAS #1110 HUNTINGTON B CA     084271  04/04', '25.93', '8955.70', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(210, 'DEBIT', '2015-04-06', 'RUBIO''S #145 HUNTINGTON BE CA                04/04', '13.78', '8941.92', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(211, 'DEBIT', '2015-04-06', 'Online Transfer to CHK ...2339 transaction#: 4550926344 04/06', '100.00', '8841.92', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(212, 'DEBIT', '2015-04-06', 'STARBUCKS #11028 TUSTIN Tustin CA            04/06', '10.95', '8830.97', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(213, 'DEBIT', '2015-04-06', 'WALGREENS 7001 WESTMIN WESTMINSTER CA044687  04/06', '3.88', '8827.09', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(214, 'DEBIT', '2015-04-06', 'CA DMV WESTMINSTER FO WESTMINSTER CA 764591  04/06', '33.00', '8794.09', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:37', 1, '2015-11-14 05:21:47'),
(215, 'DEBIT', '2015-04-06', 'Anacapa Apartmen WEB PMTS   1DK062          WEB ID: 1203874681', '2245.00', '6549.09', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(216, 'DEBIT', '2015-04-01', 'Online Transfer to CHK ...2339 transaction#: 4540457616 04/01', '100.00', '8996.10', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(217, 'CREDIT', '2015-03-31', 'PROOVE BIOSCIENC DIRECT DEP                 PPD ID: 9111111101', '4244.20', '9451.53', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(218, 'DEBIT', '2015-03-31', 'Online Payment 4537905314 To Cox Communications 03/31', '200.00', '9251.53', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(219, 'DEBIT', '2015-03-31', 'Online Payment 4537905330 To NWP SERVICES CORPORATION 03/31', '46.95', '9204.58', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(220, 'DEBIT', '2015-03-31', 'Online Payment 4537905336 To SOUTHERN CALIFORNIA EDISON 03/31', '45.26', '9159.32', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(221, 'DEBIT', '2015-03-31', 'Online Payment 4537905354 To VERIZON WIRELESS 03/31', '35.45', '9123.87', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(222, 'DEBIT', '2015-03-31', 'Online Payment 4537905347 To SOUTHERN CALIFORNIA GAS 03/31', '27.77', '9096.10', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:38', 1, '2015-11-14 05:21:47'),
(223, 'DEBIT', '2015-03-30', 'ATM WITHDRAWAL                       006099  03/281455 BAKE', '60.00', '5268.33', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:39', 1, '2015-11-14 05:21:47'),
(224, 'DEBIT', '2015-03-30', 'TCA FASTRAK R 949-727-4800 CA                03/29', '1.92', '5266.41', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:39', 1, '2015-11-14 05:21:47'),
(225, 'DEBIT', '2015-03-30', 'STARBUCKS #11028 TUSTIN Tustin CA            03/29', '19.50', '5246.91', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:39', 1, '2015-11-14 05:21:47'),
(226, 'DEBIT', '2015-03-30', 'BARNESNOBLE 13712 Jamb Irvine CA     045971  03/29', '14.58', '5232.33', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:39', 1, '2015-11-14 05:21:47'),
(227, 'DEBIT', '2015-03-30', 'HARRY''S 888-212-6855 NY                      03/29', '25.00', '5207.33', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 0, '2015-04-22 17:06:39', 1, '2015-11-14 05:21:47'),
(228, 'DEBIT', '2015-05-19', 'Online Transfer to CHK ...2339 transaction#: 4639594782 05/19', '313.48', '3179.59', NULL, '17', 'Transfer to Business to cover Child Support', 1, '2015-10-07', 1, 0, 2, '2015-04-24 13:58:57', 1, '2015-11-14 05:21:47'),
(229, 'CHECK', '2015-04-27', 'CHECK 221 ', '2500.00', '3841.70', '221', '12', 'Rallo Law Firm - Expenses for lawsuit', 1, '2015-10-07', 1, 0, 2, '2015-04-24 18:37:00', 1, '2015-11-14 05:21:47'),
(230, 'DSLIP', '2015-05-05', 'DEPOSIT  ID NUMBER 680596', '3000.00', '4486.02', NULL, '10', 'From Cash Savings', 1, '2015-10-07', 1, 0, 2, '2015-04-24 18:38:00', 1, '2015-11-14 05:21:47'),
(239, 'DEBIT', '2015-05-12', 'NETFLIX.COM NETFLIX.COM CA                   05/12', '7.99', '24.88', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-14 09:20:55', 1, '2015-11-14 05:21:47'),
(240, 'DEBIT', '2015-05-11', 'EDWARDS WESTPARK 8 IRVINE CA                 05/09', '9.00', '32.87', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-14 09:21:07', 1, '2015-11-14 05:21:47'),
(241, 'DEBIT', '2015-05-08', 'JAMBA JUICE 2 TUSTIN CA                      05/07', '5.89', '41.87', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-14 09:21:15', 1, '2015-11-14 05:21:47'),
(242, 'DEBIT', '2015-05-13', 'ENTERPRISE RENT-A-CAR TUSTIN CA              05/12', '100.00', '4127.88', NULL, '4', 'Covered by Nationwide Insurance', 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:26:27', 1, '2015-11-14 05:21:47'),
(243, 'DEBIT', '2015-05-13', 'TCA FASTRAK R 949-727-4800 CA                05/13', '5.68', '4122.20', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:26:35', 1, '2015-11-14 05:21:47'),
(244, 'DSLIP', '2015-05-08', 'DEPOSIT  ID NUMBER  99564', '130.00', '4237.88', NULL, '2', 'Health Insurance re-imbursement for Dr Chrispens', 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:27:06', 1, '2015-11-14 05:21:47'),
(245, 'DEBIT', '2015-05-08', 'Online Transfer to CHK ...9570 transaction#: 4619687503 05/08', '10.00', '4227.88', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:27:15', 1, '2015-11-14 05:21:47'),
(246, 'DEBIT', '2015-05-07', 'Online Payment 4616320321 To SOUTHERN CALIFORNIA GAS 05/07', '44.81', '4441.21', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:27:26', 1, '2015-11-14 05:21:47'),
(247, 'DEBIT', '2015-05-07', 'JPMorgan Chase   Ext Trnsfr 4548284659      WEB ID: 9200502231', '333.33', '4107.88', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:27:43', 1, '2015-11-14 05:21:47'),
(248, 'CHECK', '2015-05-06', 'CHECK 223 ', '440.00', '4486.02', '223', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:28:03', 1, '2015-11-14 05:21:47'),
(249, 'CREDIT', '2015-05-05', 'Online Transfer from CHK ...9570 transaction#: 4612476741', '440.00', '4926.02', NULL, '5', 'From Nancy - Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-05-14 09:39:35', 1, '2015-11-14 05:21:47'),
(250, 'CREDIT', '2015-05-04', 'Online Transfer from CHK ...9570 transaction#: 4610357477', '300.00', '3736.95', NULL, '2', 'Merrielle Health Insurance', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:14:44', 1, '2015-11-14 05:21:47'),
(251, 'DEBIT', '2015-05-04', 'TCA FASTRAK R 949-727-4800 CA                05/02', '5.93', '3731.02', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:16:42', 1, '2015-11-14 05:21:47'),
(252, 'DEBIT', '2015-05-04', 'Anacapa Apartmen WEB PMTS   CY7B72          WEB ID: 1203874681', '2245.00', '1486.02', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:16:54', 1, '2015-11-14 05:21:47'),
(253, 'CHECK', '2015-04-30', 'CHECK 219 ', '100.00', '3436.95', '219', '1', 'Tutoring', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:17:14', 1, '2015-11-14 05:21:47'),
(254, 'DEBIT', '2015-04-29', 'Online Payment 4596323597 To VERIZON WIRELESS 04/29', '70.20', '3556.53', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:17:21', 1, '2015-11-14 05:21:47'),
(255, 'DEBIT', '2015-04-29', 'Online Payment 4596323593 To SOUTHERN CALIFORNIA EDISON 04/29', '19.58', '3536.95', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:17:28', 1, '2015-11-14 05:21:47'),
(256, 'DEBIT', '2015-04-28', 'TARGET T1 TARGET T1238 IRVINE CA             04/28', '45.00', '3626.73', NULL, '2', 'Prescriptions', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:17:48', 1, '2015-11-14 05:21:47'),
(257, 'DEBIT', '2015-04-27', 'MERCURY CASUALTY PAYMENT    040109170054530 WEB ID: 1952577343', '86.88', '3754.82', NULL, '7', 'Car Insurance', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:18:25', 1, '2015-11-14 05:21:47'),
(258, 'CREDIT', '2015-04-27', 'Online Transfer from CHK ...9570 transaction#: 4592910825', '64.85', '3819.67', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:26:52', 1, '2015-11-14 05:21:47'),
(259, 'DEBIT', '2015-04-27', 'APL* ITUNES.COM/BILL 866-712-7753 CA         04/24', '0.99', '3818.68', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:03', 1, '2015-11-14 05:21:47'),
(260, 'DEBIT', '2015-04-27', 'PICK UP STIX 765 TUSTIN TUSTIN CA            04/24', '29.44', '3789.24', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:10', 1, '2015-11-14 05:21:47'),
(261, 'DEBIT', '2015-04-27', 'Online Payment 4592926943 To Cox Communications 04/27', '175.83', '3613.41', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:17', 1, '2015-11-14 05:21:47');
INSERT INTO `transaction` (`id`, `type`, `transaction_date`, `description`, `amount`, `bank_account_balance`, `check_num`, `category_id`, `notes`, `is_uploaded`, `reconciled_date`, `bank_account_id`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(262, 'DEBIT', '2015-04-27', 'Online Payment 4592937729 To NWP SERVICES CORPORATION 04/27', '50.21', '3563.20', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:23', 1, '2015-11-14 05:21:47'),
(263, 'DEBIT', '2015-04-24', 'SUPERCUTS HB HUNTINGTON BE CA                04/22', '15.50', '6341.70', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:29', 1, '2015-11-14 05:21:47'),
(264, 'DEBIT', '2015-04-23', 'STARBUCKS #05807 HUN Huntington Be CA        04/22', '7.50', '6363.85', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:37', 1, '2015-11-14 05:21:47'),
(265, 'DEBIT', '2015-04-23', 'STARBUCKS #05807 HUN Huntington Be CA        04/22', '6.65', '6357.20', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:27:44', 1, '2015-11-14 05:21:47'),
(266, 'CREDIT', '2015-04-22', 'ATM CHECK DEPOSIT 04/22 7830 EDINGER AVE HUNTINGTON BE CA', '300.00', '6571.35', NULL, '2', 'Nick & Tash Health Ins for Apr & May', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:28:50', 1, '2015-11-14 05:21:47'),
(267, 'CHECK', '2015-04-22', 'CHECK 220 ', '200.00', '6371.35', '220', '5', 'Matt Switzer - Ferrier', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:30:37', 1, '2015-11-14 05:21:47'),
(268, 'DSLIP', '2015-04-27', 'REMOTE ONLINE DEPOSIT #          1', '108.53', '3671.73', '1', '4', 'Expenses from Proove Bio', 1, '2015-10-07', 1, 0, 2, '2015-05-15 11:31:28', 1, '2015-11-14 05:21:47'),
(269, 'CHECK', '2015-07-01', 'CHECK 229 ', '830.15', '2869.56', '229', '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-15 12:20:10', 1, '2015-11-14 05:21:48'),
(270, 'CHECK', '2015-05-19', 'CHECK 222 ', '830.15', '2349.44', '222', '2', 'Health Ins. for Apr', 1, '2015-10-07', 1, 0, 2, '2015-05-15 12:20:50', 1, '2015-11-14 05:21:47'),
(271, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637791736', '1000.00', '4083.73', NULL, '5', 'Victory Horse Show - from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-05-15 12:30:00', 1, '2015-11-14 05:21:47'),
(272, 'CREDIT', '2015-06-03', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', '4763.82', NULL, '13', 'From UI', 1, '2015-10-07', 1, 0, 2, '2015-05-15 12:30:00', 1, '2015-11-14 05:21:48'),
(273, 'CREDIT', '2015-06-17', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(274, 'CREDIT', '2015-07-01', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(275, 'CREDIT', '2015-07-15', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(276, 'CREDIT', '2015-07-29', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(277, 'CREDIT', '2015-08-12', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(278, 'CREDIT', '2015-08-26', 'From UI', '900.00', '0.00', NULL, '14', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-15 12:30:00', 2, '2015-11-12 22:01:32'),
(279, 'CHECK', '2015-05-14', 'CHECK 224 ', '872.73', '3249.47', '224', '19', 'FTB 2014 + Interest & Fee', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:22:52', 1, '2015-11-14 05:21:47'),
(280, 'DEBIT', '2015-05-18', 'AMERINOC COM 877-805-6542 CA                 05/15', '9.95', '64.93', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:28:19', 1, '2015-11-14 05:21:47'),
(281, 'DEBIT', '2015-05-18', 'MICHAELS STORES INC772 TUSTIN CA     321479  05/18', '24.76', '40.17', NULL, '1', 'School Stuff', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:28:58', 1, '2015-11-14 05:21:47'),
(282, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638601748', '24.76', '64.93', NULL, '1', 'School Stuff - from Nancy', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:29:14', 1, '2015-11-14 05:21:47'),
(283, 'DEBIT', '2015-05-18', 'OFFICE MAX/OFFI 13728 IRVINE CA      205682  05/18', '25.36', '39.57', NULL, '1', 'School Supplies', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:29:30', 1, '2015-11-14 05:21:47'),
(284, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638600591', '25.36', '64.93', NULL, '1', 'School Supplies - from Nancy', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:29:46', 1, '2015-11-14 05:21:47'),
(285, 'DEBIT', '2015-05-18', 'DOMINO''S 7893 TUSTIN CA                      05/16', '23.57', '41.36', NULL, '5', 'Victory Horse Show', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:30:09', 1, '2015-11-14 05:21:47'),
(286, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637795722', '21.57', '62.93', NULL, '5', 'Victory Horse Show - from Nancy', 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:30:32', 1, '2015-11-14 05:21:47'),
(287, 'CREDIT', '2015-05-14', 'Online Transfer from CHK ...9657 transaction#: 4629258861', '50.00', '74.88', NULL, '17', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-19 08:30:40', 1, '2015-11-14 05:21:47'),
(288, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638603880', '300.00', '4383.73', NULL, '5', 'Victory Horse Show - from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:32:26', 1, '2015-11-14 05:21:47'),
(289, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637788465', '64.49', '4448.22', NULL, '5', 'Victory Horse Show - from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:32:46', 1, '2015-11-14 05:21:47'),
(290, 'CHECK', '2015-05-18', 'CHECK 228 ', '655.15', '3793.07', '228', '5', 'Victory horse show fees', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:33:11', 1, '2015-11-14 05:21:47'),
(291, 'CHECK', '2015-05-18', 'CHECK 227 ', '300.00', '3493.07', '227', '5', 'Victory horse show groom', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:33:31', 1, '2015-11-14 05:21:47'),
(292, 'CHECK', '2015-05-15', 'CHECK 225 ', '140.00', '3083.69', '225', '5', 'Victory horse show trailer - Dan Porter', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:33:54', 1, '2015-11-14 05:21:47'),
(293, 'CREDIT', '2015-05-15', 'INTEREST PAYMENT', '0.04', '3083.73', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:34:00', 1, '2015-11-14 05:21:47'),
(294, 'CREDIT', '2015-05-14', 'Online Transfer from CHK ...9570 transaction#: 4629258246', '30.00', '3279.47', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:34:07', 1, '2015-11-14 05:21:47'),
(295, 'DEBIT', '2015-05-14', 'TCA FASTRAK R 949-727-4800 CA                05/14', '5.78', '3273.69', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:34:14', 1, '2015-11-14 05:21:47'),
(296, 'DEBIT', '2015-05-14', 'Online Transfer to CHK ...2339 transaction#: 4629258861 05/14', '50.00', '3223.69', NULL, '17', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:34:23', 1, '2015-11-14 05:21:47'),
(297, 'DSLIP', '2015-05-25', 'Health Insurance for Nick & Tash - May', '300.00', '0.00', NULL, '2', NULL, 0, '2015-10-07', 1, 1, 2, '2015-05-19 08:38:27', 2, '2015-11-12 22:01:32'),
(298, 'CREDIT', '2015-05-22', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', '3638.07', NULL, '13', 'From UI', 1, '2015-10-07', 1, 0, 2, '2015-05-19 08:44:47', 1, '2015-11-14 05:21:48'),
(299, 'CHECK', '2015-07-08', 'Victory horse show training - Moonstone', '185.00', '0.00', NULL, '5', 'Victory horse show training - Moonstone', 0, '2015-10-07', 1, 1, 2, '2015-05-19 08:47:56', 2, '2015-11-12 22:01:32'),
(300, 'CREDIT', '2015-05-19', 'Online Transfer from CHK ...9657 transaction#: 4639594782', '313.48', '376.41', NULL, '17', 'To cover child support payment', 1, '2015-10-07', 2, 0, 2, '2015-05-23 17:03:55', 1, '2015-11-14 05:21:47'),
(301, 'DEBIT', '2015-05-19', 'ANSAR GALLERY TUSTIN CA                      05/18', '5.37', '371.04', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-23 17:04:04', 1, '2015-11-14 05:21:48'),
(302, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643876773', '185.00', '2577.39', NULL, '5', 'From nancy - Matt Switzer (Ferrier)', 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:08:26', 1, '2015-11-14 05:21:48'),
(303, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643875927', '50.00', '2627.39', NULL, '5', 'from Nancy - OCHSA Membership', 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:09:50', 1, '2015-11-14 05:21:48'),
(304, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643878956', '10.68', '2638.07', NULL, '5', 'Miscellaneous - Victory Horse Show', 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:10:58', 1, '2015-11-14 05:21:48'),
(305, 'CREDIT', '2015-05-20', 'ENTERPRISE RENT-A-CAR TUSTIN CA              05/19', '100.00', '2449.44', NULL, '4', 'Credit for rental', 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:15:17', 1, '2015-11-14 05:21:48'),
(306, 'DEBIT', '2015-05-20', 'BAJA FRESH 10063 IRVINE CA                   05/18', '7.05', '2442.39', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:15:24', 1, '2015-11-14 05:21:48'),
(307, 'CHECK', '2015-05-20', 'CHECK 209 ', '50.00', '2392.39', '209', '5', 'OCHSA Membership', 1, '2015-10-07', 1, 0, 2, '2015-05-23 17:15:51', 1, '2015-11-14 05:21:48'),
(308, 'DEBIT', '2015-05-20', 'STATE OF CA DEPT OF D 916-464-5000 CA        05/19', '313.48', '57.56', NULL, '18', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-23 17:35:35', 1, '2015-11-14 05:21:48'),
(310, 'CHECK', '2015-05-26', 'CHECK 230 ', '185.00', '3453.07', '230', '5', 'Matt Switzer - Ferrier', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:00:24', 1, '2015-11-14 05:21:48'),
(311, 'DEBIT', '2015-05-26', 'APL* ITUNES.COM/BILL 866-712-7753 CA         05/24', '0.99', '3452.08', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:00:38', 1, '2015-11-14 05:21:48'),
(312, 'DEBIT', '2015-05-27', 'TCA FASTRAK R 949-727-4800 CA                05/27', '3.26', '3448.82', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:00:59', 1, '2015-11-14 05:21:48'),
(313, 'DEBIT', '2015-05-27', 'EQUESTRIAN SERVICES II COSTA MESA CA         05/26', '650.00', '2798.82', NULL, '5', 'Laloni - Board', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:01:17', 1, '2015-11-14 05:21:48'),
(314, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654232530', '35.58', '2834.40', NULL, '5', 'Laloni - Supplies - From Nancy', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:01:44', 1, '2015-11-14 05:21:48'),
(315, 'DEBIT', '2015-05-28', 'HITCHN POST FEED AND TA ORANGE CA            05/26', '35.58', '3448.82', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:01:52', 1, '2015-11-14 05:21:48'),
(316, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654231215', '650.00', '3484.40', NULL, '5', 'Laloni Board - From Nancy', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:02:18', 1, '2015-11-14 05:21:48'),
(317, 'DEBIT', '2015-05-28', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', '3363.82', NULL, '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:02:29', 1, '2015-11-14 05:21:48'),
(318, 'DEBIT', '2015-05-28', 'TCA FASTRAK R 949-727-4800 CA                05/28', '30.00', '3333.82', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:02:36', 1, '2015-11-14 05:21:48'),
(319, 'DSLIP', '2015-05-28', 'REMOTE ONLINE DEPOSIT #          1', '450.00', '3783.82', '1', '2', 'Nick & tash - Health Ins', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:02:56', 1, '2015-11-14 05:21:48'),
(320, 'DEBIT', '2015-05-29', 'Online Transfer to CHK ...9570 transaction#: 4659770569 05/29', '20.00', '3763.82', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:03:03', 1, '2015-11-14 05:21:48'),
(321, 'DEBIT', '2015-05-28', 'STARBUCKS #22637 COSTA Costa Mesa CA         05/27', '3.95', '53.61', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-05-31 09:07:24', 1, '2015-11-14 05:21:48'),
(322, 'CHECK', '2015-07-01', 'CHECK 231 ', '830.15', '2039.41', '231', '2', 'Health Insurance for June', 1, '2015-10-07', 1, 0, 2, '2015-05-31 09:29:34', 1, '2015-11-14 05:21:48'),
(323, 'DEBIT', '2015-06-03', 'POSTAL ANNEX 56 TUSTIN CA                    06/01', '20.00', '33.61', NULL, '4', 'Return stirups', 1, '2015-10-07', 2, 0, 2, '2015-06-08 06:51:55', 1, '2015-11-14 05:21:48'),
(324, 'DEBIT', '2015-06-04', 'AMPCO PARKING 2600MICHE IRVINE CA            06/02', '6.00', '27.61', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-08 06:52:07', 1, '2015-11-14 05:21:48'),
(325, 'DEBIT', '2015-06-02', 'BARNESNOBLE 13712 Jamb Irvine CA     731785  06/02', '19.43', '3744.39', NULL, '1', 'SAT Books', 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:54:37', 1, '2015-11-14 05:21:48'),
(326, 'DEBIT', '2015-06-02', 'BARNESNOBLE 13712 Jamb Irvine CA     235048  06/02', '36.91', '3707.48', NULL, '1', 'SAT Books', 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:54:49', 1, '2015-11-14 05:21:48'),
(327, 'CREDIT', '2015-06-02', 'Online Transfer from CHK ...9570 transaction#: 4668247731', '56.34', '3763.82', NULL, '1', 'SAT Books', 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:55:09', 1, '2015-11-14 05:21:48'),
(328, 'DEBIT', '2015-06-04', 'Anacapa Apartmen WEB PMTS   2SKY82          WEB ID: 1203874681', '2245.00', '2518.82', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:55:37', 1, '2015-11-14 05:21:48'),
(329, 'DEBIT', '2015-06-04', 'JAEGERHAUS GERMAN RESTA ANAHEIM CA           06/03', '61.14', '2457.68', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:55:46', 1, '2015-11-14 05:21:48'),
(330, 'CREDIT', '2015-06-05', 'Online Transfer from CHK ...9570 transaction#: 4675864534', '490.00', '2947.68', NULL, '5', 'Moonstone - from Nancy', 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:56:05', 1, '2015-11-14 05:21:48'),
(331, 'DEBIT', '2015-06-05', 'G BURGER IRVINE CA                           06/04', '24.84', '2922.84', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:56:13', 1, '2015-11-14 05:21:48'),
(332, 'CHECK', '2015-06-09', 'Moonstone', '490.00', '0.00', NULL, '5', NULL, 0, '2015-10-07', 1, 1, 2, '2015-06-08 06:57:16', 2, '2015-11-12 22:01:32'),
(333, 'CHECK', '2015-06-08', 'CHECK 232 ', '490.00', '2432.84', '232', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-06-08 06:57:16', 1, '2015-11-14 05:21:48'),
(334, 'DEBIT', '2015-06-08', 'TARGET T1 TARGET T1238 IRVINE CA             06/08', '45.76', '2387.08', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-11 21:18:37', 1, '2015-11-14 05:21:48'),
(335, 'DEBIT', '2015-06-08', 'STARBUCKS #22637 COSTA Costa Mesa CA         06/06', '3.95', '2383.13', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-11 21:18:45', 1, '2015-11-14 05:21:48'),
(336, 'DEBIT', '2015-06-09', 'JPMorgan Chase   Ext Trnsfr 4613408975      WEB ID: 9200502231', '333.33', '2049.80', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-11 21:19:28', 1, '2015-11-14 05:21:48'),
(337, 'DEBIT', '2015-06-10', 'TARGET T1 TARGET T1238 IRVINE CA             06/10', '25.00', '2024.80', NULL, '2', 'Meds', 1, '2015-10-07', 1, 0, 2, '2015-06-11 21:19:34', 1, '2015-11-14 05:21:48'),
(338, 'DSLIP', '2015-06-10', 'REMOTE ONLINE DEPOSIT #          1', '122.50', '2147.30', '1', '2', 'Dr Thomas Rose', 1, '2015-10-07', 1, 0, 2, '2015-06-11 21:19:50', 1, '2015-11-14 05:21:48'),
(339, 'DSLIP', '2015-06-12', 'DEPOSIT  ID NUMBER 578381', '2500.00', '4404.07', NULL, '10', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:54:34', 1, '2015-11-14 05:21:48'),
(340, 'DEBIT', '2015-06-12', 'TARGET T1 TARGET T1238 IRVINE CA             06/12', '28.04', '4376.03', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:54:46', 1, '2015-11-14 05:21:48'),
(341, 'DEBIT', '2015-06-11', 'FRY''S ELECTRONICS    FOUNTAIN VLY CA 002295  06/11', '186.18', '1961.12', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:54:54', 1, '2015-11-14 05:21:48'),
(342, 'DEBIT', '2015-06-11', 'COSTCO GAS #1110 HUNTINGTON B CA     008112  06/11', '34.50', '1926.62', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:55:01', 1, '2015-11-14 05:21:48'),
(343, 'DEBIT', '2015-06-11', 'STARBUCKS #14005 COSTA Costa Mesa CA         06/10', '10.10', '1916.52', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:55:12', 1, '2015-11-14 05:21:48'),
(344, 'DEBIT', '2015-06-11', 'CIRCLE K 03037 111 DEL COSTA MESA CA         06/11', '12.45', '1904.07', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 05:55:18', 1, '2015-11-14 05:21:48'),
(345, 'CREDIT', '2015-06-18', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '944.33', '4512.89', NULL, '13', 'from UI', 1, '2015-10-07', 1, 0, 2, '2015-06-13 17:57:57', 1, '2015-11-14 05:21:48'),
(346, 'CHECK', '2015-06-16', 'CHECK 233 ', '570.00', '3618.32', '233', '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 18:12:25', 1, '2015-11-14 05:21:48'),
(347, 'CREDIT', '2015-06-15', 'Online Transfer from CHK ...9570 transaction#: 4690420078', '320.00', '4696.03', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-13 18:13:11', 1, '2015-11-14 05:21:48'),
(348, 'DEBIT', '2015-06-12', 'NETFLIX.COM NETFLIX.COM CA                   06/12', '7.99', '19.62', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-13 18:16:49', 1, '2015-11-14 05:21:48'),
(349, 'DEBIT', '2015-06-12', 'FRY''S ELECTRONICS #7 FOUNTAIN VALL CA        06/11', '7.55', '12.07', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-13 18:16:56', 1, '2015-11-14 05:21:48'),
(350, 'DEBIT', '2015-06-16', 'STARBUCKS #11028 TUSTIN Tustin CA            06/15', '7.80', '3610.52', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:53:09', 1, '2015-11-14 05:21:48'),
(351, 'DEBIT', '2015-06-15', 'Online Payment 4691539425 To NWP SERVICES CORPORATION 06/15', '47.11', '4648.92', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:53:51', 1, '2015-11-14 05:21:48'),
(352, 'DEBIT', '2015-06-15', 'Online Payment 4691539430 To SOUTHERN CALIFORNIA GAS 06/15', '25.63', '4623.29', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:53:58', 1, '2015-11-14 05:21:48'),
(353, 'DEBIT', '2015-06-15', 'TRADER JOE''S # 197 TUSTIN CA         877580  06/14', '92.78', '4530.51', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:54:05', 1, '2015-11-14 05:21:48'),
(354, 'CREDIT', '2015-06-15', 'INTEREST PAYMENT', '0.03', '4530.54', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:54:10', 1, '2015-11-14 05:21:48'),
(355, 'DEBIT', '2015-06-15', 'SPROUTS FARMERS MKT#25 TUSTIN CA     531908  06/15', '40.50', '4490.04', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:54:17', 1, '2015-11-14 05:21:48'),
(356, 'DEBIT', '2015-06-15', 'Online Payment 4691539423 To Cox Communications 06/15', '212.68', '4277.36', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:54:26', 1, '2015-11-14 05:21:48'),
(357, 'DEBIT', '2015-06-15', 'Online Transfer to CHK ...9570 transaction#: 4691425603 06/15', '10.00', '4267.36', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:54:36', 1, '2015-11-14 05:21:48'),
(358, 'DEBIT', '2015-06-15', 'Online Transfer to CHK ...9570 transaction#: 4690095616 06/15', '10.00', '4257.36', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:55:08', 1, '2015-11-14 05:21:48'),
(359, 'DEBIT', '2015-06-15', 'Online Payment 4691539432 To VERIZON WIRELESS 06/15', '69.04', '4188.32', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:55:41', 1, '2015-11-14 05:21:48'),
(360, 'CREDIT', '2015-06-15', 'DV *ENG CATALOG 800-9891500 MA               06/12', '99.99', '112.06', NULL, '5', 'Refund - Dover', 1, '2015-10-07', 2, 0, 2, '2015-06-17 11:56:02', 1, '2015-11-14 05:21:48'),
(361, 'DEBIT', '2015-06-16', 'Online Transfer to CHK ...9570 transaction#: 4696305348 06/16', '10.00', '3600.52', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:56:21', 1, '2015-11-14 05:21:48'),
(362, 'DEBIT', '2015-06-16', 'RUBIO''S #011 TUSTIN CA                       06/15', '26.96', '3573.56', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-17 11:56:28', 1, '2015-11-14 05:21:48'),
(363, 'DEBIT', '2015-06-17', 'Online Transfer to CHK ...9570 transaction#: 4698666625 06/17', '5.00', '3568.56', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:44:29', 1, '2015-11-14 05:21:48'),
(364, 'DEBIT', '2015-06-17', 'AMERINOC COM 877-805-6542 CA                 06/15', '9.95', '102.11', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-21 09:44:36', 1, '2015-11-14 05:21:48'),
(365, 'DEBIT', '2015-06-18', '35 FOR LIFE 714-485-2299 TX                  06/16', '157.90', '4354.99', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:04', 1, '2015-11-14 05:21:48'),
(366, 'DEBIT', '2015-06-18', 'STARBUCKS #16779 GARD Garden Grove CA        06/17', '4.55', '4350.44', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:10', 1, '2015-11-14 05:21:48'),
(367, 'DEBIT', '2015-06-18', 'STATE OF CA DEPT OF D 916-464-5000 CA        06/17', '625.00', '3725.44', NULL, '18', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:17', 1, '2015-11-14 05:21:48'),
(368, 'DEBIT', '2015-06-18', 'RITE AID CORP. TUSTIN CA             778041  06/18', '8.18', '3717.26', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:26', 1, '2015-11-14 05:21:48'),
(369, 'DEBIT', '2015-06-18', 'RALPHS  TUSTIN CA                    036549  06/18', '31.09', '71.02', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-21 09:45:32', 1, '2015-11-14 05:21:48'),
(370, 'DEBIT', '2015-06-19', 'STARBUCKS #11028 TUSTIN Tustin CA            06/18', '6.70', '64.32', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-21 09:45:37', 1, '2015-11-14 05:21:48'),
(371, 'DEBIT', '2015-06-19', 'COSTCO GAS #1001 TUSTIN CA           007850  06/19', '39.03', '3678.23', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:43', 1, '2015-11-14 05:21:48'),
(372, 'DEBIT', '2015-06-19', 'RALPHS 13321 JAMBOREE TUSTIN CA      431183  06/19', '32.25', '3645.98', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-21 09:45:50', 1, '2015-11-14 05:21:48'),
(373, 'DSLIP', '2015-07-01', 'DEPOSIT  ID NUMBER 390390', '4000.00', '6039.41', NULL, NULL, NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-22 16:53:29', 1, '2015-11-14 05:21:48'),
(374, 'DEBIT', '2015-06-22', 'AMERICAN HORSE PRODU SAN JUAN CAPI CA122743  06/21', '164.81', '3481.17', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:47:22', 1, '2015-11-14 05:21:48'),
(375, 'DEBIT', '2015-06-22', 'ATM WITHDRAWAL                       003006  06/2113128 JAM', '40.00', '3441.17', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:47:29', 1, '2015-11-14 05:21:48'),
(376, 'DEBIT', '2015-06-22', 'DOORDASH.COM 6506819470 CA                   06/20', '17.20', '3423.97', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:47:45', 1, '2015-11-14 05:21:48'),
(377, 'DEBIT', '2015-06-22', 'Online Transfer to CHK ...9570 transaction#: 4704943413 06/22', '5.00', '3418.97', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:47:58', 1, '2015-11-14 05:21:48'),
(378, 'DEBIT', '2015-06-22', 'COSTCO WHSE #0122 TUSTIN CA          299123  06/20', '109.97', '3309.00', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:48:05', 1, '2015-11-14 05:21:48'),
(379, 'DEBIT', '2015-06-22', 'STARBUCKS #11093 COSTA Costa Mesa CA         06/20', '10.35', '3298.65', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:48:11', 1, '2015-11-14 05:21:48'),
(380, 'DEBIT', '2015-06-22', 'JAMBA JUICE 2 TUSTIN CA                      06/19', '16.17', '3282.48', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:48:18', 1, '2015-11-14 05:21:48'),
(381, 'DEBIT', '2015-06-22', 'FRESH & EASY#1474 Garden Grove CA    676440  06/22', '5.49', '3276.99', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:48:26', 1, '2015-11-14 05:21:48'),
(382, 'DEBIT', '2015-06-22', 'STARBUCKS #00636 SAN San Juan Capi CA        06/21', '7.20', '57.12', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-24 11:48:31', 1, '2015-11-14 05:21:48'),
(383, 'DEBIT', '2015-06-22', 'PICK UP STIX 765 TUSTIN TUSTIN CA            06/19', '27.38', '29.74', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-06-24 11:48:38', 1, '2015-11-14 05:21:48'),
(384, 'CREDIT', '2015-06-22', 'Online Transfer from CHK ...9570 transaction#: 4707909278', '129.00', '3405.99', NULL, '5', 'From Nancy', 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:48:53', 1, '2015-11-14 05:21:48'),
(385, 'DEBIT', '2015-06-23', 'STARBUCKS #16779 GARD Garden Grove CA        06/22', '4.55', '3401.44', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-24 11:49:04', 1, '2015-11-14 05:21:48'),
(386, 'DSLIP', '2015-06-24', 'DEPOSIT  ID NUMBER 990221', '660.00', '4061.44', NULL, NULL, '', 1, '2015-10-07', 1, 0, 2, '2015-06-25 12:53:39', 1, '2015-11-14 05:21:48'),
(387, 'CREDIT', '2015-07-02', 'xxxxxxx', '1111.00', '0.00', NULL, NULL, 'xxx', 0, '2015-10-07', 1, 1, 2, '2015-06-25 13:12:30', 2, '2015-11-12 22:01:32'),
(388, 'DSLIP', '2015-07-02', 'zzvczddv', '222.00', '0.00', NULL, NULL, 'dvdv', 0, '2015-10-07', 1, 1, 2, '2015-06-25 13:25:04', 2, '2015-11-12 22:01:32'),
(389, 'CHECK', '2015-07-27', 'CHECK 234 ', '830.15', '3636.40', '234', '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-06-25 13:58:18', 1, '2015-11-14 05:21:48'),
(390, 'DEBIT', '2015-06-25', 'APL* ITUNES.COM/BILL 866-712-7753 CA         06/24', '0.99', '4060.45', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:44:14', 1, '2015-11-14 05:21:48'),
(391, 'DEBIT', '2015-06-25', 'Online Transfer to CHK ...9570 transaction#: 4714173699 06/25', '70.00', '3990.45', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:45:34', 1, '2015-11-14 05:21:48'),
(392, 'DEBIT', '2015-06-29', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', '3905.45', NULL, '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:45:44', 1, '2015-11-14 05:21:48'),
(393, 'DEBIT', '2015-06-29', 'Online Transfer to CHK ...9570 transaction#: 4720985724 06/29', '5.00', '3900.45', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:45:53', 1, '2015-11-14 05:21:48'),
(394, 'DEBIT', '2015-06-29', 'TARGET T1 TARGET T1238 IRVINE CA             06/28', '31.07', '3869.38', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:46:11', 1, '2015-11-14 05:21:48'),
(395, 'DEBIT', '2015-06-29', 'AMERICAN HORSE PRODU SAN JUAN CAPI CA        06/27', '75.48', '3793.90', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:46:18', 1, '2015-11-14 05:21:48'),
(396, 'DEBIT', '2015-06-29', 'TRADER JOE''S # 197 TUSTIN CA         555324  06/28', '66.29', '3727.61', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:46:24', 1, '2015-11-14 05:21:48'),
(397, 'DEBIT', '2015-06-30', 'ROYAL CLEANERS IRVINE CA             523765  06/30', '7.75', '21.99', NULL, '5', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-01 11:46:30', 1, '2015-11-14 05:21:48'),
(398, 'DEBIT', '2015-06-30', 'POSTAL ANNEX 56 TUSTIN CA            205428  06/30', '27.90', '3699.71', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-01 11:46:38', 1, '2015-11-14 05:21:48'),
(399, 'DEBIT', '2015-07-01', 'SUBWAY        0060806 GARDEN GROVE CA        06/30', '12.02', '6027.39', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-03 13:25:07', 1, '2015-11-14 05:21:48'),
(400, 'DEBIT', '2015-07-02', 'STATE OF CA DEPT OF D 916-464-5000 CA        07/01', '600.00', '5427.39', NULL, '18', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-03 13:26:02', 1, '2015-11-14 05:21:48'),
(401, 'DEBIT', '2015-07-03', 'ARCO #42091 HUNTINGTON BE CA         857552  07/03', '35.47', '5391.92', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:04', 1, '2015-11-14 05:21:48'),
(402, 'DEBIT', '2015-07-06', 'JPMorgan Chase   Ext Trnsfr 4677015622      WEB ID: 9200502231', '333.33', '5058.59', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:11', 1, '2015-11-14 05:21:48'),
(403, 'DEBIT', '2015-07-06', 'Anacapa Apartmen WEB PMTS   M29FB2          WEB ID: 1203874681', '2245.00', '2813.59', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:17', 1, '2015-11-14 05:21:48'),
(404, 'DEBIT', '2015-07-06', 'FRESH & EASY#1474 Garden Grove CA    726420  07/06', '7.78', '2805.81', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:25', 1, '2015-11-14 05:21:48'),
(405, 'DEBIT', '2015-07-06', 'SPROUTS FARMERS MKT#25 TUSTIN CA     408729  07/04', '25.40', '2780.41', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:31', 1, '2015-11-14 05:21:48'),
(406, 'DEBIT', '2015-07-06', 'Online Payment 4733338666 To NWP SERVICES CORPORATION 07/06', '51.40', '2729.01', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:14:38', 1, '2015-11-14 05:21:48'),
(407, 'DEBIT', '2015-07-06', 'TARGET T1 TARGET T1238 IRVINE CA             07/04 Purchase $48.29 Cash Back $40.00', '88.29', '2640.72', NULL, NULL, NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:15:02', 1, '2015-11-14 05:21:48'),
(408, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...2339 transaction#: 4738475077 07/07', '100.00', '2480.22', NULL, '17', 'To Business Account', 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:15:20', 1, '2015-11-14 05:21:48'),
(409, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...9570 transaction#: 4739108893 07/07', '250.00', '2230.22', NULL, '5', 'Horse Show Deposit', 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:15:38', 1, '2015-11-14 05:21:48'),
(410, 'CREDIT', '2015-07-07', 'Online Transfer from CHK ...9657 transaction#: 4738475077', '100.00', '121.99', NULL, '17', 'From Personal', 1, '2015-10-07', 2, 0, 2, '2015-07-09 11:15:55', 1, '2015-11-14 05:21:48'),
(411, 'DEBIT', '2015-07-07', 'AAA CA MBR RENEWAL - 877-428-2277 CA         07/07', '48.00', '73.99', NULL, '7', 'AAA', 1, '2015-10-07', 2, 0, 2, '2015-07-09 11:16:07', 1, '2015-11-14 05:21:48'),
(412, 'DEBIT', '2015-07-06', 'SKYPE.COM LUXEMBOURG                         07/01', '30.50', '2610.22', NULL, '21', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:17:23', 1, '2015-11-14 05:21:48'),
(413, 'DEBIT', '2015-07-06', 'SKYPE.COM LUXEMBOURG                         07/01', '30.00', '2580.22', NULL, '21', 'Skype', 1, '2015-10-07', 1, 0, 2, '2015-07-09 11:17:36', 1, '2015-11-14 05:21:48'),
(414, 'DSLIP', '2015-07-17', 'DEPOSIT  ID NUMBER 628490', '3500.00', '5184.93', NULL, '13', 'Spectrom Tech', 1, '2015-10-07', 1, 0, 2, '2015-07-14 08:27:57', 1, '2015-11-14 05:21:48'),
(415, 'CREDIT', '2015-07-29', 'From UI', '900.00', '0.00', NULL, '14', '06/14/2015 - 06/27/2015', 0, '2015-10-07', 1, 1, 2, '2015-07-14 08:30:43', 2, '2015-11-12 22:01:32'),
(416, 'CREDIT', '2015-07-30', 'From UI', '900.00', '0.00', NULL, '14', '06/28/2015 - 07/11/2015', 0, '2015-10-07', 1, 1, 2, '2015-07-14 08:31:11', 2, '2015-11-12 22:01:32'),
(417, 'DEBIT', '2015-07-13', 'SUBWAY        0060806 GARDEN GROVE CA        07/10', '11.50', '62.49', NULL, '21', 'Lunch', 1, '2015-10-07', 2, 0, 2, '2015-07-14 08:36:09', 1, '2015-11-14 05:21:48'),
(418, 'DEBIT', '2015-07-13', 'NETFLIX.COM NETFLIX.COM CA                   07/12', '7.99', '54.50', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-14 08:36:29', 1, '2015-11-14 05:21:48'),
(419, 'DEBIT', '2015-07-09', 'Online Payment 4742976433 To Cox Communications 07/09', '199.36', '2030.86', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-14 08:37:43', 1, '2015-11-14 05:21:48'),
(420, 'DEBIT', '2015-07-10', 'PAYPAL *ENVATO MKPL EN 4029357733            07/08', '19.00', '2011.86', NULL, '21', 'YouTube Plugin', 1, '2015-10-07', 1, 0, 2, '2015-07-14 08:38:05', 1, '2015-11-14 05:21:48'),
(421, 'DEBIT', '2015-07-10', 'Online Payment 4726870504 To SOUTHERN CALIFORNIA EDISON 07/10', '102.60', '1909.26', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-14 08:38:13', 1, '2015-11-14 05:21:48'),
(422, 'DEBIT', '2015-07-10', 'Online Payment 4733338669 To VERIZON WIRELESS 07/10', '70.14', '1839.12', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-14 08:38:21', 1, '2015-11-14 05:21:48'),
(423, 'CREDIT', '2015-07-15', 'INTEREST PAYMENT', '0.03', '1839.15', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-17 08:30:18', 1, '2015-11-14 05:21:48'),
(424, 'DEBIT', '2015-07-15', 'COSTCO WHSE #1110 HUNTINGTON BE CA   256354  07/15', '110.00', '1729.15', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-17 08:30:30', 1, '2015-11-14 05:21:48'),
(425, 'DEBIT', '2015-07-15', 'COSTCO GAS #1110 HUNTINGTON B CA     058391  07/15', '44.22', '1684.93', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-17 08:30:37', 1, '2015-11-14 05:21:48'),
(426, 'DEBIT', '2015-07-17', 'AMERINOC COM 877-805-6542 CA                 07/15', '9.95', '44.55', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-27 12:40:09', 1, '2015-11-14 05:21:48'),
(427, 'DEBIT', '2015-07-17', 'TRADER JOE''S # 197 TUSTIN CA         757105  07/17', '83.46', '5101.47', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:40:17', 1, '2015-11-14 05:21:48'),
(428, 'DEBIT', '2015-07-17', 'AMAZON MKTPLACE PMTS AMZN.COM/BILL WA        07/17', '10.00', '5091.47', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:40:28', 1, '2015-11-14 05:21:48'),
(429, 'DEBIT', '2015-07-21', 'Chase QuickPay Electronic Transfer 4764433141 to Christopher', '331.20', '4760.27', NULL, '4', 'JetBlue to San Francisco', 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:41:19', 1, '2015-11-14 05:21:48'),
(430, 'DEBIT', '2015-07-22', 'ROYAL CLEANERS IRVINE CA             364183  07/22', '32.40', '4727.87', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:41:27', 1, '2015-11-14 05:21:48'),
(431, 'DEBIT', '2015-07-23', 'BART-POWELL        Q SAN FRANCISCO CA        07/23', '3.80', '4724.07', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:41:33', 1, '2015-11-14 05:21:48'),
(432, 'DEBIT', '2015-07-24', 'STARBUCKS #09687 SOU South San Fra CA        07/24', '15.20', '4708.87', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:41:39', 1, '2015-11-14 05:21:48'),
(433, 'DEBIT', '2015-07-24', 'Online Payment 4742976442 To SOUTHERN CALIFORNIA GAS 07/24', '25.32', '4683.55', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:41:47', 1, '2015-11-14 05:21:48'),
(434, 'DEBIT', '2015-07-24', 'DARBY DANS SANDWICH CO S SAN FRAN CA         07/23', '7.25', '37.30', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-27 12:41:55', 1, '2015-11-14 05:21:48'),
(435, 'DEBIT', '2015-07-24', 'AIRPORT INN S SAN FRAN CA                    07/23', '217.00', '4466.55', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:42:06', 1, '2015-11-14 05:21:48'),
(436, 'CREDIT', '2015-07-31', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '2700.00', '7821.85', NULL, '13', 'From UI', 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:48:24', 1, '2015-11-14 05:21:48'),
(437, 'CREDIT', '2015-08-12', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '900.00', '5359.49', NULL, '13', 'From UI', 1, '2015-10-07', 1, 0, 2, '2015-07-27 12:49:52', 1, '2015-11-14 05:21:48'),
(438, 'DSLIP', '2015-07-27', 'REMOTE ONLINE DEPOSIT #          1', '576.12', '613.42', '1', '14', 'Refund of payroll taxes to QWSI', 1, '2015-10-07', 2, 0, 2, '2015-07-27 12:51:20', 1, '2015-11-14 05:21:48'),
(439, 'DEBIT', '2015-07-27', 'JAMBA JUICE 2 TUSTIN CA                      07/25', '5.89', '607.53', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-30 14:09:08', 1, '2015-11-14 05:21:48'),
(440, 'DEBIT', '2015-07-27', 'WAHOO''S FISH TACO-93 NEWPORT BEACH CA        07/26', '23.78', '3612.62', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:09:42', 1, '2015-11-14 05:21:48'),
(441, 'DEBIT', '2015-07-27', 'EXPRESS LLC NEWPORT BEACH CA                 07/26', '34.65', '3577.97', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:09:50', 1, '2015-11-14 05:21:48'),
(442, 'DEBIT', '2015-07-27', 'SPROUTS FARMERS MKT#25 TUSTIN CA     506375  07/25', '50.49', '3527.48', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:09:56', 1, '2015-11-14 05:21:48'),
(443, 'DEBIT', '2015-07-27', 'APL* ITUNES.COM/BILL 866-712-7753 CA         07/24', '0.99', '3526.49', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:10:04', 1, '2015-11-14 05:21:48'),
(444, 'DEBIT', '2015-07-27', 'Online Transfer to CHK ...9570 transaction#: 4777651363 07/27', '15.00', '592.53', NULL, '1', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-30 14:10:15', 1, '2015-11-14 05:21:48'),
(445, 'DEBIT', '2015-07-28', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', '3441.49', NULL, '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:10:26', 1, '2015-11-14 05:21:48'),
(446, 'DEBIT', '2015-07-28', 'Online Transfer to CHK ...9657 transaction#: 4779781947 07/28', '500.00', '92.53', NULL, '17', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-30 14:10:35', 1, '2015-11-14 05:21:48'),
(447, 'CREDIT', '2015-07-28', 'Online Transfer from CHK ...2339 transaction#: 4779781947', '500.00', '3941.49', NULL, '17', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:10:41', 1, '2015-11-14 05:21:48'),
(448, 'DEBIT', '2015-07-28', 'Anacapa Apartmen WEB PMTS   F264C2          WEB ID: 1203874681', '56.52', '3884.97', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:10:48', 1, '2015-11-14 05:21:48'),
(449, 'DEBIT', '2015-07-28', 'HITCHN POST FEED AND TA ORANGE CA            07/26', '48.44', '3836.53', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:10:55', 1, '2015-11-14 05:21:48'),
(450, 'DEBIT', '2015-07-28', 'TRADER JOE''S # 197 TUSTIN CA         241266  07/28', '65.87', '3770.66', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:11:04', 1, '2015-11-14 05:21:48'),
(451, 'DEBIT', '2015-07-29', 'TARGET T1238 IRVINE CA               059261  07/29', '17.35', '75.18', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-30 14:11:11', 1, '2015-11-14 05:21:48'),
(452, 'DEBIT', '2015-07-29', 'COSTCO GAS #1110 HUNTINGTON B CA     083695  07/29', '41.81', '3728.85', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-30 14:11:28', 1, '2015-11-14 05:21:48'),
(453, 'DEBIT', '2015-07-29', 'TARGET T1238 IRVINE CA               025829  07/29', '43.36', '31.82', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-07-30 14:11:38', 1, '2015-11-14 05:21:48'),
(454, 'DSLIP', '2015-07-30', 'REMOTE ONLINE DEPOSIT #          1', '300.00', '4028.85', '1', '2', 'Nick & Tash Health Ins', 1, '2015-10-07', 1, 0, 2, '2015-07-31 08:13:13', 1, '2015-11-14 05:21:48'),
(455, 'CREDIT', '2015-07-30', 'Online Transfer from CHK ...9570 transaction#: 4783757829', '1150.00', '5178.85', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-31 08:13:21', 1, '2015-11-14 05:21:48'),
(456, 'CHECK', '2015-08-04', 'Health Ins', '830.15', '0.00', NULL, '2', 'August 2015', 0, '2015-10-07', 1, 1, 2, '2015-07-31 08:14:18', 2, '2015-11-12 22:01:32'),
(457, 'CHECK', '2015-08-31', 'CHECK 235 ', '830.15', '1907.46', '235', '2', 'August 2015', 1, '2015-10-07', 1, 0, 2, '2015-07-31 08:14:18', 1, '2015-11-14 05:21:48'),
(458, 'DEBIT', '2015-08-03', 'EQUESTRIAN SERVICES II COSTA MESA CA         07/31', '1000.00', '6801.85', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-07-31 08:15:13', 1, '2015-11-14 05:21:48'),
(459, 'CREDIT', '2015-08-11', 'Online Transfer from CHK ...9570 transaction#: 4809017984', '800.00', '4659.49', NULL, '5', 'HB Show', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:12:05', 1, '2015-11-14 05:21:48'),
(460, 'CHECK', '2015-08-11', 'CHECK 238 ', '200.00', '4459.49', '238', '5', 'Matt Switzer - Ferrier', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:13:40', 1, '2015-11-14 05:21:48'),
(461, 'DEBIT', '2015-08-10', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   718945  08/09', '66.07', '3958.78', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:13:48', 1, '2015-11-14 05:21:48'),
(462, 'DEBIT', '2015-08-10', 'TARGET T1 TARGET T1238 IRVINE CA             08/10', '46.79', '3911.99', NULL, '2', 'Prescriptions', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:14:06', 1, '2015-11-14 05:21:48'),
(463, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '2.00', '3909.99', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:14:28', 1, '2015-11-14 05:21:48'),
(464, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '7.00', '3902.99', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:14:42', 1, '2015-11-14 05:21:48'),
(465, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '3.50', '3899.49', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:14:58', 1, '2015-11-14 05:21:48'),
(466, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '7.00', '3892.49', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:11', 1, '2015-11-14 05:21:48'),
(467, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '16.00', '3876.49', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:21', 1, '2015-11-14 05:21:48'),
(468, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '17.00', '3859.49', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:28', 1, '2015-11-14 05:21:48'),
(469, 'DEBIT', '2015-08-07', 'JPMorgan Chase   Ext Trnsfr 4731425829      WEB ID: 9200502231', '333.33', '4175.35', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:36', 1, '2015-11-14 05:21:48'),
(470, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '27.50', '4147.85', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:45', 1, '2015-11-14 05:21:48'),
(471, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '13.00', '4134.85', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:52', 1, '2015-11-14 05:21:48'),
(472, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '10.00', '4124.85', NULL, '5', 'HB Show - Food', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:15:59', 1, '2015-11-14 05:21:48'),
(473, 'CHECK', '2015-08-07', 'CHECK 237 ', '100.00', '4024.85', '237', '5', 'Dan Porter - Trailer', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:16:39', 1, '2015-11-14 05:21:48'),
(474, 'DEBIT', '2015-08-06', 'STARBUCKS #22637 COSTA Costa Mesa CA         08/05', '6.70', '25.12', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-12 09:16:45', 1, '2015-11-14 05:21:48'),
(475, 'CREDIT', '2015-08-06', 'Online Transfer from CHK ...9570 transaction#: 4799384776', '295.00', '4726.82', NULL, '5', 'HB Show', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:00', 1, '2015-11-14 05:21:48'),
(476, 'DEBIT', '2015-08-06', 'MIGUELS JR 23 TUSTIN CA                      08/04', '11.21', '4715.61', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:08', 1, '2015-11-14 05:21:48'),
(477, 'DEBIT', '2015-08-06', 'Online Payment 4777577136 To Cox Communications 08/06', '194.62', '4520.99', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:16', 1, '2015-11-14 05:21:48'),
(478, 'DEBIT', '2015-08-06', 'TARGET T1 TARGET T1238 IRVINE CA             08/06', '12.31', '4508.68', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:26', 1, '2015-11-14 05:21:48'),
(479, 'CHECK', '2015-08-04', 'CHECK 236 ', '43.24', '4431.82', '236', '9', 'Afni - ATT', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:38', 1, '2015-11-14 05:21:48'),
(480, 'DEBIT', '2015-08-03', 'TARGET T1 TARGET T1238 IRVINE CA             08/01', '41.02', '6760.83', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:48', 1, '2015-11-14 05:21:48'),
(481, 'DEBIT', '2015-08-03', 'TRADER JOE''S # 197 TUSTIN CA         240615  08/02', '35.77', '6725.06', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:17:55', 1, '2015-11-14 05:21:48'),
(482, 'DEBIT', '2015-08-03', 'Online Transfer to CHK ...9570 transaction#: 4791226933 08/03', '10.00', '6715.06', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:18:07', 1, '2015-11-14 05:21:48'),
(483, 'DEBIT', '2015-08-03', 'Anacapa Apartmen WEB PMTS   SKCNC2          WEB ID: 1203874681', '2240.00', '4475.06', NULL, '16', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:18:16', 1, '2015-11-14 05:21:48'),
(484, 'DEBIT', '2015-07-31', 'Online Transfer to CHK ...9570 transaction#: 4786458129 07/31', '20.00', '7801.85', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:18:46', 1, '2015-11-14 05:21:48'),
(485, 'DEBIT', '2015-07-30', 'Online Payment to Equine Medical Associates', '57.00', '5121.85', NULL, '5', 'Vet', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:40:25', 1, '2015-11-14 05:21:48'),
(486, 'DEBIT', '2015-08-12', 'Online Payment 4779784583 To VERIZON WIRELESS 08/12', '69.80', '5289.69', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:43:11', 1, '2015-11-14 05:21:48'),
(487, 'DEBIT', '2015-08-12', '35 FOR LIFE 714-485-2299 TX                  08/11', '121.90', '5167.79', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:43:50', 1, '2015-11-14 05:21:48'),
(488, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9570 transaction#: 4810787262', '480.00', '5647.79', NULL, '5', 'From Nancy', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:44:18', 1, '2015-11-14 05:21:48'),
(489, 'DEBIT', '2015-08-20', 'Online Payment 4808912285 To Memorial Health Services 08/20', '40.00', '3821.14', NULL, '2', 'Blood Test - First Payment against $120', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:45:10', 1, '2015-11-14 05:21:48'),
(490, 'CHECK', '2015-08-12', 'CHECK 239 ', '880.00', '4767.79', '239', '5', 'Moonstone', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:47:10', 1, '2015-11-14 05:21:48'),
(491, 'CHECK', '2015-08-12', 'Javier Franco - Groom HB Show', '500.00', '4267.79', '240', '5', '', 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:47:50', 1, '2015-11-14 05:21:48'),
(492, 'DEBIT', '2015-08-24', 'STATE OF CA DEPT OF D 916-464-5000 CA        08/22', '625.00', '2638.77', NULL, '18', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:49:03', 1, '2015-11-14 05:21:48'),
(493, 'DEBIT', '2015-09-18', 'Online Payment 4808913626 To Memorial Health Services 09/18', '40.00', '2167.18', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-12 09:52:40', 1, '2015-11-14 05:21:49'),
(494, 'DEBIT', '2015-10-20', 'Online Payment 4808914580 To Memorial Health Services 10/20', '40.00', '4404.78', NULL, '2', NULL, 1, '2015-10-21', 1, 0, 2, '2015-08-12 09:53:44', 1, '2015-11-14 05:21:49'),
(495, 'DEBIT', '2015-08-12', 'Online Transfer to CHK ...2339 transaction#: 4810788315 08/12', '100.00', '4167.79', NULL, '17', 'To Business', 1, '2015-10-07', 1, 0, 2, '2015-08-13 12:33:13', 1, '2015-11-14 05:21:48'),
(496, 'DEBIT', '2015-08-12', 'NETFLIX.COM NETFLIX.COM CA                   08/12', '7.99', '17.13', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-13 12:34:15', 1, '2015-11-14 05:21:48'),
(497, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9657 transaction#: 4810788315', '100.00', '117.13', NULL, '17', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-13 12:34:22', 1, '2015-11-14 05:21:48'),
(498, 'DEBIT', '2015-08-12', 'ANSAR GALLERY TUSTIN CA              447910  08/12', '18.43', '98.70', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-13 12:34:29', 1, '2015-11-14 05:21:48'),
(499, 'CREDIT', '2015-08-21', 'From Savings', '1000.00', '0.00', NULL, '10', NULL, 0, '2015-10-07', 1, 1, 2, '2015-08-13 12:37:10', 2, '2015-11-12 22:01:32'),
(500, 'DEBIT', '2015-08-13', 'Online Payment 4778933007 To SOUTHERN CALIFORNIA EDISON 08/13', '68.98', '4098.81', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:02', 1, '2015-11-14 05:21:48'),
(501, 'DEBIT', '2015-08-13', 'TRADER JOE''S # 197 TUSTIN CA         681115  08/13', '42.40', '4056.41', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:08', 1, '2015-11-14 05:21:48'),
(502, 'DEBIT', '2015-08-13', 'STARBUCKS #22637 COSTA Costa Mesa CA         08/12', '4.55', '4051.86', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:15', 1, '2015-11-14 05:21:48'),
(503, 'DEBIT', '2015-08-14', 'COSTCO GAS #1001 TUSTIN CA           040388  08/14', '40.95', '4010.91', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:22', 1, '2015-11-14 05:21:48'),
(504, 'DEBIT', '2015-08-14', 'TAX PROS 209-589-9046 CA                     08/12', '36.95', '3973.96', NULL, '11', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:41', 1, '2015-11-14 05:21:48'),
(505, 'DEBIT', '2015-08-14', 'SUBWAY        00018846 COSTA MESA CA         08/13', '14.99', '83.71', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-20 08:33:47', 1, '2015-11-14 05:21:48'),
(506, 'CREDIT', '2015-08-17', 'INTEREST PAYMENT', '0.04', '3974.00', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:33:52', 1, '2015-11-14 05:21:48'),
(507, 'DEBIT', '2015-08-17', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   913901  08/15', '9.96', '73.75', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-20 08:33:59', 1, '2015-11-14 05:21:48'),
(508, 'DEBIT', '2015-08-17', 'STARBUCKS CARD RELOAD 800-782-7282 WA        08/15', '15.00', '58.75', NULL, '1', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-20 08:34:20', 1, '2015-11-14 05:21:48'),
(509, 'DEBIT', '2015-08-17', 'MCDONALD''S F34609 COSTA MESA CA              08/13', '6.24', '52.51', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-20 08:34:44', 1, '2015-11-14 05:21:48'),
(510, 'DEBIT', '2015-08-18', 'TRADER JOE''S # 210 IRVINE CA         677137  08/18', '72.86', '3901.14', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:34:54', 1, '2015-11-14 05:21:48'),
(511, 'DEBIT', '2015-08-18', 'AMERINOC COM 877-805-6542 CA                 08/15', '9.95', '42.56', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-20 08:35:03', 1, '2015-11-14 05:21:48'),
(512, 'DEBIT', '2015-08-19', 'ATM WITHDRAWAL                       002932  08/1913128 JAM', '40.00', '3861.14', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-20 08:35:16', 1, '2015-11-14 05:21:48'),
(513, 'CREDIT', '2015-11-20', 'State Tax Refund', '202.00', '4086.14', NULL, '14', '', 0, NULL, 1, 0, 2, '2015-08-20 09:23:07', 1, '2015-11-15 05:34:18'),
(514, 'CREDIT', '2015-10-31', 'Federal Tax Refund', '200.00', '2657.57', NULL, '14', '', 0, '2015-11-04', 1, 1, 2, '2015-08-20 09:23:41', 2, '2015-11-12 21:58:43'),
(515, 'DEBIT', '2015-08-20', 'TUSTIN RANCH TIRE AND TUSTIN CA      802939  08/20', '499.32', '3321.82', NULL, '7', 'Tires', 1, '2015-10-07', 1, 0, 2, '2015-08-22 07:43:08', 1, '2015-11-14 05:21:48'),
(516, 'DEBIT', '2015-08-20', 'ANSAR GALLERY TUSTIN CA              135261  08/20', '18.92', '3302.90', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-22 07:44:04', 1, '2015-11-14 05:21:48');
INSERT INTO `transaction` (`id`, `type`, `transaction_date`, `description`, `amount`, `bank_account_balance`, `check_num`, `category_id`, `notes`, `is_uploaded`, `reconciled_date`, `bank_account_id`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(517, 'DEBIT', '2015-08-21', 'DAPHNE''S COSTA MES COSTA MESA CA             08/20', '21.22', '3281.68', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-22 07:44:13', 1, '2015-11-14 05:21:48'),
(518, 'DEBIT', '2015-08-21', 'Online Payment 4801929763 To SOUTHERN CALIFORNIA GAS 08/21', '17.91', '3263.77', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-22 07:44:23', 1, '2015-11-14 05:21:48'),
(519, 'CREDIT', '2015-08-28', 'Pay From Robert Half', '280.00', '0.00', NULL, '13', 'TotalApps', 0, '2015-10-07', 1, 1, 2, '2015-08-22 07:46:08', 2, '2015-11-12 22:01:32'),
(520, 'DEBIT', '2015-08-24', 'KOHL''S #1382 18182 IRV TUSTIN CA     916405  08/23', '53.98', '2584.79', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:55:39', 1, '2015-11-14 05:21:48'),
(521, 'DEBIT', '2015-08-24', 'STARBUCKS CARD RELOAD 800-782-7282 WA        08/24', '10.00', '32.56', NULL, '1', NULL, 1, '2015-10-07', 2, 0, 2, '2015-08-29 08:55:47', 1, '2015-11-14 05:21:48'),
(522, 'DEBIT', '2015-08-24', 'TRADER JOE''S # 197 TUSTIN CA         278695  08/23', '77.64', '2507.15', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:55:53', 1, '2015-11-14 05:21:48'),
(523, 'DEBIT', '2015-08-26', 'AULD DUBLINER TUSTIN TUSTIN CA               08/24', '24.80', '2482.35', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:56:14', 1, '2015-11-14 05:21:48'),
(524, 'DEBIT', '2015-08-27', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', '2397.35', NULL, '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:56:24', 1, '2015-11-14 05:21:48'),
(525, 'CREDIT', '2015-08-27', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '384.09', '2781.44', NULL, '13', 'Robert Half', 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:56:41', 1, '2015-11-14 05:21:48'),
(526, 'DEBIT', '2015-08-28', 'TRADER JOE''S #195 ALISO VIEJO CA     042760  08/28', '5.28', '2776.16', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:56:52', 1, '2015-11-14 05:21:48'),
(527, 'DEBIT', '2015-08-28', 'COSTCO GAS #1001 TUSTIN CA           061817  08/28', '38.55', '2737.61', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-08-29 08:57:01', 1, '2015-11-14 05:21:48'),
(528, 'CHECK', '2015-09-22', 'Health Insurance', '903.93', '0.00', NULL, '2', NULL, 0, '2015-10-07', 1, 1, 2, '2015-08-29 09:05:38', 2, '2015-11-12 22:01:32'),
(529, 'CHECK', '2015-09-25', 'CHECK 241 ', '902.93', '2352.31', '241', '2', 'September', 1, '2015-10-07', 1, 0, 2, '2015-08-29 09:05:38', 1, '2015-11-14 05:21:49'),
(530, 'DSLIP', '2015-08-31', 'REMOTE ONLINE DEPOSIT #          1', '300.00', '2207.46', '1', '2', 'For Nick and Tash', 1, '2015-10-07', 1, 0, 2, '2015-08-29 09:07:47', 1, '2015-11-14 05:21:48'),
(531, 'DEBIT', '2015-09-01', 'ConService', '46.54', '0.00', NULL, '9', 'Water', 0, '2015-10-07', 1, 1, 2, '2015-08-29 09:11:33', 2, '2015-11-12 22:01:32'),
(532, 'DSLIP', '2015-08-31', 'DEPOSIT  ID NUMBER 570514', '1000.00', '3207.46', NULL, '10', 'Savings', 1, '2015-10-07', 1, 0, 2, '2015-08-29 09:21:04', 1, '2015-11-14 05:21:48'),
(533, 'DEBIT', '2015-08-31', 'TRADER JOE''S # 210 IRVINE CA         536123  08/31', '20.21', '3187.25', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:26:45', 1, '2015-11-14 05:21:48'),
(534, 'DEBIT', '2015-08-31', 'Online Transfer to CHK ...9570 transaction#: 4848568454 08/31', '10.00', '3177.25', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:26:58', 1, '2015-11-14 05:21:48'),
(535, 'DEBIT', '2015-08-31', 'TRADER JOE''S # 197 TUSTIN CA         919596  08/30', '52.00', '3125.25', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:27:04', 1, '2015-11-14 05:21:48'),
(536, 'DEBIT', '2015-08-31', 'COSTCO WHSE #1001 TUSTIN CA          204030  08/29', '178.97', '2946.28', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:27:10', 1, '2015-11-14 05:21:48'),
(537, 'DEBIT', '2015-08-31', 'JUICE IT UP COSTA MESA CA                    08/29', '26.10', '2920.18', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:27:17', 1, '2015-11-14 05:21:48'),
(538, 'DEBIT', '2015-08-31', 'SUPERCUTS 8744 IRVINE CA                     08/29', '18.50', '2901.68', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-01 16:27:23', 1, '2015-11-14 05:21:48'),
(539, 'DEBIT', '2015-09-01', 'Anacapa Apartmen WEB PMTS   09JYD2          WEB ID: 1203874681', '2291.54', '610.14', NULL, NULL, 'Robert Half', 1, '2015-10-07', 1, 0, 2, '2015-09-03 09:44:41', 1, '2015-11-14 05:21:48'),
(540, 'CREDIT', '2015-09-02', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1716.93', '2327.07', NULL, '13', 'Robert Half', 1, '2015-10-07', 1, 0, 2, '2015-09-03 09:44:57', 1, '2015-11-14 05:21:48'),
(541, 'DEBIT', '2015-09-02', 'Online Transfer to MMA ...0371 transaction#: 4855032727 09/02', '500.00', '1827.07', NULL, '17', 'from Checking', 1, '2015-10-07', 1, 0, 2, '2015-09-03 09:45:03', 1, '2015-11-14 05:21:48'),
(542, 'CREDIT', '2015-09-02', 'Online Transfer from CHK ...9657 transaction#: 4855032727', '500.00', '500.09', NULL, '17', 'From Premier Account', 1, '2015-10-07', 6, 0, 2, '2015-09-03 14:57:13', 1, '2015-11-14 05:21:48'),
(543, 'DEBIT', '2015-09-08', 'Online Payment 4844889178 To Cox Communications 09/08', '194.62', '1632.45', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:11', 1, '2015-11-14 05:21:48'),
(544, 'DEBIT', '2015-09-08', 'CITY OF HB PARKING M HUNTINGTN BCH CA        09/07', '6.00', '1626.45', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:19', 1, '2015-11-14 05:21:48'),
(545, 'DEBIT', '2015-09-08', 'TRADER JOE''S # 197 TUSTIN CA         394151  09/06', '66.13', '1560.32', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:26', 1, '2015-11-14 05:21:49'),
(546, 'DEBIT', '2015-09-08', 'CROWN ACE HARDWA COSTA MESA CA               09/06 Purchase $38.62 Cash Back $20.00', '58.62', '1501.70', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:35', 1, '2015-11-14 05:21:49'),
(547, 'DEBIT', '2015-09-08', 'TARGET        00012385 IRVINE CA             09/05', '65.77', '1435.93', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:42', 1, '2015-11-14 05:21:49'),
(548, 'DEBIT', '2015-09-08', 'RUBIO''S #011 TUSTIN CA                       09/05', '11.74', '1424.19', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:49', 1, '2015-11-14 05:21:49'),
(549, 'DEBIT', '2015-09-08', 'STATE OF CA DEPT OF D 916-464-5000 CA        09/05', '625.00', '799.19', NULL, '18', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:34:55', 1, '2015-11-14 05:21:49'),
(550, 'DEBIT', '2015-09-08', 'COSTCO GAS #1001 TUSTIN CA           084812  09/08', '36.44', '762.75', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:35:02', 1, '2015-11-14 05:21:49'),
(551, 'DEBIT', '2015-09-08', 'THE FLAME BROILER #175 TUSTIN CA             09/05', '5.40', '27.16', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-10 09:35:08', 1, '2015-11-14 05:21:49'),
(552, 'DEBIT', '2015-09-09', 'JPMorgan Chase   Ext Trnsfr 4798914040      WEB ID: 9200502231', '333.33', '429.42', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:35:15', 1, '2015-11-14 05:21:49'),
(553, 'DEBIT', '2015-09-09', 'VVS*VAL VET/DIRECT PE 800-468-0059 KS        09/08', '52.95', '376.47', NULL, '5', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:35:27', 1, '2015-11-14 05:21:49'),
(554, 'CREDIT', '2015-09-10', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1716.93', '2093.40', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-10 09:38:04', 1, '2015-11-14 05:21:49'),
(555, 'CREDIT', '2015-09-17', 'Total Apps', '1267.67', '0.00', NULL, '13', NULL, 0, '2015-10-07', 1, 1, 2, '2015-09-10 09:38:46', 2, '2015-11-12 22:01:32'),
(556, 'CREDIT', '2015-09-10', 'Online Transfer from CHK ...9657 transaction#: 4870329779', '100.00', '127.16', NULL, '17', 'from Premier account', 1, '2015-10-07', 2, 0, 2, '2015-09-11 12:54:24', 1, '2015-11-14 05:21:49'),
(557, 'CREDIT', '2015-09-10', 'Online Transfer from CHK ...9657 transaction#: 4870326664', '500.00', '1000.09', NULL, '17', 'From Premier Account', 1, '2015-10-07', 6, 0, 2, '2015-09-11 12:54:48', 1, '2015-11-14 05:21:49'),
(558, 'DEBIT', '2015-09-10', 'Online Payment 4844889184 To VERIZON WIRELESS 09/10', '69.98', '2023.42', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-11 12:55:31', 1, '2015-11-14 05:21:49'),
(559, 'DEBIT', '2015-09-10', 'Online Transfer to MMA ...0371 transaction#: 4870326664 09/10', '500.00', '1523.42', NULL, '17', 'to savings acount', 1, '2015-10-07', 1, 0, 2, '2015-09-11 12:55:45', 1, '2015-11-14 05:21:49'),
(560, 'DEBIT', '2015-09-10', 'Online Transfer to CHK ...2339 transaction#: 4870329779 09/10', '100.00', '1423.42', NULL, '17', 'to business account', 1, '2015-10-07', 1, 0, 2, '2015-09-11 12:56:00', 1, '2015-11-14 05:21:49'),
(561, 'DEBIT', '2015-09-10', 'Online Payment 4870465364 To SOUTHERN CALIFORNIA EDISON 09/10', '57.16', '1366.26', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-11 12:56:06', 1, '2015-11-14 05:21:49'),
(562, 'DEBIT', '2015-09-11', 'APL* ITUNES.COM/BILL 866-712-7753 CA         09/10', '0.99', '1365.27', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-15 08:26:56', 1, '2015-11-14 05:21:49'),
(563, 'DEBIT', '2015-09-14', 'STARBUCKS #19353 WESTM Westminster CA        09/12', '6.70', '120.46', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-15 08:27:10', 1, '2015-11-14 05:21:49'),
(564, 'CREDIT', '2015-09-24', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1571.20', '3320.68', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 08:24:53', 1, '2015-11-14 05:21:49'),
(565, 'DEBIT', '2015-09-14', 'NETFLIX.COM NETFLIX.COM CA                   09/13', '7.99', '112.47', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-17 09:20:22', 1, '2015-11-14 05:21:49'),
(566, 'DEBIT', '2015-09-14', 'EUREKA HUNTINGTON BE HUNTINGTON BE CA        09/11', '94.25', '1271.02', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 09:20:34', 1, '2015-11-14 05:21:49'),
(567, 'DEBIT', '2015-09-14', 'ATM WITHDRAWAL                       006903  09/1213128 JAM', '100.00', '1171.02', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 09:20:48', 1, '2015-11-14 05:21:49'),
(568, 'DEBIT', '2015-09-14', 'VIVA FRESH MEXICAN RES BURBANK CA            09/12', '68.02', '1103.00', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 09:21:03', 1, '2015-11-14 05:21:49'),
(569, 'DEBIT', '2015-09-14', 'COSTCO GAS #0411 FOUNTAIN VALL CA    020051  09/13', '25.45', '1077.55', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 09:21:10', 1, '2015-11-14 05:21:49'),
(570, 'DEBIT', '2015-09-14', 'WHICH WICH #354 TUSTIN CA                    09/13', '8.86', '103.61', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-17 09:21:17', 1, '2015-11-14 05:21:49'),
(571, 'DEBIT', '2015-09-15', 'Online Transfer to CHK ...9570 transaction#: 4880457094 09/15', '75.00', '1002.55', NULL, '1', 'School supplies', 1, '2015-10-07', 1, 0, 2, '2015-09-17 10:14:14', 1, '2015-11-14 05:21:49'),
(572, 'CREDIT', '2015-09-16', 'INTEREST PAYMENT', '0.01', '1000.10', NULL, '14', NULL, 1, '2015-10-07', 6, 0, 2, '2015-09-17 10:14:36', 1, '2015-11-14 05:21:49'),
(573, 'DEBIT', '2015-09-16', 'HARRY''S 888-212-6855 WWW.HARRYS.CO NY        09/13', '33.00', '969.55', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 10:14:45', 1, '2015-11-14 05:21:49'),
(574, 'DEBIT', '2015-09-16', 'TCA FASTRAK R 949-727-4800 CA                09/16', '30.00', '939.55', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 10:14:54', 1, '2015-11-14 05:21:49'),
(575, 'CREDIT', '2015-09-16', 'INTEREST PAYMENT', '0.02', '939.57', NULL, '14', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-17 10:15:05', 1, '2015-11-14 05:21:49'),
(576, 'DEBIT', '2015-09-16', 'RALPHS TUSTIN CA                     034317  09/16', '19.48', '84.13', NULL, '6', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-17 10:15:13', 1, '2015-11-14 05:21:49'),
(577, 'CREDIT', '2015-09-17', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1267.61', '2207.18', NULL, '13', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:04:37', 1, '2015-11-14 05:21:49'),
(578, 'DEBIT', '2015-09-17', 'AMERINOC COM 877-805-6542 CA                 09/15', '9.95', '74.18', NULL, '9', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-24 08:04:47', 1, '2015-11-14 05:21:49'),
(579, 'DEBIT', '2015-09-18', 'TRADER JOE''S #195 ALISO VIEJO CA     180923  09/18', '68.55', '2098.63', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:04:53', 1, '2015-11-14 05:21:49'),
(580, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '10.00', '2088.63', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:15', 1, '2015-11-14 05:21:49'),
(581, 'DEBIT', '2015-09-21', 'Online Transfer to CHK ...9570 transaction#: 4889717746 09/21', '25.00', '2063.63', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:28', 1, '2015-11-14 05:21:49'),
(582, 'DEBIT', '2015-09-21', 'PETSMART INC 1314 TUSTIN CA          254077  09/19', '41.98', '2021.65', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:35', 1, '2015-11-14 05:21:49'),
(583, 'DEBIT', '2015-09-21', 'COSTCO GAS #1001 TUSTIN CA           096284  09/20', '31.11', '1990.54', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:42', 1, '2015-11-14 05:21:49'),
(584, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '18.00', '1972.54', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:49', 1, '2015-11-14 05:21:49'),
(585, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '22.00', '1950.54', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:05:55', 1, '2015-11-14 05:21:49'),
(586, 'DEBIT', '2015-09-21', 'ATM WITHDRAWAL                       008042  09/1913128 JAM', '100.00', '1850.54', NULL, '5', 'Riding Lesson w/Michael $85', 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:06:24', 1, '2015-11-14 05:21:49'),
(587, 'DEBIT', '2015-09-21', 'ROSS STORES #179 TUSTIN CA           655258  09/20', '8.62', '65.56', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-24 08:06:32', 1, '2015-11-14 05:21:49'),
(588, 'DEBIT', '2015-09-21', 'ARCO T83551 COSTA MESA CA            066676  09/19', '10.42', '55.14', NULL, '3', NULL, 1, '2015-10-07', 2, 0, 2, '2015-09-24 08:06:43', 1, '2015-11-14 05:21:49'),
(589, 'DEBIT', '2015-09-21', 'NEWPORT CREST MEDICA NEWPORT BEACH CA        09/17', '40.00', '1810.54', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:06:53', 1, '2015-11-14 05:21:49'),
(590, 'DEBIT', '2015-09-22', 'TARGET        00012385 IRVINE CA             09/21', '18.98', '1791.56', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:07:11', 1, '2015-11-14 05:21:49'),
(591, 'DEBIT', '2015-09-23', 'OFFICE MAX/OFFI 13728 IRVINE CA      102437  09/23', '21.58', '1769.98', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:07:18', 1, '2015-11-14 05:21:49'),
(592, 'DEBIT', '2015-09-23', 'Online Payment 4859940019 To SOUTHERN CALIFORNIA GAS 09/23', '20.50', '1749.48', NULL, '9', NULL, 1, '2015-10-07', 1, 0, 2, '2015-09-24 08:07:26', 1, '2015-11-14 05:21:49'),
(593, 'CHECK', '2015-10-01', 'CHECK 242 ', '500.00', '2511.82', '242', '4', 'US Citizenship', 1, '2015-10-07', 1, 0, 1, '2015-09-25 00:00:00', 1, '2015-11-14 05:21:49'),
(594, 'DEBIT', '2015-09-24', 'Online Transfer to CHK ...9570 transaction#: 4897558868 09/24', '5.00', '3315.68', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:19:49', 1, '2015-11-14 05:21:49'),
(595, 'DEBIT', '2015-09-24', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   299970  09/24', '60.44', '3255.24', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:20:02', 1, '2015-11-14 05:21:49'),
(596, 'DEBIT', '2015-09-25', 'BARNESNOBLE 13712 Jamb Irvine CA     560007  09/25', '37.15', '2315.16', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:07', 1, '2015-11-14 05:21:49'),
(597, 'DEBIT', '2015-09-25', 'JUICE IT UP COSTA MESA CA                    09/24', '10.50', '2304.66', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:15', 1, '2015-11-14 05:21:49'),
(598, 'DEBIT', '2015-09-28', 'Online Transfer to CHK ...9570 transaction#: 4905453004 09/28', '10.00', '2294.66', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:33', 1, '2015-11-14 05:21:49'),
(599, 'DEBIT', '2015-09-28', 'TARGET        00012385 IRVINE CA             09/27', '19.12', '2275.54', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:42', 1, '2015-11-14 05:21:49'),
(600, 'DEBIT', '2015-09-28', 'COSTCO GAS #1001 TUSTIN CA           051947  09/27', '34.26', '2241.28', NULL, '3', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:48', 1, '2015-11-14 05:21:49'),
(601, 'DEBIT', '2015-09-28', 'ATM WITHDRAWAL                       009703  09/2631972 CAM', '140.00', '2101.28', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:21:56', 1, '2015-11-14 05:21:49'),
(602, 'DEBIT', '2015-09-28', 'TARGET        00012385 IRVINE CA             09/25', '29.78', '2071.50', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:22:04', 1, '2015-11-14 05:21:49'),
(603, 'DEBIT', '2015-09-28', 'MIGUELS JR #20 COSTA MESA CA                 09/25', '7.54', '2063.96', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:22:10', 1, '2015-11-14 05:21:49'),
(604, 'DEBIT', '2015-09-28', 'THE WATER BREWERY COSTA MESA CA              09/25', '51.41', '2012.55', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:22:23', 1, '2015-11-14 05:21:49'),
(605, 'CREDIT', '2015-09-28', 'Online Transfer from MMA ...0371 transaction#: 4905455106', '1000.00', '3012.55', NULL, '17', 'from Savings', 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:22:43', 1, '2015-11-14 05:21:49'),
(606, 'DEBIT', '2015-09-28', 'Online Transfer to CHK ...9657 transaction#: 4905455106 09/28', '1000.00', '0.10', NULL, '17', 'To Premier Account', 1, '2015-10-07', 6, 0, 2, '2015-10-03 10:23:03', 1, '2015-11-14 05:21:49'),
(607, 'DEBIT', '2015-09-29', 'TCA FASTRAK R 949-727-4800 CA                09/28', '30.00', '2982.55', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:23:11', 1, '2015-11-14 05:21:49'),
(608, 'DEBIT', '2015-09-29', 'POSTAL ANNEX LAKE FOREST CA          406170  09/29', '9.95', '2972.60', NULL, '4', 'Citizenship Photos', 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:23:31', 1, '2015-11-14 05:21:49'),
(609, 'DEBIT', '2015-09-29', 'COSTCO WHSE #0122 TUSTIN CA          472844  09/29', '134.04', '2838.56', NULL, '6', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:23:37', 1, '2015-11-14 05:21:49'),
(610, 'DEBIT', '2015-09-29', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', '2753.56', NULL, '7', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:23:53', 1, '2015-11-14 05:21:49'),
(611, 'DSLIP', '2015-09-29', 'DEPOSIT  ID NUMBER 265785', '258.26', '3011.82', NULL, '14', 'Lens v Anthem Insurance Companies - Class Action', 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:24:31', 1, '2015-11-14 05:21:49'),
(612, 'DEBIT', '2015-10-05', 'Anacapa Apartmen WEB PMTS   0HNYG2          WEB ID: 1203874681', '2291.10', '220.72', NULL, NULL, NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:39:39', 1, '2015-11-14 05:21:49'),
(613, 'CREDIT', '2015-10-05', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '902.93', '1123.65', NULL, '13', 'Robert Half - TotalApps', 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:43:06', 1, '2015-11-14 05:21:49'),
(614, 'DEBIT', '2015-10-05', '35 FOR LIFE 714-485-2299 TX                  10/01', '129.53', '994.12', NULL, '2', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-03 10:43:47', 1, '2015-11-14 05:21:49'),
(615, 'DSLIP', '2015-10-05', 'DEPOSIT  ID NUMBER 980267', '5000.00', '5994.12', NULL, '14', 'From UK', 1, '2015-10-07', 1, 0, 2, '2015-10-04 10:11:38', 1, '2015-11-14 05:21:49'),
(616, 'DSLIP', '2015-10-05', 'REMOTE ONLINE DEPOSIT #          1', '100.59', '6094.71', '1', '2', 'Anthem Blue Cross Rebate', 1, '2015-10-07', 1, 0, 2, '2015-10-04 10:12:29', 1, '2015-11-14 05:21:49'),
(617, 'DEBIT', '2015-10-05', 'TARGET        00012385 IRVINE CA             10/03', '53.72', '6040.99', NULL, NULL, NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-04 10:13:25', 1, '2015-11-14 05:21:49'),
(618, 'DEBIT', '2015-10-06', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '4000.00', '2439.87', NULL, '10', 'Fidelity', 1, '2015-10-07', 1, 0, 2, '2015-10-04 10:14:18', 1, '2015-11-14 05:21:49'),
(619, 'CREDIT', '2015-10-05', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '585.00', '6625.99', NULL, '13', 'From UI', 1, '2015-10-07', 1, 0, 2, '2015-10-04 10:31:18', 1, '2015-11-14 05:21:49'),
(620, 'CHECK', '2015-11-05', 'CHECK # 0243      USCIS PHOENIX    PAYMENT           ARC ID: 7001010303', '680.00', '1399.89', '243', '4', 'US Dept of Home Security', 1, NULL, 1, 0, 2, '2015-10-10 11:21:16', 1, '2015-11-14 05:21:49'),
(621, 'DEBIT', '2015-10-05', 'Online Transfer to CHK ...9570 transaction#: 4920133088 10/05', '10.00', '6615.99', NULL, '1', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:13:09', 1, '2015-11-14 05:21:49'),
(622, 'DEBIT', '2015-10-05', 'CENTURY THEATRES 482 HUNTINGTN BCH CA        10/04', '42.50', '6573.49', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:13:17', 1, '2015-11-14 05:21:49'),
(623, 'DEBIT', '2015-10-05', 'RUBIO''S #011 TUSTIN CA                       10/04', '8.63', '46.51', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-10-11 16:13:23', 1, '2015-11-14 05:21:49'),
(624, 'DEBIT', '2015-10-05', 'Online Transfer to CHK ...9570 transaction#: 4923101850 10/05', '109.00', '6464.49', NULL, '1', 'Driving Lesson', 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:14:05', 1, '2015-11-14 05:21:49'),
(625, 'DEBIT', '2015-10-05', 'WHOLEFDS HTB 10 7881 HUNTINGTON BE CA936274  10/04', '24.62', '6439.87', NULL, '4', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:14:11', 1, '2015-11-14 05:21:49'),
(626, 'DEBIT', '2015-10-05', 'WHOLEFDS HTB 10 7881 HUNTINGTON BE CA258648  10/04', '6.85', '39.66', NULL, '4', NULL, 1, '2015-10-07', 2, 0, 2, '2015-10-11 16:14:33', 1, '2015-11-14 05:21:49'),
(627, 'DEBIT', '2015-10-06', 'HARBOR JUSTICE CENTE NEWPORT BEACH CA        10/05', '25.00', '2414.87', NULL, '4', 'Citizenship - Criminal Record', 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:14:57', 1, '2015-11-14 05:21:49'),
(628, 'DEBIT', '2015-10-06', 'Online Transfer to CHK ...9570 transaction#: 4924816941 10/06', '56.00', '2358.87', NULL, '5', 'Feed', 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:15:34', 1, '2015-11-14 05:21:49'),
(629, 'DEBIT', '2015-10-07', 'JPMorgan Chase   Ext Trnsfr 4861396298      WEB ID: 9200502231', '333.33', '2025.54', NULL, '15', NULL, 1, '2015-10-07', 1, 0, 2, '2015-10-11 16:15:42', 1, '2015-11-14 05:21:49'),
(630, 'DEBIT', '2015-10-08', 'Online Transfer to CHK ...9570 transaction#: 4928497722 10/08', '30.00', '1995.54', NULL, '1', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:15:59', 1, '2015-11-14 05:21:49'),
(631, 'DEBIT', '2015-10-08', 'Online Payment 4906999435 To Cox Communications 10/08', '194.62', '1800.92', NULL, '9', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:05', 1, '2015-11-14 05:21:49'),
(632, 'DEBIT', '2015-10-09', 'RALPHS 13321 JAMBOREE TUSTIN CA      463108  10/09', '48.34', '1752.58', NULL, '6', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:14', 1, '2015-11-14 05:21:49'),
(633, 'DEBIT', '2015-10-09', 'COSTCO GAS #1001 TUSTIN CA           048085  10/09', '35.20', '1717.38', NULL, '3', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:22', 1, '2015-11-14 05:21:49'),
(634, 'DEBIT', '2015-10-09', 'Online Payment 4920399432 To VERIZON WIRELESS 10/09', '69.36', '1648.02', NULL, '9', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:28', 1, '2015-11-14 05:21:49'),
(635, 'DEBIT', '2015-10-09', 'APL* ITUNES.COM/BILL 866-712-7753 CA         10/08', '0.99', '1647.03', NULL, '9', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:34', 1, '2015-11-14 05:21:49'),
(636, 'DEBIT', '2015-10-09', '35 FOR LIFE 714-485-2299 TX                  10/07', '28.40', '1618.63', NULL, '2', 'For Natasha', 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:46', 1, '2015-11-14 05:21:49'),
(637, 'DEBIT', '2015-10-09', 'Online Payment 4901130932 To SOUTHERN CALIFORNIA EDISON 10/09', '76.01', '1542.62', NULL, '9', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-11 16:16:53', 1, '2015-11-14 05:21:49'),
(638, 'CHECK', '2015-10-28', 'CHECK 244 ', '866.75', '1665.28', '244', '2', 'October Premium', 1, '2015-11-04', 1, 0, 2, '2015-10-11 16:25:42', 1, '2015-11-14 05:21:49'),
(639, 'DSLIP', '2015-01-02', 'Opening Deposit', '3026.27', '4875.70', NULL, '22', NULL, 1, '2015-10-07', 1, 0, 1, '2015-10-17 00:00:00', 1, '2015-11-14 05:21:46'),
(640, 'DSLIP', '2015-01-02', 'Opening Deposit', '158.05', '158.05', NULL, '22', NULL, 1, '2015-10-07', 2, 0, 1, '2015-10-17 00:00:00', 1, '2015-11-14 05:21:46'),
(641, 'DSLIP', '2015-01-02', 'Opening Deposit', '0.09', '0.09', NULL, '22', NULL, 1, '2015-10-07', 6, 0, 1, '2015-10-17 00:00:00', 1, '2015-11-14 05:21:46'),
(642, 'DEBIT', '2015-10-13', 'Online Transfer to CHK ...9570 transaction#: 4932803174 10/13', '245.00', '1297.62', NULL, '5', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:44:39', 1, '2015-11-14 05:21:49'),
(643, 'DEBIT', '2015-10-13', 'DOVER SADDLERY - L LAGUNA HILLS CA           10/10', '24.83', '1272.79', NULL, '5', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:44:45', 1, '2015-11-14 05:21:49'),
(644, 'DEBIT', '2015-10-13', 'TRADER JOE''S # 210 IRVINE CA         909893  10/10', '98.04', '1174.75', NULL, '6', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:44:52', 1, '2015-11-14 05:21:49'),
(645, 'DEBIT', '2015-10-13', 'NETFLIX.COM NETFLIX.COM CA                   10/12', '7.99', '31.67', NULL, '9', NULL, 1, '2015-10-21', 2, 0, 2, '2015-10-17 08:44:59', 1, '2015-11-14 05:21:49'),
(646, 'DEBIT', '2015-10-13', 'THE HABIT-COSTA MESA #6 COSTA MESA CA        10/11', '29.05', '1145.70', NULL, '4', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:06', 1, '2015-11-14 05:21:49'),
(647, 'DEBIT', '2015-10-13', 'ATM WITHDRAWAL                       009815  10/131455 BAKE', '120.00', '1025.70', NULL, '4', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:14', 1, '2015-11-14 05:21:49'),
(648, 'DEBIT', '2015-10-13', 'Online Transfer to CHK ...9570 transaction#: 4936153482 10/13', '20.00', '1005.70', NULL, '1', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:22', 1, '2015-11-14 05:21:49'),
(649, 'DSLIP', '2015-10-13', 'DEPOSIT  ID NUMBER 228258', '225.00', '1230.70', NULL, '5', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:29', 1, '2015-11-14 05:21:49'),
(650, 'DEBIT', '2015-10-15', 'Online Transfer to CHK ...2339 transaction#: 4941907310 10/15', '100.00', '1130.70', NULL, '17', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:42', 1, '2015-11-14 05:21:49'),
(651, 'CREDIT', '2015-10-15', 'Online Transfer from CHK ...9657 transaction#: 4941907310', '100.00', '131.67', NULL, '17', NULL, 1, '2015-10-21', 2, 0, 2, '2015-10-17 08:45:53', 1, '2015-11-14 05:21:49'),
(652, 'CREDIT', '2015-10-16', 'INTEREST PAYMENT', '0.02', '1130.72', NULL, '14', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:45:59', 1, '2015-11-14 05:21:49'),
(653, 'CREDIT', '2015-10-16', 'MLS TECHNOLOGIES DIRDEP                     PPD ID: 1330914630', '4082.02', '5212.74', NULL, '13', 'MLS Technologies - Panasonic', 1, '2015-10-21', 1, 0, 2, '2015-10-17 08:46:19', 1, '2015-11-14 05:21:49'),
(654, 'CREDIT', '2015-10-16', 'INTEREST PAYMENT', '0.01', '0.11', NULL, '14', NULL, 1, '2015-10-21', 6, 0, 2, '2015-10-17 08:46:28', 1, '2015-11-14 05:21:49'),
(655, 'DEBIT', '2015-10-16', 'BARNESNOBLE 13712 Jamb Irvine CA     122366  10/16', '5.81', '125.86', NULL, '4', NULL, 1, '2015-10-21', 2, 0, 2, '2015-10-17 08:46:36', 1, '2015-11-14 05:21:49'),
(656, 'DEBIT', '2015-10-19', 'Equine Medical Associates', '125.66', '5087.08', NULL, '5', 'Equine Medical Associates', 1, '2015-10-21', 1, 0, 2, '2015-10-17 13:31:25', 1, '2015-11-14 05:21:49'),
(657, 'DEBIT', '2015-10-20', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '500.00', '3904.78', NULL, '10', 'Fidelity Investments', 1, '2015-10-21', 1, 0, 2, '2015-10-17 13:37:55', 1, '2015-11-14 05:21:49'),
(658, 'DEBIT', '2015-10-20', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '250.00', '3654.78', NULL, '10', 'Fidelity Investments', 1, '2015-10-21', 1, 0, 2, '2015-10-17 15:22:45', 1, '2015-11-14 05:21:49'),
(659, 'CREDIT', '2015-12-11', 'MLS Technologies - Panasomic', '2900.00', '6986.14', NULL, '13', 'MLS Technologies - Panasomic', 0, NULL, 1, 0, 2, '2015-10-17 15:30:14', 1, '2015-11-15 05:34:18'),
(660, 'CREDIT', '2016-01-08', 'MLS Technologies - Panasomic', '2100.00', '9086.14', NULL, '13', 'MLS Technologies - Panasomic', 0, NULL, 1, 0, 2, '2015-10-17 15:31:35', 1, '2015-11-15 05:34:18'),
(661, 'DEBIT', '2015-10-19', 'AMERINOC COM 877-805-6542 CA                 10/15', '9.95', '115.91', NULL, '9', NULL, 1, '2015-10-21', 2, 0, 2, '2015-10-24 20:39:10', 1, '2015-11-14 05:21:49'),
(662, 'DEBIT', '2015-10-19', 'Online Transfer to MMA ...0371 transaction#: 4946800755 10/19', '500.00', '4587.08', NULL, '17', 'To Savings', 1, '2015-10-21', 1, 0, 2, '2015-10-24 20:39:46', 1, '2015-11-14 05:21:49'),
(663, 'CREDIT', '2015-10-19', 'Online Transfer from CHK ...9657 transaction#: 4946800755', '500.00', '500.11', NULL, '17', 'From Premier', 1, '2015-10-21', 6, 0, 2, '2015-10-24 20:39:58', 1, '2015-11-14 05:21:49'),
(664, 'DEBIT', '2015-10-19', 'Online Transfer to CHK ...9570 transaction#: 4948925298 10/19', '100.00', '4487.08', NULL, '5', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-24 20:40:31', 1, '2015-11-14 05:21:49'),
(665, 'DEBIT', '2015-10-19', 'TRADER JOE''S # 197 TUSTIN CA         865646  10/17', '42.30', '4444.78', NULL, '6', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-24 20:40:39', 1, '2015-11-14 05:21:49'),
(666, 'DEBIT', '2015-10-20', 'THE UPS STORE #0026 LAKE FOREST CA   057058  10/20', '50.00', '65.91', NULL, '4', 'Live Scan for Citizenship', 1, '2015-10-21', 2, 0, 2, '2015-10-24 20:41:03', 1, '2015-11-14 05:21:49'),
(667, 'DEBIT', '2015-10-20', 'RALPHS 21751 LAKE FORE LAKE FOREST CA342697  10/20', '7.98', '3646.80', NULL, '6', NULL, 1, '2015-10-21', 1, 0, 2, '2015-10-24 20:42:26', 1, '2015-11-14 05:21:49'),
(668, 'CREDIT', '2015-10-21', 'TAX PRODUCTS PE3 SBTPG LLC                  PPD ID: 3722260102', '208.02', '3854.82', NULL, '14', 'Federal Tax Refund', 1, '2015-10-21', 1, 0, 2, '2015-10-24 20:42:51', 1, '2015-11-14 05:21:49'),
(669, 'DEBIT', '2015-10-22', 'COSTCO GAS #1001 TUSTIN CA           083292  10/22', '35.43', '3819.39', NULL, '3', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-24 20:42:58', 1, '2015-11-14 05:21:49'),
(670, 'DEBIT', '2015-10-22', 'Online Payment 4924453736 To SOUTHERN CALIFORNIA GAS 10/22', '18.07', '3801.32', NULL, '9', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-24 20:43:08', 1, '2015-11-14 05:21:49'),
(671, 'CHECK', '2015-10-28', 'Javier Franco - Groom', '600.00', '973.28', NULL, '5', 'Javier Franco - Groom', 0, '2015-11-04', 1, 1, 2, '2015-10-26 18:09:12', 2, '2015-11-12 21:58:43'),
(672, 'DEBIT', '2015-10-26', 'SQ *ORANGE COUNTY HO San Juan Capi CA        10/25', '150.00', '3651.32', NULL, '5', 'OCHSA Banquet', 1, '2015-11-04', 1, 0, 2, '2015-10-26 18:10:33', 1, '2015-11-14 05:21:49'),
(673, 'DEBIT', '2015-11-02', 'Embroidery - Jacket and back pack', '95.00', '5527.28', NULL, '5', 'Embroidery - Jacket and back pack', 0, '2015-11-04', 1, 1, 2, '2015-10-26 18:11:36', 2, '2015-11-12 21:58:43'),
(674, 'DEBIT', '2015-10-26', 'TRADER JOE''S # 197 TUSTIN CA                 10/24 Purchase $81.50 Cash Back $40.00', '121.50', '3529.82', NULL, NULL, '', 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:22:17', 1, '2015-11-14 05:21:49'),
(675, 'DEBIT', '2015-10-26', 'SQ *ALEXA CATERING San Juan Capi CA          10/25', '12.50', '3517.32', NULL, '4', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:22:24', 1, '2015-11-14 05:21:49'),
(676, 'DEBIT', '2015-10-26', 'SQ *DAMIAN CHIROPRA LAGUNA HILLS CA          10/23', '40.00', '3477.32', NULL, '2', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:22:36', 1, '2015-11-14 05:21:49'),
(677, 'DEBIT', '2015-10-26', 'THREADNEEDLE EMBROIDERY CARLSBAD CA          10/25', '98.00', '3379.32', NULL, '5', 'Jacket & Back Pack', 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:22:59', 1, '2015-11-14 05:21:49'),
(678, 'CHECK', '2015-10-27', 'CHECK 245 ', '600.00', '2779.32', '245', '5', 'Javier Franco - Groom', 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:23:21', 1, '2015-11-14 05:21:49'),
(679, 'DEBIT', '2015-10-27', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '89.88', '2689.44', NULL, '7', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:23:33', 1, '2015-11-14 05:21:49'),
(680, 'DEBIT', '2015-10-27', 'TARGET        00012385 IRVINE CA             10/26', '117.41', '2572.03', NULL, '4', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:23:42', 1, '2015-11-14 05:21:49'),
(681, 'DEBIT', '2015-10-27', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           10/26', '40.00', '2532.03', NULL, '2', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:23:52', 1, '2015-11-14 05:21:49'),
(682, 'DEBIT', '2015-10-29', 'MCC HOMEOWNERS GW 888-637-2176 CA            10/29', '125.00', '1540.28', NULL, '4', NULL, 1, '2015-11-04', 1, 0, 2, '2015-10-30 22:24:32', 1, '2015-11-14 05:21:49'),
(683, 'CREDIT', '2015-10-30', 'MLS Technologies', '4082.00', '5622.28', NULL, '13', 'MLS Technologies - Panasonic', 0, '2015-11-04', 1, 1, 2, '2015-10-30 23:58:58', 2, '2015-11-12 21:58:43'),
(684, 'DEBIT', '2015-11-02', 'Fidelity Investments', '250.00', '5372.28', NULL, '10', 'Fidelity Investments', 0, '2015-11-04', 1, 1, 2, '2015-10-31 15:13:40', 2, '2015-11-12 21:58:43'),
(685, 'DEBIT', '2015-11-02', 'Online Payment 4976005868 To William Van Der Reis MD Inc 11/02', '60.00', '5515.48', NULL, '2', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-01 18:24:47', 1, '2015-11-14 05:21:49'),
(686, 'DEBIT', '2015-11-03', 'MIGUELS JR 23 TUSTIN CA                      11/01', '16.17', '49.74', NULL, '4', NULL, 1, '2015-11-04', 2, 0, 2, '2015-11-05 18:20:30', 1, '2015-11-14 05:21:49'),
(687, 'DEBIT', '2015-11-03', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '250.00', '2079.89', NULL, '10', 'Fidelity Investments', 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:20:53', 1, '2015-11-14 05:21:49'),
(688, 'DEBIT', '2015-11-02', 'Online Transfer to CHK ...9570 transaction#: 4978600070 11/02', '109.00', '5406.48', NULL, '1', 'Driving Lesson', 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:21:09', 1, '2015-11-14 05:21:49'),
(689, 'DEBIT', '2015-11-02', 'STEIN MART 355 13742 J Irvine CA     530788  11/01', '188.96', '5217.52', NULL, '4', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:21:17', 1, '2015-11-14 05:21:49'),
(690, 'DEBIT', '2015-11-02', 'Online Transfer to MMA ...0371 transaction#: 4974068458 11/02', '500.00', '4717.52', NULL, '17', 'To Savings', 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:21:31', 1, '2015-11-14 05:21:49'),
(691, 'CREDIT', '2015-11-02', 'Online Transfer from CHK ...9657 transaction#: 4974068458', '500.00', '1000.11', NULL, '17', 'From Premier', 1, '2015-11-04', 6, 0, 2, '2015-11-05 18:21:44', 1, '2015-11-14 05:21:49'),
(692, 'DEBIT', '2015-11-02', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           10/30', '40.00', '4677.52', NULL, '2', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:21:56', 1, '2015-11-14 05:21:49'),
(693, 'DEBIT', '2015-11-02', 'PICK UP STIX 765 TUSTIN TUSTIN CA            10/29', '27.27', '4650.25', NULL, '4', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:22:16', 1, '2015-11-14 05:21:49'),
(694, 'DEBIT', '2015-11-02', 'Anacapa Apartmen WEB PMTS   KY67J2          WEB ID: 1203874681', '2287.21', '2363.04', NULL, NULL, '', 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:22:26', 1, '2015-11-14 05:21:49'),
(695, 'DEBIT', '2015-11-02', 'COSTCO GAS #0454 IRVINE CA           098401  10/31', '33.15', '2329.89', NULL, '3', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:22:33', 1, '2015-11-14 05:21:49'),
(696, 'CREDIT', '2015-10-30', 'MLS TECHNOLOGIES DIRDEP                     PPD ID: 1330914630', '4082.02', '5622.30', NULL, '13', 'Panasonic', 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:22:51', 1, '2015-11-14 05:21:49'),
(697, 'DEBIT', '2015-10-30', 'TRADER JOE''S # 210 IRVINE CA         154108  10/30', '46.82', '5575.48', NULL, '6', NULL, 1, '2015-11-04', 1, 0, 2, '2015-11-05 18:22:59', 1, '2015-11-14 05:21:49'),
(698, 'DEBIT', '2015-11-06', '#06526 ALBERTSONS LAKE FOREST CA     232131  11/06', '8.36', '41.38', NULL, '6', NULL, 1, NULL, 2, 0, 2, '2015-11-07 17:34:17', 1, '2015-11-14 05:21:49'),
(699, 'DEBIT', '2015-11-06', 'WHICH WICH #354 TUSTIN CA                    11/05', '9.99', '1389.90', NULL, '4', NULL, 1, NULL, 1, 0, 2, '2015-11-07 17:36:37', 1, '2015-11-14 05:21:49'),
(700, 'DEBIT', '2015-11-06', 'Online Payment 4975824707 To Cox Communications 11/06', '194.61', '1195.29', NULL, '9', NULL, 1, NULL, 1, 0, 2, '2015-11-07 17:36:46', 1, '2015-11-14 05:21:49'),
(701, 'DEBIT', '2015-11-06', 'Online Transfer to CHK ...9570 transaction#: 4989069217 11/06', '10.00', '1185.29', NULL, '1', NULL, 1, NULL, 1, 0, 2, '2015-11-07 17:36:54', 1, '2015-11-14 05:21:49'),
(702, 'DEBIT', '2015-11-06', 'WHICH WICH #354 TUSTIN CA                    11/05', '2.11', '1183.18', NULL, '4', NULL, 1, NULL, 1, 0, 2, '2015-11-07 17:37:07', 1, '2015-11-14 05:21:49'),
(703, 'DEBIT', '2015-11-06', 'TRADER JOE''S # 197 TUSTIN CA         057208  11/06', '98.25', '1084.93', NULL, '6', NULL, 1, NULL, 1, 0, 2, '2015-11-07 17:37:18', 1, '2015-11-14 05:21:49'),
(704, 'DEBIT', '2015-11-09', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           11/06', '80.00', '1004.93', NULL, '2', NULL, 1, NULL, 1, 0, 2, '2015-11-08 19:36:29', 1, '2015-11-14 05:21:49'),
(705, 'DEBIT', '2015-11-09', 'APL* ITUNES.COM/BILL 866-712-7753 CA         11/08', '0.99', '1003.94', NULL, '9', NULL, 1, NULL, 1, 0, 1, '2015-11-12 19:09:36', 1, '2015-11-15 05:24:35'),
(706, 'DEBIT', '2015-11-09', 'COSTCO GAS #0454 IRVINE CA           003753  11/08', '24.65', '979.29', NULL, '3', NULL, 1, NULL, 1, 0, 1, '2015-11-12 19:09:45', 1, '2015-11-15 05:24:35'),
(707, 'DEBIT', '2015-11-09', 'REDHILL CARWASH TUSTIN CA                    11/07', '20.99', '20.39', NULL, '7', '', 1, NULL, 2, 0, 1, '2015-11-12 19:09:55', 1, '2015-11-15 05:24:35'),
(708, 'DEBIT', '2015-11-09', 'TARGET T-1238 Irvine CA              000801  11/08', '7.48', '12.91', NULL, '4', NULL, 1, NULL, 2, 0, 1, '2015-11-12 19:10:15', 1, '2015-11-15 05:24:35'),
(709, 'DEBIT', '2015-11-09', 'JPMorgan Chase   Ext Trnsfr 4923689806      WEB ID: 9200502231', '333.33', '645.96', NULL, '15', NULL, 1, NULL, 1, 0, 1, '2015-11-12 19:10:25', 1, '2015-11-15 05:24:35'),
(710, 'DEBIT', '2015-11-10', 'Online Payment 4975845782 To VERIZON WIRELESS 11/10', '69.66', '576.30', NULL, '9', NULL, 1, NULL, 1, 0, 1, '2015-11-12 19:10:33', 1, '2015-11-15 05:24:35'),
(711, 'DEBIT', '2015-11-12', 'NETFLIX.COM NETFLIX.COM CA                   11/12', '7.99', '4.92', NULL, '9', NULL, 1, NULL, 2, 0, 1, '2015-11-13 21:15:59', 1, '2015-11-15 05:24:35'),
(712, 'DEBIT', '2015-11-12', 'BARNESNOBLE 81 Fortune Irvine CA     823787  11/11', '27.22', '549.08', NULL, '4', NULL, 1, NULL, 1, 0, 1, '2015-11-13 21:16:06', 1, '2015-11-15 05:24:35'),
(713, 'DEBIT', '2015-11-12', 'Amazon.com AMZN.COM/BILL WA                  11/10', '35.63', '513.45', NULL, '4', NULL, 1, NULL, 1, 0, 1, '2015-11-13 21:16:14', 1, '2015-11-15 05:34:07'),
(714, 'DEBIT', '2015-11-12', 'Online Payment 4964755141 To SOUTHERN CALIFORNIA EDISON 11/12', '38.19', '475.26', NULL, '9', NULL, 1, NULL, 1, 0, 1, '2015-11-13 21:16:20', 1, '2015-11-15 05:34:07'),
(715, 'DEBIT', '2015-11-12', 'SPROUTS FARMERS MKT#25 TUSTIN CA     024608  11/12', '28.33', '446.93', NULL, '6', NULL, 1, NULL, 1, 0, 1, '2015-11-13 21:16:27', 1, '2015-11-15 05:34:07'),
(716, 'CREDIT', '2015-11-12', 'Online Transfer from CHK ...9657 transaction#: 4999462858', '100.00', '104.92', NULL, '17', 'From Premier', 1, NULL, 2, 0, 1, '2015-11-13 21:16:46', 1, '2015-11-15 05:24:35'),
(717, 'DEBIT', '2015-11-12', 'Online Transfer to CHK ...2339 transaction#: 4999462858 11/12', '100.00', '346.93', NULL, '17', 'To Business', 1, NULL, 1, 0, 1, '2015-11-13 21:16:59', 1, '2015-11-15 05:34:07'),
(718, 'CREDIT', '2015-11-13', 'MLS Technologies - Panasonic', '4082.02', '4428.95', NULL, '13', 'MLS Technologies - Panasonic', 0, NULL, 1, 0, 1, '2015-11-13 21:18:07', 1, '2015-11-15 05:34:07'),
(719, 'DEBIT', '2015-11-13', 'Child Support', '192.31', '4236.64', NULL, '18', 'Child Support', 0, NULL, 1, 0, 1, '2015-11-13 21:18:47', 1, '2015-11-15 05:34:18'),
(720, 'DEBIT', '2015-11-16', 'Child Support', '312.50', '3884.14', NULL, '18', 'Child Support', 0, NULL, 1, 0, 1, '2015-11-14 19:28:14', 1, '2015-11-15 05:34:18'),
(721, 'DEBIT', '2015-11-13', 'Dr Neal Damian', '40.00', '4196.64', NULL, '2', 'Dr Neal Damian', 0, NULL, 1, 0, 1, '2015-11-14 21:34:06', 1, '2015-11-15 05:34:18');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_split`
--

CREATE TABLE `transaction_split` (
  `id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_id` int(11) UNSIGNED NOT NULL,
  `type` enum('DEBIT','CREDIT','CHECK','DSLIP') NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `notes` varchar(150) DEFAULT NULL,
  `assign` varchar(50) NOT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction_split`
--

INSERT INTO `transaction_split` (`id`, `amount`, `transaction_id`, `type`, `category_id`, `notes`, `assign`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, '100.00', 386, 'DSLIP', 2, 'Ins. For OC Scan', '', 0, 2, '2015-06-25 12:54:58', 2, '2015-10-17 21:31:59'),
(2, '300.00', 386, 'DSLIP', 2, 'For Nick & Tash Medical Ins.', '', 0, 2, '2015-06-25 12:54:58', 2, '2015-10-17 21:31:59'),
(3, '260.00', 386, 'DSLIP', 13, 'From Eppicard', '', 0, 2, '2015-06-25 12:54:59', 2, '2015-10-17 21:31:59'),
(4, '999.00', 387, 'CREDIT', 14, '', '', 1, 2, '2015-06-25 13:12:30', 2, '2015-07-03 20:44:04'),
(5, '112.00', 387, 'CREDIT', 2, '', '', 1, 2, '2015-06-25 13:12:31', 2, '2015-07-03 20:44:10'),
(6, '123.00', 388, 'DSLIP', 14, 'aaaa', '', 1, 2, '2015-06-25 13:25:04', 2, '2015-07-03 20:44:37'),
(7, '99.00', 388, 'DSLIP', 2, 'bbbbb', '', 1, 2, '2015-06-25 13:25:05', 2, '2015-07-03 20:44:41'),
(8, '1000.00', 373, 'DEBIT', 10, '', '', 0, 2, '2015-07-01 12:37:56', 2, '2015-07-03 20:45:45'),
(9, '5000.00', 373, 'CREDIT', 13, 'SpectromTech', '', 0, 2, '2015-07-01 12:37:57', 2, '2015-07-03 20:45:49'),
(10, '45.00', 407, 'DEBIT', 2, 'Medications', '', 0, 2, '2015-07-09 11:19:13', 2, '2015-07-09 18:19:39'),
(11, '40.00', 407, 'DEBIT', 4, 'Cash', '', 0, 2, '2015-07-09 11:19:14', 2, '2015-07-09 18:19:40'),
(12, '3.29', 407, 'DEBIT', 4, '', '', 0, 2, '2015-07-09 11:19:14', 2, '2015-07-09 18:19:40'),
(13, '2245.00', 539, 'DEBIT', 16, '', '', 0, 2, '2015-09-03 09:47:42', 2, '2015-09-03 16:47:42'),
(14, '46.54', 539, 'DEBIT', 9, 'ConServe', '', 0, 2, '2015-09-03 09:47:43', 2, '2015-09-03 16:49:46'),
(15, '2245.00', 612, 'DEBIT', 16, 'Anacapa', '', 0, 2, '2015-10-03 10:39:40', 2, '2015-10-03 17:39:40'),
(16, '46.10', 612, 'DEBIT', 9, 'ConServe', '', 0, 2, '2015-10-03 10:39:40', 2, '2015-10-03 17:39:40'),
(17, '45.00', 617, 'DEBIT', 2, 'Prescriptions', '', 0, 2, '2015-10-04 10:13:26', 2, '2015-10-04 17:13:26'),
(18, '8.72', 617, 'DEBIT', 6, '', '', 0, 2, '2015-10-04 10:13:26', 2, '2015-10-04 17:13:26'),
(19, '81.50', 674, 'DEBIT', 6, '', '', 0, 2, '2015-11-05 18:56:52', 2, '2015-11-06 02:56:52'),
(20, '40.00', 674, 'DEBIT', 4, '', '', 0, 2, '2015-11-05 18:56:52', 2, '2015-11-06 02:56:52'),
(21, '2245.00', 694, 'DEBIT', 16, '', '', 0, 2, '2015-11-07 20:03:03', 2, '2015-11-08 04:03:03'),
(22, '42.21', 694, 'DEBIT', 9, 'ConServe', '', 0, 2, '2015-11-07 20:03:04', 2, '2015-11-08 04:03:04');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_upload`
--

CREATE TABLE `transaction_upload` (
  `id` int(11) NOT NULL,
  `upload_datetime` datetime NOT NULL,
  `bank_account_id` int(11) UNSIGNED NOT NULL,
  `type` enum('DEBIT','CREDIT','CHECK','DSLIP') NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(200) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `check_num` varchar(50) DEFAULT NULL,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction_upload`
--

INSERT INTO `transaction_upload` (`id`, `upload_datetime`, `bank_account_id`, `type`, `transaction_date`, `description`, `amount`, `check_num`, `status`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, '2015-05-14 09:20:08', 2, 'DEBIT', '2015-05-12', 'NETFLIX.COM NETFLIX.COM CA                   05/12', '7.99', NULL, 1, 0, 2, '2015-05-14 09:20:08', 2, '2015-05-14 16:20:55'),
(2, '2015-05-14 09:20:08', 2, 'DEBIT', '2015-05-11', 'EDWARDS WESTPARK 8 IRVINE CA                 05/09', '9.00', NULL, 1, 0, 2, '2015-05-14 09:20:09', 2, '2015-05-14 16:21:07'),
(3, '2015-05-14 09:20:08', 2, 'DEBIT', '2015-05-08', 'JAMBA JUICE 2 TUSTIN CA                      05/07', '5.89', NULL, 1, 0, 2, '2015-05-14 09:20:09', 2, '2015-05-14 16:21:15'),
(4, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-13', 'ENTERPRISE RENT-A-CAR TUSTIN CA              05/12', '100.00', NULL, 1, 0, 2, '2015-05-14 09:25:28', 2, '2015-05-14 16:26:27'),
(5, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-13', 'TCA FASTRAK R 949-727-4800 CA                05/13', '5.68', NULL, 1, 0, 2, '2015-05-14 09:25:28', 2, '2015-05-14 16:26:35'),
(6, '2015-05-14 09:25:28', 1, 'DSLIP', '2015-05-08', 'DEPOSIT  ID NUMBER  99564', '130.00', NULL, 1, 0, 2, '2015-05-14 09:25:28', 2, '2015-05-14 16:27:05'),
(7, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-08', 'Online Transfer to CHK ...9570 transaction#: 4619687503 05/08', '10.00', NULL, 1, 0, 2, '2015-05-14 09:25:28', 2, '2015-05-14 16:27:15'),
(8, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-07', 'Online Payment 4616320321 To SOUTHERN CALIFORNIA GAS 05/07', '44.81', NULL, 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-14 16:27:26'),
(9, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-07', 'JPMorgan Chase   Ext Trnsfr 4548284659      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-14 16:27:43'),
(10, '2015-05-14 09:25:28', 1, 'CHECK', '2015-05-06', 'CHECK 223 ', '440.00', '223', 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-14 16:28:03'),
(11, '2015-05-14 09:25:28', 1, 'DSLIP', '2015-05-05', 'DEPOSIT  ID NUMBER 680596', '3000.00', NULL, 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-14 16:39:05'),
(12, '2015-05-14 09:25:28', 1, 'CREDIT', '2015-05-05', 'Online Transfer from CHK ...9570 transaction#: 4612476741', '440.00', NULL, 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-14 16:39:34'),
(13, '2015-05-14 09:25:28', 1, 'CREDIT', '2015-05-04', 'Online Transfer from CHK ...9570 transaction#: 4610357477', '300.00', NULL, 1, 0, 2, '2015-05-14 09:25:29', 2, '2015-05-15 18:14:44'),
(14, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-04', 'TCA FASTRAK R 949-727-4800 CA                05/02', '5.93', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:16:42'),
(15, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-05-04', 'Anacapa Apartmen WEB PMTS   CY7B72          WEB ID: 1203874681', '2245.00', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:16:53'),
(16, '2015-05-14 09:25:28', 1, 'CHECK', '2015-04-30', 'CHECK 219 ', '100.00', '219', 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:17:14'),
(17, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-29', 'Online Payment 4596323597 To VERIZON WIRELESS 04/29', '70.20', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:17:21'),
(18, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-29', 'Online Payment 4596323593 To SOUTHERN CALIFORNIA EDISON 04/29', '19.58', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:17:27'),
(19, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-28', 'TARGET T1 TARGET T1238 IRVINE CA             04/28', '45.00', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:17:48'),
(20, '2015-05-14 09:25:28', 1, 'DSLIP', '2015-04-27', 'REMOTE ONLINE DEPOSIT #          1', '108.53', '1', 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:31:28'),
(21, '2015-05-14 09:25:28', 1, 'CREDIT', '2015-04-27', 'Online Transfer from CHK ...9570 transaction#: 4592910825', '64.85', NULL, 1, 0, 2, '2015-05-14 09:25:30', 2, '2015-05-15 18:26:52'),
(22, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-27', 'APL* ITUNES.COM/BILL 866-712-7753 CA         04/24', '0.99', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:03'),
(23, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-27', 'PICK UP STIX 765 TUSTIN TUSTIN CA            04/24', '29.44', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:10'),
(24, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-27', 'Online Payment 4592926943 To Cox Communications 04/27', '175.83', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:17'),
(25, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-27', 'Online Payment 4592937729 To NWP SERVICES CORPORATION 04/27', '50.21', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:23'),
(26, '2015-05-14 09:25:28', 1, 'CHECK', '2015-04-27', 'CHECK 221 ', '2500.00', '221', 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:25:56'),
(27, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-27', 'MERCURY CASUALTY PAYMENT    040109170054530 WEB ID: 1952577343', '86.88', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:18:25'),
(28, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-24', 'SUPERCUTS HB HUNTINGTON BE CA                04/22', '15.50', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:29'),
(29, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-23', 'STARBUCKS #05807 HUN Huntington Be CA        04/22', '7.50', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:36'),
(30, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-23', 'STARBUCKS #05807 HUN Huntington Be CA        04/22', '6.65', NULL, 1, 0, 2, '2015-05-14 09:25:31', 2, '2015-05-15 18:27:44'),
(31, '2015-05-14 09:25:28', 1, 'CREDIT', '2015-04-22', 'ATM CHECK DEPOSIT 04/22 7830 EDINGER AVE HUNTINGTON BE CA', '300.00', NULL, 1, 0, 2, '2015-05-14 09:25:32', 2, '2015-05-15 18:28:50'),
(32, '2015-05-14 09:25:28', 1, 'CHECK', '2015-04-22', 'CHECK 220 ', '200.00', '220', 1, 0, 2, '2015-05-14 09:25:32', 2, '2015-05-15 18:30:37'),
(33, '2015-05-14 09:25:28', 1, 'DEBIT', '2015-04-21', 'APPLEBEES VICT15215262 VICTORVILLE CA        04/20', '38.15', NULL, 1, 0, 2, '2015-05-14 09:25:32', 2, '2015-05-15 18:29:26'),
(34, '2015-05-19 08:27:45', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638600591', '25.36', NULL, 1, 0, 2, '2015-05-19 08:27:45', 2, '2015-05-19 15:29:46'),
(35, '2015-05-19 08:27:45', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638601748', '24.76', NULL, 1, 0, 2, '2015-05-19 08:27:45', 2, '2015-05-19 15:29:14'),
(36, '2015-05-19 08:27:45', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637795722', '21.57', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:30:32'),
(37, '2015-05-19 08:27:45', 2, 'DEBIT', '2015-05-18', 'AMERINOC COM 877-805-6542 CA                 05/15', '9.95', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:28:19'),
(38, '2015-05-19 08:27:45', 2, 'DEBIT', '2015-05-18', 'DOMINO''S 7893 TUSTIN CA                      05/16', '23.57', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:30:09'),
(39, '2015-05-19 08:27:45', 2, 'DEBIT', '2015-05-18', 'OFFICE MAX/OFFI 13728 IRVINE CA      205682  05/18', '25.36', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:29:30'),
(40, '2015-05-19 08:27:45', 2, 'DEBIT', '2015-05-18', 'MICHAELS STORES INC772 TUSTIN CA     321479  05/18', '24.76', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:28:58'),
(41, '2015-05-19 08:27:45', 2, 'CREDIT', '2015-05-14', 'Online Transfer from CHK ...9657 transaction#: 4629258861', '50.00', NULL, 1, 0, 2, '2015-05-19 08:27:46', 2, '2015-05-19 15:30:40'),
(42, '2015-05-19 08:31:22', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637791736', '1000.00', NULL, 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:32:07'),
(43, '2015-05-19 08:31:22', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638603880', '300.00', NULL, 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:32:26'),
(44, '2015-05-19 08:31:22', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637788465', '64.49', NULL, 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:32:45'),
(45, '2015-05-19 08:31:22', 1, 'CHECK', '2015-05-18', 'CHECK 228 ', '655.15', '228', 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:33:11'),
(46, '2015-05-19 08:31:22', 1, 'CHECK', '2015-05-18', 'CHECK 227 ', '300.00', '227', 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:33:31'),
(47, '2015-05-19 08:31:22', 1, 'CHECK', '2015-05-15', 'CHECK 225 ', '140.00', '225', 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:33:54'),
(48, '2015-05-19 08:31:22', 1, 'CREDIT', '2015-05-15', 'INTEREST PAYMENT', '0.04', NULL, 1, 0, 2, '2015-05-19 08:31:22', 2, '2015-05-19 15:33:59'),
(49, '2015-05-19 08:31:22', 1, 'CREDIT', '2015-05-14', 'Online Transfer from CHK ...9570 transaction#: 4629258246', '30.00', NULL, 1, 0, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:34:07'),
(50, '2015-05-19 08:31:22', 1, 'DEBIT', '2015-05-14', 'TCA FASTRAK R 949-727-4800 CA                05/14', '5.78', NULL, 1, 0, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:34:14'),
(51, '2015-05-19 08:31:22', 1, 'DEBIT', '2015-05-14', 'Online Transfer to CHK ...2339 transaction#: 4629258861 05/14', '50.00', NULL, 1, 0, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:34:23'),
(52, '2015-05-19 08:31:22', 1, 'CHECK', '2015-05-14', 'CHECK 224 ', '872.73', '224', 1, 0, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:35:07'),
(53, '2015-05-19 08:31:22', 1, 'DEBIT', '2015-05-13', 'ENTERPRISE RENT-A-CAR TUSTIN CA              05/12', '100.00', NULL, 0, 1, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:35:28'),
(54, '2015-05-19 08:31:22', 1, 'DEBIT', '2015-05-13', 'TCA FASTRAK R 949-727-4800 CA                05/13', '5.68', NULL, 0, 1, 2, '2015-05-19 08:31:23', 2, '2015-05-19 15:35:33'),
(55, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-20', 'STATE OF CA DEPT OF D 916-464-5000 CA        05/19', '313.48', NULL, 1, 0, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:35:35'),
(56, '2015-05-23 17:02:55', 2, 'CREDIT', '2015-05-19', 'Online Transfer from CHK ...9657 transaction#: 4639594782', '313.48', NULL, 1, 0, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:03:55'),
(57, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-19', 'ANSAR GALLERY TUSTIN CA                      05/18', '5.37', NULL, 1, 0, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:04:04'),
(58, '2015-05-23 17:02:55', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638600591', '25.36', NULL, 0, 1, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:04:19'),
(59, '2015-05-23 17:02:55', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638601748', '24.76', NULL, 0, 1, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:04:23'),
(60, '2015-05-23 17:02:55', 2, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637795722', '21.57', NULL, 0, 1, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:04:31'),
(61, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-18', 'AMERINOC COM 877-805-6542 CA                 05/15', '9.95', NULL, 0, 1, 2, '2015-05-23 17:02:55', 2, '2015-05-24 00:04:39'),
(62, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-18', 'DOMINO''S 7893 TUSTIN CA                      05/16', '23.57', NULL, 0, 1, 2, '2015-05-23 17:02:56', 2, '2015-05-24 00:04:43'),
(63, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-18', 'OFFICE MAX/OFFI 13728 IRVINE CA      205682  05/18', '25.36', NULL, 0, 1, 2, '2015-05-23 17:02:56', 2, '2015-05-24 00:04:46'),
(64, '2015-05-23 17:02:55', 2, 'DEBIT', '2015-05-18', 'MICHAELS STORES INC772 TUSTIN CA     321479  05/18', '24.76', NULL, 0, 1, 2, '2015-05-23 17:02:56', 2, '2015-05-24 00:04:49'),
(65, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-22', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:06:36'),
(66, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643876773', '185.00', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:08:26'),
(67, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643875927', '50.00', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:09:50'),
(68, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-21', 'Online Transfer from CHK ...9570 transaction#: 4643878956', '10.68', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:10:58'),
(69, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-20', 'ENTERPRISE RENT-A-CAR TUSTIN CA              05/19', '100.00', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:15:17'),
(70, '2015-05-23 17:06:06', 1, 'DEBIT', '2015-05-20', 'BAJA FRESH 10063 IRVINE CA                   05/18', '7.05', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:15:24'),
(71, '2015-05-23 17:06:06', 1, 'CHECK', '2015-05-20', 'CHECK 209 ', '50.00', '209', 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:15:51'),
(72, '2015-05-23 17:06:06', 1, 'DEBIT', '2015-05-19', 'Online Transfer to CHK ...2339 transaction#: 4639594782 05/19', '313.48', NULL, 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:16:29'),
(73, '2015-05-23 17:06:06', 1, 'CHECK', '2015-05-19', 'CHECK 222 ', '830.15', '222', 1, 0, 2, '2015-05-23 17:06:06', 2, '2015-05-24 00:17:00'),
(74, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637791736', '1000.00', NULL, 0, 1, 2, '2015-05-23 17:06:07', 2, '2015-05-24 00:17:15'),
(75, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4638603880', '300.00', NULL, 0, 1, 2, '2015-05-23 17:06:07', 2, '2015-05-24 00:17:25'),
(76, '2015-05-23 17:06:06', 1, 'CREDIT', '2015-05-18', 'Online Transfer from CHK ...9570 transaction#: 4637788465', '64.49', NULL, 0, 1, 2, '2015-05-23 17:06:07', 2, '2015-05-24 00:17:28'),
(77, '2015-05-23 17:06:06', 1, 'CHECK', '2015-05-18', 'CHECK 228 ', '655.15', '228', 0, 1, 2, '2015-05-23 17:06:07', 2, '2015-05-24 00:17:37'),
(78, '2015-05-23 17:06:06', 1, 'CHECK', '2015-05-18', 'CHECK 227 ', '300.00', '227', 0, 1, 2, '2015-05-23 17:06:07', 2, '2015-05-25 17:00:25'),
(79, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-29', 'Online Transfer to CHK ...9570 transaction#: 4659770569 05/29', '20.00', NULL, 1, 0, 2, '2015-05-31 08:59:01', 2, '2015-05-31 16:03:03'),
(80, '2015-05-31 08:59:01', 1, 'DSLIP', '2015-05-28', 'REMOTE ONLINE DEPOSIT #          1', '450.00', '1', 1, 0, 2, '2015-05-31 08:59:01', 2, '2015-05-31 16:02:56'),
(81, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-28', 'HITCHN POST FEED AND TA ORANGE CA            05/26', '35.58', NULL, 1, 0, 2, '2015-05-31 08:59:01', 2, '2015-05-31 16:01:51'),
(82, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-28', 'TCA FASTRAK R 949-727-4800 CA                05/28', '30.00', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:02:36'),
(83, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-28', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:02:28'),
(84, '2015-05-31 08:59:01', 1, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654231215', '650.00', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:02:18'),
(85, '2015-05-31 08:59:01', 1, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654232530', '35.58', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:01:44'),
(86, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-27', 'EQUESTRIAN SERVICES II COSTA MESA CA         05/26', '650.00', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:01:17'),
(87, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-27', 'TCA FASTRAK R 949-727-4800 CA                05/27', '3.26', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:00:58'),
(88, '2015-05-31 08:59:01', 1, 'DEBIT', '2015-05-26', 'APL* ITUNES.COM/BILL 866-712-7753 CA         05/24', '0.99', NULL, 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:00:37'),
(89, '2015-05-31 08:59:01', 1, 'CHECK', '2015-05-26', 'CHECK 230 ', '185.00', '230', 1, 0, 2, '2015-05-31 08:59:02', 2, '2015-05-31 16:00:24'),
(90, '2015-05-31 08:59:01', 1, 'CREDIT', '2015-05-22', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', NULL, 0, 1, 2, '2015-05-31 08:59:02', 2, '2015-05-31 15:59:23'),
(91, '2015-05-31 09:06:50', 2, 'DEBIT', '2015-05-28', 'STARBUCKS #22637 COSTA Costa Mesa CA         05/27', '3.95', NULL, 0, 1, 2, '2015-05-31 09:06:50', 2, '2015-06-01 15:53:41'),
(92, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-29', 'Online Transfer to CHK ...9570 transaction#: 4659770569 05/29', '20.00', NULL, 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:10'),
(93, '2015-06-01 08:19:19', 2, 'DSLIP', '2015-05-28', 'REMOTE ONLINE DEPOSIT #          1', '450.00', '1', 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:12'),
(94, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-28', 'HITCHN POST FEED AND TA ORANGE CA            05/26', '35.58', NULL, 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:15'),
(95, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-28', 'TCA FASTRAK R 949-727-4800 CA                05/28', '30.00', NULL, 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:17'),
(96, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-28', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:20'),
(97, '2015-06-01 08:19:19', 2, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654231215', '650.00', NULL, 0, 1, 2, '2015-06-01 08:19:19', 2, '2015-06-01 15:43:27'),
(98, '2015-06-01 08:19:19', 2, 'CREDIT', '2015-05-27', 'Online Transfer from CHK ...9570 transaction#: 4654232530', '35.58', NULL, 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:43:29'),
(99, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-27', 'EQUESTRIAN SERVICES II COSTA MESA CA         05/26', '650.00', NULL, 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:43:32'),
(100, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-27', 'TCA FASTRAK R 949-727-4800 CA                05/27', '3.26', NULL, 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:43:34'),
(101, '2015-06-01 08:19:19', 2, 'DEBIT', '2015-05-26', 'APL* ITUNES.COM/BILL 866-712-7753 CA         05/24', '0.99', NULL, 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:43:37'),
(102, '2015-06-01 08:19:19', 2, 'CHECK', '2015-05-26', 'CHECK 230 ', '185.00', '230', 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:43:41'),
(103, '2015-06-01 08:19:19', 2, 'CREDIT', '2015-05-22', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', NULL, 0, 1, 2, '2015-06-01 08:19:20', 2, '2015-06-01 15:45:04'),
(104, '2015-06-08 06:51:24', 2, 'DEBIT', '2015-06-04', 'AMPCO PARKING 2600MICHE IRVINE CA            06/02', '6.00', NULL, 1, 0, 2, '2015-06-08 06:51:24', 2, '2015-06-08 13:52:06'),
(105, '2015-06-08 06:51:24', 2, 'DEBIT', '2015-06-03', 'POSTAL ANNEX 56 TUSTIN CA                    06/01', '20.00', NULL, 1, 0, 2, '2015-06-08 06:51:24', 2, '2015-06-08 13:51:55'),
(106, '2015-06-08 06:54:06', 1, 'CREDIT', '2015-06-05', 'Online Transfer from CHK ...9570 transaction#: 4675864534', '490.00', NULL, 1, 0, 2, '2015-06-08 06:54:06', 2, '2015-06-08 13:56:05'),
(107, '2015-06-08 06:54:06', 1, 'DEBIT', '2015-06-05', 'G BURGER IRVINE CA                           06/04', '24.84', NULL, 1, 0, 2, '2015-06-08 06:54:06', 2, '2015-06-08 13:56:13'),
(108, '2015-06-08 06:54:06', 1, 'DEBIT', '2015-06-04', 'JAEGERHAUS GERMAN RESTA ANAHEIM CA           06/03', '61.14', NULL, 1, 0, 2, '2015-06-08 06:54:06', 2, '2015-06-08 13:55:45'),
(109, '2015-06-08 06:54:06', 1, 'DEBIT', '2015-06-04', 'Anacapa Apartmen WEB PMTS   2SKY82          WEB ID: 1203874681', '2245.00', NULL, 1, 0, 2, '2015-06-08 06:54:06', 2, '2015-06-08 13:55:37'),
(110, '2015-06-08 06:54:06', 1, 'CREDIT', '2015-06-03', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '1000.00', NULL, 1, 0, 2, '2015-06-08 06:54:06', 2, '2015-06-08 13:55:23'),
(111, '2015-06-08 06:54:06', 1, 'CREDIT', '2015-06-02', 'Online Transfer from CHK ...9570 transaction#: 4668247731', '56.34', NULL, 1, 0, 2, '2015-06-08 06:54:07', 2, '2015-06-08 13:55:09'),
(112, '2015-06-08 06:54:06', 1, 'DEBIT', '2015-06-02', 'BARNESNOBLE 13712 Jamb Irvine CA     235048  06/02', '36.91', NULL, 1, 0, 2, '2015-06-08 06:54:07', 2, '2015-06-08 13:54:49'),
(113, '2015-06-08 06:54:06', 1, 'DEBIT', '2015-06-02', 'BARNESNOBLE 13712 Jamb Irvine CA     731785  06/02', '19.43', NULL, 1, 0, 2, '2015-06-08 06:54:07', 2, '2015-06-08 13:54:37'),
(114, '2015-06-11 21:18:17', 1, 'DSLIP', '2015-06-10', 'REMOTE ONLINE DEPOSIT #          1', '122.50', '1', 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:19:50'),
(115, '2015-06-11 21:18:17', 1, 'DEBIT', '2015-06-10', 'TARGET T1 TARGET T1238 IRVINE CA             06/10', '25.00', NULL, 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:19:34'),
(116, '2015-06-11 21:18:17', 1, 'DEBIT', '2015-06-09', 'JPMorgan Chase   Ext Trnsfr 4613408975      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:19:28'),
(117, '2015-06-11 21:18:17', 1, 'DEBIT', '2015-06-08', 'STARBUCKS #22637 COSTA Costa Mesa CA         06/06', '3.95', NULL, 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:18:45'),
(118, '2015-06-11 21:18:17', 1, 'DEBIT', '2015-06-08', 'TARGET T1 TARGET T1238 IRVINE CA             06/08', '45.76', NULL, 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:18:37'),
(119, '2015-06-11 21:18:17', 1, 'CHECK', '2015-06-08', 'CHECK 232 ', '490.00', '232', 1, 0, 2, '2015-06-11 21:18:17', 2, '2015-06-12 04:19:21'),
(120, '2015-06-13 05:54:21', 1, 'DSLIP', '2015-06-12', 'DEPOSIT  ID NUMBER 578381', '2500.00', NULL, 1, 0, 2, '2015-06-13 05:54:21', 2, '2015-06-13 12:54:34'),
(121, '2015-06-13 05:54:21', 1, 'DEBIT', '2015-06-12', 'TARGET T1 TARGET T1238 IRVINE CA             06/12', '28.04', NULL, 1, 0, 2, '2015-06-13 05:54:22', 2, '2015-06-13 12:54:46'),
(122, '2015-06-13 05:54:21', 1, 'DEBIT', '2015-06-11', 'STARBUCKS #14005 COSTA Costa Mesa CA         06/10', '10.10', NULL, 1, 0, 2, '2015-06-13 05:54:22', 2, '2015-06-13 12:55:11'),
(123, '2015-06-13 05:54:21', 1, 'DEBIT', '2015-06-11', 'COSTCO GAS #1110 HUNTINGTON B CA     008112  06/11', '34.50', NULL, 1, 0, 2, '2015-06-13 05:54:22', 2, '2015-06-13 12:55:01'),
(124, '2015-06-13 05:54:21', 1, 'DEBIT', '2015-06-11', 'FRY''S ELECTRONICS    FOUNTAIN VLY CA 002295  06/11', '186.18', NULL, 1, 0, 2, '2015-06-13 05:54:22', 2, '2015-06-13 12:54:54'),
(125, '2015-06-13 05:54:21', 1, 'DEBIT', '2015-06-11', 'CIRCLE K 03037 111 DEL COSTA MESA CA         06/11', '12.45', NULL, 1, 0, 2, '2015-06-13 05:54:22', 2, '2015-06-13 12:55:18'),
(126, '2015-06-13 18:16:36', 2, 'DEBIT', '2015-06-12', 'FRY''S ELECTRONICS #7 FOUNTAIN VALL CA        06/11', '7.55', NULL, 1, 0, 2, '2015-06-13 18:16:36', 2, '2015-06-14 01:16:56'),
(127, '2015-06-13 18:16:36', 2, 'DEBIT', '2015-06-12', 'NETFLIX.COM NETFLIX.COM CA                   06/12', '7.99', NULL, 1, 0, 2, '2015-06-13 18:16:37', 2, '2015-06-14 01:16:49'),
(128, '2015-06-17 11:52:29', 2, 'DEBIT', '2015-06-15', 'DV *ENG CATALOG 800-9891500 MA               06/12', '99.99', NULL, 1, 0, 2, '2015-06-17 11:52:29', 2, '2015-06-17 18:56:01'),
(129, '2015-06-17 11:52:29', 2, 'DEBIT', '2015-06-12', 'FRY''S ELECTRONICS #7 FOUNTAIN VALL CA        06/11', '7.55', NULL, 0, 1, 2, '2015-06-17 11:52:29', 2, '2015-06-17 19:05:30'),
(130, '2015-06-17 11:52:29', 2, 'DEBIT', '2015-06-12', 'NETFLIX.COM NETFLIX.COM CA                   06/12', '7.99', NULL, 0, 1, 2, '2015-06-17 11:52:30', 2, '2015-06-17 19:05:48'),
(131, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-16', 'STARBUCKS #11028 TUSTIN Tustin CA            06/15', '7.80', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:53:09'),
(132, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-16', 'RUBIO''S #011 TUSTIN CA                       06/15', '26.96', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:56:28'),
(133, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-16', 'Online Transfer to CHK ...9570 transaction#: 4696305348 06/16', '10.00', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:56:21'),
(134, '2015-06-17 11:52:51', 1, 'CHECK', '2015-06-16', 'CHECK 233 ', '570.00', '233', 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:56:12'),
(135, '2015-06-17 11:52:51', 1, 'CREDIT', '2015-06-15', 'Online Transfer from CHK ...9570 transaction#: 4690420078', '320.00', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:55:33'),
(136, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Transfer to CHK ...9570 transaction#: 4690095616 06/15', '10.00', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:55:08'),
(137, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Transfer to CHK ...9570 transaction#: 4691425603 06/15', '10.00', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:54:36'),
(138, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Payment 4691539423 To Cox Communications 06/15', '212.68', NULL, 1, 0, 2, '2015-06-17 11:52:51', 2, '2015-06-17 18:54:25'),
(139, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Payment 4691539432 To VERIZON WIRELESS 06/15', '69.04', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:55:41'),
(140, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Payment 4691539425 To NWP SERVICES CORPORATION 06/15', '47.11', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:53:51'),
(141, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'Online Payment 4691539430 To SOUTHERN CALIFORNIA GAS 06/15', '25.63', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:53:58'),
(142, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'TRADER JOE''S # 197 TUSTIN CA         877580  06/14', '92.78', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:54:05'),
(143, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-15', 'SPROUTS FARMERS MKT#25 TUSTIN CA     531908  06/15', '40.50', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:54:17'),
(144, '2015-06-17 11:52:51', 1, 'CREDIT', '2015-06-15', 'INTEREST PAYMENT', '0.03', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:54:10'),
(145, '2015-06-17 11:52:51', 1, 'DSLIP', '2015-06-12', 'DEPOSIT  ID NUMBER 578381', '2500.00', NULL, 1, 0, 2, '2015-06-17 11:52:52', 2, '2015-06-17 18:53:42'),
(146, '2015-06-17 11:52:51', 1, 'DEBIT', '2015-06-12', 'TARGET T1 TARGET T1238 IRVINE CA             06/12', '28.04', NULL, 0, 1, 2, '2015-06-17 11:52:52', 2, '2015-06-17 19:05:35'),
(147, '2015-06-21 09:43:50', 2, 'DEBIT', '2015-06-19', 'STARBUCKS #11028 TUSTIN Tustin CA            06/18', '6.70', NULL, 1, 0, 2, '2015-06-21 09:43:50', 2, '2015-06-21 16:45:37'),
(148, '2015-06-21 09:43:50', 2, 'DEBIT', '2015-06-18', 'RALPHS  TUSTIN CA                    036549  06/18', '31.09', NULL, 1, 0, 2, '2015-06-21 09:43:50', 2, '2015-06-21 16:45:32'),
(149, '2015-06-21 09:43:50', 2, 'DEBIT', '2015-06-17', 'AMERINOC COM 877-805-6542 CA                 06/15', '9.95', NULL, 1, 0, 2, '2015-06-21 09:43:50', 2, '2015-06-21 16:44:36'),
(150, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-19', 'COSTCO GAS #1001 TUSTIN CA           007850  06/19', '39.03', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:43'),
(151, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-19', 'RALPHS 13321 JAMBOREE TUSTIN CA      431183  06/19', '32.25', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:50'),
(152, '2015-06-21 09:44:16', 1, 'CREDIT', '2015-06-18', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '944.33', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:44:57'),
(153, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-18', '35 FOR LIFE 714-485-2299 TX                  06/16', '157.90', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:04'),
(154, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-18', 'STARBUCKS #16779 GARD Garden Grove CA        06/17', '4.55', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:10'),
(155, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-18', 'STATE OF CA DEPT OF D 916-464-5000 CA        06/17', '625.00', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:17'),
(156, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-18', 'RITE AID CORP. TUSTIN CA             778041  06/18', '8.18', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:45:26'),
(157, '2015-06-21 09:44:16', 1, 'DEBIT', '2015-06-17', 'Online Transfer to CHK ...9570 transaction#: 4698666625 06/17', '5.00', NULL, 1, 0, 2, '2015-06-21 09:44:16', 2, '2015-06-21 16:44:28'),
(158, '2015-06-24 11:46:59', 2, 'DEBIT', '2015-06-22', 'PICK UP STIX 765 TUSTIN TUSTIN CA            06/19', '27.38', NULL, 1, 0, 2, '2015-06-24 11:46:59', 2, '2015-06-24 18:48:37'),
(159, '2015-06-24 11:46:59', 2, 'DEBIT', '2015-06-22', 'STARBUCKS #00636 SAN San Juan Capi CA        06/21', '7.20', NULL, 1, 0, 2, '2015-06-24 11:46:59', 2, '2015-06-24 18:48:31'),
(160, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-23', 'STARBUCKS #16779 GARD Garden Grove CA        06/22', '4.55', NULL, 1, 0, 2, '2015-06-24 11:47:09', 2, '2015-06-24 18:49:04'),
(161, '2015-06-24 11:47:09', 1, 'CREDIT', '2015-06-22', 'Online Transfer from CHK ...9570 transaction#: 4707909278', '129.00', NULL, 1, 0, 2, '2015-06-24 11:47:09', 2, '2015-06-24 18:48:53'),
(162, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'JAMBA JUICE 2 TUSTIN CA                      06/19', '16.17', NULL, 1, 0, 2, '2015-06-24 11:47:09', 2, '2015-06-24 18:48:18'),
(163, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'STARBUCKS #11093 COSTA Costa Mesa CA         06/20', '10.35', NULL, 1, 0, 2, '2015-06-24 11:47:09', 2, '2015-06-24 18:48:11'),
(164, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'COSTCO WHSE #0122 TUSTIN CA          299123  06/20', '109.97', NULL, 1, 0, 2, '2015-06-24 11:47:09', 2, '2015-06-24 18:48:05'),
(165, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'Online Transfer to CHK ...9570 transaction#: 4704943413 06/22', '5.00', NULL, 1, 0, 2, '2015-06-24 11:47:10', 2, '2015-06-24 18:47:58'),
(166, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'DOORDASH.COM 6506819470 CA                   06/20', '17.20', NULL, 1, 0, 2, '2015-06-24 11:47:10', 2, '2015-06-24 18:47:45'),
(167, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'ATM WITHDRAWAL                       003006  06/2113128 JAM', '40.00', NULL, 1, 0, 2, '2015-06-24 11:47:10', 2, '2015-06-24 18:47:29'),
(168, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'AMERICAN HORSE PRODU SAN JUAN CAPI CA122743  06/21', '164.81', NULL, 1, 0, 2, '2015-06-24 11:47:10', 2, '2015-06-24 18:47:22'),
(169, '2015-06-24 11:47:09', 1, 'DEBIT', '2015-06-22', 'FRESH & EASY#1474 Garden Grove CA    676440  06/22', '5.49', NULL, 1, 0, 2, '2015-06-24 11:47:10', 2, '2015-06-24 18:48:26'),
(170, '2015-06-25 12:53:18', 1, 'DSLIP', '2015-06-24', 'DEPOSIT  ID NUMBER 990221', '660.00', NULL, 1, 0, 2, '2015-06-25 12:53:18', 2, '2015-06-25 19:53:39'),
(171, '2015-07-01 11:43:41', 2, 'DEBIT', '2015-06-30', 'ROYAL CLEANERS IRVINE CA             523765  06/30', '7.75', NULL, 1, 0, 2, '2015-07-01 11:43:41', 2, '2015-07-01 18:46:30'),
(172, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-30', 'POSTAL ANNEX 56 TUSTIN CA            205428  06/30', '27.90', NULL, 1, 0, 2, '2015-07-01 11:44:01', 2, '2015-07-01 18:46:38'),
(173, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-29', 'AMERICAN HORSE PRODU SAN JUAN CAPI CA        06/27', '75.48', NULL, 1, 0, 2, '2015-07-01 11:44:01', 2, '2015-07-01 18:46:18'),
(174, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-29', 'TRADER JOE''S # 197 TUSTIN CA         555324  06/28', '66.29', NULL, 1, 0, 2, '2015-07-01 11:44:01', 2, '2015-07-01 18:46:24'),
(175, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-29', 'TARGET T1 TARGET T1238 IRVINE CA             06/28', '31.07', NULL, 1, 0, 2, '2015-07-01 11:44:02', 2, '2015-07-01 18:46:11'),
(176, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-29', 'Online Transfer to CHK ...9570 transaction#: 4720985724 06/29', '5.00', NULL, 1, 0, 2, '2015-07-01 11:44:02', 2, '2015-07-01 18:45:53'),
(177, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-29', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 1, 0, 2, '2015-07-01 11:44:02', 2, '2015-07-01 18:45:44'),
(178, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-25', 'APL* ITUNES.COM/BILL 866-712-7753 CA         06/24', '0.99', NULL, 1, 0, 2, '2015-07-01 11:44:02', 2, '2015-07-01 18:44:14'),
(179, '2015-07-01 11:44:01', 1, 'DEBIT', '2015-06-25', 'Online Transfer to CHK ...9570 transaction#: 4714173699 06/25', '70.00', NULL, 1, 0, 2, '2015-07-01 11:44:02', 2, '2015-07-01 18:45:33'),
(180, '2015-07-03 13:24:43', 1, 'DEBIT', '2015-07-02', 'STATE OF CA DEPT OF D 916-464-5000 CA        07/01', '600.00', NULL, 1, 0, 2, '2015-07-03 13:24:43', 2, '2015-07-03 20:26:02'),
(181, '2015-07-03 13:24:43', 1, 'DSLIP', '2015-07-01', 'DEPOSIT  ID NUMBER 390390', '4000.00', NULL, 1, 0, 2, '2015-07-03 13:24:43', 2, '2015-07-03 20:24:58'),
(182, '2015-07-03 13:24:43', 1, 'DEBIT', '2015-07-01', 'SUBWAY        0060806 GARDEN GROVE CA        06/30', '12.02', NULL, 1, 0, 2, '2015-07-03 13:24:43', 2, '2015-07-03 20:25:07'),
(183, '2015-07-03 13:24:43', 1, 'CHECK', '2015-07-01', 'CHECK 229 ', '830.15', '229', 1, 0, 2, '2015-07-03 13:24:43', 2, '2015-07-03 20:25:27'),
(184, '2015-07-03 13:24:43', 1, 'CHECK', '2015-07-01', 'CHECK 231 ', '830.15', '231', 1, 0, 2, '2015-07-03 13:24:43', 2, '2015-07-03 20:25:54'),
(185, '2015-07-09 11:13:23', 2, 'CREDIT', '2015-07-07', 'Online Transfer from CHK ...9657 transaction#: 4738475077', '100.00', NULL, 1, 0, 2, '2015-07-09 11:13:23', 2, '2015-07-09 18:15:55'),
(186, '2015-07-09 11:13:23', 2, 'DEBIT', '2015-07-07', 'AAA CA MBR RENEWAL - 877-428-2277 CA         07/07', '48.00', NULL, 1, 0, 2, '2015-07-09 11:13:23', 2, '2015-07-09 18:16:07'),
(187, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...2339 transaction#: 4738475077 07/07', '100.00', NULL, 1, 0, 2, '2015-07-09 11:13:51', 2, '2015-07-09 18:15:20'),
(188, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...9570 transaction#: 4739108893 07/07', '250.00', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:15:38'),
(189, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'SKYPE.COM LUXEMBOURG                         07/01', '30.50', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:17:23'),
(190, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'SKYPE.COM LUXEMBOURG                         07/01', '30.00', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:17:36'),
(191, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'Online Payment 4733338666 To NWP SERVICES CORPORATION 07/06', '51.40', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:38'),
(192, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'TARGET T1 TARGET T1238 IRVINE CA             07/04 Purchase $48.29 Cash Back $40.00', '88.29', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:15:02'),
(193, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'SPROUTS FARMERS MKT#25 TUSTIN CA     408729  07/04', '25.40', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:31'),
(194, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'FRESH & EASY#1474 Garden Grove CA    726420  07/06', '7.78', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:24'),
(195, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'Anacapa Apartmen WEB PMTS   M29FB2          WEB ID: 1203874681', '2245.00', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:17'),
(196, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-06', 'JPMorgan Chase   Ext Trnsfr 4677015622      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:11'),
(197, '2015-07-09 11:13:51', 1, 'DEBIT', '2015-07-03', 'ARCO #42091 HUNTINGTON BE CA         857552  07/03', '35.47', NULL, 1, 0, 2, '2015-07-09 11:13:52', 2, '2015-07-09 18:14:04'),
(198, '2015-07-14 08:35:26', 2, 'DEBIT', '2015-07-13', 'SUBWAY        0060806 GARDEN GROVE CA        07/10', '11.50', NULL, 1, 0, 2, '2015-07-14 08:35:26', 2, '2015-07-14 15:36:08'),
(199, '2015-07-14 08:35:26', 2, 'DEBIT', '2015-07-13', 'NETFLIX.COM NETFLIX.COM CA                   07/12', '7.99', NULL, 1, 0, 2, '2015-07-14 08:35:26', 2, '2015-07-14 15:36:29'),
(200, '2015-07-14 08:35:26', 2, 'CREDIT', '2015-07-07', 'Online Transfer from CHK ...9657 transaction#: 4738475077', '100.00', NULL, 0, 1, 2, '2015-07-14 08:35:26', 2, '2015-07-14 15:35:41'),
(201, '2015-07-14 08:35:26', 2, 'DEBIT', '2015-07-07', 'AAA CA MBR RENEWAL - 877-428-2277 CA         07/07', '48.00', NULL, 0, 1, 2, '2015-07-14 08:35:26', 2, '2015-07-14 15:35:49'),
(202, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-10', 'PAYPAL *ENVATO MKPL EN 4029357733            07/08', '19.00', NULL, 1, 0, 2, '2015-07-14 08:37:07', 2, '2015-07-14 15:38:05'),
(203, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-10', 'Online Payment 4726870504 To SOUTHERN CALIFORNIA EDISON 07/10', '102.60', NULL, 1, 0, 2, '2015-07-14 08:37:07', 2, '2015-07-14 15:38:13'),
(204, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-10', 'Online Payment 4733338669 To VERIZON WIRELESS 07/10', '70.14', NULL, 1, 0, 2, '2015-07-14 08:37:08', 2, '2015-07-14 15:38:21'),
(205, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-09', 'Online Payment 4742976433 To Cox Communications 07/09', '199.36', NULL, 1, 0, 2, '2015-07-14 08:37:08', 2, '2015-07-14 15:37:43'),
(206, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...2339 transaction#: 4738475077 07/07', '100.00', NULL, 0, 1, 2, '2015-07-14 08:37:08', 2, '2015-07-14 15:37:27'),
(207, '2015-07-14 08:37:07', 1, 'DEBIT', '2015-07-07', 'Online Transfer to CHK ...9570 transaction#: 4739108893 07/07', '250.00', NULL, 0, 1, 2, '2015-07-14 08:37:08', 2, '2015-07-14 15:37:34'),
(208, '2015-07-17 08:29:30', 1, 'DEBIT', '2015-07-15', 'COSTCO WHSE #1110 HUNTINGTON BE CA   256354  07/15', '110.00', NULL, 1, 0, 2, '2015-07-17 08:29:30', 2, '2015-07-17 15:30:29'),
(209, '2015-07-17 08:29:30', 1, 'DEBIT', '2015-07-15', 'COSTCO GAS #1110 HUNTINGTON B CA     058391  07/15', '44.22', NULL, 1, 0, 2, '2015-07-17 08:29:30', 2, '2015-07-17 15:30:37'),
(210, '2015-07-17 08:29:30', 1, 'CREDIT', '2015-07-15', 'INTEREST PAYMENT', '0.03', NULL, 1, 0, 2, '2015-07-17 08:29:30', 2, '2015-07-17 15:30:18'),
(211, '2015-07-17 08:29:57', 2, 'DEBIT', '2015-07-13', 'SUBWAY        0060806 GARDEN GROVE CA        07/10', '11.50', NULL, 0, 1, 2, '2015-07-17 08:29:57', 2, '2015-07-17 15:30:11'),
(212, '2015-07-17 08:29:57', 2, 'DEBIT', '2015-07-13', 'NETFLIX.COM NETFLIX.COM CA                   07/12', '7.99', NULL, 0, 1, 2, '2015-07-17 08:29:57', 2, '2015-07-17 15:30:07'),
(213, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-24', 'AIRPORT INN S SAN FRAN CA                    07/23', '217.00', NULL, 1, 0, 2, '2015-07-27 12:39:37', 2, '2015-07-27 19:42:06'),
(214, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-24', 'Online Payment 4742976442 To SOUTHERN CALIFORNIA GAS 07/24', '25.32', NULL, 1, 0, 2, '2015-07-27 12:39:37', 2, '2015-07-27 19:41:47'),
(215, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-24', 'STARBUCKS #09687 SOU South San Fra CA        07/24', '15.20', NULL, 1, 0, 2, '2015-07-27 12:39:37', 2, '2015-07-27 19:41:39'),
(216, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-23', 'BART-POWELL        Q SAN FRANCISCO CA        07/23', '3.80', NULL, 1, 0, 2, '2015-07-27 12:39:37', 2, '2015-07-27 19:41:33'),
(217, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-22', 'ROYAL CLEANERS IRVINE CA             364183  07/22', '32.40', NULL, 1, 0, 2, '2015-07-27 12:39:38', 2, '2015-07-27 19:41:27'),
(218, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-21', 'Chase QuickPay Electronic Transfer 4764433141 to Christopher', '331.20', NULL, 1, 0, 2, '2015-07-27 12:39:38', 2, '2015-07-27 19:41:19'),
(219, '2015-07-27 12:39:37', 1, 'DSLIP', '2015-07-17', 'DEPOSIT  ID NUMBER 628490', '3500.00', NULL, 1, 0, 2, '2015-07-27 12:39:38', 2, '2015-07-27 19:40:52'),
(220, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-17', 'AMAZON MKTPLACE PMTS AMZN.COM/BILL WA        07/17', '10.00', NULL, 1, 0, 2, '2015-07-27 12:39:38', 2, '2015-07-27 19:40:28'),
(221, '2015-07-27 12:39:37', 1, 'DEBIT', '2015-07-17', 'TRADER JOE''S # 197 TUSTIN CA         757105  07/17', '83.46', NULL, 1, 0, 2, '2015-07-27 12:39:38', 2, '2015-07-27 19:40:17'),
(222, '2015-07-27 12:39:56', 2, 'DEBIT', '2015-07-24', 'DARBY DANS SANDWICH CO S SAN FRAN CA         07/23', '7.25', NULL, 1, 0, 2, '2015-07-27 12:39:56', 2, '2015-07-27 19:41:54'),
(223, '2015-07-27 12:39:56', 2, 'DEBIT', '2015-07-17', 'AMERINOC COM 877-805-6542 CA                 07/15', '9.95', NULL, 1, 0, 2, '2015-07-27 12:39:56', 2, '2015-07-27 19:40:09'),
(224, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-29', 'COSTCO GAS #1110 HUNTINGTON B CA     083695  07/29', '41.81', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:11:28'),
(225, '2015-07-30 14:08:44', 1, 'CREDIT', '2015-07-28', 'Online Transfer from CHK ...2339 transaction#: 4779781947', '500.00', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:10:41'),
(226, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-28', 'HITCHN POST FEED AND TA ORANGE CA            07/26', '48.44', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:10:55'),
(227, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-28', 'TRADER JOE''S # 197 TUSTIN CA         241266  07/28', '65.87', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:11:04'),
(228, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-28', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:10:25'),
(229, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-28', 'Anacapa Apartmen WEB PMTS   F264C2          WEB ID: 1203874681', '56.52', NULL, 1, 0, 2, '2015-07-30 14:08:44', 2, '2015-07-30 21:10:48'),
(230, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-27', 'APL* ITUNES.COM/BILL 866-712-7753 CA         07/24', '0.99', NULL, 1, 0, 2, '2015-07-30 14:08:45', 2, '2015-07-30 21:10:03'),
(231, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-27', 'SPROUTS FARMERS MKT#25 TUSTIN CA     506375  07/25', '50.49', NULL, 1, 0, 2, '2015-07-30 14:08:45', 2, '2015-07-30 21:09:56'),
(232, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-27', 'EXPRESS LLC NEWPORT BEACH CA                 07/26', '34.65', NULL, 1, 0, 2, '2015-07-30 14:08:45', 2, '2015-07-30 21:09:50'),
(233, '2015-07-30 14:08:44', 1, 'DEBIT', '2015-07-27', 'WAHOO''S FISH TACO-93 NEWPORT BEACH CA        07/26', '23.78', NULL, 1, 0, 2, '2015-07-30 14:08:45', 2, '2015-07-30 21:09:42'),
(234, '2015-07-30 14:08:44', 1, 'CHECK', '2015-07-27', 'CHECK 234 ', '830.15', '234', 1, 0, 2, '2015-07-30 14:08:45', 2, '2015-07-30 21:09:35'),
(235, '2015-07-30 14:08:56', 2, 'DEBIT', '2015-07-29', 'TARGET T1238 IRVINE CA               025829  07/29', '43.36', NULL, 1, 0, 2, '2015-07-30 14:08:56', 2, '2015-07-30 21:11:38'),
(236, '2015-07-30 14:08:56', 2, 'DEBIT', '2015-07-29', 'TARGET T1238 IRVINE CA               059261  07/29', '17.35', NULL, 1, 0, 2, '2015-07-30 14:08:57', 2, '2015-07-30 21:11:11'),
(237, '2015-07-30 14:08:56', 2, 'DEBIT', '2015-07-28', 'Online Transfer to CHK ...9657 transaction#: 4779781947 07/28', '500.00', NULL, 1, 0, 2, '2015-07-30 14:08:57', 2, '2015-07-30 21:10:35'),
(238, '2015-07-30 14:08:56', 2, 'DSLIP', '2015-07-27', 'REMOTE ONLINE DEPOSIT #          1', '576.12', '1', 1, 0, 2, '2015-07-30 14:08:57', 2, '2015-07-30 21:09:20'),
(239, '2015-07-30 14:08:56', 2, 'DEBIT', '2015-07-27', 'JAMBA JUICE 2 TUSTIN CA                      07/25', '5.89', NULL, 1, 0, 2, '2015-07-30 14:08:57', 2, '2015-07-30 21:09:07'),
(240, '2015-07-30 14:08:56', 2, 'DEBIT', '2015-07-27', 'Online Transfer to CHK ...9570 transaction#: 4777651363 07/27', '15.00', NULL, 1, 0, 2, '2015-07-30 14:08:57', 2, '2015-07-30 21:10:15'),
(241, '2015-07-31 08:12:38', 1, 'DSLIP', '2015-07-30', 'REMOTE ONLINE DEPOSIT #          1', '300.00', '1', 1, 0, 2, '2015-07-31 08:12:38', 2, '2015-07-31 15:13:13'),
(242, '2015-07-31 08:12:38', 1, 'CREDIT', '2015-07-30', 'Online Transfer from CHK ...9570 transaction#: 4783757829', '1150.00', NULL, 1, 0, 2, '2015-07-31 08:12:38', 2, '2015-07-31 15:13:21'),
(243, '2015-08-12 09:11:01', 1, 'CREDIT', '2015-08-11', 'Online Transfer from CHK ...9570 transaction#: 4809017984', '800.00', NULL, 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:12:05'),
(244, '2015-08-12 09:11:01', 1, 'CHECK', '2015-08-11', 'CHECK 238 ', '200.00', '238', 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:13:40'),
(245, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '17.00', NULL, 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:15:28'),
(246, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '16.00', NULL, 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:15:21'),
(247, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/07', '7.00', NULL, 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:15:11'),
(248, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '3.50', NULL, 1, 0, 2, '2015-08-12 09:11:01', 2, '2015-08-12 16:14:58'),
(249, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '7.00', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:14:42'),
(250, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'SEASIDE CATERING NEWPORT BEACH CA            08/08', '2.00', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:14:28'),
(251, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   718945  08/09', '66.07', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:13:48'),
(252, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-10', 'TARGET T1 TARGET T1238 IRVINE CA             08/10', '46.79', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:14:05'),
(253, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '27.50', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:15:45'),
(254, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '13.00', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:15:52'),
(255, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-07', 'SEASIDE CATERING NEWPORT BEACH CA            08/06', '10.00', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:15:59'),
(256, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-07', 'JPMorgan Chase   Ext Trnsfr 4731425829      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:15:36'),
(257, '2015-08-12 09:11:01', 1, 'CHECK', '2015-08-07', 'CHECK 237 ', '100.00', '237', 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:16:38'),
(258, '2015-08-12 09:11:01', 1, 'CREDIT', '2015-08-06', 'Online Transfer from CHK ...9570 transaction#: 4799384776', '295.00', NULL, 1, 0, 2, '2015-08-12 09:11:02', 2, '2015-08-12 16:17:00'),
(259, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-06', 'MIGUELS JR 23 TUSTIN CA                      08/04', '11.21', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:08'),
(260, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-06', 'Online Payment 4777577136 To Cox Communications 08/06', '194.62', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:16'),
(261, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-06', 'TARGET T1 TARGET T1238 IRVINE CA             08/06', '12.31', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:26'),
(262, '2015-08-12 09:11:01', 1, 'CHECK', '2015-08-04', 'CHECK 236 ', '43.24', '236', 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:38'),
(263, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-03', 'EQUESTRIAN SERVICES II COSTA MESA CA         07/31', '1000.00', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:18:36'),
(264, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-03', 'TARGET T1 TARGET T1238 IRVINE CA             08/01', '41.02', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:48'),
(265, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-03', 'TRADER JOE''S # 197 TUSTIN CA         240615  08/02', '35.77', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:17:55'),
(266, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-03', 'Online Transfer to CHK ...9570 transaction#: 4791226933 08/03', '10.00', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:18:07'),
(267, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-08-03', 'Anacapa Apartmen WEB PMTS   SKCNC2          WEB ID: 1203874681', '2240.00', NULL, 1, 0, 2, '2015-08-12 09:11:03', 2, '2015-08-12 16:18:16'),
(268, '2015-08-12 09:11:01', 1, 'CREDIT', '2015-07-31', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '2700.00', NULL, 1, 0, 2, '2015-08-12 09:11:04', 2, '2015-08-12 16:19:04'),
(269, '2015-08-12 09:11:01', 1, 'DEBIT', '2015-07-31', 'Online Transfer to CHK ...9570 transaction#: 4786458129 07/31', '20.00', NULL, 1, 0, 2, '2015-08-12 09:11:04', 2, '2015-08-12 16:18:46'),
(270, '2015-08-12 09:11:40', 2, 'DEBIT', '2015-08-06', 'STARBUCKS #22637 COSTA Costa Mesa CA         08/05', '6.70', NULL, 1, 0, 2, '2015-08-12 09:11:40', 2, '2015-08-12 16:16:45'),
(271, '2015-08-13 12:30:58', 2, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9657 transaction#: 4810788315', '100.00', NULL, 1, 0, 2, '2015-08-13 12:30:58', 2, '2015-08-13 19:34:22'),
(272, '2015-08-13 12:30:58', 2, 'DEBIT', '2015-08-12', 'ANSAR GALLERY TUSTIN CA              447910  08/12', '18.43', NULL, 1, 0, 2, '2015-08-13 12:30:58', 2, '2015-08-13 19:34:29'),
(273, '2015-08-13 12:30:58', 2, 'DEBIT', '2015-08-12', 'NETFLIX.COM NETFLIX.COM CA                   08/12', '7.99', NULL, 1, 0, 2, '2015-08-13 12:30:58', 2, '2015-08-13 19:34:15'),
(274, '2015-08-13 12:31:15', 1, 'CREDIT', '2015-08-12', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '900.00', NULL, 1, 0, 2, '2015-08-13 12:31:15', 2, '2015-08-13 19:34:07'),
(275, '2015-08-13 12:31:15', 1, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9570 transaction#: 4810787262', '480.00', NULL, 1, 0, 2, '2015-08-13 12:31:15', 2, '2015-08-13 19:33:53'),
(276, '2015-08-13 12:31:15', 1, 'DEBIT', '2015-08-12', '35 FOR LIFE 714-485-2299 TX                  08/11', '121.90', NULL, 1, 0, 2, '2015-08-13 12:31:16', 2, '2015-08-13 19:33:41');
INSERT INTO `transaction_upload` (`id`, `upload_datetime`, `bank_account_id`, `type`, `transaction_date`, `description`, `amount`, `check_num`, `status`, `is_deleted`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(277, '2015-08-13 12:31:15', 1, 'DEBIT', '2015-08-12', 'Online Payment 4779784583 To VERIZON WIRELESS 08/12', '69.80', NULL, 1, 0, 2, '2015-08-13 12:31:16', 2, '2015-08-13 19:33:27'),
(278, '2015-08-13 12:31:15', 1, 'DEBIT', '2015-08-12', 'Online Transfer to CHK ...2339 transaction#: 4810788315 08/12', '100.00', NULL, 1, 0, 2, '2015-08-13 12:31:16', 2, '2015-08-13 19:33:13'),
(279, '2015-08-13 12:31:15', 1, 'CHECK', '2015-08-12', 'CHECK 239 ', '880.00', '239', 1, 0, 2, '2015-08-13 12:31:16', 2, '2015-08-13 19:32:55'),
(280, '2015-08-13 12:31:15', 1, 'CHECK', '2015-08-12', 'CHECK 240 ', '500.00', '240', 1, 0, 2, '2015-08-13 12:31:16', 2, '2015-08-13 19:32:40'),
(281, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-18', 'AMERINOC COM 877-805-6542 CA                 08/15', '9.95', NULL, 1, 0, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:35:03'),
(282, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-17', 'MCDONALD''S F34609 COSTA MESA CA              08/13', '6.24', NULL, 1, 0, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:34:44'),
(283, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-17', 'STARBUCKS CARD RELOAD 800-782-7282 WA        08/15', '15.00', NULL, 1, 0, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:34:20'),
(284, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-17', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   913901  08/15', '9.96', NULL, 1, 0, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:33:59'),
(285, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-14', 'SUBWAY        00018846 COSTA MESA CA         08/13', '14.99', NULL, 1, 0, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:33:47'),
(286, '2015-08-20 08:30:13', 2, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9657 transaction#: 4810788315', '100.00', NULL, 0, 1, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:36:01'),
(287, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-12', 'ANSAR GALLERY TUSTIN CA              447910  08/12', '18.43', NULL, 0, 1, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:35:36'),
(288, '2015-08-20 08:30:13', 2, 'DEBIT', '2015-08-12', 'NETFLIX.COM NETFLIX.COM CA                   08/12', '7.99', NULL, 0, 1, 2, '2015-08-20 08:30:13', 2, '2015-08-20 15:36:06'),
(289, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-19', 'ATM WITHDRAWAL                       002932  08/1913128 JAM', '40.00', NULL, 1, 0, 2, '2015-08-20 08:30:59', 2, '2015-08-20 15:35:16'),
(290, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-18', 'TRADER JOE''S # 210 IRVINE CA         677137  08/18', '72.86', NULL, 1, 0, 2, '2015-08-20 08:30:59', 2, '2015-08-20 15:34:54'),
(291, '2015-08-20 08:30:59', 1, 'CREDIT', '2015-08-17', 'INTEREST PAYMENT', '0.04', NULL, 1, 0, 2, '2015-08-20 08:30:59', 2, '2015-08-20 15:33:52'),
(292, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-14', 'TAX PROS 209-589-9046 CA                     08/12', '36.95', NULL, 1, 0, 2, '2015-08-20 08:30:59', 2, '2015-08-20 15:33:41'),
(293, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-14', 'COSTCO GAS #1001 TUSTIN CA           040388  08/14', '40.95', NULL, 1, 0, 2, '2015-08-20 08:30:59', 2, '2015-08-20 15:33:22'),
(294, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-13', 'STARBUCKS #22637 COSTA Costa Mesa CA         08/12', '4.55', NULL, 1, 0, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:33:15'),
(295, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-13', 'Online Payment 4778933007 To SOUTHERN CALIFORNIA EDISON 08/13', '68.98', NULL, 1, 0, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:33:02'),
(296, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-13', 'TRADER JOE''S # 197 TUSTIN CA         681115  08/13', '42.40', NULL, 1, 0, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:33:08'),
(297, '2015-08-20 08:30:59', 1, 'CREDIT', '2015-08-12', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '900.00', NULL, 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:36:12'),
(298, '2015-08-20 08:30:59', 1, 'CREDIT', '2015-08-12', 'Online Transfer from CHK ...9570 transaction#: 4810787262', '480.00', NULL, 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:36:16'),
(299, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-12', '35 FOR LIFE 714-485-2299 TX                  08/11', '121.90', NULL, 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:36:29'),
(300, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-12', 'Online Payment 4779784583 To VERIZON WIRELESS 08/12', '69.80', NULL, 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:36:23'),
(301, '2015-08-20 08:30:59', 1, 'DEBIT', '2015-08-12', 'Online Transfer to CHK ...2339 transaction#: 4810788315 08/12', '100.00', NULL, 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:35:57'),
(302, '2015-08-20 08:30:59', 1, 'CHECK', '2015-08-12', 'CHECK 239 ', '880.00', '239', 0, 1, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:35:45'),
(303, '2015-08-20 08:30:59', 1, 'CHECK', '2015-08-12', 'CHECK 240 ', '500.00', '240', 1, 0, 2, '2015-08-20 08:31:00', 2, '2015-08-20 15:31:19'),
(304, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-21', 'DAPHNE''S COSTA MES COSTA MESA CA             08/20', '21.22', NULL, 1, 0, 2, '2015-08-22 07:42:29', 2, '2015-08-22 14:44:13'),
(305, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-21', 'Online Payment 4801929763 To SOUTHERN CALIFORNIA GAS 08/21', '17.91', NULL, 1, 0, 2, '2015-08-22 07:42:30', 2, '2015-08-22 14:44:23'),
(306, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-20', 'Online Payment 4808912285 To Memorial Health Services 08/20', '40.00', NULL, 1, 0, 2, '2015-08-22 07:42:30', 2, '2015-08-22 14:43:51'),
(307, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-20', 'ANSAR GALLERY TUSTIN CA              135261  08/20', '18.92', NULL, 1, 0, 2, '2015-08-22 07:42:30', 2, '2015-08-22 14:44:03'),
(308, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-20', 'TUSTIN RANCH TIRE AND TUSTIN CA      802939  08/20', '499.32', NULL, 1, 0, 2, '2015-08-22 07:42:31', 2, '2015-08-22 14:43:07'),
(309, '2015-08-22 07:42:29', 1, 'DEBIT', '2015-08-19', 'ATM WITHDRAWAL                       002932  08/1913128 JAM', '40.00', NULL, 0, 1, 2, '2015-08-22 07:42:31', 2, '2015-08-22 14:42:49'),
(310, '2015-08-29 08:54:36', 2, 'DEBIT', '2015-08-24', 'STARBUCKS CARD RELOAD 800-782-7282 WA        08/24', '10.00', NULL, 1, 0, 2, '2015-08-29 08:54:36', 2, '2015-08-29 15:55:46'),
(311, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-28', 'TRADER JOE''S #195 ALISO VIEJO CA     042760  08/28', '5.28', NULL, 1, 0, 2, '2015-08-29 08:54:56', 2, '2015-08-29 15:56:52'),
(312, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-28', 'COSTCO GAS #1001 TUSTIN CA           061817  08/28', '38.55', NULL, 1, 0, 2, '2015-08-29 08:54:56', 2, '2015-08-29 15:57:01'),
(313, '2015-08-29 08:54:56', 1, 'CREDIT', '2015-08-27', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '384.09', NULL, 1, 0, 2, '2015-08-29 08:54:56', 2, '2015-08-29 15:56:41'),
(314, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-27', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 1, 0, 2, '2015-08-29 08:54:56', 2, '2015-08-29 15:56:24'),
(315, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-26', 'AULD DUBLINER TUSTIN TUSTIN CA               08/24', '24.80', NULL, 1, 0, 2, '2015-08-29 08:54:57', 2, '2015-08-29 15:56:14'),
(316, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-24', 'STATE OF CA DEPT OF D 916-464-5000 CA        08/22', '625.00', NULL, 1, 0, 2, '2015-08-29 08:54:57', 2, '2015-08-29 15:56:06'),
(317, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-24', 'TRADER JOE''S # 197 TUSTIN CA         278695  08/23', '77.64', NULL, 1, 0, 2, '2015-08-29 08:54:57', 2, '2015-08-29 15:55:53'),
(318, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-24', 'KOHL''S #1382 18182 IRV TUSTIN CA     916405  08/23', '53.98', NULL, 1, 0, 2, '2015-08-29 08:54:57', 2, '2015-08-29 15:55:38'),
(319, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-21', 'DAPHNE''S COSTA MES COSTA MESA CA             08/20', '21.22', NULL, 0, 1, 2, '2015-08-29 08:54:57', 2, '2015-08-29 15:55:28'),
(320, '2015-08-29 08:54:56', 1, 'DEBIT', '2015-08-21', 'Online Payment 4801929763 To SOUTHERN CALIFORNIA GAS 08/21', '17.91', NULL, 0, 1, 2, '2015-08-29 08:54:58', 2, '2015-08-29 15:55:08'),
(321, '2015-09-01 16:26:34', 1, 'DSLIP', '2015-08-31', 'DEPOSIT  ID NUMBER 570514', '1000.00', NULL, 1, 0, 2, '2015-09-01 16:26:34', 2, '2015-09-01 23:28:36'),
(322, '2015-09-01 16:26:34', 1, 'DSLIP', '2015-08-31', 'REMOTE ONLINE DEPOSIT #          1', '300.00', '1', 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:27:48'),
(323, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'SUPERCUTS 8744 IRVINE CA                     08/29', '18.50', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:27:23'),
(324, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'JUICE IT UP COSTA MESA CA                    08/29', '26.10', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:27:17'),
(325, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'COSTCO WHSE #1001 TUSTIN CA          204030  08/29', '178.97', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:27:10'),
(326, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'TRADER JOE''S # 197 TUSTIN CA         919596  08/30', '52.00', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:27:04'),
(327, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'Online Transfer to CHK ...9570 transaction#: 4848568454 08/31', '10.00', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:26:58'),
(328, '2015-09-01 16:26:34', 1, 'DEBIT', '2015-08-31', 'TRADER JOE''S # 210 IRVINE CA         536123  08/31', '20.21', NULL, 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:26:45'),
(329, '2015-09-01 16:26:34', 1, 'CHECK', '2015-08-31', 'CHECK 235 ', '830.15', '235', 1, 0, 2, '2015-09-01 16:26:35', 2, '2015-09-01 23:28:10'),
(330, '2015-09-03 09:44:21', 1, 'CREDIT', '2015-09-02', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1716.93', NULL, 1, 0, 2, '2015-09-03 09:44:21', 2, '2015-09-03 16:44:57'),
(331, '2015-09-03 09:44:21', 1, 'DEBIT', '2015-09-02', 'Online Transfer to MMA ...0371 transaction#: 4855032727 09/02', '500.00', NULL, 1, 0, 2, '2015-09-03 09:44:21', 2, '2015-09-03 16:45:03'),
(332, '2015-09-03 09:44:21', 1, 'DEBIT', '2015-09-01', 'Anacapa Apartmen WEB PMTS   09JYD2          WEB ID: 1203874681', '2291.54', NULL, 1, 0, 2, '2015-09-03 09:44:21', 2, '2015-09-03 16:44:41'),
(333, '2015-09-03 15:01:21', 6, 'CREDIT', '2015-09-02', 'Online Transfer from CHK ...9657 transaction#: 4855032727', '500.00', NULL, 1, 0, 2, '2015-09-03 15:01:21', 2, '2015-09-03 22:01:37'),
(334, '2015-09-10 09:30:45', 2, 'DEBIT', '2015-09-08', 'THE FLAME BROILER #175 TUSTIN CA             09/05', '5.40', NULL, 1, 0, 2, '2015-09-10 09:30:45', 2, '2015-09-10 16:35:08'),
(335, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-09', 'VVS*VAL VET/DIRECT PE 800-468-0059 KS        09/08', '52.95', NULL, 1, 0, 2, '2015-09-10 09:30:55', 2, '2015-09-10 16:35:27'),
(336, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-09', 'JPMorgan Chase   Ext Trnsfr 4798914040      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-09-10 09:30:55', 2, '2015-09-10 16:35:15'),
(337, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'STATE OF CA DEPT OF D 916-464-5000 CA        09/05', '625.00', NULL, 1, 0, 2, '2015-09-10 09:30:55', 2, '2015-09-10 16:34:55'),
(338, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'RUBIO''S #011 TUSTIN CA                       09/05', '11.74', NULL, 1, 0, 2, '2015-09-10 09:30:55', 2, '2015-09-10 16:34:49'),
(339, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'TARGET        00012385 IRVINE CA             09/05', '65.77', NULL, 1, 0, 2, '2015-09-10 09:30:55', 2, '2015-09-10 16:34:42'),
(340, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'CROWN ACE HARDWA COSTA MESA CA               09/06 Purchase $38.62 Cash Back $20.00', '58.62', NULL, 1, 0, 2, '2015-09-10 09:30:56', 2, '2015-09-10 16:34:34'),
(341, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'TRADER JOE''S # 197 TUSTIN CA         394151  09/06', '66.13', NULL, 1, 0, 2, '2015-09-10 09:30:56', 2, '2015-09-10 16:34:26'),
(342, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'CITY OF HB PARKING M HUNTINGTN BCH CA        09/07', '6.00', NULL, 1, 0, 2, '2015-09-10 09:30:56', 2, '2015-09-10 16:34:19'),
(343, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'Online Payment 4844889178 To Cox Communications 09/08', '194.62', NULL, 1, 0, 2, '2015-09-10 09:30:56', 2, '2015-09-10 16:34:11'),
(344, '2015-09-10 09:30:55', 1, 'DEBIT', '2015-09-08', 'COSTCO GAS #1001 TUSTIN CA           084812  09/08', '36.44', NULL, 1, 0, 2, '2015-09-10 09:30:56', 2, '2015-09-10 16:35:02'),
(345, '2015-09-11 12:46:25', 2, 'CREDIT', '2015-09-10', 'Online Transfer from CHK ...9657 transaction#: 4870329779', '100.00', NULL, 1, 0, 2, '2015-09-11 12:46:25', 2, '2015-09-11 19:54:24'),
(346, '2015-09-11 12:46:45', 6, 'CREDIT', '2015-09-10', 'Online Transfer from CHK ...9657 transaction#: 4870326664', '500.00', NULL, 1, 0, 2, '2015-09-11 12:46:45', 2, '2015-09-11 19:54:48'),
(347, '2015-09-11 12:46:56', 1, 'CREDIT', '2015-09-10', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1716.93', NULL, 1, 0, 2, '2015-09-11 12:46:56', 2, '2015-09-11 19:55:23'),
(348, '2015-09-11 12:46:56', 1, 'DEBIT', '2015-09-10', 'Online Payment 4844889184 To VERIZON WIRELESS 09/10', '69.98', NULL, 1, 0, 2, '2015-09-11 12:46:56', 2, '2015-09-11 19:55:30'),
(349, '2015-09-11 12:46:56', 1, 'DEBIT', '2015-09-10', 'Online Transfer to MMA ...0371 transaction#: 4870326664 09/10', '500.00', NULL, 1, 0, 2, '2015-09-11 12:46:56', 2, '2015-09-11 19:55:45'),
(350, '2015-09-11 12:46:56', 1, 'DEBIT', '2015-09-10', 'Online Transfer to CHK ...2339 transaction#: 4870329779 09/10', '100.00', NULL, 1, 0, 2, '2015-09-11 12:46:56', 2, '2015-09-11 19:55:59'),
(351, '2015-09-11 12:46:56', 1, 'DEBIT', '2015-09-10', 'Online Payment 4870465364 To SOUTHERN CALIFORNIA EDISON 09/10', '57.16', NULL, 1, 0, 2, '2015-09-11 12:46:57', 2, '2015-09-11 19:56:06'),
(352, '2015-09-15 07:55:39', 2, 'DEBIT', '2015-09-14', 'STARBUCKS #19353 WESTM Westminster CA        09/12', '6.70', NULL, 1, 0, 2, '2015-09-15 07:55:39', 2, '2015-09-15 15:27:10'),
(353, '2015-09-15 07:55:39', 2, 'DEBIT', '2015-09-14', 'WHICH WICH #354 TUSTIN CA                    09/13', '8.86', NULL, 1, 0, 2, '2015-09-15 07:55:39', 2, '2015-09-17 16:21:16'),
(354, '2015-09-15 07:55:39', 2, 'DEBIT', '2015-09-14', 'NETFLIX.COM NETFLIX.COM CA                   09/13', '7.99', NULL, 1, 0, 2, '2015-09-15 07:55:40', 2, '2015-09-17 16:20:22'),
(355, '2015-09-15 07:55:53', 1, 'DEBIT', '2015-09-14', 'EUREKA HUNTINGTON BE HUNTINGTON BE CA        09/11', '94.25', NULL, 1, 0, 2, '2015-09-15 07:55:53', 2, '2015-09-17 16:20:34'),
(356, '2015-09-15 07:55:53', 1, 'DEBIT', '2015-09-14', 'ATM WITHDRAWAL                       006903  09/1213128 JAM', '100.00', NULL, 1, 0, 2, '2015-09-15 07:55:53', 2, '2015-09-17 16:20:47'),
(357, '2015-09-15 07:55:53', 1, 'DEBIT', '2015-09-14', 'VIVA FRESH MEXICAN RES BURBANK CA            09/12', '68.02', NULL, 1, 0, 2, '2015-09-15 07:55:53', 2, '2015-09-17 16:21:03'),
(358, '2015-09-15 07:55:53', 1, 'DEBIT', '2015-09-14', 'COSTCO GAS #0411 FOUNTAIN VALL CA    020051  09/13', '25.45', NULL, 1, 0, 2, '2015-09-15 07:55:53', 2, '2015-09-17 16:21:10'),
(359, '2015-09-15 07:55:53', 1, 'DEBIT', '2015-09-11', 'APL* ITUNES.COM/BILL 866-712-7753 CA         09/10', '0.99', NULL, 1, 0, 2, '2015-09-15 07:55:53', 2, '2015-09-15 15:26:56'),
(360, '2015-09-17 10:11:08', 2, 'DEBIT', '2015-09-16', 'RALPHS TUSTIN CA                     034317  09/16', '19.48', NULL, 1, 0, 2, '2015-09-17 10:11:08', 2, '2015-09-17 17:15:13'),
(361, '2015-09-17 10:12:20', 6, 'CREDIT', '2015-09-16', 'INTEREST PAYMENT', '0.01', NULL, 1, 0, 2, '2015-09-17 10:12:20', 2, '2015-09-17 17:14:36'),
(362, '2015-09-17 10:13:45', 1, 'DEBIT', '2015-09-16', 'HARRY''S 888-212-6855 WWW.HARRYS.CO NY        09/13', '33.00', NULL, 1, 0, 2, '2015-09-17 10:13:45', 2, '2015-09-17 17:14:45'),
(363, '2015-09-17 10:13:45', 1, 'DEBIT', '2015-09-16', 'TCA FASTRAK R 949-727-4800 CA                09/16', '30.00', NULL, 1, 0, 2, '2015-09-17 10:13:46', 2, '2015-09-17 17:14:53'),
(364, '2015-09-17 10:13:45', 1, 'CREDIT', '2015-09-16', 'INTEREST PAYMENT', '0.02', NULL, 1, 0, 2, '2015-09-17 10:13:46', 2, '2015-09-17 17:15:05'),
(365, '2015-09-17 10:13:45', 1, 'DEBIT', '2015-09-15', 'Online Transfer to CHK ...9570 transaction#: 4880457094 09/15', '75.00', NULL, 1, 0, 2, '2015-09-17 10:13:46', 2, '2015-09-17 17:14:14'),
(366, '2015-09-24 08:02:53', 2, 'DEBIT', '2015-09-21', 'ARCO T83551 COSTA MESA CA            066676  09/19', '10.42', NULL, 1, 0, 2, '2015-09-24 08:02:53', 2, '2015-09-24 15:06:43'),
(367, '2015-09-24 08:02:53', 2, 'DEBIT', '2015-09-21', 'ROSS STORES #179 TUSTIN CA           655258  09/20', '8.62', NULL, 1, 0, 2, '2015-09-24 08:02:53', 2, '2015-09-24 15:06:32'),
(368, '2015-09-24 08:02:53', 2, 'DEBIT', '2015-09-17', 'AMERINOC COM 877-805-6542 CA                 09/15', '9.95', NULL, 1, 0, 2, '2015-09-24 08:02:53', 2, '2015-09-24 15:04:47'),
(369, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-23', 'Online Payment 4859940019 To SOUTHERN CALIFORNIA GAS 09/23', '20.50', NULL, 1, 0, 2, '2015-09-24 08:03:13', 2, '2015-09-24 15:07:26'),
(370, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-23', 'OFFICE MAX/OFFI 13728 IRVINE CA      102437  09/23', '21.58', NULL, 1, 0, 2, '2015-09-24 08:03:13', 2, '2015-09-24 15:07:18'),
(371, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-22', 'TARGET        00012385 IRVINE CA             09/21', '18.98', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:07:11'),
(372, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'NEWPORT CREST MEDICA NEWPORT BEACH CA        09/17', '40.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:06:53'),
(373, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'ATM WITHDRAWAL                       008042  09/1913128 JAM', '100.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:06:24'),
(374, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '22.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:05:55'),
(375, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '18.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:05:49'),
(376, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'PONY EXPRESSO CAFE DEL MAR CA                09/19', '10.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:05:15'),
(377, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'Online Transfer to CHK ...9570 transaction#: 4889717746 09/21', '25.00', NULL, 1, 0, 2, '2015-09-24 08:03:14', 2, '2015-09-24 15:05:28'),
(378, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'PETSMART INC 1314 TUSTIN CA          254077  09/19', '41.98', NULL, 1, 0, 2, '2015-09-24 08:03:15', 2, '2015-09-24 15:05:34'),
(379, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-21', 'COSTCO GAS #1001 TUSTIN CA           096284  09/20', '31.11', NULL, 1, 0, 2, '2015-09-24 08:03:15', 2, '2015-09-24 15:05:42'),
(380, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-18', 'Online Payment 4808913626 To Memorial Health Services 09/18', '40.00', NULL, 1, 0, 2, '2015-09-24 08:03:15', 2, '2015-09-24 15:05:06'),
(381, '2015-09-24 08:03:13', 1, 'DEBIT', '2015-09-18', 'TRADER JOE''S #195 ALISO VIEJO CA     180923  09/18', '68.55', NULL, 1, 0, 2, '2015-09-24 08:03:15', 2, '2015-09-24 15:04:53'),
(382, '2015-09-24 08:03:13', 1, 'CREDIT', '2015-09-17', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1267.61', NULL, 1, 0, 2, '2015-09-24 08:03:15', 2, '2015-09-24 15:04:37'),
(383, '2015-10-03 10:17:49', 6, 'DEBIT', '2015-09-28', 'Online Transfer to CHK ...9657 transaction#: 4905455106 09/28', '1000.00', NULL, 1, 0, 2, '2015-10-03 10:17:49', 2, '2015-10-03 17:23:03'),
(384, '2015-10-03 10:18:02', 1, 'CHECK', '2015-10-01', 'CHECK 242 ', '500.00', '242', 1, 0, 2, '2015-10-03 10:18:02', 2, '2015-10-03 17:25:01'),
(385, '2015-10-03 10:18:02', 1, 'DSLIP', '2015-09-29', 'DEPOSIT  ID NUMBER 265785', '258.26', NULL, 1, 0, 2, '2015-10-03 10:18:02', 2, '2015-10-03 17:24:31'),
(386, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-29', 'TCA FASTRAK R 949-727-4800 CA                09/28', '30.00', NULL, 1, 0, 2, '2015-10-03 10:18:02', 2, '2015-10-03 17:23:11'),
(387, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-29', 'POSTAL ANNEX LAKE FOREST CA          406170  09/29', '9.95', NULL, 1, 0, 2, '2015-10-03 10:18:02', 2, '2015-10-03 17:23:31'),
(388, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-29', 'COSTCO WHSE #0122 TUSTIN CA          472844  09/29', '134.04', NULL, 1, 0, 2, '2015-10-03 10:18:02', 2, '2015-10-03 17:23:37'),
(389, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-29', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '85.00', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:23:53'),
(390, '2015-10-03 10:18:02', 1, 'CREDIT', '2015-09-28', 'Online Transfer from MMA ...0371 transaction#: 4905455106', '1000.00', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:22:43'),
(391, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'THE WATER BREWERY COSTA MESA CA              09/25', '51.41', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:22:22'),
(392, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'MIGUELS JR #20 COSTA MESA CA                 09/25', '7.54', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:22:10'),
(393, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'TARGET        00012385 IRVINE CA             09/25', '29.78', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:22:04'),
(394, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'ATM WITHDRAWAL                       009703  09/2631972 CAM', '140.00', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:21:55'),
(395, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'COSTCO GAS #1001 TUSTIN CA           051947  09/27', '34.26', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:21:48'),
(396, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'TARGET        00012385 IRVINE CA             09/27', '19.12', NULL, 1, 0, 2, '2015-10-03 10:18:03', 2, '2015-10-03 17:21:41'),
(397, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-28', 'Online Transfer to CHK ...9570 transaction#: 4905453004 09/28', '10.00', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:21:33'),
(398, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-25', 'JUICE IT UP COSTA MESA CA                    09/24', '10.50', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:21:15'),
(399, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-25', 'BARNESNOBLE 13712 Jamb Irvine CA     560007  09/25', '37.15', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:21:07'),
(400, '2015-10-03 10:18:02', 1, 'CHECK', '2015-09-25', 'CHECK 241 ', '902.93', '241', 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:20:38'),
(401, '2015-10-03 10:18:02', 1, 'CREDIT', '2015-09-24', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '1571.20', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:18:58'),
(402, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-24', 'Online Transfer to CHK ...9570 transaction#: 4897558868 09/24', '5.00', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:19:49'),
(403, '2015-10-03 10:18:02', 1, 'DEBIT', '2015-09-24', 'TRADER JOE''S # 047 HUNTINGTNBCH CA   299970  09/24', '60.44', NULL, 1, 0, 2, '2015-10-03 10:18:04', 2, '2015-10-03 17:20:02'),
(404, '2015-10-11 16:09:14', 2, 'DEBIT', '2015-10-05', 'RUBIO''S #011 TUSTIN CA                       10/04', '8.63', NULL, 1, 0, 2, '2015-10-11 16:09:14', 2, '2015-10-11 23:13:23'),
(405, '2015-10-11 16:09:14', 2, 'DEBIT', '2015-10-05', 'WHOLEFDS HTB 10 7881 HUNTINGTON BE CA258648  10/04', '6.85', NULL, 1, 0, 2, '2015-10-11 16:09:15', 2, '2015-10-11 23:14:33'),
(406, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', '35 FOR LIFE 714-485-2299 TX                  10/07', '28.40', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:46'),
(407, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', 'APL* ITUNES.COM/BILL 866-712-7753 CA         10/08', '0.99', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:34'),
(408, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', 'Online Payment 4901130932 To SOUTHERN CALIFORNIA EDISON 10/09', '76.01', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:53'),
(409, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', 'Online Payment 4920399432 To VERIZON WIRELESS 10/09', '69.36', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:28'),
(410, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', 'COSTCO GAS #1001 TUSTIN CA           048085  10/09', '35.20', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:22'),
(411, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-09', 'RALPHS 13321 JAMBOREE TUSTIN CA      463108  10/09', '48.34', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:14'),
(412, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-08', 'Online Payment 4906999435 To Cox Communications 10/08', '194.62', NULL, 1, 0, 2, '2015-10-11 16:09:57', 2, '2015-10-11 23:16:05'),
(413, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-08', 'Online Transfer to CHK ...9570 transaction#: 4928497722 10/08', '30.00', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:15:59'),
(414, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-07', 'JPMorgan Chase   Ext Trnsfr 4861396298      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:15:42'),
(415, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-06', 'HARBOR JUSTICE CENTE NEWPORT BEACH CA        10/05', '25.00', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:14:57'),
(416, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-06', 'Online Transfer to CHK ...9570 transaction#: 4924816941 10/06', '56.00', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:15:34'),
(417, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-06', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '4000.00', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:15:12'),
(418, '2015-10-11 16:09:57', 1, 'DSLIP', '2015-10-05', 'DEPOSIT  ID NUMBER 980267', '5000.00', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:12:18'),
(419, '2015-10-11 16:09:57', 1, 'DSLIP', '2015-10-05', 'REMOTE ONLINE DEPOSIT #          1', '100.59', '1', 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:12:02'),
(420, '2015-10-11 16:09:57', 1, 'CREDIT', '2015-10-05', 'ROBERT HALF INTE PAYROLL                    PPD ID: 1941648701', '902.93', NULL, 1, 0, 2, '2015-10-11 16:09:58', 2, '2015-10-11 23:11:29'),
(421, '2015-10-11 16:09:57', 1, 'CREDIT', '2015-10-05', 'BANK OF AMERICA  FndTrnsfr                  PPD ID: 2941721694', '585.00', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:11:11'),
(422, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', '35 FOR LIFE 714-485-2299 TX                  10/01', '129.53', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:14:24'),
(423, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'TARGET        00012385 IRVINE CA             10/03', '53.72', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:12:52'),
(424, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'Online Transfer to CHK ...9570 transaction#: 4920133088 10/05', '10.00', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:13:09'),
(425, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'CENTURY THEATRES 482 HUNTINGTN BCH CA        10/04', '42.50', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:13:17'),
(426, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'WHOLEFDS HTB 10 7881 HUNTINGTON BE CA936274  10/04', '24.62', NULL, 1, 0, 2, '2015-10-11 16:09:59', 2, '2015-10-11 23:14:11'),
(427, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'Online Transfer to CHK ...9570 transaction#: 4923101850 10/05', '109.00', NULL, 1, 0, 2, '2015-10-11 16:10:00', 2, '2015-10-11 23:14:05'),
(428, '2015-10-11 16:09:57', 1, 'DEBIT', '2015-10-05', 'Anacapa Apartmen WEB PMTS   0HNYG2          WEB ID: 1203874681', '2291.10', NULL, 1, 0, 2, '2015-10-11 16:10:00', 2, '2015-10-11 23:13:41'),
(429, '2015-10-17 08:43:45', 6, 'CREDIT', '2015-10-16', 'INTEREST PAYMENT', '0.01', NULL, 1, 0, 2, '2015-10-17 08:43:45', 2, '2015-10-17 15:46:28'),
(430, '2015-10-17 08:44:02', 2, 'DEBIT', '2015-10-16', 'BARNESNOBLE 13712 Jamb Irvine CA     122366  10/16', '5.81', NULL, 1, 0, 2, '2015-10-17 08:44:02', 2, '2015-10-17 15:46:36'),
(431, '2015-10-17 08:44:02', 2, 'CREDIT', '2015-10-15', 'Online Transfer from CHK ...9657 transaction#: 4941907310', '100.00', NULL, 1, 0, 2, '2015-10-17 08:44:02', 2, '2015-10-17 15:45:53'),
(432, '2015-10-17 08:44:02', 2, 'DEBIT', '2015-10-13', 'NETFLIX.COM NETFLIX.COM CA                   10/12', '7.99', NULL, 1, 0, 2, '2015-10-17 08:44:02', 2, '2015-10-17 15:44:59'),
(433, '2015-10-17 08:44:12', 1, 'CREDIT', '2015-10-16', 'MLS TECHNOLOGIES DIRDEP                     PPD ID: 1330914630', '4082.02', NULL, 1, 0, 2, '2015-10-17 08:44:12', 2, '2015-10-17 15:46:19'),
(434, '2015-10-17 08:44:12', 1, 'CREDIT', '2015-10-16', 'INTEREST PAYMENT', '0.02', NULL, 1, 0, 2, '2015-10-17 08:44:12', 2, '2015-10-17 15:45:59'),
(435, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-15', 'Online Transfer to CHK ...2339 transaction#: 4941907310 10/15', '100.00', NULL, 1, 0, 2, '2015-10-17 08:44:12', 2, '2015-10-17 15:45:42'),
(436, '2015-10-17 08:44:12', 1, 'DSLIP', '2015-10-13', 'DEPOSIT  ID NUMBER 228258', '225.00', NULL, 1, 0, 2, '2015-10-17 08:44:12', 2, '2015-10-17 15:45:29'),
(437, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'Online Transfer to CHK ...9570 transaction#: 4932803174 10/13', '245.00', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:44:38'),
(438, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'DOVER SADDLERY - L LAGUNA HILLS CA           10/10', '24.83', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:44:45'),
(439, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'TRADER JOE''S # 210 IRVINE CA         909893  10/10', '98.04', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:44:52'),
(440, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'THE HABIT-COSTA MESA #6 COSTA MESA CA        10/11', '29.05', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:45:06'),
(441, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'Online Transfer to CHK ...9570 transaction#: 4936153482 10/13', '20.00', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:45:22'),
(442, '2015-10-17 08:44:12', 1, 'DEBIT', '2015-10-13', 'ATM WITHDRAWAL                       009815  10/131455 BAKE', '120.00', NULL, 1, 0, 2, '2015-10-17 08:44:13', 2, '2015-10-17 15:45:14'),
(443, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-22', 'Online Payment 4924453736 To SOUTHERN CALIFORNIA GAS 10/22', '18.07', NULL, 1, 0, 2, '2015-10-24 20:38:28', 2, '2015-10-25 03:43:08'),
(444, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-22', 'COSTCO GAS #1001 TUSTIN CA           083292  10/22', '35.43', NULL, 1, 0, 2, '2015-10-24 20:38:28', 2, '2015-10-25 03:42:58'),
(445, '2015-10-24 20:38:28', 1, 'CREDIT', '2015-10-21', 'TAX PRODUCTS PE3 SBTPG LLC                  PPD ID: 3722260102', '208.02', NULL, 1, 0, 2, '2015-10-24 20:38:28', 2, '2015-10-25 03:42:51'),
(446, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-20', 'Online Payment 4808914580 To Memorial Health Services 10/20', '40.00', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:42:38'),
(447, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-20', 'RALPHS 21751 LAKE FORE LAKE FOREST CA342697  10/20', '7.98', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:42:26'),
(448, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-20', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '500.00', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:42:19'),
(449, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-20', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '250.00', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:42:00'),
(450, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-19', 'Online Transfer to MMA ...0371 transaction#: 4946800755 10/19', '500.00', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:39:46'),
(451, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-19', 'TRADER JOE''S # 197 TUSTIN CA         865646  10/17', '42.30', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:40:39'),
(452, '2015-10-24 20:38:28', 1, 'DEBIT', '2015-10-19', 'Online Transfer to CHK ...9570 transaction#: 4948925298 10/19', '100.00', NULL, 1, 0, 2, '2015-10-24 20:38:29', 2, '2015-10-25 03:40:31'),
(453, '2015-10-24 20:38:43', 6, 'CREDIT', '2015-10-19', 'Online Transfer from CHK ...9657 transaction#: 4946800755', '500.00', NULL, 1, 0, 2, '2015-10-24 20:38:43', 2, '2015-10-25 03:39:58'),
(454, '2015-10-24 20:38:57', 2, 'DEBIT', '2015-10-20', 'THE UPS STORE #0026 LAKE FOREST CA   057058  10/20', '50.00', NULL, 1, 0, 2, '2015-10-24 20:38:57', 2, '2015-10-25 03:41:03'),
(455, '2015-10-24 20:38:57', 2, 'DEBIT', '2015-10-19', 'AMERINOC COM 877-805-6542 CA                 10/15', '9.95', NULL, 1, 0, 2, '2015-10-24 20:38:57', 2, '2015-10-25 03:39:10'),
(456, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-29', 'MCC HOMEOWNERS GW 888-637-2176 CA            10/29', '125.00', NULL, 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:24:32'),
(457, '2015-10-30 22:21:28', 1, 'CHECK', '2015-10-28', 'CHECK 244 ', '866.75', '244', 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:24:14'),
(458, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-27', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           10/26', '40.00', NULL, 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:23:51'),
(459, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-27', 'TARGET        00012385 IRVINE CA             10/26', '117.41', NULL, 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:23:42'),
(460, '2015-10-30 22:21:28', 1, 'CHECK', '2015-10-27', 'CHECK 245 ', '600.00', '245', 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:23:21'),
(461, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-27', 'MERCURY CASUALTY PAYMENT                    PPD ID: 1952577343', '89.88', NULL, 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:23:33'),
(462, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-26', 'SQ *DAMIAN CHIROPRA LAGUNA HILLS CA          10/23', '40.00', NULL, 1, 0, 2, '2015-10-30 22:21:28', 2, '2015-10-31 05:22:36'),
(463, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-26', 'TRADER JOE''S # 197 TUSTIN CA                 10/24 Purchase $81.50 Cash Back $40.00', '121.50', NULL, 1, 0, 2, '2015-10-30 22:21:29', 2, '2015-10-31 05:22:17'),
(464, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-26', 'THREADNEEDLE EMBROIDERY CARLSBAD CA          10/25', '98.00', NULL, 1, 0, 2, '2015-10-30 22:21:29', 2, '2015-10-31 05:22:59'),
(465, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-26', 'SQ *ALEXA CATERING San Juan Capi CA          10/25', '12.50', NULL, 1, 0, 2, '2015-10-30 22:21:29', 2, '2015-10-31 05:22:24'),
(466, '2015-10-30 22:21:28', 1, 'DEBIT', '2015-10-26', 'SQ *ORANGE COUNTY HO San Juan Capi CA        10/25', '150.00', NULL, 1, 0, 2, '2015-10-30 22:21:29', 2, '2015-10-31 05:22:08'),
(467, '2015-10-30 00:00:00', 2, 'DEBIT', '2015-10-29', 'TEST', '11.00', NULL, 0, 1, 1, '2015-10-30 00:00:00', 1, '2015-11-07 17:30:03'),
(468, '2015-10-28 00:00:00', 1, 'DEBIT', '2015-10-26', 'TEST 2', '22.00', NULL, 0, 1, 1, '2015-10-30 00:00:00', 2, '2015-11-07 17:29:59'),
(469, '2015-11-05 18:19:08', 6, 'CREDIT', '2015-11-02', 'Online Transfer from CHK ...9657 transaction#: 4974068458', '500.00', NULL, 1, 0, 2, '2015-11-05 18:19:08', 2, '2015-11-06 02:21:44'),
(470, '2015-11-05 18:19:56', 2, 'DEBIT', '2015-11-03', 'MIGUELS JR 23 TUSTIN CA                      11/01', '16.17', NULL, 1, 0, 2, '2015-11-05 18:19:56', 2, '2015-11-06 02:20:30'),
(471, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-03', 'FID BKG SVC LLC  MONEYLINE                  PPD ID: 0368004600', '250.00', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:20:53'),
(472, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'PICK UP STIX 765 TUSTIN TUSTIN CA            10/29', '27.27', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:16'),
(473, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           10/30', '40.00', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:21:56'),
(474, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'Online Transfer to MMA ...0371 transaction#: 4974068458 11/02', '500.00', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:21:31'),
(475, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'COSTCO GAS #0454 IRVINE CA           098401  10/31', '33.15', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:33'),
(476, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'Online Payment 4976005868 To William Van Der Reis MD Inc 11/02', '60.00', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:09'),
(477, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'STEIN MART 355 13742 J Irvine CA     530788  11/01', '188.96', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:21:17'),
(478, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'Online Transfer to CHK ...9570 transaction#: 4978600070 11/02', '109.00', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:21:09'),
(479, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-11-02', 'Anacapa Apartmen WEB PMTS   KY67J2          WEB ID: 1203874681', '2287.21', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:26'),
(480, '2015-11-05 18:20:18', 1, 'CREDIT', '2015-10-30', 'MLS TECHNOLOGIES DIRDEP                     PPD ID: 1330914630', '4082.02', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:51'),
(481, '2015-11-05 18:20:18', 1, 'DEBIT', '2015-10-30', 'TRADER JOE''S # 210 IRVINE CA         154108  10/30', '46.82', NULL, 1, 0, 2, '2015-11-05 18:20:18', 2, '2015-11-06 02:22:59'),
(482, '2015-11-07 17:32:34', 2, 'DEBIT', '2015-11-06', '#06526 ALBERTSONS LAKE FOREST CA     232131  11/06', '8.36', NULL, 1, 0, 2, '2015-11-07 17:32:34', 2, '2015-11-08 01:34:17'),
(483, '2015-11-07 17:32:34', 2, 'DEBIT', '2015-11-03', 'MIGUELS JR 23 TUSTIN CA                      11/01', '16.17', NULL, 1, 0, 2, '2015-11-07 17:32:34', 2, '2015-11-08 01:38:17'),
(484, '2015-11-07 17:33:12', 1, 'DEBIT', '2015-11-06', 'WHICH WICH #354 TUSTIN CA                    11/05', '9.99', NULL, 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:36:37'),
(485, '2015-11-07 17:33:12', 1, 'DEBIT', '2015-11-06', 'WHICH WICH #354 TUSTIN CA                    11/05', '2.11', NULL, 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:37:07'),
(486, '2015-11-07 17:33:12', 1, 'DEBIT', '2015-11-06', 'Online Payment 4975824707 To Cox Communications 11/06', '194.61', NULL, 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:36:46'),
(487, '2015-11-07 17:33:12', 1, 'DEBIT', '2015-11-06', 'Online Transfer to CHK ...9570 transaction#: 4989069217 11/06', '10.00', NULL, 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:36:54'),
(488, '2015-11-07 17:33:12', 1, 'DEBIT', '2015-11-06', 'TRADER JOE''S # 197 TUSTIN CA         057208  11/06', '98.25', NULL, 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:37:18'),
(489, '2015-11-07 17:33:12', 1, 'CHECK', '2015-11-05', 'CHECK # 0243      USCIS PHOENIX    PAYMENT           ARC ID: 7001010303', '680.00', '243', 1, 0, 2, '2015-11-07 17:33:12', 2, '2015-11-08 01:37:51'),
(490, '2015-11-12 19:08:46', 2, 'DEBIT', '2015-11-09', 'REDHILL CARWASH TUSTIN CA                    11/07', '20.99', NULL, 1, 0, 2, '2015-11-12 19:08:46', 1, '2015-11-13 03:09:55'),
(491, '2015-11-12 19:08:46', 2, 'DEBIT', '2015-11-09', 'TARGET T-1238 Irvine CA              000801  11/08', '7.48', NULL, 1, 0, 2, '2015-11-12 19:08:46', 1, '2015-11-13 03:10:15'),
(492, '2015-11-12 19:09:25', 1, 'DEBIT', '2015-11-10', 'Online Payment 4975845782 To VERIZON WIRELESS 11/10', '69.66', NULL, 1, 0, 2, '2015-11-12 19:09:25', 1, '2015-11-13 03:10:33'),
(493, '2015-11-12 19:09:25', 1, 'DEBIT', '2015-11-09', 'SQ *DAMIAN CHIROPRA LAKE FOREST CA           11/06', '80.00', NULL, 1, 0, 2, '2015-11-12 19:09:25', 1, '2015-11-13 03:10:07'),
(494, '2015-11-12 19:09:25', 1, 'DEBIT', '2015-11-09', 'APL* ITUNES.COM/BILL 866-712-7753 CA         11/08', '0.99', NULL, 1, 0, 2, '2015-11-12 19:09:25', 1, '2015-11-13 03:09:36'),
(495, '2015-11-12 19:09:25', 1, 'DEBIT', '2015-11-09', 'COSTCO GAS #0454 IRVINE CA           003753  11/08', '24.65', NULL, 1, 0, 2, '2015-11-12 19:09:25', 1, '2015-11-13 03:09:45'),
(496, '2015-11-12 19:09:25', 1, 'DEBIT', '2015-11-09', 'JPMorgan Chase   Ext Trnsfr 4923689806      WEB ID: 9200502231', '333.33', NULL, 1, 0, 2, '2015-11-12 19:09:25', 1, '2015-11-13 03:10:25'),
(497, '2015-11-13 21:15:20', 2, 'CREDIT', '2015-11-12', 'Online Transfer from CHK ...9657 transaction#: 4999462858', '100.00', NULL, 1, 0, 2, '2015-11-13 21:15:20', 1, '2015-11-14 05:16:46'),
(498, '2015-11-13 21:15:20', 2, 'DEBIT', '2015-11-12', 'NETFLIX.COM NETFLIX.COM CA                   11/12', '7.99', NULL, 1, 0, 2, '2015-11-13 21:15:20', 1, '2015-11-14 05:15:59'),
(499, '2015-11-13 21:15:50', 1, 'DEBIT', '2015-11-12', 'Amazon.com AMZN.COM/BILL WA                  11/10', '35.63', NULL, 1, 0, 2, '2015-11-13 21:15:50', 1, '2015-11-14 05:16:14'),
(500, '2015-11-13 21:15:50', 1, 'DEBIT', '2015-11-12', 'BARNESNOBLE 81 Fortune Irvine CA     823787  11/11', '27.22', NULL, 1, 0, 2, '2015-11-13 21:15:50', 1, '2015-11-14 05:16:06'),
(501, '2015-11-13 21:15:50', 1, 'DEBIT', '2015-11-12', 'Online Payment 4964755141 To SOUTHERN CALIFORNIA EDISON 11/12', '38.19', NULL, 1, 0, 2, '2015-11-13 21:15:50', 1, '2015-11-14 05:16:20'),
(502, '2015-11-13 21:15:50', 1, 'DEBIT', '2015-11-12', 'Online Transfer to CHK ...2339 transaction#: 4999462858 11/12', '100.00', NULL, 1, 0, 2, '2015-11-13 21:15:50', 1, '2015-11-14 05:16:59'),
(503, '2015-11-13 21:15:50', 1, 'DEBIT', '2015-11-12', 'SPROUTS FARMERS MKT#25 TUSTIN CA     024608  11/12', '28.33', NULL, 1, 0, 2, '2015-11-13 21:15:50', 1, '2015-11-14 05:16:27');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(40) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `login` varchar(50) NOT NULL DEFAULT '',
  `pass` varchar(50) NOT NULL DEFAULT '',
  `user_role_id` int(11) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `activation_code` varchar(50) DEFAULT NULL,
  `forgotten_password_code` varchar(50) DEFAULT NULL,
  `last_session_id` varchar(32) DEFAULT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `joindate` date DEFAULT NULL,
  `expiredate` date DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `coName` varchar(100) DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `lastname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `handle` varchar(100) CHARACTER SET latin1 NOT NULL,
  `userDOB` date DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `phone` varchar(22) CHARACTER SET latin1 DEFAULT NULL,
  `phone2` varchar(22) CHARACTER SET latin1 DEFAULT NULL,
  `cellPhone` varchar(30) CHARACTER SET latin1 NOT NULL,
  `icq` varchar(22) CHARACTER SET latin1 DEFAULT NULL,
  `street1` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `street2` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `city` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `state` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `zip` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `ip_address`, `salt`, `login`, `pass`, `user_role_id`, `active`, `activation_code`, `forgotten_password_code`, `last_session_id`, `last_login`, `joindate`, `expiredate`, `updateDate`, `email`, `coName`, `firstname`, `lastname`, `handle`, `userDOB`, `gender`, `phone`, `phone2`, `cellPhone`, `icq`, `street1`, `street2`, `city`, `state`, `zip`, `is_deleted`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, NULL, NULL, 'admin', '7b1a8b1c3dc119e076b0377a237e1e73', 1, 1, NULL, NULL, '406103978bb2560b17329f0cfe8bb96a', 2015, NULL, NULL, NULL, 'markhambd@gmail.com', '', 'Brian', 'Markham', 'Admin', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, '0000-00-00 00:00:00', 0, '2015-11-16 01:03:29', 0),
(2, NULL, NULL, 'bmark', '7b1a8b1c3dc119e076b0377a237e1e73', 2, 1, '', '', '71109055ceb9b7d15a5cb84718ed7e5e', 2015, '2007-07-14', '0000-00-00', '0000-00-00', 'markhambd@gmail.com', '', 'Brian', 'Markham', 'Brian', '1969-12-31', NULL, '9998885000', '8887776666', '9497020934', NULL, '134 Montara Drive', '', 'Aliso Viejo', 'CA', '92656', 0, '0000-00-00 00:00:00', 2, '2015-11-16 02:21:55', 0),
(3, NULL, NULL, 'chris99', '8877c913c4bec66a1c4276a427b54f85', 2, 1, NULL, NULL, NULL, 2013, NULL, NULL, NULL, 'cdmarkham99@gmail.com', '', 'Christopher3', 'Markham', '', '0000-00-00', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, '0000-00-00 00:00:00', 2, '2015-11-09 21:42:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `roles` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `roles`, `is_deleted`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, '{"0":"user","1":"admin"}', 0, '2015-05-21 15:15:00', 2, '2015-05-22 15:24:39', 2),
(2, '{"0":"user"}', 0, '2015-05-21 15:15:00', 2, '2015-11-09 21:56:27', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_session`
--

CREATE TABLE `user_session` (
  `id` varchar(32) NOT NULL COMMENT 'session id',
  `user_id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(32) NOT NULL,
  `http_referrer` varchar(150) NOT NULL,
  `request_time` datetime NOT NULL,
  `expire` datetime NOT NULL COMMENT 'time when session expires',
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_session`
--

INSERT INTO `user_session` (`id`, `user_id`, `ip_address`, `http_referrer`, `request_time`, `expire`, `data`) VALUES
('', 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"aaa":"123456"}'),
('0033fd2e8c60e662e8596f53e75a3369', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:01:56', '2015-06-08 07:31:58', NULL),
('00637f20cc138e750d7aeba042ba5c9f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-19 09:15:24', '2015-06-19 09:55:41', NULL),
('0111bcace6bfdae8fad4f317f044ee5a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-27 09:02:39', '2015-09-27 10:20:23', NULL),
('01a655e74f4bc9d4c3e3fd4f8a0f0ed4', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:35:29', '2015-11-09 23:37:55', NULL),
('01df5598a52a2f4c705a9547e83235b5', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-13 12:10:05', '2015-08-13 13:17:37', NULL),
('022411740284ac5c60b0505b468afc0e', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-27 17:50:36', '2015-05-27 19:05:40', NULL),
('024069e15b6bc010f0754ad00985242b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-13 16:48:08', '2015-06-13 18:46:58', NULL),
('028c13638b9bc0495968fc618b0a117e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-17 20:19:45', '2015-07-17 21:38:02', NULL),
('02d14dc86a9896fde6811ca9583fdb1f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:55:36', '2015-11-09 23:25:36', NULL),
('03ef353646d3b09fecd5bb07f792b9b6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 11:17:12', '2015-09-16 12:05:07', NULL),
('045e8d8741a32b7c1b813c2695932a2a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-04 20:31:25', '2015-11-04 21:03:24', NULL),
('0592faef2a9f2c534bdd697e4b054238', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 14:24:50', '2015-06-08 14:55:06', NULL),
('06eedd9f7c24437805c957242f567e11', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-05 01:36:53', '2015-11-05 02:23:48', NULL),
('07a8283e405cd57e606f8bad1e5fe1b3', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-25 07:49:10', '2015-05-25 10:46:32', NULL),
('082c53574e4ffdfa9186249746054fa8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:21:01', '2015-09-03 16:21:28', NULL),
('0a16f582dbc49166e621988a34f51a29', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-10 18:16:02', '2015-11-10 19:11:58', NULL),
('0a1c329093d1e28a60e42d79f803f9e3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-09 08:27:58', '2015-06-09 08:30:39', NULL),
('0addbf3deb5afc4dc352a0fe3c2ae9a2', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-29 16:10:18', '2015-05-29 17:41:48', NULL),
('0da089f392c176be55318ee15753671d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:11:59', '2015-11-09 23:21:56', NULL),
('10899baf0ea3d4942931663bf1a5dfa3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-22 07:40:30', '2015-08-22 08:32:11', NULL),
('11184b0f5ae10784baf523bc74f4a6c6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-24 11:45:07', '2015-06-24 12:24:49', NULL),
('1250e6fcb8a37faac0bc862d094e60cb', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:30:29', '2015-09-03 17:00:34', NULL),
('13d8de27e2da81553ff6ab1d73ba4e39', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-16 10:53:16', '2015-07-16 12:21:15', NULL),
('1501fe13761af4f32b81dc81949d909b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:15:25', '2015-09-03 16:20:51', NULL),
('1857fa9be689449de18f99d1226a3c75', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:43:51', '2015-09-03 15:43:58', NULL),
('18ad58ebf28510f7ebda08f496ca0155', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-26 21:27:55', '2015-09-26 23:04:33', NULL),
('18c4c41bb794cef37e4582475f220279', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-23 09:40:21', '2015-09-23 10:44:30', NULL),
('199780e2d1bc6e4ab0bf2725cc4f8f41', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-15 09:24:26', '2015-09-15 10:51:59', NULL),
('1a04321c5a123e24e8276fd6325a2ebd', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-24 12:21:14', '2015-09-24 14:33:34', NULL),
('1b3b82a982526b14b0ea00b0c6a0aabe', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-15 13:08:53', '2015-06-15 13:39:42', NULL),
('1b656755b967ea3bea26a99903f142de', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-31 16:51:50', '2015-10-31 17:28:55', NULL),
('1cb4635cc8c4b49ecf8dd9ba726dcb1d', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-26 11:31:07', '2015-05-26 12:02:52', NULL),
('1d2d396fee2a2c67ca015d24ee7da0e9', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-28 16:18:10', '2015-07-28 16:48:13', NULL),
('1d5c527b76f01f17730ae09fc0cbde27', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-06 07:38:12', '2015-09-06 09:16:57', NULL),
('1e3fe7d0a62af01ac7c2755721b952d0', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-10 09:25:55', '2015-09-10 10:28:28', NULL),
('1ff180dbf52c9bfbfb69bb81c746e18e', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-10 01:47:33', '2015-11-10 02:50:57', NULL),
('218d23587a38b29f10d13fbfec835d5e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-27 08:35:59', '2015-09-27 09:06:00', NULL),
('21c2a2475a599b9bd777ce5abd0ec905', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:09:05', '2015-06-08 07:39:05', NULL),
('24419aa9bcb0e090f42489153fa9d7e5', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-24 10:09:13', '2015-09-24 10:28:46', NULL),
('2443c8c7d6c250b82d5409ee972a77d3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 14:19:12', '2015-06-08 14:20:00', NULL),
('2507736b8563af6f53ab3a66f8e1ff7c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-17 18:21:44', '2015-06-17 18:51:48', NULL),
('25c72c6cefc985b2ef82cdc83519a8e8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:26:46', '2015-09-03 16:26:48', NULL),
('2731507b396e6f3328b42bc55ad98152', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-30 08:33:35', '2015-05-30 09:14:58', NULL),
('287d9430b013285cfc2c500499d187ed', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-22 16:06:36', '2015-09-22 17:34:43', NULL),
('297c5332be8d0d39bb1e963aa4e5e276', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-17 16:46:13', '2015-07-17 17:20:48', NULL),
('29b97812705e0e8b6309c3086d54113b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-26 23:12:41', '2015-10-27 00:55:22', NULL),
('29d2b3c14f5d8a43be413b340f4c6558', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-18 18:24:17', '2015-10-18 18:54:58', NULL),
('2a7b66614527eff0763f7b7c45b44b27', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-24 11:43:14', '2015-06-24 11:44:47', NULL),
('2ae41bf8d024711b3ffc3f8e463cda04', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-04 22:29:33', '2015-11-04 23:05:34', NULL),
('2b7502fc4782f6436b18b896ea4434d7', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:21:33', '2015-09-03 16:21:37', NULL),
('2b8aa56fd7dad16db1b9e77c2869f7c9', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-02 08:37:21', '2015-06-02 09:24:30', NULL),
('2d6a3603b1e2e29628028006c481dd56', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-14 11:56:48', '2015-07-14 12:28:32', NULL),
('2f6071ddbb29e6904ee7d2e895faaaad', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-11 16:05:31', '2015-10-11 17:00:30', NULL),
('30d3b24b06b64ca1523d8ddf26992736', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-21 09:42:03', '2015-06-21 10:18:25', NULL),
('32f9413a98aefd821fa6d82e2e395607', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-03 17:40:02', '2015-11-03 19:02:38', NULL),
('3341da5010393ca704dbdc8c878c5fd4', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-17 20:11:40', '2015-10-17 21:28:07', NULL),
('34b1679584b621e276ec5b83ac98dd5d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-31 08:11:38', '2015-07-31 08:46:01', NULL),
('353f67e643f19452ca423b146bcca114', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:10:33', '2015-06-08 07:40:33', NULL),
('35d0eafaa3c913a9783d3fdf0a4e08be', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-18 15:27:37', '2015-09-18 16:12:51', NULL),
('368b59a5824b46e1d232ffce7c985a3d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:13:42', '2015-09-03 16:14:08', NULL),
('36b3ca23f15ca322e3e274d8d7ac8c08', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-24 15:35:00', '2015-08-24 16:05:00', NULL),
('3714bce0c3dcfdbaf0697e4e1b58e4be', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-15 07:51:17', '2015-09-15 08:57:10', NULL),
('3748ba6102a91071aade39c4c57cdd66', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:47:23', '2015-09-03 15:47:39', NULL),
('375a61179dd0d148e958291237e7871c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-04 08:18:30', '2015-07-04 09:07:32', NULL),
('38d4f59b974c86f49caa3087995541d6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 13:14:51', '2015-09-03 14:27:27', NULL),
('390870da25f85ec451b9f43be1d55544', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:26:49', '2015-09-03 16:28:19', NULL),
('39549cc7d470db31effd1541fcc97194', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-17 14:54:58', '2015-07-17 16:03:30', NULL),
('397f74b99a122d0107b0c715add4afc2', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-09 21:43:40', '2015-10-09 22:42:15', NULL),
('3c1591206460d776db20e0c857728343', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-12 16:53:23', '2015-09-12 17:23:41', NULL),
('3c2610f1eefe79011641b9268450250b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-25 12:51:32', '2015-06-25 14:28:53', NULL),
('401cc8cc4eab6293e7c1d08461b02ee4', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-11 21:01:40', '2015-06-11 21:56:26', NULL),
('406103978bb2560b17329f0cfe8bb96a', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 17:03:28', '2015-11-15 18:01:20', NULL),
('41b6e52eb123a6e69ca35e902d52ccf0', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 06:50:55', '2015-06-08 07:30:29', NULL),
('4304a7b589e2d2022bbb679273110568', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-03 19:12:20', '2015-07-03 20:30:42', NULL),
('449e2487f93ed600a800c3c849038fe7', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-13 08:08:01', '2015-09-13 09:03:02', NULL),
('46e91a8a4238a32fc46fbe9465e2ffb4', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-24 21:18:42', '2015-05-24 21:35:18', NULL),
('46eae70acb2a157c32bfcf4e0f9c2af1', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-03 09:34:29', '2015-06-03 10:05:29', NULL),
('47815753a41ad21daf1fbafc1e9e24bf', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 16:07:17', '2015-06-01 16:07:55', NULL),
('48b2c35321cd81d7d1653901c2607ce5', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-05 18:16:21', '2015-11-05 19:34:05', NULL),
('4990ae1246fdf48b7d010c05576f8d47', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 13:52:08', '2015-09-16 14:24:26', NULL),
('4a0ba7f6a1b96e8ca1a3ae2eb5b0ec01', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-14 11:54:22', '2015-08-14 11:54:29', NULL),
('4a6796b4786e6d4e52025c3a0ed494de', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-17 11:01:13', '2015-09-17 11:34:07', NULL),
('4dfb87fb77263cb65c748549a25099e1', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:54:30', '2015-11-09 23:24:30', NULL),
('4e0c828c5d97d40d266f374c198a32f5', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-02 14:21:49', '2015-09-02 16:44:18', NULL),
('4f01bbc1401ffeace15260ec0ab0e8cb', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-10 16:06:19', '2015-09-10 17:51:41', NULL),
('4f1eed0bdcce12f323f8e4f40d2083d8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:47:45', '2015-09-03 15:49:01', NULL),
('5026453b5b6703b0c38023ea5d96fbf2', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-27 12:38:00', '2015-07-27 13:08:48', NULL),
('5048df925037788186d3a8aa51a12b2c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-13 05:01:42', '2015-06-13 06:29:07', NULL),
('51924dcf99c386f4628bb09114dc96ea', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:37:56', '2015-11-09 23:38:25', NULL),
('531adc9b2cdad1b16ddbea821e1a7edb', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-17 12:45:13', '2015-09-17 13:26:02', NULL),
('53e2339b23728b316ff8bd52b605fe55', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-04 09:45:01', '2015-09-04 10:49:59', NULL),
('540d85cc73d560ad45c7702cbb9590ea', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:24:47', '2015-09-03 16:24:50', NULL),
('5458c99a53775c52e7d85c4dfe945c8b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:56:42', '2015-11-09 23:04:34', NULL),
('54df2617b39f31fff6882147e6de8076', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-01 16:22:39', '2015-09-01 17:01:29', NULL),
('56246436cc79e5d21539f2c031e2416d', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-29 07:55:09', '2015-05-29 10:15:34', NULL),
('56593dbdb924addce986392b867087cc', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-11 13:40:23', '2015-09-11 14:24:24', NULL),
('5697bac5d1cebfc00207e391460a0be9', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-14 18:48:24', '2015-11-14 22:09:16', NULL),
('57a4f9dc7317460f76f70645f7bfb546', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-24 10:28:50', '2015-09-24 11:54:09', NULL),
('58c020cef4f14d5ff901af6dd961d971', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-23 10:10:39', '2015-06-23 10:50:21', NULL),
('5ab27c6e3870e521d5762ad031458162', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:21:40', '2015-09-03 16:24:46', NULL),
('5adfdf02791848b7bfa84d8251b30039', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-22 16:41:23', '2015-06-22 17:51:28', NULL),
('5b5b2d23f28420e053bbc0e217f70f72', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-25 14:29:33', '2015-05-25 17:49:20', NULL),
('5e4f8a6358bc0a24e6bb661323894961', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:24:53', '2015-09-03 16:26:44', NULL),
('5fd7567007e67b4fd162ffbde6d1f31f', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 08:11:48', '2015-06-01 08:11:51', NULL),
('61301b079051ccf6aa2d8d04ec0c679f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-01 16:10:24', '2015-11-01 16:40:24', NULL),
('61b69a66e52d92f98ce3f9980cfff2f3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-08 16:54:32', '2015-09-08 17:24:35', NULL),
('61da2a8f4ebccfe1f4042b9fba796e88', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:51:21', '2015-11-09 23:21:21', NULL),
('625834490cb48355759d5d43c97531e8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-17 11:45:17', '2015-06-17 13:18:13', NULL),
('655a6d921d40003fe17dd3b2a0bd0572', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-08 19:16:13', '2015-11-08 20:22:14', NULL),
('6752fbe84071f4c74e8b461682b34275', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-01 11:41:32', '2015-07-01 12:18:37', NULL),
('6a004ac0b908411fcdbe39d28921a280', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-14 17:33:36', '2015-07-14 18:16:09', NULL),
('6aea7f97e60cd0135c4d2f37f3cf4878', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-10 01:42:18', '2015-11-10 01:42:26', NULL),
('6b061874b27855d3136c4b7326a397f6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-16 16:22:10', '2015-06-16 17:08:46', NULL),
('6c12565eb2e0508062e6dad74a0ea97e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-18 11:02:08', '2015-10-18 13:41:24', NULL),
('6d4e3121169acb4f834fcd3d51fa104d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-01 18:24:18', '2015-11-01 18:56:00', NULL),
('6e8c278e418729ea7bb8230b58b7a32b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:45:53', '2015-09-03 15:47:08', NULL),
('6fb3d6e2631d9d43cb72fa0297b919c9', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-26 16:11:22', '2015-05-26 18:01:16', NULL),
('71109055ceb9b7d15a5cb84718ed7e5e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:21:55', '2015-11-15 18:56:19', NULL),
('727dafc8f4a90b71ec6110440100048a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-29 08:52:51', '2015-08-29 09:51:12', NULL),
('728c46df3128b6d0405e93db28999cb7', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-12 08:23:44', '2015-06-12 08:53:48', NULL),
('72a2255fa7715df2e8100a9a73e5381a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-10 10:25:05', '2015-10-10 12:03:16', NULL),
('7369653c17efd4848c5a6015c5744da4', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-11 07:52:12', '2015-06-11 08:22:26', NULL),
('746510d6a74d99f8e7fd74f9f166ff58', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-03 14:28:16', '2015-06-03 15:08:04', NULL),
('747c9b5362049a8062f88ff4debe4164', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:21:34', '2015-11-15 18:51:34', NULL),
('74afb25677e0e838c1134debf10b089e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 14:40:12', '2015-09-03 15:43:49', NULL),
('79eeed95f58459634fb3bc8b0995f4fa', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-26 18:07:56', '2015-10-26 18:15:12', NULL),
('7ada317a8d0cb69c7cd2065a22c2e593', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-21 08:52:44', '2015-09-21 10:01:18', NULL),
('7c31e3d2d9a6b1950db39f618c794573', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-10 01:22:14', '2015-11-10 01:39:32', NULL),
('7dd938c85489659b4d5673f8e835a094', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:12:40', '2015-09-03 16:13:40', NULL),
('7fa094478636416d92ae183a7087b34e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:04:44', '2015-06-08 07:34:46', NULL),
('7fa435c285c30a6c3b75167b9236c0ae', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-10 07:57:43', '2015-06-10 09:22:14', NULL),
('80d49edc2414b08e8736dd93d8666dca', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:22:14', '2015-11-09 23:34:05', NULL),
('8160f3f3ed46bacec6724a84d980e781', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-16 13:35:56', '2015-07-16 14:29:18', NULL),
('8315b54dc1308fe74c0e52193359905e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-21 16:17:54', '2015-09-21 17:27:20', NULL),
('8339baf2ed28dae44f6b41fce0e9b5cd', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-14 08:24:20', '2015-07-14 09:23:34', NULL),
('84c89cdda7d321933e479f3acb343875', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-04 10:10:41', '2015-10-04 11:29:59', NULL),
('856a709e30e8e8c5242b987abe4ec92f', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:38:26', '2015-11-10 01:22:09', NULL),
('8622f02b570eb7a8d187ea183e175ce4', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-01 16:48:26', '2015-11-01 18:08:26', NULL),
('862dde67683c07926489d5ecdcd078fc', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-11 14:59:50', '2015-10-11 15:45:06', NULL),
('86652ce1258f72bdb3844761154c0de6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-24 07:18:47', '2015-09-24 09:19:08', NULL),
('86b7ee63ab24de4748d954a088b03281', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:42:55', '2015-11-09 22:43:58', NULL),
('86e7e06d061535ca23c69f642d217941', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-25 07:48:45', '2015-05-25 07:49:07', NULL),
('87d94b2eaf456c80e77b77ce9635761c', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-24 21:35:46', '2015-05-24 22:12:05', NULL),
('892564c94931aaf313ac360485799828', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:05:02', '2015-11-15 18:35:55', NULL),
('8bfc94b10c01b059ec89c15556676742', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:11:37', '2015-09-03 16:12:37', NULL),
('8c841e3385935cf489bcdec12c6729e9', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 08:11:35', '2015-06-01 08:11:45', NULL),
('8d3d7b872869e9c504a76024427ddd54', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:15:36', '2015-06-08 08:35:53', NULL),
('902d85e43fcfab6235eaf7c0f5b0cbc8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:11:06', '2015-06-08 07:12:09', NULL),
('904731081d3039e92faaf3f5739a4052', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-10 14:07:06', '2015-09-10 14:39:54', NULL),
('929a386520bd89252e1a3800b70bb6fc', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-10 07:43:38', '2015-10-10 09:00:00', NULL),
('92df8a8302af31b55ca82d72bc856e5f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-19 09:58:55', '2015-06-19 10:29:25', NULL),
('932f149ca4c18784f2c6deeeb9d17b02', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-28 19:13:22', '2015-09-28 19:18:11', NULL),
('9346a21ea7e66ebfa5df5b623470d938', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-30 21:26:07', '2015-10-30 21:56:45', NULL),
('93ad422e5b4bea170f2881e6aba3ad80', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:03:27', '2015-11-15 18:04:58', NULL),
('94868eb1b29a09fed0dc9c9366f660cf', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 09:38:36', '2015-09-03 10:37:12', NULL),
('957184a8aa492be5da0926c1725fff65', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-28 07:46:48', '2015-05-28 09:04:03', NULL),
('9627e6d72de682a475a772817c12df7a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:47:11', '2015-09-03 15:47:20', NULL),
('96ee54314bce89fa46dfbbbd2c406a13', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-10 11:38:03', '2015-06-10 12:37:12', NULL),
('97a0a20d1d0a9131d461f955751af45d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-09 12:08:29', '2015-07-09 12:52:13', NULL),
('98d50479b41cd1d4a773674791bdbf41', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-09 08:30:44', '2015-06-09 09:29:02', NULL),
('9946034ff39603af039d8884ccf02548', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-07 17:30:23', '2015-11-07 19:14:21', NULL),
('9a4316d85defce4dccdcf4e57fd6c47d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-18 17:30:09', '2015-10-18 17:47:43', NULL),
('9a57148c0c66c3fc336ad7075d4356b8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 08:41:48', '2015-06-08 09:16:30', NULL),
('9e63d37b420be9fc562f43ad615c0267', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-13 23:49:41', '2015-11-14 02:33:12', '{"aaa":"123456"}'),
('9f64150eff634afe50e18e2576e89b3f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-28 16:26:50', '2015-09-28 17:28:00', NULL),
('a1b55e9b3b2fbfac1439ab0c86694ad2', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-23 14:11:08', '2015-09-23 14:41:11', NULL),
('a1d4f72251bf6bc985adfaa4c8d333e2', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-05 09:42:14', '2015-09-05 10:12:24', NULL),
('a23cbb5d98077f4ab75ffb92d2711c9f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-01 12:32:39', '2015-07-01 13:08:28', NULL),
('a40cfd3b12c12ab3e4f19ffaa97b07b0', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 11:18:57', '2015-06-08 11:19:07', NULL),
('a4be28c991750cfde1dfafad149b1648', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-15 11:31:39', '2015-09-15 12:01:41', NULL),
('a548b0396916f53846334c955a23a02f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-03 09:08:58', '2015-10-03 11:21:29', NULL),
('a5b05d37403931fea740ea81ea6a1d44', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 15:44:07', '2015-09-03 15:45:50', NULL),
('a6dcf4ad4afc6f0a4929550190346197', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-03 13:23:19', '2015-07-03 14:30:52', NULL),
('a75817406987a03312d21b06bf048ec1', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-02 22:54:09', '2015-11-03 02:29:59', NULL),
('a8fa1971983fd6aaff7e27761d8dd668', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-31 14:36:05', '2015-10-31 16:27:10', NULL),
('a9aae22f28e6bd1f4ce7f5bc937c6423', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-03 08:30:20', '2015-06-03 09:07:22', NULL),
('aa3dd86cf8438ca5a0efafb7931c48b9', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-31 08:44:52', '2015-05-31 08:46:25', NULL),
('add89677996f706d5b42a6ec7b847298', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:51:44', '2015-11-09 23:21:44', NULL),
('afc8b37f9fa5fa551d615100c17af741', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-16 15:13:26', '2015-06-16 16:04:00', NULL),
('b0035fbc1fb46a04050668126b95e4a4', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-26 22:14:18', '2015-10-26 22:54:51', NULL),
('b45e97927bc8b8634ad69a5bf262ed80', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-10 01:39:39', '2015-11-10 01:41:38', NULL),
('b748531ec273bf000eb13001d1755613', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-10 10:23:15', '2015-06-10 10:53:16', NULL),
('b7ac61b6e5af8c89d2ea62ab860bb41d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:28:21', '2015-09-03 16:28:25', NULL),
('b824b0373a1f0a9c03d0aca40bde69c1', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 08:13:20', '2015-06-01 10:00:31', NULL),
('b83dcf32aab2f071f47ff4185356d831', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-07 19:31:48', '2015-11-07 20:36:02', NULL),
('b8b3fc79316e5423d2f95ee118fea544', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-17 13:30:48', '2015-10-17 16:12:52', NULL),
('b8eabd5ca4c8bd973ed5fb7aa560b184', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-28 14:26:47', '2015-09-28 14:57:02', NULL),
('bc352ba389e30ddd5030bfe5d39d2d0b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:20:55', '2015-09-03 16:20:59', NULL),
('bccff53d3812578dc631e7fe0cef90d2', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-26 08:50:39', '2015-05-26 11:30:31', NULL),
('be18300ea89be6b46dcbd84dac4a36f5', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-18 17:47:44', '2015-10-18 18:20:11', NULL),
('bfa9cda47b3bf93c8de60a91c47f4920', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-26 20:03:44', '2015-10-26 20:57:11', NULL),
('c22f86943aa52b190edbfb50d87faa5d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-24 20:36:51', '2015-10-24 21:33:00', NULL),
('c2e85d6f80046b08700df6a6d21e643b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-16 16:44:19', '2015-07-16 17:46:03', NULL),
('c35fa5a34c3ae1c78d1833c22ec9cd54', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:22:03', '2015-11-09 23:22:08', NULL),
('c47fbaeab6692c761b5b1333c8a22dff', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-12 19:07:15', '2015-11-12 19:57:02', NULL),
('c4cd6c48bd32da4b09c9e240ef1fdb84', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-13 21:13:41', '2015-11-13 22:04:32', NULL),
('c56ac6ff0c3a4c42cdac7a246a3823a6', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 16:07:58', '2015-06-01 18:10:48', NULL),
('c58951d819cdb9cc6144d3ebe5db390a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:01:25', '2015-11-15 18:03:20', NULL),
('c664ee4d614e2fb848f3f748237cda1b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-25 14:31:08', '2015-09-25 17:26:51', NULL),
('c6e11e1383e9ffb7415940bf3f0a4c02', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-02 10:59:38', '2015-08-02 11:00:19', NULL),
('c78d3add7e277217b549eae2bf8d2619', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-17 14:23:34', '2015-06-17 16:23:47', NULL),
('c7d5454713dd29310a09cd0208869cee', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:07:44', '2015-11-15 18:21:25', NULL),
('c961e00bf28f64cf0f7f77b8ac389d47', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:07:09', '2015-11-15 18:07:39', NULL),
('c965d9bd78f3b1b8d56700f210dc8741', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-30 14:04:29', '2015-07-30 15:44:28', NULL),
('cb20dee8fb2bcb29ff8123af7f248f23', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-31 08:46:51', '2015-05-31 08:47:06', NULL),
('cb2ffd3657987648ae56ae721861c374', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 13:04:41', '2015-06-08 13:45:21', NULL),
('ccfefe4d0430d389f2312aa993b47e88', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-04 19:34:28', '2015-11-04 20:26:29', NULL),
('cdd9cf377dfe5cd7ea8ec1132a939835', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-24 17:47:46', '2015-05-24 18:34:20', NULL),
('ce34bd261689be9eac44f2a75cd30fe4', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-31 08:48:34', '2015-05-31 10:40:10', NULL),
('ce67c02930dfcb20e77f557eab9cae80', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-14 07:50:35', '2015-08-14 08:20:38', NULL),
('ce74bc9ae270e3eeb73a17c5de417f2c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 12:47:59', '2015-09-16 13:35:03', NULL),
('cffa823e6af521ed847b53cb282c061b', 2, '127.0.0.1', '', '2015-06-08 07:14:36', '2015-06-08 07:14:57', NULL),
('d0ca916b5e7582aa1eb6e32a0017e796', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:07:45', '2015-11-09 23:11:53', NULL),
('d14e3908b572dc63371fe73e51427a8e', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-23 10:51:07', '2015-09-23 12:57:30', NULL),
('d2495b693ba2799c3812242f18752bf7', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-27 08:00:05', '2015-05-27 09:29:23', NULL),
('d2715ac0f609ccd1c7afbb5040d17e1a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-07 11:40:20', '2015-06-07 12:10:26', NULL),
('d2d0959b5db4ed52d2a326b7409ad4ae', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-17 08:19:25', '2015-07-17 09:54:05', NULL),
('d3a59648a5f1bd0ddd0b99c50d9cd2c1', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-31 09:05:35', '2015-08-31 09:37:15', NULL),
('d4c60f544537069ca2623f27cfa7a6f8', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-24 11:21:00', '2015-06-24 11:24:58', NULL),
('d5728bae0e9bc8987ea1b7404260344c', 2, '127.0.0.1', 'http://budget.loc/', '2015-06-01 12:59:33', '2015-06-01 14:29:35', NULL),
('d69f1626c904d5e59be8301c0594986a', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-28 10:19:02', '2015-05-28 12:16:38', NULL),
('d6dfb0e438c4ecffd479678500be8957', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:54:04', '2015-11-09 22:54:24', NULL),
('d7317d83509ef14449313d74f655142e', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-25 10:46:34', '2015-05-25 10:49:38', NULL),
('d7c856ea3826165445ff4a0af432d2af', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-12 22:33:26', '2015-11-13 00:56:49', NULL),
('d7d71ab4412c42b51db4de60d34f7071', 1, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 23:34:06', '2015-11-09 23:35:27', NULL),
('d82323546dc6484e3823f07e26ce4dc1', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-26 21:34:33', '2015-10-26 22:12:30', NULL),
('d8754751b3a34c2b7a87ebb3f4ca60b3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 09:24:04', '2015-09-16 11:02:51', NULL),
('dc0ba2feb4a9bafd4d0863ef65fd3b64', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-11 12:43:30', '2015-09-11 13:27:01', NULL),
('dc526201ff5ec36726b89aa1ddf848fc', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-24 17:47:03', '2015-05-24 17:47:27', NULL),
('dc5da7d7e51133deb7b1aa2521ecc67c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-17 08:26:46', '2015-10-17 09:54:37', NULL),
('dca46e860841c2c4882fdd1ebe909331', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:14:09', '2015-09-03 16:15:22', NULL),
('dce7d731200ccab753d723eebbc68580', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-20 08:27:52', '2015-08-20 09:56:59', NULL),
('df4ca30424551665c8f62d9418123661', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-24 15:34:43', '2015-08-24 15:34:56', NULL),
('dfd2a9978c005e346ce015d550230c6d', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-31 08:47:08', '2015-05-31 08:48:19', NULL),
('e029d8b5512257442e8dd4b43ad122ca', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:09:46', '2015-09-03 16:11:34', NULL),
('e04f00b03e5d6d378c811781088ed680', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-03 15:54:15', '2015-06-03 16:25:47', NULL),
('e1298026f48b10aecfed42cca92ace7c', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-07 10:10:04', '2015-06-07 10:40:05', NULL),
('e13ef8daf01183b45705445489d9938a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-18 13:47:36', '2015-09-18 14:17:45', NULL),
('e31e2ff68112d408aff0a3721cf522e3', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 11:26:39', '2015-06-08 12:16:08', NULL),
('e355bc097244c434acb526f88f56dac9', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-17 08:23:20', '2015-09-17 09:14:19', NULL),
('e3fc4a01c010a81b0e12014eb8dc47e6', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 12:07:22', '2015-09-16 12:44:58', NULL),
('e49a3b3231f437f489cc134e65eee862', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-14 13:35:19', '2015-09-14 14:05:51', NULL),
('e7b4af73ed5eb02c53be574cff7d674b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-24 11:25:42', '2015-06-24 11:43:08', NULL),
('e7f5bb7908c2f3fa0c8db35dcd6b5530', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:52:15', '2015-11-09 22:53:57', NULL),
('e867ec24778cd7890d67e5bdc18ebc3f', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-01 09:12:53', '2015-08-01 09:46:03', NULL),
('e8dbd114cec60b3fd568b5cc1b67d667', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-04 13:57:12', '2015-06-04 14:27:14', NULL),
('e91944e02d2ea263026cea231f98c469', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-14 10:15:13', '2015-07-14 11:56:21', NULL),
('eabb5917ff07d52bd2afcfc8a731a716', 2, '127.0.0.1', 'http://budget.loc/', '2015-05-30 13:16:30', '2015-05-30 14:08:20', NULL),
('eb56fd215eaae372ef07b180c6067660', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-03 16:09:39', '2015-09-03 16:09:44', NULL),
('ec2f75d0c3453ac1aa6aa6484d083d2d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-15 18:05:58', '2015-11-15 18:07:04', NULL),
('ece598122ad7b01da1389a171aad7bfb', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 11:05:57', '2015-06-08 11:18:30', NULL),
('edd8f1dc07709b5a4588ffd440ffb366', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-11-09 22:44:05', '2015-11-09 22:51:18', NULL),
('ee9370575ae3696f82f0196daa875b06', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-09 11:12:00', '2015-07-09 11:53:46', NULL),
('f245306506f0215654e67329da87fc1d', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-16 14:25:37', '2015-09-16 16:05:05', NULL),
('f6357d0c5a5b7230f3f336b480b2fb38', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-17 09:17:31', '2015-09-17 10:54:54', NULL),
('f7170a6ef57e54c15e620952eee96367', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-07-16 09:55:16', '2015-07-16 10:31:32', NULL),
('fa666022a1ca80eb9cfda5b41f12831b', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-08-12 09:08:09', '2015-08-12 10:28:40', NULL),
('fc910aff4bb82a2efcb6e845939137d0', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-09-27 08:36:03', '2015-09-27 09:02:32', NULL),
('fd97cd861146c41c6445a3bc007b2338', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-11 19:00:12', '2015-10-11 21:11:25', NULL),
('fd9e434f0a6a262c927c6d271bc3683a', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-08 07:12:23', '2015-06-08 07:42:23', NULL),
('fe34c90fd3d0c84276a8c675a6baff30', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-06-24 11:25:11', '2015-06-24 11:25:33', NULL),
('fe46f299bf502b9d2c580554672cb747', 2, '127.0.0.1', 'http://bdm.budget.loc/', '2015-10-30 22:12:55', '2015-10-31 00:53:07', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_data`
--
ALTER TABLE `app_data`
  ADD UNIQUE KEY `key` (`key`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_account`
--
ALTER TABLE `bank_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forecast`
--
ALTER TABLE `forecast`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `security_permission`
--
ALTER TABLE `security_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `security_role`
--
ALTER TABLE `security_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `security_role_permission`
--
ALTER TABLE `security_role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `security_role_id` (`security_role_id`),
  ADD KEY `security_permission_id` (`security_permission_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_date` (`transaction_date`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `bank_account_id` (`bank_account_id`),
  ADD KEY `is_reconciled` (`reconciled_date`);

--
-- Indexes for table `transaction_split`
--
ALTER TABLE `transaction_split`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `transaction_upload`
--
ALTER TABLE `transaction_upload`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login` (`login`),
  ADD KEY `role_id` (`user_role_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_session`
--
ALTER TABLE `user_session`
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `bank_account`
--
ALTER TABLE `bank_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `configuration`
--
ALTER TABLE `configuration`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `forecast`
--
ALTER TABLE `forecast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `security_permission`
--
ALTER TABLE `security_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `security_role`
--
ALTER TABLE `security_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `security_role_permission`
--
ALTER TABLE `security_role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=722;
--
-- AUTO_INCREMENT for table `transaction_split`
--
ALTER TABLE `transaction_split`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `transaction_upload`
--
ALTER TABLE `transaction_upload`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=504;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
