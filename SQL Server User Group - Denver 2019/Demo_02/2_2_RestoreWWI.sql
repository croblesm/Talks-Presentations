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
    SERVERPROPERTY('ProductVersion') AS [Product Version],
    RIGHT(@@version, LEN(@@version)- 3 -charindex (' ON ', @@VERSION)) [OS Version],
    SERVERPROPERTY ('Edition') AS [Edition]
FROM sys.dm_os_sys_info;