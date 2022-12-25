-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2022 at 06:53 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `waterorg`
--

-- --------------------------------------------------------

--
-- Table structure for table `finances`
--

CREATE TABLE `finances` (
  `projectidd` int(11) NOT NULL,
  `orgidd` int(11) NOT NULL,
  `percentage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `orgid` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `country` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `projectID(PK)` int(11) NOT NULL,
  `projectTitle` varchar(80) NOT NULL,
  `totalCost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `researcher`
--

CREATE TABLE `researcher` (
  `email` varchar(80) NOT NULL,
  `rName` varchar(80) NOT NULL,
  `orgID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `researchon`
--

CREATE TABLE `researchon` (
  `waterID(FKPK)` int(11) NOT NULL,
  `projectID(FKPK)` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `runningwater`
--

CREATE TABLE `runningwater` (
  `waterID` int(11) NOT NULL,
  `waterName` varchar(80) NOT NULL,
  `waterID(largeRiver)` int(11) NOT NULL,
  `millagepoint` int(11) NOT NULL,
  `Length` int(11) NOT NULL,
  `flowrate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `standingwater`
--

CREATE TABLE `standingwater` (
  `waterID(FKPK)` int(11) NOT NULL,
  `waterName` varchar(80) NOT NULL,
  `surface` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workson`
--

CREATE TABLE `workson` (
  `projectidW` int(11) NOT NULL,
  `email` varchar(80) NOT NULL,
  `function` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `finances`
--
ALTER TABLE `finances`
  ADD PRIMARY KEY (`projectidd`,`orgidd`),
  ADD UNIQUE KEY `projectidd` (`projectidd`,`orgidd`),
  ADD KEY `orgidd` (`orgidd`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`orgid`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`projectID(PK)`);

--
-- Indexes for table `researcher`
--
ALTER TABLE `researcher`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `orgID` (`orgID`);

--
-- Indexes for table `researchon`
--
ALTER TABLE `researchon`
  ADD PRIMARY KEY (`waterID(FKPK)`,`projectID(FKPK)`),
  ADD UNIQUE KEY `waterID(FKPK)` (`waterID(FKPK)`),
  ADD UNIQUE KEY `projectID(FKPK)` (`projectID(FKPK)`);

--
-- Indexes for table `runningwater`
--
ALTER TABLE `runningwater`
  ADD PRIMARY KEY (`waterID`),
  ADD UNIQUE KEY `waterID(largeRiver)` (`waterID(largeRiver)`);

--
-- Indexes for table `standingwater`
--
ALTER TABLE `standingwater`
  ADD PRIMARY KEY (`waterID(FKPK)`);

--
-- Indexes for table `workson`
--
ALTER TABLE `workson`
  ADD PRIMARY KEY (`projectidW`,`email`),
  ADD UNIQUE KEY `projectID` (`projectidW`,`email`),
  ADD UNIQUE KEY `projectID(PKP)` (`projectidW`,`email`),
  ADD KEY `email` (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `finances`
--
ALTER TABLE `finances`
  ADD CONSTRAINT `finances_ibfk_1` FOREIGN KEY (`projectidd`) REFERENCES `project` (`projectID(PK)`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `finances_ibfk_2` FOREIGN KEY (`orgidd`) REFERENCES `organization` (`orgid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `researcher`
--
ALTER TABLE `researcher`
  ADD CONSTRAINT `researcher_ibfk_1` FOREIGN KEY (`orgID`) REFERENCES `organization` (`orgid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `researchon`
--
ALTER TABLE `researchon`
  ADD CONSTRAINT `researchon_ibfk_1` FOREIGN KEY (`waterID(FKPK)`) REFERENCES `runningwater` (`waterID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `researchon_ibfk_2` FOREIGN KEY (`projectID(FKPK)`) REFERENCES `project` (`projectID(PK)`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `runningwater`
--
ALTER TABLE `runningwater`
  ADD CONSTRAINT `runningwater_ibfk_1` FOREIGN KEY (`waterID`) REFERENCES `standingwater` (`waterID(FKPK)`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `workson`
--
ALTER TABLE `workson`
  ADD CONSTRAINT `workson_ibfk_1` FOREIGN KEY (`projectidW`) REFERENCES `project` (`projectID(PK)`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `workson_ibfk_2` FOREIGN KEY (`email`) REFERENCES `researcher` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
