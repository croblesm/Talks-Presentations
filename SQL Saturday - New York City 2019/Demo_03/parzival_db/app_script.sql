--------------------------------------------------------------------------------- 
-- Create Human Resources database
---------------------------------------------------------------------------------

-- Create new database
USE master
GO
CREATE DATABASE HumanResources
GO

-- Create new tables
USE HumanResources
GO
CREATE TABLE HumanResources.dbo.Employee 
    (EmpID INT NOT NULL , 
        EmpName VARCHAR(50) NOT NULL, 
	    Designation VARCHAR(50) NULL, 
        Department VARCHAR(50) NULL, 
        JoiningDate DATETIME NULL,
	    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED (EmpID)
    )
GO
INSERT INTO HumanResources.dbo.Employee 
	(EmpID, EmpName, Designation, Department, JoiningDate)
VALUES 
	(1, 'CHIN YEN', 'LAB ASSISTANT', 'LAB', GETDATE()),
	(2, 'MIKE PEARL', 'SENIOR ACCOUNTANT', 'ACCOUNTS', GETDATE()),
	(3, 'GREEN FIELD', 'ACCOUNTANT', 'ACCOUNTS', GETDATE()),
	(4, 'DEWANE PAUL', 'PROGRAMMER', 'IT', GETDATE()),
	(5, 'MATTS', 'SR. PROGRAMMER', 'IT', GETDATE()),
	(6, 'PLANK OTO', 'ACCOUNTANT', 'ACCOUNTS', GETDATE())
GO

CREATE TABLE HumanResources.dbo.EmployeeDetails(
	[EmpID] [int] NULL,
	[EmpName] [varchar](50) NULL,
	[Mobile] [varchar](10) NULL,
	[PresentAddress] [varchar](100) NULL,
	[Area] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Qualification] [varchar](50) NULL,
	[Email] [varchar](50) NULL
) ON [PRIMARY]
GO

ALTER TABLE HumanResources.dbo.EmployeeDetails  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetails_Employee] 
    FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO

ALTER TABLE HumanResources.dbo.EmployeeDetails CHECK CONSTRAINT [FK_EmployeeDetails_Employee]
GO

INSERT INTO HumanResources.dbo.EmployeeDetails 
    (EmpID, EmpName, Mobile, PresentAddress, Area, City, Country, Qualification, Email)
VALUES
    (1, 'CHIN YEN', '1234567879', '1 MAIN AVE', 'WA', 'TACOCA', 'USA', 'GRADUATE','chinxyz@emp.com'),
    (2, 'MIKE PEARL', '2152313213', 'B BLOCK NICE STREET', 'WENEN', 'TACOCA', 'SCODD', 'GRADUATE', 'mike230@emample.com'),
    (3, 'GREEN FIELD', '4517825469', 'UNIVERSAL NEW AVE', 'BOURNNILE', 'BRISDON', 'NEW START', 'MANAGEMENT','greenden3939@emample.com'),
    (4, 'DEWANE PAUL', '5741115523', 'SPACE, 1 OF 1', 'ANDALUSIAN', 'PARALLEL', 'NEW RIVER', 'MATHEMATICS','dpaul_lime44@emample.com'),
    (5, 'MATTS', '4755#55522', 'NOT KNOWN', 'WOODOO', 'COMMONS', 'UNITED KINGDOM', 'ADVANCE PHYSICS','matts-ino33@emample.com'),
    (6, 'PLANK OTO', '5124785452', 'TUCSON, AZ MSA', 'ALPINE', 'ARIZONA', 'USA', 'DIPLOMA IN FINANCE','plaoto_nk984@emample.com')
GO