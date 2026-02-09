/* 1. CREACIÓN DE TABLAS */

CREATE TABLE SEDE (
    codsede   NUMBER(14) PRIMARY KEY,
    Nombre    VARCHAR2(100) UNIQUE NOT NULL,
    Direccion VARCHAR2(255)
);

CREATE TABLE DEPARTAMENTO (
    coddepartamento NUMBER(14) PRIMARY KEY,
    Nombre          VARCHAR2(100) UNIQUE NOT NULL,
    Direccion       VARCHAR2(255)
);

CREATE TABLE EQUIPO (
    codequipo     NUMBER(14) PRIMARY KEY,
    Nombre_Equipo VARCHAR2(100) UNIQUE NOT NULL,
    Descripcion   VARCHAR2(500)
);


CREATE TABLE PROYECTO (
    codproyecto     NUMBER(14) PRIMARY KEY,
    Nombre_Proyecto VARCHAR2(100) UNIQUE NOT NULL,
    Descripcion     VARCHAR2(500),
    Fecha_Inicio    DATE NOT NULL,
    Fecha_Fin       DATE,
    Estado          VARCHAR2(20),
    Subproyecto     VARCHAR2(100), 
    CONSTRAINT chk_estado_proyecto 
        CHECK (Estado IN ('Propuesta', 'En Curso', 'Pausado', 'Finalizado'))
);

CREATE TABLE PROGRAMADOR (
    codprogramador  NUMBER(14) PRIMARY KEY,
    DNI             VARCHAR2(20) UNIQUE NOT NULL,
    Nombre          VARCHAR2(50) NOT NULL,
    Ap1             VARCHAR2(50) NOT NULL,
    Ap2             VARCHAR2(50),
    Email           VARCHAR2(100), 
    coddepartamento NUMBER(14),
    codequipo       NUMBER(14),
    CONSTRAINT fk_prog_depto FOREIGN KEY (coddepartamento) 
        REFERENCES DEPARTAMENTO(coddepartamento),
    CONSTRAINT fk_prog_equipo FOREIGN KEY (codequipo) 
        REFERENCES EQUIPO(codequipo)
);

CREATE TABLE SENIOR (
    codsenior       NUMBER(14) PRIMARY KEY,
    DNI             VARCHAR2(20) UNIQUE NOT NULL,
    coddepartamento NUMBER(14),
    codsede         NUMBER(14),
    CONSTRAINT fk_senior_depto FOREIGN KEY (coddepartamento) 
        REFERENCES DEPARTAMENTO(coddepartamento),
    CONSTRAINT fk_senior_sede FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede)
);

CREATE TABLE JUNIOR (
    codjunior       NUMBER(14) PRIMARY KEY,
    DNI             VARCHAR2(20) UNIQUE NOT NULL,
    coddepartamento NUMBER(14),
    codsede         NUMBER(14),
    CONSTRAINT fk_junior_depto FOREIGN KEY (coddepartamento) 
        REFERENCES DEPARTAMENTO(coddepartamento),
    CONSTRAINT fk_junior_sede FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede)
);


/* 2. INSERCIÓN DE DATOS */

INSERT INTO SEDE (codsede, Nombre, Direccion) 
VALUES (1, 'Sede Norte - Madrid', 'Paseo de la Castellana 200');
INSERT INTO SEDE (codsede, Nombre, Direccion) 
VALUES (2, 'Sede Sur - Málaga', 'Parque Tecnológico de Andalucía');

INSERT INTO DEPARTAMENTO (coddepartamento, Nombre, Direccion) 
VALUES (10, 'Desarrollo Backend', 'Planta 3 - Ala A');
INSERT INTO DEPARTAMENTO (coddepartamento, Nombre, Direccion) 
VALUES (20, 'Inteligencia Artificial', 'Planta 5 - Ala B');

INSERT INTO EQUIPO (codequipo, Nombre_Equipo, Descripcion) 
VALUES (100, 'Alpha Team', 'Especialistas en Java y Spring Boot');
INSERT INTO EQUIPO (codequipo, Nombre_Equipo, Descripcion) 
VALUES (200, 'Data Wizards', 'Enfocados en modelos de Machine Learning');

INSERT INTO PROYECTO (codproyecto, Nombre_Proyecto, Descripcion, Fecha_Inicio, Fecha_Fin, Estado, Subproyecto) 
VALUES (500, 'Sistema Bancario Core', 'Renovación de plataforma bancaria', TO_DATE('2024-01-01', 'YYYY-MM-DD'), NULL, 'En Curso', 'Módulo Pagos');
INSERT INTO PROYECTO (codproyecto, Nombre_Proyecto, Descripcion, Fecha_Inicio, Fecha_Fin, Estado, Subproyecto) 
VALUES (501, 'Análisis de Sentimiento v2', 'Mejora del motor de IA', TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Finalizado', NULL);

INSERT INTO PROGRAMADOR (codprogramador, DNI, Nombre, Ap1, Ap2, Email, coddepartamento, codequipo) 
VALUES (1001, '11111111A', 'Laura', 'García', 'Mora', 'laura.garcia@tech.com', 10, 100);

INSERT INTO PROGRAMADOR (codprogramador, DNI, Nombre, Ap1, Ap2, Email, coddepartamento, codequipo) 
VALUES (1002, '22222222B', 'Roberto', 'Sanz', 'León', 'roberto.sanz@tech.com', 20, 200);

INSERT INTO SENIOR (codsenior, DNI, coddepartamento, codsede) 
VALUES (1, '11111111A', 10, 1);

INSERT INTO JUNIOR (codjunior, DNI, coddepartamento, codsede) 
VALUES (1, '22222222B', 20, 2);


/* 3. ELIMINACIÓN DE TABLAS */

DROP TABLE DEPARTAMENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE EQUIPO CASCADE CONSTRAINTS PURGE;
DROP TABLE JUNIOR CASCADE CONSTRAINTS PURGE;
DROP TABLE PROGRAMADOR CASCADE CONSTRAINTS PURGE;
DROP TABLE PROYECTO CASCADE CONSTRAINTS PURGE;
DROP TABLE SEDE CASCADE CONSTRAINTS PURGE;
DROP TABLE SENIOR CASCADE CONSTRAINTS PURGE;