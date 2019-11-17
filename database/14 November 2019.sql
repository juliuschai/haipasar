-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2019 at 01:10 PM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbhaipasar`
--
CREATE DATABASE IF NOT EXISTS `dbhaipasar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dbhaipasar`;

-- --------------------------------------------------------

--
-- Table structure for table `dbmaccount`
--

DROP TABLE IF EXISTS `dbmaccount`;
CREATE TABLE `dbmaccount` (
  `ID` bigint(20) NOT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `ImgProfile` text,
  `Address` text,
  `City` text,
  `CodePos` varchar(10) DEFAULT NULL,
  `IsDelete` int(1) NOT NULL DEFAULT '0',
  `isAdmin` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbmaccount`
--

INSERT INTO `dbmaccount` (`ID`, `DisplayName`, `Email`, `Password`, `Phone`, `ImgProfile`, `Address`, `City`, `CodePos`, `IsDelete`, `isAdmin`) VALUES
(17, 'admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, 0, 1),
(19, 'Ganda Tadio Surya', 'gandatadyosurya@yahoo.com', 'ganda', '082264576766', NULL, 'Gang Kamboja No 6', 'Surabaya', '60222', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dbmcategory`
--

DROP TABLE IF EXISTS `dbmcategory`;
CREATE TABLE `dbmcategory` (
  `ID` bigint(20) NOT NULL,
  `NameCategory` varchar(100) DEFAULT NULL,
  `ImageUrl` text,
  `isDelete` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbmcategory`
--

INSERT INTO `dbmcategory` (`ID`, `NameCategory`, `ImageUrl`, `isDelete`) VALUES
(2, 'Buah - buahan', '', 0),
(3, 'Sayur - sayuran', '', 0),
(4, 'Atk', '', 1),
(5, 'Daging', '', 1),
(6, 'Bibit', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dbmfilesmanager`
--

DROP TABLE IF EXISTS `dbmfilesmanager`;
CREATE TABLE `dbmfilesmanager` (
  `ID` bigint(20) NOT NULL,
  `NameFile` varchar(100) DEFAULT NULL,
  `Path` text,
  `TimeCreated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbmfilesmanager`
--

INSERT INTO `dbmfilesmanager` (`ID`, `NameFile`, `Path`, `TimeCreated`) VALUES
(1, 'ketan', '1910261-ketan20180907_102338.jpg', '2019-10-26 17:41:35');

-- --------------------------------------------------------

--
-- Table structure for table `dbmproduct`
--

DROP TABLE IF EXISTS `dbmproduct`;
CREATE TABLE `dbmproduct` (
  `ID` bigint(20) NOT NULL,
  `SKU` varchar(50) DEFAULT NULL,
  `NameProduct` varchar(100) DEFAULT NULL,
  `IDCategory` bigint(20) DEFAULT NULL,
  `ImageUrl` text,
  `Unit` varchar(5) NOT NULL DEFAULT 'unit',
  `Price` decimal(10,0) DEFAULT NULL,
  `Stock` decimal(10,0) DEFAULT NULL,
  `Description` text,
  `IDShop` bigint(20) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `IsDelete` int(1) NOT NULL DEFAULT '0',
  `isShowStock` int(1) NOT NULL DEFAULT '0',
  `isWatch` bigint(20) NOT NULL DEFAULT '0',
  `isShow` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbmproduct`
--

INSERT INTO `dbmproduct` (`ID`, `SKU`, `NameProduct`, `IDCategory`, `ImageUrl`, `Unit`, `Price`, `Stock`, `Description`, `IDShop`, `IDAccount`, `IsDelete`, `isShowStock`, `isWatch`, `isShow`) VALUES
(1, '110110545', 'Wortel', 3, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'kg', '6000', '94', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 0, 0, 0, 0),
(2, '110110546', 'Bayam', 3, 'https://cdn0-production-images-kly.akamaized.net/k8yRzfr3g4tUnAPb-6dgkdb7LYo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/726405/original/spinach.jpg', 'ikat', '3500', '195', 'Bayam (Amaranthus spp.) merupakan tumbuhan yang biasa ditanam untuk dikonsumsi daunnya sebagai sayuran hijau. ... Tumbuhan ini dikenal sebagai sayuran sumber zat besi yang penting bagi tubuh.', NULL, NULL, 0, 0, 3, 0),
(3, '110110547', 'Kangkung', 6, 'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/08/kangkung.jpg?fit=1200%2C852&ssl=1', 'pcs', '500', '1000', 'Batang kangkung bulat dan berlubang, berbuku-buku, banyak mengandung air (herbacious) dari buku-bukunya mudah sekali keluar akar. Memiliki percabangan yang banyak dan setelah tumbuh lama batangnya akan merayap (menjalar). ... Bentuk biji kangkung bersegi-segi atau tegak bulat.', NULL, NULL, 0, 0, 0, 0),
(5, '110110553', 'Bawang Putih', 3, 'http://www.car.co.id/media/267826/28-des_499x334.jpg', 'siung', '950', '300', 'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.', NULL, NULL, 0, 0, 0, 0),
(6, '110110555', 'Cabe', 3, 'https://cdn.shopify.com/s/files/1/0021/5030/1751/products/28337342_B_300x300.jpg?v=1562422590', 'pcs', '3500', '200', 'Cabai atau yang biasa kita kenal disebut lombok adalah sejenis sayuran buah semusim yang termasuk dalam anggota genus Capsicum yang banyak diperlukan oleh masyarakat sebagai penyedap rasa masakan. Cabai (Capsicum annuum L.) merupakan komoditas sayuran yang banyak digemari oleh masyarakat', NULL, NULL, 0, 0, 0, 0),
(8, '110110549', 'Wortel', 3, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'pcs', '6000', '0', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 0, 1, 0, 0),
(9, '110210545', 'Bayam', 2, 'https://cdn0-production-images-kly.akamaized.net/k8yRzfr3g4tUnAPb-6dgkdb7LYo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/726405/original/spinach.jpg', 'pcs', '1500', '50', 'Bayam (Amaranthus spp.) merupakan tumbuhan yang biasa ditanam untuk dikonsumsi daunnya sebagai sayuran hijau. ... Tumbuhan ini dikenal sebagai sayuran sumber zat besi yang penting bagi tubuh.', NULL, NULL, 0, 1, 0, 0),
(10, '110110599', 'Kangkung', 2, 'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/08/kangkung.jpg?fit=1200%2C852&ssl=1', 'pcs', '500', '50', 'Batang kangkung bulat dan berlubang, berbuku-buku, banyak mengandung air (herbacious) dari buku-bukunya mudah sekali keluar akar. Memiliki percabangan yang banyak dan setelah tumbuh lama batangnya akan merayap (menjalar). ... Bentuk biji kangkung bersegi-segi atau tegak bulat.', NULL, NULL, 0, 0, 0, 0),
(11, '110113545', 'Bawang Merah', NULL, 'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1546143306/qb0mdrgfy4kpvh4gxfwo.jpg', 'pcs', '1100', '0', 'Bentuk biji agak pipih. Biji bawang merah dapat digunakan sebagai bahan perbanyakan tanaman secara generatif. Bawang merah mengandung vitamin C, kalium, serat, dan asam folat. ... Bawang merah juga mengandung zat pengatur tumbuh alami berupa hormon auksin dan gibereli', NULL, NULL, 0, 0, 4, 0),
(12, '110110895', 'Bawang Putih', NULL, 'http://www.car.co.id/media/267826/28-des_499x334.jpg', 'pcs', '1000', '50', 'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.', NULL, NULL, 0, 0, 0, 0),
(15, '110110545', 'Wortel', 3, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'pcs', '500', '500', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 0, 1, 0, 0),
(17, '234234', 'Tomat 1', 2, 'https://storage.googleapis.com/manfaat/2018/03/232b25e3-manfaat-sayur-tomat.png', 'pcs', '5000', '650', 'Tomat adalah buah yang berbentuk bulat dan memiliki warna yang merah dan ada yang hijau. ... Tomat juga ada yang berukuran sangat kecil yang biasa disebut dengan tomat cheri. Biasanya tomat jenis tersebut digunakan untuk membuat salad. Dalam buah tomat terdapat banyak biji di dalamny', NULL, NULL, 0, 0, 0, 0),
(18, '110110545', 'Wortel', 2, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'pcs', '6000', '100', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 0, 1, 0, 0),
(19, '110110546', 'Bayam', NULL, 'https://cdn0-production-images-kly.akamaized.net/k8yRzfr3g4tUnAPb-6dgkdb7LYo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/726405/original/spinach.jpg', 'pcs', '1500', '200', 'Bayam (Amaranthus spp.) merupakan tumbuhan yang biasa ditanam untuk dikonsumsi daunnya sebagai sayuran hijau. ... Tumbuhan ini dikenal sebagai sayuran sumber zat besi yang penting bagi tubuh.', NULL, NULL, 0, 0, 0, 0),
(20, '110110547', 'Kangkung', NULL, 'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/08/kangkung.jpg?fit=1200%2C852&ssl=1', 'pcs', '500', '1000', 'Batang kangkung bulat dan berlubang, berbuku-buku, banyak mengandung air (herbacious) dari buku-bukunya mudah sekali keluar akar. Memiliki percabangan yang banyak dan setelah tumbuh lama batangnya akan merayap (menjalar). ... Bentuk biji kangkung bersegi-segi atau tegak bulat.', NULL, NULL, 0, 0, 0, 0),
(21, '110110555', 'Bawang Putih', 2, 'http://www.car.co.id/media/267826/28-des_499x334.jpg', 'pcs', '950', '300', 'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.', NULL, NULL, 0, 0, 0, 1),
(22, '110110555', 'Cabe', NULL, 'https://cdn.shopify.com/s/files/1/0021/5030/1751/products/28337342_B_300x300.jpg?v=1562422590', 'pcs', '3500', '200', 'Cabai atau yang biasa kita kenal disebut lombok adalah sejenis sayuran buah semusim yang termasuk dalam anggota genus Capsicum yang banyak diperlukan oleh masyarakat sebagai penyedap rasa masakan. Cabai (Capsicum annuum L.) merupakan komoditas sayuran yang banyak digemari oleh masyarakat', NULL, NULL, 0, 0, 0, 0),
(23, '110110549', 'Wortel delete', 3, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'pcs', '6000', '0', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 1, 0, 0, 0),
(24, '110210545', 'Bayam', NULL, 'https://cdn0-production-images-kly.akamaized.net/k8yRzfr3g4tUnAPb-6dgkdb7LYo=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/726405/original/spinach.jpg', 'pcs', '1500', '50', 'Bayam (Amaranthus spp.) merupakan tumbuhan yang biasa ditanam untuk dikonsumsi daunnya sebagai sayuran hijau. ... Tumbuhan ini dikenal sebagai sayuran sumber zat besi yang penting bagi tubuh.', NULL, NULL, 0, 0, 0, 0),
(25, '110110599', 'Kangkung', NULL, 'https://i2.wp.com/resepkoki.id/wp-content/uploads/2018/08/kangkung.jpg?fit=1200%2C852&ssl=1', 'pcs', '500', '50', 'Batang kangkung bulat dan berlubang, berbuku-buku, banyak mengandung air (herbacious) dari buku-bukunya mudah sekali keluar akar. Memiliki percabangan yang banyak dan setelah tumbuh lama batangnya akan merayap (menjalar). ... Bentuk biji kangkung bersegi-segi atau tegak bulat.', NULL, NULL, 0, 0, 0, 0),
(26, '110113545', 'Bawang Merah', 2, 'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1546143306/qb0mdrgfy4kpvh4gxfwo.jpg', 'pcs', '1100', '0', 'Bentuk biji agak pipih. Biji bawang merah dapat digunakan sebagai bahan perbanyakan tanaman secara generatif. Bawang merah mengandung vitamin C, kalium, serat, dan asam folat. ... Bawang merah juga mengandung zat pengatur tumbuh alami berupa hormon auksin dan gibereli', NULL, NULL, 0, 1, 0, 0),
(27, '110110895', 'Bawang Putih', 3, 'http://www.car.co.id/media/267826/28-des_499x334.jpg', 'pcs', '1000', '50', 'Bawang putih (Allium sativum; bahasa Inggris: garlic) adalah nama tanaman dari genus Allium sekaligus nama dari umbi yang dihasilkan. ... Bawang mentah penuh dengan senyawa-senyawa sulfur, termasuk zat kimia yang disebut alliin yang membuat bawang putih mentah terasa getir atau angur.', NULL, NULL, 0, 0, 0, 0),
(28, '110110545', 'Wortel', 2, 'https://i1.wp.com/resepkoki.id/wp-content/uploads/2017/10/wortel.jpg?fit=2048%2C1488&ssl=1', 'pcs', '500', '500', 'Klasifikasi Tanaman Wortel. Wortel merupakan tanaman sayuran termasuk ke dalam jenis tanaman semak, dan tumbuh baik pada musim kemarau maupun musim hujan. Tanaman wortel mempunyai struktur batang yang pendek, serta akar yang berakar tunggang dapat berubah bentuk menjadi bulat dan disebut dengan umbi.', NULL, NULL, 0, 1, 0, 0),
(29, '234234', 'Tomat 1', 2, 'https://storage.googleapis.com/manfaat/2018/03/232b25e3-manfaat-sayur-tomat.png', 'pcs', '5000', '650', 'Tomat adalah buah yang berbentuk bulat dan memiliki warna yang merah dan ada yang hijau. ... Tomat juga ada yang berukuran sangat kecil yang biasa disebut dengan tomat cheri. Biasanya tomat jenis tersebut digunakan untuk membuat salad. Dalam buah tomat terdapat banyak biji di dalamny', NULL, NULL, 0, 1, 3, 1),
(30, '234234', 'sdfkl', 2, 'jlk', 'jkl', '0', '0', 'jlk', NULL, NULL, 1, 0, 0, 0),
(31, '0546456', 'Pisang Pisang', 2, 'https://bogor.net/wp-content/uploads/2018sdfsdf/03/Manfaat-Buah-Pisang-Bagi-Kesehatan.png', 'pcs', '22000', '100', '', NULL, NULL, 0, 1, 2, 0),
(32, '239482349', 'TEst', 2, 'Test', 'Test', '1231232', '24234', '', NULL, NULL, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dbmshop`
--

DROP TABLE IF EXISTS `dbmshop`;
CREATE TABLE `dbmshop` (
  `ID` bigint(20) NOT NULL,
  `NameShop` varchar(100) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `PosLat` varchar(100) DEFAULT NULL,
  `PosLon` varchar(100) DEFAULT NULL,
  `Address` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbmshop`
--

INSERT INTO `dbmshop` (`ID`, `NameShop`, `IDAccount`, `PosLat`, `PosLon`, `Address`) VALUES
(1, 'Toko Bu Marjo', 1, '-7.330923', '112.673893', NULL),
(2, 'Maju Mapan', 1, '-7.330923', '112.673893', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dbssystem`
--

DROP TABLE IF EXISTS `dbssystem`;
CREATE TABLE `dbssystem` (
  `ID` bigint(20) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbssystem`
--

INSERT INTO `dbssystem` (`ID`, `Username`, `Password`) VALUES
(1, 'root', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `dbtbanner`
--

DROP TABLE IF EXISTS `dbtbanner`;
CREATE TABLE `dbtbanner` (
  `ID` bigint(20) NOT NULL,
  `Caption` varchar(100) NOT NULL,
  `Content` text NOT NULL,
  `ImageUrl` text,
  `TimeShow` int(5) DEFAULT '1000',
  `isShow` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbtbanner`
--

INSERT INTO `dbtbanner` (`ID`, `Caption`, `Content`, `ImageUrl`, `TimeShow`, `isShow`) VALUES
(1, 'Banner 1', 'Promo  1', '/haipasar.jpg', 1000, 1),
(2, 'Banner 2', '', 'https://cf.shopee.co.id/file/8143343a788eb4a8c82b3018a2badfef', 10000, 1),
(3, 'Banner 3', '', 'https://cms.dailysocial.id/wp-content/uploads/2019/06/63300752ea4d2e97bdcb073375e748b0_WhatsApp-Image-2019-06-26-at-16.15.15.jpeg', 1000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `dbtcart`
--

DROP TABLE IF EXISTS `dbtcart`;
CREATE TABLE `dbtcart` (
  `ID` bigint(20) NOT NULL,
  `IDProduct` bigint(20) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `NameProduct` varchar(100) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL,
  `Price` decimal(10,0) DEFAULT NULL,
  `isDelete` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbtcart`
--

INSERT INTO `dbtcart` (`ID`, `IDProduct`, `IDAccount`, `NameProduct`, `Qty`, `Price`, `isDelete`) VALUES
(1, 2, 1, 'Bayam', 1, '1500', 1),
(2, 12, 1, 'Bawang Putih', 1, '1000', 1),
(3, 2, 1, 'Bayam', 1, '1500', 1),
(4, 1, 1, 'Wortel', 1, '6000', 1),
(5, 2, 1, 'Bayam', 4, '1500', 1),
(6, 3, 1, 'Kangkung', 5, '500', 1),
(7, 15, 1, 'Wortel', 1, '500', 1),
(8, 2, 1, 'Bayam', 1, '1500', 1),
(9, 6, 1, 'Cabe', 1, '3500', 1),
(10, 5, 1, 'Bawang Putih', 5, '950', 1),
(11, 3, 1, 'Kangkung', 1, '500', 1),
(12, 3, 1, 'Kangkung', 1, '500', 1),
(13, 5, 1, 'Bawang Putih', 1, '950', 1),
(14, 5, 1, 'Bawang Putih', 1, '950', 1),
(15, 17, 1, 'Tomat 1', 3, '5000', 1),
(16, 5, 1, 'Bawang Putih', 1, '950', 1),
(17, 5, 1, 'Bawang Putih', 1, '950', 1),
(18, 8, 1, 'Wortel', 1, '6000', 1),
(19, 8, 1, 'Wortel', 1, '6000', 1),
(20, 3, 1, 'Kangkung', 1, '500', 1),
(21, 2, 1, 'Bayam', 1, '1500', 1),
(22, 3, 3, 'Kangkung', 9, '500', 1),
(23, 10, 1, 'Kangkung', 1, '500', 1),
(24, 5, 1, 'Bawang Putih', 1, '950', 1),
(25, 5, 1, 'Bawang Putih', 5, '950', 1),
(26, 11, 1, 'Bawang Merah', 1, '1100', 1),
(27, 5, 1, 'Bawang Putih', 1, '950', 1);

-- --------------------------------------------------------

--
-- Table structure for table `dbtmessage`
--

DROP TABLE IF EXISTS `dbtmessage`;
CREATE TABLE `dbtmessage` (
  `ID` bigint(20) NOT NULL,
  `IDSender` bigint(20) DEFAULT NULL,
  `IDReceipt` bigint(20) DEFAULT NULL,
  `Message` text,
  `TimeCreated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbtmessage`
--

INSERT INTO `dbtmessage` (`ID`, `IDSender`, `IDReceipt`, `Message`, `TimeCreated`) VALUES
(1, 1, 0, 'Hallo Admin', '2019-09-24 19:38:35'),
(2, 0, 1, 'Iya ada apa', '2019-09-24 19:39:59'),
(3, 0, 1, 'Ada yang bisa saya bantu ?', '2019-09-24 19:40:02'),
(4, 1, 0, 'Apakah pesanan saya bisa di proses', '2019-09-24 19:40:04'),
(5, 2, 0, 'Hai Admin', '2019-09-24 19:40:07'),
(6, 0, 1, 'Oke mohon tunggu sebenatar', '2019-09-24 19:40:58'),
(7, 0, 2, 'Hallo User 2', '2019-09-24 19:41:00');

-- --------------------------------------------------------

--
-- Table structure for table `dbttransdetail`
--

DROP TABLE IF EXISTS `dbttransdetail`;
CREATE TABLE `dbttransdetail` (
  `ID` bigint(20) NOT NULL,
  `TransID` bigint(20) DEFAULT NULL,
  `DocNumber` varchar(20) DEFAULT NULL,
  `IDProduct` bigint(20) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL,
  `Price` decimal(10,0) DEFAULT NULL,
  `Total` decimal(10,0) DEFAULT NULL,
  `Status` char(15) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbttransdetail`
--

INSERT INTO `dbttransdetail` (`ID`, `TransID`, `DocNumber`, `IDProduct`, `Qty`, `Price`, `Total`, `Status`) VALUES
(1, 1, '2510191', 22, 1, '3500', '3500', 'none'),
(2, 2, '2510192', 29, 1, '5000', '5000', 'none'),
(3, 3, '2510193', 29, 1, '5000', '5000', 'none'),
(4, 4, '2510194', 29, 1, '5000', '5000', 'none'),
(5, 5, '2510195', 29, 1, '5000', '5000', 'none'),
(6, 6, '2510196', 29, 1, '5000', '5000', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `dbttransdoc`
--

DROP TABLE IF EXISTS `dbttransdoc`;
CREATE TABLE `dbttransdoc` (
  `ID` bigint(20) NOT NULL,
  `DocNumber` varchar(20) DEFAULT NULL,
  `IDAccount` bigint(20) DEFAULT NULL,
  `TimeCreated` datetime DEFAULT NULL,
  `TimeUpdated` datetime DEFAULT NULL,
  `GrandTotal` decimal(10,0) NOT NULL DEFAULT '0',
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
  `Notes` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbttransdoc`
--

INSERT INTO `dbttransdoc` (`ID`, `DocNumber`, `IDAccount`, `TimeCreated`, `TimeUpdated`, `GrandTotal`, `Status`, `StatusPayment`, `PaymentProof`, `ShippingPaymentPerson`, `ShippingPaymentNumber`, `ShippingPaymentBank`, `ShippingAmount`, `ShippingRecipient`, `ShippingEmail`, `ShippingPhone`, `ShippingAddress`, `ShippingCity`, `ShippingCodePos`, `Notes`) VALUES
(1, '2510191', 17, '2019-10-25 05:32:51', '2019-10-25 05:32:51', '3500', 'open', 'notyet', '', '', '', '', NULL, 'Ganda Tadio Surya', 'gandatadyosurya@yahoo.com', '082264576766', 'Gang Kamboja No 6', 'Surabaya', '60222', ''),
(2, '2510192', 0, '2019-10-25 06:01:55', '2019-10-25 06:01:55', '5000', 'open', 'notyet', '', '', '', '', NULL, 'Ganda Tadio Surya', 'gandatadyosurya@yahoo.com', '082264576766', 'Gang Kamboja No 6', 'Surabaya', '60222', ''),
(3, '2510193', 19, '2019-10-25 06:02:59', '2019-10-25 06:02:59', '5000', 'open', 'notyet', '', '', '', '', NULL, 'Ganda Tadio Surya', 'gandatadyosurya@yahoo.com', '082264576766', 'Gang Kamboja No 6', 'Surabaya', '60222', ''),
(4, '2510194', 19, '2019-10-25 06:03:37', '2019-10-25 06:03:37', '5000', 'open', 'success', '20180907_101336.jpg', 'sdf', 'sdf', 'Bank BCA', '23423', 'test', 'test@yahoo.com', 'test', 'test', 'test', 'test', 'test'),
(5, '2510195', 19, '2019-10-25 06:06:57', '2019-10-25 06:06:57', '5000', 'complete', 'waiting', '20180907_101349.jpg', 'GANDA TADIO SURYA', '122412921', 'Bank BCA', '100000', 'Ganda Tadio Surya', 'gandatadyosurya@yahoo.com', '082264576766', 'Gang Kamboja No 6', 'Surabaya', '60222', ''),
(6, '2510196', 0, '2019-10-25 06:07:50', '2019-10-25 06:07:50', '5000', 'complete', 'success', 'CaptureVPS Haipasar.PNG', 'Ganda ', '2154651', 'Bank BCA', '62000', 'etset', 'test', 'tset', 'testq', 'test', 'test', 'tset');

-- --------------------------------------------------------

--
-- Table structure for table `dbttranshistory`
--

DROP TABLE IF EXISTS `dbttranshistory`;
CREATE TABLE `dbttranshistory` (
  `ID` bigint(20) NOT NULL,
  `TransID` bigint(20) DEFAULT NULL,
  `DocNumber` varchar(20) DEFAULT NULL,
  `Status` char(15) NOT NULL,
  `Notes` text,
  `TimeCreated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbttranshistory`
--

INSERT INTO `dbttranshistory` (`ID`, `TransID`, `DocNumber`, `Status`, `Notes`, `TimeCreated`) VALUES
(1, 6, '2510196', 'new', 'Belum melakukan pembayaran', '2019-10-26 06:40:17'),
(2, 6, '2510196', 'new', 'Pembarayan telah dikonfirmasi', '2019-10-26 06:40:29'),
(3, 6, '2510196', 'new', '', '2019-10-26 06:40:34'),
(4, 6, '2510196', 'new', '', '2019-10-26 06:41:31'),
(5, 6, '2510196', 'new', 'Transaksi berhasil', '2019-10-26 06:42:25'),
(6, 6, '2510196', 'new', 'Transaksi dibatalkan', '2019-10-26 06:42:32'),
(7, 6, '2510196', 'new', 'Transaksi diperbarui', '2019-10-26 06:42:39'),
(8, 6, '2510196', 'new', 'Belum melakukan pembayaran', '2019-10-26 06:42:47'),
(9, 6, '2510196', 'new', 'Pembarayan telah dikonfirmasi', '2019-10-26 07:11:12'),
(10, 5, '2510195', 'new', 'Pembarayan telah dikonfirmasi', '2019-10-26 07:12:36'),
(11, 5, '2510195', 'new', 'Transaksi diproses', '2019-10-26 07:12:36'),
(12, 5, '2510195', 'new', 'Transaksi berhasil', '2019-10-26 07:12:51'),
(13, 4, '2510194', 'new', 'Pembarayan telah dikonfirmasi', '2019-10-26 07:17:23'),
(14, 6, '2510196', 'new', 'Transaksi berhasil', '2019-10-26 07:18:47'),
(15, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:11:00'),
(16, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:12:09'),
(17, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:13:08'),
(18, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:13:22'),
(19, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:19:02'),
(20, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:19:14'),
(21, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:21:28'),
(22, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:21:56'),
(23, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:49:10'),
(24, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:49:56'),
(25, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:50:39'),
(26, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:51:12'),
(27, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:52:40'),
(28, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:52:47'),
(29, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:54:47'),
(30, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:54:53'),
(31, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:56:18'),
(32, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:56:45'),
(33, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:57:23'),
(34, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:57:30'),
(35, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:57:40'),
(36, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:57:47'),
(37, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 16:58:42'),
(38, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 16:58:49'),
(39, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 17:00:51'),
(40, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 17:01:06'),
(41, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 17:01:53'),
(42, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 17:02:01'),
(43, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 17:14:53'),
(44, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 17:15:21'),
(45, 5, '2510195', 'new', 'Belum melakukan pembayaran', '2019-10-26 17:16:11'),
(46, 0, '2510195', 'new', 'Upload pembayaran', '2019-10-26 17:27:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dbmaccount`
--
ALTER TABLE `dbmaccount`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbmcategory`
--
ALTER TABLE `dbmcategory`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbmfilesmanager`
--
ALTER TABLE `dbmfilesmanager`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbmproduct`
--
ALTER TABLE `dbmproduct`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbmshop`
--
ALTER TABLE `dbmshop`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbssystem`
--
ALTER TABLE `dbssystem`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbtbanner`
--
ALTER TABLE `dbtbanner`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbtcart`
--
ALTER TABLE `dbtcart`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbtmessage`
--
ALTER TABLE `dbtmessage`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbttransdetail`
--
ALTER TABLE `dbttransdetail`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbttransdoc`
--
ALTER TABLE `dbttransdoc`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dbttranshistory`
--
ALTER TABLE `dbttranshistory`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dbmaccount`
--
ALTER TABLE `dbmaccount`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `dbmcategory`
--
ALTER TABLE `dbmcategory`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dbmfilesmanager`
--
ALTER TABLE `dbmfilesmanager`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dbmproduct`
--
ALTER TABLE `dbmproduct`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `dbmshop`
--
ALTER TABLE `dbmshop`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dbssystem`
--
ALTER TABLE `dbssystem`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dbtbanner`
--
ALTER TABLE `dbtbanner`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dbtcart`
--
ALTER TABLE `dbtcart`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `dbtmessage`
--
ALTER TABLE `dbtmessage`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dbttransdetail`
--
ALTER TABLE `dbttransdetail`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dbttransdoc`
--
ALTER TABLE `dbttransdoc`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dbttranshistory`
--
ALTER TABLE `dbttranshistory`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
