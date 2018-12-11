CREATE DATABASE  IF NOT EXISTS `crews` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `crews`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: crews
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add club',1,'add_club'),(2,'Can change club',1,'change_club'),(3,'Can delete club',1,'delete_club'),(4,'Can view club',1,'view_club'),(5,'Can add club_admin',2,'add_club_admin'),(6,'Can change club_admin',2,'change_club_admin'),(7,'Can delete club_admin',2,'delete_club_admin'),(8,'Can view club_admin',2,'view_club_admin'),(9,'Can add club_registered_member',3,'add_club_registered_member'),(10,'Can change club_registered_member',3,'change_club_registered_member'),(11,'Can delete club_registered_member',3,'delete_club_registered_member'),(12,'Can view club_registered_member',3,'view_club_registered_member'),(13,'Can add comment',4,'add_comment'),(14,'Can change comment',4,'change_comment'),(15,'Can delete comment',4,'delete_comment'),(16,'Can view comment',4,'view_comment'),(17,'Can add event',5,'add_event'),(18,'Can change event',5,'change_event'),(19,'Can delete event',5,'delete_event'),(20,'Can view event',5,'view_event'),(21,'Can add event_media',6,'add_event_media'),(22,'Can change event_media',6,'change_event_media'),(23,'Can delete event_media',6,'delete_event_media'),(24,'Can view event_media',6,'view_event_media'),(25,'Can add event_registered_user',7,'add_event_registered_user'),(26,'Can change event_registered_user',7,'change_event_registered_user'),(27,'Can delete event_registered_user',7,'delete_event_registered_user'),(28,'Can view event_registered_user',7,'view_event_registered_user'),(29,'Can add leave_club_log',8,'add_leave_club_log'),(30,'Can change leave_club_log',8,'change_leave_club_log'),(31,'Can delete leave_club_log',8,'delete_leave_club_log'),(32,'Can view leave_club_log',8,'view_leave_club_log'),(33,'Can add likes',9,'add_likes'),(34,'Can change likes',9,'change_likes'),(35,'Can delete likes',9,'delete_likes'),(36,'Can view likes',9,'view_likes'),(37,'Can add login',10,'add_login'),(38,'Can change login',10,'change_login'),(39,'Can delete login',10,'delete_login'),(40,'Can view login',10,'view_login'),(41,'Can add logout_log',11,'add_logout_log'),(42,'Can change logout_log',11,'change_logout_log'),(43,'Can delete logout_log',11,'delete_logout_log'),(44,'Can view logout_log',11,'view_logout_log'),(45,'Can add media',12,'add_media'),(46,'Can change media',12,'change_media'),(47,'Can delete media',12,'delete_media'),(48,'Can view media',12,'view_media'),(49,'Can add notification',13,'add_notification'),(50,'Can change notification',13,'change_notification'),(51,'Can delete notification',13,'delete_notification'),(52,'Can view notification',13,'view_notification'),(53,'Can add notification_user',14,'add_notification_user'),(54,'Can change notification_user',14,'change_notification_user'),(55,'Can delete notification_user',14,'delete_notification_user'),(56,'Can view notification_user',14,'view_notification_user'),(57,'Can add poll',15,'add_poll'),(58,'Can change poll',15,'change_poll'),(59,'Can delete poll',15,'delete_poll'),(60,'Can view poll',15,'view_poll'),(61,'Can add poll_options',16,'add_poll_options'),(62,'Can change poll_options',16,'change_poll_options'),(63,'Can delete poll_options',16,'delete_poll_options'),(64,'Can view poll_options',16,'view_poll_options'),(65,'Can add poll_participation',17,'add_poll_participation'),(66,'Can change poll_participation',17,'change_poll_participation'),(67,'Can delete poll_participation',17,'delete_poll_participation'),(68,'Can view poll_participation',17,'view_poll_participation'),(69,'Can add post',18,'add_post'),(70,'Can change post',18,'change_post'),(71,'Can delete post',18,'delete_post'),(72,'Can view post',18,'view_post'),(73,'Can add post_media',19,'add_post_media'),(74,'Can change post_media',19,'change_post_media'),(75,'Can delete post_media',19,'delete_post_media'),(76,'Can view post_media',19,'view_post_media'),(77,'Can add remove_club_log',20,'add_remove_club_log'),(78,'Can change remove_club_log',20,'change_remove_club_log'),(79,'Can delete remove_club_log',20,'delete_remove_club_log'),(80,'Can view remove_club_log',20,'view_remove_club_log'),(81,'Can add room',21,'add_room'),(82,'Can change room',21,'change_room'),(83,'Can delete room',21,'delete_room'),(84,'Can view room',21,'view_room'),(85,'Can add user',22,'add_user'),(86,'Can change user',22,'change_user'),(87,'Can delete user',22,'delete_user'),(88,'Can view user',22,'view_user'),(89,'Can add log entry',23,'add_logentry'),(90,'Can change log entry',23,'change_logentry'),(91,'Can delete log entry',23,'delete_logentry'),(92,'Can view log entry',23,'view_logentry'),(93,'Can add permission',24,'add_permission'),(94,'Can change permission',24,'change_permission'),(95,'Can delete permission',24,'delete_permission'),(96,'Can view permission',24,'view_permission'),(97,'Can add group',25,'add_group'),(98,'Can change group',25,'change_group'),(99,'Can delete group',25,'delete_group'),(100,'Can view group',25,'view_group'),(101,'Can add user',26,'add_user'),(102,'Can change user',26,'change_user'),(103,'Can delete user',26,'delete_user'),(104,'Can view user',26,'view_user'),(105,'Can add content type',27,'add_contenttype'),(106,'Can change content type',27,'change_contenttype'),(107,'Can delete content type',27,'delete_contenttype'),(108,'Can view content type',27,'view_contenttype'),(109,'Can add session',28,'add_session'),(110,'Can change session',28,'change_session'),(111,'Can delete session',28,'delete_session'),(112,'Can view session',28,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$23tgOoR9U4wM$PNKWe53CW/IXO6796OOGNjsL1HnmjRpuD0wUb6NdkbY=','2018-12-08 12:18:25.104081',1,'root','','','madhuchandhana.p16@iiits.in',1,1,'2018-12-08 12:18:13.051320');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_club`
--

DROP TABLE IF EXISTS `crew_club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_club` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `club_name` varchar(30) NOT NULL,
  `club_description` longtext NOT NULL,
  `club_startdate` datetime(6) NOT NULL,
  `club_logo` varchar(100) DEFAULT NULL,
  `club_tc` varchar(100) NOT NULL,
  `club_active_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_club`
--

LOCK TABLES `crew_club` WRITE;
/*!40000 ALTER TABLE `crew_club` DISABLE KEYS */;
INSERT INTO `crew_club` VALUES (1,'Adventure','The basic concept to establish this club is to promote healthy adventure activities, especially camping, trekking and climbing etc.All the activities of this club are planned jointly by the club members and the faculty advisor.','2018-10-25 07:00:00.000000','club_logos/trekking-logo.gif','club_t&c/adventure.png',1),(2,'Photography','To promote creativity through photography, to share and critique the photographs of peers, to educate and improve technical skills, and to spread the love of photography throughout the campus.','2017-12-13 08:49:34.000000','club_logos/photo_3.jpg','club_t&c/photography.pdf',1),(3,'Dance','Objective of the club is to let everybody know about the dancing spirit, to enhance extra-curricular activity, also to develop career in dancing profession those who have the passion for dance.To encourage students for dance performances.','2017-09-14 07:37:08.000000','club_logos/dance.png','club_t&c/TC_FF_A5__Plain_English_ACT_NOVV2.pdf',1),(4,'Entrepreneurship','The Entrepreneurship Club aims to provide a conduit by which students can access entrepreneurial resources, network with community entrepreneurs, and share ideas. The club is dedicated to furthering understanding about new and small businesses.','2018-11-07 10:10:53.000000','club_logos/entrepreneur.png','club_t&c/entrepreneurship.pdf',1),(5,'Film Making','The goal of the Student Film Making Club is to create original films, including all aspects of film making such as screenwriting, story boarding, location scouting, acting, directing, filming, post-production, scoring, distribution and marketing.Film-making involves a number of discrete stages including an initial story, idea, or commission, through screenwriting, casting, shooting, sound recording and reproduction, editing, and screening the finished product before an audience that may result in a film release and exhibition.','2018-10-19 05:20:46.000000','club_logos/film.png','club_t&c/film.pdf',1),(6,'Nature','Nature Club is an organization that promotes green choices on campus and is all about getting students out into nature. Nature Club is dedicated to making campus and community more aware of native flora and fauna through education and hand on experience in hiking, snorkeling, and camping.Nature, in the broadest sense, is the natural, physical, or material world or universe. \\\"Nature\\\" can refer to the phenomena of the physical world, and also to life in general. The study of nature is a large, if not the only, part of science. Although humans are part of nature, human activity is often understood as a separate category from other natural phenomena.','2017-11-09 08:33:00.000000','club_logos/ecology.png','club_t&c/nature.pdf',1),(7,'Programming','Programming Club is designed for students with an interest in computer science. Some of our focal points include computer programming, web design, and network administration. Our goal is to enhance the skills needed in the field through team projects, tournaments, and guest speakers already involved in workforce.','2017-09-06 10:40:30.000000','club_logos/programming.png','club_t&c/programming.pdf',1),(8,'Astronomy','The purpose of the Astronomy Club is to advance the awareness of the cosmos and optical observation of outer space, on the Brandeis Campus. The club hosts group star and celestial gazing on telescopes, astronomy lectures and astronomy related events.Astronomy is a natural science that studies celestial objects and phenomena. It applies mathematics, physics, and chemistry, in an effort to explain the origin of those objects and phenomena and their evolution.It is concerned with the evolution, physics, chemistry, meteorology, and motion of celestial objects, as well as the formation and development of the universe.Astronomy is one of the oldest sciences.Astronomers of early civilizations performed methodical observations of the night sky, and astronomical artifacts have been found from much earlier periods.','2018-12-05 12:10:23.000000','club_logos/telescope.png','club_t&c/astronomy.pdf',1),(9,'Music','Music is an art form and cultural activity whose medium is sound organized in time. In general definitions of music will include common elements such as pitch, rhythm, dynamics, and the sonic qualities of timbre and texture. Different styles or types of music may emphasize, de-emphasize or omit some of these elements.','2018-01-12 09:41:39.000000','club_logos/karaoke.png','club_t&c/music.pdf',1),(10,'Star Gazing','Amateur astronomy is a hobby whose participants enjoy observing or imaging celestial objects in the sky using the unaided eye, binoculars, or telescopes. Even though scientific research may not be their primary goal, some amateur astronomers make contributions in doing citizen science, such as by monitoring variable stars, double stars or occultations of stars by the Moon or asteroids, or by discovering transient objects, such as comets, galactic novae or supernovae in other galaxies.','2018-11-08 09:20:06.000000','club_logos/watching-stars.png','club_t&c/TC_FF_A5__Plain_English_ACT_NOVV2_P2fOeA6.pdf',1),(11,'Cooking','Teaches students how to cook deliciously..','2018-10-10 10:04:00.000000','club_logos/cooking.png','club_t&c/TC_FF_A5__Plain_English_ACT_NOVV2_2Hh5lkY.pdf',1);
/*!40000 ALTER TABLE `crew_club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_club_admin`
--

DROP TABLE IF EXISTS `crew_club_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_club_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_joining` datetime(6) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_club_admin_club_id_id_53d6316a_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_club_admin_user_id_id_3b9f2618_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_club_admin_club_id_id_53d6316a_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_club_admin_user_id_id_3b9f2618_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_club_admin`
--

