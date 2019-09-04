-- Create new database
USE master;
CREATE DATABASE Retail;
GO

-- Check MDF and LDF paths
SELECT name, physical_name, type_desc FROM sys.master_files
WHERE database_id = db_id('Retail')

-- Take backup (using Wizard)
-- Check files within container