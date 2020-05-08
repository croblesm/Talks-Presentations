--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 6- Restore database in destination (Container)
---------------------------------------------------------------------------------

-- Get backup metadata (optional)
--RESTORE FILELISTONLY FROM DISK = '/Shared/hr_20200508_1500.bak';

-- Restore database using shared folder
USE master
GO
RESTORE DATABASE HumanResources
FROM DISK = '/Shared/hr_20200508_1000.bak'
WITH MOVE 'HumanResources_data' TO '/mssql_data/HR.mdf',
MOVE 'HumanResources_log' TO '/mssql_log/HR_log.ldf';

-- Returning employee and employee details data
SELECT * FROM HumanResources.dbo.Employees;
SELECT * FROM HumanResources.dbo.Dependents;