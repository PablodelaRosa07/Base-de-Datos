/* Creación de Tablas (Pablo) */

CREATE TABLE ORGANISATION (
    Organisation_Code      INT PRIMARY KEY,
    Name                   VARCHAR(255) UNIQUE NOT NULL,
    Organisation_Type      VARCHAR(100),
    Sector                 VARCHAR(100),
    Address                VARCHAR(255),
    Contact_Phone          VARCHAR(20),
    Financing_Type         VARCHAR(50),
    Contact_Email          VARCHAR(255),
    Budget                 DECIMAL(12,2) CHECK (Budget > 0),
    Registration_Date      DATE CHECK (Registration_Date <= CURRENT_DATE),
    Activity_Status        VARCHAR(20)
        CHECK (Activity_Status IN ('Active','Inactive','Suspended')),
    CHECK (Contact_Email REGEXP '^[^@]+@[^@]+\.[^@]+$')
);

CREATE TABLE PUBLIC_ORGANISATION (
    Public_Code            INT PRIMARY KEY,
    Public_Funding         DECIMAL(12,2) CHECK (Public_Funding >= 0),
    Main_Financing_Source  VARCHAR(255),
    Requires_Unanimity     BOOLEAN CHECK (Requires_Unanimity IN (TRUE, FALSE)),
    Organisation_Code      INT UNIQUE,
    FOREIGN KEY (Organisation_Code)
        REFERENCES ORGANISATION(Organisation_Code)
);

CREATE TABLE PRIVATE_ORGANISATION (
    Private_Code           INT PRIMARY KEY,
    Private_Financing      DECIMAL(12,2) CHECK (Private_Financing >= 0),
    Advertising            VARCHAR(255),
    Organisation_Code      INT UNIQUE,
    FOREIGN KEY (Organisation_Code)
        REFERENCES ORGANISATION(Organisation_Code)
);

CREATE TABLE ACTION (
    Action_Code            INT PRIMARY KEY,
    Action_Name            VARCHAR(255) UNIQUE NOT NULL,
    Action_Type            VARCHAR(100),
    Description            TEXT,
    Start_Date             DATE,
    End_Date               DATE,
    Budget                 DECIMAL(12,2) CHECK (Budget > 0),
    Expected_Result        TEXT,
    Action_Status          VARCHAR(50),
    Impact_Assessment      TEXT,
    Duration               INT CHECK (Duration > 0),
    CHECK (Start_Date <= End_Date)
);

CREATE TABLE VOLUNTEER (
    Volunteer_Code         INT PRIMARY KEY,
    DNI                    VARCHAR(9) UNIQUE
        CHECK (DNI REGEXP '^[0-9]{8}[A-Z]$'),
    Name                   VARCHAR(100),
    Surname1               VARCHAR(100),
    Surname2               VARCHAR(100),
    Age                    INT CHECK (Age >= 18),
    Start_Date             DATE,
    End_Date               DATE,
    Contact                VARCHAR(255),
    Specialisation         VARCHAR(255),
    Contract_Duration      INT CHECK (Contract_Duration > 0),
    CHECK (Start_Date <= End_Date)
);

CREATE TABLE AREA (
    Area_Code              INT PRIMARY KEY,
    Environment            VARCHAR(100),
    Postcode               VARCHAR(10) UNIQUE,
    Community              VARCHAR(100),
    GDP                    DECIMAL(14,2),
    Aid_Received           DECIMAL(12,2) CHECK (Aid_Received >= 0),
    Accessibility_Logistics VARCHAR(255),
    Unemployment_Rate      DECIMAL(5,2)
        CHECK (Unemployment_Rate BETWEEN 0 AND 100),
    Average_Education      DECIMAL(5,2)
        CHECK (Average_Education BETWEEN 0 AND 100)
);

CREATE TABLE LOGISTICS (
    Logistics_Code         INT PRIMARY KEY,
    Transport_Type         VARCHAR(100),
    Goods_Type             VARCHAR(100),
    DNI                    VARCHAR(9)
        CHECK (DNI REGEXP '^[0-9]{8}[A-Z]$'),
    Resource_Allocation    VARCHAR(255),
    Responsible            VARCHAR(255),
    Cost                   DECIMAL(12,2) CHECK (Cost > 0),
    Budget                 DECIMAL(12,2) CHECK (Budget >= Cost),
    Departure_Address      VARCHAR(255),
    Arrival_Address        VARCHAR(255),
    CHECK (Departure_Address LIKE '%Spain%')
);