/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.6-MariaDB : Database - dbhaipasar
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dbhaipasar` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dbhaipasar`;

/*Table structure for table `dbmaccount` */

DROP TABLE IF EXISTS `dbmaccount`;

CREATE TABLE `dbmaccount` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DisplayName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `ImgProfile` text DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `City` text DEFAULT NULL,
  `CodePos` varchar(10) DEFAULT NULL,
  `IsDelete` int(1) NOT NULL DEFAULT 0,
  `isAdmin` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `dbmaccount` */

insert  into `dbmaccount`(`ID`,`DisplayName`,`Email`,`Password`,`Phone`,`ImgProfile`,`Address`,`City`,`CodePos`,`IsDelete`,`isAdmin`) values 
(1,'admin','admin','admin',NULL,NULL,NULL,NULL,NULL,0,1),
(2,'ganda','gandatadyosurya@yahoo.com','ganda','082264576766',NULL,'Gang Kamboja No 6','Surabaya','',0,0);

/*Table structure for table `dbmcategory` */

DROP TABLE IF EXISTS `dbmcategory`;

CREATE TABLE `dbmcategory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NameCategory` varchar(100) DEFAULT NULL,
  `isDelete` int(1) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `dbmcategory` */

insert  into `dbmcategory`(`ID`,`NameCategory`,`isDelete`) values 
(2,'Buah - buahan',0),
(3,'Sayur - sayuran',0),
(4,'Atk',1),
(5,'Daging',1),
(6,'Ikan',0);

/*Table structure for table `dbmfilesmanager` */

DROP TABLE IF EXISTS `dbmfilesmanager`;

