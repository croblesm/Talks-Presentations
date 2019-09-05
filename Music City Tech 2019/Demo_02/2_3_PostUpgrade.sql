--------------------------------------------------------------------------------- 
-- Get SQL Server Instance and OS Level Details, databases and datafiles
---------------------------------------------------------------------------------
-- Look for WWI database
SELECT name FROM sys.databases;

-- Check SQL Server version --14.0.3076.1 = CU14
SELECT
    SERVERPROPERTY('ServerName') AS [Instance Name],
    SERVERPROPERTY('ProductVersion') AS [Product Version],
    RIGHT(@@version, LEN(@@version)- 3 -charindex (' ON ', @@VERSION)) [OS Version],
    SERVERPROPERTY ('Edition') AS [Edition];