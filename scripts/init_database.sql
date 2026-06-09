-- ============================================================================
-- DATA WAREHOUSE INITIALIZATION SCRIPT
-- Architecture: Medallion Architecture (Bronze -> Silver -> Gold)
-- Target Engine: MySQL
-- ============================================================================

-- ----------------------------------------------------------------------------
-- STEP 1: Environment Cleanup
-- ----------------------------------------------------------------------------
-- Purpose: Safely drop existing environments to allow for clean, repeatable deployments.
-- In MySQL, dropping a schema/database automatically drops all underlying tables.

DROP DATABASE IF EXISTS DataWarehouse_bronze;
DROP DATABASE IF EXISTS DataWarehouse_silver;
DROP DATABASE IF EXISTS DataWarehouse_gold;


-- ----------------------------------------------------------------------------
-- STEP 2: Database / Layer Creation
-- ----------------------------------------------------------------------------
-- Note: MySQL treats 'SCHEMA' and 'DATABASE' as exact synonyms. 
-- We isolate Bronze, Silver, and Gold as separate databases to simulate schemas.

-- BRONZE: The Raw Landing Zone. Stores original data exactly as it arrived from sources.
CREATE DATABASE DataWarehouse_bronze;

-- SILVER: The Cleansed / Conformed Zone. Stores deduplicated, validated, and enriched data.
CREATE DATABASE DataWarehouse_silver;

-- GOLD: The Business / Analytics Zone. Stores optimized, aggregated data ready for BI tools.
CREATE DATABASE DataWarehouse_gold;

