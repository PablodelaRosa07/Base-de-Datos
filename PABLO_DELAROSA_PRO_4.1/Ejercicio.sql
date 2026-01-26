
CREATE TABLE ORGANISATION (
    Organisation_Code   NUMBER(14) PRIMARY KEY,
    Name                VARCHAR2(100) NOT NULL,
    Type_Organisation   VARCHAR2(50),
    Sector              VARCHAR2(100),
    Direction           VARCHAR2(150),
    Contact_Telephone   VARCHAR2(20),
    Financing_Type      VARCHAR2(50),
    Contact_Email       VARCHAR2(120),
    Budget              NUMBER(14,2) NOT NULL,
    Registration_Date   DATE NOT NULL,
    Activity_Status     VARCHAR2(20),
    CONSTRAINT chk_org_budget CHECK (Budget > 0),
    CONSTRAINT chk_org_status CHECK (Activity_Status IN ('Active','Inactive','Suspended')),
    CONSTRAINT chk_org_email CHECK (REGEXP_LIKE(Contact_Email, '^[^@]+@[^@]+\.[^@]+$')),
    CONSTRAINT chk_org_phone CHECK (REGEXP_LIKE(Contact_Telephone, '^[0-9]{9}$')),
    CONSTRAINT chk_org_regdate CHECK (Registration_Date <= SYSDATE)
);

CREATE TABLE AREA (
    Area_Code              NUMBER(14) PRIMARY KEY,
    Atmosphere             VARCHAR2(100),
    Postcode               VARCHAR2(10),
    Community              VARCHAR2(100),
    GDP_Area               NUMBER(14,2),
    Aid_Received           NUMBER(14,2),
    Accessibility_Logistics VARCHAR2(200),
    Unemployment_Rate      NUMBER(5,2),
    Average_Education      NUMBER(5,2),
    CONSTRAINT chk_area_unemployment CHECK (Unemployment_Rate BETWEEN 0 AND 100),
    CONSTRAINT chk_area_education CHECK (Average_Education BETWEEN 0 AND 100),
    CONSTRAINT chk_area_aid CHECK (Aid_Received >= 0),
    CONSTRAINT chk_area_postcode CHECK (REGEXP_LIKE(Postcode, '^[0-9]{5}$'))
);

CREATE TABLE ACTION (
    Actions_Code       NUMBER(14) PRIMARY KEY,
    Name_Action        VARCHAR2(100) NOT NULL,
    Type_Action        VARCHAR2(50),
    Description        VARCHAR2(500),
    Start_Date         DATE NOT NULL,
    End_Date           DATE NOT NULL,
    Budget             NUMBER(14,2) NOT NULL,
    Expected_Result    VARCHAR2(500),
    State_Action       VARCHAR2(50),
    Impact_Assessment  VARCHAR2(500),
    Duration           NUMBER(14) NOT NULL,
    CONSTRAINT chk_action_budget CHECK (Budget > 0),
    CONSTRAINT chk_action_dates CHECK (Start_Date <= End_Date),
    CONSTRAINT chk_action_duration CHECK (Duration > 0)
);




CREATE TABLE HOME (
    Home_Code           NUMBER(14) PRIMARY KEY,
    Postal_Code         VARCHAR2(10),
    Street              VARCHAR2(100),
    Number_Home         NUMBER(6),
    City                VARCHAR2(100),
    Member_Num          NUMBER(5),
    Employed_Num        NUMBER(5),
    Unemployed_Num      NUMBER(5),
    Home_Ownership      NUMBER(1),
    Home_Quality        VARCHAR2(20),
    Avg_Education_Level NUMBER(5,2),
    Area_Zone           NUMBER(14),
    CONSTRAINT chk_home_quality CHECK (Home_Quality IN ('Bad','Acceptable','Good')),
    CONSTRAINT chk_home_postal CHECK (REGEXP_LIKE(Postal_Code, '^[0-9]{5}$')),
    CONSTRAINT fk_home_area FOREIGN KEY (Area_Zone) REFERENCES AREA(Area_Code) ON DELETE CASCADE
        
);

CREATE TABLE ECONOMY (
    Economy_Code        NUMBER(14) PRIMARY KEY,
    Aid_Income          NUMBER(14,2),
    Monthly_Income      NUMBER(14,2),
    Monthly_Expense     NUMBER(14,2),
    Food_Expense        NUMBER(14,2),
    Education_Expense   NUMBER(14,2),
    Health_Expense      NUMBER(14,2),
    Housing_Expense     NUMBER(14,2),
    Leisure_Expense     NUMBER(14,2),
    Saving              NUMBER(14,2),
    Home_Code           NUMBER(14),
    CONSTRAINT fk_economy_home FOREIGN KEY (Home_Code)  REFERENCES HOME(Home_Code) ON DELETE CASCADE
       
);

CREATE TABLE SOURCES_OF_INCOME (
    CodSources   NUMBER(14) PRIMARY KEY,
    Sources      VARCHAR2(300) NOT NULL,  
    Economy_Code NUMBER(14),
    CONSTRAINT fk_sources_economy FOREIGN KEY (Economy_Code) REFERENCES ECONOMY(Economy_Code) ON DELETE CASCADE
);


