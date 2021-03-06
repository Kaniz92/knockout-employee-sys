﻿/*
Deployment script for OrganizationEmployeeData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "OrganizationEmployeeData"
:setvar DefaultFilePrefix "OrganizationEmployeeData"
:setvar DefaultDataPath "C:\Users\Gayat\AppData\Local\Microsoft\VisualStudio\SSDT\OrganizationEmployeeData\"
:setvar DefaultLogPath "C:\Users\Gayat\AppData\Local\Microsoft\VisualStudio\SSDT\OrganizationEmployeeData\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[Department]...';


GO
CREATE TABLE [dbo].[Department] (
    [DepartmentID] INT           IDENTITY (1, 1) NOT NULL,
    [Title]        NVARCHAR (50) NULL,
    [Credits]      INT           NULL,
    PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);


GO
PRINT N'Creating [dbo].[Employee]...';


GO
CREATE TABLE [dbo].[Employee] (
    [EmployeeID]  INT           IDENTITY (1, 1) NOT NULL,
    [LastName]    NVARCHAR (50) NULL,
    [FirstName]   NVARCHAR (50) NULL,
    [JoiningDate] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);


GO
PRINT N'Creating [dbo].[Enrollment]...';


GO
CREATE TABLE [dbo].[Enrollment] (
    [EnrollmentID] INT            IDENTITY (1, 1) NOT NULL,
    [Band]         DECIMAL (3, 2) NULL,
    [DepartmentID] INT            NOT NULL,
    [EmployeeID]   INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([EnrollmentID] ASC)
);


GO
PRINT N'Creating FK_dbo.Enrollment_dbo.Department_DepartmentID...';


GO
ALTER TABLE [dbo].[Enrollment] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.Enrollment_dbo.Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_dbo.Enrollment_dbo.Employee_EmployeeID...';


GO
ALTER TABLE [dbo].[Enrollment] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.Enrollment_dbo.Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]) ON DELETE CASCADE;


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
MERGE INTO Department AS Target 
USING (VALUES 
        (1, 'Microsoft', 3), 
        (2, 'Java', 3), 
        (3, 'Php', 4)
) 
AS Source (DepartmentID, Title, Credits) 
ON Target.DepartmentID = Source.DepartmentID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (Title, Credits) 
VALUES (Title, Credits);


MERGE INTO Employee AS Target
USING (VALUES 
        (1, 'Ark', 'Roop', '2013-09-01'), 
        (2, 'Akash', 'Gupta', '2012-01-13'), 
	(3, 'Saurabh', 'Gupta', '2011-09-03')
)
AS Source (EmployeeID, LastName, FirstName, JoiningDate)
ON Target.EmployeeID = Source.EmployeeID
WHEN NOT MATCHED BY TARGET THEN
INSERT (LastName, FirstName, JoiningDate)
VALUES (LastName, FirstName, JoiningDate);


MERGE INTO Enrollment AS Target
USING (VALUES 
	(1, 2.00, 1, 1),
	(2, 3.50, 1, 2),
	(3, 4.00, 2, 3),
	(4, 1.80, 2, 1),
	(5, 3.20, 3, 1),
	(6, 4.00, 3, 2)
)
AS Source (EnrollmentID, Band, DepartmentID, EmployeeID)
ON Target.EnrollmentID = Source.EnrollmentID
WHEN NOT MATCHED BY TARGET THEN
INSERT (Band, DepartmentID, EmployeeID)
VALUES (Band, DepartmentID, EmployeeID);
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Enrollment] WITH CHECK CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.Department_DepartmentID];

ALTER TABLE [dbo].[Enrollment] WITH CHECK CHECK CONSTRAINT [FK_dbo.Enrollment_dbo.Employee_EmployeeID];


GO
PRINT N'Update complete.';


GO
