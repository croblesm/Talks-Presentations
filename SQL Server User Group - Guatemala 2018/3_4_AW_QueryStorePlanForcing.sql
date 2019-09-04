USE AdventureWorks2016
GO

--Force Plan
EXEC sp_query_store_force_plan @query_id = XX, @plan_id = XX;

/*
--Unforce Plan
EXEC sp_query_store_unforce_plan @query_id = XX, @plan_id = XX; */

--Verify Plan from Top Resource consuming queries

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
WHERE p.query_id = XX;

--Run store procedure again
EXEC usp_getProductSales 897; --few rows
EXEC usp_getProductSales 870; --large rows
