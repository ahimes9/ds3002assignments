#DROP DATABASE northwind_dw;
CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE northwind_dw;

# creating the dimension tables
DROP TABLE dim_customers;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `mobile_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

DROP TABLE dim_employees;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `mobile_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

DROP TABLE dim_products;
CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;

DROP TABLE dim_shippers;
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

# creating the fact table
DROP TABLE fact_orders;
CREATE TABLE fact_orders (
  `order_id` int,
  `employee_id` int,
  `customer_id` int,
  `product_id` int,
  `shipper_id` int DEFAULT NULL,
  `ship_name` varchar(50) DEFAULT NULL,
  `ship_address` longtext,
  `ship_city` varchar(50) DEFAULT NULL,
  `ship_state_province` varchar(50) DEFAULT NULL,
  `ship_zip_postal_code` varchar(50) DEFAULT NULL,
  `ship_country_region` varchar(50) DEFAULT NULL,
  `quantity` int,
  `order_date` datetime DEFAULT NULL,
  `shipped_date` datetime DEFAULT NULL,
  `shipping_fee` int,
  `taxes` decimal(19,4) DEFAULT '0.0000',
  `payment_type` varchar(50) DEFAULT NULL,
  `paid_date` datetime DEFAULT NULL,
  `tax_rate` double DEFAULT '0',
  `order_status` int,
  `order_details_status` int
);

# loading the dimension tables
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`mobile_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `customers`.`id`,
    `customers`.`company`,
    `customers`.`last_name`,
    `customers`.`first_name`,
    `customers`.`email_address`,
    `customers`.`job_title`,
    `customers`.`business_phone`,
    `customers`.`home_phone`,
    `customers`.`mobile_phone`,
    `customers`.`fax_number`,
    `customers`.`address`,
    `customers`.`city`,
    `customers`.`state_province`,
    `customers`.`zip_postal_code`,
    `customers`.`country_region`
FROM `northwind`.`customers`;

INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`mobile_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`mobile_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`
FROM `northwind`.`employees`;

INSERT INTO `northwind_dw`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT `products`.`id`,
    `products`.`product_code`,
    `products`.`product_name`,
    `products`.`standard_cost`,
    `products`.`list_price`,
    `products`.`reorder_level`,
    `products`.`target_level`,
    `products`.`quantity_per_unit`,
    `products`.`discontinued`,
    `products`.`minimum_reorder_quantity`,
    `products`.`category`
FROM `northwind`.`products`;

INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `shippers`.`id`,
    `shippers`.`company`,
    `shippers`.`business_phone`,
    `shippers`.`fax_number`,
    `shippers`.`address`,
    `shippers`.`city`,
    `shippers`.`state_province`,
    `shippers`.`zip_postal_code`,
    `shippers`.`country_region`
FROM `northwind`.`shippers`;

# loading the orders fact table
INSERT INTO `northwind_dw`.`fact_orders`
(`order_id`,
`employee_id`,
`customer_id`,
`product_id`,
`shipper_id`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`quantity`,
`order_date`,
`shipped_date`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`order_status`,
`order_details_status`)
SELECT o.id AS order_id, o.employee_id, o.customer_id, od.product_id, o.shipper_id, o.ship_name, o.ship_address, o.ship_city,
o.ship_state_province, o.ship_zip_postal_code, o.ship_country_region, od.quantity, o.order_date, o.shipped_date, o.shipping_fee,
o.taxes, o.payment_type, o.paid_date, o.tax_rate, os.id AS order_status, ods.id AS order_details_status
FROM northwind.orders o
JOIN northwind.orders_status os
ON os.id = o.status_id
JOIN northwind.order_details od
ON o.id = od.order_id
JOIN northwind.order_details_status ods
ON od.status_id = ods.id
;

## creating a dimensional report
# SQL SELECT statement that returns each customer’s last name, the total amount of the order quantity 
# associated with each customer, and the total amount of the order unit price associated with each customer
SELECT dc.last_name, SUM(fo.quantity) AS total_quantity, SUM(dp.list_price) AS total_unit_price
FROM northwind_dw.fact_orders fo
JOIN northwind_dw.dim_customers dc
ON fo.customer_id=dc.customer_key
JOIN northwind_dw.dim_products dp
ON dp.product_key=fo.product_id
GROUP BY dc.last_name
