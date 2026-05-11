-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 13, 2026 at 08:05 AM
-- Server version: 8.0.44-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `IENAC25_NOTAM_groupeD`
--
DROP DATABASE IF EXISTS `IENAC25_NOTAM_groupeD`;
CREATE DATABASE IF NOT EXISTS `IENAC25_NOTAM_groupeD` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `IENAC25_NOTAM_groupeD`;

-- --------------------------------------------------------

--
-- Table structure for table `Aeroport`
--

CREATE TABLE `Aeroport` (
  `idAeroport` int NOT NULL,
  `code` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Aeroport`
--

INSERT INTO `Aeroport` (`idAeroport`, `code`, `nom`) VALUES
(1, 'LFBO', 'Aeroport de Toulouse Blagnac'),
(2, 'LFPG', 'Aeroport de Roissy Charles De Gaulle'),
(3, 'LFPO', 'Aeroport de Paris Orly');

-- --------------------------------------------------------

--
-- Table structure for table `AeroportDegagement`
--

CREATE TABLE `AeroportDegagement` (
  `idAeroportDegagement` int NOT NULL,
  `idVol` int NOT NULL,
  `idAeroport` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Notam`
--

CREATE TABLE `Notam` (
  `idNotam` int NOT NULL,
  `typeNotam` enum('NOTAMN','NOTAMR','NOTAMC','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `objet` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `idAeroport` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Notam`
--

INSERT INTO `Notam` (`idNotam`, `typeNotam`, `objet`, `description`, `dateDebut`, `dateFin`, `idAeroport`) VALUES
(1, 'NOTAMN', 'LFFF/QFAXX/IV/NBO/ A/000/999/4843N00223E005', 'L\'ATTENTION DES EQUIPAGES EST ATTIREE SUR LA PRESENCE D\'UNE ROUTE PASSANT DERRIERE LES POSTES DE STATIONNEMENT AVIONS C08A, C08, C08B, C10, C12 ET C14 EN RAISON DE TRAVAUX.\r\n', '2026-04-13', '2026-04-15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Utilisateur`
--

CREATE TABLE `Utilisateur` (
  `idutilisateur` int NOT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prenom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `motdepasse` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Utilisateur`
--

INSERT INTO `Utilisateur` (`idutilisateur`, `nom`, `prenom`, `login`, `motdepasse`, `admin`) VALUES
(1, 'Admin', 'Admin', 'Admin', 'Admin', 1),
(2, 'Collec', 'Noe', 'collecno', 'ViveLaBretagne', 0),
(3, 'Montemont', 'Axel', 'montemax', 'ViveLAlsace', 0),
(4, 'Ermel', 'Thibault', 'ermelth', 'Chat', 1),
(5, 'Dalquier', 'Alois', 'dalquial', 'Vivele47', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Vol`
--

CREATE TABLE `Vol` (
  `idVol` int NOT NULL,
  `dateDepart` date NOT NULL,
  `idAeroportDep` int NOT NULL,
  `idAeroportArr` int NOT NULL,
  `idUtilisateur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Vol`
--

INSERT INTO `Vol` (`idVol`, `dateDepart`, `idAeroportDep`, `idAeroportArr`, `idUtilisateur`) VALUES
(1, '2026-04-13', 1, 2, 1),
(2, '2026-04-20', 3, 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Aeroport`
--
ALTER TABLE `Aeroport`
  ADD PRIMARY KEY (`idAeroport`);

--
-- Indexes for table `AeroportDegagement`
--
ALTER TABLE `AeroportDegagement`
  ADD PRIMARY KEY (`idAeroportDegagement`),
  ADD KEY `idVolConstraint` (`idVol`),
  ADD KEY `idAeroport` (`idAeroport`);

--
-- Indexes for table `Notam`
--
ALTER TABLE `Notam`
  ADD PRIMARY KEY (`idNotam`),
  ADD KEY `idAeroportConstraint` (`idAeroport`);

--
-- Indexes for table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`idutilisateur`);

--
-- Indexes for table `Vol`
--
ALTER TABLE `Vol`
  ADD PRIMARY KEY (`idVol`),
  ADD KEY `idAeroportDepConstraint` (`idAeroportDep`),
  ADD KEY `idAeroportArrConstraint` (`idAeroportArr`),
  ADD KEY `idUtilisateurConstraint` (`idUtilisateur`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Aeroport`
--
ALTER TABLE `Aeroport`
  MODIFY `idAeroport` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `AeroportDegagement`
--
ALTER TABLE `AeroportDegagement`
  MODIFY `idAeroportDegagement` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Notam`
--
ALTER TABLE `Notam`
  MODIFY `idNotam` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  MODIFY `idutilisateur` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Vol`
--
ALTER TABLE `Vol`
  MODIFY `idVol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AeroportDegagement`
--
ALTER TABLE `AeroportDegagement`
  ADD CONSTRAINT `idAeroport` FOREIGN KEY (`idAeroport`) REFERENCES `Aeroport` (`idAeroport`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `idVolConstraint` FOREIGN KEY (`idVol`) REFERENCES `Vol` (`idVol`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Notam`
--
ALTER TABLE `Notam`
  ADD CONSTRAINT `idAeroportConstraint` FOREIGN KEY (`idAeroport`) REFERENCES `Aeroport` (`idAeroport`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Vol`
--
ALTER TABLE `Vol`
  ADD CONSTRAINT `idAeroportArrConstraint` FOREIGN KEY (`idAeroportArr`) REFERENCES `Aeroport` (`idAeroport`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `idAeroportDepConstraint` FOREIGN KEY (`idAeroportDep`) REFERENCES `Aeroport` (`idAeroport`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `idUtilisateurConstraint` FOREIGN KEY (`idUtilisateur`) REFERENCES `Utilisateur` (`idutilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
