DELETE FROM EmployeeInTraining;
DELETE FROM TrainingProgram;
DELETE FROM Employee;
DELETE FROM Department;
DELETE FROM JobTitle;
DELETE FROM OperatingSystem;
DELETE FROM Computer;
DELETE FROM PaymentTypes;
DELETE FROM OrdersByProduct;
DELETE FROM Orders;
DELETE FROM Customer;
DELETE FROM ProductType;
DELETE FROM Product;

DROP TABLE IF EXISTS EmployeeInTraining;
DROP TABLE IF EXISTS TrainingProgram;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS JobTitle;
DROP TABLE IF EXISTS OperatingSystem;
DROP TABLE IF EXISTS Computer;
DROP TABLE IF EXISTS PaymentTypes;
DROP TABLE IF EXISTS OrdersByProduct;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS ProductType;
DROP TABLE IF EXISTS Product;

CREATE TABLE 'JobTitle' (
    'JobTitleId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Title' TEXT NOT NULL
);

CREATE TABLE 'Department' (
    'DepartmentId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'Budget' TEXT NOT NULL,
    'JobTitleId' INTEGER NOT NULL,
        FOREIGN KEY('JobTitleId') REFERENCES 'JobTitle'('JobTitleId')
);


CREATE TABLE 'Employee' (
    'EmployeeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'FirstName' TEXT NOT NULL,
    'LastName' TEXT NOT NULL,
    'Title' TEXT NOT NULL,
    'DepartmentId' INTEGER NOT NULL,
    'JobTitleId' INTEGER NOT NULL,
        FOREIGN KEY('DepartmentId') REFERENCES 'Department'('DepartmentId'),
        FOREIGN KEY('JobTitleId') REFERENCES 'JobTitle'('JobTitleId')
);

CREATE TABLE 'TrainingProgram' (
    'TrainingProgramId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'StartDate' TEXT NOT NULL,
    'EndDate' TEXT NOT NULL,
    'ClassSize' INTEGER NOT NULL
);

CREATE TABLE 'EmployeeInTraining' (
    'EmployeeInTrainingId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'EmployeeId' INTEGER NOT NULL,
    'TrainingProgramId' INTEGER NOT NULL,
        FOREIGN KEY('TrainingProgramId') REFERENCES 'TrainingProgram'('TrainingProgramId'),
        FOREIGN KEY('EmployeeId') REFERENCES 'Employee' ('EmployeeId')
);

CREATE TABLE 'Computer' (
    'ComputerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'CommisionedDate' TEXT NOT NULL,
    'DecommisionedDate' TEXT NOT NULL,
    'InCommision' BOOLEAN NOT NUll,
    'OperatingSystemId' TEXT NOT NULL,
    'EmployeeId' INTEGER NOT NULL,
    'DepartmentId' INTEGER NOT NUll,
        FOREIGN KEY('OperatingSystemId') REFERENCES 'OperatingSystem'('OperatingSystemId'),
        FOREIGN KEY('EmployeeId') REFERENCES 'Employee'('EmployeeId'),
        FOREIGN KEY('DepartmentId') REFERENCES 'Department'('DepartmentId')
);

CREATE TABLE 'OperatingSystem' (
    'OperatingSystemId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL
);

CREATE TABLE 'ProductType' (
    'ProductTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'TypeName'
);

CREATE TABLE 'Product' (
    'ProductId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'Price' TEXT NOT NULL,
    'Description' TEXT NOT NULL,
    'ProductTypeId' TEXT NOT NULL,
    'CustomerId' INTEGER NOT NULL,
        FOREIGN KEY('ProductTypeId') REFERENCES 'ProductType'('ProductTypeId'),
        FOREIGN KEY('CustomerId') REFERENCES 'Customer'('CustomerId')
);

CREATE TABLE 'Customer' (
    'CustomerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'FirstName' TEXT NOT NULL,
    'LastName' TEXT NOT NULL,
    'DateCreated' TEXT NOT NULL,
    'Active' BOOLEAN NOT NULL,
    'InactiveDate' TEXT NOT NULL
);

CREATE TABLE 'Orders' (
    'OrderId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'CustomerId' INTEGER NOT NULL,
        FOREIGN KEY('CustomerId') REFERENCES 'Customer'('CustomerId')
);

CREATE TABLE 'OrdersByProduct' (
    'OrdersByProductId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'OrderId' INTEGER NOT NULL,
    'ProductId' INTEGER NOT NULL,
        FOREIGN KEY('OrderId') REFERENCES 'Orders'('OrderId'),
        FOREIGN KEY('ProductId') REFERENCES 'Product' ('ProductId')
);

CREATE TABLE 'PaymentTypes' (
    'PaymentTypesId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'TypeName' TEXT NOT NULL,
    'OrderId' INTEGER NOT NULL,
        FOREIGN KEY('OrderId') REFERENCES 'Orders'('OrderId')
);
