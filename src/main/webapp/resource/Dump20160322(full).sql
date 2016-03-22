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
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
INSERT INTO `attachment` VALUES (43,'2015-06-11 15:22:43','jetty.xml',1,'l2component',107),(44,'2015-06-22 09:17:49','jmx.access',1,'FEATURE',4),(55,'2016-01-09 13:04:29','Copy of 知识库问题清单(2).xlsx',1,'FEATURE',24),(56,'2016-01-09 13:04:33','attachment-del.png',1,'FEATURE',24),(63,'2016-01-09 13:17:12','attachment.png',1,'MODULE',57),(68,'2016-01-09 13:44:16','attachment.png',1,'L1COMPONENT',406),(72,'2016-01-09 15:07:21','Copy of 知识库问题清单(2).xlsx',1,'l2component',133),(73,'2016-01-09 15:07:35','Copy of 知识库问题清单(2).xlsx',1,'l2component',133),(74,'2016-01-09 15:07:47','Copy of 知识库问题清单(2).xlsx',1,'l3component',1),(75,'2016-01-09 15:10:40','Copy of 知识库问题清单(2).xlsx',1,'L2COMPONENT',133),(83,'2016-01-09 16:15:44','Copy of 知识库问题清单(2).xlsx',1,'MODULE',57),(84,'2016-01-09 16:31:39','Copy of 知识库问题清单(2).xlsx',1,'FUNCTIONMODULE',57);
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `change_history`
--