CREATE TABLE SERVICE (
    Service_Code   NUMBER(14) PRIMARY KEY,
    Name           VARCHAR2(50)NOT NULL,
    Street         VARCHAR2(50)NOT NULL,
    Number_Service NUMBER(9),
    City           VARCHAR2(100)NOT NULL,
    Type           VARCHAR2(20),
    Availability   VARCHAR2(20),
    Quality        VARCHAR2(20),
    Expense        VARCHAR2(20),
    Economy_Code   NUMBER(14),

    CONSTRAINT chk_service_type CHECK (Type IN ('MONEY','SOURCES','HUMAN AID')),
    CONSTRAINT chk_service_availability CHECK (Availability IN ('LOW','NORMAL','HIGH')),
    CONSTRAINT chk_service_quality CHECK (Quality IN ('BAD','NORMAL','GOOD')),
    CONSTRAINT chk_service_expense CHECK (Expense IN ('CHEAP','NORMAL','EXPENSIVE')),
    CONSTRAINT fk_service_economy FOREIGN KEY (Economy_Code) REFERENCES ECONOMY(Economy_Code) ON DELETE CASCADE
        
);



CREATE TABLE OCCUPATION (
    Occupation_Code  NUMBER(14) PRIMARY KEY,
    Employed_Time    NUMBER(5),
    Unemployed_Time  NUMBER(5),
    Retired          VARCHAR2(3) NOT NULL,
    Employed         VARCHAR2(3)NOT NULL,
    Unemployed       VARCHAR2(3)NOT NULL,
    Student          VARCHAR2(3)NOT NULL,
    Money_Earned     NUMBER(14,2),
    Pension_Received NUMBER(14,2),
    CONSTRAINT chk_occ_retired CHECK (Retired IN ('YES','NOT')),
    CONSTRAINT chk_occ_employed CHECK (Employed IN ('YES','NOT')),
    CONSTRAINT chk_occ_unemployed CHECK (Unemployed IN ('YES','NOT')),
    CONSTRAINT chk_occ_student CHECK (Student IN ('YES','NOT'))
);

CREATE TABLE JOB_TYPE (
    JobType_Code     NUMBER(14) PRIMARY KEY,
    type_job        VARCHAR2(300)NOT NULL,
    Occupation_Code  NUMBER(14),
    CONSTRAINT fk_jobtype_occupation FOREIGN KEY (Occupation_Code)  REFERENCES OCCUPATION(Occupation_Code) ON DELETE CASCADE
       
);

CREATE TABLE SALARY (
    Salary_Code     NUMBER(14) PRIMARY KEY,
    Salary_now      NUMBER(12) NOT NULL,
    Occupation_Code NUMBER(14),
    CONSTRAINT fk_salary_occupation FOREIGN KEY (Occupation_Code) REFERENCES OCCUPATION(Occupation_Code) ON DELETE CASCADE
);
        



CREATE TABLE MEMBER (
    Member_Code     NUMBER(14) PRIMARY KEY,
    Name            VARCHAR2(100)NOT NULL,
    DNI             VARCHAR2(9)NOT NULL,
    Sn1             VARCHAR2(50)NOT NULL,
    Sn2             VARCHAR2(50),
    Age             NUMBER(3)NOT NULL,
    Gender          VARCHAR2(10),
    Civil_Status    VARCHAR2(20)NOT NULL,
    Monthly_Income  NUMBER(14,2)NOT NULL,
    Home_Code       NUMBER(14),
    Economy_Code    NUMBER(14),
    Occupation_Code NUMBER(14),

    CONSTRAINT chk_member_age CHECK (Age >= 0),
    CONSTRAINT chk_member_gender CHECK (Gender IN ('male','female')),
    CONSTRAINT chk_member_civil CHECK (Civil_Status IN ('single','married')),
    CONSTRAINT chk_member_dni CHECK (REGEXP_LIKE(DNI, '^[0-9]{8}[A-Z]$')),
    CONSTRAINT uk_member_dni UNIQUE (DNI),
    CONSTRAINT fk_member_home FOREIGN KEY (Home_Code)  REFERENCES HOME(Home_Code) ON DELETE CASCADE,       
    CONSTRAINT fk_member_economy FOREIGN KEY (Economy_Code)  REFERENCES ECONOMY(Economy_Code) ON DELETE CASCADE,       
    CONSTRAINT fk_member_occupation FOREIGN KEY (Occupation_Code)  REFERENCES OCCUPATION(Occupation_Code) ON DELETE CASCADE
       
);

CREATE TABLE EDUCATION (
    EducationCode NUMBER(14) PRIMARY KEY,
    Education     VARCHAR2(20),
    Member_Code   NUMBER(14),

    CONSTRAINT chk_education CHECK (Education IN ('School','Highschool','University','FP')),
    CONSTRAINT fk_education_member FOREIGN KEY (Member_Code) REFERENCES MEMBER(Member_Code) ON DELETE CASCADE );