CREATE TABLE `dbmfilesmanager` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NameFile` varchar(100) DEFAULT NULL,
  `Path` text DEFAULT NULL,
  `TimeCreated` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

/*Data for the table `dbmfilesmanager` */

insert  into `dbmfilesmanager`(`ID`,`NameFile`,`Path`,`TimeCreated`) values 
(2,'Buah Naga','1911062-Buah NagaBuah NAga.jpg','2019-11-06 14:20:49'),
(3,'Buah NAGA','1911063-Buah NAGAScreenshot_13.png','2019-11-06 14:36:50'),
(4,'Apel Fuji','1911074-Apel Fujiapel fuji.jpeg','2019-11-07 11:17:37'),
(5,'Apel Malang','1911075-Apel Malangapel malang.jpg','2019-11-07 11:17:54'),
(6,'Apel washington','1911076-Apel washingtonApel Washington.jpg','2019-11-07 11:32:40'),
(7,'apel granny','1911077-apel grannyapple-granny.jpg','2019-11-07 11:32:57'),
(8,'pear pakam','1911078-pear pakampear pakam.jpg','2019-11-07 11:33:11'),
(9,'pear singo','1911079-pear singopear singo.jpg','2019-11-07 11:45:02'),
(10,'apel fuji rrc','19110710-apel fuji rrcfruit fuji rrc.jpg','2019-11-07 11:45:27'),
(11,'pear ya lie','19110711-pear ya liepear yalie.jpg','2019-11-07 11:45:50'),
(12,'jeruk sunkist','19110712-jeruk sunkistjeruk-sunkist.jpg','2019-11-07 11:46:10'),
(13,'pear xianglie','19110713-pear xiangliepear xiang lie.jpg','2019-11-07 11:46:34'),
(14,'jeruk baby pacitan','19110714-jeruk baby pacitanjeruk baby pacitan.png','2019-11-07 11:47:05'),
(15,'jeruk mandarin','19110715-jeruk mandarinjeruk mandarin.jpg','2019-11-07 11:47:31'),
(16,'alpukat','19110716-alpukatalpukat.webp','2019-11-07 11:48:02'),
(17,'salak pondoh','19110717-salak pondohsalak pondoh.jpg','2019-11-07 11:48:29'),
(18,'mangga gadung','19110718-mangga gadungmangga gadung.png','2019-11-07 11:48:45'),
(19,'lemon import','19110719-lemon importlemon import.jpg','2019-11-07 11:49:08'),
(20,'melon super','19110720-melon supermelon super.jpg','2019-11-07 11:49:28'),
(21,'pepaya california','19110721-pepaya californiapepaya california.jpg','2019-11-07 11:49:49'),
(22,'melon golden','19110722-melon goldenmelon golden.jpg','2019-11-07 11:50:08'),
(23,'semangka kuning','19110723-semangka kuningsemangka kuning.jpg','2019-11-07 11:50:26'),
(24,'Apel Red Star','19110724-Apel Red Starred star.jpg','2019-11-07 12:11:35'),
(25,'Daun Kemangi','19110725-Daun Kemangidaun kemangi.jpg','2019-11-07 12:18:27'),
(26,'daun pisang','19110726-daun pisangdaun pisang.jpg','2019-11-07 12:18:47'),
(27,'daun pepaya','19110727-daun pepayadaun pepaya.jpg','2019-11-07 12:19:17'),
(28,'daun gingseng','19110728-daun gingsengDaun-Ginseng-1.jpg','2019-11-07 12:19:40'),
(29,'Daun pandang','19110729-Daun pandangdaun pandan.jpg','2019-11-07 12:19:57'),
(30,'daun siomak','19110730-daun siomakdaun siomak.jpg','2019-11-07 12:20:14'),
(31,'selada','19110731-seladaselada.jpeg','2019-11-07 14:28:42'),
(32,'selada','19110732-seladaselada.jpeg','2019-11-07 14:28:44'),
(33,'selada keriting','19110733-selada keritingselada_keriting.jpg','2019-11-07 14:29:03'),
(34,'Buncis','19110734-Buncisbuncis.jpg','2019-11-07 14:29:27'),
(35,'brokoli','19110735-brokoliBrokoli.jpg','2019-11-07 14:29:53'),
(36,'tomat bandung','19110736-tomat bandungtomat bandung.webp','2019-11-07 14:30:25'),
(37,'Wortel brastagi','19110737-Wortel brastagiwortel brastagi.jpg','2019-11-07 14:33:38'),
(38,'jagung','19110738-jagungjagung.jpg','2019-11-07 14:34:09'),
(39,'timun','19110739-timuntimun besar.webp','2019-11-07 14:34:41'),
(40,'Wortel','19110740-Wortelwortel.jpeg','2019-11-07 14:35:30'),
(41,'Terong','19110741-Terongterong.jpg','2019-11-07 14:40:14'),
(42,'lobak','19110742-lobaklobak.jpg','2019-11-07 14:41:25'),
(43,'Zucchini','19110743-Zucchinizukhini.webp','2019-11-07 14:41:52'),
(44,'Timun Besar','19110744-Timun Besartimun.jpg','2019-11-07 14:42:50'),
(45,'Lidah Buaya','19110745-Lidah Buayalidah buaya.jpg','2019-11-07 15:04:42'),
(46,'','19110746-kluwek.jpg','2019-11-07 15:05:13'),
(47,'','19110747-jeruk nipis.jpg','2019-11-07 15:05:33'),
(48,'','19110748-kencur.jpeg','2019-11-07 15:05:51'),
(49,'','19110749-kunyit.jpg','2019-11-07 15:06:29'),
(50,'','19110750-jahe.webp','2019-11-07 15:06:48'),
(51,'','19110751-cabe.jpg','2019-11-07 15:07:06'),
(52,'','19110752-cabe merah.png','2019-11-07 15:07:23'),
(53,'','19110753-cabe rawit hijau.jpg','2019-11-07 15:08:14'),
(54,'','19110754-cabe keriting.webp','2019-11-07 15:08:35'),
(55,'','19110755-cabe rawit.jpg','2019-11-07 15:08:59'),
(56,'','19110756-bawang merah.jpg','2019-11-07 15:32:01'),
(57,'','19110757-bawang putih.jpg','2019-11-07 15:32:29'),
(58,'','19110758-bawang bombay.png','2019-11-07 15:32:45'),
(59,'','19110759-bawang putih kating.jpg','2019-11-07 15:33:02'),
(60,'','19110760-kentang.jpeg','2019-11-07 15:33:20'),
(61,'','19110761-kol putih.jpg','2019-11-07 15:33:45'),
(62,'','19110762-sawi putih.webp','2019-11-07 15:34:02'),
(63,'','19110763-lettuce.jpg','2019-11-07 15:34:21'),
(64,'','19110764-kembang kol.jpg','2019-11-07 15:34:41'),
(65,'','19110765-Brokoli.jpg','2019-11-07 15:34:57'),
(67,'Banner HP','19110767-Banner HP340x300.png','2019-11-07 16:01:37');

/*Table structure for table `dbmproduct` */

DROP TABLE IF EXISTS `dbmproduct`;

CREATE TABLE `dbmproduct` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SKU` varchar(50) DEFAULT NULL,
  `NameProduct` varchar(100) DEFAULT NULL,
  `IDCategory` bigint(20) DEFAULT NULL,
  `ImageUrl` text DEFAULT NULL,
  `Unit` varchar(10) NOT NULL DEFAULT 'unit',
  `Price` decimal(10,0) DEFAULT NULL,
  `Stock` decimal(10,0) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `IDShop` bigint(20) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `IsDelete` int(1) NOT NULL DEFAULT 0,
  `isShowStock` int(1) NOT NULL DEFAULT 0,
  `isWatch` bigint(20) NOT NULL DEFAULT 0,
  `isShow` int(1) NOT NULL DEFAULT 0,
  `isPromo` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

