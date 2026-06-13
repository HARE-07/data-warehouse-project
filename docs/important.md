Dimension Table  -->  describes WHO, WHAT, WHERE
                      dim_customers -- who bought
                      dim_products  -- what was bought

Fact Table       -->  describes WHAT HAPPENED
                      fact_sales    -- the actual sale event
                      has numbers: sales, quantity, price


--------------------------------------------------------------------------------------------------------------------------------

Full Data Flow Visualized for datawarehouse_gold.dim_customer.


crm_cust_info (ci)          erp_cust_az12 (ca)      erp_loc_a101 (la)
      |                             |                       |
      | cst_key = ca.cid            |                       |
      |_____________________________|                       |
                    |                                       |
                    | cst_key = la.cid                      |
                    |_______________________________________|
                                    |
                                    v
                          gold.dim_customers
                    (complete customer dimension)

Columns combined:
ci  --> customer_id, customer_number, first_name,
        last_name, marital_status, gender, create_date
ca  --> birthdate, gender (fallback)
la  --> country
---------------------------------------------------------------------------------------------------------------------------------------
Full Data Flow Visualized for datawarehouse_gold.dim_product.


crm_prd_info (pn)              erp_px_cat_g1v2 (pc)
      |                                  |
      | pn.cat_id = pc.id               |
      |__________________________________|
                    |
                    | WHERE prd_end_dt IS NULL
                    | (only current products)
                    v
            gold.dim_products
         (current product dimension)

Columns combined:
pn --> product_id, product_number, product_name,
       category_id, cost, product_line, start_date
pc --> category, subcategory, maintenance

------------------------------------------------------------------------------------------------------------------------------

Silver has raw IDs:
sls_prd_key = 'BK-R50'   -- text key
sls_cust_id = 101         -- source system ID

Gold needs surrogate keys:
product_key  = 5          -- warehouse key
customer_key = 1          -- warehouse key

fact_sales links everything together
using surrogate keys from dimensions

-----------------------------------------------------------------------------------------------------------------------------
dim_customers
                      |
                      | customer_key
                      |
dim_products ---  fact_sales
product_key       order_number
                  order_date
                  sales_amount
                  quantity
                  price
