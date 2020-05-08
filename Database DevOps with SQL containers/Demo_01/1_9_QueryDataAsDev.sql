--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 9- Query masked data as Dev team
---------------------------------------------------------------------------------
USE HumanResources;
GO

--Display current execution context before
SELECT SUSER_NAME() login_name, USER_NAME() user_name;

--Set execution context to "dev_team" login \ user
EXECUTE AS USER = 'dev_team';  

--Display current execution context after
SELECT SUSER_NAME() login_name, USER_NAME() user_name;

-- Returning employee and employee details data (masked)
SELECT TOP 4 *  FROM HumanResources.dbo.Employees;
SELECT TOP 4 * FROM HumanResources.dbo.Dependents;