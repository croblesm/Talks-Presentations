--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 3- SQL Server instance properties
---------------------------------------------------------------------------------

-- Getting backup metadata
DECLARE @BackupPath NVARCHAR(256)
EXEC master.dbo.xp_instance_regread 
        N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer',N'BackupDirectory', 
        @BackupPath OUTPUT

-- Getting information all together
SELECT 
    SERVERPROPERTY('MachineName') InstanceName
    ,CASE LEFT(CONVERT(VARCHAR, SERVERPROPERTY('ProductVersion')),4) 
        WHEN '14.0' THEN 'SQL Server 2017'
        ELSE 'Newer than SQL Server 2017'
    END AS Version
    ,SERVERPROPERTY('ProductVersion') Build
    ,SERVERPROPERTY('ProductUpdateLevel') CU
    ,SERVERPROPERTY ('Edition') AS Edition
    ,SERVERPROPERTY('InstanceDefaultDataPath') DataPath
    ,SERVERPROPERTY('InstanceDefaultLogPath') LogPath
    ,@BackupPath BackupPath;

-- Checking SQL Server services status
SELECT servicename ServiceName, status_desc Status from sys.dm_server_services;