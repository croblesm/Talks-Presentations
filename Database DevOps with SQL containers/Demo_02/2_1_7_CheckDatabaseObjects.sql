--------------------------------------------------------------------------------- 
-- DEMO 2 --
-- 7- Check database objects
---------------------------------------------------------------------------------
USE DBA;
GO

--Getting list of stored procedures
SELECT ROUTINE_NAME StoredProcedureName, ROUTINE_TYPE ObjectType 
FROM INFORMATION_SCHEMA.ROUTINES;

--Testing sp_WhoIsActive
EXEC sp_whoisactive @output_column_list = '[dd hh:mm:ss.mss][session_id]'