/*Data for the table `dbmproduct` */

insert  into `dbmproduct`(`ID`,`SKU`,`NameProduct`,`IDCategory`,`ImageUrl`,`Unit`,`Price`,`Stock`,`Description`,`IDShop`,`IDAccount`,`IsDelete`,`isShowStock`,`isWatch`,`isShow`,`isPromo`) values 
(1,'110110545','Wortel',3,'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1','kg',6000,94,'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.',NULL,NULL,0,0,3,0,0),
(2,'110110546','Bayam',3,'https://cdn0-production-images-kly.akamaized.net/k8yRzfr3g4tUnAPb-6dgkdb7LYo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/726405/original/spinach.jpg','ikat',3500,195,'Bayam (Amaranthus spp.) merupakan tumbuhan yang biasa ditanam untuk dikonsumsi daunnya sebagai sayuran hijau. ... Tumbuhan ini dikenal sebagai sayuran sumber zat besi yang penting bagi tubuh.',NULL,NULL,0,0,4,0,0),
(5,'110110553','Bawang Putih',3,'http://www.car.co.id/media/267826/28-des_499x334.jpg','siung',950,300,'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.',NULL,NULL,0,0,0,0,0),
(11,'110113545','Bawang Merah',NULL,'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1546143306/qb0mdrgfy4kpvh4gxfwo.jpg','pcs',1100,0,'Bentuk biji agak pipih. Biji bawang merah dapat digunakan sebagai bahan perbanyakan tanaman secara generatif. Bawang merah mengandung vitamin C, kalium, serat, dan asam folat. ... Bawang merah juga mengandung zat pengatur tumbuh alami berupa hormon auksin dan gibereli',NULL,NULL,1,0,4,0,0),
(20,'110110547','Kangkung',NULL,'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/08/kangkung.jpg?fit=1200%2C852&ssl=1','pcs',500,1000,'Batang kangkung bulat dan berlubang, berbuku-buku, banyak mengandung air (herbacious) dari buku-bukunya mudah sekali keluar akar. Memiliki percabangan yang banyak dan setelah tumbuh lama batangnya akan merayap (menjalar). ... Bentuk biji kangkung bersegi-segi atau tegak bulat.',NULL,NULL,0,0,0,0,0),
(21,'110110555','Bawang Putih',2,'http://www.car.co.id/media/267826/28-des_499x334.jpg','pcs',950,300,'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.',NULL,NULL,1,0,1,1,0),
(22,'110110555','Cabe',NULL,'https://cdn.shopify.com/s/files/1/0021/5030/1751/products/28337342_B_300x300.jpg?v=1562422590','pcs',3500,200,'Cabai atau yang biasa kita kenal disebut lombok adalah sejenis sayuran buah semusim yang termasuk dalam anggota genus Capsicum yang banyak diperlukan oleh masyarakat sebagai penyedap rasa masakan. Cabai (Capsicum annuum L.) merupakan komoditas sayuran yang banyak digemari oleh masyarakat',NULL,NULL,0,0,1,0,0),
(26,'110113545','Bawang Merah',2,'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1546143306/qb0mdrgfy4kpvh4gxfwo.jpg','pcs',1100,0,'Bentuk biji agak pipih. Biji bawang merah dapat digunakan sebagai bahan perbanyakan tanaman secara generatif. Bawang merah mengandung vitamin C, kalium, serat, dan asam folat. ... Bawang merah juga mengandung zat pengatur tumbuh alami berupa hormon auksin dan gibereli',NULL,NULL,0,1,3,0,0),
(27,'110110895','Bawang Putih',3,'http://www.car.co.id/media/267826/28-des_499x334.jpg','pcs',1000,50,'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.',NULL,NULL,1,0,1,0,0),
(29,'234234','Tomat 1',2,'https://storage.googleapis.com/manfaat/2018/03/232b25e3-manfaat-sayur-tomat.png','pcs',5000,650,'Tomat adalah buah yang berbentuk bulat dan memiliki warna yang merah dan ada yang hijau. ... Tomat juga ada yang berukuran sangat kecil yang biasa disebut dengan tomat cheri. Biasanya tomat jenis tersebut digunakan untuk membuat salad. Dalam buah tomat terdapat banyak biji di dalamny',NULL,NULL,0,1,5,1,0),
(34,'12','Buah Naga',2,'','/100 gram',995,100,'',NULL,NULL,1,0,0,1,0),
(35,'12222','Buah Naga',2,'http://haipasar.com/file/1911062-Buah%20NagaBuah%20NAga.jpg','100 gram',995,100,'',NULL,NULL,0,0,0,0,0),
(36,'','Apel Fuji',2,'http://haipasar.com/file/1911074-Apel%20Fujiapel%20fuji.jpeg','100 gram',48880,1,'',NULL,NULL,0,0,0,0,0),
(37,'','Apel Malang',2,'http://haipasar.com/file/1911075-Apel%20Malangapel%20malang.jpg','100 gram ',4795,1,'',NULL,NULL,0,0,0,0,0),
(38,'','Apel Washington',2,'/file/1911076-Apel washingtonApel Washington.jpg','100 gram',3995,1,'',NULL,NULL,0,0,0,0,0),
(39,'','Apel Granny',2,'/file/1911077-apel grannyapple-granny.jpg','100 gram',49995,1,'',NULL,NULL,0,0,0,0,0),
(40,'','Pear Pakam',2,'/file/1911078-pear pakampear pakam.jpg','100 gram',2990,1,'',NULL,NULL,0,0,0,0,0),
(41,'','Pear Singo',2,'/file/1911079-pear singopear singo.jpg','100 gram',2995,1,'',NULL,NULL,0,0,0,0,0),
(42,'','Apel Fuji RRC',2,'/file/19110710-apel fuji rrcfruit fuji rrc.jpg','100 gram',3895,1,'',NULL,NULL,0,0,0,0,0),
(43,'','Pear Yalie',2,'/file/19110711-pear ya liepear yalie.jpg','100 gram',970,1,'',NULL,NULL,0,0,0,0,0),
(44,'','Jeruk Sunkist',2,'/file/19110712-jeruk sunkistjeruk-sunkist.jpg','100 gram',3295,1,'',NULL,NULL,0,0,0,0,0),
(45,'','Pear Xiang Lie',2,'/file/19110713-pear xiangliepear xiang lie.jpg','100 gram',4495,1,'',NULL,NULL,0,0,0,0,0),
(46,'','Jeruk Baby Pacitan',2,'/file/19110714-jeruk baby pacitanjeruk baby pacitan.png','100 gram',1495,1,'',NULL,NULL,0,0,0,0,0),
(47,'','Jeruk Mandarin',2,'/file/19110715-jeruk mandarinjeruk mandarin.jpg','100 gram',4495,1,'',NULL,NULL,0,0,0,0,0),
(48,'','Alpukat',2,'/file/19110716-alpukatalpukat.webp','100 gram',3895,1,'',NULL,NULL,0,0,0,0,0),
(49,'','Salak Pondoh',2,'/file/19110717-salak pondohsalak pondoh.jpg','100 gram',1875,1,'',NULL,NULL,0,0,0,0,0),
(50,'','Melon Super',2,'/file/19110720-melon supermelon super.jpg','100 gram',1295,1,'',NULL,NULL,0,0,0,0,0),
(51,'','Pepaya California',2,'/file/19110721-pepaya californiapepaya california.jpg','100 gram',895,1,'',NULL,NULL,0,0,0,0,0),
(52,'','Melon Golden',2,'/file/19110722-melon goldenmelon golden.jpg','100 gram',1695,1,'',NULL,NULL,0,0,0,0,0),
(53,'','Semangka Kuning',2,'/file/19110723-semangka kuningsemangka kuning.jpg','100 gram',1195,1,'',NULL,NULL,0,0,0,0,0),
(54,'','Apel Red Star',2,'/file/19110724-Apel Red Starred star.jpg','100 gram',2895,1,'',NULL,NULL,0,0,0,0,0),
(55,'','Daun Kemangi',3,'/file/19110725-Daun Kemangidaun kemangi.jpg','100 gram ',3950,1,'',NULL,NULL,0,0,0,0,0),
(56,'','Daun Pisang',3,'/file/19110726-daun pisangdaun pisang.jpg','100 gram',4790,1,'',NULL,NULL,0,0,0,0,0),
(57,'','Daun Pepaya',3,'/file/19110727-daun pepayadaun pepaya.jpg','100 gram',2950,1,'',NULL,NULL,0,0,0,0,0),
(58,'','Daun Gingseng',3,'/file/19110728-daun gingsengDaun-Ginseng-1.jpg','100 gram',1950,1,'',NULL,NULL,0,0,0,0,0),
(59,'','Daun Pandan',2,'/file/19110729-Daun pandangdaun pandan.jpg','100 gram',1950,1,'',NULL,NULL,0,0,0,0,0),
(60,'','Daun Siomak',3,'/file/19110730-daun siomakdaun siomak.jpg','100 gram',4950,1,'',NULL,NULL,0,0,0,0,0),
(61,'','Selada',3,'/file/19110731-seladaselada.jpeg','100 gram',11950,1,'',NULL,NULL,0,0,0,0,0),
(62,'','Selada Keriting',3,'/file/19110733-selada keritingselada_keriting.jpg','100 gram',10990,1,'',NULL,NULL,0,0,0,0,0),
(63,'','Buncis',3,'/file/19110734-Buncisbuncis.jpg','250 gram',13990,1,'',NULL,NULL,0,0,0,0,0),
(64,'','Brokoli',3,'/file/19110735-brokoliBrokoli.jpg','ons',4995,1,'',NULL,NULL,0,0,0,0,0),
(65,'','Tomat Bandung',3,'/file/19110736-tomat bandungtomat bandung.webp','100 gram',1095,1,'',NULL,NULL,0,0,0,0,0),
(66,'','Wortel Brastagi',3,'/file/19110737-Wortel brastagiwortel brastagi.jpg','100 gram',1340,1,'',NULL,NULL,0,0,0,0,0),
(67,'','Jagung',3,'/file/19110738-jagungjagung.jpg','100 gram',995,1,'',NULL,NULL,0,0,0,0,0),
(68,'','Timun',2,'/file/19110739-timuntimun besar.webp','100 gram',2295,1,'',NULL,NULL,0,0,0,0,0),
(69,'','Terong',3,'/file/19110741-Terongterong.jpg','100 gram',1595,1,'',NULL,NULL,0,0,0,0,0),
(70,'','Lobak',3,'/file/19110742-lobaklobak.jpg','100 gram',2095,2,'',NULL,NULL,0,0,0,0,0),
(71,'','Zucchini',3,'/file/19110743-Zucchinizukhini.webp','100 gram',4295,1,'',NULL,NULL,0,0,0,0,0),
(72,'','Timun Besar',2,'/file/19110744-Timun Besartimun.jpg','100 gram',1595,1,'',NULL,NULL,0,0,0,0,0),
(73,'','Lidah Buaya',3,'/file/19110745-Lidah Buayalidah buaya.jpg','100 gram',1845,1,'',NULL,NULL,0,0,0,0,0),
(74,'','Kluwek',3,'/file/19110746-kluwek.jpg','100 gram',5990,1,'',NULL,NULL,0,0,0,0,0),
(75,'','Jeruk Nipis',3,'/file/19110747-jeruk nipis.jpg','100 gram',4295,1,'',NULL,NULL,0,0,0,0,0),
(76,'','Kencur',3,'/file/19110748-kencur.jpeg','100 gram',11095,1,'',NULL,NULL,0,0,0,0,0),
(77,'','Jahe',3,'/file/19110750-jahe.webp','100 gram',8495,1,'',NULL,NULL,0,0,0,0,0),
(78,'','Kunyit',3,'/file/19110749-kunyit.jpg','100 gram',1995,1,'',NULL,NULL,0,0,0,0,0),
(79,'','Cabai',3,'/file/19110751-cabe.jpg','100 gram',11950,1,'',NULL,NULL,0,0,0,0,0),
(80,'','Cabai Merah',3,'/file/19110752-cabe merah.png','100 gram',12950,2,'',NULL,NULL,0,0,0,0,0),
(81,'','Cabai Rawit Hijau',3,'/file/19110753-cabe rawit hijau.jpg','100 gram',7995,1,'',NULL,NULL,0,0,0,0,0),
(82,'','Cabai Keriting',3,'/file/19110754-cabe keriting.webp','100 gram',9995,1,'',NULL,NULL,0,0,0,0,0),
(83,'','Cabai Rawit',3,'/file/19110755-cabe rawit.jpg','100 gram',14950,1,'',NULL,NULL,0,0,0,0,0),
(84,'','Bawang Putiih',3,'/file/19110757-bawang putih.jpg','100 gram',3500,1,'',NULL,NULL,0,0,0,0,0),
(85,'','Bawang Bombay',3,'/file/19110758-bawang bombay.png','500 gram',2995,1,'',NULL,NULL,0,0,0,0,0),
(86,'','Bawang Putih Kating',3,'/file/19110759-bawang putih kating.jpg','100 gram',4000,1,'',NULL,NULL,0,0,0,0,0),
(87,'','Kentang',3,'/file/19110760-kentang.jpeg','100 gram',2295,1,'',NULL,NULL,0,0,0,0,0),
(88,'','Sawi Putih',3,'/file/19110762-sawi putih.webp','100 gram',1895,1,'',NULL,NULL,0,0,0,0,0),
(89,'','Lettuce',3,'/file/19110763-lettuce.jpg','100 gram',3995,1,'',NULL,NULL,0,0,0,0,0),
(90,'','Kembang Kol',3,'/file/19110764-kembang kol.jpg','100 gram',3495,1,'',NULL,NULL,0,0,0,0,0);

