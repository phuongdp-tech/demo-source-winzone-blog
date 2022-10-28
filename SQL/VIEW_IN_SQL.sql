USE [master]
GO
IF DB_ID('winzonevn_view_demo') IS NOT NULL
   DROP DATABASE winzonevn_view_demo
GO
CREATE DATABASE winzonevn_view_demo
GO
USE winzonevn_view_demo

GO
CREATE TABLE Department
(
    DepartmentNo		INT						IDENTITY(1, 1),
    DepartmentName		NVARCHAR(100)           NOT NULL,

	CONSTRAINT	PK_Department_DepartmentNo				PRIMARY KEY	(DepartmentNo)
)
GO
CREATE TABLE Employee
(
    EmployeeNo			INT						IDENTITY(1, 1),
    EmployeeName		NVARCHAR(100)           NOT NULL,
    Salary			    MONEY,
	DepartmentNo		INT

	CONSTRAINT	PK_Employee_EmployeeNo			PRIMARY KEY	(EmployeeNo),
    CONSTRAINT	FK_Employee_Department		    FOREIGN KEY (DepartmentNo) REFERENCES Department(DepartmentNo)
)
GO
INSERT INTO Department(DepartmentName) VALUES
('Marketing'), ('IT'), ('Sale')

GO
INSERT INTO Employee(EmployeeName, Salary, DepartmentNo) VALUES
('Adam', 1000, 3),
('Susan', 1100, 1),
('John', 900, 2)

-- 2.1.1 Tạo view truy xuất data từ 2 tables
GO
CREATE VIEW employee_with_department_view AS
SELECT E.EmployeeNo, E.EmployeeName, D.DepartmentName
FROM Employee E
INNER JOIN Department D ON E.DepartmentNo = D.DepartmentNo
GO

SELECT 
    EmployeeNo, EmployeeName, DepartmentName 
FROM 
    employee_with_department_view
GO

-- 2.1.2 Tạo view có CONSTRAINT
CREATE VIEW employee_view AS
SELECT E.EmployeeNo, E.EmployeeName, E.DepartmentNo
FROM Employee E
WHERE E.DepartmentNo = 1
WITH CHECK OPTION;
GO
SELECT 
    EmployeeNo, EmployeeName, DepartmentNo 
FROM 
    employee_view
GO
-- Query_01: Success
INSERT INTO employee_view(EmployeeName, DepartmentNo) VALUES
('Selena', 1)

-- Query_02: The attempted insert or update failed because the target view either specifies WITH CHECK OPTION ...
INSERT INTO employee_view(EmployeeName, DepartmentNo) VALUES
('Peter', 2)

-- 2.1.4 Tạo view có READ ONLY
GO
CREATE VIEW employee_view_read_only AS
SELECT E.EmployeeNo, E.EmployeeName, E.DepartmentNo
FROM Employee E
UNION ALL
SELECT NULL, NULL, NULL

GO
-- Query_03: Update or insert of view or function 'employee_view_read_only' failed because it contains a derived or constant field.
INSERT INTO employee_view_read_only(EmployeeName, DepartmentNo) VALUES ('David', 2)

-- 2.3 Alter View
GO
CREATE OR ALTER VIEW employee_view AS
SELECT E.EmployeeNo, E.EmployeeName
FROM Employee E
WHERE E.DepartmentNo = 1
WITH CHECK OPTION;
GO
