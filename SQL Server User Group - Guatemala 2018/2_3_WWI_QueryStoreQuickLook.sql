USE WideWorldImporters
GO
SELECT 'Query Store Configuration' as ReportName;
-- Checks the most important QS settings
SELECT 
	actual_state_desc, -- For more information ⟶ https://goo.gl/iXec4C
	readonly_reason = 
		CASE
			WHEN readonly_reason = 1 THEN 'Database in read-only mode'
			WHEN readonly_reason = 2 THEN 'Database in single-user mode'
			WHEN readonly_reason = 4 THEN 'Database in emergency mode'
			WHEN readonly_reason = 8 THEN 'Database is secondary replica'
			WHEN readonly_reason = 65536 THEN 'Query Store has reached the size limit set by the MAX_STORAGE_SIZE_MB option'
			WHEN readonly_reason = 131072 THEN 'The number of different statements in Query Store has reached the internal memory limit'
			WHEN readonly_reason = 262144 THEN 'Size of in-memory items waiting to be persisted on disk has reached the internal memory limit'
			WHEN readonly_reason = 524288 THEN 'User database has reached disk size limit'
			ELSE 'N\A'
		END,
    current_storage_size_mb, 
	max_storage_size_mb,
	interval_length_minutes,
	flush_interval_seconds,
	size_based_cleanup_mode_desc
FROM sys.database_query_store_options;  

SELECT 'Top long running queries during last hour (25)' as ReportName;
-- Show the TOP 25 long running queries during the last hour
SELECT 
    qst.query_text_id,
	qsq.query_id,  
	qsp.plan_id,
	ISNULL(OBJECT_NAME(qsq.object_id), 'Ad-Hoc') [object_name],
	qst.query_sql_text,
	ROUND(rs.avg_duration/1000000,2) avg_duration_seconds,
	DATEADD(MINUTE, DATEDIFF(MINUTE, GETUTCDATE(), rs.last_execution_time), GETDATE()) AS last_execution_time,
	try_convert(xml,qsp.query_plan) as query_plan
FROM sys.query_store_query qsq 
JOIN sys.query_store_query_text qst
	ON qsq.query_text_id = qst.query_text_id
JOIN sys.query_store_plan qsp 
	ON qsq.query_id = qsp.query_id
JOIN sys.query_store_runtime_stats rs 
	ON qsp.plan_id = rs.plan_id 
WHERE rs.last_execution_time > DATEADD(hour, -1, GETUTCDATE())  
ORDER BY rs.avg_duration DESC;  
GO
