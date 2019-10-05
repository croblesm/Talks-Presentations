--------------------------------------------------------------------------------- 
-- Create Human Resources database
---------------------------------------------------------------------------------

-- Create new database
USE master
GO
CREATE DATABASE TARS
GO

-- Create new tables
USE TARS
GO
CREATE TABLE TARS.dbo.Robot
    (RobotID INT NOT NULL , 
        RobotName VARCHAR(50) NOT NULL, 
	    Designation VARCHAR(50) NULL, 
        Location VARCHAR(50) NULL, 
        JoiningDate DATETIME NULL,
	    CONSTRAINT [PK_Robot] PRIMARY KEY CLUSTERED (RobotID)
    )
GO
INSERT INTO TARS.dbo.Robot
	(RobotID, RobotName, Designation, Location, JoiningDate)
VALUES 
	(1, 'TARS', 'LAB ASSISTANT', 'HOUSTON', GETDATE()),
	(2, 'PLEX', 'PILOT', 'HOUSTON', GETDATE())
GO