/*Table structure for table `dbtbanner` */

DROP TABLE IF EXISTS `dbtbanner`;

CREATE TABLE `dbtbanner` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Caption` varchar(100) NOT NULL,
  `Content` text NOT NULL,
  `ImageUrl` text DEFAULT NULL,
  `TimeShow` int(5) DEFAULT 1000,
  `isShow` int(1) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `dbtbanner` */

insert  into `dbtbanner`(`ID`,`Caption`,`Content`,`ImageUrl`,`TimeShow`,`isShow`) values 
(1,'Banner 1','Promo  1','http://haipasar.com/file/19110767-Banner%20HP340x300.png',1000,1),
(2,'Banner 2','','https://cf.shopee.co.id/file/8143343a788eb4a8c82b3018a2badfef',10000,1),
(3,'Banner 3','','https://cms.dailysocial.id/wp-content/uploads/2019/06/63300752ea4d2e97bdcb073375e748b0_WhatsApp-Image-2019-06-26-at-16.15.15.jpeg',1000,1);

/*Table structure for table `dbttransdetail` */

DROP TABLE IF EXISTS `dbttransdetail`;

CREATE TABLE `dbttransdetail` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TransID` bigint(20) DEFAULT NULL,
  `DocNumber` varchar(20) DEFAULT NULL,
  `IDProduct` bigint(20) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL,
  `Price` decimal(10,0) DEFAULT NULL,
  `Total` decimal(10,0) DEFAULT NULL,
  `Status` char(15) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `dbttransdetail` */

