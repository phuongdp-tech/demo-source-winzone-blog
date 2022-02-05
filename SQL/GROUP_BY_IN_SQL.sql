USE [master]
GO
IF DB_ID('GROUP_BY_IN_SQL') IS NOT NULL
   DROP DATABASE GROUP_BY_IN_SQL
GO
CREATE DATABASE GROUP_BY_IN_SQL
GO
USE GROUP_BY_IN_SQL

GO
CREATE TABLE Employees
(
    EmployeeID			INT						IDENTITY(1, 1),
    FullName			NVARCHAR(100)           NOT NULL,
    Email			    VARCHAR(100)            NOT NULL,
	[Level]				CHAR(10)                NOT NULL,
    [Status]			CHAR(20)                NOT NULL

	CONSTRAINT	PK_Employee_EmpNo				PRIMARY KEY	(EmployeeID),
	CONSTRAINT	CHK_Employee_Level				CHECK		([Level] IN ('Fresher', 'Junior', 'Senior')),
	CONSTRAINT	CHK_Employee_Status				CHECK		([Status] IN ('Working', 'Unpaid Leave', 'Out')),
	CONSTRAINT	UQ_Employee_Email				UNIQUE		(Email)
)
GO
INSERT INTO Employees(FullName, Email, [Level], [Status])
VALUES
('Ken Sánchez', 'ken@test.com', 'Fresher', 'Working'),
('Brian Welcker', 'brian@test.com', 'Junior', 'Working'),
('Stephen Jiang', 'stephen@test.com', 'Senior', 'Working'),
('Linda Mitchell', 'linda@test.com', 'Senior', 'Out'),
('Michael Blythe', 'michael@test.com', 'Junior', 'Unpaid Leave'),
('Syed Abbas', 'syed@test.com', 'Fresher', 'Working'),
('Lynn Tsoflias', 'lynn@test.com', 'Fresher', 'Working'),
('David Bradley', 'david@test.com', 'Junior', 'Working'),
('Mary Gibson', 'mary@test.com', 'Senior', 'Unpaid Leave'),
('Clever', 'clever@test.com', 'Senior', 'Working');

-- [Q.1]
SELECT [Level], Count(1) AS TotalEmployee
FROM Employees
GROUP BY [Level]

-- [Q.2]
SELECT [Level], Count(1) AS TotalEmployee
FROM Employees
WHERE [Status] = 'Working'
GROUP BY [Level]

-- [Q.3]
SELECT [Level], Count(1) AS TotalEmployee
FROM Employees
GROUP BY [Level]
HAVING COUNT(1) >= 4

-- [Q.4] a
SELECT [Level], Count(1) AS TotalEmployee
FROM Employees
WHERE [Level] = 'Fresher'
GROUP BY [Level]

-- [Q.4] b
SELECT [Level], Count(1) AS TotalEmployee
FROM Employees
GROUP BY [Level]
HAVING [Level] = 'Fresher'

-- [Q.5]
SELECT Level, Count(1) AS TotalEmployee
FROM Employees
WHERE Status = 'Working'
GROUP BY Level
HAVING COUNT(1) > 2
