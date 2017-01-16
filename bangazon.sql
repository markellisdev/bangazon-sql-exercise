DELETE FROM OrdersByProduct;
DELETE FROM Product;
DELETE FROM Orders;
DELETE FROM Customer;
DELETE FROM Computer;
DELETE FROM EmployeeInTraining;
DELETE FROM Employee;
DELETE FROM PaymentType;
DELETE FROM ProductType;
DELETE FROM OperatingSystem;
DELETE FROM TrainingProgram;
DELETE FROM JobTitle;
DELETE FROM Department;


DROP TABLE IF EXISTS EmployeeInTraining;
DROP TABLE IF EXISTS TrainingProgram;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS JobTitle;
DROP TABLE IF EXISTS OperatingSystem;
DROP TABLE IF EXISTS Computer;
DROP TABLE IF EXISTS PaymentType;
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
    'Budget' TEXT NOT NULL
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
    'InCommision' BOOLEAN NOT NULL,
    'OperatingSystemId' INTEGER NOT NULL,
    'EmployeeId' INTEGER NOT NULL,
    'DepartmentId' INTEGER NOT NULL,
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

CREATE TABLE 'Customer' (
    'CustomerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'FirstName' TEXT NOT NULL,
    'LastName' TEXT NOT NULL,
    'DateCreated' DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    'Active' BOOLEAN NOT NULL,
    'InactiveDate' TEXT NOT NULL
);

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

CREATE TABLE 'Orders' (
    'OrderId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'CustomerId' INTEGER NOT NULL,
        FOREIGN KEY('CustomerId') REFERENCES 'Customer'('CustomerId')
);

CREATE TABLE 'OrdersByProduct' (
    'OrdersByProductId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'OrderId' INTEGER NOT NULL,
    'ProductId' INTEGER NOT NULL,
    'PaymentTypeId' INTEGER NOT NULL,
        FOREIGN KEY('OrderId') REFERENCES 'Orders'('OrderId'),
        FOREIGN KEY('ProductId') REFERENCES 'Product' ('ProductId'),
        FOREIGN KEY('PaymentTypeId') REFERENCES 'PaymentType'('PaymentTypeId')
);

CREATE TABLE 'PaymentType' (
    'PaymentTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'TypeName' TEXT NOT NULL
);

INSERT INTO PaymentType VALUES (null, 'CreditCard');
INSERT INTO PaymentType VALUES (null, 'Check');
INSERT INTO PaymentType VALUES (null, 'Cash');


INSERT INTO JobTitle VALUES (null, 'Supervisor');
INSERT INTO JobTitle VALUES (null, 'PersonalAssistant');

INSERT INTO Department VALUES (null, 'Sales', 200000);
INSERT INTO Department VALUES (null, 'Marketing', 200000);
INSERT INTO Department VALUES (null, 'ProductEngineering', 400000);
INSERT INTO Department VALUES (null, 'Operations', 300000);
INSERT INTO Department VALUES (null, 'Support', 100000);

INSERT INTO Employee VALUES (null, 'Jami', 'Jackson', 'MarketingDirector', 2, 1);
INSERT INTO Employee VALUES (null, 'Wim', 'Hof', 'HRDirector', 4, 1);
INSERT INTO Employee VALUES (null, 'Steve', 'Brownlee', 'SoftwareEngineer', 3, 1);
INSERT INTO Employee VALUES (null, 'Mary', 'Woodson', 'PersonalAssistant', 4, 2);

INSERT INTO OperatingSystem VALUES (null, 'Windows');
INSERT INTO OperatingSystem VALUES (null, 'MacOS');
INSERT INTO OperatingSystem VALUES (null, 'Linux');

-- Original insert where date format is not correct
-- INSERT INTO Computer VALUES (null, '20170101', 'nil', 1, 1, 1, 2);
-- INSERT INTO Computer VALUES (null, '20170102', 'nil', 1, 2, 2, 4);
-- INSERT INTO Computer VALUES (null, '20170103', 'nil', 1, 2, 3, 3);

-- Used the following update after putting date values in without proper format xxxx-xx-xx(year, month, day)
INSERT OR REPLACE INTO Computer VALUES (1, '2017-01-01', 'nil', 1, 1, 1, 2);
INSERT OR REPLACE INTO Computer VALUES (2, '2017-01-02', 'nil', 1, 2, 2, 4);
INSERT OR REPLACE INTO Computer VALUES (3, '2017-01-03', 'nil', 1, 2, 3, 3);

INSERT INTO ProductType VALUES (null, 'Clothing');
INSERT INTO ProductType VALUES (null, 'Electronics');
INSERT INTO ProductType VALUES (null, 'HealthAndPersonalCare');
INSERT INTO ProductType VALUES (null, 'Jewelry');
INSERT INTO ProductType VALUES (null, 'Automotive');

INSERT INTO Customer VALUES (null, 'Jim', 'Jensen', '2017-01-03', 1, 'nil');
INSERT OR REPLACE INTO Customer VALUES (2, 'Mary', 'Swanson', CURRENT_TIMESTAMP, 1, 'nil');
INSERT OR REPLACE INTO Customer VALUES (3, 'Fred', 'Gamble', '2017-01-01', 1, 'nil');
INSERT INTO Customer VALUES (null, 'Tim', 'Lewis', 2016-01-01, 0, CURRENT_TIMESTAMP);

INSERT INTO Product VALUES (null, 'PA9000', 980, 'The Personal Assistant 9000 can help you with all of your everyday tasks. Just speak your commands and the PA9000 will complete all tasks while you focus on your day.', 2, 2);
INSERT INTO Product VALUES (null, 'PeppermintSoap', 12, 'This peppermint soap was handmade in our Vermont home with only natural ingredients and essential oils.', 3, 1);
INSERT INTO Product VALUES (null, 'TMNTShirt', 19, 'This teenage mutant ninja turtles shirt is just what your child has been looking for.', 1, 1);
INSERT INTO Product VALUES (null, 'TeaTreeOilToothpaste', 9, 'This Tea Tree Oil toothpaste is handmade with love and care.', 3, 1);
INSERT INTO Product VALUES (null, 'CharmBracelet', 29, 'Beautiful charm bracelet with one owl charm. Other charms sold separately', 4, 3);
INSERT INTO Product VALUES (null, 'WheelBrushSet', 16, 'This set of 3 wheel brushes will help keep your wheels and tires looking new', 5, 1);

INSERT INTO Orders VALUES (null, 2);
INSERT INTO Orders VALUES (null, 3);
INSERT INTO Orders VALUES (null, 1);

INSERT INTO OrdersByProduct VALUES (null, 2, 3, 3);
INSERT INTO OrdersByProduct VALUES (null, 2, 6, 3);
INSERT INTO OrdersByProduct VALUES (null, 1, 5, 1);
INSERT INTO OrdersByProduct VALUES (null, 1, 4, 1);
INSERT INTO OrdersByProduct VALUES (null, 1, 2, 1);
INSERT INTO OrdersByProduct VALUES (null, 3, 1, 2);