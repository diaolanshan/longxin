CREATE DATABASE  IF NOT EXISTS `longxin` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `longxin`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: longxin
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREATED_AT` datetime DEFAULT NULL,
  `FILE_NAME` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `OWNER` int(11) DEFAULT NULL,
  `CATEGORY` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `REFERENCE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_USERS_idx` (`OWNER`),
  CONSTRAINT `FK_USERS` FOREIGN KEY (`OWNER`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change_history`
--

DROP TABLE IF EXISTS `change_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_history` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY` varchar(45) COLLATE utf8_bin NOT NULL,
  `OPERATOR` int(11) NOT NULL,
  `UPDATED_AT` datetime NOT NULL,
  `REFERENCE_ID` int(11) NOT NULL,
  `OLD_VALUE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `NEW_VALUE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `OPERATION_TYPE` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `COMMENTS` varchar(1028) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `HISTORY_FK1_idx` (`OPERATOR`),
  CONSTRAINT `HISTORY_FK1` FOREIGN KEY (`OPERATOR`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departmentname` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PRODUCT` int(11) NOT NULL,
  `FEATURE_NAME` varchar(128) NOT NULL,
  `TEMPLATE` int(11) DEFAULT NULL,
  `ICON_NAME` varchar(45) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FEATURE_FK1_idx` (`PRODUCT`),
  CONSTRAINT `FEATURE_FK1` FOREIGN KEY (`PRODUCT`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `function_module`
--

DROP TABLE IF EXISTS `function_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `function_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) COLLATE utf8_bin NOT NULL,
  `FEATURE` int(11) NOT NULL,
  `DESCRIPTION` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `TEMPLATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `FK1_idx` (`FEATURE`),
  KEY `FM_FK1_idx` (`FEATURE`),
  CONSTRAINT `FEATURE_MODULE_FK1` FOREIGN KEY (`FEATURE`) REFERENCES `feature` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l1_component`
--

DROP TABLE IF EXISTS `l1_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l1_component` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `MODULE` int(11) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  `TEMPLATE` int(11) DEFAULT '0',
  `IS_DRAFT` int(11) DEFAULT NULL,
  `FUNCTION_MODULE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `COMPONENT_FK_1_idx` (`MODULE`),
  KEY `FK2_idx` (`FUNCTION_MODULE`),
  CONSTRAINT `FK1` FOREIGN KEY (`MODULE`) REFERENCES `module` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2` FOREIGN KEY (`FUNCTION_MODULE`) REFERENCES `function_module` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l1_component_parameter`
--

DROP TABLE IF EXISTS `l1_component_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l1_component_parameter` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARAMETER_NAME` varchar(128) NOT NULL,
  `PARAMETER_VALUE` varchar(256) DEFAULT NULL,
  `UNIT_NAME` varchar(45) DEFAULT NULL,
  `OPTIONS` varchar(512) DEFAULT NULL,
  `L1_COMPONENT` int(11) DEFAULT NULL,
  `MIN_VALUE` varchar(45) DEFAULT NULL,
  `MAX_VALUE` varchar(45) DEFAULT NULL,
  `IS_DRAFT` int(11) DEFAULT NULL,
  `DRAFT_VALUE` varchar(256) DEFAULT NULL,
  `SCOPE_STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK1_idx` (`L1_COMPONENT`),
  KEY `idx` (`MIN_VALUE`),
  CONSTRAINT `L1_FK1` FOREIGN KEY (`L1_COMPONENT`) REFERENCES `l1_component` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l2_component`
--

DROP TABLE IF EXISTS `l2_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l2_component` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `L1` int(11) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  `TEMPLATE` int(11) DEFAULT '0',
  `IS_DRAFT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_idx` (`L1`),
  CONSTRAINT `L2_FK1` FOREIGN KEY (`L1`) REFERENCES `l1_component` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l2_component_parameter`
--

DROP TABLE IF EXISTS `l2_component_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l2_component_parameter` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARAMETER_NAME` varchar(45) DEFAULT NULL,
  `PARAMETER_VALUE` varchar(512) DEFAULT NULL,
  `UNIT_NAME` varchar(45) DEFAULT NULL,
  `OPTIONS` varchar(512) DEFAULT NULL,
  `L2_COMPONENT` int(11) DEFAULT NULL,
  `MIN_VALUE` varchar(45) DEFAULT NULL,
  `MAX_VALUE` varchar(45) DEFAULT NULL,
  `IS_DRAFT` int(11) DEFAULT NULL,
  `DRAFT_VALUE` varchar(256) DEFAULT NULL,
  `SCOPE_STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK1_idx` (`L2_COMPONENT`),
  CONSTRAINT `L2_FKK1` FOREIGN KEY (`L2_COMPONENT`) REFERENCES `l2_component` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l3_component`
