/*
  This script is bulk insert table content inside the database 
  we used truncate to drop tables first to avoid errors 
  then we added stored procedures to load content dynamically if there are a new update for the csv files 
  */
create or alter procedure bronze.load_bronze as
Begin 
print '=========================================='
print 'load bronze layer'
print '=========================================='

print '-------------------------------------------'
print 'load CRM Tables'
print '-------------------------------------------'
truncate table bronze.crm_customer_info
bulk insert bronze.crm_customer_info
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.crm_product_info
bulk insert bronze.crm_product_info
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.crm_sales_details
bulk insert bronze.crm_sales_details 
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
print '-------------------------------------------'
print 'load ERP Tables'
print '-------------------------------------------'
truncate table bronze.erp_cust_az12
bulk insert bronze.erp_cust_az12
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.erp_loc_a101
bulk insert bronze.erp_loc_a101
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.erp_px_cat_g1v2
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\m_kam\Downloads\Compressed\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
End
