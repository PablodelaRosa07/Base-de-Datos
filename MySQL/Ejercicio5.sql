/* 1. TABLAS MAESTRAS */
CREATE TABLE MARCA (
    codmarca      NUMBER(14) PRIMARY KEY,
    Nombre        VARCHAR2(50) UNIQUE NOT NULL,
    Descripcion   VARCHAR2(200),
    Pais_Origen   VARCHAR2(50),
    Historial     VARCHAR2(100)
);

CREATE TABLE MODELO (
    codmodelo         NUMBER(14) PRIMARY KEY,
    Nombre_Modelo     VARCHAR2(100) UNIQUE NOT NULL,
    Lugar_Fabricacion VARCHAR2(100),
    Fecha_Fabricacion DATE,
    Tipo_Vehiculo     VARCHAR2(50) NOT NULL, 
    codmarca          NUMBER(14),
    CONSTRAINT fk_mod_marca FOREIGN KEY (codmarca) REFERENCES MARCA(codmarca)
);

CREATE TABLE CLIENTE (
    codcliente     NUMBER(14) PRIMARY KEY,
    DNI            VARCHAR2(20) UNIQUE NOT NULL,
    Nombre         VARCHAR2(50) NOT NULL,
    Ap1            VARCHAR2(50) NOT NULL,
    Ap2            VARCHAR2(50),
    Contacto       VARCHAR2(100), 
    Direccion      VARCHAR2(255),
    Fecha_Registro DATE NOT NULL 
);

CREATE TABLE OFICINA (
    codoficina     NUMBER(14) PRIMARY KEY,
    Nombre_Oficina VARCHAR2(100),
    Direccion      VARCHAR2(255) UNIQUE NOT NULL
);

CREATE TABLE CURSO (
    codcurso     NUMBER(14) PRIMARY KEY,
    Nombre_Curso VARCHAR2(100) UNIQUE NOT NULL,
    Tipo_Curso   VARCHAR2(50)
);

CREATE TABLE EMPLEADO (
    codempleado        NUMBER(14) PRIMARY KEY,
    DNI                VARCHAR2(20) UNIQUE NOT NULL,
    Nombre             VARCHAR2(50) NOT NULL,
    Ap1                VARCHAR2(50) NOT NULL,
    Ap2                VARCHAR2(50),
    Contacto           VARCHAR2(100), 
    Puesto             VARCHAR2(50),
    Fecha_Contratacion DATE NOT NULL, 
    codoficina         NUMBER(14),
    CONSTRAINT fk_emp_oficina FOREIGN KEY (codoficina) REFERENCES OFICINA(codoficina)
);

CREATE TABLE VEHICULO (
    codvehiculo NUMBER(14) PRIMARY KEY,
    Matricula   VARCHAR2(20) UNIQUE NOT NULL,
    Anio_Compra NUMBER(4), 
    Estado      VARCHAR2(20),
    codmodelo   NUMBER(14),
    codoficina  NUMBER(14), 
    CONSTRAINT chk_estado_vehiculo 
        CHECK (Estado IN ('Disponible', 'Alquilado', 'En Taller', 'Baja')),
    CONSTRAINT fk_veh_modelo FOREIGN KEY (codmodelo) REFERENCES MODELO(codmodelo),
    CONSTRAINT fk_veh_oficina FOREIGN KEY (codoficina) REFERENCES OFICINA(codoficina)
);

CREATE TABLE ALQUILER (
    codalquiler     NUMBER(14) PRIMARY KEY,
    Fecha_Inicio    DATE NOT NULL,
    Fecha_Fin       DATE,
    Precio_Total    NUMBER(10,2), 
    Estado_Alquiler VARCHAR2(20),
    codcliente      NUMBER(14),
    codvehiculo     NUMBER(14),
    codempleado     NUMBER(14),
    CONSTRAINT chk_precio_alquiler CHECK (Precio_Total > 0),
    CONSTRAINT chk_estado_alquiler 
        CHECK (Estado_Alquiler IN ('Reservado', 'Activo', 'Finalizado', 'Cancelado')),
    CONSTRAINT fk_alq_cli FOREIGN KEY (codcliente)  REFERENCES CLIENTE(codcliente),
    CONSTRAINT fk_alq_veh FOREIGN KEY (codvehiculo) REFERENCES VEHICULO(codvehiculo),
    CONSTRAINT fk_alq_emp FOREIGN KEY (codempleado) REFERENCES EMPLEADO(codempleado)
);


/* 2. INSERCIÓN DE DATOS */

INSERT INTO MARCA (codmarca, Nombre, Descripcion, Pais_Origen, Historial)
VALUES (1, 'Toyota', 'Líder en fiabilidad y vehículos híbridos', 'Japón', 'Fundada en 1937');

INSERT INTO OFICINA (codoficina, Nombre_Oficina, Direccion)
VALUES (10, 'Oficina Central Atocha', 'Calle de Méndez Álvaro, 1, Madrid');

INSERT INTO CLIENTE (codcliente, DNI, Nombre, Ap1, Ap2, Contacto, Direccion, Fecha_Registro)
VALUES (100, '12345678Z', 'Lucía', 'Fernández', 'Ruiz', 'lucia.fer@email.com', 'Calle Mayor 15, Madrid', SYSDATE - 30);

INSERT INTO CURSO (codcurso, Nombre_Curso, Tipo_Curso)
VALUES (500, 'Atención al Cliente Premium', 'Ventas');

INSERT INTO MODELO (codmodelo, Nombre_Modelo, Lugar_Fabricacion, Fecha_Fabricacion, Tipo_Vehiculo, codmarca)
VALUES (20, 'Corolla Hybrid', 'Toyota City', TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'Turismo', 1);

INSERT INTO EMPLEADO (codempleado, DNI, Nombre, Ap1, Ap2, Contacto, Puesto, Fecha_Contratacion, codoficina)
VALUES (1000, '87654321X', 'Javier', 'Gómez', 'Pascual', 'j.gomez@rentacar.com', 'Agente de Ventas', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 10);

INSERT INTO VEHICULO (codvehiculo, Matricula, Anio_Compra, Estado, codmodelo, codoficina)
VALUES (5000, '1234-LMX', 2023, 'Disponible', 20, 10);

INSERT INTO ALQUILER (codalquiler, Fecha_Inicio, Fecha_Fin, Precio_Total, Estado_Alquiler, codcliente, codvehiculo, codempleado)
VALUES (9000, SYSDATE, SYSDATE + 7, 350.50, 'Activo', 100, 5000, 1000);


/* 3. ELIMINACIÓN DE TABLAS */

DROP TABLE ALQUILER CASCADE CONSTRAINTS PURGE;
DROP TABLE VEHICULO CASCADE CONSTRAINTS PURGE;
DROP TABLE EMPLEADO CASCADE CONSTRAINTS PURGE;
DROP TABLE CURSO CASCADE CONSTRAINTS PURGE;
DROP TABLE OFICINA CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE MODELO CASCADE CONSTRAINTS PURGE;
DROP TABLE MARCA CASCADE CONSTRAINTS PURGE;