--

DROP TABLE IF EXISTS `l3_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l3_component` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `L2` int(11) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  `TEMPLATE` int(11) DEFAULT '0',
  `IS_DRAFT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FFFFK_idx` (`L2`),
  CONSTRAINT `L3_FKK1` FOREIGN KEY (`L2`) REFERENCES `l2_component` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `l3_component_parameter`
--

DROP TABLE IF EXISTS `l3_component_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l3_component_parameter` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARAMETER_NAME` varchar(45) DEFAULT NULL,
  `PARAMETER_VALUE` varchar(128) DEFAULT NULL,
  `UNIT_NAME` varchar(45) DEFAULT NULL,
  `OPTIONS` varchar(512) DEFAULT NULL,
  `L3_COMPONENT` int(11) DEFAULT NULL,
  `MIN_VALUE` varchar(45) DEFAULT NULL,
  `MAX_VALUE` varchar(45) DEFAULT NULL,
  `IS_DRAFT` int(11) DEFAULT NULL,
  `DRAFT_VALUE` varchar(256) DEFAULT NULL,
  `SCOPE_STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `L3_FK1_idx` (`L3_COMPONENT`),
  CONSTRAINT `L3_FK1` FOREIGN KEY (`L3_COMPONENT`) REFERENCES `l3_component` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FEATURE` int(11) NOT NULL,
  `MODULE_NAME` varchar(128) DEFAULT NULL,
  `TEMPLATE` int(11) DEFAULT NULL,
  `DESCRIPTION` varchar(256) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FUNCTION_FK1_idx` (`FEATURE`),
  CONSTRAINT `FUNCTION_FK1` FOREIGN KEY (`FEATURE`) REFERENCES `feature` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `createdat` datetime NOT NULL,
  `TEMPLATE` int(11) DEFAULT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `function_name` varchar(1024) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_OWNER_idx` (`owner`),
  CONSTRAINT `FK_OWNER` FOREIGN KEY (`owner`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requirements`
--

DROP TABLE IF EXISTS `requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requirements` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SEQUENCE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `NAME` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_DATE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `ORIGIN_NO` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `G_REQUIREMENT` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_SCOPE` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMERA` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMERB` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMERC` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMERD` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BRANDA` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BRANDB` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BRANDC` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BRANDD` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `AA_COMPONENT` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `AA_RESULT` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `AA_REQUIREMENT` varchar(245) COLLATE utf8_bin DEFAULT NULL,
  `AA_SCOPE` varchar(245) COLLATE utf8_bin DEFAULT NULL,
  `TRACK_DOCUMENT` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CONFIRMED_RESULT` varchar(245) COLLATE utf8_bin DEFAULT NULL,
  `RESPONSIBLE` varchar(245) COLLATE utf8_bin DEFAULT NULL,
  `ORIGIN_PLAN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `UPDATE_DATE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `CLOSE_DATE` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `FINAL_RESULT` varchar(245) COLLATE utf8_bin DEFAULT NULL,
  `PRODUCT` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `REQUIREMENT_FK1_idx` (`PRODUCT`),
  CONSTRAINT `REQUIREMENT_FK1` FOREIGN KEY (`PRODUCT`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_feature_matrix`
--

DROP TABLE IF EXISTS `user_feature_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_feature_matrix` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER` int(11) NOT NULL,
  `FEATURE` int(11) NOT NULL,
  `CREATED_AT` datetime NOT NULL,
  `CREATED_BY` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `FK1_FEATURE_idx` (`FEATURE`),
  KEY `FK2_USER_idx` (`USER`),
  KEY `FK3_CREATOR_idx` (`CREATED_BY`),
  CONSTRAINT `FK1_FEATURE` FOREIGN KEY (`FEATURE`) REFERENCES `feature` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_USER` FOREIGN KEY (`USER`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_CREATOR` FOREIGN KEY (`CREATED_BY`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(256) DEFAULT NULL,
  `createdat` datetime NOT NULL,
  `role` varchar(128) NOT NULL,
  `department` int(11) DEFAULT NULL,
  `telephone` varchar(256) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department` (`department`),
  KEY `role` (`role`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'longxin'
--

--
-- Dumping routines for database 'longxin'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-22 10:15:13
