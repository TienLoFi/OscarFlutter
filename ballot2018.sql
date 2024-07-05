-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 05, 2024 at 07:07 AM
-- Server version: 10.6.16-MariaDB-cll-lve
-- PHP Version: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ballot2018`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_ballot`
--

CREATE TABLE `tb_ballot` (
  `id` int(11) NOT NULL COMMENT 'user id',
  `answer` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `tb_ballot`
--

INSERT INTO `tb_ballot` (`id`, `answer`) VALUES
(4937, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1000p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8002p\"},{\"name\":\"9\",\"value\":\"r9002p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140004p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160003p\"},{\"name\":\"17\",\"value\":\"r170003p\"},{\"name\":\"18\",\"value\":\"r180004p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210000p\"},{\"name\":\"22\",\"value\":\"r220003p\"}]'),
(4992, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6002p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8002p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100004p\"},{\"name\":\"11\",\"value\":\"r110002p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140000p\"},{\"name\":\"15\",\"value\":\"r150003p\"},{\"name\":\"16\",\"value\":\"r160002p\"},{\"name\":\"17\",\"value\":\"r170003p\"},{\"name\":\"18\",\"value\":\"r180000p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]'),
(4994, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1000p\"},{\"name\":\"2\",\"value\":\"r2003p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4000p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7001p\"},{\"name\":\"8\",\"value\":\"r8000p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100004p\"},{\"name\":\"11\",\"value\":\"r110003p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130002p\"},{\"name\":\"14\",\"value\":\"r140004p\"},{\"name\":\"15\",\"value\":\"r150004p\"},{\"name\":\"16\",\"value\":\"r160003p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180004p\"},{\"name\":\"19\",\"value\":\"r190000p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220003p\"}]'),
(4996, '[{\"name\":\"0\",\"value\":\"r0007p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2002p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5002p\"},{\"name\":\"6\",\"value\":\"r6002p\"},{\"name\":\"7\",\"value\":\"r7001p\"},{\"name\":\"8\",\"value\":\"r8000p\"},{\"name\":\"9\",\"value\":\"r9001p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110000p\"},{\"name\":\"12\",\"value\":\"r120002p\"},{\"name\":\"13\",\"value\":\"r130004p\"},{\"name\":\"14\",\"value\":\"r140001p\"},{\"name\":\"15\",\"value\":\"r150000p\"},{\"name\":\"16\",\"value\":\"r160001p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180003p\"},{\"name\":\"19\",\"value\":\"r190001p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]'),
(4881, '[]'),
(5006, '[{\"name\":\"0\",\"value\":\"r0001p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2001p\"},{\"name\":\"3\",\"value\":\"r3002p\"},{\"name\":\"4\",\"value\":\"r4002p\"},{\"name\":\"5\",\"value\":\"r5002p\"},{\"name\":\"6\",\"value\":\"r6002p\"},{\"name\":\"7\",\"value\":\"r7001p\"},{\"name\":\"8\",\"value\":\"r8003p\"},{\"name\":\"9\",\"value\":\"r9003p\"},{\"name\":\"10\",\"value\":\"r100002p\"},{\"name\":\"11\",\"value\":\"r110000p\"},{\"name\":\"12\",\"value\":\"r120002p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140001p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160003p\"},{\"name\":\"17\",\"value\":\"r170001p\"},{\"name\":\"18\",\"value\":\"r180001p\"},{\"name\":\"19\",\"value\":\"r190001p\"},{\"name\":\"20\",\"value\":\"r200002p\"},{\"name\":\"21\",\"value\":\"r210001p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]'),
(4940, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1000p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8001p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110002p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130004p\"},{\"name\":\"14\",\"value\":\"r140000p\"},{\"name\":\"15\",\"value\":\"r150003p\"},{\"name\":\"16\",\"value\":\"r160002p\"},{\"name\":\"17\",\"value\":\"r170002p\"},{\"name\":\"18\",\"value\":\"r180002p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220000p\"}]'),
(5002, '[{\"name\":\"0\",\"value\":\"r0005p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3003p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5001p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8002p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100004p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130002p\"},{\"name\":\"14\",\"value\":\"r140003p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160003p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180002p\"},{\"name\":\"19\",\"value\":\"r190003p\"},{\"name\":\"20\",\"value\":\"r200004p\"},{\"name\":\"21\",\"value\":\"r210001p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]'),
(5001, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2003p\"},{\"name\":\"3\",\"value\":\"r3000p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7001p\"},{\"name\":\"8\",\"value\":\"r8004p\"},{\"name\":\"9\",\"value\":\"r9003p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120004p\"},{\"name\":\"13\",\"value\":\"r130002p\"},{\"name\":\"14\",\"value\":\"r140004p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160001p\"},{\"name\":\"17\",\"value\":\"r170002p\"},{\"name\":\"18\",\"value\":\"r180000p\"},{\"name\":\"19\",\"value\":\"r190001p\"},{\"name\":\"20\",\"value\":\"r200003p\"},{\"name\":\"21\",\"value\":\"r210001p\"},{\"name\":\"22\",\"value\":\"r220002p\"}]'),
(5003, '[\n  {\n    \"value\" : \"r0004p\",\n    \"name\" : \"0\"\n  },\n  {\n    \"value\" : \"r1002p\",\n    \"name\" : \"1\"\n  },\n  {\n    \"value\" : \"r2004p\",\n    \"name\" : \"2\"\n  },\n  {\n    \"value\" : \"r3004p\",\n    \"name\" : \"3\"\n  },\n  {\n    \"value\" : \"r4001p\",\n    \"name\" : \"4\"\n  },\n  {\n    \"value\" : \"r5000p\",\n    \"name\" : \"5\"\n  },\n  {\n    \"value\" : \"r6002p\",\n    \"name\" : \"6\"\n  },\n  {\n    \"value\" : \"r7002p\",\n    \"name\" : \"7\"\n  },\n  {\n    \"value\" : \"r8002p\",\n    \"name\" : \"8\"\n  },\n  {\n    \"value\" : \"r9003p\",\n    \"name\" : \"9\"\n  },\n  {\n    \"value\" : \"r100004p\",\n    \"name\" : \"10\"\n  },\n  {\n    \"value\" : \"r110002p\",\n    \"name\" : \"11\"\n  },\n  {\n    \"value\" : \"r120000p\",\n    \"name\" : \"12\"\n  },\n  {\n    \"value\" : \"r130004p\",\n    \"name\" : \"13\"\n  },\n  {\n    \"value\" : \"r140004p\",\n    \"name\" : \"14\"\n  },\n  {\n    \"value\" : \"r150002p\",\n    \"name\" : \"15\"\n  },\n  {\n    \"value\" : \"r160001p\",\n    \"name\" : \"16\"\n  },\n  {\n    \"value\" : \"r170003p\",\n    \"name\" : \"17\"\n  },\n  {\n    \"value\" : \"r180002p\",\n    \"name\" : \"18\"\n  },\n  {\n    \"value\" : \"r190004p\",\n    \"name\" : \"19\"\n  },\n  {\n    \"value\" : \"r200001p\",\n    \"name\" : \"20\"\n  },\n  {\n    \"value\" : \"r210004p\",\n    \"name\" : \"21\"\n  },\n  {\n    \"value\" : \"r220002p\",\n    \"name\" : \"22\"\n  }\n]'),
(4989, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1000p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4002p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6002p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8001p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130004p\"},{\"name\":\"14\",\"value\":\"r140000p\"},{\"name\":\"15\",\"value\":\"r150003p\"},{\"name\":\"16\",\"value\":\"r160002p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180002p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220000p\"}]'),
(4991, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3000p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8001p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100000p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140001p\"},{\"name\":\"15\",\"value\":\"r150003p\"},{\"name\":\"16\",\"value\":\"r160003p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180002p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]'),
(4963, '[{\"name\":\"0\",\"value\":\"r0002p\"},{\"name\":\"1\",\"value\":\"r1002p\"},{\"name\":\"2\",\"value\":\"r2000p\"},{\"name\":\"3\",\"value\":\"r3003p\"},{\"name\":\"4\",\"value\":\"r4000p\"},{\"name\":\"5\",\"value\":\"r5000p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7002p\"},{\"name\":\"8\",\"value\":\"r8000p\"},{\"name\":\"9\",\"value\":\"r9004p\"},{\"name\":\"10\",\"value\":\"r100004p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120004p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140002p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160000p\"},{\"name\":\"17\",\"value\":\"r170000p\"},{\"name\":\"18\",\"value\":\"r180001p\"},{\"name\":\"19\",\"value\":\"r190003p\"},{\"name\":\"20\",\"value\":\"r200001p\"},{\"name\":\"21\",\"value\":\"r210004p\"},{\"name\":\"22\",\"value\":\"r220000p\"}]'),
(4997, '[\n  {\n    \"value\" : \"r0002p\",\n    \"name\" : \"0\"\n  },\n  {\n    \"value\" : \"r1002p\",\n    \"name\" : \"1\"\n  },\n  {\n    \"value\" : \"r2004p\",\n    \"name\" : \"2\"\n  },\n  {\n    \"name\" : \"3\",\n    \"value\" : \"r3000p\"\n  },\n  {\n    \"value\" : \"r4002p\",\n    \"name\" : \"4\"\n  },\n  {\n    \"value\" : \"r5000p\",\n    \"name\" : \"5\"\n  },\n  {\n    \"name\" : \"6\",\n    \"value\" : \"r6000p\"\n  },\n  {\n    \"name\" : \"7\",\n    \"value\" : \"r7002p\"\n  },\n  {\n    \"value\" : \"r8002p\",\n    \"name\" : \"8\"\n  },\n  {\n    \"name\" : \"9\",\n    \"value\" : \"r9001p\"\n  },\n  {\n    \"name\" : \"10\",\n    \"value\" : \"r100000p\"\n  },\n  {\n    \"name\" : \"11\",\n    \"value\" : \"r110004p\"\n  },\n  {\n    \"value\" : \"r120000p\",\n    \"name\" : \"12\"\n  },\n  {\n    \"name\" : \"13\",\n    \"value\" : \"r130003p\"\n  },\n  {\n    \"name\" : \"14\",\n    \"value\" : \"r140003p\"\n  },\n  {\n    \"name\" : \"15\",\n    \"value\" : \"r150003p\"\n  },\n  {\n    \"name\" : \"16\",\n    \"value\" : \"r160000p\"\n  },\n  {\n    \"name\" : \"17\",\n    \"value\" : \"r170000p\"\n  },\n  {\n    \"name\" : \"18\",\n    \"value\" : \"r180004p\"\n  },\n  {\n    \"value\" : \"r190004p\",\n    \"name\" : \"19\"\n  },\n  {\n    \"name\" : \"20\",\n    \"value\" : \"r200001p\"\n  },\n  {\n    \"name\" : \"21\",\n    \"value\" : \"r210004p\"\n  },\n  {\n    \"name\" : \"22\",\n    \"value\" : \"r220000p\"\n  }\n]'),
(4998, '[\n  {\n    \"name\" : \"0\",\n    \"value\" : \"r0004p\"\n  },\n  {\n    \"name\" : \"1\",\n    \"value\" : \"r1002p\"\n  },\n  {\n    \"name\" : \"2\",\n    \"value\" : \"r2004p\"\n  },\n  {\n    \"value\" : \"r3000p\",\n    \"name\" : \"3\"\n  },\n  {\n    \"value\" : \"r4004p\",\n    \"name\" : \"4\"\n  },\n  {\n    \"value\" : \"r5001p\",\n    \"name\" : \"5\"\n  },\n  {\n    \"value\" : \"r6000p\",\n    \"name\" : \"6\"\n  },\n  {\n    \"name\" : \"7\",\n    \"value\" : \"r7003p\"\n  },\n  {\n    \"value\" : \"r8004p\",\n    \"name\" : \"8\"\n  },\n  {\n    \"name\" : \"9\",\n    \"value\" : \"r9003p\"\n  },\n  {\n    \"name\" : \"10\",\n    \"value\" : \"r100001p\"\n  },\n  {\n    \"name\" : \"11\",\n    \"value\" : \"r110002p\"\n  },\n  {\n    \"name\" : \"12\",\n    \"value\" : \"r120002p\"\n  },\n  {\n    \"name\" : \"13\",\n    \"value\" : \"r130002p\"\n  },\n  {\n    \"value\" : \"r140003p\",\n    \"name\" : \"14\"\n  },\n  {\n    \"name\" : \"15\",\n    \"value\" : \"r150002p\"\n  },\n  {\n    \"name\" : \"16\",\n    \"value\" : \"r160001p\"\n  },\n  {\n    \"name\" : \"17\",\n    \"value\" : \"r170004p\"\n  },\n  {\n    \"name\" : \"18\",\n    \"value\" : \"r180003p\"\n  },\n  {\n    \"name\" : \"19\",\n    \"value\" : \"r190004p\"\n  },\n  {\n    \"name\" : \"20\",\n    \"value\" : \"r200001p\"\n  },\n  {\n    \"name\" : \"21\",\n    \"value\" : \"r210004p\"\n  },\n  {\n    \"value\" : \"r220004p\",\n    \"name\" : \"22\"\n  }\n]'),
(4975, '[{\"name\":\"0\",\"value\":\"r0004p\"},{\"name\":\"1\",\"value\":\"r1001p\"},{\"name\":\"2\",\"value\":\"r2004p\"},{\"name\":\"3\",\"value\":\"r3004p\"},{\"name\":\"4\",\"value\":\"r4003p\"},{\"name\":\"5\",\"value\":\"r5004p\"},{\"name\":\"6\",\"value\":\"r6000p\"},{\"name\":\"7\",\"value\":\"r7003p\"},{\"name\":\"8\",\"value\":\"r8001p\"},{\"name\":\"9\",\"value\":\"r9000p\"},{\"name\":\"10\",\"value\":\"r100002p\"},{\"name\":\"11\",\"value\":\"r110004p\"},{\"name\":\"12\",\"value\":\"r120000p\"},{\"name\":\"13\",\"value\":\"r130003p\"},{\"name\":\"14\",\"value\":\"r140004p\"},{\"name\":\"15\",\"value\":\"r150002p\"},{\"name\":\"16\",\"value\":\"r160000p\"},{\"name\":\"17\",\"value\":\"r170001p\"},{\"name\":\"18\",\"value\":\"r180000p\"},{\"name\":\"19\",\"value\":\"r190004p\"},{\"name\":\"20\",\"value\":\"r200004p\"},{\"name\":\"21\",\"value\":\"r210003p\"},{\"name\":\"22\",\"value\":\"r220001p\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `email` varchar(512) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `level` int(11) DEFAULT 101 COMMENT '100:admin 101:user',
  `score` varchar(10) DEFAULT '0',
  `correct_categories` tinyint(3) UNSIGNED NOT NULL,
  `last_update` int(11) DEFAULT 0,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `Verify` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id`, `name`, `email`, `pwd`, `level`, `score`, `correct_categories`, `last_update`, `info1`, `info2`, `Verify`) VALUES
(4881, 'Admin', 'oscarballot@admin.com', 'f5df01b435d9e40f635ef82b67f0515c', 100, '0', 23, 1648428544, NULL, NULL, 1),
(5002, 'Colin & Tara', 'colindc9@gmail.com', '82c1974a50f3c5b4ea4dabaa77f76f76', 101, '0', 0, 1678665542, 'The Fabelmans', '4', 1),
(4996, 'Arabella Campana', 'arabella.campana@gmail.com', '9a5bbcfc7d478ae2dac3f05201d9b9bd', 101, '0', 0, 1678652609, 'Top Gun: Maverick', '3', 1),
(4994, 'Emily', 'ewagner1887@gmail.com', 'a48341b7e281299d69bcb5480654e463', 101, '0', 0, 1678646320, 'Everything Everywhere All at Once', '5', 1),
(4979, 'Ed', 'campana.ed@gmail.com', 'ad100897c6f809081d942836af421f86', 101, '0', 0, 1678557907, NULL, NULL, 1),
(4983, 'Bobby & Steve Briggs ', 'briggsmorin@gmail.com', '9e068f95e8c7da873a01b250773d20ac', 101, '0', 0, 1678577727, NULL, NULL, 0),
(4997, 'patrick', 'patrick.zhao96@gmail.com', 'a19250698b1b13a6f87e95800e75b5a5', 101, '0', 0, 1678661088, 'Parasite', '4', 0),
(4992, 'Abi Foerster', 'abifoerster@yahoo.com', 'abcda272f3837a6f544481afd164d913', 101, '0', 0, 1678641157, 'Everything Everywhere All at Once', '6', 1),
(4937, 'Kristen Willard', 'kristen_willard@hotmail.com', '20a6de86c60a0c868a0dbb9b048b997e', 101, '0', 0, 1678586780, 'Everything Everywhere All at Once', '4', 1),
(4984, 'greg', 'greg69@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 101, '0', 0, 1678595628, NULL, NULL, 0),
(4993, 'Casandra Newell', 'casandra_newell@yahoo.com', '3fd8bc420e135630aab9f922ad546511', 101, '0', 0, 1678641663, NULL, NULL, 0),
(4940, 'Ashley', 'ashleyf72@gmail.com', 'a7c4767efe9cc774a30fb192fc793ab1', 101, '0', 0, 1678499809, 'Everything Everywhere All at Once', '4', 1),
(5006, 'ADevIndustries', 'adevindustries@gmail.com', '84a2364019bb154276f41966d26146e7', 101, '0', 0, 1709150733, 'Killers of the Flower Moon', '6', 1),
(5007, 'Diego', 'dinunez@hotmail.com', '88444df94952c7c0180c19c4ae4fd3d2', 101, '0', 0, 1708314020, NULL, NULL, 0),
(4988, 'Ellen Campana', 'ellencampana@yahoo.com', '15b4a1c08ed4b2877f8fdcd47a5bc283', 101, '0', 0, 1709605152, 'Everything Everywhere All at Once', '5', 1),
(4989, 'Dan Shillito', 'dan.shillito@gmail.com', '0739513ff06b28ea8a1831bdd04105a1', 101, '0', 0, 1678635715, 'Everything Everywhere All at Once', '4', 1),
(4951, 'Andi', 'andijohnson1@gmail.com', 'b23ca48d97657880a8370e3ed43875dc', 101, '0', 0, 1648417407, NULL, NULL, 0),
(4956, 'Amanda', 'afarrell396@gmail.com', 'd764437b32d69a6b126bf6239920d6a2', 101, '0', 0, 1648419391, NULL, NULL, 1),
(5003, 'Dawn Abasta', 'dluvcntry@gmail.com', '1198d46653fd6bc3f50aa19a8a7c4b1e', 101, '0', 0, 1678669664, 'everything everywhere all at once', '5', 0),
(5004, 'Colin Campbell', 'colin@seventeas.com', '82c1974a50f3c5b4ea4dabaa77f76f76', 101, '0', 0, 1678665081, NULL, NULL, 0),
(4963, 'Lynn Schmitz', 'lschmitz1@comcast.net', 'a7f006c740730cb1864e5fc4abd9bab5', 101, '0', 0, 1678424286, 'The Banshees of Inisherin', '5', 1),
(4998, 'nicole', 'nicolej12@hotmail.com', 'e1736e0d943f0e0d0b40ab185bbef358', 101, '0', 0, 1678657361, 'Parasite', '6', 0),
(4991, 'Matt C!', 'mcpurple@hotmail.com', 'f5df01b435d9e40f635ef82b67f0515c', 101, '0', 0, 1678637799, 'Everything Everywhere All at Once', '5', 1),
(5000, 'Dray', 'evosdesign@aol.com', '8635cd91e80bf1c8f0b490a3c72324da', 101, '0', 0, 1678659967, NULL, NULL, 0),
(5001, 'Tim Dellinger', 'tim.dellinger@gmail.com', '8ecb288addb7d7f4b4eab6dc8abac404', 101, '0', 0, 1678661888, 'All Quiet on the Western Front', '3', 1),
(4975, 'Anna Santos de Dios', 'alsdd_2@hotmail.com', 'c1bb228938ad326f41fd41ad934a7f0d', 101, '0', 0, 1678466852, 'Everything Everywhere All at Once', '4', 1),
(5005, 'Allie', 'aquinn151@gmail.com', '6c97e53836216dc3cb00ace27b79812e', 101, '0', 0, 1679071590, NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_ballot`
--
ALTER TABLE `tb_ballot`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5008;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
