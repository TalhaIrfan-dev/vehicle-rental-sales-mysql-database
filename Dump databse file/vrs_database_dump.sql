-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vrs
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(50) NOT NULL,
  `CustomerCNIC` varchar(15) NOT NULL,
  `Phone_no` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `CustomerCNIC` (`CustomerCNIC`),
  UNIQUE KEY `Phone_no` (`Phone_no`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `customers_chk_1` CHECK ((`CustomerName` <> _utf8mb4'')),
  CONSTRAINT `customers_chk_2` CHECK (regexp_like(`CustomerCNIC`,_utf8mb4'^[0-9]{5}-[0-9]{7}-[0-9]{1}$')),
  CONSTRAINT `customers_chk_3` CHECK (regexp_like(`Phone_no`,_utf8mb4'^[0-9]{4} [0-9]{7}$')),
  CONSTRAINT `customers_chk_4` CHECK ((`Email` like _utf8mb4'%@%.%'))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Ahmed Khan','42101-1234567-1','0300 1234567','ahmed.khan@example.com'),(2,'Sara Malik','35202-7654321-9','0312 7654321','sara.malik@example.com'),(3,'Zain Ali','61101-3344556-4','0321 3344556','zain.ali@example.com'),(4,'Hina Shah','42201-2233445-2','0301 2233445','hina.shah@example.com'),(5,'Talha Rizvi','33102-9988776-6','0345 9988776','talha.rizvi@example.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drivers` (
  `DriverID` int NOT NULL AUTO_INCREMENT,
  `DriverName` varchar(50) NOT NULL,
  `CNIC` varchar(15) NOT NULL,
  `Phone_no` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `LicenseNo` varchar(20) NOT NULL,
  `ExperienceYears` int DEFAULT NULL,
  `Availability` enum('Available','Assigned','On Leave') NOT NULL,
  PRIMARY KEY (`DriverID`),
  UNIQUE KEY `CNIC` (`CNIC`),
  UNIQUE KEY `Phone_no` (`Phone_no`),
  UNIQUE KEY `LicenseNo` (`LicenseNo`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `drivers_chk_1` CHECK ((`DriverName` <> _utf8mb4'')),
  CONSTRAINT `drivers_chk_2` CHECK ((`ExperienceYears` >= 0)),
  CONSTRAINT `drivers_chk_3` CHECK (regexp_like(`CNIC`,_utf8mb4'^[0-9]{5}-[0-9]{7}-[0-9]{1}$')),
  CONSTRAINT `drivers_chk_4` CHECK (regexp_like(`Phone_no`,_utf8mb4'^[0-9]{4} [0-9]{7}$')),
  CONSTRAINT `drivers_chk_5` CHECK ((`Email` like _utf8mb4'%@%.%'))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
INSERT INTO `drivers` VALUES (1,'Imran Shaikh','42101-1122334-5','0300 1122334','imran.shaikh@example.com','LIC12345',5,'Available'),(2,'Adeel Qureshi','35202-2233445-7','0301 2233445','adeel.q@example.com','LIC67890',3,'Assigned'),(3,'Farhan Aziz','61101-3344556-2','0321 3344556','farhan.aziz@example.com','LIC11122',7,'Available');
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `HistoryID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(50) DEFAULT NULL,
  `CustomerCNIC` varchar(15) DEFAULT NULL,
  `Vehicle_model` varchar(50) DEFAULT NULL,
  `Registration_no` varchar(15) DEFAULT NULL,
  `DriverName` varchar(50) DEFAULT NULL,
  `record_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `Status` enum('Rented','Sold') NOT NULL,
  PRIMARY KEY (`HistoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,'Sara Malik','35202-7654321-9','Suzuki Alto','GHI-4321',NULL,'2025-03-10',NULL,1600000.00,'Sold'),(2,'Ahmed Khan','42101-1234567-1','Kawasaki Ninja H2R','KNH-2424','Imran Shaikh','2025-04-01','2025-04-05',15000.00,'Rented'),(3,'Ahmed Khan','42101-1234567-1','Honda Civic','DEF-5678',NULL,'2025-05-10',NULL,15000.00,'Rented'),(4,'Sara Malik','35202-7654321-9','Yamaha YBR 125','MNO-999','Imran Shaikh','2025-05-11',NULL,3500.00,'Rented');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records` (
  `Record_id` int NOT NULL AUTO_INCREMENT,
  `VehicleID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `DriverID` int DEFAULT NULL,
  `record_date` date NOT NULL DEFAULT (curdate()),
  `return_date` date DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `Status` enum('Rented','Sold') NOT NULL,
  PRIMARY KEY (`Record_id`),
  KEY `VehicleID` (`VehicleID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `DriverID` (`DriverID`),
  CONSTRAINT `records_ibfk_1` FOREIGN KEY (`VehicleID`) REFERENCES `vehicles` (`VehicleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `records_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `records_ibfk_3` FOREIGN KEY (`DriverID`) REFERENCES `drivers` (`DriverID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records`
--

LOCK TABLES `records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
INSERT INTO `records` VALUES (1,26,2,NULL,'2025-03-10',NULL,1600000.00,'Sold'),(2,29,1,1,'2025-04-01','2025-04-05',15000.00,'Rented'),(3,25,1,NULL,'2025-05-10',NULL,15000.00,'Rented'),(4,28,2,1,'2025-05-11',NULL,3500.00,'Rented');
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentaldrivers`
--

DROP TABLE IF EXISTS `rentaldrivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentaldrivers` (
  `RentalDriverID` int NOT NULL AUTO_INCREMENT,
  `Rental_id` int NOT NULL,
  `DriverID` int NOT NULL,
  `AssignedDate` date NOT NULL DEFAULT (curdate()),
  `Shift` enum('Morning','Evening','Night') DEFAULT 'Morning',
  PRIMARY KEY (`RentalDriverID`),
  UNIQUE KEY `Rental_id` (`Rental_id`),
  UNIQUE KEY `DriverID` (`DriverID`),
  CONSTRAINT `rentaldrivers_ibfk_1` FOREIGN KEY (`Rental_id`) REFERENCES `rentals` (`Rental_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rentaldrivers_ibfk_2` FOREIGN KEY (`DriverID`) REFERENCES `drivers` (`DriverID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentaldrivers`
--

LOCK TABLES `rentaldrivers` WRITE;
/*!40000 ALTER TABLE `rentaldrivers` DISABLE KEYS */;
INSERT INTO `rentaldrivers` VALUES (1,2,1,'2026-01-19','Morning');
/*!40000 ALTER TABLE `rentaldrivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `Rental_id` int NOT NULL AUTO_INCREMENT,
  `VehicleID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `rental_date` date NOT NULL DEFAULT (curdate()),
  `rental_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Rental_id`),
  UNIQUE KEY `VehicleID` (`VehicleID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`VehicleID`) REFERENCES `vehicles` (`VehicleID`) ON UPDATE CASCADE,
  CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,25,1,'2025-05-10',15000.00),(2,28,2,'2025-05-11',3500.00);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `VehicleID` int NOT NULL AUTO_INCREMENT,
  `Vehicle_model` varchar(50) NOT NULL,
  `Registration_no` varchar(15) NOT NULL,
  `TypeId` int NOT NULL,
  `VehicleStatus` enum('available','rented','sold','not_available') NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`VehicleID`),
  UNIQUE KEY `Registration_no` (`Registration_no`),
  KEY `TypeId` (`TypeId`),
  CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `vehicletype` (`TypeId`) ON UPDATE CASCADE,
  CONSTRAINT `vehicles_chk_1` CHECK ((`Vehicle_model` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (24,'Toyota Corolla','ABC-1234',1,'available',2500000.00),(25,'Honda Civic','DEF-5678',1,'rented',2800000.00),(26,'Suzuki Alto','GHI-4321',3,'sold',1600000.00),(27,'KIA Sportage','JKL-8765',2,'available',5500000.00),(28,'Yamaha YBR 125','MNO-999',4,'rented',300000.00),(29,'Kawasaki Ninja H2R','KNH-2424',4,'available',800000.00),(30,'Hyundai Elantra','HYN-1122',1,'available',2700000.00),(31,'Toyota Fortuner','TYF-8899',2,'available',9000000.00),(32,'Suzuki Wagon R','SWG-3344',3,'available',1800000.00),(33,'Honda BR-V','HBR-5566',2,'available',4300000.00),(34,'Yamaha MT-15','YMT-777',4,'available',450000.00),(35,'Honda CD 70','HCD-888',4,'available',150000.00),(36,'Suzuki Cultus','SCL-1212',3,'available',2000000.00),(37,'Kawasaki Z1000','KZ1-9090',4,'available',1200000.00),(38,'Nissan Dayz','NSD-6543',3,'available',1700000.00),(39,'Changan Karvaan','CHK-8888',5,'available',2100000.00),(40,'Toyota Hiace','THC-2222',5,'available',3800000.00),(41,'Honda Vezel','HVZ-3434',1,'available',4700000.00);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicletype`
--

DROP TABLE IF EXISTS `vehicletype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicletype` (
  `TypeId` int NOT NULL AUTO_INCREMENT,
  `Vehicle_type` varchar(15) NOT NULL,
  `Average_rent` decimal(8,2) NOT NULL,
  PRIMARY KEY (`TypeId`),
  UNIQUE KEY `Vehicle_type` (`Vehicle_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicletype`
--

LOCK TABLES `vehicletype` WRITE;
/*!40000 ALTER TABLE `vehicletype` DISABLE KEYS */;
INSERT INTO `vehicletype` VALUES (1,'Sedan',4000.00),(2,'SUV',5000.00),(3,'Hatchback',3000.00),(4,'Bike',2000.00),(5,'Van',3500.00);
/*!40000 ALTER TABLE `vehicletype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-19 18:03:03