LOCK TABLES `crew_club_admin` WRITE;
/*!40000 ALTER TABLE `crew_club_admin` DISABLE KEYS */;
INSERT INTO `crew_club_admin` VALUES (1,'2018-10-25 12:00:00.000000',1,6),(2,'2017-12-13 15:58:15.000000',2,7),(3,'2018-12-08 20:54:22.000000',3,13),(4,'2018-12-08 20:55:06.000000',6,12),(5,'2018-12-08 20:57:39.000000',7,14),(6,'2018-02-01 10:17:43.000000',9,15),(7,'2018-12-09 10:19:08.000000',11,2),(8,'2018-12-09 10:59:23.000000',4,16),(9,'2018-12-09 11:01:39.000000',5,17),(10,'2018-12-09 11:08:02.000000',8,18),(11,'2018-12-09 11:08:12.000000',10,19);
/*!40000 ALTER TABLE `crew_club_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_club_registered_member`
--

DROP TABLE IF EXISTS `crew_club_registered_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_club_registered_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_joining` datetime(6) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_club_registered_member_club_id_id_4f0c9ea2_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_club_registered_member_user_id_id_2dd0687e_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_club_registered_member_club_id_id_4f0c9ea2_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_club_registered_member_user_id_id_2dd0687e_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_club_registered_member`
--

LOCK TABLES `crew_club_registered_member` WRITE;
/*!40000 ALTER TABLE `crew_club_registered_member` DISABLE KEYS */;
INSERT INTO `crew_club_registered_member` VALUES (1,'2018-12-08 14:59:06.419824',1,1),(2,'2018-12-08 14:59:19.605554',2,1),(3,'2018-12-08 19:01:59.115345',1,2),(4,'2018-12-10 09:38:21.575931',3,1),(5,'2018-12-10 09:38:45.000000',4,3),(6,'2018-12-10 09:38:59.000000',5,3),(7,'2018-12-10 09:39:12.000000',2,12),(8,'2018-12-10 09:39:22.000000',11,15),(9,'2018-12-10 09:39:32.000000',1,11),(10,'2018-12-10 09:39:57.000000',7,95),(11,'2018-12-10 09:40:15.000000',9,13),(12,'2018-12-10 09:40:24.000000',3,6),(13,'2018-12-10 09:40:35.000000',10,7),(14,'2018-12-10 09:40:43.000000',4,97),(15,'2018-12-10 09:41:38.000000',7,10),(16,'2018-12-10 09:41:47.000000',5,5),(17,'2018-12-10 09:41:58.000000',5,14),(18,'2018-12-10 09:42:07.000000',8,73),(19,'2018-12-10 09:42:16.000000',9,18),(20,'2018-12-10 09:42:25.000000',8,89),(21,'2018-12-10 09:42:35.000000',7,93),(22,'2018-12-10 09:42:46.000000',10,16),(23,'2018-12-10 09:42:59.000000',5,16),(24,'2018-12-10 09:43:08.000000',7,94),(25,'2018-12-10 09:43:18.000000',4,4),(26,'2018-12-10 09:43:26.000000',5,1),(27,'2018-12-10 09:43:41.000000',8,5),(28,'2018-12-10 09:44:11.000000',8,93),(29,'2018-12-10 09:44:32.000000',2,56),(30,'2018-12-10 09:44:45.000000',4,45),(31,'2018-12-10 09:44:56.000000',4,69),(32,'2018-12-10 09:45:05.000000',5,96),(33,'2018-12-10 09:45:16.000000',6,98),(34,'2018-12-10 09:45:26.000000',7,100),(35,'2018-12-10 09:45:41.000000',7,99),(36,'2018-12-10 09:45:51.000000',1,94),(37,'2018-12-10 09:46:01.000000',6,31),(38,'2018-12-10 09:46:10.000000',2,61),(39,'2018-12-10 09:46:20.000000',8,58),(40,'2018-12-10 09:46:30.000000',9,92),(41,'2018-12-10 09:46:39.000000',2,42),(42,'2018-12-10 09:46:58.000000',7,91),(43,'2018-12-10 09:47:09.000000',7,90),(44,'2018-12-10 09:47:25.000000',7,87),(45,'2018-12-10 09:47:35.000000',11,54),(46,'2018-12-10 09:47:47.000000',11,86),(47,'2018-12-10 09:47:58.000000',4,84),(48,'2018-12-10 09:48:13.000000',5,82),(49,'2018-12-10 09:48:41.000000',1,61),(50,'2018-12-10 09:49:28.000000',3,83),(51,'2018-12-10 09:49:40.000000',2,81),(52,'2018-12-10 09:49:50.000000',7,55),(53,'2018-12-10 09:50:01.000000',7,44),(54,'2018-12-10 09:50:11.000000',6,79),(55,'2018-12-10 09:50:21.000000',9,10),(56,'2018-12-10 09:50:28.000000',7,63),(57,'2018-12-10 09:50:44.000000',6,75),(58,'2018-12-10 09:50:58.000000',5,49),(59,'2018-12-10 09:51:09.000000',7,29),(60,'2018-12-10 09:51:19.000000',5,36),(61,'2018-12-10 09:51:29.000000',7,34),(62,'2018-12-10 09:51:39.000000',5,41),(63,'2018-12-10 09:51:50.000000',8,67),(64,'2018-12-10 09:52:02.000000',7,35),(65,'2018-12-10 09:52:16.000000',7,66),(66,'2018-12-10 09:52:27.000000',5,71),(67,'2018-12-10 09:52:39.000000',3,65),(68,'2018-12-10 09:52:49.000000',4,50),(69,'2018-12-10 09:53:01.000000',5,70),(70,'2018-12-10 09:53:12.000000',5,51),(71,'2018-12-10 09:53:23.000000',3,68),(72,'2018-12-10 09:53:36.000000',8,65),(73,'2018-12-10 09:53:49.000000',3,88),(74,'2018-12-10 09:54:04.000000',3,26),(75,'2018-12-10 09:54:34.000000',1,54),(76,'2018-12-10 09:54:44.000000',2,47),(77,'2018-12-10 09:54:58.000000',3,59),(78,'2018-12-10 09:55:08.000000',4,23),(79,'2018-12-10 09:55:18.000000',4,37),(80,'2018-12-10 09:55:31.000000',10,7),(81,'2018-12-10 09:55:54.000000',1,78),(82,'2018-12-10 09:56:04.000000',7,77),(83,'2018-12-10 09:56:14.000000',4,57),(84,'2018-12-10 09:57:06.000000',5,64),(85,'2018-12-10 09:57:19.000000',3,53),(86,'2018-12-10 09:57:30.000000',4,46),(87,'2018-12-10 09:57:42.000000',6,52),(88,'2018-12-10 09:58:08.000000',1,49),(89,'2018-12-10 09:58:21.000000',7,38),(90,'2018-12-10 09:58:31.000000',5,59),(91,'2018-12-10 09:58:43.000000',11,50),(92,'2018-12-10 09:58:53.000000',7,7),(93,'2018-12-10 09:59:02.000000',7,6),(94,'2018-12-10 09:59:11.000000',9,5),(95,'2018-12-10 09:59:21.000000',1,12),(96,'2018-12-10 09:59:29.000000',7,48),(97,'2018-12-10 10:00:13.000000',9,54),(98,'2018-12-10 10:00:44.000000',8,30),(99,'2018-12-10 10:01:04.000000',3,86),(100,'2018-12-10 10:01:31.000000',1,10),(101,'2018-12-10 10:02:01.000000',2,100),(102,'2018-12-10 12:04:33.300653',1,18),(103,'2018-12-10 12:18:51.777065',7,1),(104,'2018-12-10 12:53:08.071207',1,96),(105,'2018-12-10 13:01:50.535629',1,13),(106,'2018-12-10 13:28:02.332757',6,89),(107,'2018-12-10 13:37:24.417384',1,93);
/*!40000 ALTER TABLE `crew_club_registered_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_comment`
--

DROP TABLE IF EXISTS `crew_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `comment_datetime` datetime(6) NOT NULL,
  `post_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_comment_post_id_id_bd7a7c2f_fk_CREW_post_id` (`post_id_id`),
  KEY `CREW_comment_user_id_id_fe6ed28a_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_comment_post_id_id_bd7a7c2f_fk_CREW_post_id` FOREIGN KEY (`post_id_id`) REFERENCES `crew_post` (`id`),
  CONSTRAINT `CREW_comment_user_id_id_fe6ed28a_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_comment`
--

LOCK TABLES `crew_comment` WRITE;
/*!40000 ALTER TABLE `crew_comment` DISABLE KEYS */;
INSERT INTO `crew_comment` VALUES (1,'Good','2018-12-08 15:17:38.602009',1,1),(2,'I missed it!','2018-12-08 19:02:14.020478',1,2),(3,'That\'s interesting','2018-12-10 12:19:05.158272',5,1),(4,'Clean*','2018-12-10 12:41:17.120492',7,98),(5,'Sure..','2018-12-10 12:46:15.291448',9,100),(6,'Yes pls do','2018-12-10 12:46:34.860108',9,1),(7,'Ok sure..thank u','2018-12-10 12:53:55.015298',11,93),(8,'thank u','2018-12-10 12:54:19.617721',11,95),(9,'Yes learnt good thingd..','2018-12-10 12:57:32.626483',16,93),(10,'things*','2018-12-10 12:57:39.415858',16,93),(11,'shared knowledge','2018-12-10 12:57:48.139329',16,93),(12,'Yes..but felt little boring','2018-12-10 12:58:11.061924',16,100),(13,'i couldnt attend it','2018-12-10 12:59:01.967957',16,8),(14,'We will meet next time sir','2018-12-10 12:59:30.406892',16,94),(15,'Appreciate the effort','2018-12-10 13:00:56.825565',17,53),(16,'Yes','2018-12-10 13:02:02.081711',13,13),(17,'A proper session on it would be nice','2018-12-10 13:21:07.580712',24,100),(18,'Astronomy ','2018-12-10 13:22:16.857482',26,89),(19,'True','2018-12-10 13:23:03.696117',27,8),(20,'He is also good at photography','2018-12-10 13:23:14.132828',27,8),(21,'feel proud of him','2018-12-10 13:24:01.999800',28,100),(22,'yes','2018-12-10 13:29:35.347170',13,18),(23,'ok sir','2018-12-10 13:29:43.729078',3,18),(24,'chandu..nice pic','2018-12-10 13:29:56.488625',1,18),(25,'Want it in sricity','2018-12-10 13:32:27.562508',21,86),(26,'astronomy','2018-12-10 13:34:12.907657',30,93),(27,'I agree','2018-12-10 14:02:02.008023',28,1);
/*!40000 ALTER TABLE `crew_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_event`
--

DROP TABLE IF EXISTS `crew_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(30) NOT NULL,
  `event_start_datetime` datetime(6) NOT NULL,
  `event_end_datetime` datetime(6) NOT NULL,
  `event_type` varchar(30) NOT NULL,
  `event_duration` int(11) NOT NULL,
  `event_host` varchar(30) NOT NULL,
  `event_limit` int(11) NOT NULL,
  `event_fill_status` int(11) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `event_venue_id` int(11) NOT NULL,
  `organizer_id_id` int(11) NOT NULL,
  `event_description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_event_club_id_id_296ac4b8_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_event_event_venue_id_234b7765_fk_CREW_room_id` (`event_venue_id`),
  KEY `CREW_event_organizer_id_id_31be82c9_fk_CREW_user_id` (`organizer_id_id`),
  CONSTRAINT `CREW_event_club_id_id_296ac4b8_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_event_event_venue_id_234b7765_fk_CREW_room_id` FOREIGN KEY (`event_venue_id`) REFERENCES `crew_room` (`id`),
  CONSTRAINT `CREW_event_organizer_id_id_31be82c9_fk_CREW_user_id` FOREIGN KEY (`organizer_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_event`
--

LOCK TABLES `crew_event` WRITE;
/*!40000 ALTER TABLE `crew_event` DISABLE KEYS */;
INSERT INTO `crew_event` VALUES (1,'Elektra','2018-11-30 06:30:00.000000','2018-11-30 12:30:00.000000','Competition',6,'IIITS',60,1,7,5,14,'Description'),(2,'Reverse Coding','2018-12-02 10:00:00.000000','2018-12-02 12:00:00.000000','Competition',2,'IIITS',60,0,7,6,14,'Description'),(3,'The-Dancer','2018-12-05 07:00:00.000000','2018-12-05 09:00:00.000000','Competition',2,'IIITS',30,0,3,4,13,'Description'),(4,'SaReGaMa','2018-12-03 07:00:00.000000','2018-12-03 09:00:00.000000','Competition',2,'IIITS',40,0,9,3,15,'Description'),(5,'The Cooking Competition','2018-12-05 06:30:00.000000','2018-12-05 09:30:00.000000','Competition',3,'IIITS',100,0,11,4,2,'Description'),(6,'Bird watching','2018-12-11 02:30:00.000000','2018-12-11 11:30:00.000000','Show',9,'IIITS',40,0,6,11,12,'Lets watch birds together'),(7,'College Chef','2018-12-11 07:30:00.000000','2018-12-11 09:30:00.000000','Competition',1,'IIITS',50,0,11,3,2,'To bring out the cooking talent from our IIITS students'),(8,'Shuttersbugs','2018-12-12 12:30:00.000000','2018-12-12 14:30:00.000000','Competition',2,'IIITS',20,0,2,11,7,'A small lens is enough to see the whole world'),(9,'Silver screen','2018-12-13 10:30:00.000000','2018-12-13 14:30:00.000000','Competition',4,'IIITS',40,0,5,9,17,'To bring out the film maker in you!!'),(10,'Saahas','2018-12-12 02:30:00.000000','2018-12-12 12:30:00.000000','Activity',10,'IIITS',45,0,1,11,6,'Discover the explorer in you through this trek!!'),(11,'Star scope','2018-12-13 14:30:00.000000','2018-12-13 17:30:00.000000','Activity',3,'IIITS',20,0,10,11,19,'Lets provide a feast to our eyes by watching stars');
/*!40000 ALTER TABLE `crew_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_event_media`
--

DROP TABLE IF EXISTS `crew_event_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_event_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_type` varchar(30) NOT NULL,
  `media` varchar(100) NOT NULL,
  `event_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_event_media_event_id_id_a194ab8d_fk_CREW_event_id` (`event_id_id`),
  CONSTRAINT `CREW_event_media_event_id_id_a194ab8d_fk_CREW_event_id` FOREIGN KEY (`event_id_id`) REFERENCES `crew_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_event_media`
--

LOCK TABLES `crew_event_media` WRITE;
/*!40000 ALTER TABLE `crew_event_media` DISABLE KEYS */;
INSERT INTO `crew_event_media` VALUES (1,'Image','event_media/Electra_lBRleeS.jpeg',1),(2,'Image','event_media/Reverse_coding_24BJt70.jpeg',2),(3,'Image','event_media/dance_face_off_WWBonJl.jpg',3),(4,'Image','event_media/SaReGaMa_zJuTlID.jpg',4);
/*!40000 ALTER TABLE `crew_event_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_event_registered_user`
--

DROP TABLE IF EXISTS `crew_event_registered_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_event_registered_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `register_datetime` datetime(6) NOT NULL,
  `event_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_event_registered_user_event_id_id_047ddb4d_fk_CREW_event_id` (`event_id_id`),
  KEY `CREW_event_registered_user_user_id_id_c9b8078b_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_event_registered_user_event_id_id_047ddb4d_fk_CREW_event_id` FOREIGN KEY (`event_id_id`) REFERENCES `crew_event` (`id`),
  CONSTRAINT `CREW_event_registered_user_user_id_id_c9b8078b_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_event_registered_user`
--

LOCK TABLES `crew_event_registered_user` WRITE;
/*!40000 ALTER TABLE `crew_event_registered_user` DISABLE KEYS */;
INSERT INTO `crew_event_registered_user` VALUES (2,'2018-12-10 14:12:28.000000',5,1);
/*!40000 ALTER TABLE `crew_event_registered_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_leave_club_log`
--

DROP TABLE IF EXISTS `crew_leave_club_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_leave_club_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leave_club_id` int(11) NOT NULL,
  `date_of_leaving` datetime(6) NOT NULL,
  `reason` longtext NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_leave_club_log_club_id_id_2cd6f4b0_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_leave_club_log_user_id_id_d931823d_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_leave_club_log_club_id_id_2cd6f4b0_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_leave_club_log_user_id_id_d931823d_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_leave_club_log`
--

LOCK TABLES `crew_leave_club_log` WRITE;
/*!40000 ALTER TABLE `crew_leave_club_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_leave_club_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_likes`
--

DROP TABLE IF EXISTS `crew_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `like_type` varchar(30) NOT NULL,
  `liked_user_id_id` int(11) NOT NULL,
  `post_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_likes_liked_user_id_id_cba80bec_fk_CREW_user_id` (`liked_user_id_id`),
  KEY `CREW_likes_post_id_id_dcdbca6f_fk_CREW_post_id` (`post_id_id`),
  CONSTRAINT `CREW_likes_liked_user_id_id_cba80bec_fk_CREW_user_id` FOREIGN KEY (`liked_user_id_id`) REFERENCES `crew_user` (`id`),
  CONSTRAINT `CREW_likes_post_id_id_dcdbca6f_fk_CREW_post_id` FOREIGN KEY (`post_id_id`) REFERENCES `crew_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_likes`
--

LOCK TABLES `crew_likes` WRITE;
/*!40000 ALTER TABLE `crew_likes` DISABLE KEYS */;
INSERT INTO `crew_likes` VALUES (1,'Like',1,3),(2,'Like',8,4),(3,'Like',8,2),(4,'Like',8,1),(5,'Like',93,5),(6,'Like',1,5),(7,'Like',100,5),(8,'DisLike',8,7),(9,'Like',93,9),(10,'Like',1,9),(11,'Like',94,9),(12,'Like',94,5),(13,'Like',96,13),(14,'Like',93,11),(15,'Like',93,16),(16,'Like',100,16),(17,'Like',1,9),(18,'Like',100,28),(19,'Like',98,29),(20,'Like',89,29),(21,'Like',18,1),(22,'Like',86,21),(23,'Like',1,28);
/*!40000 ALTER TABLE `crew_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_login`
--

DROP TABLE IF EXISTS `crew_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) NOT NULL,
  `datetime_of_login` datetime(6) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_login_user_id_id_bddbac93_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_login_user_id_id_bddbac93_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_login`
--

LOCK TABLES `crew_login` WRITE;
/*!40000 ALTER TABLE `crew_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_logout_log`
--

DROP TABLE IF EXISTS `crew_logout_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_logout_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logout_datetime` datetime(6) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_logout_log_user_id_id_1d89cfa9_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_logout_log_user_id_id_1d89cfa9_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_logout_log`
--

LOCK TABLES `crew_logout_log` WRITE;
/*!40000 ALTER TABLE `crew_logout_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_logout_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_media`
--

DROP TABLE IF EXISTS `crew_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media` varchar(100) NOT NULL,
  `media_type` varchar(30) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_media_club_id_id_a2e1daa9_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_media_user_id_id_359c9cdb_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_media_club_id_id_a2e1daa9_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_media_user_id_id_359c9cdb_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_media`
--

LOCK TABLES `crew_media` WRITE;
/*!40000 ALTER TABLE `crew_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_notification`
--

DROP TABLE IF EXISTS `crew_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_content` longtext NOT NULL,
  `notification_datetime` datetime(6) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_notification_club_id_id_1450c08c_fk_CREW_club_id` (`club_id_id`),
  CONSTRAINT `CREW_notification_club_id_id_1450c08c_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_notification`
--

LOCK TABLES `crew_notification` WRITE;
/*!40000 ALTER TABLE `crew_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_notification_user`
--

DROP TABLE IF EXISTS `crew_notification_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_notification_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `view_type` tinyint(1) NOT NULL,
  `notification_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_notification_us_notification_id_id_fa4cc4ee_fk_CREW_noti` (`notification_id_id`),
  KEY `CREW_notification_user_user_id_id_77cf2bed_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_notification_us_notification_id_id_fa4cc4ee_fk_CREW_noti` FOREIGN KEY (`notification_id_id`) REFERENCES `crew_notification` (`id`),
  CONSTRAINT `CREW_notification_user_user_id_id_77cf2bed_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_notification_user`
--

LOCK TABLES `crew_notification_user` WRITE;
/*!40000 ALTER TABLE `crew_notification_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_notification_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_poll`
--

DROP TABLE IF EXISTS `crew_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_title` varchar(50) NOT NULL,
  `poll_description` longtext NOT NULL,
  `poll_winner` int(11) NOT NULL,
  `start_datetime` datetime(6) NOT NULL,
  `end_datetime` datetime(6) NOT NULL,
  `poll_type` varchar(10) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_poll_user_id_id_ded514e5_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_poll_user_id_id_ded514e5_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_poll`
--

LOCK TABLES `crew_poll` WRITE;
/*!40000 ALTER TABLE `crew_poll` DISABLE KEYS */;
INSERT INTO `crew_poll` VALUES (1,'Electing Club Admin','Do you want elections to be conducted for electing the Admins of each club?',1,'2018-12-08 18:30:00.000000','2018-12-11 18:30:00.000000','Single',8),(2,'Trek on 22nd January','Are you interested?',1,'2018-12-10 11:30:00.000000','2018-12-14 02:30:00.000000','Single',6),(3,'Kayaking on January 29th','Are you interested?',1,'2018-12-07 10:30:00.000000','2018-12-13 02:30:00.000000','Single',6),(4,'Trekking places','Which place do you want to visit?',1,'2018-12-10 02:30:00.000000','2018-12-19 04:30:00.000000','Single',6),(5,'Choice of dishes','Which cuisine most of you want to learn?',1,'2018-12-06 11:30:00.000000','2018-12-20 12:30:00.000000','Single',2),(6,'Cooking sessions','How frequently do you want the sessions to be conducted?',1,'2018-12-05 10:30:00.000000','2018-12-13 11:30:00.000000','Single',2),(7,'Feedback of the session','What was your experience in today\'s session?',1,'2018-12-10 04:30:00.000000','2018-12-11 04:30:00.000000','Single',2),(8,'Night photoshoot','Are you interested in night photoshoots?',1,'2018-12-04 04:30:00.000000','2018-12-13 18:29:00.000000','Single',7),(9,'Best picture','Which picture do you like the most?Select any 3!',1,'2018-12-09 11:30:00.000000','2018-12-11 04:30:00.000000','Multiple',7),(10,'Type of session','Which one do you want?',1,'2018-12-05 11:30:00.000000','2018-12-13 12:30:00.000000','Single',7),(11,'Place to shoot','Which is your choice?',1,'2018-12-11 02:30:00.000000','2018-12-11 07:00:00.000000','Single',7),(12,'Type of sessions','Pick your choice',1,'2018-12-06 19:00:00.000000','2018-12-11 19:00:00.000000','Single',17),(13,'Contest type','which contest do you like?',1,'2018-12-06 04:30:00.000000','2018-12-15 04:30:00.000000','Single',17),(14,'Extension of deadline','Do you want extension for the short film contest submission',1,'2018-12-10 04:30:00.000000','2018-12-10 16:30:00.000000','Single',17),(15,'Session on Java Programming','Do you want a session on java programming?',1,'2018-12-11 04:30:00.000000','2018-12-12 04:30:00.000000','Single',14),(16,'Theory or Practical?','Which is your choice for session on Java programming?',1,'2018-12-07 04:30:00.000000','2018-12-08 04:30:00.000000','Single',14),(17,'Reverse coding','Are you interested in reverse coding?',1,'2018-12-11 02:30:00.000000','2018-12-11 14:30:00.000000','Single',14),(18,'Session experience','How did you feel about today\'s session?',1,'2018-12-10 16:30:00.000000','2018-12-11 04:30:00.000000','Single',19),(19,'Frequency of sessions','How often do you want to meet?',1,'2018-12-07 04:30:00.000000','2018-12-08 04:30:00.000000','Single',19),(20,'Visit outdoor places','Do you want to visit any space research center or just study online?',1,'2018-12-09 04:30:00.000000','2018-12-12 04:30:00.000000','Single',18),(21,'Session on what?','Which is your choice for the session?',1,'2018-12-12 04:30:00.000000','2018-12-13 07:00:00.000000','Single',15),(22,'Competition','Are you interested in inter-college competition or intra-college competition?',1,'2018-12-11 04:30:00.000000','2018-12-11 16:30:00.000000','Single',15),(23,'Choice of dance','Which form of dance session do you want on 17th decemeber 2018?',1,'2018-12-05 04:30:00.000000','2018-12-16 16:30:00.000000','Single',13),(24,'Inter-college participation','Are you interested in inter-college competition on 30th December 2018?',1,'2018-12-11 04:30:00.000000','2018-12-12 04:30:00.000000','Single',13),(25,'Best performance','Which house did the best dance performance in Abhisarga 2K18?',1,'2018-12-10 16:30:00.000000','2018-12-12 16:30:00.000000','Single',13),(26,'Bird watching','Interested in bird watching on 16th December?',1,'2018-12-09 04:30:00.000000','2018-12-11 11:30:00.000000','Single',12),(27,'NSS Event','Interested in NSS event in our campus on 18th December 2018?',1,'2018-12-10 04:30:00.000000','2018-12-10 12:30:00.000000','Single',12),(28,'Event in butterfly park','Interested in cleaning of butterfly park on 17th December 2018?',1,'2018-12-09 11:30:00.000000','2018-12-11 12:30:00.000000','Single',12),(29,'Best Music performance','Whose was the best music performance in Abhisarga 2k18?',1,'2018-12-05 04:30:00.000000','2018-12-13 12:30:00.000000','Single',15),(30,'Adding a club','Should sports club be formed?',1,'2018-12-04 04:30:00.000000','2018-12-12 04:30:00.000000','Single',8);
/*!40000 ALTER TABLE `crew_poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_poll_options`
--

DROP TABLE IF EXISTS `crew_poll_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_poll_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option` varchar(30) NOT NULL,
  `image` varchar(100) NOT NULL,
  `votes` int(11) NOT NULL,
  `poll_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_poll_options_poll_id_id_581029a2_fk_CREW_poll_id` (`poll_id_id`),
  CONSTRAINT `CREW_poll_options_poll_id_id_581029a2_fk_CREW_poll_id` FOREIGN KEY (`poll_id_id`) REFERENCES `crew_poll` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_poll_options`
--

LOCK TABLES `crew_poll_options` WRITE;
/*!40000 ALTER TABLE `crew_poll_options` DISABLE KEYS */;
INSERT INTO `crew_poll_options` VALUES (1,'Yes','',10,1),(2,'No','',2,1),(3,'Yes','',6,2),(4,'No','',0,2),(5,'Yes','',1,3),(6,'No','',5,3),(7,'Ubbalamadugu water falls','',1,4),(8,'Tada falls','',1,4),(9,'Nagala hills','',2,4),(10,'Far places from sricity','',2,4),(11,'South Indian','',1,5),(12,'North Indian','',0,5),(13,'Chinese','',0,5),(14,'Italian','',0,5),(15,'Weekly','',1,6),(16,'Monthly','',0,6),(17,'Once in 2 months','',0,6),(18,'Excellent','',0,7),(19,'Good','',1,7),(20,'Satisfactory','',0,7),(21,'Bad','',0,7),(22,'Worst','',0,7),(23,'Yes','',1,8),(24,'No','',1,8),(25,'','poll_media/polls/photo-1.jpg',0,9),(26,'','poll_media/polls/photo-2.jpg',0,9),(27,'','poll_media/polls/photo-3.jpg',0,9),(28,'','poll_media/polls/photo-4.jpg',0,9),(29,'','poll_media/polls/photo-5.jpg',0,9),(30,'','poll_media/polls/photo-6.jpg',0,9),(31,'','poll_media/polls/photo-7.jpg',0,9),(32,'','poll_media/polls/photo-8.jpg',0,9),(33,'Practical session','',2,10),(34,'Theory session','',0,10),(35,'Zoo - Wildlife','',1,11),(36,'Park - Nature','',1,11),(37,'Script writing','',0,12),(38,'Direction','',1,12),(39,'Cinematography','',1,12),(40,'Short Film contest','',1,13),(41,'Story writing contest','',1,13),(42,'Yes','',2,14),(43,'No','',0,14),(44,'Yes','',4,15),(45,'No','',1,15),(46,'Theory','',1,16),(47,'Practical','',4,16),(48,'Yes','',2,17),(49,'No','',3,17),(50,'Excellent','',0,18),(51,'Good','',0,18),(52,'Satisfactory','',0,18),(53,'Bad','',0,18),(54,'Worst','',0,18),(55,'Weekly','',0,19),(56,'Monthly','',0,19),(57,'Once in 2 months','',0,19),(58,'Space research center','',2,20),(59,'Online study','',0,20),(60,'Guitar','',0,21),(61,'Flute','',1,21),(62,'Keyboard','',0,21),(63,'Drums','',1,21),(64,'Inter-college','',1,22),(65,'Intra-college','',1,22),(66,'Folk','',0,23),(67,'Western','',2,23),(68,'Classical','',1,23),(69,'Yes','',2,24),(70,'No','',1,24),(71,'Astra','',0,25),(72,'Chakra','',1,25),(73,'Trishul','',2,25),(74,'Vajra','',0,25),(75,'Yes','',2,26),(76,'No','',0,26),(77,'Yes','',1,27),(78,'No','',1,27),(79,'Yes','',1,28),(80,'No','',1,28),(81,'Astra','',1,29),(82,'Chakra','',1,29),(83,'Trishul','',0,29),(84,'Vajra','',0,29),(85,'Yes','',3,30),(86,'No','',9,30);
/*!40000 ALTER TABLE `crew_poll_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_poll_participation`
--

DROP TABLE IF EXISTS `crew_poll_participation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_poll_participation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id_id` int(11) NOT NULL,
  `poll_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_poll_participat_option_id_id_3ff75aac_fk_CREW_poll` (`option_id_id`),
  KEY `CREW_poll_participation_poll_id_id_22bdfecc_fk_CREW_poll_id` (`poll_id_id`),
  KEY `CREW_poll_participation_user_id_id_cb73dae0_fk_CREW_user_id` (`user_id_id`),
  CONSTRAINT `CREW_poll_participat_option_id_id_3ff75aac_fk_CREW_poll` FOREIGN KEY (`option_id_id`) REFERENCES `crew_poll_options` (`id`),
  CONSTRAINT `CREW_poll_participation_poll_id_id_22bdfecc_fk_CREW_poll_id` FOREIGN KEY (`poll_id_id`) REFERENCES `crew_poll` (`id`),
  CONSTRAINT `CREW_poll_participation_user_id_id_cb73dae0_fk_CREW_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_poll_participation`
--

LOCK TABLES `crew_poll_participation` WRITE;
/*!40000 ALTER TABLE `crew_poll_participation` DISABLE KEYS */;
INSERT INTO `crew_poll_participation` VALUES (1,1,1,1),(2,1,1,93),(3,86,30,93),(4,44,15,93),(5,47,16,93),(6,48,17,93),(7,58,20,93),(8,3,2,1),(9,5,3,1),(10,9,4,1),(11,23,8,1),(12,33,10,1),(13,35,11,1),(14,38,12,1),(15,40,13,1),(16,42,14,1),(17,44,15,1),(18,47,16,1),(19,49,17,1),(20,67,23,1),(21,69,24,1),(22,73,25,1),(23,86,30,1),(24,24,8,100),(25,33,10,100),(26,36,11,100),(27,85,30,100),(28,45,15,100),(29,47,16,100),(30,48,17,100),(31,1,1,100),(32,1,1,98),(33,86,30,98),(34,75,26,98),(35,78,27,98),(36,80,28,98),(37,1,1,96),(38,85,30,96),(39,39,12,96),(40,41,13,96),(41,42,14,96),(42,1,1,95),(43,86,30,95),(44,44,15,95),(45,46,16,95),(46,49,17,95),(47,3,2,94),(48,6,3,94),(49,10,4,94),(50,2,1,94),(51,86,30,94),(52,44,15,94),(53,47,16,94),(54,49,17,94),(55,1,1,89),(56,86,30,89),(57,58,20,89),(58,1,1,53),(59,86,30,53),(60,68,23,53),(61,69,24,53),(62,73,25,53),(63,3,2,13),(64,6,3,13),(65,10,4,13),(66,1,1,13),(67,86,30,13),(68,63,21,13),(69,65,22,13),(70,81,29,13),(71,3,2,96),(72,6,3,96),(73,7,4,96),(74,11,5,86),(75,15,6,86),(76,19,7,86),(77,2,1,86),(78,86,30,86),(79,67,23,86),(80,70,24,86),(81,72,25,86),(82,75,26,89),(83,77,27,89),(84,79,28,89),(85,3,2,18),(86,6,3,18),(87,9,4,18),(88,1,1,18),(89,85,30,18),(90,61,21,18),(91,64,22,18),(92,82,29,18),(93,3,2,93),(94,6,3,93),(95,8,4,93);
/*!40000 ALTER TABLE `crew_poll_participation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_post`
--

DROP TABLE IF EXISTS `crew_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_title` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `post_datetime` datetime(6) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  `posted_by_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_post_club_id_id_10ee685d_fk_CREW_club_id` (`club_id_id`),
  KEY `CREW_post_posted_by_id_id_ae8473ac_fk_CREW_user_id` (`posted_by_id_id`),
  CONSTRAINT `CREW_post_club_id_id_10ee685d_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`),
  CONSTRAINT `CREW_post_posted_by_id_id_ae8473ac_fk_CREW_user_id` FOREIGN KEY (`posted_by_id_id`) REFERENCES `crew_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_post`
--

LOCK TABLES `crew_post` WRITE;
/*!40000 ALTER TABLE `crew_post` DISABLE KEYS */;
INSERT INTO `crew_post` VALUES (1,'Trekking','Enjoyed my trek a lot!!','2018-12-08 15:02:42.361785',1,1),(2,'Photography','Learnt few things about photography in today\'s visit to Pulicat lake','2018-12-08 15:22:00.377199',2,1),(3,'Camp in Nagala Hills','We will have a camp in Nagala Hills on 20th January 2019 for 2 days.It is on paid basis.First 50 members are allowed.A google form will be circulated soon..','2018-12-10 08:15:47.640949',1,8),(4,'NSS Event','Conducted our first NSS Event on 9th December 2018.','2018-12-10 11:56:21.969264',6,8),(5,'Programming session','Can we have a session on iOS app development on 15th december 2018?Like it if you want..','2018-12-10 12:08:05.653710',7,93),(6,'Appreciation','Good work by programming club','2018-12-10 12:38:37.049755',7,100),(7,'NSS Event','Butterfly park is already clen..No need of special cleaning for it..','2018-12-10 12:41:06.096977',6,98),(8,'Short Film shooting','Please announce the results of the short film contest contest','2018-12-10 12:43:03.305693',5,96),(9,'Android development','Please conduct a session on android development','2018-12-10 12:44:38.076468',7,95),(10,'Events','Programming club should conduct more events frequently.Not only during fests!','2018-12-10 12:50:38.946362',7,94),(11,'Android development','We are thinking to conduct a session on android development on 15th January 2019.Make sure you make use of it.','2018-12-10 12:51:26.634392',7,94),(12,'Cinematography','Can anyone take a session on cinematography?','2018-12-10 12:52:24.034989',5,96),(13,'Trekking','Please dont take repeated members for trekking..Give chance to everyone','2018-12-10 12:53:34.915060',1,96),(14,'Outdoor events','Please take us to ISRO','2018-12-10 12:55:59.913204',8,89),(15,'Club meet','We really had nice time in the club meeting today','2018-12-10 12:56:46.791579',8,89),(16,'Experience ','Today\'s session was very good..','2018-12-10 12:57:19.357736',7,94),(17,'Best performance','Trishul gave its best with limited dancers','2018-12-10 13:00:45.133837',3,53),(18,'Events','Please organize more events','2018-12-10 13:06:05.852317',8,89),(19,'Competition','Conduct more competitions ','2018-12-10 13:16:07.852828',11,86),(20,'Talents','Everyone showcases their talents very well\r\n','2018-12-10 13:16:36.779172',3,86),(21,'Food love','Wanna have it..','2018-12-10 13:17:38.912593',11,86),(22,'Best performance','Astra was good among all in abhisarga','2018-12-10 13:18:15.433108',3,86),(23,'Session on Block chain','We need a session on block chain','2018-12-10 13:19:58.739084',8,93),(24,'Block chain','Block chain is interesting and important topic','2018-12-10 13:20:56.618100',7,100),(25,'Exams','Few exams also can be conducted ','2018-12-10 13:21:24.871812',7,100),(26,'Course','It should be made an elective','2018-12-10 13:22:10.731273',8,89),(27,'Direction','Sessions on direction by vinay are great','2018-12-10 13:22:46.192744',5,96),(28,'Appreciation','Gowtham is a professional photographer..','2018-12-10 13:23:55.646790',2,100),(29,'In love with nature','Love it','2018-12-10 13:26:23.744451',6,98),(30,'Agree','I agree making it compulsory course','2018-12-10 13:34:06.311271',8,93);
/*!40000 ALTER TABLE `crew_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_post_media`
--

DROP TABLE IF EXISTS `crew_post_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_post_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_type` varchar(30) NOT NULL,
  `media` varchar(100) NOT NULL,
  `post_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_post_media_post_id_id_8a4a19f1_fk_CREW_post_id` (`post_id_id`),
  CONSTRAINT `CREW_post_media_post_id_id_8a4a19f1_fk_CREW_post_id` FOREIGN KEY (`post_id_id`) REFERENCES `crew_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_post_media`
--

LOCK TABLES `crew_post_media` WRITE;
/*!40000 ALTER TABLE `crew_post_media` DISABLE KEYS */;
INSERT INTO `crew_post_media` VALUES (3,'Image','post_media/panipuri.jpeg',21),(4,'Image','post_media/nature.jpg',29);
/*!40000 ALTER TABLE `crew_post_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_remove_club_log`
--

DROP TABLE IF EXISTS `crew_remove_club_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_remove_club_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remove_datetime` datetime(6) NOT NULL,
  `club_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CREW_remove_club_log_club_id_id_749cc61e_fk_CREW_club_id` (`club_id_id`),
  CONSTRAINT `CREW_remove_club_log_club_id_id_749cc61e_fk_CREW_club_id` FOREIGN KEY (`club_id_id`) REFERENCES `crew_club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_remove_club_log`
--

LOCK TABLES `crew_remove_club_log` WRITE;
/*!40000 ALTER TABLE `crew_remove_club_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `crew_remove_club_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_room`
--

DROP TABLE IF EXISTS `crew_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_num` int(11) NOT NULL,
  `room_capacity` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_room`
--

LOCK TABLES `crew_room` WRITE;
/*!40000 ALTER TABLE `crew_room` DISABLE KEYS */;
INSERT INTO `crew_room` VALUES (1,101,100,1),(2,103,100,1),(3,105,100,1),(4,107,100,1),(5,115,110,1),(6,113,110,1),(7,205,60,1),(8,207,60,1),(9,209,60,1),(10,211,70,1),(11,0,60,1);
/*!40000 ALTER TABLE `crew_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew_user`
--

DROP TABLE IF EXISTS `crew_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `crew_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `user_type` varchar(30) NOT NULL,
  `user_role` varchar(30) NOT NULL,
  `user_password` varchar(30) NOT NULL,
  `user_bio` longtext NOT NULL,
  `user_dp` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew_user`
--

LOCK TABLES `crew_user` WRITE;
/*!40000 ALTER TABLE `crew_user` DISABLE KEYS */;
INSERT INTO `crew_user` VALUES (1,'Sai Madhu Chandhana','madhuchandhana.p16@iiits.in','Student','Club member','Sairam@23','I am a interested in web development','users_profile_images/IMG_2009_jsOrkQp.JPG'),(2,'Vinoothna Sai Kinnera','vinoothnasai.k16@iiits.in','Club Admin','President','vinoothna','I am an active participant in many clubs.','users_profile_images/photo.jpg'),(3,'Prudhvi Krishna','prudhvikrishna.n16@iiits.in','Student','Club member','prudhvi','I am interested in ASE course very much','users_profile_images/photo_1.jpg'),(4,'Rahul Raghava','rahulraghava.p16@iiits.in','Student','Club member','rahulraghava','I am interested in photography','users_profile_images/photo_2.jpg'),(5,'Sai Sachin','saisachin.n16@iiits.in','Student','Club member','sachin','I am interested in face recognition technology','users_profile_images/photo_2_fxEIqng.jpg'),(6,'Vinay Balla','vinay.b15@iiits.in','Club Admin','President','vinay','I am interested in dance,adventures and photography.','users_profile_images/vinay.jpg'),(7,'Raviteja Gowtham','raviteja.g15@iiits.in','Club Admin','President','gowtham','I am interested in photography and also preparing for civils exam','users_profile_images/gowtham.jpg'),(8,'Yogananda Roa','yogananda.r@iiits.in','Super Admin','President','yogananda','I am interested in nature related activities','users_profile_images/yogananda.jpg'),(9,'Rohit Chowdary','rohitchowdary.a16@iiits.in','Student','Club member','rohit','I am interested in adventures.','users_profile_images/photo_4.jpg'),(10,'Chaitanya','viswachaitanya.b16@iiits.in','Club Admin','President','chaitanya','I love kayaking and water sports','users_profile_images/20181209_021712.jpg'),(11,'Nivesh','nivesh.b15@iiits.in','Club Admin','President','nivesh','I love nature','users_profile_images/nivesh.jpg'),(12,'Niteesh','niteesh.k15@iiits.in','Club Admin','President','niteesh','I love nature and interested in civils.','users_profile_images/niteesh.jpg'),(13,'Sumanth Manduru','sumanth.m15@iiits.in','Club Admin','President','sumanth','I love dance.','users_profile_images/sumanth.jpg'),(14,'Krishna Kumar Dey','krishnakumar.d16@iiits.in','Club Admin','President','krishna','I am good at coding','users_profile_images/krishna.jpg'),(15,'M S Shruthi','shruthi.ms16@iiits.in','Club Admin','President','shruthi','I am very interested in music','users_profile_images/photo_5.jpg'),(16,'Sowmya Vasuki','sowmyavasuki.j16@iiits.in','Club Admin','President','sowmya','I am an intelligent girl','users_profile_images/IMG_5439.JPG'),(17,'Rohith','rohith.s15@iiits.in','Club Admin','President','rohith','I am interested in films','users_profile_images/rohith.jpg'),(18,'Meghana','meghana.k16@iiits.in','Club Admin','President','meghana','I am interested in astronomy and related stuff...','users_profile_images/meghana.jpg'),(19,'Sree Pragna','sreepragna.v16@iiits.in','Club Admin','President','pragna','I love stars and elephants','users_profile_images/pragna.jpg'),(20,'Anjali Poornima','anjalipoornima.k16@iiits.in','Student','Club member','anjali','I am a student of IIITS','users_profile_images/IMG_0859.JPG'),(21,'Sri Harshitha','sriharshitha.k16@iiits.in','Student','Club member','harshitha','I am a student of IIITS','users_profile_images/harshitha.jpg'),(22,'Maheswari','maheswari.k16@iiits.in','Student','Club member','maheswari','I am a student of IIITS','users_profile_images/mahe.jpg'),(23,'Renuka','renukaram.s16@iiits.in','Student','Club member','renuka','I am a student of IIITS','users_profile_images/renuka.jpg'),(24,'Deeksha Ummadi','deeksha.u16@iiits.in','Student','Club member','deeksha','I am a student of IIITS','users_profile_images/deeksha.jpg'),(25,'Dharani Maddela','dharani.m16@iiits.in','Student','Club member','dharani','I am a student of IIITS','users_profile_images/dharanim.jpg'),(26,'Vaishnavi','venkatavaishnavi.n16@iiits.in','Student','Club member','vaishnavi','I am a student of IIITS','users_profile_images/vaishu.jpg'),(27,'Dharani Akurathi','dharani.a16@iiits.in','Student','Club member','dharaniakurathi','I am a student of IIITS','users_profile_images/dharania.jpg'),(28,'Sahithi Krishna','sahithikrishna.k16@iiits.in','Student','Club member','sahithi','I am a student of IIITS','users_profile_images/sahithi.jpg'),(29,'Niharika','niharika.c16@iiits.in','Student','Club member','niharika','I am a student of IIITS','users_profile_images/niharika.jpg'),(30,'Keerthi Doma','saikeerthi.d16@iiits.in','Student','Club member','keerthidoma','I am a student of IIITS','users_profile_images/keerthid.jpg'),(31,'Mrudula','mrudulashastri.p16@iiits.in','Student','Club member','mrudula','I am a student of IIITS','users_profile_images/mrudula.jpg'),(32,'Jhansi Rani','jhansirani.c16@iiits.in','Student','Club member','jhansi','I am a student of IIITS','users_profile_images/jhansi.jpg'),(33,'Aswanth Nayak','aswanthnayak.b16@iiits.in','Student','Club member','aswanth','I am a student of IIITS','users_profile_images/aswanth.jpg'),(34,'Anirudh Kannan','anirudhkannan.v16@iiits.in','Student','Club member','anirudh','I am a student of IIITS','users_profile_images/anirudh.jpg'),(35,'Sai Rathan','sairathan.v16@iiits.in','Student','Club member','rathan','I am a student of IIITS','users_profile_images/rathan.jpg'),(36,'Sahaj Agarwal','sahaj.a16@iiits.in','Student','Club member','sahaj','I am a student of IIITS','users_profile_images/sahaj.jpg'),(37,'Sanyem Gupta','sanyem.g16@iiits.in','Student','Club member','sanyem','I am a student of IIITS','users_profile_images/sanyem.jpg'),(38,'Garvit Kataria','garvit.k16@iiits.in','Student','Club member','garvit','I am a student of IIITS','users_profile_images/garvit.jpg'),(39,'Anubhav Ujwal','anubhav.u16@iiits.in','Student','Club member','anubhav','I am a student of IIITS','users_profile_images/anubhav.jpg'),(40,'Anurag Gupta','anurag.g16@iiits.in','Student','Club member','anurag','I am a student of IIITS','users_profile_images/anurag.jpg'),(41,'Paras Dahiya','paras.d16@iiits.in','Student','Club member','paras','I am a student of IIITS','users_profile_images/paras.jpg'),(42,'Prathyush Potluri','prathyush.p16@iiits.in','Student','Club member','prathyush','I am a student of IIITS','users_profile_images/prathyush.jpg'),(43,'Prasanna Kumar','saiprasannakumar.k16@iiits.in','Student','Club member','prasanna','I am a student of IIITS','users_profile_images/prasanna.jpg'),(44,'Rajaram','rajaramachandrarao.v16@iiits.i','Student','Club member','rajaram','I am a student of IIITS','users_profile_images/rajaram.jpg'),(45,'Srijan Reddy','srijanreddy.v16@iiits.in','Student','Club member','srijan','I am a student of IIITS','users_profile_images/srijan.jpg'),(46,'Uday Raj','udayraj.s16@iiits.in','Student','Club member','uday','I am a student of IIITS','users_profile_images/uday.jpg'),(47,'Bhavi Chawla','bhavi.c16@iiits.in','Student','Club member','bhavi','I am a student of IIITS','users_profile_images/bhavi.jpg'),(48,'Rutvik Reddy','rutvikreddy.v16@iiits.in','Student','Club member','rutvik','I am a student of IIITS','users_profile_images/rutvik.jpg'),(49,'Mahathi','mahathi.d16@iiits.in','Student','Club member','mahathi','I am a student of IIITS','users_profile_images/mahathi.jpg'),(50,'Keerthi Priyanka','keerthipriyanka.l16@iiits.in','Student','Club member','keerthipriyanka','I am a student of IIITS','users_profile_images/keerthitwin.jpg'),(51,'Sree Harshitha','sreeharshitha.p16@iiits.in','Student','Club member','harshithapolamada','I am a student of IIITS','users_profile_images/harshithap.jpg'),(52,'Rishitha','rishitha.p16@iiits.in','Student','Club member','rishitha','I am a student of IIITS','users_profile_images/rishitha.jpg'),(53,'Supriya','saisupriya.d16@iiits.in','Student','Club member','supriya','I am a student of IIITS','users_profile_images/supriya.jpg'),(54,'Anusha','satyabalaanusha.s16@iiits.in','Student','Club member','anusha','I am a student of IIITS','users_profile_images/anusha.jpg'),(55,'Arvind Deshraj','arvind.d16@iiits.in','Student','Club member','arvind','I am a student of IIITS','users_profile_images/arvind.jpg'),(56,'Veda','veda.b16@iiits.in','Student','Club member','veda','I am a student of IIITS','users_profile_images/veda.jpg'),(57,'Jahnavi','jahnavi.b16@iiits.in','Student','Club member','jahnavib','I am a student of IIITS','users_profile_images/jahnavib.jpg'),(58,'Jahnavi Gujjula','jahnavi.g16@iiits.in','Student','Club member','jahnavig','I am a student of IIITS','users_profile_images/jahnavig.jpg'),(59,'Monica Guduru','monica.g16@iiits.in','Student','Club member','monica','I am a student of IIITS','users_profile_images/monica.jpg'),(60,'Mounika Chadalavada','mounika.c16@iiits.in','Student','Club member','mounika','I am a student of IIITS','users_profile_images/mounika.jpg'),(61,'Srilekha','srilekha.n16@iiits.in','Student','Club member','srilekha','I am a student of IIITS','users_profile_images/srilekha.jpg'),(62,'Hinduja Bikki','hinduja.b16@iiits.in','Student','Club member','hinduja','I am a student of IIITS','users_profile_images/hinduja.jpg'),(63,'Veena Prathyusha','veenaprathyusha.b16@iiits.in','Student','Club member','veena','I am a student of IIITS','users_profile_images/veena.jpg'),(64,'Sivani','sivani.b16@iiits.in','Student','Club member','sivani','I am a student of IIITS','users_profile_images/sivani.jpg'),(65,'Aakash Shukla','aakash.s16@iiits.in','Student','Club member','aakash','I am a student of IIITS','users_profile_images/aakash.jpg'),(66,'Jaswanth Kumar','jaswanthkumar.y16@iiits.in','Student','Club member','jaswanth','I am a student of IIITS','users_profile_images/jaswanth.jpg'),(67,'Yashwanth','yashwanth.p16@iiits.in','Student','Club member','yashwanth','I am a student of IIITS','users_profile_images/yashwanth.jpg'),(68,'Nikhil Singh','vasanthnikhil.s16@iiits.in','Student','Club member','nikhilsingh','I am a student of IIITS','users_profile_images/nikhilsingh.jpg'),(69,'Prasad Vishal Dinesh','prasadvishal.d16@iiits.in','Student','Club member','prasadvishal','I am a student of IIITS','users_profile_images/vishal.jpg'),(70,'Sowmya Maheshwaram','sowmya.m16@iiits.in','Student','Club member','sowmyamaheshwaram','I am a student of IIITS','users_profile_images/sowmya.jpg'),(71,'Padmini','padmini.c16@iiits.in','Student','Club member','padmini','I am a student of IIITS','users_profile_images/padmini.jpg'),(72,'Manasa','saikaranam.m16@iiits.in','Student','Club member','manasa','I am a student of IIITS','users_profile_images/manasa.jpg'),(73,'Muni Nihitha','muninihitha.p16@iiits.in','Student','Club member','nihitha','I am a student of IIITS','users_profile_images/nihitha.jpg'),(74,'Surya Teja','suryateja.a16@iiits.in','Student','Club member','surya','I am a student of IIITS','users_profile_images/surya.jpg'),(75,'Hareesh','hareesh.t16@iiits.in','Student','Club member','hareesh','I am a student of IIITS','users_profile_images/hareesh.jpg'),(76,'Mani Teja','saimaniteja.a16@iiits.in','Student','Club member','maniteja','I am a student of IIITS','users_profile_images/maniteja.jpg'),(77,'Abhishek','abhishek.t16@iiits.in','Student','Club member','abhishek','I am a student of IIITS','users_profile_images/abhishek.webp'),(78,'Abhilash','abhilash.p16@iiits.in','Student','Club member','abhilash','I am a student of IIITS','users_profile_images/abhilash.jpg'),(79,'Ravi Teja','raviteja.k16@iiits.in','Student','Club member','raviteja','I am a student of IIITS','users_profile_images/raviteja.jpg'),(80,'Venkata Charan','venkatacharan.g16@iiits.in','Student','Club member','charan','I am a student of IIITS','users_profile_images/charan.jpg'),(81,'Manoj','saimanoj.g16@iiits.in','Student','Club member','manoj','I am a student of IIITS','users_profile_images/manoj.jpg'),(82,'Raja Yalla','satyasaivenkataraja.y16@iiits.','Student','Club member','rajayalla','I am a student of IIITS','users_profile_images/rajayalla.jpg'),(83,'Lokesh','venkatlokeshkumar.s16@iiits.in','Student','Club member','lokesh','I am a student of IIITS','users_profile_images/lokesh.jpg'),(84,'Rahul Motipalle','ramsairahul.m16@iiits.in','Student','Club member','rahulm','I am a student of IIITS','users_profile_images/rahulm.jpg'),(85,'Krishna Vamsi','krishnavamsi.d16@iiits.in','Student','Club member','krishnavamsi','I am a student of IIITS','users_profile_images/krishnavamsi.jpg'),(86,'Lasya Athivaram','lasya.a15@iiits.in','Student','Club member','lasya','I am a student of IIITS','users_profile_images/lasya.jpg'),(87,'Nagasai','nagasaigoud.p16@iiits.in','Student','Club member','nagasai','I am a student of IIITS','users_profile_images/nagasai.jpg'),(88,'Swaroop','swaroop.v15@iiits.in','Student','Club member','swaroop','I am a student of IIITS','users_profile_images/swaroop.jpg'),(89,'Dileep Kumar','dileepkumar.p16@iiits.in','Student','Club member','dileep','I am a student of IIITS','users_profile_images/dileep.jpg'),(90,'Subhash Karthikeya','subhashkarthikeya.m16@iiits.in','Student','Club member','karthik','I am a student of IIITS','users_profile_images/karthik.jpg'),(91,'Satyasai','satyasai.k16@iiits.in','Student','Club member','satyasai','I am a student of IIITS','users_profile_images/satyasai.jpg'),(92,'Pavan Sai','pavansai.m16@iiits.in','Student','Club member','pavansai','I am a student of IIITS','users_profile_images/pavansai.jpg'),(93,'Rishav Chandra','rishavchandra.v16@iiits.in','Student','Club member','rishav','I am a student of IIITS','users_profile_images/rishav.jpg'),(94,'Vishakha','vishakha.k16@iiits.in','Student','Club member','vishakha','I am a student of IIITS','users_profile_images/vishakha.jpg'),(95,'Chandrajeet','chandrajeet.c16@iiits.in','Student','Club member','chandrajeet','I am a student of IIITS','users_profile_images/chandrajeet.jpg'),(96,'Ragavi','ragavi.d15@iiits.in','Student','Club member','ragavi','I am a student of IIITS','users_profile_images/ragavi.jpg'),(97,'Vaishali Sharma','vaishali.s16@iiits.in','Student','Club member','vaishali','I am a student of IIITS','users_profile_images/vaishali.jpg'),(98,'Varshitha','varshitha.c15@iiits.in','Student','Club member','varshitha','I am a student of IIITS','users_profile_images/varshitha.jpg'),(99,'Pramod','pramod.y15@iiits.in','Student','Club member','pramod','I am a student of IIITS','users_profile_images/pramod.jpg'),(100,'Shariq','shariqsuhail.m15@iiits.in','Student','Club member','shariq','I am a student of IIITS','users_profile_images/shariq.jpg');
/*!40000 ALTER TABLE `crew_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-12-08 12:21:07.207606','1','1 Sai Madhu Chandhana',1,'[{\"added\": {}}]',22,1),(2,'2018-12-08 12:23:56.753053','1','1 Sai Madhu Chandhana',2,'[{\"changed\": {\"fields\": [\"user_type\"]}}]',22,1),(3,'2018-12-08 12:56:43.771795','2','2 Vinoothna Sai Kinnera',1,'[{\"added\": {}}]',22,1),(4,'2018-12-08 12:56:52.648117','1','1 Sai Madhu Chandhana',2,'[{\"changed\": {\"fields\": [\"user_type\"]}}]',22,1),(5,'2018-12-08 13:00:17.286663','3','3 Prudhvi Krishna',1,'[{\"added\": {}}]',22,1),(6,'2018-12-08 13:01:30.585283','4','4 Rahul Raghava',1,'[{\"added\": {}}]',22,1),(7,'2018-12-08 13:03:26.430552','5','5 Sai Sachin',1,'[{\"added\": {}}]',22,1),(8,'2018-12-08 13:10:57.784165','6','6 Vinay Balla',1,'[{\"added\": {}}]',22,1),(9,'2018-12-08 14:42:02.651158','7','7 Raviteja Gowtham',1,'[{\"added\": {}}]',22,1),(10,'2018-12-08 14:49:25.972566','1','Club id :1 Adventure True',1,'[{\"added\": {}}]',1,1),(11,'2018-12-08 14:56:21.652755','2','Club id :2 Photography True',1,'[{\"added\": {}}]',1,1),(12,'2018-12-08 14:58:06.046408','1','Club id :1 Adventure True user-id 6 Vinay Balla',1,'[{\"added\": {}}]',2,1),(13,'2018-12-08 14:58:43.682637','2','Club id :2 Photography True user-id 7 Raviteja Gowtham',1,'[{\"added\": {}}]',2,1),(14,'2018-12-08 15:13:29.086204','8','8 Yogananda Roa',1,'[{\"added\": {}}]',22,1),(15,'2018-12-08 20:10:34.786332','3','Club id :3 Dance True',1,'[{\"added\": {}}]',1,1),(16,'2018-12-08 20:18:01.735641','4','Club id :4 Entrepreneurship True',1,'[{\"added\": {}}]',1,1),(17,'2018-12-08 20:22:07.528141','5','Club id :5 Film Making True',1,'[{\"added\": {}}]',1,1),(18,'2018-12-08 20:29:06.873178','6','Club id :6 Nature True',1,'[{\"added\": {}}]',1,1),(19,'2018-12-08 20:34:52.057116','7','Club id :7 Programming True',1,'[{\"added\": {}}]',1,1),(20,'2018-12-08 20:40:47.467796','8','Club id :8 Astronomy True',1,'[{\"added\": {}}]',1,1),(21,'2018-12-08 20:45:08.383435','9','9 Rohit Chowdary',1,'[{\"added\": {}}]',22,1),(22,'2018-12-08 20:47:42.219425','10','10 Chaitanya',1,'[{\"added\": {}}]',22,1),(23,'2018-12-08 20:49:29.650743','11','11 Nivesh',1,'[{\"added\": {}}]',22,1),(24,'2018-12-08 20:51:12.345017','12','12 Niteesh',1,'[{\"added\": {}}]',22,1),(25,'2018-12-08 20:53:27.414257','13','13 Sumanth Manduru',1,'[{\"added\": {}}]',22,1),(26,'2018-12-08 20:54:56.041202','3','Club id :3 Dance True user-id 13 Sumanth Manduru',1,'[{\"added\": {}}]',2,1),(27,'2018-12-08 20:55:14.975056','4','Club id :6 Nature True user-id 12 Niteesh',1,'[{\"added\": {}}]',2,1),(28,'2018-12-08 20:57:32.864116','14','14 Krishna Kumar Dey',1,'[{\"added\": {}}]',22,1),(29,'2018-12-08 20:57:46.435980','5','Club id :7 Programming True user-id 14 Krishna Kumar Dey',1,'[{\"added\": {}}]',2,1),(30,'2018-12-09 09:52:25.626864','9','Club id :9 Music True',1,'[{\"added\": {}}]',1,1),(31,'2018-12-09 09:54:11.079810','5','Club id :5 Film Making True',2,'[{\"changed\": {\"fields\": [\"club_description\"]}}]',1,1),(32,'2018-12-09 09:56:17.479732','6','Club id :6 Nature True',2,'[{\"changed\": {\"fields\": [\"club_description\"]}}]',1,1),(33,'2018-12-09 09:57:12.377895','8','Club id :8 Astronomy True',2,'[{\"changed\": {\"fields\": [\"club_description\"]}}]',1,1),(34,'2018-12-09 10:03:01.979577','10','Club id :10 Star Gazing True',1,'[{\"added\": {}}]',1,1),(35,'2018-12-09 10:12:19.213574','11','Club id :11 Cooking True',1,'[{\"added\": {}}]',1,1),(36,'2018-12-09 10:16:42.765788','15','15 M S Shruthi',1,'[{\"added\": {}}]',22,1),(37,'2018-12-09 10:18:02.265730','6','Club id :9 Music True user-id 15 M S Shruthi',1,'[{\"added\": {}}]',2,1),(38,'2018-12-09 10:19:01.723654','2','2 Vinoothna Sai Kinnera',2,'[{\"changed\": {\"fields\": [\"user_type\", \"user_role\"]}}]',22,1),(39,'2018-12-09 10:19:18.455677','7','Club id :11 Cooking True user-id 2 Vinoothna Sai Kinnera',1,'[{\"added\": {}}]',2,1),(40,'2018-12-09 10:24:41.864573','1','Room No - 101',1,'[{\"added\": {}}]',21,1),(41,'2018-12-09 10:25:10.024254','2','Room No - 103',1,'[{\"added\": {}}]',21,1),(42,'2018-12-09 10:25:29.732812','3','Room No - 105',1,'[{\"added\": {}}]',21,1),(43,'2018-12-09 10:25:51.192586','4','Room No - 107',1,'[{\"added\": {}}]',21,1),(44,'2018-12-09 10:26:09.670817','5','Room No - 115',1,'[{\"added\": {}}]',21,1),(45,'2018-12-09 10:26:29.212779','6','Room No - 113',1,'[{\"added\": {}}]',21,1),(46,'2018-12-09 10:29:21.540144','1','1 Elektra',1,'[{\"added\": {}}]',5,1),(47,'2018-12-09 10:30:59.802525','2','2 Reverse Coding',1,'[{\"added\": {}}]',5,1),(48,'2018-12-09 10:32:35.290392','3','3 The-Dancer',1,'[{\"added\": {}}]',5,1),(49,'2018-12-09 10:33:48.034814','4','4 SaReGaMa',1,'[{\"added\": {}}]',5,1),(50,'2018-12-09 10:37:22.860261','5','5 The Cooking Competition',1,'[{\"added\": {}}]',5,1),(51,'2018-12-09 10:39:15.215801','1','1 ElektraImage',1,'[{\"added\": {}}]',6,1),(52,'2018-12-09 10:39:34.323674','2','2 Reverse CodingImage',1,'[{\"added\": {}}]',6,1),(53,'2018-12-09 10:40:02.375172','3','3 The-DancerImage',1,'[{\"added\": {}}]',6,1),(54,'2018-12-09 10:40:22.385826','4','4 SaReGaMaImage',1,'[{\"added\": {}}]',6,1),(55,'2018-12-09 10:59:13.726119','16','16 Sowmya Vasuki',1,'[{\"added\": {}}]',22,1),(56,'2018-12-09 10:59:33.989789','8','Club id :4 Entrepreneurship True user-id 16 Sowmya Vasuki',1,'[{\"added\": {}}]',2,1),(57,'2018-12-09 11:01:32.660430','17','17 Rohith',1,'[{\"added\": {}}]',22,1),(58,'2018-12-09 11:01:47.320926','9','Club id :5 Film Making True user-id 17 Rohith',1,'[{\"added\": {}}]',2,1),(59,'2018-12-09 11:06:05.759253','18','18 Meghana',1,'[{\"added\": {}}]',22,1),(60,'2018-12-09 11:07:54.958420','19','19 Sree Pragna',1,'[{\"added\": {}}]',22,1),(61,'2018-12-09 11:08:10.072974','10','Club id :8 Astronomy True user-id 18 Meghana',1,'[{\"added\": {}}]',2,1),(62,'2018-12-09 11:08:20.319140','11','Club id :10 Star Gazing True user-id 19 Sree Pragna',1,'[{\"added\": {}}]',2,1),(63,'2018-12-09 11:20:40.817889','1','Club id :1 Adventure True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(64,'2018-12-09 11:20:54.761612','2','Club id :2 Photography True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(65,'2018-12-09 11:21:31.797534','3','Club id :3 Dance True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(66,'2018-12-09 11:21:45.173760','4','Club id :4 Entrepreneurship True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(67,'2018-12-09 11:22:01.683601','5','Club id :5 Film Making True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(68,'2018-12-09 11:22:19.745299','6','Club id :6 Nature True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(69,'2018-12-09 11:22:30.463621','7','Club id :7 Programming True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(70,'2018-12-09 11:23:02.592686','8','Club id :8 Astronomy True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(71,'2018-12-09 11:24:03.497785','9','Club id :9 Music True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(72,'2018-12-09 11:24:14.026623','10','Club id :10 Star Gazing True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(73,'2018-12-09 11:24:35.966940','11','Club id :11 Cooking True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(74,'2018-12-09 11:38:57.194153','20','20 Anjali Poornima',1,'[{\"added\": {}}]',22,1),(75,'2018-12-09 11:42:09.736956','21','21 Sri Harshitha',1,'[{\"added\": {}}]',22,1),(76,'2018-12-09 11:43:57.774657','22','22 Maheswari',1,'[{\"added\": {}}]',22,1),(77,'2018-12-09 11:47:16.863341','23','23 Renuka',1,'[{\"added\": {}}]',22,1),(78,'2018-12-09 11:51:07.125553','24','24 Deeksha Ummadi',1,'[{\"added\": {}}]',22,1),(79,'2018-12-09 11:52:34.770057','25','25 Dharani Maddela',1,'[{\"added\": {}}]',22,1),(80,'2018-12-09 11:54:01.015141','26','26 Vaishnavi',1,'[{\"added\": {}}]',22,1),(81,'2018-12-09 11:54:59.094899','27','27 Dharani Akurathi',1,'[{\"added\": {}}]',22,1),(82,'2018-12-09 11:57:19.533406','28','28 Sahithi Krishna',1,'[{\"added\": {}}]',22,1),(83,'2018-12-09 11:58:26.753538','29','29 Niharika',1,'[{\"added\": {}}]',22,1),(84,'2018-12-09 12:09:11.578918','30','30 Keerthi Doma',1,'[{\"added\": {}}]',22,1),(85,'2018-12-09 12:13:01.206800','31','31 Mrudula',1,'[{\"added\": {}}]',22,1),(86,'2018-12-09 12:14:02.859338','32','32 Jhansi Rani',1,'[{\"added\": {}}]',22,1),(87,'2018-12-09 12:15:54.043870','33','33 Aswanth Nayak',1,'[{\"added\": {}}]',22,1),(88,'2018-12-09 12:17:46.603950','34','34 Anirudh Kannan',1,'[{\"added\": {}}]',22,1),(89,'2018-12-09 12:18:57.175091','35','35 Sai Rathan',1,'[{\"added\": {}}]',22,1),(90,'2018-12-09 12:22:21.961354','6','6 Vinay Balla',2,'[{\"changed\": {\"fields\": [\"user_dp\"]}}]',22,1),(91,'2018-12-09 12:24:32.030693','36','36 Sahaj Agarwal',1,'[{\"added\": {}}]',22,1),(92,'2018-12-09 12:25:37.543948','37','37 Sanyem Gupta',1,'[{\"added\": {}}]',22,1),(93,'2018-12-09 12:27:10.413130','38','38 Garvit Kataria',1,'[{\"added\": {}}]',22,1),(94,'2018-12-09 12:35:11.553159','39','39 Anubhav Ujwal',1,'[{\"added\": {}}]',22,1),(95,'2018-12-09 12:36:12.718343','40','40 Anurag Gupta',1,'[{\"added\": {}}]',22,1),(96,'2018-12-09 12:38:34.042044','41','41 Paras Dahiya',1,'[{\"added\": {}}]',22,1),(97,'2018-12-09 12:40:28.134092','42','42 Prathyush Potluri',1,'[{\"added\": {}}]',22,1),(98,'2018-12-09 12:41:51.051890','43','43 Prasanna Kumar',1,'[{\"added\": {}}]',22,1),(99,'2018-12-09 12:43:12.229305','44','44 Rajaram',1,'[{\"added\": {}}]',22,1),(100,'2018-12-09 12:45:08.703586','45','45 Srijan Reddy',1,'[{\"added\": {}}]',22,1),(101,'2018-12-09 12:47:00.676926','46','46 Uday Raj',1,'[{\"added\": {}}]',22,1),(102,'2018-12-09 12:47:55.294296','47','47 Bhavi Chawla',1,'[{\"added\": {}}]',22,1),(103,'2018-12-09 12:49:15.773152','48','48 Rutvik Reddy',1,'[{\"added\": {}}]',22,1),(104,'2018-12-09 12:50:42.107273','49','49 Mahathi',1,'[{\"added\": {}}]',22,1),(105,'2018-12-09 13:02:25.417502','50','50 Keerthi Priyanka',1,'[{\"added\": {}}]',22,1),(106,'2018-12-09 13:05:17.858591','51','51 Sree Harshitha',1,'[{\"added\": {}}]',22,1),(107,'2018-12-09 13:10:02.822629','52','52 Rishitha',1,'[{\"added\": {}}]',22,1),(108,'2018-12-09 13:11:09.200175','53','53 Supriya',1,'[{\"added\": {}}]',22,1),(109,'2018-12-09 13:12:22.911409','54','54 Anusha',1,'[{\"added\": {}}]',22,1),(110,'2018-12-09 13:13:35.433241','55','55 Arvind Deshraj',1,'[{\"added\": {}}]',22,1),(111,'2018-12-09 13:24:07.057389','56','56 Veda',1,'[{\"added\": {}}]',22,1),(112,'2018-12-09 13:25:03.816346','57','57 Jahnavi',1,'[{\"added\": {}}]',22,1),(113,'2018-12-09 13:25:50.215902','58','58 Jahnavi Gujjula',1,'[{\"added\": {}}]',22,1),(114,'2018-12-09 13:26:41.371837','59','59 Monica Guduru',1,'[{\"added\": {}}]',22,1),(115,'2018-12-09 13:27:25.453894','60','60 Mounika Chadalavada',1,'[{\"added\": {}}]',22,1),(116,'2018-12-09 13:28:16.377022','61','61 Srilekha',1,'[{\"added\": {}}]',22,1),(117,'2018-12-09 13:31:40.159884','62','62 Hinduja Bikki',1,'[{\"added\": {}}]',22,1),(118,'2018-12-09 13:32:56.753028','63','63 Veena Prathyusha',1,'[{\"added\": {}}]',22,1),(119,'2018-12-09 13:34:33.728636','64','64 Sivani',1,'[{\"added\": {}}]',22,1),(120,'2018-12-09 13:36:14.238539','65','65 Aakash Shukla',1,'[{\"added\": {}}]',22,1),(121,'2018-12-09 13:37:13.940998','66','66 Jaswanth Kumar',1,'[{\"added\": {}}]',22,1),(122,'2018-12-09 13:39:10.619726','67','67 Yashwanth',1,'[{\"added\": {}}]',22,1),(123,'2018-12-09 15:54:34.642050','68','68 Nikhil Singh',1,'[{\"added\": {}}]',22,1),(124,'2018-12-09 15:57:45.786586','69','69 Prasad Vishal Dinesh',1,'[{\"added\": {}}]',22,1),(125,'2018-12-09 16:01:15.193597','70','70 Sowmya Maheshwaram',1,'[{\"added\": {}}]',22,1),(126,'2018-12-09 16:02:05.384826','71','71 Padmini',1,'[{\"added\": {}}]',22,1),(127,'2018-12-09 16:04:07.053538','72','72 Manasa',1,'[{\"added\": {}}]',22,1),(128,'2018-12-09 16:05:26.668750','7','7 Raviteja Gowtham',2,'[{\"changed\": {\"fields\": [\"user_dp\"]}}]',22,1),(129,'2018-12-09 16:10:24.020111','73','73 Muni Nihitha',1,'[{\"added\": {}}]',22,1),(130,'2018-12-09 16:11:28.111796','74','74 Surya Teja',1,'[{\"added\": {}}]',22,1),(131,'2018-12-09 16:14:49.731850','75','75 Hareesh',1,'[{\"added\": {}}]',22,1),(132,'2018-12-09 16:33:18.750814','76','76 Mani Teja',1,'[{\"added\": {}}]',22,1),(133,'2018-12-09 16:34:31.730908','77','77 Abhishek',1,'[{\"added\": {}}]',22,1),(134,'2018-12-09 16:35:30.585785','78','78 Abhilash',1,'[{\"added\": {}}]',22,1),(135,'2018-12-09 16:37:48.895236','79','79 Ravi Teja',1,'[{\"added\": {}}]',22,1),(136,'2018-12-09 16:39:32.934211','80','80 Venkata Charan',1,'[{\"added\": {}}]',22,1),(137,'2018-12-09 16:40:27.777704','81','81 Manoj',1,'[{\"added\": {}}]',22,1),(138,'2018-12-09 16:41:40.297984','82','82 Raja Yalla',1,'[{\"added\": {}}]',22,1),(139,'2018-12-09 16:42:59.046691','83','83 Lokesh',1,'[{\"added\": {}}]',22,1),(140,'2018-12-09 16:44:39.579687','84','84 Rahul Motipalle',1,'[{\"added\": {}}]',22,1),(141,'2018-12-09 16:46:50.511910','85','85 Krishna Vamsi',1,'[{\"added\": {}}]',22,1),(142,'2018-12-09 16:47:59.916924','86','86 Lasya Athivaram',1,'[{\"added\": {}}]',22,1),(143,'2018-12-09 16:50:28.321917','87','87 Nagasai',1,'[{\"added\": {}}]',22,1),(144,'2018-12-09 16:51:56.373952','88','88 Swaroop',1,'[{\"added\": {}}]',22,1),(145,'2018-12-09 16:53:21.190556','89','89 Dileep Kumar',1,'[{\"added\": {}}]',22,1),(146,'2018-12-09 16:54:47.424315','90','90 Subhash Karthikeya',1,'[{\"added\": {}}]',22,1),(147,'2018-12-09 16:55:54.902325','91','91 Satyasai',1,'[{\"added\": {}}]',22,1),(148,'2018-12-09 16:56:47.651350','92','92 Pavan Sai',1,'[{\"added\": {}}]',22,1),(149,'2018-12-09 16:58:28.746629','93','93 Rishav Chandra',1,'[{\"added\": {}}]',22,1),(150,'2018-12-09 16:59:48.246556','94','94 Vishakha',1,'[{\"added\": {}}]',22,1),(151,'2018-12-09 17:00:48.246577','95','95 Chandrajeet',1,'[{\"added\": {}}]',22,1),(152,'2018-12-09 17:01:49.876008','96','96 Ragavi',1,'[{\"added\": {}}]',22,1),(153,'2018-12-09 17:02:43.741455','97','97 Vaishali Sharma',1,'[{\"added\": {}}]',22,1),(154,'2018-12-09 17:03:47.166983','98','98 Varshitha',1,'[{\"added\": {}}]',22,1),(155,'2018-12-09 17:04:54.999954','99','99 Pramod',1,'[{\"added\": {}}]',22,1),(156,'2018-12-09 17:06:10.495137','100','100 Shariq',1,'[{\"added\": {}}]',22,1),(157,'2018-12-10 08:16:58.167315','8','8 Yogananda Roa',2,'[{\"changed\": {\"fields\": [\"user_dp\"]}}]',22,1),(158,'2018-12-10 09:31:49.364971','3','Club id :3 Dance True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(159,'2018-12-10 09:33:09.804821','1','Club id :1 Adventure True',2,'[{\"changed\": {\"fields\": [\"club_tc\"]}}]',1,1),(160,'2018-12-10 09:33:23.322663','11','Club id :11 Cooking True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(161,'2018-12-10 09:33:50.987669','5','Club id :5 Film Making True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(162,'2018-12-10 09:34:24.387335','2','Club id :2 Photography True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(163,'2018-12-10 09:35:03.435893','7','Club id :7 Programming True',2,'[{\"changed\": {\"fields\": [\"club_logo\"]}}]',1,1),(164,'2018-12-10 09:38:57.134310','5','Registration Club id :4 Entrepreneurship True user-id 3 Prudhvi Krishna',1,'[{\"added\": {}}]',3,1),(165,'2018-12-10 09:39:08.189197','6','Registration Club id :5 Film Making True user-id 3 Prudhvi Krishna',1,'[{\"added\": {}}]',3,1),(166,'2018-12-10 09:39:21.015685','7','Registration Club id :2 Photography True user-id 12 Niteesh',1,'[{\"added\": {}}]',3,1),(167,'2018-12-10 09:39:30.581637','8','Registration Club id :11 Cooking True user-id 15 M S Shruthi',1,'[{\"added\": {}}]',3,1),(168,'2018-12-10 09:39:54.961531','9','Registration Club id :1 Adventure True user-id 11 Nivesh',1,'[{\"added\": {}}]',3,1),(169,'2018-12-10 09:40:12.975279','10','Registration Club id :7 Programming True user-id 95 Chandrajeet',1,'[{\"added\": {}}]',3,1),(170,'2018-12-10 09:40:22.271891','11','Registration Club id :9 Music True user-id 13 Sumanth Manduru',1,'[{\"added\": {}}]',3,1),(171,'2018-12-10 09:40:33.166419','12','Registration Club id :3 Dance True user-id 6 Vinay Balla',1,'[{\"added\": {}}]',3,1),(172,'2018-12-10 09:40:41.354960','13','Registration Club id :10 Star Gazing True user-id 7 Raviteja Gowtham',1,'[{\"added\": {}}]',3,1),(173,'2018-12-10 09:40:52.096671','14','Registration Club id :4 Entrepreneurship True user-id 97 Vaishali Sharma',1,'[{\"added\": {}}]',3,1),(174,'2018-12-10 09:41:45.446840','15','Registration Club id :7 Programming True user-id 10 Chaitanya',1,'[{\"added\": {}}]',3,1),(175,'2018-12-10 09:41:56.578077','16','Registration Club id :5 Film Making True user-id 5 Sai Sachin',1,'[{\"added\": {}}]',3,1),(176,'2018-12-10 09:42:05.289556','17','Registration Club id :5 Film Making True user-id 14 Krishna Kumar Dey',1,'[{\"added\": {}}]',3,1),(177,'2018-12-10 09:42:15.342590','18','Registration Club id :8 Astronomy True user-id 73 Muni Nihitha',1,'[{\"added\": {}}]',3,1),(178,'2018-12-10 09:42:23.500364','19','Registration Club id :9 Music True user-id 18 Meghana',1,'[{\"added\": {}}]',3,1),(179,'2018-12-10 09:42:33.592000','20','Registration Club id :8 Astronomy True user-id 89 Dileep Kumar',1,'[{\"added\": {}}]',3,1),(180,'2018-12-10 09:42:42.100653','21','Registration Club id :7 Programming True user-id 93 Rishav Chandra',1,'[{\"added\": {}}]',3,1),(181,'2018-12-10 09:42:58.119241','22','Registration Club id :10 Star Gazing True user-id 16 Sowmya Vasuki',1,'[{\"added\": {}}]',3,1),(182,'2018-12-10 09:43:06.975223','23','Registration Club id :5 Film Making True user-id 16 Sowmya Vasuki',1,'[{\"added\": {}}]',3,1),(183,'2018-12-10 09:43:16.531648','24','Registration Club id :7 Programming True user-id 94 Vishakha',1,'[{\"added\": {}}]',3,1),(184,'2018-12-10 09:43:24.743984','25','Registration Club id :4 Entrepreneurship True user-id 4 Rahul Raghava',1,'[{\"added\": {}}]',3,1),(185,'2018-12-10 09:43:35.521167','26','Registration Club id :5 Film Making True user-id 1 Sai Madhu Chandhana',1,'[{\"added\": {}}]',3,1),(186,'2018-12-10 09:43:53.334649','27','Registration Club id :8 Astronomy True user-id 5 Sai Sachin',1,'[{\"added\": {}}]',3,1),(187,'2018-12-10 09:44:31.143757','28','Registration Club id :8 Astronomy True user-id 93 Rishav Chandra',1,'[{\"added\": {}}]',3,1),(188,'2018-12-10 09:44:44.073485','29','Registration Club id :2 Photography True user-id 56 Veda',1,'[{\"added\": {}}]',3,1),(189,'2018-12-10 09:44:53.942060','30','Registration Club id :4 Entrepreneurship True user-id 45 Srijan Reddy',1,'[{\"added\": {}}]',3,1),(190,'2018-12-10 09:45:03.490013','31','Registration Club id :4 Entrepreneurship True user-id 69 Prasad Vishal Dinesh',1,'[{\"added\": {}}]',3,1),(191,'2018-12-10 09:45:14.047122','32','Registration Club id :5 Film Making True user-id 96 Ragavi',1,'[{\"added\": {}}]',3,1),(192,'2018-12-10 09:45:24.031817','33','Registration Club id :6 Nature True user-id 98 Varshitha',1,'[{\"added\": {}}]',3,1),(193,'2018-12-10 09:45:39.847029','34','Registration Club id :7 Programming True user-id 100 Shariq',1,'[{\"added\": {}}]',3,1),(194,'2018-12-10 09:45:49.549765','35','Registration Club id :7 Programming True user-id 99 Pramod',1,'[{\"added\": {}}]',3,1),(195,'2018-12-10 09:45:59.126207','36','Registration Club id :1 Adventure True user-id 94 Vishakha',1,'[{\"added\": {}}]',3,1),(196,'2018-12-10 09:46:08.330828','37','Registration Club id :6 Nature True user-id 31 Mrudula',1,'[{\"added\": {}}]',3,1),(197,'2018-12-10 09:46:18.032127','38','Registration Club id :2 Photography True user-id 61 Srilekha',1,'[{\"added\": {}}]',3,1),(198,'2018-12-10 09:46:28.808284','39','Registration Club id :8 Astronomy True user-id 58 Jahnavi Gujjula',1,'[{\"added\": {}}]',3,1),(199,'2018-12-10 09:46:38.431415','40','Registration Club id :9 Music True user-id 92 Pavan Sai',1,'[{\"added\": {}}]',3,1),(200,'2018-12-10 09:46:48.732876','41','Registration Club id :2 Photography True user-id 42 Prathyush Potluri',1,'[{\"added\": {}}]',3,1),(201,'2018-12-10 09:47:08.008137','42','Registration Club id :7 Programming True user-id 91 Satyasai',1,'[{\"added\": {}}]',3,1),(202,'2018-12-10 09:47:23.636923','43','Registration Club id :7 Programming True user-id 90 Subhash Karthikeya',1,'[{\"added\": {}}]',3,1),(203,'2018-12-10 09:47:34.116647','44','Registration Club id :7 Programming True user-id 87 Nagasai',1,'[{\"added\": {}}]',3,1),(204,'2018-12-10 09:47:46.403951','45','Registration Club id :11 Cooking True user-id 54 Anusha',1,'[{\"added\": {}}]',3,1),(205,'2018-12-10 09:47:56.053741','46','Registration Club id :11 Cooking True user-id 86 Lasya Athivaram',1,'[{\"added\": {}}]',3,1),(206,'2018-12-10 09:48:11.572085','47','Registration Club id :4 Entrepreneurship True user-id 84 Rahul Motipalle',1,'[{\"added\": {}}]',3,1),(207,'2018-12-10 09:48:23.282254','48','Registration Club id :5 Film Making True user-id 82 Raja Yalla',1,'[{\"added\": {}}]',3,1),(208,'2018-12-10 09:49:22.667244','49','Registration Club id :1 Adventure True user-id 61 Srilekha',1,'[{\"added\": {}}]',3,1),(209,'2018-12-10 09:49:37.959547','50','Registration Club id :3 Dance True user-id 83 Lokesh',1,'[{\"added\": {}}]',3,1),(210,'2018-12-10 09:49:49.131629','51','Registration Club id :2 Photography True user-id 81 Manoj',1,'[{\"added\": {}}]',3,1),(211,'2018-12-10 09:49:59.358046','52','Registration Club id :7 Programming True user-id 55 Arvind Deshraj',1,'[{\"added\": {}}]',3,1),(212,'2018-12-10 09:50:09.116477','53','Registration Club id :7 Programming True user-id 44 Rajaram',1,'[{\"added\": {}}]',3,1),(213,'2018-12-10 09:50:18.970719','54','Registration Club id :6 Nature True user-id 79 Ravi Teja',1,'[{\"added\": {}}]',3,1),(214,'2018-12-10 09:50:27.175240','55','Registration Club id :9 Music True user-id 10 Chaitanya',1,'[{\"added\": {}}]',3,1),(215,'2018-12-10 09:50:42.677145','56','Registration Club id :7 Programming True user-id 63 Veena Prathyusha',1,'[{\"added\": {}}]',3,1),(216,'2018-12-10 09:50:56.950935','57','Registration Club id :6 Nature True user-id 75 Hareesh',1,'[{\"added\": {}}]',3,1),(217,'2018-12-10 09:51:06.905876','58','Registration Club id :5 Film Making True user-id 49 Mahathi',1,'[{\"added\": {}}]',3,1),(218,'2018-12-10 09:51:17.485057','59','Registration Club id :7 Programming True user-id 29 Niharika',1,'[{\"added\": {}}]',3,1),(219,'2018-12-10 09:51:27.961812','60','Registration Club id :5 Film Making True user-id 36 Sahaj Agarwal',1,'[{\"added\": {}}]',3,1),(220,'2018-12-10 09:51:37.292331','61','Registration Club id :7 Programming True user-id 34 Anirudh Kannan',1,'[{\"added\": {}}]',3,1),(221,'2018-12-10 09:51:47.965479','62','Registration Club id :5 Film Making True user-id 41 Paras Dahiya',1,'[{\"added\": {}}]',3,1),(222,'2018-12-10 09:52:00.509302','63','Registration Club id :8 Astronomy True user-id 67 Yashwanth',1,'[{\"added\": {}}]',3,1),(223,'2018-12-10 09:52:12.611607','64','Registration Club id :7 Programming True user-id 35 Sai Rathan',1,'[{\"added\": {}}]',3,1),(224,'2018-12-10 09:52:25.554240','65','Registration Club id :7 Programming True user-id 66 Jaswanth Kumar',1,'[{\"added\": {}}]',3,1),(225,'2018-12-10 09:52:36.342001','66','Registration Club id :5 Film Making True user-id 71 Padmini',1,'[{\"added\": {}}]',3,1),(226,'2018-12-10 09:52:47.541810','67','Registration Club id :3 Dance True user-id 65 Aakash Shukla',1,'[{\"added\": {}}]',3,1),(227,'2018-12-10 09:52:58.972163','68','Registration Club id :4 Entrepreneurship True user-id 50 Keerthi Priyanka',1,'[{\"added\": {}}]',3,1),(228,'2018-12-10 09:53:09.696324','69','Registration Club id :5 Film Making True user-id 70 Sowmya Maheshwaram',1,'[{\"added\": {}}]',3,1),(229,'2018-12-10 09:53:20.973807','70','Registration Club id :5 Film Making True user-id 51 Sree Harshitha',1,'[{\"added\": {}}]',3,1),(230,'2018-12-10 09:53:33.570130','71','Registration Club id :3 Dance True user-id 68 Nikhil Singh',1,'[{\"added\": {}}]',3,1),(231,'2018-12-10 09:53:46.788089','72','Registration Club id :8 Astronomy True user-id 65 Aakash Shukla',1,'[{\"added\": {}}]',3,1),(232,'2018-12-10 09:53:59.868236','73','Registration Club id :3 Dance True user-id 88 Swaroop',1,'[{\"added\": {}}]',3,1),(233,'2018-12-10 09:54:31.785242','74','Registration Club id :3 Dance True user-id 26 Vaishnavi',1,'[{\"added\": {}}]',3,1),(234,'2018-12-10 09:54:42.368004','75','Registration Club id :1 Adventure True user-id 54 Anusha',1,'[{\"added\": {}}]',3,1),(235,'2018-12-10 09:54:56.364158','76','Registration Club id :2 Photography True user-id 47 Bhavi Chawla',1,'[{\"added\": {}}]',3,1),(236,'2018-12-10 09:55:06.444754','77','Registration Club id :3 Dance True user-id 59 Monica Guduru',1,'[{\"added\": {}}]',3,1),(237,'2018-12-10 09:55:15.988348','78','Registration Club id :4 Entrepreneurship True user-id 23 Renuka',1,'[{\"added\": {}}]',3,1),(238,'2018-12-10 09:55:28.477544','79','Registration Club id :4 Entrepreneurship True user-id 37 Sanyem Gupta',1,'[{\"added\": {}}]',3,1),(239,'2018-12-10 09:55:51.454859','80','Registration Club id :10 Star Gazing True user-id 7 Raviteja Gowtham',1,'[{\"added\": {}}]',3,1),(240,'2018-12-10 09:56:02.441728','81','Registration Club id :1 Adventure True user-id 78 Abhilash',1,'[{\"added\": {}}]',3,1),(241,'2018-12-10 09:56:12.840068','82','Registration Club id :7 Programming True user-id 77 Abhishek',1,'[{\"added\": {}}]',3,1),(242,'2018-12-10 09:56:32.773828','83','Registration Club id :4 Entrepreneurship True user-id 57 Jahnavi',1,'[{\"added\": {}}]',3,1),(243,'2018-12-10 09:57:16.364424','84','Registration Club id :5 Film Making True user-id 64 Sivani',1,'[{\"added\": {}}]',3,1),(244,'2018-12-10 09:57:28.940174','85','Registration Club id :3 Dance True user-id 53 Supriya',1,'[{\"added\": {}}]',3,1),(245,'2018-12-10 09:57:39.638992','86','Registration Club id :4 Entrepreneurship True user-id 46 Uday Raj',1,'[{\"added\": {}}]',3,1),(246,'2018-12-10 09:58:02.012211','87','Registration Club id :6 Nature True user-id 52 Rishitha',1,'[{\"added\": {}}]',3,1),(247,'2018-12-10 09:58:18.991175','88','Registration Club id :1 Adventure True user-id 49 Mahathi',1,'[{\"added\": {}}]',3,1),(248,'2018-12-10 09:58:29.134567','89','Registration Club id :7 Programming True user-id 38 Garvit Kataria',1,'[{\"added\": {}}]',3,1),(249,'2018-12-10 09:58:40.627277','90','Registration Club id :5 Film Making True user-id 59 Monica Guduru',1,'[{\"added\": {}}]',3,1),(250,'2018-12-10 09:58:50.592393','91','Registration Club id :11 Cooking True user-id 50 Keerthi Priyanka',1,'[{\"added\": {}}]',3,1),(251,'2018-12-10 09:59:00.716051','92','Registration Club id :7 Programming True user-id 7 Raviteja Gowtham',1,'[{\"added\": {}}]',3,1),(252,'2018-12-10 09:59:08.588542','93','Registration Club id :7 Programming True user-id 6 Vinay Balla',1,'[{\"added\": {}}]',3,1),(253,'2018-12-10 09:59:19.435926','94','Registration Club id :9 Music True user-id 5 Sai Sachin',1,'[{\"added\": {}}]',3,1),(254,'2018-12-10 09:59:28.040959','95','Registration Club id :1 Adventure True user-id 12 Niteesh',1,'[{\"added\": {}}]',3,1),(255,'2018-12-10 09:59:43.355054','96','Registration Club id :7 Programming True user-id 48 Rutvik Reddy',1,'[{\"added\": {}}]',3,1),(256,'2018-12-10 10:00:28.284398','97','Registration Club id :9 Music True user-id 54 Anusha',1,'[{\"added\": {}}]',3,1),(257,'2018-12-10 10:00:54.056019','98','Registration Club id :8 Astronomy True user-id 30 Keerthi Doma',1,'[{\"added\": {}}]',3,1),(258,'2018-12-10 10:01:28.196473','99','Registration Club id :3 Dance True user-id 86 Lasya Athivaram',1,'[{\"added\": {}}]',3,1),(259,'2018-12-10 10:01:39.325687','100','Registration Club id :1 Adventure True user-id 10 Chaitanya',1,'[{\"added\": {}}]',3,1),(260,'2018-12-10 10:02:21.498408','101','Registration Club id :2 Photography True user-id 100 Shariq',1,'[{\"added\": {}}]',3,1),(261,'2018-12-10 10:55:18.150571','9','9 Rohit Chowdary',2,'[{\"changed\": {\"fields\": [\"user_type\", \"user_role\"]}}]',22,1),(262,'2018-12-10 11:29:02.049103','25','25Best performance',2,'[{\"changed\": {\"fields\": [\"poll_description\"]}}]',15,1),(263,'2018-12-10 12:20:51.833162','1','1 Sai Madhu Chandhana',2,'[{\"changed\": {\"fields\": [\"user_dp\"]}}]',22,1),(264,'2018-12-10 12:47:37.103627','94','94 Vishakha',2,'[{\"changed\": {\"fields\": [\"user_email\"]}}]',22,1),(265,'2018-12-10 12:49:54.290854','1','Event : 1 Elektra User :94 Vishakha',3,'',7,1),(266,'2018-12-10 13:58:27.926542','2','Post :1 TrekkingImage',3,'',19,1),(267,'2018-12-10 13:58:28.238706','1','Post :1 TrekkingImage',3,'',19,1),(268,'2018-12-10 14:12:42.131501','2','Event : 5 The Cooking Competition User :1 Sai Madhu Chandhana',1,'[{\"added\": {}}]',7,1),(269,'2018-12-10 18:07:27.583542','6','Room No - 113',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(270,'2018-12-10 18:07:32.196178','5','Room No - 115',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(271,'2018-12-10 18:07:36.680524','4','Room No - 107',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(272,'2018-12-10 18:07:41.287685','3','Room No - 105',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(273,'2018-12-10 18:07:48.206303','2','Room No - 103',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(274,'2018-12-10 18:07:52.745088','1','Room No - 101',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',21,1),(275,'2018-12-10 18:08:07.434832','7','Room No - 205',1,'[{\"added\": {}}]',21,1),(276,'2018-12-10 18:08:20.497157','8','Room No - 207',1,'[{\"added\": {}}]',21,1),(277,'2018-12-10 18:20:58.180165','9','Room No - 209',1,'[{\"added\": {}}]',21,1),(278,'2018-12-10 18:21:50.313210','10','Room No - 211',1,'[{\"added\": {}}]',21,1),(279,'2018-12-10 18:32:41.637958','11','Room No - 0',1,'[{\"added\": {}}]',21,1),(280,'2018-12-10 18:34:53.911139','6','6 Bird watching',1,'[{\"added\": {}}]',5,1),(281,'2018-12-10 18:51:51.778632','7','7 College Chef',1,'[{\"added\": {}}]',5,1),(282,'2018-12-10 18:54:27.414138','8','8 Shuttersbugs',1,'[{\"added\": {}}]',5,1),(283,'2018-12-10 18:56:54.018022','9','9 Silver screen',1,'[{\"added\": {}}]',5,1),(284,'2018-12-10 19:01:10.392530','10','10 Saahas',1,'[{\"added\": {}}]',5,1),(285,'2018-12-10 19:01:33.788521','10','10 Saahas',2,'[{\"changed\": {\"fields\": [\"event_type\"]}}]',5,1),(286,'2018-12-10 19:08:15.047875','11','11 Star scope',1,'[{\"added\": {}}]',5,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (23,'admin','logentry'),(25,'auth','group'),(24,'auth','permission'),(26,'auth','user'),(27,'contenttypes','contenttype'),(1,'CREW','club'),(2,'CREW','club_admin'),(3,'CREW','club_registered_member'),(4,'CREW','comment'),(5,'CREW','event'),(6,'CREW','event_media'),(7,'CREW','event_registered_user'),(8,'CREW','leave_club_log'),(9,'CREW','likes'),(10,'CREW','login'),(11,'CREW','logout_log'),(12,'CREW','media'),(13,'CREW','notification'),(14,'CREW','notification_user'),(15,'CREW','poll'),(16,'CREW','poll_options'),(17,'CREW','poll_participation'),(18,'CREW','post'),(19,'CREW','post_media'),(20,'CREW','remove_club_log'),(21,'CREW','room'),(22,'CREW','user'),(28,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'CREW','0001_initial','2018-12-08 12:09:57.179137'),(2,'CREW','0002_club_club_active_status','2018-12-08 12:09:59.035123'),(3,'contenttypes','0001_initial','2018-12-08 12:10:00.572014'),(4,'auth','0001_initial','2018-12-08 12:10:27.136960'),(5,'admin','0001_initial','2018-12-08 12:10:32.982327'),(6,'admin','0002_logentry_remove_auto_add','2018-12-08 12:10:33.100049'),(7,'admin','0003_logentry_add_action_flag_choices','2018-12-08 12:10:33.229664'),(8,'contenttypes','0002_remove_content_type_name','2018-12-08 12:10:39.244577'),(9,'auth','0002_alter_permission_name_max_length','2018-12-08 12:10:41.363907'),(10,'auth','0003_alter_user_email_max_length','2018-12-08 12:10:43.799394'),(11,'auth','0004_alter_user_username_opts','2018-12-08 12:10:43.874244'),(12,'auth','0005_alter_user_last_login_null','2018-12-08 12:10:45.783123'),(13,'auth','0006_require_contenttypes_0002','2018-12-08 12:10:45.870880'),(14,'auth','0007_alter_validators_add_error_messages','2018-12-08 12:10:46.030427'),(15,'auth','0008_alter_user_username_max_length','2018-12-08 12:10:48.960589'),(16,'auth','0009_alter_user_last_name_max_length','2018-12-08 12:10:50.817623'),(17,'sessions','0001_initial','2018-12-08 12:10:52.286694'),(18,'CREW','0003_event_event_description','2018-12-10 12:21:27.669903');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('vlf3cs5e8pm09tbymhnaifucyfp4a7m7','ZjlhODAzMmZjOGQ4OTRiNzYxMjE2ZTQ0ZjFhNjBkOTdiODk2YmZlYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NDJkMDE5ZWExYTQyMDFmNGUyMjhkMTRkYTFmZDUzMzJmMmJjMGE4In0=','2018-12-22 12:18:25.207962');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'crews'
--
/*!50003 DROP PROCEDURE IF EXISTS `joined_clubs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `joined_clubs`(IN user_id INT)
BEGIN
SELECT c.id,c.club_name,cr.date_of_joining FROM ((crew_club c join crew_club_registered_member cr ON c.id=cr.club_id_id)join crew_user u ON u.id=cr.user_id_id) WHERE u.id=user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `my_events` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `my_events`(IN user_id INT)
BEGIN
select e.id,e.event_name,eru.register_datetime from ((crew_event e join crew_event_registered_user eru on e.id=eru.event_id_id)join crew_user u on u.id = eru.user_id_id)where u.id=user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `my_posts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `my_posts`(IN user_id INT)
BEGIN
select p.id,p.post_title,c.club_name,p.post_datetime from ((crew_post p join crew_club c on p.club_id_id=c.id)join crew_user u on p.posted_by_id_id=u.id) where u.id=user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-11  0:42:29
