USE AdventureWorks2016
GO

SET STATISTICS IO ON
EXEC usp_getProductSales 897; --few rows
EXEC usp_getProductSales 870; --large rows

SELECT st.TEXT
	,qs.creation_time
	,qs.last_execution_time
	,qs.execution_count
	,qs.last_logical_reads
	,qs.last_logical_writes
	,qs.last_physical_reads
	,qs.sql_handle
FROM sys.dm_exec_query_stats AS qs
	CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
	CROSS APPLY sys.dm_exec_text_query_plan(qs.plan_handle, DEFAULT, DEFAULT) AS qp
WHERE qp.dbid = DB_ID(DB_NAME())
	AND st.TEXT LIKE '%usp_getProductSales%' ---filter by name of the SP

--Remove query plan from cache
--DBCC FREEPROCCACHE (0x03000500DD931004301D1E0105A9000001000000000000000000000000000000000000000000000000000000)

--Force Plan
EXEC sp_query_store_force_plan @query_id = 52, @plan_id = 8;

--Unforce Plan
EXEC sp_query_store_unforce_plan @query_id = 263, @plan_id = 274;
--Verify Plan from tracked queries

--Run store procedure again
EXEC usp_getProductSales 897; --few rows
EXEC usp_getProductSales 870; --large rows

-- Check status of forced plan
SELECT 
	p.plan_id, 
	p.query_id, 
    ISNULL(OBJECT_NAME(q.object_id), 'Ad-Hoc') [object_name],
    p.force_failure_count, 
	p.last_force_failure_reason_desc
FROM sys.query_store_plan AS p
JOIN sys.query_store_query AS Q
	ON p.query_id = q.query_id
WHERE p.query_id = 52;