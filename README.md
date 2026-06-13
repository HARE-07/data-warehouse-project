🏗️ Data Warehouse & Analytics Project

Medallion Architecture | MySQL | ETL Pipeline | Star Schema

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL-FF6B35?style=for-the-badge&logo=databricks&logoColor=white"/>
  <img src="https://img.shields.io/badge/ETL%20Pipeline-1E7145?style=for-the-badge&logo=apacheairflow&logoColor=white"/>
  <img src="https://img.shields.io/badge/Data%20Warehouse-1F5C99?style=for-the-badge&logo=googlecloud&logoColor=white"/>
  <img src="https://img.shields.io/badge/Star%20Schema-BF6000?style=for-the-badge&logo=powerbi&logoColor=white"/>
</p>


🎯 A complete, production-style Data Warehouse built from scratch using Medallion Architecture — ingesting raw CSV data from CRM & ERP systems, transforming it through Bronze → Silver → Gold layers, and serving it as a Star Schema for business analytics.




📋 Table of Contents


Project Overview
Architecture
Data Flow
Tech Stack
Project Structure
Layer Details

🥉 Bronze Layer
🥈 Silver Layer
🥇 Gold Layer



Data Model — Star Schema
SQL Features Used
Quality Checks
Getting Started
Project Stats
License
About Me



🗂️ Project Overview

This project demonstrates a complete end-to-end Data Warehouse solution built entirely in MySQL Workbench. It covers every stage of a modern data pipeline — from raw data ingestion to business-ready analytical views.

What This Project Covers

AreaWhat Was BuiltData EngineeringETL pipeline ingesting raw CSV data from CRM & ERP systemsData ModelingStar Schema with Dimension and Fact tablesData QualityValidation checks across all three layersAnalyticsSQL-based reporting on customers, products, and salesDocumentationFull technical documentation of every transformation

Business Problem Solved


Raw data from two separate source systems (CRM and ERP) was siloed, dirty, and inconsistent. This project consolidates both into a single clean, reliable data warehouse that answers key business questions about customer behavior, product performance, and sales trends.




🏛️ Architecture

This project follows the Medallion Architecture — an industry-standard pattern used by companies like Databricks, Snowflake, and Azure.

```
┌─────────────────────────────────────────────────────────────────┐
│                     SOURCE SYSTEMS                              │
│                                                                 │
│   📁 CRM System              📁 ERP System                      │
│   ├── cust_info.csv          ├── cust_az12.csv                  │
│   ├── prd_info.csv           ├── loc_a101.csv                   │
│   └── sales_details.csv      └── px_cat_g1v2.csv                │
└─────────────────────┬───────────────────────────────────────────┘
                      │  LOAD DATA LOCAL INFILE
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  🥉 BRONZE LAYER  (datawarehouse_bronze)                        │
│                                                                 │
│  Raw data stored AS-IS — no transformation                      │
│  All dates as VARCHAR · Dirty values preserved · Audit trail    │
└─────────────────────┬───────────────────────────────────────────┘
                      │  Stored Procedure: load_silver()
                      │  INSERT INTO ... SELECT
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  🥈 SILVER LAYER  (datawarehouse_silver)                        │
│                                                                 │
│  Cleaned · Standardized · Deduplicated · Type-converted         │
│  TRIM · UPPER · CASE · STR_TO_DATE · ROW_NUMBER · LEAD          │
└─────────────────────┬───────────────────────────────────────────┘
                      │  CREATE VIEW
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  🥇 GOLD LAYER  (datawarehouse_gold)                            │
│                                                                 │
│  Business-ready · Star Schema · Surrogate Keys · Joined         │
│  dim_customers · dim_products · fact_sales                      │
└─────────────────────────────────────────────────────────────────┘
```
🔄 Data Flow
```
CSV Files (Local Machine)
        │
        │  LOAD DATA LOCAL INFILE
        ▼
Bronze Tables ──────────────────────────────────────────┐
  crm_cust_info        (18,485 raw customer records)    │
  crm_prd_info         (product catalog)                │  RAW
  crm_sales_details    (60,000+ sales transactions)     │
  erp_cust_az12        (birthdate & gender from ERP)    │
  erp_loc_a101         (country data from ERP)          │
  erp_px_cat_g1v2      (product categories from ERP)   │
        │                                               ┘
        │  load_silver() Stored Procedure
        │  TRUNCATE → Transform → INSERT
        ▼
Silver Tables ──────────────────────────────────────────┐
  crm_cust_info        (deduplicated, cleaned)          │
  crm_prd_info         (keys split, dates fixed)        │  CLEAN
  crm_sales_details    (dates converted, sales fixed)   │
  erp_cust_az12        (NAS prefix removed, dates ok)   │
  erp_loc_a101         (country codes standardized)     │
  erp_px_cat_g1v2      (clean as-is)                    │
        │                                               ┘
        │  CREATE VIEW (Gold Layer)
        │  LEFT JOINs + Surrogate Keys


```
⚡ Getting Started

Prerequisites


MySQL 8.0 or above (ROW_NUMBER window function required)
MySQL Workbench
CSV source files from CRM and ERP systems


Step-by-Step Setup

Step 1 — Create databases

sqlCREATE DATABASE IF NOT EXISTS datawarehouse_bronze;
CREATE DATABASE IF NOT EXISTS datawarehouse_silver;
CREATE DATABASE IF NOT EXISTS datawarehouse_gold;

Step 2 — Create Bronze tables

bashRun: scripts/bronze/ddl_bronze.sql

Step 3 — Load Bronze data

bashRun: scripts/bronze/load_bronze.sql
-- Updates path to your local CSV location first!

Step 4 — Create Silver tables

bashRun: scripts/silver/ddl_silver.sql

Step 5 — Load Silver data

sql-- Run the stored procedure
CALL datawarehouse_silver.load_silver();

Step 6 — Create Gold views

bashRun: scripts/gold/ddl_gold.sql

Step 7 — Run quality checks

bashRun: quality_checks/quality_checks_silver.sql
Run: quality_checks/quality_checks_gold.sql

Step 8 — Query the data warehouse

sqlSELECT * FROM datawarehouse_gold.dim_customers LIMIT 10;
SELECT * FROM datawarehouse_gold.dim_products  LIMIT 10;
SELECT * FROM datawarehouse_gold.fact_sales    LIMIT 10;


📊 Project Stats

MetricValueSource Systems2 (CRM + ERP)Source CSV Files6Bronze Tables6Silver Tables6Gold Views3 (2 dimensions + 1 fact)Customer Records18,485Transformations Applied15+SQL Functions Used20+Quality Checks12+
        ▼
Gold Views ─────────────────────────────────────────────┐
  dim_customers        (complete customer profile)       │
  dim_products         (current active products only)   │  BUSINESS
  fact_sales           (transactions with surr. keys)   │  READY
                                                        ┘
```
