CREATE TABLE [dbo].[Enrollment]
(
	[EnrollmentID] INT NOT NULL IDENTITY(1,1),
	[Band] DECIMAL(3,2) NULL,
	[DepartmentID] int not null,
	[EmployeeID] int not null,
	primary key clustered([EnrollmentID] ASC),
	constraint [FK_dbo.Enrollment_dbo.Department_DepartmentID] FOREIGN KEY ([DepartmentID])
		references [dbo].[Department]([DepartmentID]) on delete cascade,
	constraint [FK_dbo.Enrollment_dbo.Employee_EmployeeID] foreign key ([EmployeeID])
		references [dbo].[Employee]([EmployeeID]) on delete cascade
)
