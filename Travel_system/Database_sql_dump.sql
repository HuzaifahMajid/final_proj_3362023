CREATE DATABASE  IF NOT EXISTS `travelreservationdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `travelreservationdb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: travelreservationdb
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `userType` varchar(15) NOT NULL,
  PRIMARY KEY (`AccountID`),
  UNIQUE KEY `AccountID_UNIQUE` (`AccountID`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'zazi','admin','admin'),(2,'mark','123','customerrep'),(3,'jeff','123','customer'),(5,'test','test','customer'),(6,'musa','lol','customer'),(7,'ray','gay','customer');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `AircraftID` int NOT NULL AUTO_INCREMENT,
  `AirlineID` varchar(2) DEFAULT NULL,
  `TotalSeats` int DEFAULT NULL,
  PRIMARY KEY (`AircraftID`),
  KEY `AirlineID_idx` (`AirlineID`),
  CONSTRAINT `AirlineID` FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (1,'DA',50),(2,'UA',100);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `AirlineID` varchar(2) NOT NULL,
  `Aircrafts_owned` int NOT NULL,
  PRIMARY KEY (`AirlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('DA',5),('UA',10);
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `airportID` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`airportID`),
  UNIQUE KEY `airportID_UNIQUE` (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('JFK','John F.K Airport','New York','United States'),('LHR','Heathrow','London','United Kingdom');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_summary`
--

DROP TABLE IF EXISTS `financial_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_summary` (
  `SummaryID` int NOT NULL AUTO_INCREMENT,
  `Month` int DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `FlightNumber` int DEFAULT NULL,
  `AirlineID` varchar(2) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `TotalRevenue` decimal(10,2) DEFAULT NULL,
  `TotalTicketsSold` int DEFAULT NULL,
  PRIMARY KEY (`SummaryID`),
  KEY `FlightNumber` (`FlightNumber`),
  KEY `AirlineID` (`AirlineID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `financial_summary_ibfk_1` FOREIGN KEY (`FlightNumber`) REFERENCES `flight` (`FlightNumber`),
  CONSTRAINT `financial_summary_ibfk_2` FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`),
  CONSTRAINT `financial_summary_ibfk_3` FOREIGN KEY (`CustomerID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_summary`
--

LOCK TABLES `financial_summary` WRITE;
/*!40000 ALTER TABLE `financial_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `financial_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_transactions`
--

DROP TABLE IF EXISTS `financial_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `TransactionDateTime` datetime DEFAULT NULL,
  `TicketID` int DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `TicketID` (`TicketID`),
  CONSTRAINT `financial_transactions_ibfk_1` FOREIGN KEY (`TicketID`) REFERENCES `reservation` (`ReservationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_transactions`
--

LOCK TABLES `financial_transactions` WRITE;
/*!40000 ALTER TABLE `financial_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `financial_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `FlightNumber` int NOT NULL AUTO_INCREMENT,
  `AirlineID` varchar(2) NOT NULL,
  `DepartureAirportID` varchar(3) NOT NULL,
  `DestinationAirportID` varchar(3) NOT NULL,
  `DepartureTime` datetime NOT NULL,
  `ArrivalTime` datetime NOT NULL,
  `FlightType` varchar(20) NOT NULL,
  `AircraftID` int NOT NULL,
  `Monday` tinyint DEFAULT '1',
  `Tuesday` tinyint DEFAULT '0',
  `Wednesday` tinyint DEFAULT '1',
  `Thursday` tinyint DEFAULT '0',
  `Friday` tinyint DEFAULT '0',
  `Saturday` tinyint DEFAULT '0',
  `Sunday` tinyint DEFAULT '0',
  `price` decimal(10,2) DEFAULT NULL,
  `numberOfStops` int DEFAULT NULL,
  PRIMARY KEY (`FlightNumber`),
  KEY `AircraftID_idx` (`AircraftID`),
  KEY `DepartureAirport_idx` (`DepartureAirportID`),
  KEY `DestinationAirport_idx` (`DestinationAirportID`),
  KEY `airline_ID` (`AirlineID`),
  CONSTRAINT `aircraftID` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`),
  CONSTRAINT `airline_ID` FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`),
  CONSTRAINT `arrivalAID` FOREIGN KEY (`DestinationAirportID`) REFERENCES `airports` (`airportID`),
  CONSTRAINT `departAID` FOREIGN KEY (`DepartureAirportID`) REFERENCES `airports` (`airportID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'DA','JFK','LHR','2023-01-15 08:00:00','2023-01-16 12:00:00','International',1,1,0,1,0,0,0,0,500.00,2);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionanswer`
--

DROP TABLE IF EXISTS `questionanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionanswer` (
  `QAID` int unsigned NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `Question` text NOT NULL,
  `Answer` text,
  PRIMARY KEY (`QAID`),
  KEY `CustomerID_idx` (`CustomerID`),
  CONSTRAINT `CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionanswer`
--

LOCK TABLES `questionanswer` WRITE;
/*!40000 ALTER TABLE `questionanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `ID` int DEFAULT NULL,
  `FlightNumber` int DEFAULT NULL,
  `SeatNumber` varchar(10) DEFAULT NULL,
  `TicketClass` varchar(20) DEFAULT NULL,
  `TicketFare` decimal(10,2) DEFAULT NULL,
  `PurchaseDateTime` datetime DEFAULT NULL,
  `BookingFee` decimal(10,2) DEFAULT NULL,
  `AirlineID` varchar(2) DEFAULT NULL,
  `PassFirstName` varchar(50) DEFAULT NULL,
  `PassLastName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ReservationID`),
  KEY `ID_idx` (`ID`),
  KEY `flightNUM` (`FlightNumber`),
  CONSTRAINT `flightNUM` FOREIGN KEY (`FlightNumber`) REFERENCES `flight` (`FlightNumber`),
  CONSTRAINT `ID` FOREIGN KEY (`ID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `WaitlistID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `FlightNumber` int NOT NULL,
  `AirlineID` varchar(2) NOT NULL,
  PRIMARY KEY (`WaitlistID`),
  UNIQUE KEY `UC_Waitlist` (`CustomerID`,`FlightNumber`,`AirlineID`),
  KEY `fnum_idx` (`FlightNumber`),
  KEY `airline_idx` (`AirlineID`) /*!80000 INVISIBLE */,
  CONSTRAINT `airline` FOREIGN KEY (`AirlineID`) REFERENCES `flight` (`AirlineID`),
  CONSTRAINT `customer_ID` FOREIGN KEY (`CustomerID`) REFERENCES `account` (`AccountID`),
  CONSTRAINT `fnum` FOREIGN KEY (`FlightNumber`) REFERENCES `flight` (`FlightNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-15  4:11:56
