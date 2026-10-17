/*
print '=============================================='
This is code to create tables, we added with it check for null and drop tables to avoid any errors 
print '=============================================='
*/

if object_id ('bronze.crm_customer_info','U') is not null 
drop table bronze.crm_customer_info
create table bronze.crm_customer_info
(
customer_id int,
customer_key nvarchar(50),
customer_firstname nvarchar(50),
customer_lastname nvarchar(50),
customer_marital_status nvarchar(50),
customer_gender nvarchar(50),
customer_create_date date
);
if object_id ('bronze.crm_product_info','U') is not null 
drop table bronze.crm_product_info
create table bronze.crm_product_info
(
product_id int,
product_key nvarchar(50),
product_name nvarchar(50),
product_cost int,
product_line nvarchar(50),
product_start_date date,
product_end_date date
);
if object_id ('bronze.crm_sales_details','U') is not null 
drop table bronze.crm_sales_details

create table bronze.crm_sales_details
(
sales_order_number nvarchar(50),
sales_production_key nvarchar(50),
sales_customer_id int,
sales_order_date int,
sales_ship_date int,
sales_due_date int,
sls_sales int,
sales_quantity int,
sales_price int
);
if object_id ('bronze.erp_cust_az12','U') is not null 
drop table bronze.erp_cust_az12
create table bronze.erp_cust_az12
(
cid nvarchar(50),
bdate date,
gen nvarchar(50)
);
if object_id ('bronze.erp_loc_a101','U') is not null 
drop table bronze.erp_loc_a101
create table bronze.erp_loc_a101
(
cid nvarchar(50),
country nvarchar(50)
);
if object_id ('bronze.erp_px_cat_g1v2','U') is not null 
drop table bronze.erp_px_cat_g1v2
create table bronze.erp_px_cat_g1v2
(
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
);

