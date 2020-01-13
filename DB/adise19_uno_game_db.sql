-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2020 at 09:36 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adise19_uno_game_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_board` ()  BEGIN
	update `game_status` set `status`='not active', `p_turn`=null, `result`=null;
	replace into `remaining_deck` select * from `remaining_deck_reset`;
	replace into `deck` select * from `deck_reset`;
 	delete from `hand`;
	delete from `players` where `username` is not null;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deck`
--

CREATE TABLE `deck` (
  `card_id` tinyint(4) NOT NULL,
  `card_color` enum('R','Y','B','G','W') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `card_text` varchar(3) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deck`
--

INSERT INTO `deck` (`card_id`, `card_color`, `card_text`) VALUES
(1, 'R', '0'),
(2, 'R', '1'),
(3, 'R', '1'),
(4, 'R', '2'),
(5, 'R', '2'),
(7, 'R', '3'),
(8, 'R', '4'),
(9, 'R', '4'),
(10, 'R', '5'),
(12, 'R', '6'),
(13, 'R', '6'),
(14, 'R', '7'),
(15, 'R', '7'),
(17, 'R', '8'),
(18, 'R', '9'),
(19, 'R', '9'),
(20, 'R', '+2'),
(22, 'R', 'R'),
(23, 'R', 'R'),
(25, 'R', 'S'),
(26, 'Y', '0'),
(27, 'Y', '1'),
(28, 'Y', '1'),
(29, 'Y', '2'),
(30, 'Y', '2'),
(31, 'Y', '3'),
(32, 'Y', '3'),
(33, 'Y', '4'),
(34, 'Y', '4'),
(35, 'Y', '5'),
(36, 'Y', '5'),
(37, 'Y', '6'),
(39, 'Y', '7'),
(40, 'Y', '7'),
(41, 'Y', '8'),
(42, 'Y', '8'),
(44, 'Y', '9'),
(45, 'Y', '+2'),
(46, 'Y', '+2'),
(47, 'Y', 'R'),
(48, 'Y', 'R'),
(49, 'Y', 'S'),
(50, 'Y', 'S'),
(51, 'B', '0'),
(52, 'B', '1'),
(53, 'B', '1'),
(54, 'B', '2'),
(55, 'B', '2'),
(56, 'B', '3'),
(57, 'B', '3'),
(58, 'B', '4'),
(59, 'B', '4'),
(60, 'B', '5'),
(61, 'B', '5'),
(62, 'B', '6'),
(63, 'B', '6'),
(64, 'B', '7'),
(65, 'B', '7'),
(66, 'B', '8'),
(67, 'B', '8'),
(68, 'B', '9'),
(69, 'B', '9'),
(70, 'B', '+2'),
(71, 'B', '+2'),
(72, 'B', 'R'),
(73, 'B', 'R'),
(75, 'B', 'S'),
(76, 'G', '0'),
(78, 'G', '1'),
(79, 'G', '2'),
(80, 'G', '2'),
(81, 'G', '3'),
(82, 'G', '3'),
(84, 'G', '4'),
(85, 'G', '5'),
(86, 'G', '5'),
(87, 'G', '6'),
(88, 'G', '6'),
(89, 'G', '7'),
(91, 'G', '8'),
(92, 'G', '8'),
(93, 'G', '9'),
(95, 'G', '+2'),
(96, 'G', '+2'),
(98, 'G', 'R'),
(99, 'G', 'S'),
(100, 'G', 'S'),
(101, 'W', '+4W'),
(102, 'W', '+4W'),
(103, 'W', '+4W'),
(104, 'W', '+4W'),
(106, 'W', 'W'),
(107, 'W', 'W'),
(108, 'W', 'W');

-- --------------------------------------------------------

--
-- Table structure for table `deck_reset`
--

CREATE TABLE `deck_reset` (
  `card_id` tinyint(4) NOT NULL,
  `card_color` enum('R','Y','B','G','W') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `card_text` varchar(3) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deck_reset`
--

INSERT INTO `deck_reset` (`card_id`, `card_color`, `card_text`) VALUES
(1, 'R', '0'),
(2, 'R', '1'),
(3, 'R', '1'),
(4, 'R', '2'),
(5, 'R', '2'),
(6, 'R', '3'),
(7, 'R', '3'),
(8, 'R', '4'),
(9, 'R', '4'),
(10, 'R', '5'),
(11, 'R', '5'),
(12, 'R', '6'),
(13, 'R', '6'),
(14, 'R', '7'),
(15, 'R', '7'),
(16, 'R', '8'),
(17, 'R', '8'),
(18, 'R', '9'),
(19, 'R', '9'),
(20, 'R', '+2'),
(21, 'R', '+2'),
(22, 'R', 'R'),
(23, 'R', 'R'),
(24, 'R', 'S'),
(25, 'R', 'S'),
(26, 'Y', '0'),
(27, 'Y', '1'),
(28, 'Y', '1'),
(29, 'Y', '2'),
(30, 'Y', '2'),
(31, 'Y', '3'),
(32, 'Y', '3'),
(33, 'Y', '4'),
(34, 'Y', '4'),
(35, 'Y', '5'),
(36, 'Y', '5'),
(37, 'Y', '6'),
(38, 'Y', '6'),
(39, 'Y', '7'),
(40, 'Y', '7'),
(41, 'Y', '8'),
(42, 'Y', '8'),
(43, 'Y', '9'),
(44, 'Y', '9'),
(45, 'Y', '+2'),
(46, 'Y', '+2'),
(47, 'Y', 'R'),
(48, 'Y', 'R'),
(49, 'Y', 'S'),
(50, 'Y', 'S'),
(51, 'B', '0'),
(52, 'B', '1'),
(53, 'B', '1'),
(54, 'B', '2'),
(55, 'B', '2'),
(56, 'B', '3'),
(57, 'B', '3'),
(58, 'B', '4'),
(59, 'B', '4'),
(60, 'B', '5'),
(61, 'B', '5'),
(62, 'B', '6'),
(63, 'B', '6'),
(64, 'B', '7'),
(65, 'B', '7'),
(66, 'B', '8'),
(67, 'B', '8'),
(68, 'B', '9'),
(69, 'B', '9'),
(70, 'B', '+2'),
(71, 'B', '+2'),
(72, 'B', 'R'),
(73, 'B', 'R'),
(74, 'B', 'S'),
(75, 'B', 'S'),
(76, 'G', '0'),
(77, 'G', '1'),
(78, 'G', '1'),
(79, 'G', '2'),
(80, 'G', '2'),
(81, 'G', '3'),
(82, 'G', '3'),
(83, 'G', '4'),
(84, 'G', '4'),
(85, 'G', '5'),
(86, 'G', '5'),
(87, 'G', '6'),
(88, 'G', '6'),
(89, 'G', '7'),
(90, 'G', '7'),
(91, 'G', '8'),
(92, 'G', '8'),
(93, 'G', '9'),
(94, 'G', '9'),
(95, 'G', '+2'),
(96, 'G', '+2'),
(97, 'G', 'R'),
(98, 'G', 'R'),
(99, 'G', 'S'),
(100, 'G', 'S'),
(101, 'W', '+4W'),
(102, 'W', '+4W'),
(103, 'W', '+4W'),
(104, 'W', '+4W'),
(105, 'W', 'W'),
(106, 'W', 'W'),
(107, 'W', 'W'),
(108, 'W', 'W');

-- --------------------------------------------------------

--
-- Table structure for table `game_status`
--

CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborded') NOT NULL DEFAULT 'not active',
  `p_turn` enum('p1','p2') DEFAULT NULL,
  `result` enum('p1','p2','D') DEFAULT NULL,
  `last_change` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `game_status`
--

INSERT INTO `game_status` (`status`, `p_turn`, `result`, `last_change`) VALUES
('not active', NULL, NULL, '2020-01-13 19:33:42');

--
-- Triggers `game_status`
--
DELIMITER $$
CREATE TRIGGER `game_status_update` BEFORE UPDATE ON `game_status` FOR EACH ROW BEGIN
		set NEW.last_change = now();
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hand`
--

CREATE TABLE `hand` (
  `player_name` enum('p1','p2') COLLATE utf8_bin NOT NULL,
  `card_id` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `hand`
--

INSERT INTO `hand` (`player_name`, `card_id`) VALUES
('p1', 6),
('p1', 11),
('p1', 38),
('p1', 43),
('p1', 83),
('p1', 90),
('p1', 97),
('p2', 16),
('p2', 21),
('p2', 24),
('p2', 74),
('p2', 77),
('p2', 94),
('p2', 105);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `player_name` enum('p1','p2') NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `last_action` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `play_card`
--

CREATE TABLE `play_card` (
  `play_card_id` tinyint(4) NOT NULL,
  `card_id` tinyint(4) NOT NULL,
  `card_text` varchar(3) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `play_card`
--

INSERT INTO `play_card` (`play_card_id`, `card_id`, `card_text`) VALUES
(1, 27, '1');

-- --------------------------------------------------------

--
-- Table structure for table `remaining_deck`
--

CREATE TABLE `remaining_deck` (
  `card_id` tinyint(4) NOT NULL,
  `card_color` enum('R','Y','B','G','W') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `card_text` varchar(3) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `remaining_deck`
--

INSERT INTO `remaining_deck` (`card_id`, `card_color`, `card_text`) VALUES
(1, 'R', '0'),
(2, 'R', '1'),
(3, 'R', '1'),
(4, 'R', '2'),
(5, 'R', '2'),
(7, 'R', '3'),
(8, 'R', '4'),
(9, 'R', '4'),
(10, 'R', '5'),
(12, 'R', '6'),
(13, 'R', '6'),
(14, 'R', '7'),
(15, 'R', '7'),
(17, 'R', '8'),
(18, 'R', '9'),
(19, 'R', '9'),
(20, 'R', '+2'),
(22, 'R', 'R'),
(23, 'R', 'R'),
(25, 'R', 'S'),
(26, 'Y', '0'),
(28, 'Y', '1'),
(29, 'Y', '2'),
(30, 'Y', '2'),
(31, 'Y', '3'),
(32, 'Y', '3'),
(33, 'Y', '4'),
(34, 'Y', '4'),
(35, 'Y', '5'),
(36, 'Y', '5'),
(37, 'Y', '6'),
(39, 'Y', '7'),
(40, 'Y', '7'),
(41, 'Y', '8'),
(42, 'Y', '8'),
(44, 'Y', '9'),
(45, 'Y', '+2'),
(46, 'Y', '+2'),
(47, 'Y', 'R'),
(48, 'Y', 'R'),
(49, 'Y', 'S'),
(50, 'Y', 'S'),
(51, 'B', '0'),
(52, 'B', '1'),
(53, 'B', '1'),
(54, 'B', '2'),
(55, 'B', '2'),
(56, 'B', '3'),
(57, 'B', '3'),
(58, 'B', '4'),
(59, 'B', '4'),
(60, 'B', '5'),
(61, 'B', '5'),
(62, 'B', '6'),
(63, 'B', '6'),
(64, 'B', '7'),
(65, 'B', '7'),
(66, 'B', '8'),
(67, 'B', '8'),
(68, 'B', '9'),
(69, 'B', '9'),
(70, 'B', '+2'),
(71, 'B', '+2'),
(72, 'B', 'R'),
(73, 'B', 'R'),
(75, 'B', 'S'),
(76, 'G', '0'),
(78, 'G', '1'),
(79, 'G', '2'),
(80, 'G', '2'),
(81, 'G', '3'),
(82, 'G', '3'),
(84, 'G', '4'),
(85, 'G', '5'),
(86, 'G', '5'),
(87, 'G', '6'),
(88, 'G', '6'),
(89, 'G', '7'),
(91, 'G', '8'),
(92, 'G', '8'),
(93, 'G', '9'),
(95, 'G', '+2'),
(96, 'G', '+2'),
(98, 'G', 'R'),
(99, 'G', 'S'),
(100, 'G', 'S'),
(101, 'W', '+4W'),
(102, 'W', '+4W'),
(103, 'W', '+4W'),
(104, 'W', '+4W'),
(106, 'W', 'W'),
(107, 'W', 'W'),
(108, 'W', 'W');

-- --------------------------------------------------------

--
-- Table structure for table `remaining_deck_reset`
--

CREATE TABLE `remaining_deck_reset` (
  `card_id` tinyint(4) NOT NULL,
  `card_color` enum('R','Y','B','G','W') COLLATE utf8_bin NOT NULL,
  `card_text` varchar(3) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `remaining_deck_reset`
--

INSERT INTO `remaining_deck_reset` (`card_id`, `card_color`, `card_text`) VALUES
(1, 'R', '0'),
(2, 'R', '1'),
(3, 'R', '1'),
(4, 'R', '2'),
(5, 'R', '2'),
(6, 'R', '3'),
(7, 'R', '3'),
(8, 'R', '4'),
(9, 'R', '4'),
(10, 'R', '5'),
(11, 'R', '5'),
(12, 'R', '6'),
(13, 'R', '6'),
(14, 'R', '7'),
(15, 'R', '7'),
(16, 'R', '8'),
(17, 'R', '8'),
(18, 'R', '9'),
(19, 'R', '9'),
(20, 'R', '+2'),
(21, 'R', '+2'),
(22, 'R', 'R'),
(23, 'R', 'R'),
(24, 'R', 'S'),
(25, 'R', 'S'),
(26, 'Y', '0'),
(27, 'Y', '1'),
(28, 'Y', '1'),
(29, 'Y', '2'),
(30, 'Y', '2'),
(31, 'Y', '3'),
(32, 'Y', '3'),
(33, 'Y', '4'),
(34, 'Y', '4'),
(35, 'Y', '5'),
(36, 'Y', '5'),
(37, 'Y', '6'),
(38, 'Y', '6'),
(39, 'Y', '7'),
(40, 'Y', '7'),
(41, 'Y', '8'),
(42, 'Y', '8'),
(43, 'Y', '9'),
(44, 'Y', '9'),
(45, 'Y', '+2'),
(46, 'Y', '+2'),
(47, 'Y', 'R'),
(48, 'Y', 'R'),
(49, 'Y', 'S'),
(50, 'Y', 'S'),
(51, 'B', '0'),
(52, 'B', '1'),
(53, 'B', '1'),
(54, 'B', '2'),
(55, 'B', '2'),
(56, 'B', '3'),
(57, 'B', '3'),
(58, 'B', '4'),
(59, 'B', '4'),
(60, 'B', '5'),
(61, 'B', '5'),
(62, 'B', '6'),
(63, 'B', '6'),
(64, 'B', '7'),
(65, 'B', '7'),
(66, 'B', '8'),
(67, 'B', '8'),
(68, 'B', '9'),
(69, 'B', '9'),
(70, 'B', '+2'),
(71, 'B', '+2'),
(72, 'B', 'R'),
(73, 'B', 'R'),
(74, 'B', 'S'),
(75, 'B', 'S'),
(76, 'G', '0'),
(77, 'G', '1'),
(78, 'G', '1'),
(79, 'G', '2'),
(80, 'G', '2'),
(81, 'G', '3'),
(82, 'G', '3'),
(83, 'G', '4'),
(84, 'G', '4'),
(85, 'G', '5'),
(86, 'G', '5'),
(87, 'G', '6'),
(88, 'G', '6'),
(89, 'G', '7'),
(90, 'G', '7'),
(91, 'G', '8'),
(92, 'G', '8'),
(93, 'G', '9'),
(94, 'G', '9'),
(95, 'G', '+2'),
(96, 'G', '+2'),
(97, 'G', 'R'),
(98, 'G', 'R'),
(99, 'G', 'S'),
(100, 'G', 'S'),
(101, 'W', '+4W'),
(102, 'W', '+4W'),
(103, 'W', '+4W'),
(104, 'W', '+4W'),
(105, 'W', 'W'),
(106, 'W', 'W'),
(107, 'W', 'W'),
(108, 'W', 'W');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deck`
--
ALTER TABLE `deck`
  ADD PRIMARY KEY (`card_id`,`card_text`);

--
-- Indexes for table `deck_reset`
--
ALTER TABLE `deck_reset`
  ADD PRIMARY KEY (`card_id`,`card_text`);

--
-- Indexes for table `hand`
--
ALTER TABLE `hand`
  ADD PRIMARY KEY (`player_name`,`card_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_name`);

--
-- Indexes for table `play_card`
--
ALTER TABLE `play_card`
  ADD PRIMARY KEY (`play_card_id`,`card_id`);

--
-- Indexes for table `remaining_deck`
--
ALTER TABLE `remaining_deck`
  ADD PRIMARY KEY (`card_id`,`card_text`);

--
-- Indexes for table `remaining_deck_reset`
--
ALTER TABLE `remaining_deck_reset`
  ADD PRIMARY KEY (`card_id`,`card_text`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
