-- Enabling QS for demo DBs and clearing old QS data
USE master
GO
ALTER DATABASE [WideWorldImporters] SET QUERY_STORE = ON;
ALTER DATABASE [WideWorldImporters] SET QUERY_STORE CLEAR;
ALTER DATABASE [AdventureWorks2016] SET QUERY_STORE = ON;
ALTER DATABASE [AdventureWorks2016] SET QUERY_STORE CLEAR;
GO

ALTER DATABASE [WideWorldImporters] SET QUERY_STORE (
--ALTER DATABASE [AdventureWorks2016] SET QUERY_STORE (

	--READ_ONLY (No new data)
	--READ_WRITE (Default)
	OPERATION_MODE = READ_WRITE, 
	
	--ALL:	Capture all queries executed (Default for SQL Server 2016+)
	--AUTO:	Ignore infrequence and queries with low compile and execution duration, only relevant queries (Default for Azure SQL DB)
	--NONE:	Stop capturing new queries
	QUERY_CAPTURE_MODE = AUTO,   

	--Default 100 MBs
	MAX_STORAGE_SIZE_MB = 2048,

	--AUTO:	Cleanup automatically activated when total amount of data gets close to maximum size (90%).
	--OFF:	No cleanup
	SIZE_BASED_CLEANUP_MODE = AUTO,

	--Default 15 minutes for SQL Server 2016+ and Azure SQL DB
	DATA_FLUSH_INTERVAL_SECONDS = 60,

	--Fixed values:	1, 5, 10, 15, 30, 60, 1440 minutes, this is the statistics agreggation interval
	--The lower the value the more granular the analysis can be
	INTERVAL_LENGTH_MINUTES = 5
	);
GO