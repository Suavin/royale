-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.30-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para vrp
CREATE DATABASE IF NOT EXISTS `vrp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vrp`;

-- Copiando estrutura para tabela vrp.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_app_chat: ~0 rows (aproximadamente)
DELETE FROM `phone_app_chat`;
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_calls: ~0 rows (aproximadamente)
DELETE FROM `phone_calls`;
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_messages: 0 rows
DELETE FROM `phone_messages`;
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_users_contacts: 0 rows
DELETE FROM `phone_users_contacts`;
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_accounts
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_accounts: ~0 rows (aproximadamente)
DELETE FROM `twitter_accounts`;
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_likes
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_likes: ~0 rows (aproximadamente)
DELETE FROM `twitter_likes`;
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela vrp.twitter_tweets: ~0 rows (aproximadamente)
DELETE FROM `twitter_tweets`;
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_business
CREATE TABLE IF NOT EXISTS `vrp_business` (
  `user_id` int(11) NOT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_business: ~0 rows (aproximadamente)
DELETE FROM `vrp_business`;
/*!40000 ALTER TABLE `vrp_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_business` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_srv_data: ~0 rows (aproximadamente)
DELETE FROM `vrp_srv_data`;
/*!40000 ALTER TABLE `vrp_srv_data` DISABLE KEYS */;
INSERT INTO `vrp_srv_data` (`dkey`, `dvalue`) VALUES
	('custom:u1veh_toros', '{"janela":-1,"plate":{"text":"85MJX871","index":0},"farol":false,"wheel":3,"turbo":false,"mods":{"1":-1,"2":-1,"3":-1,"4":-1,"5":-1,"6":-1,"7":2,"8":-1,"9":-1,"10":-1,"11":1,"12":-1,"13":-1,"14":-1,"15":-1,"16":-1,"17":-1,"18":false,"19":-1,"20":false,"21":-1,"22":false,"23":-1,"24":-1,"25":-1,"26":-1,"27":-1,"28":-1,"29":-1,"30":-1,"31":-1,"32":-1,"33":-1,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":1,"49":-1,"0":-1},"colour":{"custom":{"secondary":[176,176,176],"primary":[15,15,15]},"smoke":[255,255,255],"secondary":121,"neon":[255,0,255],"pearlescent":7,"primary":1,"wheel":0},"bulletproof":1,"neon":{"left":false,"right":false,"front":false,"back":false},"fumaca":false,"tyres":-1,"tyresvariation":false}');
/*!40000 ALTER TABLE `vrp_srv_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_users: ~0 rows (aproximadamente)
DELETE FROM `vrp_users`;
/*!40000 ALTER TABLE `vrp_users` DISABLE KEYS */;
INSERT INTO `vrp_users` (`id`, `last_login`, `ip`, `whitelisted`, `banned`) VALUES
	(1, '05.06.2019', '127.0.0.1', 1, 0);
/*!40000 ALTER TABLE `vrp_users` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_data: ~2 rows (aproximadamente)
DELETE FROM `vrp_user_data`;
/*!40000 ALTER TABLE `vrp_user_data` DISABLE KEYS */;
INSERT INTO `vrp_user_data` (`user_id`, `dkey`, `dvalue`) VALUES
	(1, 'currentCharacterMode', '{"fathersID":0,"chestModel":4,"beardModel":7,"blushModel":-1,"eyebrowsModel":0,"sundamageModel":-1,"makeupModel":-1,"cheekboneHeight":0,"shapeMix":0.3,"eyebrowsHeight":0,"chinWidth":0,"firstHairColor":28,"blushColor":0,"chinShape":0,"skinColor":6,"complexionModel":-1,"noseShift":0,"eyebrowsWidth":0,"noseLength":0,"noseWidth":0,"cheeksWidth":0,"noseTip":0,"cheekboneWidth":0,"frecklesModel":-1,"chinPosition":0,"eyesColor":0,"neckWidth":0,"noseBridge":0,"lips":0,"secondHairColor":13,"beardColor":28,"mothersID":21,"noseHeight":0,"jawWidth":0,"jawHeight":0,"blemishesModel":-1,"eyebrowsColor":0,"chinLength":0,"lipstickColor":0,"gender":0,"ageingModel":2,"chestColor":0,"lipstickModel":-1,"hairModel":18}'),
	(1, 'vRP:datatable', '{"groups":{"Trafico":true,"admin":true},"gaptitudes":[],"colete":0,"inventory":[],"position":{"z":5.8801565170288,"y":-3265.3278808594,"x":1175.0258789063},"health":400,"cloakroom_idle":{"2":[18,0,0],"1":[-1,0,2],"0":[0,0,0],"9":[0,0,2],"8":[15,0,2],"7":[-1,0,2],"6":[77,1,2],"5":[0,0,2],"4":[15,2,2],"3":[15,0,2],"14":[0,0,255],"18":[33554944,2,0],"16":[65538,2,1],"p6":[-1,0],"p4":[-1,0],"10":[-1,0,2],"p0":[28,1],"12":[0,0,0],"20":[33686018,2,5],"modelhash":1885233650,"p9":[-1,0],"19":[33686018,2,0],"15":[0,2,228],"17":[0,2,0],"p5":[-1,0],"p3":[-1,0],"p2":[-1,0],"p1":[5,0],"11":[160,0,2],"p10":[-1,0],"13":[0,2,0],"p7":[-1,0],"p8":[-1,0]},"customization":{"1":[-1,0,2],"2":[18,0,0],"3":[15,0,2],"4":[15,2,2],"5":[0,0,2],"6":[77,1,2],"7":[-1,0,2],"8":[15,0,2],"9":[0,0,2],"10":[-1,0,2],"11":[160,0,2],"12":[0,0,0],"13":[0,2,0],"14":[0,0,255],"15":[0,2,100],"16":[65538,2,255],"17":[0,2,255],"18":[33554944,2,255],"19":[33686018,2,255],"20":[33686018,2,255],"0":[0,0,0],"p7":[-1,0],"p8":[-1,0],"p6":[-1,0],"p5":[-1,0],"p4":[-1,0],"p3":[-1,0],"p10":[-1,0],"p1":[-1,0],"p2":[-1,0],"p0":[-1,0],"p9":[-1,0],"modelhash":1885233650},"weapons":[]}'),
	(1, 'vRP:spawnController', '2');
/*!40000 ALTER TABLE `vrp_user_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_homes
CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_homes: ~0 rows (aproximadamente)
DELETE FROM `vrp_user_homes`;
/*!40000 ALTER TABLE `vrp_user_homes` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_homes` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_identities
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_identities: ~0 rows (aproximadamente)
DELETE FROM `vrp_user_identities`;
/*!40000 ALTER TABLE `vrp_user_identities` DISABLE KEYS */;
INSERT INTO `vrp_user_identities` (`user_id`, `registration`, `phone`, `firstname`, `name`, `age`) VALUES
	(1, '85MJX871', '875-300', 'Xibata', 'Xico', 38);
/*!40000 ALTER TABLE `vrp_user_identities` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_ids: ~5 rows (aproximadamente)
DELETE FROM `vrp_user_ids`;
/*!40000 ALTER TABLE `vrp_user_ids` DISABLE KEYS */;
INSERT INTO `vrp_user_ids` (`identifier`, `user_id`) VALUES
	('discord:229376970964729856', 1),
	('license:5d97cf0aaadd4d6be9198902781aba1b00a4e41c', 1),
	('live:914801253975754', 1),
	('steam:11000011359e460', 1),
	('xbl:2535464965308181', 1);
/*!40000 ALTER TABLE `vrp_user_ids` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_moneys
CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_moneys: ~0 rows (aproximadamente)
DELETE FROM `vrp_user_moneys`;
/*!40000 ALTER TABLE `vrp_user_moneys` DISABLE KEYS */;
INSERT INTO `vrp_user_moneys` (`user_id`, `wallet`, `bank`) VALUES
	(1, 17355, 4000);
/*!40000 ALTER TABLE `vrp_user_moneys` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_vehicles
CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT '0',
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT '1000',
  `body` int(4) NOT NULL DEFAULT '1000',
  `fuel` int(3) NOT NULL DEFAULT '100',
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_vehicles: ~0 rows (aproximadamente)
DELETE FROM `vrp_user_vehicles`;
/*!40000 ALTER TABLE `vrp_user_vehicles` DISABLE KEYS */;
INSERT INTO `vrp_user_vehicles` (`user_id`, `vehicle`, `detido`, `time`, `engine`, `body`, `fuel`) VALUES
	(1, 'panto', 0, '0', 1000, 1000, 100);
/*!40000 ALTER TABLE `vrp_user_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
