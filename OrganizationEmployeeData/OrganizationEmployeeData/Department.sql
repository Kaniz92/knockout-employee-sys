CREATE TABLE [dbo].[Department]
(
	[DepartmentID] INT NOT NULL IDENTITY(1,1),
	[Title] NVARCHAR(50) NULL,
	[Credits] INT NULL,
	PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
)
