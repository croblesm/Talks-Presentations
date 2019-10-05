--------------------------------------------------------------------------------- 
-- Querying Human Resources database
---------------------------------------------------------------------------------

-- Query Human Resources tables
SELECT * FROM HumanResources.dbo.Employee;
SELECT * FROM HumanResources.dbo.EmployeeDetails;

-- Check MDF and LDF paths
SELECT name, physical_name, type_desc FROM sys.master_files
WHERE database_id = db_id('HumanResources')