--------------------------------------------------------------------------------- 
-- Restore Wide World Importers in SQL Server CU15 container
---------------------------------------------------------------------------------

-- Restore WWI
RESTORE DATABASE WWI FROM DISK = '/Shared/wwi.bak' WITH
MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf',
MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImporters_userdata.ndf',
MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf', 
MOVE 'WWI_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1';

-- Look for WWI database
SELECT name FROM sys.databases;

-- Check SQL Server version 14.0.3162.1 = CU15
SELECT
    SERVERPROPERTY('ServerName') AS [Instance Name],
    SERVERPROPERTY('ProductVersion') AS [Product Version],
    SERVERPROPERTY('ProductUpdateLevel') AS [CU],
    RIGHT(@@version, LEN(@@version)- 3 -charindex (' ON ', @@VERSION)) [OS Version],
    SERVERPROPERTY ('Edition') AS [Edition];