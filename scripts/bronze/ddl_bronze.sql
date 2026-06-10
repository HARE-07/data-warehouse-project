-- ================================================
-- DDL Script: Bronze Layer Tables
-- ================================================
-- Purpose    : Create raw tables for Bronze layer
--              to store data as-is from source
--              systems without any transformation
-- Schema     : datawarehouse_bronze
-- Author     : Hare
-- Created    : 2024
-- ------------------------------------------------
-- Tables Created:
--   CRM Source:
--     - crm_cust_info       (Customer Info)
--     - crm_prd_info        (Product Info)
--     - crm_sales_details   (Sales Details)
--   ERP Source:
--     - erp_cust_az12       (Customer Data)
--     - erp_loc_a101        (Location Data)
--     - erp_px_cat_g1v2     (Product Category)
-- ------------------------------------------------
-- Notes      : - All date columns stored as VARCHAR
--                to preserve raw values
--               - DROP TABLE IF EXISTS used before
--                each CREATE for safe re-running
-- ================================================



	-- ================================================
-- Loading Bronze Layer
-- ================================================
SET @batch_start_time = NOW();
-- ------------------------------------------------
-- Loading CRM Tables
-- ------------------------------------------------

-- Loading: crm_cust_info
set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.crm_cust_info;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE datawarehouse_bronze.crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time =now();
SELECT CONCAT('>> crm_cust_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';

-- ------------------------------------------------

-- Loading: crm_prd_info
set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.crm_prd_info;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE datawarehouse_bronze.crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time = now();
SELECT CONCAT('>> crm_prd_info Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';


-- ------------------------------------------------

-- Loading: crm_sales_details
set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.crm_sales_details;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE datawarehouse_bronze.crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time = now();
SELECT CONCAT('>> crm_sales_details Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';


-- ================================================
-- Loading ERP Tables
-- ================================================

-- Loading: erp_cust_az12
set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.erp_cust_az12;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv'
INTO TABLE datawarehouse_bronze.erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time = now();
SELECT CONCAT('>> erp_cust_az12 Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';


-- ------------------------------------------------

-- Loading: erp_loc_a101

set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.erp_loc_a101;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv'
INTO TABLE datawarehouse_bronze.erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time = now();
SELECT CONCAT('>> erp_loc_a101 Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';

-- ------------------------------------------------

-- Loading: erp_px_cat_g1v2
set @start_time = now();
TRUNCATE TABLE datawarehouse_bronze.erp_px_cat_g1v2;
LOAD DATA LOCAL INFILE 'C:/Users/hare2/Downloads/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv'
INTO TABLE datawarehouse_bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
set @end_time = now();
SELECT CONCAT('>> erp_px_cat_g1v2 Load Duration: ', TIMESTAMPDIFF(SECOND, @start_time, @end_time), ' seconds') AS '';

-- ================================================
-- Bronze Layer Loading Complete!
-- ================================================
SET @batch_end_time = NOW();
SELECT CONCAT('>> Total Bronze Layer Duration: ', TIMESTAMPDIFF(SECOND, @batch_start_time, @batch_end_time), ' seconds') AS '';
