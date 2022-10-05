-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2022 at 09:52 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `sp_delete_product` (IN `pId` INT, IN `upUser` VARCHAR(40))  BEGIN
  DECLARE userCcyCode VARCHAR(40) DEFAULT '';
  DECLARE pCcyCode VARCHAR(40) DEFAULT '';

  SELECT currency_code INTO userCcyCode FROM tb_user WHERE user_no = upUser;
  SELECT currency_code INTO pCcyCode FROM tb_product WHERE product_id = pId;

  IF userCcyCode = pCcyCode THEN
    DELETE FROM tb_product WHERE product_id = pId;
    SELECT 1 AS result; -- 1 : Mean operation success
  ELSE
    SELECT -2 AS result; -- -2 : Mean not the user that create this product
  END IF;
END$$

CREATE  PROCEDURE `sp_delete_user` (IN `uNo` VARCHAR(40))  BEGIN
  UPDATE tb_user SET
     user_status = 'n'
  WHERE user_no = uNo;
  SELECT 1 AS result; -- 1 : Mean operation success
END$$

CREATE  PROCEDURE `sp_get_product` ()  BEGIN
  SELECT * FROM tb_product;
END$$

CREATE  PROCEDURE `sp_get_user` ()  BEGIN
  SELECT * FROM tb_user;
END$$

CREATE  PROCEDURE `sp_insert_product` (IN `pName` VARCHAR(80), IN `pPrice` INT, IN `ccyCode` VARCHAR(20), IN `crUser` VARCHAR(40))  BEGIN
  INSERT INTO tb_product(
    product_name, product_price, currency_code, create_user, row_date, row_time
  ) VALUES (
    pName, pPrice, ccyCode, crUser, NOW(), NOW()
  );
  SELECT 1 AS result; -- 1 : Mean operation success
END$$

CREATE  PROCEDURE `sp_insert_user` (IN `uNo` VARCHAR(40), IN `uName` VARCHAR(50), IN `ccyCode` VARCHAR(20))  BEGIN
  INSERT INTO tb_user(
    user_no, full_name, currency_code, row_date, row_time
  ) VALUES (
    uNo, uName, ccyCode, NOW(), NOW()
  );
  SELECT 1 AS result; -- 1 : Mean operation success
END$$

CREATE  PROCEDURE `sp_update_product` (IN `pId` INT, IN `pName` VARCHAR(80), IN `pPrice` INT, IN `ccyCode` VARCHAR(20), IN `upUser` VARCHAR(40))  BEGIN
  DECLARE userCcyCode VARCHAR(40) DEFAULT '';

  SELECT currency_code INTO userCcyCode FROM tb_user WHERE user_no = upUser;

  IF userCcyCode = ccyCode THEN
    UPDATE tb_product SET
      product_name = pName, product_price = pPrice, currency_code = ccyCode
    WHERE product_id = pId;
    SELECT 1 AS result; -- 1 : Mean operation success
  ELSE
    SELECT -2 AS result; -- -2 : Mean not the user that create this product
  END IF;
END$$

CREATE  PROCEDURE `sp_update_user` (IN `uNo` VARCHAR(40), IN `uName` VARCHAR(50), IN `ccyCode` VARCHAR(20))  BEGIN
  UPDATE tb_user SET
     full_name = uName, currency_code = ccyCode
  WHERE user_no = uNo;
  SELECT 1 AS result; -- 1 : Mean operation success
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_currency`
--

CREATE TABLE `tb_currency` (
  `currency_code` varchar(20) NOT NULL,
  `currency_name` varchar(30) DEFAULT NULL,
  `currency_unit` varchar(10) DEFAULT NULL,
  `currency_status` enum('y','n') DEFAULT 'y',
  `row_date` date DEFAULT NULL,
  `row_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_currency`
--

INSERT INTO `tb_currency` (`currency_code`, `currency_name`, `currency_unit`, `currency_status`, `row_date`, `row_time`) VALUES
('CNY', 'Yuan', '¥', 'y', '2022-10-05', '13:28:00'),
('LAK', 'Kip', '₭', 'y', '2022-10-05', '13:28:00'),
('THB', 'Baht', '฿', 'y', '2022-10-05', '13:28:00'),
('USD', 'Dollar', '$', 'y', '2022-10-05', '13:28:00');

-- --------------------------------------------------------

--
-- Table structure for table `tb_product`
--

CREATE TABLE `tb_product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `currency_code` varchar(20) DEFAULT NULL,
  `product_status` enum('y','n') DEFAULT 'y',
  `create_user` varchar(40) DEFAULT NULL,
  `row_date` date DEFAULT NULL,
  `row_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `user_no` varchar(40) NOT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `currency_code` varchar(20) DEFAULT NULL,
  `user_status` enum('y','n') DEFAULT 'y',
  `row_date` date DEFAULT NULL,
  `row_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`user_no`, `full_name`, `currency_code`, `user_status`, `row_date`, `row_time`) VALUES
('0001', 'Mr A', 'LAK', 'y', '2022-10-05', '13:30:00'),
('0002', 'Mr B', 'USD', 'y', '2022-10-05', '13:30:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_currency`
--
ALTER TABLE `tb_currency`
  ADD PRIMARY KEY (`currency_code`);

--
-- Indexes for table `tb_product`
--
ALTER TABLE `tb_product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FK_tb_product_tb_currency_currency_code` (`currency_code`),
  ADD KEY `FK_tb_product_tb_user_user_no` (`create_user`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`user_no`),
  ADD KEY `FK_tb_user_tb_currency_currency_code` (`currency_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_product`
--
ALTER TABLE `tb_product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_product`
--
ALTER TABLE `tb_product`
  ADD CONSTRAINT `FK_tb_product_tb_currency_currency_code` FOREIGN KEY (`currency_code`) REFERENCES `tb_currency` (`currency_code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tb_product_tb_user_user_no` FOREIGN KEY (`create_user`) REFERENCES `tb_user` (`user_no`) ON DELETE CASCADE;

--
-- Constraints for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD CONSTRAINT `FK_tb_user_tb_currency_currency_code` FOREIGN KEY (`currency_code`) REFERENCES `tb_currency` (`currency_code`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