CREATE TABLE AID (
    Aid_Code         NUMBER(14) PRIMARY KEY,
    Start_Date       DATE,
    Aid_Duration     NUMBER(5),
    End_Date         DATE,
    Status           VARCHAR2(30),
    Budget_Received  NUMBER(14,2),
    Home_Code        NUMBER(14),
    Action_Code      NUMBER(14),
    CONSTRAINT fk_aid_home FOREIGN KEY (Home_Code) REFERENCES HOME(Home_Code) ON DELETE CASCADE,        
    CONSTRAINT fk_aid_action FOREIGN KEY (Action_Code) REFERENCES ACTION(Actions_Code) ON DELETE CASCADE
        
);

CREATE TABLE AID_TYPE (
    Aid_Code      NUMBER(14),
    Aid_TypeCode  NUMBER(14),
    CONSTRAINT pk_aid_type PRIMARY KEY (Aid_Code, Aid_TypeCode),
    CONSTRAINT fk_aidtype_aid FOREIGN KEY (Aid_Code)  REFERENCES AID(Aid_Code) ON DELETE CASCADE
       
);

CREATE TABLE DONATIONS (
    Aid_Code      NUMBER(14),
    DonationCode  NUMBER(14),
    CONSTRAINT pk_donations PRIMARY KEY (Aid_Code, DonationCode),
    CONSTRAINT fk_donations_aid FOREIGN KEY (Aid_Code)  REFERENCES AID(Aid_Code) ON DELETE CASCADE
);
       

CREATE TABLE SOURCE (
    Aid_Code    NUMBER(14),
    SourceCode  NUMBER(14),
    CONSTRAINT pk_source PRIMARY KEY (Aid_Code, SourceCode),
    CONSTRAINT fk_source_aid FOREIGN KEY (Aid_Code)  REFERENCES AID(Aid_Code) ON DELETE CASCADE       
);

CREATE TABLE DELIVERY_ROUTES (
    Aid_Code   NUMBER(14),
    RouteCode  NUMBER(14),
    CONSTRAINT pk_routes PRIMARY KEY (Aid_Code, RouteCode),
    CONSTRAINT fk_routes_aid FOREIGN KEY (Aid_Code)  REFERENCES AID(Aid_Code) ON DELETE CASCADE      
);


CREATE TABLE USES (
    Home_Code    NUMBER(14),
    Service_Code NUMBER(14),
    CONSTRAINT pk_uses PRIMARY KEY (Home_Code, Service_Code),
    CONSTRAINT fk_uses_home FOREIGN KEY (Home_Code)  REFERENCES HOME(Home_Code) ON DELETE CASCADE,       
    CONSTRAINT fk_uses_service FOREIGN KEY (Service_Code) REFERENCES SERVICE(Service_Code) ON DELETE CASCADE        
);

CREATE TABLE LIVING (
    Member_Code        NUMBER(14),
    Family_Member_Code NUMBER(14),
    CONSTRAINT pk_living PRIMARY KEY (Member_Code, Family_Member_Code),
    CONSTRAINT fk_living_member1 FOREIGN KEY (Member_Code)  REFERENCES MEMBER(Member_Code) ON DELETE CASCADE,        
    CONSTRAINT fk_living_member2 FOREIGN KEY (Family_Member_Code) REFERENCES MEMBER(Member_Code) ON DELETE CASCADE        
);

CREATE TABLE DEPENDS (
    Aid_Code     NUMBER(14),
    Primary_Aid  NUMBER(14),
    CONSTRAINT pk_depends PRIMARY KEY (Aid_Code, Primary_Aid),
    CONSTRAINT fk_depends_aid1 FOREIGN KEY (Aid_Code)  REFERENCES AID(Aid_Code) ON DELETE CASCADE,    
    CONSTRAINT fk_depends_aid2 FOREIGN KEY (Primary_Aid) REFERENCES AID(Aid_Code) ON DELETE CASCADE        
);

DROP TABLE DEPENDS CASCADE CONSTRAINTS;
DROP TABLE LIVING CASCADE CONSTRAINTS;
DROP TABLE USES CASCADE CONSTRAINTS;
DROP TABLE DELIVERY_ROUTES CASCADE CONSTRAINTS;
DROP TABLE SOURCE CASCADE CONSTRAINTS;
DROP TABLE DONATIONS CASCADE CONSTRAINTS;
DROP TABLE AID_TYPE CASCADE CONSTRAINTS;
DROP TABLE AID CASCADE CONSTRAINTS;
DROP TABLE EDUCATION CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE SALARY CASCADE CONSTRAINTS;
DROP TABLE JOB_TYPE CASCADE CONSTRAINTS;
DROP TABLE OCCUPATION CASCADE CONSTRAINTS;
DROP TABLE SERVICE CASCADE CONSTRAINTS;
DROP TABLE SOURCES_OF_INCOME CASCADE CONSTRAINTS;
DROP TABLE ECONOMY CASCADE CONSTRAINTS;
DROP TABLE HOME CASCADE CONSTRAINTS;
DROP TABLE ACTION CASCADE CONSTRAINTS;
DROP TABLE AREA CASCADE CONSTRAINTS;
DROP TABLE ORGANISATION CASCADE CONSTRAINTS;