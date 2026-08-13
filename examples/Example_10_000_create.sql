CREATE TABLE Customers (
    CustomerId INT GENERATED ALWAYS AS IDENTITY,
    CustomerName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CustomerId)
);

CREATE TABLE Employees (
    EmployeeId INT GENERATED ALWAYS AS IDENTITY,
    EmployeeName VARCHAR(255) NOT NULL,
    PRIMARY KEY (EmployeeId)
);

CREATE TABLE SoftwareProducts (
    SoftwareProductId INT GENERATED ALWAYS AS IDENTITY,
    SoftwareProductName VARCHAR(255) NOT NULL,
    PRIMARY KEY (SoftwareProductId)
);

CREATE TABLE Orders (
    OrderId INT GENERATED ALWAYS AS IDENTITY,
    OrderTestName VARCHAR(255) NOT NULL,
    CustomerId INT NOT NULL,
    EmployeeId INT NOT NULL,
    PRIMARY KEY (OrderId),
    CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    CONSTRAINT FK_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);

CREATE TABLE OrderItems (
    OrderItemId INT GENERATED ALWAYS AS IDENTITY,
    OrderId INT NOT NULL,
    SoftwareProductId INT NOT NULL,
    Quantity INT NOT NULL,
    SortOrder INT NOT NULL,
    PRIMARY KEY (OrderItemId),
    CONSTRAINT FK_OrderId FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_SoftwareProductId FOREIGN KEY (SoftwareProductId) REFERENCES SoftwareProducts(SoftwareProductId)
);
