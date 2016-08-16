# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: property.coz6tg30r0u1.us-east-1.rds.amazonaws.com (MySQL 5.6.10)
# Database: property
# Generation Time: 2016-08-10 17:25:33 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table DOB Permit Issuance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DOB Permit Issuance`;

CREATE TABLE `DOB Permit Issuance` (
  `BOROUGH` varchar(255) DEFAULT NULL,
  `Bin #` int(11) NOT NULL DEFAULT '0',
  `House #` varchar(255) DEFAULT NULL,
  `Street Name` varchar(255) DEFAULT NULL,
  `Job #` bigint(11) NOT NULL DEFAULT '0',
  `Job doc. #` varchar(255) DEFAULT NULL,
  `Job Type` varchar(255) DEFAULT NULL,
  `Self_Cert` varchar(255) DEFAULT NULL,
  `Block` varchar(255) DEFAULT NULL,
  `Lot` varchar(255) DEFAULT NULL,
  `Community Board` int(11) DEFAULT NULL,
  `Zip Code` int(11) DEFAULT NULL,
  `Bldg Type` int(11) DEFAULT NULL,
  `Residential` varchar(255) DEFAULT NULL,
  `Special District 1` varchar(255) DEFAULT NULL,
  `Special District 2` varchar(255) DEFAULT NULL,
  `Work Type` varchar(255) DEFAULT NULL,
  `Permit Status` varchar(255) DEFAULT NULL,
  `Filing Status` varchar(255) DEFAULT NULL,
  `Permit Type` varchar(255) DEFAULT NULL,
  `Permit Sequence #` varchar(255) DEFAULT NULL,
  `Permit Subtype` varchar(255) DEFAULT NULL,
  `Oil Gas` varchar(255) DEFAULT NULL,
  `Site Fill` varchar(255) DEFAULT NULL,
  `Filing Date` varchar(255) DEFAULT NULL,
  `Issuance Date` varchar(255) DEFAULT NULL,
  `Expiration Date` varchar(255) DEFAULT NULL,
  `Job Start Date` varchar(255) DEFAULT NULL,
  `Permittee's First Name` varchar(255) DEFAULT NULL,
  `Permittee's Last Name` varchar(255) DEFAULT NULL,
  `Permittee's Business Name` varchar(255) DEFAULT NULL,
  `Permittee's Phone #` bigint(11) DEFAULT NULL,
  `Permittee's License Type` varchar(255) DEFAULT NULL,
  `Permittee's License #` varchar(255) DEFAULT NULL,
  `Act as Superintendent` varchar(255) DEFAULT NULL,
  `Permittee's Other Title` varchar(255) DEFAULT NULL,
  `HIC License` varchar(255) DEFAULT NULL,
  `Site Safety Mgr's First Name` varchar(255) DEFAULT NULL,
  `Site Safety Mgr's Last Name` varchar(255) DEFAULT NULL,
  `Site Safety Mgr Business Name` varchar(255) DEFAULT NULL,
  `Superintendent First & Last Name` varchar(255) DEFAULT NULL,
  `Superintendent Business Name` varchar(255) DEFAULT NULL,
  `Owner's Business Type` varchar(255) DEFAULT NULL,
  `Non-Profit` varchar(255) DEFAULT NULL,
  `Owner's Business Name` varchar(255) DEFAULT NULL,
  `Owner's First Name` varchar(255) DEFAULT NULL,
  `Owner's Last Name` varchar(255) DEFAULT NULL,
  `Owner's House #` varchar(255) DEFAULT NULL,
  `Owner's House Street Name` varchar(255) DEFAULT NULL,
  `Owner’s House City` varchar(255) DEFAULT NULL,
  `Owner’s House State` varchar(255) DEFAULT NULL,
  `Owner’s House Zip Code` varchar(255) DEFAULT NULL,
  `Owner's Phone #` varchar(255) DEFAULT NULL,
  `DOBRunDate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Job #`),
  KEY `Building` (`Bin #`),
  CONSTRAINT `Building` FOREIGN KEY (`Bin #`) REFERENCES `NYC Buildings` (`bin`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='https://data.cityofnewyork.us/Housing-Development/Historical-DOB-Permit-Issuance/fqsa-ugc6\n\nHistorical DOB Permit Issuance\nA list of permits issued between January 1 2000 through April 24, 2013.';



# Dump of table Legally Operating Businesses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Legally Operating Businesses`;

CREATE TABLE `Legally Operating Businesses` (
  `DCA License Number` varchar(255) NOT NULL DEFAULT '',
  `License Type` varchar(255) DEFAULT NULL,
  `License Expiration Date` varchar(255) DEFAULT NULL,
  `License Category` varchar(255) DEFAULT NULL,
  `Business Name` varchar(255) DEFAULT NULL,
  `Business Name 2` varchar(255) DEFAULT NULL,
  `Address Building` varchar(255) DEFAULT NULL,
  `Address Street Name` varchar(255) DEFAULT NULL,
  `Secondary Address Street Name` varchar(255) DEFAULT NULL,
  `Address City` varchar(255) DEFAULT NULL,
  `Address State` varchar(255) DEFAULT NULL,
  `Address ZIP` varchar(255) DEFAULT NULL,
  `Contact Phone Number` varchar(255) DEFAULT NULL,
  `Address Borough` varchar(255) DEFAULT NULL,
  `Detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DCA License Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table NYC Buildings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `NYC Buildings`;

CREATE TABLE `NYC Buildings` (
  `boro` int(11) DEFAULT NULL,
  `block` int(11) DEFAULT NULL,
  `lot` int(11) DEFAULT NULL,
  `bin` int(11) NOT NULL DEFAULT '0',
  `lhnd` varchar(255) DEFAULT NULL,
  `lhns` varchar(255) DEFAULT NULL,
  `lcontpar` varchar(255) DEFAULT NULL,
  `lsos` varchar(255) DEFAULT NULL,
  `hhnd` varchar(255) DEFAULT NULL,
  `hhns` varchar(255) DEFAULT NULL,
  `hcontpar` varchar(255) DEFAULT NULL,
  `hsos` varchar(255) DEFAULT NULL,
  `scboro` int(11) DEFAULT NULL,
  `sc5` int(11) DEFAULT NULL,
  `sclgc` int(11) DEFAULT NULL,
  `stname` varchar(255) DEFAULT NULL,
  `addrtype` varchar(255) DEFAULT NULL,
  `realb7sc` varchar(255) DEFAULT NULL,
  `validlgcs` varchar(255) DEFAULT NULL,
  `parity` varchar(255) DEFAULT NULL,
  `b10sc` bigint(11) DEFAULT NULL,
  `segid` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table NYC Open Data Available Datasets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `NYC Open Data Available Datasets`;

CREATE TABLE `NYC Open Data Available Datasets` (
  `Agency` varchar(255) NOT NULL DEFAULT '',
  `Dataset` varchar(255) NOT NULL DEFAULT '',
  `Dataset description` text,
  PRIMARY KEY (`Agency`,`Dataset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='https://data.cityofnewyork.us/dataset/NYC-Open-Data-Available-Datasets/j9m9-eu6n\n\nNYC Open Data Available Datasets\nBased on NYC Open Data Plan Dashboard Values\nA listing of all available and planned datasets for use in feeding API calls and embedded lists on the NYC Open Data Compliance Plan Dashboard';



# Dump of table Restaurant Inspection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Restaurant Inspection`;

CREATE TABLE `Restaurant Inspection` (
  `CAMIS` int(11) NOT NULL DEFAULT '0',
  `DBA` varchar(255) DEFAULT NULL,
  `BORO` varchar(255) DEFAULT NULL,
  `BUILDING` varchar(255) NOT NULL DEFAULT '',
  `STREET` varchar(255) DEFAULT NULL,
  `ZIPCODE` int(11) DEFAULT NULL,
  `PHONE` bigint(11) DEFAULT NULL,
  `CUISINE DESCRIPTION` varchar(255) DEFAULT NULL,
  `INSPECTION DATE` varchar(255) NOT NULL DEFAULT '',
  `ACTION` varchar(255) DEFAULT NULL,
  `VIOLATION CODE` varchar(255) DEFAULT NULL,
  `VIOLATION DESCRIPTION` mediumtext,
  `CRITICAL FLAG` varchar(255) DEFAULT NULL,
  `SCORE` varchar(255) DEFAULT NULL,
  `GRADE` varchar(255) DEFAULT NULL,
  `GRADE DATE` varchar(255) DEFAULT NULL,
  `RECORD DATE` varchar(255) DEFAULT NULL,
  `INSPECTION TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CAMIS`,`INSPECTION DATE`,`BUILDING`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/xx67-kt59\n\n\n\nDOHMH New York City Restaurant Inspection Results\nBased on DOHMH New York City Restaurant Inspection Results\nThis dataset provides restaurant inspections, violations, grades and adjudication information';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
