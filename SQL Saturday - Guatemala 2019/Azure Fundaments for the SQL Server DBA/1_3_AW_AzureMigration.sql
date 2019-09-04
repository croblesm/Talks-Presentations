USE master
GO

--Getting number of cores
SELECT * FROM sys.dm_os_sys_info;

-- Killing all connections
DECLARE 
	@dbname VARCHAR(128) = 'AdventureWorks',
	@processid INT;

SELECT @processid = MIN(spid) FROM master.dbo.sysprocesses
WHERE   dbid = DB_ID(@dbname)

WHILE @processid IS NOT NULL 
    BEGIN
	EXEC ('KILL ' + @processid)
	SELECT @processid = MIN(spid) FROM master.dbo.sysprocesses
	WHERE   dbid = DB_ID(@dbname) AND spid > @processid
END

-- Setting database to read-only
ALTER DATABASE AdventureWorks SET READ_ONLY;