insert  into `dbttransdetail`(`ID`,`TransID`,`DocNumber`,`IDProduct`,`Qty`,`Price`,`Total`,`Status`) values 
(1,1,'0511191',28,5,500,2500,'none'),
(2,1,'0511191',27,1,1000,1000,'none'),
(3,2,'0511192',28,3,500,1500,'none');

/*Table structure for table `dbttransdoc` */

DROP TABLE IF EXISTS `dbttransdoc`;

CREATE TABLE `dbttransdoc` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DocNumber` varchar(20) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `TimeCreated` datetime DEFAULT NULL,
  `TimeUpdated` datetime DEFAULT NULL,
  `GrandTotal` decimal(10,0) NOT NULL DEFAULT 0,
  `Status` char(15) NOT NULL DEFAULT 'none' COMMENT 'open,processed,awaiting,complete,canceled',
  `StatusPayment` char(15) NOT NULL DEFAULT 'none' COMMENT 'notyet,waiting,success,reject',
  `PaymentProof` text NOT NULL,
  `ShippingPaymentPerson` varchar(100) NOT NULL,
  `ShippingPaymentNumber` varchar(100) NOT NULL,
  `ShippingPaymentBank` varchar(100) NOT NULL,
  `ShippingAmount` decimal(10,0) DEFAULT NULL,
  `ShippingRecipient` varchar(200) NOT NULL,
  `ShippingEmail` varchar(100) NOT NULL,
  `ShippingPhone` varchar(20) NOT NULL,
  `ShippingAddress` text NOT NULL,
  `ShippingCity` text NOT NULL,
  `ShippingCodePos` varchar(10) NOT NULL,
  `Notes` text DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `dbttransdoc` */

insert  into `dbttransdoc`(`ID`,`DocNumber`,`IDAccount`,`TimeCreated`,`TimeUpdated`,`GrandTotal`,`Status`,`StatusPayment`,`PaymentProof`,`ShippingPaymentPerson`,`ShippingPaymentNumber`,`ShippingPaymentBank`,`ShippingAmount`,`ShippingRecipient`,`ShippingEmail`,`ShippingPhone`,`ShippingAddress`,`ShippingCity`,`ShippingCodePos`,`Notes`) values 
(1,'0511191',2,'2019-11-05 12:40:36','2019-11-05 12:40:36',3500,'open','waiting','Screenshot from 2019-11-05 06-24-05.png','GANDA TADIO SURYA','226481872','Bank BCA',35000,'ganda','gandatadyosurya@yahoo.com','082264576766','Gang Kamboja No 6','Surabaya','60222',''),
(2,'0511192',2,'2019-11-05 15:05:08','2019-11-05 15:05:08',1500,'open','waiting','IMG_20191030_210010_109.jpg','ganda','62726','Bank BCA',1600,'ganda','gandatadyosurya@yahoo.com','082264576766','Gang Kamboja No 6','Surabaya','60222','');

/*Table structure for table `dbttranshistory` */

DROP TABLE IF EXISTS `dbttranshistory`;

CREATE TABLE `dbttranshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TransID` bigint(20) DEFAULT NULL,
  `DocNumber` varchar(20) DEFAULT NULL,
  `Status` char(15) NOT NULL,
  `Notes` text DEFAULT NULL,
  `TimeCreated` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `dbttranshistory` */

insert  into `dbttranshistory`(`ID`,`TransID`,`DocNumber`,`Status`,`Notes`,`TimeCreated`) values 
(1,1,'0511191','new','Transaksi dibuat','2019-11-05 12:40:36'),
(2,0,'0511191','new','Upload pembayaran','2019-11-05 12:42:07'),
(3,2,'0511192','new','Transaksi dibuat','2019-11-05 15:05:08'),
(4,0,'0511192','new','Upload pembayaran','2019-11-05 15:06:03');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
