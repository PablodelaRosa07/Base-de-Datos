/* TABLA ORGANISATION */
CREATE TABLE ORGANISATION (
    Organisation_Code  NUMBER(14) PRIMARY KEY,
    Name               VARCHAR2(100) UNIQUE NOT NULL,
    Type_organisation  VARCHAR2(50),
    Sector             VARCHAR2(50),
    Direction          VARCHAR2(150),
    Contact_Telephone  VARCHAR2(20),
    Financing_Type     VARCHAR2(50),
    Contact_Email      VARCHAR2(100),
    Budget             NUMBER(14,2),
    Registration_Date  DATE,
    Activity_Status    VARCHAR2(20),
    CONSTRAINT chk_org_budget CHECK (Budget > 0),
    CONSTRAINT chk_org_status CHECK (Activity_Status IN ('Active', 'Inactive', 'Suspended'))
);

/* TABLA PUBLISH */
CREATE TABLE PUBLISH (
    Public_Code         NUMBER(14) PRIMARY KEY,
    Public_Funding      NUMBER(14,2),
    Head_Financing      VARCHAR2(100),
    Unanimity_Decisions VARCHAR2(5),
    Organisation_Code   NUMBER(14),
    CONSTRAINT fk_publish_org FOREIGN KEY (Organisation_Code) 
        REFERENCES ORGANISATION(Organisation_Code) ON DELETE CASCADE,
    CONSTRAINT chk_pub_funding CHECK (Public_Funding >= 0)
);

/* TABLA PRIVATE */
CREATE TABLE PRIVATE (
    Private_Code       NUMBER(14) PRIMARY KEY,
    Private_Financing  NUMBER(14,2),
    Advertising        VARCHAR2(255),
    Organisation_Code  NUMBER(14),
    CONSTRAINT fk_private_org FOREIGN KEY (Organisation_Code) 
        REFERENCES ORGANISATION(Organisation_Code) ON DELETE CASCADE,
    CONSTRAINT chk_priv_funding CHECK (Private_Financing >= 0)
);

/* TABLA ACTION */
CREATE TABLE ACTION (
    Actions_Code       NUMBER(14) PRIMARY KEY,
    Name_Action        VARCHAR2(100) UNIQUE NOT NULL,
    Type_Action        VARCHAR2(50),
    Description        VARCHAR2(500),
    Start_Date         DATE,
    End_Date           DATE,
    Budget             NUMBER(14,2),
    Expected_Result    VARCHAR2(255),
    State_Action       VARCHAR2(50),
    Impact_Assessment  VARCHAR2(255),
    Duration           NUMBER(5),
    CONSTRAINT chk_act_budget   CHECK (Budget > 0),
    CONSTRAINT chk_act_dates    CHECK (Start_Date <= End_Date),
    CONSTRAINT chk_act_duration CHECK (Duration > 0)
);

/* TABLA VOLUNTEER */
CREATE TABLE VOLUNTEER (
    Volunteer_Code     NUMBER(14) PRIMARY KEY,
    DNI                VARCHAR2(10) UNIQUE NOT NULL,
    Name               VARCHAR2(50),
    Surname1           VARCHAR2(50),
    Surname2           VARCHAR2(50),
    Age                NUMBER(3),
    Start_Date         DATE,
    End_Date           DATE,
    Contact            VARCHAR2(100),
    Specialisation     VARCHAR2(100),
    Contract_Duration  NUMBER(5),
    
    CONSTRAINT chk_vol_age      CHECK (Age >= 18),
    CONSTRAINT chk_vol_duration CHECK (Contract_Duration > 0),
    CONSTRAINT chk_vol_dates    CHECK (Start_Date <= End_Date)
);

/* TABLA AREA */
CREATE TABLE AREA (
    Area_Code               NUMBER(14) PRIMARY KEY,
    Atmosphere              VARCHAR2(50),
    Postcode                VARCHAR2(10) UNIQUE,
    Community               VARCHAR2(100),
    GDP_Area                NUMBER(14,2),
    Aid_Received            NUMBER(14,2),
    Accessibility_Logistics VARCHAR2(255),
    Unemployment_Rate       NUMBER(5,2),
    Average_Education       NUMBER(5,2),
    
    CONSTRAINT chk_area_unemp CHECK (Unemployment_Rate >= 0 AND Unemployment_Rate <= 100),
    CONSTRAINT chk_area_edu   CHECK (Average_Education >= 0 AND Average_Education <= 100),
    CONSTRAINT chk_area_aid   CHECK (Aid_Received >= 0)
);

/* TABLA LOGISTICS */
CREATE TABLE LOGISTICS (
    Logistics_Code      NUMBER(14) PRIMARY KEY,
    Transport           VARCHAR2(50),
    Goods               VARCHAR2(100),
    DNI                 VARCHAR2(10),
    Resource_Allocation VARCHAR2(255),
    In_Charge           VARCHAR2(100),
    Cost                NUMBER(14,2),
    Budget              NUMBER(14,2),
    Direction_Exit      VARCHAR2(150),
    Directions_Arrival  VARCHAR2(150),
    
    CONSTRAINT chk_log_cost    CHECK (Cost > 0),
    CONSTRAINT chk_log_budget  CHECK (Budget >= Cost)
);

