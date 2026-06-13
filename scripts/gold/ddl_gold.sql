DROP VIEW IF EXISTS datawarehouse_gold.dim_customer;

CREATE VIEW datawarehouse_gold.dim_customer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key, 
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    ca.bdate AS birth_day,
    cl.cntry AS country,
    CASE
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender,
    ci.cst_marital_status AS marital_status,
    ci.cst_create_date AS create_date
FROM datawarehouse_silver.crm_cust_info AS ci
LEFT JOIN datawarehouse_silver.erp_cust_az12 AS ca 
    ON ci.cst_key = ca.cid
LEFT JOIN datawarehouse_silver.erp_loc_a101 AS cl 
    ON ca.cid = cl.cid;
select distinct gender from datawarehouse_gold.dim_customer


---------------------------------------------------------------------------------------------------------------------------------------------------------------


drop view if exists datawarehouse_gold.dim_product;
create view datawarehouse_gold.dim_product as
select 
row_number() over(order by prd_start_dt,prd_key) as product_key,
pi.prd_id   as product_id,
pi.cat_id    as customer_id,
pi.prd_key    as product_number,
pi.prd_nm as product_name,
pc.cat   as product_category,
pc.maintenance       as product_maintenaance,
pc.subcat    as sub_category,
pi.prd_cost   as product_cost,
pi.prd_line   as product_line,
pi.prd_start_dt  as start_date,
pi.prd_end_dt  as end_date
 from datawarehouse_silver.crm_prd_info as pi
 left join datawarehouse_silver.erp_px_cat_g1v2 as pc
 on pi.cat_id = pc.id
 where pi.prd_end_dt is null;


-----------------------------------------------------------------------------------------------------------------------------------------------------
drop view if exists datawarehouse_gold.fact_sales;
create view datawarehouse_gold.fact_sales as
select 
sd.sls_ord_num   as order_number,
gp.product_key,
gc.customer_key,
sd.sls_order_dt  as order_date,
sd.sls_ship_dt   as ship_date,
sd.sls_due_dt    as due_date,
sd.sls_sales      as sales,
sd.sls_quantity     as quantity,
sd.sls_price   as price

from datawarehouse_silver.crm_sales_details as sd
left join datawarehouse_gold.dim_product as gp
on sd.sls_prd_key = gp.product_number
left join datawarehouse_gold.dim_customer as gc
on sd.sls_cust_id = gc.customer_id;