LOCK TABLES `change_history` WRITE;
/*!40000 ALTER TABLE `change_history` DISABLE KEYS */;
INSERT INTO `change_history` VALUES (147,'L2COMPONENTPARAMETER',1,'2015-06-11 15:23:34',62,'DELL','DELL','ADD','初始化'),(148,'L2COMPONENTPARAMETER',1,'2015-06-11 15:24:22',62,'IBM','IBM','CHANGE','从HP变为IBM'),(149,'L2COMPONENTPARAMETER',1,'2015-06-11 15:24:44',62,'DELL','DELL','CHANGE',''),(150,'L2COMPONENTPARAMETER',1,'2015-06-11 17:06:32',62,'BOSCH','BOSCH','CHANGE',''),(151,'L2COMPONENTPARAMETER',1,'2015-06-11 17:11:40',62,'Oracle','Oracle','CHANGE',''),(152,'L2COMPONENTPARAMETER',1,'2015-06-11 17:13:20',62,'BOSCH','BOSCH','CHANGE',''),(153,'L2COMPONENTPARAMETER',1,'2015-06-11 17:13:45',62,'HP','HP','CHANGE',''),(154,'L2COMPONENTPARAMETER',1,'2015-06-11 17:15:18',62,'HP','BOSCH','CHANGE',''),(155,'L2COMPONENTPARAMETER',6,'2015-06-12 09:25:16',62,'BOSCH','XIAOMI','CHANGE',''),(156,'L2COMPONENTPARAMETER',1,'2015-06-12 10:29:43',63,'1000','1500','CHANGE',''),(157,'L2COMPONENTPARAMETER',1,'2015-06-12 10:32:22',63,'1500','1501','CHANGE','博世新要求'),(158,'L2COMPONENTPARAMETER',1,'2015-06-14 15:17:45',64,'','','ADD',''),(159,'L2COMPONENTPARAMETER',1,'2015-06-14 15:17:49',64,'','','DELETE',NULL),(160,'L2COMPONENTPARAMETER',1,'2015-06-14 15:34:35',65,'','','ADD',''),(161,'L2COMPONENTPARAMETER',1,'2015-06-14 15:34:38',65,'','','DELETE',NULL),(162,'L2COMPONENTPARAMETER',1,'2015-06-21 23:14:12',65,'XIAOMI','XIAOMI壹','CHANGE',''),(163,'L1COMPONENTPARAMETER',1,'2015-06-22 21:30:38',3,'aa','aav','CHANGE',''),(164,'L1COMPONENTPARAMETER',1,'2015-06-22 21:35:34',7,'aaaa','aaaa','ADD','aaaaaaa'),(165,'L2COMPONENTPARAMETER',6,'2015-06-28 10:23:39',62,'XIAOMI','DELL','CHANGE',''),(166,'L2COMPONENTPARAMETER',6,'2015-06-28 10:23:50',62,'DELL','DELLL','CHANGE',''),(167,'L1COMPONENTPARAMETER',1,'2015-06-29 21:52:35',8,'aa','aa','ADD',''),(168,'L1COMPONENTPARAMETER',1,'2015-06-29 21:53:14',8,'aa','bb','CHANGE','需要更改这个的值'),(169,'L1COMPONENTPARAMETER',1,'2015-06-29 21:57:41',8,'bb','bc','CHANGE','dddddddddddd'),(170,'L1COMPONENTPARAMETER',1,'2015-06-29 22:17:01',9,'c','c','ADD',''),(171,'L1COMPONENTPARAMETER',1,'2015-06-29 22:17:20',10,'b','b','ADD',''),(172,'L1COMPONENTPARAMETER',1,'2015-06-29 22:21:48',11,'d','d','ADD',''),(173,'L1COMPONENTPARAMETER',1,'2015-06-29 22:21:49',12,'d','d','ADD',''),(174,'L1COMPONENTPARAMETER',1,'2015-06-29 22:21:50',13,'d','d','ADD',''),(175,'L1COMPONENTPARAMETER',1,'2015-06-29 22:23:07',14,'e','e','ADD','sssss'),(176,'L1COMPONENTPARAMETER',6,'2015-06-29 22:24:02',15,'d','d','ADD','增加'),(177,'L1COMPONENTPARAMETER',6,'2015-06-29 22:26:25',16,'d','d','ADD','d'),(178,'L1COMPONENTPARAMETER',1,'2015-06-29 22:31:33',15,'d','d','APPROVE','我批准这个更改'),(179,'L2COMPONENTPARAMETER',1,'2015-06-29 22:33:34',62,'DELLL','DELLL','APPROVE',''),(180,'L2COMPONENTPARAMETER',1,'2015-06-29 22:38:28',63,'1501','1501','APPROVE',''),(181,'L2COMPONENTPARAMETER',1,'2015-06-29 22:38:33',63,'1501','1501','APPROVE','我批准这个更改'),(182,'L1COMPONENTPARAMETER',6,'2015-06-29 22:39:43',2,'10','11','CHANGE','更改'),(183,'L1COMPONENTPARAMETER',6,'2015-06-29 22:39:58',2,'11','21','CHANGE','更改以下'),(184,'L1COMPONENTPARAMETER',1,'2015-06-29 22:41:23',2,'11','21','APPROVE','批准'),(185,'L2COMPONENTPARAMETER',1,'2015-06-29 22:48:44',66,'a','a','ADD','a'),(186,'L2COMPONENTPARAMETER',1,'2015-06-29 22:48:47',66,'a','a','DELETE',NULL),(187,'L1COMPONENTPARAMETER',1,'2015-07-01 13:27:18',14,'e','e','DELETE',NULL),(188,'L1COMPONENTPARAMETER',1,'2015-07-01 13:27:47',13,'d','d','DELETE',NULL),(189,'L1COMPONENTPARAMETER',1,'2015-07-01 13:36:43',12,'d','d','DELETE',NULL),(190,'L1COMPONENTPARAMETER',1,'2015-07-01 13:36:54',11,'d','d','DELETE',NULL),(191,'L1COMPONENTPARAMETER',1,'2015-07-01 13:38:07',10,'b','b','DELETE',NULL),(192,'L1COMPONENTPARAMETER',1,'2015-07-01 13:39:30',9,'c','c','DELETE',NULL),(193,'L2COMPONENTPARAMETER',1,'2015-07-01 13:42:45',64,'a','a','ADD','aaa'),(194,'L2COMPONENTPARAMETER',1,'2015-07-01 13:42:48',64,'a','a','DELETE',NULL),(195,'L3COMPONENTPARAMETER',1,'2015-07-01 13:43:10',1,'d','d','ADD','ddd'),(196,'L3COMPONENTPARAMETER',1,'2015-07-01 13:43:19',1,'d','d','DELETE',NULL),(197,'L1COMPONENTPARAMETER',1,'2016-01-09 13:52:34',24,'a','a','ADD','aaaa'),(198,'L2COMPONENTPARAMETER',1,'2016-01-09 15:17:19',1,'属性','属性','ADD','属性属性属性'),(199,'L1COMPONENTPARAMETER',1,'2016-03-22 09:49:17',8,'bc','bc','APPROVE','我允许通过');
/*!40000 ALTER TABLE `change_history` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'产品工程部'),(2,'工艺工程部'),(3,'技术研发部'),(4,'工程质量部');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,1,'有形成分分析',1,NULL,'暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 ','分析尿液有形成分浓度'),(2,1,'干化学分析',1,NULL,'分析尿液化学成分','分析尿液化学成分'),(3,1,'外观分析',NULL,NULL,'分析尿液外观特征','分析尿液外观特征'),(17,7,'外观分析',0,NULL,'分析尿液外观特征','分析尿液外观特征'),(18,7,'有形成分分析',0,NULL,'分析尿液有形成分浓度','分析尿液有形成分浓度'),(19,7,'干化学分析',0,NULL,'分析尿液化学成分','分析尿液化学成分'),(58,21,'外观分析',0,NULL,'分析尿液外观特征','分析尿液外观特征'),(59,21,'有形成分分析',0,NULL,'暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗    暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗暗啊 ','分析尿液有形成分浓度'),(60,21,'干化学分析',0,NULL,'分析尿液化学成分','分析尿液化学成分');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `function_module`
--

LOCK TABLES `function_module` WRITE;
/*!40000 ALTER TABLE `function_module` DISABLE KEYS */;
INSERT INTO `function_module` VALUES (3,'看到有形的颗粒',1,'',1),(4,'分辨有形颗粒的种类及数量',1,'',1),(5,'从有代表性的样本中提取有形成分',1,'',1),(6,'提供拍照样本与总体的比例关系',1,'',1),(8,'功能模块',17,'功能模块',0);
/*!40000 ALTER TABLE `function_module` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l1_component`
--

LOCK TABLES `l1_component` WRITE;
/*!40000 ALTER TABLE `l1_component` DISABLE KEYS */;
INSERT INTO `l1_component` VALUES (311,'显示器','显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器',1,'显示器显示器显示器显示器显示器',1,0,4),(312,'输入设备','',1,NULL,1,0,4),(313,'主机','',1,NULL,1,0,4),(319,'干化学分析11','',9,NULL,1,0,NULL),(320,'干化学分析2','',9,NULL,1,0,NULL),(321,'SAP','',2,NULL,1,0,5),(322,'BPM','',2,NULL,1,0,5),(323,'EAI','',2,NULL,1,0,5),(324,'液路系统1','',3,NULL,1,0,NULL),(325,'液路系统2','',3,NULL,1,0,NULL),(326,'镜框','',4,NULL,1,0,NULL),(371,'镜框','',40,NULL,0,0,NULL),(372,'液路系统2','',41,NULL,0,0,NULL),(373,'液路系统1','',41,NULL,0,0,NULL),(374,'输入设备','',42,NULL,0,0,NULL),(375,'显示器','',42,NULL,0,0,NULL),(376,'主机','',42,NULL,0,0,NULL),(377,'SAP','',43,NULL,0,0,NULL),(378,'EAI','',43,NULL,0,0,NULL),(379,'BPM','',43,NULL,0,0,NULL),(380,'干化学分析2','',44,NULL,0,0,NULL),(381,'干化学分析11','',44,NULL,0,0,NULL),(382,'暗暗','暗暗',47,NULL,0,1,8),(383,'往往','全球 ',47,NULL,0,1,8),(524,'镜框','',136,NULL,0,0,NULL),(525,'主机','',137,NULL,0,0,NULL),(526,'显示器','显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器显示器',137,'显示器显示器显示器显示器显示器',0,0,NULL),(527,'输入设备','',137,NULL,0,0,NULL),(528,'BPM','',138,NULL,0,0,NULL),(529,'SAP','',138,NULL,0,0,NULL),(530,'EAI','',138,NULL,0,0,NULL),(531,'液路系统1','',139,NULL,0,0,NULL),(532,'液路系统2','',139,NULL,0,0,NULL),(534,'干化学分析11','',140,NULL,0,0,NULL);
/*!40000 ALTER TABLE `l1_component` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l1_component_parameter`
--

LOCK TABLES `l1_component_parameter` WRITE;
/*!40000 ALTER TABLE `l1_component_parameter` DISABLE KEYS */;
INSERT INTO `l1_component_parameter` VALUES (8,'aa','bc','a','a',313,'aa','a',0,'bc',1),(21,'aa','bc','a','a',376,'aa','a',1,'bc',1),(36,'aa','bc','a','a',525,'aa','a',1,'bc',1);
/*!40000 ALTER TABLE `l1_component_parameter` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l2_component`
--

LOCK TABLES `l2_component` WRITE;
/*!40000 ALTER TABLE `l2_component` DISABLE KEYS */;
INSERT INTO `l2_component` VALUES (125,'d','d',313,NULL,1,0),(130,'d','d',376,NULL,0,0),(145,'d','d',525,NULL,0,0),(148,'阿','阿',311,NULL,1,0);
/*!40000 ALTER TABLE `l2_component` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l2_component_parameter`
--

LOCK TABLES `l2_component_parameter` WRITE;
/*!40000 ALTER TABLE `l2_component_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `l2_component_parameter` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l3_component`
--

LOCK TABLES `l3_component` WRITE;
/*!40000 ALTER TABLE `l3_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `l3_component` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `l3_component_parameter`
--

LOCK TABLES `l3_component_parameter` WRITE;
/*!40000 ALTER TABLE `l3_component_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `l3_component_parameter` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (1,1,'计算机',1,'计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机',''),(2,1,'系统软件',1,NULL,NULL),(3,1,'液路系统',1,NULL,NULL),(4,1,'显微镜系统',1,NULL,NULL),(9,2,'干化学分析11',1,'',''),(10,2,'干化学分析2',1,'',''),(11,2,'干化学分析3',1,'',''),(40,18,'显微镜系统',0,NULL,NULL),(41,18,'液路系统',0,NULL,NULL),(42,18,'计算机',0,NULL,NULL),(43,18,'系统软件',0,NULL,NULL),(44,19,'干化学分析11',0,'',''),(45,19,'干化学分析2',0,'',''),(46,19,'干化学分析3',0,'',''),(47,17,'子模块',0,'wo shi zimokuaiwo shi zimokuaiwo shi zimokuaiwo shi zimokuaiwo shi zimokuaiwo shi zimokuai','字模块'),(55,17,'子模块2',0,'子模块2','子模块2'),(136,59,'显微镜系统',0,'显微镜系统显微镜系统显微镜系统显微镜系统显微镜系统显微镜系统显微镜系统显微镜系统显微镜系统','显微镜系统'),(137,59,'计算机',0,'计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机计算机',''),(138,59,'系统软件',0,NULL,NULL),(139,59,'液路系统',0,NULL,NULL),(140,60,'干化学分析11',0,'',''),(141,60,'干化学分析3',0,'','');
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'模板','2015-01-01 00:00:00',1,'模板文件',NULL,1),(7,'新产品2','2016-01-10 16:22:09',0,'模板文件','',1),(21,'复制过的新产品','2016-03-22 09:24:05',0,'模板文件','',1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `requirements`
--

LOCK TABLES `requirements` WRITE;
/*!40000 ALTER TABLE `requirements` DISABLE KEYS */;
INSERT INTO `requirements` VALUES (1,'SI100','系统/界面需求','','','','','','','','','','','','','','','','','','','','','2016-06-21 12:12:12','2016-06-21 12:12:12','',1),(7,'112','','2015-06-21 23:28:59','','','','','','','','','','','','Sub-component','','','','','','','','2015-06-21 23:28:59','2015-06-21 23:28:59','',1),(11,'112','','2015-06-21 23:28:59','','','','','','','','','','','','Sub-component','','','','','','','','2015-06-21 23:28:59','2015-06-21 23:28:59','',7),(12,'SI100','系统/界面需求','','','','','','','','','','','','','','','','','','','','','2016-06-21 12:12:12','2016-06-21 12:12:12','',7),(16,'1111','','','','','','','','','','','','','','','','','','','','','','','','',1),(53,'1111','','','','','','','','','','','','','','','','','','','','','','','','',21),(54,'SI100','系统/界面需求','','','','','','','','','','','','','','','','','','','','','2016-06-21 12:12:12','2016-06-21 12:12:12','',21),(55,'112','','2015-06-21 23:28:59','','','','','','','','','','','','Sub-component','','','','','','','','2015-06-21 23:28:59','2015-06-21 23:28:59','',21);
/*!40000 ALTER TABLE `requirements` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `user_feature_matrix`
--

LOCK TABLES `user_feature_matrix` WRITE;
/*!40000 ALTER TABLE `user_feature_matrix` DISABLE KEYS */;
INSERT INTO `user_feature_matrix` VALUES (1,1,1,'2015-06-12 09:03:57',1),(4,6,1,'2015-06-12 09:08:26',1),(5,6,2,'2015-06-12 09:08:26',1),(10,2,1,'2015-06-25 18:01:44',1),(11,8,58,'2016-03-22 09:39:37',1),(12,8,59,'2016-03-22 09:39:37',1),(13,8,60,'2016-03-22 09:39:37',1),(14,27,58,'2016-03-22 09:41:48',1),(15,27,59,'2016-03-22 09:41:48',1);
/*!40000 ALTER TABLE `user_feature_matrix` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'管理员','123456','2015-01-18 21:55:23','ROLE_ADMIN',1,'18118127362',470,'2016-03-22 09:47:53'),(2,'普通用户','123456','2015-03-16 18:06:06','ROLE_USER',1,'18118127362',7,'2016-01-09 16:11:16'),(5,'高级技术用户','123456','2015-03-20 11:21:05','ROLE_SUPERTECHNICALSUPPORT',4,'123456789',7,'2015-06-28 16:48:54'),(6,'technical','123456','2015-04-06 14:09:54','ROLE_TECHNICALSUPPORT',1,'12345678',20,'2015-12-30 09:37:52'),(8,'技术员','123456','2015-06-12 09:12:18','ROLE_ADMIN',1,'1811811811',5,'2015-12-30 09:36:54'),(27,'新的用户','123456','2016-03-22 09:23:00','ROLE_USER',4,'18118127362',3,'2016-03-22 09:42:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2016-03-22 10:13:23
