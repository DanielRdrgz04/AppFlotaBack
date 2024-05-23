-- Create Brands table
CREATE TABLE Brands (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX IX_Brands_Name ON Brands(Name);

-- Create CarCategories table
CREATE TABLE CarCategories (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX IX_CarCategories_Name ON CarCategories(Name);

-- Create States table
CREATE TABLE States (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX IX_States_Name ON States(Name);

-- Create Cars table
CREATE TABLE Cars (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    PriceHour DECIMAL(18, 2) NOT NULL,
    Stock REAL NOT NULL,
    Model INT NOT NULL,
    LicensePlate NVARCHAR(6) NOT NULL,
    BrandId INT NOT NULL,
    CarCategoryId INT NOT NULL,
    CONSTRAINT FK_Cars_Brands FOREIGN KEY (BrandId) REFERENCES Brands(Id) ON DELETE RESTRICT,
    CONSTRAINT FK_Cars_CarCategories FOREIGN KEY (CarCategoryId) REFERENCES CarCategories(Id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IX_Cars_LicensePlate ON Cars(LicensePlate);
CREATE INDEX IX_Cars_BrandId ON Cars(BrandId);
CREATE INDEX IX_Cars_CarCategoryId ON Cars(CarCategoryId);

-- Create Cities table
CREATE TABLE Cities (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    StateId INT NOT NULL,
    CONSTRAINT FK_Cities_States FOREIGN KEY (StateId) REFERENCES States(Id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IX_Cities_StateId_Name ON Cities(StateId, Name);

-- Create CarImages table
CREATE TABLE CarImages (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CarId INT NOT NULL,
    Image NVARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_CarImages_Cars FOREIGN KEY (CarId) REFERENCES Cars(Id) ON DELETE RESTRICT
);
CREATE INDEX IX_CarImages_CarId ON CarImages(CarId);

-- Create Users table
CREATE TABLE Users (
    Id NVARCHAR(450) NOT NULL PRIMARY KEY,
    Document NVARCHAR(200) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(200) NOT NULL,
    Password NVARCHAR(200) NOT NULL,
    Phone NVARCHAR(200) NOT NULL,
    Photo NVARCHAR(MAX),
    UserType INT NOT NULL,
    CityId INT NOT NULL,
    UserName NVARCHAR(MAX),
    NormalizedUserName NVARCHAR(MAX),
    NormalizedEmail NVARCHAR(MAX),
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX),
    SecurityStamp NVARCHAR(MAX),
    ConcurrencyStamp NVARCHAR(MAX),
    PhoneNumber NVARCHAR(MAX),
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd DATETIMEOFFSET,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    CONSTRAINT FK_Users_Cities FOREIGN KEY (CityId) REFERENCES Cities(Id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IX_Users_Document ON Users(Document);
CREATE INDEX IX_Users_CityId ON Users(CityId);

-- Create Rents table
CREATE TABLE Rents (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId1 NVARCHAR(450),
    UserId INT NOT NULL,
    CarId INT NOT NULL,
    StartDate DATETIME2 NOT NULL,
    EndDate DATETIME2 NOT NULL,
    RealEndDate DATETIME2 NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    RentStatus INT NOT NULL,
    Remarks NVARCHAR(MAX),
    CONSTRAINT FK_Rents_Cars FOREIGN KEY (CarId) REFERENCES Cars(Id) ON DELETE RESTRICT,
    CONSTRAINT FK_Rents_Users FOREIGN KEY (UserId1) REFERENCES Users(Id) ON DELETE RESTRICT
);
CREATE INDEX IX_Rents_CarId ON Rents(CarId);
CREATE UNIQUE INDEX IX_Rents_Id ON Rents(Id);
CREATE INDEX IX_Rents_UserId1 ON Rents(UserId1);
