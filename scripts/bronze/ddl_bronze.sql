-- ================================================
-- DDL Script: Bronze Layer Tables
-- ================================================
-- Purpose    : Create raw tables for Bronze layer
--              to store data as-is from source
--              systems without any transformation
-- Schema     : datawarehouse_bronze
-- Author     : Hare2
-- Created    : 2024
-- ------------------------------------------------
-- Tables Created:
--   CRM Source:
--     - crm_cust_info       (Customer Info)
--     - crm_prd_info        (Product Info)
--     - crm_sales_details   (Sales Details)
--   ERP Source:
--     - erp_loc_a101        (Location Data)
--     - erp_cust_az12       (Customer Data)
--     - erp_px_cat_g1v2     (Product Category)
-- ------------------------------------------------
-- Notes      : - All date columns stored as VARCHAR
--                to preserve raw values
--              - DROP TABLE IF EXISTS used before
--                each CREATE for safe re-running
-- ================================================

-- ------------------------------------------------
-- CRM Tables
-- ------------------------------------------------

-- Table: crm_cust_info
-- Source: source_crm/cust_info.csv
-- Desc  : Customer personal details from CRM system
DROP TABLE IF EXISTS datawarehouse_bronze.crm_cust_info;
CREATE TABLE datawarehouse_bronze.crm_cust_info (
    cst_id              INT,           -- Customer ID (unique identifier)
    cst_key             VARCHAR(50),   -- Customer key
    cst_firstname       VARCHAR(50),   -- First name
    cst_lastname        VARCHAR(50),   -- Last name
    cst_marital_status  VARCHAR(50),   -- Marital status
    cst_gndr            VARCHAR(50),   -- Gender
    cst_create_date     VARCHAR(50)    -- Account creation date (raw)
);

-- ------------------------------------------------

-- Table: crm_prd_info
-- Source: source_crm/prd_info.csv
-- Desc  : Product details from CRM system
DROP TABLE IF EXISTS datawarehouse_bronze.crm_prd_info;
CREATE TABLE datawarehouse_bronze.crm_prd_info (
    prd_id        INT,           -- Product ID (unique identifier)
    prd_key       VARCHAR(50),   -- Product key
    prd_nm        VARCHAR(50),   -- Product name
    prd_cost      INT,           -- Product cost
    prd_line      VARCHAR(50),   -- Product line
    prd_start_dt  VARCHAR(50),   -- Product start date (raw)
    prd_end_dt    VARCHAR(50)    -- Product end date (raw)
);

-- ------------------------------------------------

-- Table: crm_sales_details
-- Source: source_crm/sales_details.csv
-- Desc  : Sales transactions from CRM system
DROP TABLE IF EXISTS datawarehouse_bronze.crm_sales_details;
CREATE TABLE datawarehouse_bronze.crm_sales_details (
    sls_ord_num   VARCHAR(50),   -- Sales order number
    sls_prd_key   VARCHAR(50),   -- Product key
    sls_cust_id   INT,           -- Customer ID
    sls_order_dt  INT,           -- Order date (raw integer)
    sls_ship_dt   INT,           -- Ship date (raw integer)
    sls_due_dt    INT,           -- Due date (raw integer)
    sls_sales     INT,           -- Sales amount
    sls_quantity  INT,           -- Quantity sold
    sls_price     INT            -- Price per unit
);

-- ------------------------------------------------
-- ERP Tables
-- ------------------------------------------------

-- Table: erp_loc_a101
-- Source: source_erp/loc_a101.csv
-- Desc  : Customer location data from ERP system
DROP TABLE IF EXISTS datawarehouse_bronze.erp_loc_a101;
CREATE TABLE datawarehouse_bronze.erp_loc_a101 (
    cid    VARCHAR(50),   -- Customer ID
    cntry  VARCHAR(50)    -- Country
);

-- ------------------------------------------------

-- Table: erp_cust_az12
-- Source: source_erp/cust_az12.csv
-- Desc  : Customer details from ERP system
DROP TABLE IF EXISTS datawarehouse_bronze.erp_cust_az12;
CREATE TABLE datawarehouse_bronze.erp_cust_az12 (
    cid    VARCHAR(50),   -- Customer ID
    bdate  VARCHAR(50),   -- Birth date (raw)
    gen    VARCHAR(50)    -- Gender
);

-- ------------------------------------------------

-- Table: erp_px_cat_g1v2
-- Source: source_erp/px_cat_g1v2.csv
-- Desc  : Product category details from ERP system
DROP TABLE IF EXISTS datawarehouse_bronze.erp_px_cat_g1v2;
CREATE TABLE datawarehouse_bronze.erp_px_cat_g1v2 (
    id           VARCHAR(50),   -- Category ID
    cat          VARCHAR(50),   -- Category name
    subcat       VARCHAR(50),   -- Sub category name
    maintenance  VARCHAR(50)    -- Maintenance flag
);

-- ================================================
-- End of DDL Script: Bronze Layer Tables
-- ================================================
