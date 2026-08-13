CREATE TABLE Customers (
    CustomerId INT GENERATED ALWAYS AS IDENTITY,
    CustomerNumber VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255),
    AddressLine1 VARCHAR(255) NOT NULL,
    AddressLine2 VARCHAR(255),
    AddressCity VARCHAR(255) NOT NULL,
    AddressState VARCHAR(2) NOT NULL,
    AddressZipCode VARCHAR(10) NOT NULL,
    DeliveryNotes VARCHAR(255),
    SignUpDate DATE NOT NULL,
    PRIMARY KEY (CustomerId)
);
