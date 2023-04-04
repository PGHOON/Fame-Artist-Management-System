-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: case5
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `admin_t`
--

DROP TABLE IF EXISTS `admin_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_t` (
  `AdminID` int NOT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `AManagerID` int NOT NULL,
  PRIMARY KEY (`AdminID`,`AManagerID`),
  KEY `fk_admin_t_artistmanager_t1_idx` (`AManagerID`),
  CONSTRAINT `fk_admin_t_artistmanager_t1` FOREIGN KEY (`AManagerID`) REFERENCES `artistmanager_t` (`AManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_t`
--

LOCK TABLES `admin_t` WRITE;
/*!40000 ALTER TABLE `admin_t` DISABLE KEYS */;
INSERT INTO `admin_t` VALUES (1,'Smith','John',3),(2,'Lee','Karen',8),(3,'Johnson','William',9),(4,'Garcia','Sophia',1),(5,'Wang','Michael',2),(6,'Davis','Avery',4),(7,'Hernandez','Olivia',10),(8,'Chen','Ethan',7),(9,'Gonzalez','Liam',6),(10,'Rodriguez','Isabella',5);
/*!40000 ALTER TABLE `admin_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agreement_t`
--

DROP TABLE IF EXISTS `agreement_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreement_t` (
  `AgreementNbr` int NOT NULL,
  `AgreementDate` timestamp NULL DEFAULT NULL,
  `GrossAmount` decimal(12,2) DEFAULT NULL,
  `AtSourceTaxWithheld` decimal(12,2) DEFAULT NULL,
  `ContractID` int NOT NULL,
  `EventID` int NOT NULL,
  PRIMARY KEY (`AgreementNbr`,`ContractID`,`EventID`),
  KEY `fk_agreement_t_contract_t1_idx` (`ContractID`),
  KEY `fk_agreement_t_event_t1_idx` (`EventID`),
  CONSTRAINT `fk_agreement_t_contract_t1` FOREIGN KEY (`ContractID`) REFERENCES `contract_t` (`ContractID`),
  CONSTRAINT `fk_agreement_t_event_t1` FOREIGN KEY (`EventID`) REFERENCES `event_t` (`EventID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agreement_t`
--

LOCK TABLES `agreement_t` WRITE;
/*!40000 ALTER TABLE `agreement_t` DISABLE KEYS */;
INSERT INTO `agreement_t` VALUES (1,'2022-01-01 18:00:00',5000.00,750.00,1,1),(2,'2022-02-14 21:30:00',7500.00,1125.00,2,3),(3,'2022-03-22 15:45:00',3000.00,450.00,3,5),(4,'2022-05-01 00:15:00',9000.00,1350.00,4,2),(5,'2022-05-06 02:00:00',2000.00,300.00,6,4),(6,'2022-06-12 19:00:00',6000.00,900.00,7,6),(7,'2022-07-18 21:30:00',3500.00,525.00,5,1),(8,'2022-08-28 01:15:00',8000.00,1200.00,10,3),(9,'2022-09-01 15:00:00',1500.00,225.00,8,5),(10,'2022-10-15 18:45:00',4500.00,675.00,9,2);
/*!40000 ALTER TABLE `agreement_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agreementinvoice_t`
--

DROP TABLE IF EXISTS `agreementinvoice_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreementinvoice_t` (
  `AgreementNbr` int NOT NULL,
  `InvoiceNbr` int NOT NULL,
  `Amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`AgreementNbr`,`InvoiceNbr`),
  KEY `fk_agreementinvoice_t_invoice_t1_idx` (`InvoiceNbr`),
  CONSTRAINT `fk_agreementinvoice_t_agreement_t1` FOREIGN KEY (`AgreementNbr`) REFERENCES `agreement_t` (`AgreementNbr`),
  CONSTRAINT `fk_agreementinvoice_t_invoice_t1` FOREIGN KEY (`InvoiceNbr`) REFERENCES `invoice_t` (`InvoiceNbr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agreementinvoice_t`
--

LOCK TABLES `agreementinvoice_t` WRITE;
/*!40000 ALTER TABLE `agreementinvoice_t` DISABLE KEYS */;
INSERT INTO `agreementinvoice_t` VALUES (1,3,1500.00),(2,6,800.00),(3,2,1200.00),(4,1,500.00),(5,8,2000.00),(6,7,1000.00),(7,10,1800.00),(8,4,600.00),(9,5,900.00),(10,9,1500.00);
/*!40000 ALTER TABLE `agreementinvoice_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_t`
--

DROP TABLE IF EXISTS `artist_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_t` (
  `ArtistID` int NOT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `YearOfBirth` int DEFAULT NULL,
  `Street` varchar(40) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Zip` varchar(9) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `ArtistType` char(1) DEFAULT NULL,
  PRIMARY KEY (`ArtistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_t`
--

LOCK TABLES `artist_t` WRITE;
/*!40000 ALTER TABLE `artist_t` DISABLE KEYS */;
INSERT INTO `artist_t` VALUES (1,'Smith','John','M',1980,'123 Main St','Anytown','NY','12345','5551231234','smith@example.com','P'),(2,'Jones','Sarah','F',1992,'456 Oak Ave','Anothercity','CA','67890','5552435678','jones@example.com','A'),(3,'Garcia','Juan','M',1975,'789 Elm St','Bigcity','TX','54321','5555231901','garcia@example.com','P'),(4,'Lee','Jin','F',1988,'246 Main St','Smalltown','WA','12345','5552453456','lee@example.com','A'),(5,'Brown','Karen','F',1967,'135 Main St','Anytown','NY','12345','5553647890','brown@example.com','P'),(6,'Gonzalez','Maria','F',1990,'579 Pine St','Anothercity','CA','67890','5523452345','gonzalez@example.com','A'),(7,'Taylor','David','M',1972,'864 Oak Ave','Bigcity','TX','54321','5551646789','taylor@example.com','P'),(8,'Choi','Min','F',1985,'975 Elm St','Smalltown','WA','12345','5552350123','choi@example.com','A'),(9,'Wilson','Brian','M',1962,'753 Main St','Anytown','NY','12345','5551234456','wilson@example.com','P'),(10,'Kim','Soo','F',1995,'864 Pine St','Anothercity','CA','67890','5552348901','kim@example.com','A');
/*!40000 ALTER TABLE `artist_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistcommitment_t`
--

DROP TABLE IF EXISTS `artistcommitment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistcommitment_t` (
  `ACommitmentID` int NOT NULL,
  `StateDateTime` timestamp NULL DEFAULT NULL,
  `EndDateTime` timestamp NULL DEFAULT NULL,
  `CommitmentType` char(2) DEFAULT NULL,
  `ArtistID` int NOT NULL,
  PRIMARY KEY (`ACommitmentID`,`ArtistID`),
  KEY `fk_artistcommitment_t_contractedartist_t1_idx` (`ArtistID`),
  CONSTRAINT `fk_artistcommitment_t_contractedartist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `contractedartist_t` (`ArtistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistcommitment_t`
--

LOCK TABLES `artistcommitment_t` WRITE;
/*!40000 ALTER TABLE `artistcommitment_t` DISABLE KEYS */;
INSERT INTO `artistcommitment_t` VALUES (1,'2022-05-01 15:00:00','2022-06-01 15:00:00','PP',1),(2,'2022-07-01 15:00:00','2022-08-01 15:00:00','AL',2),(3,'2022-09-01 15:00:00','2022-10-01 15:00:00','PR',3),(4,'2022-11-01 15:00:00','2022-12-01 16:00:00','SH',4),(5,'2023-01-01 16:00:00','2023-02-01 16:00:00','ST',5),(6,'2023-03-01 16:00:00','2023-04-01 15:00:00','MS',6),(7,'2023-05-01 15:00:00','2023-06-01 15:00:00','PR',7),(8,'2023-07-01 15:00:00','2023-08-01 15:00:00','SH',8),(9,'2023-09-01 15:00:00','2023-10-01 15:00:00','MS',9),(10,'2023-11-01 15:00:00','2023-12-01 16:00:00','ST',10);
/*!40000 ALTER TABLE `artistcommitment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistdegree_t`
--

DROP TABLE IF EXISTS `artistdegree_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistdegree_t` (
  `ArtistID` int NOT NULL,
  `DegreeId` int NOT NULL,
  `DegreeYear` int NOT NULL,
  PRIMARY KEY (`ArtistID`,`DegreeId`),
  KEY `fk_artistdegree_t_degree_t1_idx` (`DegreeId`),
  CONSTRAINT `fk_artistdegree_t_artist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`),
  CONSTRAINT `fk_artistdegree_t_degree_t1` FOREIGN KEY (`DegreeId`) REFERENCES `degree_t` (`DegreeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistdegree_t`
--

LOCK TABLES `artistdegree_t` WRITE;
/*!40000 ALTER TABLE `artistdegree_t` DISABLE KEYS */;
INSERT INTO `artistdegree_t` VALUES (1,3,2000),(2,7,2020),(3,5,2015),(4,6,2014),(5,1,2011),(6,8,2000),(7,9,2012),(8,2,2007),(9,4,1999),(10,10,2008);
/*!40000 ALTER TABLE `artistdegree_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistexpense_t`
--

DROP TABLE IF EXISTS `artistexpense_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistexpense_t` (
  `ArtistID` int NOT NULL,
  `ExpenseID` int NOT NULL,
  PRIMARY KEY (`ArtistID`,`ExpenseID`),
  KEY `fk_artistexpense_t_expense_t1_idx` (`ExpenseID`),
  CONSTRAINT `fk_artistexpense_t_contractedartist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `contractedartist_t` (`ArtistID`),
  CONSTRAINT `fk_artistexpense_t_expense_t1` FOREIGN KEY (`ExpenseID`) REFERENCES `expense_t` (`ExpenseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistexpense_t`
--

LOCK TABLES `artistexpense_t` WRITE;
/*!40000 ALTER TABLE `artistexpense_t` DISABLE KEYS */;
INSERT INTO `artistexpense_t` VALUES (10,1),(9,2),(8,3),(7,4),(6,5),(5,6),(4,7),(3,8),(2,9),(1,10);
/*!40000 ALTER TABLE `artistexpense_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artisthonor_t`
--

DROP TABLE IF EXISTS `artisthonor_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artisthonor_t` (
  `ArtistID` int NOT NULL,
  `HonorID` int NOT NULL,
  `AHYear` int DEFAULT NULL,
  PRIMARY KEY (`ArtistID`,`HonorID`),
  KEY `fk_artisthonor_t_honor_t1_idx` (`HonorID`),
  CONSTRAINT `fk_artisthonor_t_artist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`),
  CONSTRAINT `fk_artisthonor_t_honor_t1` FOREIGN KEY (`HonorID`) REFERENCES `honor_t` (`HonorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artisthonor_t`
--

LOCK TABLES `artisthonor_t` WRITE;
/*!40000 ALTER TABLE `artisthonor_t` DISABLE KEYS */;
INSERT INTO `artisthonor_t` VALUES (1,1,2000),(2,3,2020),(3,5,2015),(4,2,2014),(5,4,2011),(6,8,2000),(7,7,2012),(8,6,2007),(9,10,1999),(10,9,2008);
/*!40000 ALTER TABLE `artisthonor_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistinstrument_t`
--

DROP TABLE IF EXISTS `artistinstrument_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistinstrument_t` (
  `ArtistID` int NOT NULL,
  `InstrumentID` int NOT NULL,
  PRIMARY KEY (`ArtistID`,`InstrumentID`),
  KEY `fk_artistinstrument_t_instrument_t1_idx` (`InstrumentID`),
  CONSTRAINT `fk_artistinstrument_t_artist_t` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`),
  CONSTRAINT `fk_artistinstrument_t_instrument_t1` FOREIGN KEY (`InstrumentID`) REFERENCES `instrument_t` (`InstrumentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistinstrument_t`
--

LOCK TABLES `artistinstrument_t` WRITE;
/*!40000 ALTER TABLE `artistinstrument_t` DISABLE KEYS */;
INSERT INTO `artistinstrument_t` VALUES (10,1),(9,2),(8,3),(7,4),(6,5),(5,6),(4,7),(3,8),(2,9),(1,10);
/*!40000 ALTER TABLE `artistinstrument_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistmanager_t`
--

DROP TABLE IF EXISTS `artistmanager_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistmanager_t` (
  `AManagerID` int NOT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`AManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistmanager_t`
--

LOCK TABLES `artistmanager_t` WRITE;
/*!40000 ALTER TABLE `artistmanager_t` DISABLE KEYS */;
INSERT INTO `artistmanager_t` VALUES (1,'Jones','Sarah'),(2,'Nguyen','Michael'),(3,'Kim','Minji'),(4,'Wu','David'),(5,'Patel','Nisha'),(6,'Garcia','Antonio'),(7,'Singh','Rajesh'),(8,'Liu','Jenny'),(9,'Choi','Hyejin'),(10,'Gonzalez','Juan');
/*!40000 ALTER TABLE `artistmanager_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistmgrexpense_t`
--

DROP TABLE IF EXISTS `artistmgrexpense_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistmgrexpense_t` (
  `ExpenseID` int NOT NULL,
  `AManagerID` int NOT NULL,
  PRIMARY KEY (`ExpenseID`,`AManagerID`),
  KEY `fk_artistmgrexpense_t_artistmanager_t1_idx` (`AManagerID`),
  CONSTRAINT `fk_artistmgrexpense_t_artistmanager_t1` FOREIGN KEY (`AManagerID`) REFERENCES `artistmanager_t` (`AManagerID`),
  CONSTRAINT `fk_artistmgrexpense_t_expense_t1` FOREIGN KEY (`ExpenseID`) REFERENCES `expense_t` (`ExpenseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistmgrexpense_t`
--

LOCK TABLES `artistmgrexpense_t` WRITE;
/*!40000 ALTER TABLE `artistmgrexpense_t` DISABLE KEYS */;
INSERT INTO `artistmgrexpense_t` VALUES (10,1),(9,2),(8,3),(7,4),(6,5),(5,6),(4,7),(3,8),(2,9),(1,10);
/*!40000 ALTER TABLE `artistmgrexpense_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistnews_t`
--

DROP TABLE IF EXISTS `artistnews_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistnews_t` (
  `ArtistID` int NOT NULL,
  `NewsItemID` int NOT NULL,
  PRIMARY KEY (`ArtistID`,`NewsItemID`),
  KEY `fk_artistnews_t_newsitem_t1_idx` (`NewsItemID`),
  CONSTRAINT `fk_artistnews_t_artist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`),
  CONSTRAINT `fk_artistnews_t_newsitem_t1` FOREIGN KEY (`NewsItemID`) REFERENCES `newsitem_t` (`NewsItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistnews_t`
--

LOCK TABLES `artistnews_t` WRITE;
/*!40000 ALTER TABLE `artistnews_t` DISABLE KEYS */;
INSERT INTO `artistnews_t` VALUES (10,1),(9,2),(8,3),(7,4),(6,5),(5,6),(4,7),(3,8),(2,9),(1,10);
/*!40000 ALTER TABLE `artistnews_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistpayment_t`
--

DROP TABLE IF EXISTS `artistpayment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistpayment_t` (
  `APaymentID` int NOT NULL,
  `APaymentDate` timestamp NULL DEFAULT NULL,
  `Amount` decimal(12,2) DEFAULT NULL,
  `AdminID` int NOT NULL,
  `ArtistID` int NOT NULL,
  PRIMARY KEY (`APaymentID`,`AdminID`,`ArtistID`),
  KEY `fk_artistpayment_t_admin_t1_idx` (`AdminID`),
  KEY `fk_artistpayment_t_contractedartist_t1_idx` (`ArtistID`),
  CONSTRAINT `fk_artistpayment_t_admin_t1` FOREIGN KEY (`AdminID`) REFERENCES `admin_t` (`AdminID`),
  CONSTRAINT `fk_artistpayment_t_contractedartist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `contractedartist_t` (`ArtistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistpayment_t`
--

LOCK TABLES `artistpayment_t` WRITE;
/*!40000 ALTER TABLE `artistpayment_t` DISABLE KEYS */;
INSERT INTO `artistpayment_t` VALUES (1,'2022-03-08 15:15:00',500.00,1,1),(2,'2022-03-09 17:30:00',750.00,2,2),(3,'2022-03-10 20:45:00',1000.00,3,3),(4,'2022-03-11 22:00:00',250.00,4,4),(5,'2022-03-13 00:15:00',300.00,5,5),(6,'2022-03-14 01:30:00',600.00,6,6),(7,'2022-03-15 03:45:00',900.00,7,7),(8,'2022-03-15 13:00:00',1200.00,8,8),(9,'2022-03-16 15:15:00',1500.00,9,9),(10,'2022-03-17 17:30:00',1800.00,10,10);
/*!40000 ALTER TABLE `artistpayment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_t`
--

DROP TABLE IF EXISTS `contract_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract_t` (
  `ContractID` int NOT NULL,
  `StateDate` timestamp NULL DEFAULT NULL,
  `EndDate` timestamp NULL DEFAULT NULL,
  `RoyaltyPerc` decimal(4,2) DEFAULT NULL,
  `Terms` longtext,
  `ArtistID` int NOT NULL,
  PRIMARY KEY (`ContractID`,`ArtistID`),
  KEY `fk_contract_t_contractedartist_t1_idx` (`ArtistID`),
  CONSTRAINT `fk_contract_t_contractedartist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `contractedartist_t` (`ArtistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_t`
--

LOCK TABLES `contract_t` WRITE;
/*!40000 ALTER TABLE `contract_t` DISABLE KEYS */;
INSERT INTO `contract_t` VALUES (1,'2021-01-01 06:00:00','2022-01-01 06:00:00',10.00,'Standard terms',1),(2,'2022-03-15 05:00:00','2023-03-15 05:00:00',12.50,'Extended terms',2),(3,'2021-06-01 05:00:00','2022-06-01 05:00:00',8.75,'Standard terms',3),(4,'2022-04-30 05:00:00','2023-04-30 05:00:00',15.00,'Extended terms',4),(5,'2021-02-15 06:00:00','2022-02-15 06:00:00',9.50,'Standard terms',5),(6,'2022-05-31 05:00:00','2023-05-31 05:00:00',11.25,'Extended terms',6),(7,'2021-07-01 05:00:00','2022-07-01 05:00:00',7.50,'Standard terms',7),(8,'2022-06-30 05:00:00','2023-06-30 05:00:00',20.00,'Extended terms',8),(9,'2021-04-01 05:00:00','2022-04-01 05:00:00',10.75,'Standard terms',9),(10,'2022-08-31 05:00:00','2023-08-31 05:00:00',16.25,'Extended terms',10);
/*!40000 ALTER TABLE `contract_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contractedartist_t`
--

DROP TABLE IF EXISTS `contractedartist_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contractedartist_t` (
  `ArtistID` int NOT NULL,
  `AManagerID` int NOT NULL,
  PRIMARY KEY (`ArtistID`,`AManagerID`),
  KEY `fk_contractedartist_t_artistmanager_t1_idx` (`AManagerID`),
  CONSTRAINT `fk_contractedartist_t_artist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`),
  CONSTRAINT `fk_contractedartist_t_artistmanager_t1` FOREIGN KEY (`AManagerID`) REFERENCES `artistmanager_t` (`AManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contractedartist_t`
--

LOCK TABLES `contractedartist_t` WRITE;
/*!40000 ALTER TABLE `contractedartist_t` DISABLE KEYS */;
INSERT INTO `contractedartist_t` VALUES (10,1),(9,2),(8,3),(7,4),(6,5),(5,6),(4,7),(3,8),(2,9),(1,10);
/*!40000 ALTER TABLE `contractedartist_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_t`
--

DROP TABLE IF EXISTS `customer_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_t` (
  `CustomerID` int NOT NULL,
  `CustomerName` varchar(100) DEFAULT NULL,
  `Street` varchar(40) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Zip` varchar(9) DEFAULT NULL,
  `Phone` varchar(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_t`
--

LOCK TABLES `customer_t` WRITE;
/*!40000 ALTER TABLE `customer_t` DISABLE KEYS */;
INSERT INTO `customer_t` VALUES (1,'John Smith','123 Main St','Anytown','CA','12345','1235551234','jsmith@gmail.com'),(2,'Jane Doe','456 Elm St','Otherville','NY','67890','2345555678','jane.doe@yahoo.com'),(3,'Bob Johnson','789 Oak St','Smallville','IL','54321','4325559876','bjohnson@hotmail.com'),(4,'Mary Brown','321 Pine St','Bigtown','TX','98765','3455554321','mbrown@aol.com'),(5,'David Lee','654 Cedar St','Midtown','GA','13579','5635552468','dlee@gmail.com'),(6,'Sarah Wilson','987 Birch St','Downtown','MA','02468','2345558642','sarah.wilson@gmail.com'),(7,'Kevin Chen','246 Maple St','Uptown','WA','97531','2355551357','kchen@yahoo.com'),(8,'Amanda Jones','369 Cherry St','Seaside','FL','24680','2525555793','ajones@hotmail.com'),(9,'Michael Kim','802 Walnut St','Rivertown','OH','46802','2115550246','mkim@gmail.com'),(10,'Linda Davis','135 Beach St','Harbortown','MI','80246','5552344680','linda.davis@yahoo.com');
/*!40000 ALTER TABLE `customer_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerpayment_t`
--

DROP TABLE IF EXISTS `customerpayment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerpayment_t` (
  `CPaymentID` int NOT NULL,
  `CPaymentDate` timestamp NOT NULL,
  `Amount` decimal(12,2) NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`CPaymentID`,`CustomerID`),
  KEY `fk_customerpayment_t_customer_t1_idx` (`CustomerID`),
  CONSTRAINT `fk_customerpayment_t_customer_t1` FOREIGN KEY (`CustomerID`) REFERENCES `customer_t` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerpayment_t`
--

LOCK TABLES `customerpayment_t` WRITE;
/*!40000 ALTER TABLE `customerpayment_t` DISABLE KEYS */;
INSERT INTO `customerpayment_t` VALUES (1,'2022-07-01 14:00:00',1500.00,5),(2,'2022-07-15 18:30:00',800.00,1),(3,'2022-08-01 15:00:00',1200.00,7),(4,'2022-08-15 19:00:00',500.00,6),(5,'2022-09-01 16:00:00',2000.00,2),(6,'2022-09-15 20:30:00',1000.00,10),(7,'2022-10-01 17:00:00',1800.00,8),(8,'2022-10-15 21:00:00',600.00,3),(9,'2022-11-01 15:30:00',900.00,9),(10,'2022-11-15 23:00:00',1500.00,4);
/*!40000 ALTER TABLE `customerpayment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degree_t`
--

DROP TABLE IF EXISTS `degree_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `degree_t` (
  `DegreeId` int NOT NULL,
  `DegreeName` varchar(100) DEFAULT NULL,
  `University` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`DegreeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degree_t`
--

LOCK TABLES `degree_t` WRITE;
/*!40000 ALTER TABLE `degree_t` DISABLE KEYS */;
INSERT INTO `degree_t` VALUES (1,'Bachelor of Science in Computer Science','University of California, Los Angeles'),(2,'Master of Business Administration','New York University'),(3,'Bachelor of Arts in Psychology','Stanford University'),(4,'Master of Science in Mechanical Engineering','Georgia Institute of Technology'),(5,'Bachelor of Science in Nursing','University of Pennsylvania'),(6,'Master of Science in Computer Engineering','Carnegie Mellon University'),(7,'Bachelor of Science in Electrical Engineering','Massachusetts Institute of Technology'),(8,'Master of Education in Curriculum and Instruction','University of Michigan'),(9,'Bachelor of Science in Biology','University of Texas at Austin'),(10,'Master of Public Health','Johns Hopkins University');
/*!40000 ALTER TABLE `degree_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_t`
--

DROP TABLE IF EXISTS `event_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_t` (
  `EventID` int NOT NULL,
  `VenueID` int NOT NULL,
  `EventDesc` varchar(400) NOT NULL,
  `DateTime` timestamp NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`EventID`,`VenueID`,`CustomerID`),
  KEY `fk_event_t_venue_t1_idx` (`VenueID`),
  KEY `fk_event_t_customer_t1_idx` (`CustomerID`),
  CONSTRAINT `fk_event_t_customer_t1` FOREIGN KEY (`CustomerID`) REFERENCES `customer_t` (`CustomerID`),
  CONSTRAINT `fk_event_t_venue_t1` FOREIGN KEY (`VenueID`) REFERENCES `venue_t` (`VenueID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_t`
--

LOCK TABLES `event_t` WRITE;
/*!40000 ALTER TABLE `event_t` DISABLE KEYS */;
INSERT INTO `event_t` VALUES (1,4,'Concert','2023-04-02 00:00:00',3),(2,3,'Comedy show','2023-06-11 01:00:00',2),(3,5,'Theater play','2023-08-22 23:30:00',5),(4,1,'Festival','2023-07-17 19:00:00',9),(5,6,'Dance performance','2023-05-06 00:30:00',7),(6,2,'Live music','2023-09-03 02:00:00',1),(7,5,'Comedy show','2023-10-13 01:00:00',8),(8,4,'Theater play','2023-11-26 01:00:00',4),(9,3,'Concert','2023-08-08 23:00:00',6),(10,2,'Festival','2023-06-26 19:00:00',10);
/*!40000 ALTER TABLE `event_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_t`
--

DROP TABLE IF EXISTS `expense_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_t` (
  `ExpenseID` int NOT NULL,
  `Description` varchar(400) NOT NULL,
  `Amount` decimal(12,2) NOT NULL,
  `AccountNbr` bigint NOT NULL,
  `ExpenseType` char(1) NOT NULL,
  PRIMARY KEY (`ExpenseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_t`
--

LOCK TABLES `expense_t` WRITE;
/*!40000 ALTER TABLE `expense_t` DISABLE KEYS */;
INSERT INTO `expense_t` VALUES (1,'Catering for event',1500.00,123456789,'E'),(2,'Sound equipment rental',1000.00,987654321,'E'),(3,'Venue rental fee',2000.00,246810121,'E'),(4,'Advertising expense',500.00,135790864,'E'),(5,'Artist fee',2500.00,555555555,'E'),(6,'Travel expenses',800.00,777777777,'E'),(7,'Printing and postage',300.00,444444444,'E'),(8,'Event insurance',700.00,888888888,'E'),(9,'Decorations for event',400.00,222222222,'E'),(10,'Security services for event',1200.00,999999999,'E');
/*!40000 ALTER TABLE `expense_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `honor_t`
--

DROP TABLE IF EXISTS `honor_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `honor_t` (
  `HonorID` int NOT NULL,
  `HonorDesc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`HonorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `honor_t`
--

LOCK TABLES `honor_t` WRITE;
/*!40000 ALTER TABLE `honor_t` DISABLE KEYS */;
INSERT INTO `honor_t` VALUES (1,'honor1'),(2,'honor2'),(3,'honor3'),(4,'honor4'),(5,'honor5'),(6,'honor6'),(7,'honor7'),(8,'honor8'),(9,'honor9'),(10,'honor10');
/*!40000 ALTER TABLE `honor_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instrument_t`
--

DROP TABLE IF EXISTS `instrument_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instrument_t` (
  `InstrumentID` int NOT NULL,
  `InstrumentName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`InstrumentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instrument_t`
--

LOCK TABLES `instrument_t` WRITE;
/*!40000 ALTER TABLE `instrument_t` DISABLE KEYS */;
INSERT INTO `instrument_t` VALUES (1,'piano'),(2,'gitar'),(3,'drums'),(4,'violin'),(5,'sexophone'),(6,'trumpet'),(7,'bassgitar'),(8,'cello'),(9,'flute'),(10,'vocal');
/*!40000 ALTER TABLE `instrument_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_t`
--

DROP TABLE IF EXISTS `invoice_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_t` (
  `InvoiceNbr` int NOT NULL,
  `InvoiceDate` timestamp NULL DEFAULT NULL,
  `Total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`InvoiceNbr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_t`
--

LOCK TABLES `invoice_t` WRITE;
/*!40000 ALTER TABLE `invoice_t` DISABLE KEYS */;
INSERT INTO `invoice_t` VALUES (1,'2022-07-01 14:00:00',1500.00),(2,'2022-07-15 18:30:00',800.00),(3,'2022-08-01 15:00:00',1200.00),(4,'2022-08-15 19:00:00',500.00),(5,'2022-09-01 16:00:00',2000.00),(6,'2022-09-15 20:30:00',1000.00),(7,'2022-10-01 17:00:00',1800.00),(8,'2022-10-15 21:00:00',600.00),(9,'2022-11-01 15:30:00',900.00),(10,'2022-11-15 23:00:00',1500.00);
/*!40000 ALTER TABLE `invoice_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoicepayment_t`
--

DROP TABLE IF EXISTS `invoicepayment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoicepayment_t` (
  `InvoiceNbr` int NOT NULL,
  `CPaymentID` int NOT NULL,
  `Amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`InvoiceNbr`,`CPaymentID`),
  KEY `fk_invoicepayment_t_invoice_t1_idx` (`InvoiceNbr`),
  KEY `fk_invoicepayment_t_customerpayment_t1` (`CPaymentID`),
  CONSTRAINT `fk_invoicepayment_t_customerpayment_t1` FOREIGN KEY (`CPaymentID`) REFERENCES `customerpayment_t` (`CPaymentID`),
  CONSTRAINT `fk_invoicepayment_t_invoice_t1` FOREIGN KEY (`InvoiceNbr`) REFERENCES `invoice_t` (`InvoiceNbr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoicepayment_t`
--

LOCK TABLES `invoicepayment_t` WRITE;
/*!40000 ALTER TABLE `invoicepayment_t` DISABLE KEYS */;
INSERT INTO `invoicepayment_t` VALUES (1,1,1500.00),(2,2,800.00),(3,3,1200.00),(4,4,500.00),(5,5,2000.00),(6,6,1000.00),(7,7,1800.00),(8,8,600.00),(9,9,900.00),(10,10,1500.00);
/*!40000 ALTER TABLE `invoicepayment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsitem_t`
--

DROP TABLE IF EXISTS `newsitem_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsitem_t` (
  `NewsItemID` int NOT NULL,
  `NewsItemSource` varchar(100) DEFAULT NULL,
  `NewsItemDate` timestamp NULL DEFAULT NULL,
  `NewsItemSummary` varchar(4000) DEFAULT NULL,
  `NewsItemContent` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`NewsItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsitem_t`
--

LOCK TABLES `newsitem_t` WRITE;
/*!40000 ALTER TABLE `newsitem_t` DISABLE KEYS */;
INSERT INTO `newsitem_t` VALUES (1,'CNN','2022-11-20 18:34:56','New study shows benefits of daily exercise','A new study published today in the Journal of Health and Fitness suggests that even a small amount of daily exercise can have significant health benefits.'),(2,'BBC','2022-12-01 15:15:00','Major tech company announces new smartphone model','Apple has announced the release of their latest smartphone model, the iPhone 14, which boasts a range of new features and improvements over its predecessor.'),(3,'Reuters','2022-12-15 22:23:45','Global stock markets experience major sell-off','Stock markets around the world suffered major losses today as fears of inflation and rising interest rates led to a sell-off of equities and other risk assets.'),(4,'The Guardian','2023-01-02 14:00:00','Scientists discover new species of dinosaur in Patagonia','A team of scientists from Argentina and the UK have discovered a new species of dinosaur in Patagonia, which they have named Tralkasaurus.'),(5,'Al Jazeera','2023-01-21 00:45:30','Violent protests erupt in capital city','Protests turned violent today in the capital city as demonstrators clashed with police and set fire to several buildings.'),(6,'CNN','2023-02-05 17:11:11','Major winter storm causes travel chaos','A winter storm bringing heavy snow and freezing temperatures has caused major disruption to travel across the region, with many flights and trains cancelled or delayed.'),(7,'The New York Times','2023-02-10 20:30:00','President announces new infrastructure spending plan','President Smith today announced a new $2 trillion infrastructure spending plan aimed at improving roads, bridges, and other critical infrastructure across the country.'),(8,'BBC','2023-02-20 12:00:00','UK economy grows faster than expected','The UK economy grew by 2.4% in the last quarter of 2022, outpacing expectations and providing a boost to businesses and consumers alike.'),(9,'Reuters','2023-03-01 23:00:00','New study finds link between sugar and cancer','A new study published in the Journal of Cancer Research has found a link between high sugar consumption and an increased risk of certain types of cancer.'),(10,'Al Jazeera','2023-03-06 04:15:00','Peace talks between two countries break down','Talks aimed at resolving a long-standing conflict between the two countries have broken down, with both sides blaming the other for the lack of progress.');
/*!40000 ALTER TABLE `newsitem_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `performancerelatedc_t`
--

DROP TABLE IF EXISTS `performancerelatedc_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `performancerelatedc_t` (
  `PRCCategory` char(1) NOT NULL,
  `ACommitmentID` int NOT NULL,
  `EventID` int NOT NULL,
  PRIMARY KEY (`ACommitmentID`,`EventID`),
  KEY `fk_performancerelatedc_t_event_t1_idx` (`EventID`),
  CONSTRAINT `fk_performancerelatedc_t_artistcommitment_t1` FOREIGN KEY (`ACommitmentID`) REFERENCES `artistcommitment_t` (`ACommitmentID`),
  CONSTRAINT `fk_performancerelatedc_t_event_t1` FOREIGN KEY (`EventID`) REFERENCES `event_t` (`EventID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performancerelatedc_t`
--

LOCK TABLES `performancerelatedc_t` WRITE;
/*!40000 ALTER TABLE `performancerelatedc_t` DISABLE KEYS */;
INSERT INTO `performancerelatedc_t` VALUES ('D',1,4),('E',2,5),('A',3,8),('A',4,1),('B',5,7),('B',6,10),('C',7,2),('W',8,3),('X',9,6),('Q',10,9);
/*!40000 ALTER TABLE `performancerelatedc_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personalc_t`
--

DROP TABLE IF EXISTS `personalc_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personalc_t` (
  `ACommitmentID` int NOT NULL,
  `Firmness` char(1) DEFAULT NULL,
  PRIMARY KEY (`ACommitmentID`),
  CONSTRAINT `fk_personalc_t_artistcommitment_t1` FOREIGN KEY (`ACommitmentID`) REFERENCES `artistcommitment_t` (`ACommitmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personalc_t`
--

LOCK TABLES `personalc_t` WRITE;
/*!40000 ALTER TABLE `personalc_t` DISABLE KEYS */;
INSERT INTO `personalc_t` VALUES (1,'A'),(2,'B'),(3,'M'),(4,'S'),(5,'T'),(6,'W'),(7,'F'),(8,'F'),(9,'M'),(10,'S');
/*!40000 ALTER TABLE `personalc_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospectiveartist_t`
--

DROP TABLE IF EXISTS `prospectiveartist_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospectiveartist_t` (
  `ArtistID` int NOT NULL,
  PRIMARY KEY (`ArtistID`),
  CONSTRAINT `fk_prospectiveartist_t_artist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `artist_t` (`ArtistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospectiveartist_t`
--

LOCK TABLES `prospectiveartist_t` WRITE;
/*!40000 ALTER TABLE `prospectiveartist_t` DISABLE KEYS */;
INSERT INTO `prospectiveartist_t` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
/*!40000 ALTER TABLE `prospectiveartist_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation_t`
--

DROP TABLE IF EXISTS `recommendation_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation_t` (
  `RecommendationID` int NOT NULL,
  `RecSummary` varchar(1000) NOT NULL,
  `QualityEvaluation` varchar(500) NOT NULL,
  `ReceivedDate` timestamp NOT NULL,
  `CreatedDate` timestamp NOT NULL,
  `ArtistID` int NOT NULL,
  `SourceID` int NOT NULL,
  PRIMARY KEY (`RecommendationID`,`ArtistID`,`SourceID`),
  KEY `fk_recommendation_t_prospectiveartist_t1_idx` (`ArtistID`),
  KEY `fk_recommendation_t_source_t1_idx` (`SourceID`),
  CONSTRAINT `fk_recommendation_t_prospectiveartist_t1` FOREIGN KEY (`ArtistID`) REFERENCES `prospectiveartist_t` (`ArtistID`),
  CONSTRAINT `fk_recommendation_t_source_t1` FOREIGN KEY (`SourceID`) REFERENCES `source_t` (`SourceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation_t`
--

LOCK TABLES `recommendation_t` WRITE;
/*!40000 ALTER TABLE `recommendation_t` DISABLE KEYS */;
INSERT INTO `recommendation_t` VALUES (1,'A great recommendation for this artist.','The quality of the work was excellent.','2022-01-01 18:00:00','2022-01-02 16:00:00',1,1),(2,'I highly recommend this artist.','Their attention to detail was impressive.','2022-02-01 20:00:00','2022-02-02 17:00:00',2,2),(3,'This artist exceeded expectations.','The artwork was stunning and well-crafted.','2022-03-01 22:00:00','2022-03-02 18:00:00',3,3),(4,'A great artist who is a pleasure to work with.','The quality of their work is consistently impressive.','2022-04-01 23:00:00','2022-04-02 18:00:00',4,4),(5,'I strongly recommend this artist.','Their work is of the highest quality.','2022-05-02 01:00:00','2022-05-02 19:00:00',5,5),(6,'An artist with a unique vision.','Their work is always thought-provoking and inspiring.','2022-06-02 03:00:00','2022-06-02 20:00:00',6,6),(7,'This artist is incredibly talented.','Their work is of the highest caliber.','2022-07-01 13:00:00','2022-07-02 21:00:00',7,7),(8,'An artist who consistently produces excellent work.','Their attention to detail is impressive.','2022-08-01 15:00:00','2022-08-02 22:00:00',8,8),(9,'I strongly recommend this artist.','Their work is always unique and inspiring.','2022-09-01 17:00:00','2022-09-02 23:00:00',9,9),(10,'This artist is an excellent choice.','Their work is consistently of the highest quality.','2022-10-01 19:00:00','2022-10-03 00:00:00',10,10);
/*!40000 ALTER TABLE `recommendation_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source_t`
--

DROP TABLE IF EXISTS `source_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source_t` (
  `SourceID` int NOT NULL,
  `SourceName` varchar(50) DEFAULT NULL,
  `SourceType` varchar(20) DEFAULT NULL,
  `Quality` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`SourceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source_t`
--

LOCK TABLES `source_t` WRITE;
/*!40000 ALTER TABLE `source_t` DISABLE KEYS */;
INSERT INTO `source_t` VALUES (1,'The New York Times','Newspaper',8),(2,'CNN','Television',7),(3,'The Guardian','Newspaper',9),(4,'BBC News','Television',8),(5,'The Wall Street Journal','Newspaper',7),(6,'NBC News','Television',7),(7,'Al Jazeera','Television',9),(8,'The Washington Post','Newspaper',8),(9,'Fox News','Television',6),(10,'Bloomberg News','Newspaper',8);
/*!40000 ALTER TABLE `source_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue_t`
--

DROP TABLE IF EXISTS `venue_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venue_t` (
  `VenueID` int NOT NULL,
  `VenueName` varchar(50) NOT NULL,
  `Street` varchar(40) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Zip` varchar(9) DEFAULT NULL,
  `Phone` char(10) NOT NULL,
  `Country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`VenueID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue_t`
--

LOCK TABLES `venue_t` WRITE;
/*!40000 ALTER TABLE `venue_t` DISABLE KEYS */;
INSERT INTO `venue_t` VALUES (1,'Sunset Lounge','123 Main St','Los Angeles','CA','90001','3425551234','USA'),(2,'The Blue Note','456 5th Ave','New York','NY','10001','5554325678','USA'),(3,'The Jazz Loft','789 10th St','San Francisco','CA','94102','5553459012','USA'),(4,'The Jazz Corner','321 Oak St','Chicago','IL','60601','5554533456','USA'),(5,'The Jazz Room','567 Elm St','Boston','MA','02101','5554647890','USA'),(6,'The Velvet Lounge','2468 Broadway','Seattle','WA','98101','5553422345','USA'),(7,'The Jazz Cafe','1357 Market St','Philadelphia','PA','19101','5557656789','USA'),(8,'The Jazz Factory','91011 Wall St','Houston','TX','77001','5551230123','USA'),(9,'The Jazz Spot','1213 Park Ave','Atlanta','GA','30301','5552344567','USA'),(10,'The Jazz Cellar','1415 Vine St','Denver','CO','80201','5552648901','USA');
/*!40000 ALTER TABLE `venue_t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-02 16:15:26
