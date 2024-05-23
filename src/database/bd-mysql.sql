-- Create Brands table
CREATE TABLE Brands (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_Brands_Name ON Brands(Name);

-- Create CarCategories table
CREATE TABLE CarCategories (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_CarCategories_Name ON CarCategories(Name);

-- Create States table
CREATE TABLE States (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_States_Name ON States(Name);

-- Create Cars table
CREATE TABLE Cars (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    PriceHour DECIMAL(18, 2) NOT NULL,
    Stock FLOAT NOT NULL,
    Model INT NOT NULL,
    LicensePlate VARCHAR(6) NOT NULL,
    BrandId INT NOT NULL,
    CarCategoryId INT NOT NULL,
    CONSTRAINT FK_Cars_Brands FOREIGN KEY (BrandId) REFERENCES Brands(Id) ON DELETE RESTRICT,
    CONSTRAINT FK_Cars_CarCategories FOREIGN KEY (CarCategoryId) REFERENCES CarCategories(Id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_Cars_LicensePlate ON Cars(LicensePlate);
CREATE INDEX IX_Cars_BrandId ON Cars(BrandId);
CREATE INDEX IX_Cars_CarCategoryId ON Cars(CarCategoryId);

-- Create Cities table
CREATE TABLE Cities (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    StateId INT NOT NULL,
    CONSTRAINT FK_Cities_States FOREIGN KEY (StateId) REFERENCES States(Id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_Cities_StateId_Name ON Cities(StateId, Name);

-- Create CarImages table
CREATE TABLE CarImages (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    CarId INT NOT NULL,
    Image TEXT NOT NULL,
    CONSTRAINT FK_CarImages_Cars FOREIGN KEY (CarId) REFERENCES Cars(Id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE INDEX IX_CarImages_CarId ON CarImages(CarId);

-- Create Users table
CREATE TABLE Users (
    Id VARCHAR(450) NOT NULL PRIMARY KEY,
    Document VARCHAR(200) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(200) NOT NULL,
    Password VARCHAR(200) NOT NULL,
    Phone VARCHAR(200) NOT NULL,
    Photo TEXT,
    UserType INT NOT NULL,
    CityId INT NOT NULL,
    UserName TEXT,
    NormalizedUserName TEXT,
    NormalizedEmail TEXT,
    EmailConfirmed TINYINT(1) NOT NULL,
    PasswordHash TEXT,
    SecurityStamp TEXT,
    ConcurrencyStamp TEXT,
    PhoneNumber TEXT,
    PhoneNumberConfirmed TINYINT(1) NOT NULL,
    TwoFactorEnabled TINYINT(1) NOT NULL,
    LockoutEnd DATETIME,
    LockoutEnabled TINYINT(1) NOT NULL,
    AccessFailedCount INT NOT NULL,
    CONSTRAINT FK_Users_Cities FOREIGN KEY (CityId) REFERENCES Cities(Id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE UNIQUE INDEX IX_Users_Document ON Users(Document);
CREATE INDEX IX_Users_CityId ON Users(CityId);

-- Create Rents table
CREATE TABLE Rents (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    UserId1 VARCHAR(450),
    UserId INT NOT NULL,
    CarId INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    RealEndDate DATETIME NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    RentStatus INT NOT NULL,
    Remarks TEXT,
    CONSTRAINT FK_Rents_Cars FOREIGN KEY (CarId) REFERENCES Cars(Id) ON DELETE RESTRICT,
    CONSTRAINT FK_Rents_Users FOREIGN KEY (UserId1) REFERENCES Users(Id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE INDEX IX_Rents_CarId ON Rents(CarId);
CREATE UNIQUE INDEX IX_Rents_Id ON Rents(Id);
CREATE INDEX IX_Rents_UserId1 ON Rents(UserId1);
