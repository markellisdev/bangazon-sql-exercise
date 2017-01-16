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

INSERT INTO JobTitle VALUES (null, 'Supervisor');
INSERT INTO JobTitle VALUES (null, 'PersonalAssistant');

CREATE TABLE 'Department' (
    'DepartmentId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'Budget' TEXT NOT NULL
);

INSERT INTO Department VALUES (null, 'Sales', 200000);
INSERT INTO Department VALUES (null, 'Marketing', 200000);
INSERT INTO Department VALUES (null, 'ProductEngineering', 400000);
INSERT INTO Department VALUES (null, 'Operations', 300000);
INSERT INTO Department VALUES (null, 'Support', 100000);


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

INSERT INTO Employee VALUES (null, 'Jami', 'Jackson', 'MarketingDirector', 2, 1);
INSERT INTO Employee VALUES (null, 'Wim', 'Hof', 'HRDirector', 4, 1);
INSERT INTO Employee VALUES (null, 'Steve', 'Brownlee', 'SoftwareEngineer', 3, 1);
INSERT INTO Employee VALUES (null, 'Mary', 'Woodson', 'PersonalAssistant', 4, 2);


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
    'InCommision' BOOLEAN NOT NULL,
    'OperatingSystemId' INTEGER NOT NULL,
    'EmployeeId' INTEGER NOT NULL,
    'DepartmentId' INTEGER NOT NULL,
        FOREIGN KEY('OperatingSystemId') REFERENCES 'OperatingSystem'('OperatingSystemId'),
        FOREIGN KEY('EmployeeId') REFERENCES 'Employee'('EmployeeId'),
        FOREIGN KEY('DepartmentId') REFERENCES 'Department'('DepartmentId')
);

INSERT INTO Computer VALUES (null, '20170101', 'nil', 1, 1, 1, 2);
INSERT INTO Computer VALUES (null, '20170102', 'nil', 1, 2, 2, 4);
INSERT INTO Computer VALUES (null, '20170103', 'nil', 1, 2, 3, 3);

CREATE TABLE 'OperatingSystem' (
    'OperatingSystemId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL
);

INSERT INTO OperatingSystem VALUES (null, 'Windows');
INSERT INTO OperatingSystem VALUES (null, 'MacOS');
INSERT INTO OperatingSystem VALUES (null, 'Linux');

CREATE TABLE 'ProductType' (
    'ProductTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'TypeName'
);

INSERT INTO ProductType VALUES (null, Workstation);
INSERT INTO ProductType VALUES (null, ServicePlan);
INSERT INTO ProductType VALUES (null, Parts);

CREATE TABLE 'Customer' (
    'CustomerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'FirstName' TEXT NOT NULL,
    'LastName' TEXT NOT NULL,
    'DateCreated' DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    'Active' BOOLEAN NOT NULL,
    'InactiveDate' TEXT NOT NULL
);

INSERT INTO Customer VALUES (null, 'Jim', 'Jensen', now, 1, 'nil');

CREATE TABLE 'Product' (
    'ProductId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'Price' INTEGER NOT NULL,
    'Description' TEXT NOT NULL,
    'ProductTypeId' INTEGER NOT NULL,
    'CustomerId' INTEGER NOT NULL,
        FOREIGN KEY('ProductTypeId') REFERENCES 'ProductType'('ProductTypeId'),
        FOREIGN KEY('CustomerId') REFERENCES 'Customer'('CustomerId')
);

INSERT INTO ProductType VALUES (null, PA9000, 9800, 'The Personal Assistant 9800 can help you with all of your everyday tasks. Just speak your commands and the PA9800 will complete all tasks while you focus on your day.', 1, 0);

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
