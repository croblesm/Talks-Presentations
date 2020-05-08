--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- 8- Creating Login and masking personal data
---------------------------------------------------------------------------------

-- Creating login for development team
USE master
GO
CREATE LOGIN dev_team WITH PASSWORD=N'_D3v3L0pM3nt_',
DEFAULT_DATABASE=HumanResources, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
EXEC sp_addsrvrolemember 'dev_team', 'processadmin';  
GRANT VIEW SERVER STATE TO dev_team;

-- Creating user for login with read-only access in Human Resources database
USE HumanResources
CREATE USER dev_team FOR LOGIN dev_team;
ALTER ROLE db_datareader ADD MEMBER dev_team;
ALTER ROLE db_datawriter ADD MEMBER dev_team;
ALTER ROLE db_ddladmin ADD MEMBER dev_team;
ALTER ROLE db_backupoperator ADD MEMBER dev_team;

-- ***** Masking data using Dynamic data masking ***** 
--
-- ***** Employees data *****
-- First name
ALTER TABLE HumanResources.dbo.Employees  
ALTER COLUMN first_name ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",2)');  

-- Last name
ALTER TABLE HumanResources.dbo.Employees  
ALTER COLUMN last_name ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",2)');  

-- Salary
ALTER TABLE HumanResources.dbo.Employees  
ALTER COLUMN salary ADD MASKED WITH (FUNCTION = 'random(1, 12)');  

-- Email
ALTER TABLE HumanResources.dbo.Employees  
ALTER COLUMN email ADD MASKED WITH (FUNCTION = 'email()');

-- Phone number
ALTER TABLE HumanResources.dbo.Employees  
ALTER COLUMN phone_number ADD MASKED WITH (FUNCTION = 'partial(1,"XXX",1)');

-- ***** Dependents data *****
-- First name
ALTER TABLE HumanResources.dbo.Dependents  
ALTER COLUMN first_name ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",2)');  

-- Last name
ALTER TABLE HumanResources.dbo.Dependents  
ALTER COLUMN last_name ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",2)');