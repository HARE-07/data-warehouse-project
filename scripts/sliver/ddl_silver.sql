-- ================================================
-- DDL Script: Create Silver Tables
-- ================================================
-- Purpose    : Create cleaned tables for Silver
--              layer with proper data types
-- Schema     : datawarehouse_silver
-- Author     : Hare2
-- Created    : 2024
-- ================================================

-- ------------------------------------------------
-- CRM Tables
-- ------------------------------------------------

-- Table: crm_cust_info
DROP TABLE IF EXISTS datawarehouse_silver.crm_cust_info;
CREATE TABLE datawarehouse_silver.crm_cust_info (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gndr            VARCHAR(50),
    cst_create_date     DATE,
    dwh_create_date     DATETIME DEFAULT NOW()  -- ✅ fixed typo dhw -> dwh
);

-- Table: crm_prd_info
DROP TABLE IF EXISTS datawarehouse_silver.crm_prd_info;
CREATE TABLE datawarehouse_silver.crm_prd_info (
    prd_id          INT,
    cat_id          VARCHAR(50),   -- ✅ added missing column
    prd_key         VARCHAR(50),
    prd_nm          VARCHAR(50),
    prd_cost        INT,
    prd_line        VARCHAR(50),
    prd_start_dt    DATE,          -- ✅ fixed DATETIME -> DATE
    prd_end_dt      DATE,          -- ✅ fixed DATETIME -> DATE
    dwh_create_date DATETIME DEFAULT NOW()
);

-- Table: crm_sales_details
DROP TABLE IF EXISTS datawarehouse_silver.crm_sales_details;
CREATE TABLE datawarehouse_silver.crm_sales_details (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    DATE,          
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT,
    dwh_create_date DATETIME DEFAULT NOW()
);

-- ------------------------------------------------
-- ERP Tables
-- ------------------------------------------------

-- Table: erp_loc_a101
DROP TABLE IF EXISTS datawarehouse_silver.erp_loc_a101;
CREATE TABLE datawarehouse_silver.erp_loc_a101 (
    cid             VARCHAR(50),
    cntry           VARCHAR(50),
    dwh_create_date DATETIME DEFAULT NOW()
);

-- Table: erp_cust_az12
DROP TABLE IF EXISTS datawarehouse_silver.erp_cust_az12;
CREATE TABLE datawarehouse_silver.erp_cust_az12 (
    cid             VARCHAR(50),
    bdate           DATE,
    gen             VARCHAR(50),
    dwh_create_date DATETIME DEFAULT NOW()
);

-- Table: erp_px_cat_g1v2
DROP TABLE IF EXISTS datawarehouse_silver.erp_px_cat_g1v2;
CREATE TABLE datawarehouse_silver.erp_px_cat_g1v2 (
    id              VARCHAR(50),
    cat             VARCHAR(50),
    subcat          VARCHAR(50),
    maintenance     VARCHAR(50),
    dwh_create_date DATETIME DEFAULT NOW()
);
