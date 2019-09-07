--------------------------------------------------------------------------------- 
-- Get SQL Server Instance and OS Level Details, databases and datafiles
---------------------------------------------------------------------------------
-- Look for WWI database
SELECT name FROM sys.databases;

-- Check SQL Server version --14.0.3076.1 = CU14
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