--------------------------------------------------------------------------------- 
-- DEMO 2 --
-- 5_1 Execute some queries
---------------------------------------------------------------------------------

USE HumanResources;
GO

--Update countries
BEGIN TRANSACTION

UPDATE dbo.Locations SET street_address='2014-16 Jabberwocky Rd'
WHERE location_id = 1400;
GO