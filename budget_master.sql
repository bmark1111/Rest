-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2015 at 09:17 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `budget_master`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE IF NOT EXISTS `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(20) NOT NULL,
  `db_name` varchar(45) DEFAULT NULL,
  `is_disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `name`, `is_admin`, `domain`, `db_name`, `is_disabled`, `is_deleted`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'Budget Tracker for Brian Markham', 0, 'bdm', 'bdm_budget', 0, 0, '0000-00-00 00:00:00', '2015-06-03 22:45:27', NULL, NULL),
(2, 'Budget Tracker for Christopher Markham', 0, 'cdm', 'cdm_budget', 0, 0, '0000-00-00 00:00:00', '2015-06-03 22:45:31', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ci_error_log`
--

CREATE TABLE IF NOT EXISTS `ci_error_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message` text,
  `backtrace` text,
  `account_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `user_login` varchar(127) DEFAULT NULL,
  `environment` varchar(45) DEFAULT NULL,
  `http_host` varchar(127) DEFAULT NULL,
  `uri` text,
  `user_agent` varchar(255) DEFAULT NULL,
  `remote_address` varchar(255) DEFAULT NULL,
  `get_array` text,
  `post_array` text,
  `session_array` text,
  `session_key` varchar(127) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
