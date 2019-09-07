--------------------------------------------------------------------------------- 
-- Restore Wide World Importers in CU13 container
---------------------------------------------------------------------------------

-- Restore WWI
RESTORE DATABASE WWI FROM DISK = '/Shared/wwi.bak' WITH
MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf',
MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImporters_userdata.ndf',
MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf', 
MOVE 'WWI_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1';

-- Look for WWI database
SELECT name FROM sys.databases;

-- Check SQL Server version --14.0.3048.4 = CU13
SELECT
    SERVERPROPERTY('ServerName') AS [Instance Name],
    CASE LEFT(CONVERT(VARCHAR, SERVERPROPERTY('ProductVersion')),4) 
			WHEN '11.0' THEN 'SQL Server 2012'
			WHEN '12.0' THEN 'SQL Server 2014'
			WHEN '13.0' THEN 'SQL Server 2016'
			WHEN '14.0' THEN 'SQL Server 2017'
			ELSE 'Newer than SQL Server 2017'
		END AS [Version Build],
    SERVERPROPERTY('ProductVersion') AS [Product Version],
    SERVERPROPERTY('ProductUpdateLevel') AS [CU]