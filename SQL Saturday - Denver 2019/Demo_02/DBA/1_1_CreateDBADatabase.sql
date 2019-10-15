--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 6- Create DBA Database
---------------------------------------------------------------------------------
SET NOCOUNT ON

-- Creating DBA database
USE master;
GO
IF DB_ID (N'DBA') IS NOT NULL
DROP DATABASE DBA;
GO
CREATE DATABASE DBA;

SELECT 'DBA Database succesfully created'