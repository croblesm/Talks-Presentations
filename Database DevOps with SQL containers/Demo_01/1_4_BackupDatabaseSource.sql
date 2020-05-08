--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 4- Backup database from source (Azure)
---------------------------------------------------------------------------------
-- Reference:
-- https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url?view=sql-server-2017
-- https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-best-practices-and-troubleshooting?view=sql-server-2017
-- https://docs.microsoft.com/en-us/sql/relational-databases/tutorial-sql-server-backup-and-restore-to-azure-blob-storage-service?view=sql-server-ver15&tabs=SSMS

--Backup database to URL (Azure BLOB)
USE master
GO
BACKUP DATABASE [HumanResources] TO  URL = 
N'https://dbamastery.blob.core.windows.net/sqlbackupfiles/hr_20200508_1000.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'HumanResources-Full Database Backup', 
NOSKIP, NOREWIND, NOUNLOAD,  STATS = 5
GO