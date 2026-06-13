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


🔄 Data Flow

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
        ▼
Gold Views ─────────────────────────────────────────────┐
  dim_customers        (complete customer profile)       │
  dim_products         (current active products only)   │  BUSINESS
  fact_sales           (transactions with surr. keys)   │  READY
                                                        ┘


🛠️ Tech Stack

ComponentTechnologyPurposeDatabaseMySQL 8.0+Main data warehouse platformIDEMySQL WorkbenchQuery development & executionData SourcesCSV FilesRaw CRM & ERP dataETLSQL Stored ProceduresBronze → Silver transformationData ModelSQL ViewsSilver → Gold serving layerVersion ControlGit & GitHubCode managementDocumentationMarkdown + WordTechnical documentation


📁 Project Structure

data-warehouse-project/
│
├── 📂 datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv          # Customer personal details
│   │   ├── prd_info.csv           # Product catalog
│   │   └── sales_details.csv      # Sales transactions
│   └── source_erp/
│       ├── cust_az12.csv          # Customer birthdate & gender
│       ├── loc_a101.csv           # Customer country
│       └── px_cat_g1v2.csv        # Product categories
│
├── 📂 scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql         # CREATE TABLE statements
│   │   └── load_bronze.sql        # LOAD DATA scripts
│   ├── silver/
│   │   ├── ddl_silver.sql         # CREATE TABLE statements
│   │   └── load_silver.sql        # Stored procedure
│   └── gold/
│       └── ddl_gold.sql           # CREATE VIEW statements
│
├── 📂 quality_checks/
│   ├── quality_checks_silver.sql  # Silver layer validations
│   └── quality_checks_gold.sql    # Gold layer validations
│
├── 📂 docs/
│   └── DataWarehouse_Complete_Documentation.docx
│
└── README.md
