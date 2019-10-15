--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- Creating Development Login and mask sensitive data
---------------------------------------------------------------------------------

SET NOCOUNT ON

-- Creating login for development team
USE master
GO
CREATE LOGIN dev_team WITH PASSWORD=N'123_D3v3L0pM3nt', DEFAULT_DATABASE=HumanResources, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

-- Creating user for login in Human Resources database
USE HumanResources
CREATE USER dev_team FOR LOGIN dev_team;
ALTER ROLE db_datareader ADD MEMBER dev_team;

SELECT 'Logins succesfully created'

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

SELECT 'Data has been masked'