--------------------------------------------------------------------------------- 
-- Get SQL Server Instance properties
---------------------------------------------------------------------------------
SELECT 
    SERVERPROPERTY('InstanceDefaultDataPath') DefaultDataPath
    ,SERVERPROPERTY('InstanceDefaultLogPath') DefaultLogPath
    ,SERVERPROPERTY('ProductUpdateLevel') CU
    ,SERVERPROPERTY('ProductMajorVersion') SQLVersion
    ,SERVERPROPERTY('ProductBuild') ProductBuild
    ,SERVERPROPERTY ('IsHadrEnabled') HADREnabled;

-- Check SQL Server services
SELECT servicename ServiceName, status_desc status from sys.dm_server_services;