/* INSERTS */
INSERT INTO ORGANISATION VALUES (10, 'Banco de Alimentos Solidario', 'ONG', 'Alimentación', 'Calle Esperanza 45, Sevilla', '954001122', 'Privada', 'contacto@bancoalim.es', 250000.00, TO_DATE('2020-01-10', 'YYYY-MM-DD'), 'Active');
INSERT INTO ORGANISATION VALUES (20, 'Cáritas Diocesana', 'Religiosa', 'Social', 'Plaza de la Iglesia 1, Madrid', '910112233', 'Mixta', 'ayuda@caritas.es', 1500000.00, TO_DATE('2018-03-15', 'YYYY-MM-DD'), 'Active');
INSERT INTO ORGANISATION VALUES (30, 'Fundación contra la Pobreza Infantil', 'Fundación', 'Infancia', 'Paseo de Gracia 12, Barcelona', '932003344', 'Pública', 'info@pobrezainfantil.org', 600000.00, TO_DATE('2021-06-20', 'YYYY-MM-DD'), 'Active');

INSERT INTO PUBLISH VALUES (101, 900000.00, 'Ministerio de Asuntos Sociales', 'YES', 20);

INSERT INTO PRIVATE VALUES (201, 120000.00, 'Campaña Operación Kilo Navidad', 10);

INSERT INTO ACTION (Actions_Code, Name_Action, Type_Action, Description, Start_Date, End_Date, Budget, Expected_Result, State_Action, Impact_Assessment, Duration)
VALUES (501, 'Comedor Social Invierno', 'Asistencia', 'Reparto de menús diarios', TO_DATE('2025-11-01', 'YYYY-MM-DD'), TO_DATE('2026-03-01', 'YYYY-MM-DD'), 80000.00, 'Éxito', 'Active', 'Alto', 120);

INSERT INTO VOLUNTEER (Volunteer_Code, DNI, Name, Surname1, Surname2, Age, Start_Date, End_Date, Contact, Specialisation, Contract_Duration)
VALUES (301, '44556677B', 'Elena', 'Gómez', 'Sanz', 34, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'elena.g@social.org', 'Trabajadora Social', 365);

INSERT INTO VOLUNTEER (Volunteer_Code, DNI, Name, Surname1, Surname2, Age, Start_Date, End_Date, Contact, Specialisation, Contract_Duration)
VALUES (302, '11223344C', 'Carlos', 'Ruiz', 'Maza', 45, TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-08-15', 'YYYY-MM-DD'), 'cruiz@gmail.com', 'Logística', 180);

INSERT INTO VOLUNTEER (Volunteer_Code, DNI, Name, Surname1, Surname2, Age, Start_Date, End_Date, Contact, Specialisation, Contract_Duration)
VALUES (303, '99887766D', 'Ana', 'Belén', 'López', 29, TO_DATE('2025-01-10', 'YYYY-MM-DD'), TO_DATE('2025-07-10', 'YYYY-MM-DD'), 'ana_log@ong.es', 'Nutrición', 180);

INSERT INTO AREA (Area_Code, Atmosphere, Postcode, Community, GDP_Area, Aid_Received, Accessibility_Logistics, Unemployment_Rate, Average_Education)
VALUES (401, 'Periferia', '41013', 'Andalucía', 12000.00, 45000.00, 'Acceso terrestre limitado', 28.5, 40.0);

INSERT INTO AREA (Area_Code, Atmosphere, Postcode, Community, GDP_Area, Aid_Received, Accessibility_Logistics, Unemployment_Rate, Average_Education)
VALUES (402, 'Rural', '10005', 'Extremadura', 14500.00, 30000.00, 'Zonas de montaña', 22.1, 55.5);

INSERT INTO AREA (Area_Code, Atmosphere, Postcode, Community, GDP_Area, Aid_Received, Accessibility_Logistics, Unemployment_Rate, Average_Education)
VALUES (403, 'Urbana', '28045', 'Madrid', 25000.00, 100000.00, 'Excelente', 15.2, 70.0);

INSERT INTO LOGISTICS (Logistics_Code, Transport, Goods, DNI, Resource_Allocation, In_Charge, Cost, Budget, Direction_Exit, Directions_Arrival)
VALUES (601, 'Furgón', 'Productos frescos', '44556677B', 'Lote Familiar', 'Elena Gómez', 450.00, 600.00, 'Sevilla Centro', 'Barrio 3000 Viv.');

INSERT INTO LOGISTICS (Logistics_Code, Transport, Goods, DNI, Resource_Allocation, In_Charge, Cost, Budget, Direction_Exit, Directions_Arrival)
VALUES (602, 'Camión', 'Ropa y mantas', '11223344C', 'Campaña Frío', 'Carlos Ruiz', 800.00, 1200.00, 'Almacén Madrid', 'Albergue Social');

INSERT INTO LOGISTICS (Logistics_Code, Transport, Goods, DNI, Resource_Allocation, In_Charge, Cost, Budget, Direction_Exit, Directions_Arrival)
VALUES (603, 'Furgoneta', 'Libros y papelería', '99887766D', 'Suministros Escolares', 'Ana Belén López', 200.00, 500.00, 'Barcelona Depósito', 'Centro Educativo');


/* ELIMINACIÓN DE TABLAS */
DROP TABLE LOGISTICS CASCADE CONSTRAINTS;
DROP TABLE AREA CASCADE CONSTRAINTS;
DROP TABLE VOLUNTEER CASCADE CONSTRAINTS;
DROP TABLE ACTION CASCADE CONSTRAINTS;
DROP TABLE PRIVATE CASCADE CONSTRAINTS;
DROP TABLE PUBLISH CASCADE CONSTRAINTS;
DROP TABLE ORGANISATION CASCADE CONSTRAINTS;