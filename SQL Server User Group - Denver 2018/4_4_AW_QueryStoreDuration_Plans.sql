-- Top 25 queries by avg duration
SELECT TOP 25 p.query_id query_id
	,q.object_id object_id
	,ISNULL(OBJECT_NAME(q.object_id), 'Ad-Hoc') object_name
	,qt.query_sql_text query_sql_text
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_duration * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 0.001, 2) avg_duration
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_cpu_time * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 0.001, 2) avg_cpu_time
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_logical_io_reads * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 8, 2) avg_logical_io_reads
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_logical_io_writes * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 8, 2) avg_logical_io_writes
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_physical_io_reads * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 8, 2) avg_physical_io_reads
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_dop * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 1, 0) avg_dop
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_query_max_used_memory * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 8, 2) avg_query_max_used_memory
	,ROUND(CONVERT(FLOAT, SUM(rs.avg_rowcount * rs.count_executions)) / NULLIF(SUM(rs.count_executions), 0) * 1, 0) avg_rowcount
	,SUM(rs.count_executions) count_executions
	,COUNT(DISTINCT p.plan_id) num_plans
FROM sys.query_store_runtime_stats rs
JOIN sys.query_store_plan p ON p.plan_id = rs.plan_id
JOIN sys.query_store_query q ON q.query_id = p.query_id
JOIN sys.query_store_query_text qt ON q.query_text_id = qt.query_text_id
WHERE rs.last_execution_time >= DATEADD(HOUR,-1,GETUTCDATE())
--WHERE NOT (
--		rs.first_execution_time > @Endtime
--		OR rs.last_execution_time < @Startime
--		)
GROUP BY p.query_id
	,qt.query_sql_text
	,q.object_id
HAVING COUNT(DISTINCT p.plan_id) >= 1
ORDER BY avg_duration DESC;

-- Queries with multiple plans
WITH QryMultPlans
AS (
	SELECT COUNT(*) num_plans
		,qsp.query_id
	FROM sys.query_store_plan qsp
	JOIN sys.query_store_runtime_stats rs ON qsp.plan_id = rs.plan_id
	WHERE rs.execution_type_desc = 'Regular'
		--AND NOT (
		--	rs.first_execution_time > @Endtime
		--	OR rs.last_execution_time < @Startime
		--	)
		AND rs.last_execution_time >= DATEADD(HOUR,-1,GETUTCDATE())
	GROUP BY query_id
	HAVING COUNT(DISTINCT qsp.plan_id) > 1
	)
SELECT q.query_id
	,ISNULL(object_name(object_id), 'Ad-Hoc') AS ContainingObject
	,query_sql_text
	,plan_id
	,try_convert(XML, p.query_plan) AS plan_xml
	,DATEADD(MINUTE, DATEDIFF(MINUTE, GETUTCDATE(), P.last_compile_start_time), GETDATE()) AS last_compile_start_time
	,DATEADD(MINUTE, DATEDIFF(MINUTE, GETUTCDATE(), p.last_execution_time), GETDATE()) AS last_execution_time
FROM QryMultPlans AS qm
JOIN sys.query_store_query AS q ON qm.query_id = q.query_id
JOIN sys.query_store_plan AS p ON q.query_id = p.query_id
JOIN sys.query_store_query_text qt ON qt.query_text_id = q.query_text_id
ORDER BY query_id, plan_id;