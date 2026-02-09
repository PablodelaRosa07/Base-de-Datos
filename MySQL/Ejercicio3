/* 1. CREACIÓN DE TABLAS */
CREATE TABLE CLIENTE (
    codcliente  NUMBER(14) PRIMARY KEY,
    DNI         VARCHAR2(20) UNIQUE NOT NULL,
    Nombre      VARCHAR2(50) NOT NULL,
    Ap1         VARCHAR2(50) NOT NULL,
    Ap2         VARCHAR2(50),
    Email       VARCHAR2(100), 
    Telefono    VARCHAR2(20)  
);

CREATE TABLE MARCA (
    codmarca     NUMBER(14) PRIMARY KEY,
    Nombre_Marca VARCHAR2(100) UNIQUE NOT NULL,
    Fabricante   VARCHAR2(100),
    Localizacion VARCHAR2(100)
);

CREATE TABLE MODELO (
    codmodelo         NUMBER(14) PRIMARY KEY,
    Nombre_Modelo     VARCHAR2(100) UNIQUE NOT NULL,
    Fecha_Lanzamiento DATE,
    Promo_Lanzamiento VARCHAR2(100),
    codmarca          NUMBER(14),
    CONSTRAINT fk_modelo_marca FOREIGN KEY (codmarca) REFERENCES MARCA(codmarca)
);

CREATE TABLE PRECIO (
    codprecio    NUMBER(14) PRIMARY KEY,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin    DATE,
    Monto_Precio NUMBER(10,2) NOT NULL, 
    codmodelo    NUMBER(14),
    CONSTRAINT chk_monto_positivo CHECK (Monto_Precio > 0),
    CONSTRAINT fk_precio_modelo FOREIGN KEY (codmodelo) REFERENCES MODELO(codmodelo)
);

CREATE TABLE TIENDA (
    codtienda     NUMBER(14) PRIMARY KEY,
    Nombre_Tienda VARCHAR2(100) NOT NULL,
    Tipo_Tienda   VARCHAR2(50),
    Direccion     VARCHAR2(100) UNIQUE NOT NULL
);

CREATE TABLE FISICA (
    codfisica NUMBER(14) PRIMARY KEY,
    Direccion VARCHAR2(100) UNIQUE NOT NULL,
    codtienda NUMBER(14),
    CONSTRAINT fk_fisica_tienda FOREIGN KEY (codtienda) REFERENCES TIENDA(codtienda)
);

CREATE TABLE ONLINES ( /* Lo pongo en plural porque en singular me da error */
    codonline NUMBER(14) PRIMARY KEY,
    Web       VARCHAR2(100) UNIQUE NOT NULL,
    codtienda NUMBER(14),
    CONSTRAINT fk_online_tienda FOREIGN KEY (codtienda) REFERENCES TIENDA(codtienda)
);

CREATE TABLE MOVIL (
    codmovil  NUMBER(14) PRIMARY KEY,
    Color     VARCHAR2(30),
    Capacidad VARCHAR2(50),
    codmodelo NUMBER(14),
    codtienda NUMBER(14),
    CONSTRAINT fk_movil_modelo FOREIGN KEY (codmodelo) REFERENCES MODELO(codmodelo),
    CONSTRAINT fk_movil_tienda FOREIGN KEY (codtienda) REFERENCES TIENDA(codtienda)
);

CREATE TABLE EMPLEADO (
    codempleado NUMBER(14) PRIMARY KEY,
    DNI         VARCHAR2(20) UNIQUE NOT NULL,
    Nombre      VARCHAR2(50) NOT NULL,
    Ap1         VARCHAR2(50) NOT NULL,
    Ap2         VARCHAR2(50),
    Cargo       VARCHAR2(50),
    codtienda   NUMBER(14),
    CONSTRAINT fk_empleado_tienda FOREIGN KEY (codtienda) REFERENCES TIENDA(codtienda)
);

CREATE TABLE VENTA (
    codventa    NUMBER(14) PRIMARY KEY,
    Fecha_Venta DATE DEFAULT SYSDATE,
    Tipo_Venta  VARCHAR2(50),
    codcliente  NUMBER(14),
    codempleado NUMBER(14),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (codcliente) REFERENCES CLIENTE(codcliente),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (codempleado) REFERENCES EMPLEADO(codempleado)
);

CREATE TABLE LINEA_VENTA (
    codlineaventa NUMBER(14) PRIMARY KEY,
    Fecha_Cliente DATE NOT NULL,
    Num_Linea     NUMBER(4) NOT NULL,
    Precio_Final  NUMBER(10,2) NOT NULL,
    codmovil      NUMBER(14),
    codventa      NUMBER(14),
    codprecio     NUMBER(14),
    CONSTRAINT chk_precio_lv CHECK (Precio_Final >= 0),
    CONSTRAINT fk_lv_movil  FOREIGN KEY (codmovil) REFERENCES MOVIL(codmovil),
    CONSTRAINT fk_lv_venta  FOREIGN KEY (codventa) REFERENCES VENTA(codventa),
    CONSTRAINT fk_lv_precio FOREIGN KEY (codprecio) REFERENCES PRECIO(codprecio)
);

CREATE TABLE PROVEEDOR (
    codproveedor     NUMBER(14) PRIMARY KEY,
    Nombre_Proveedor VARCHAR2(100) NOT NULL,
    Contacto         VARCHAR2(100),
    Telefono         VARCHAR2(20)
);


/* 2. INSERCIÓN DE DATOS */

INSERT INTO CLIENTE (codcliente, DNI, Nombre, Ap1, Ap2, Email, Telefono) 
VALUES (1, '12345678A', 'Ana', 'García', 'López', 'ana.garcia@email.com', '600111222');

INSERT INTO MARCA (codmarca, Nombre_Marca, Fabricante, Localizacion) 
VALUES (10, 'Apple', 'Apple Inc.', 'California, USA');

INSERT INTO TIENDA (codtienda, Nombre_Tienda, Tipo_Tienda, Direccion) 
VALUES (100, 'Apple Store Sol', 'Física', 'Puerta del Sol 1, Madrid');

INSERT INTO PROVEEDOR (codproveedor, Nombre_Proveedor, Contacto, Telefono) 
VALUES (500, 'TechDistribución S.A.', 'Carlos Ruiz', '910000000');

INSERT INTO MODELO (codmodelo, Nombre_Modelo, Fecha_Lanzamiento, Promo_Lanzamiento, codmarca) 
VALUES (20, 'iPhone 15 Pro', TO_DATE('2023-09-22', 'YYYY-MM-DD'), 'Reserva ya', 10);

INSERT INTO FISICA (codfisica, Direccion, codtienda) 
VALUES (101, 'Puerta del Sol 1, Madrid', 100);

INSERT INTO ONLINES (codonline, Web, codtienda) 
VALUES (102, 'www.apple.com/es', 100);

INSERT INTO EMPLEADO (codempleado, DNI, Nombre, Ap1, Ap2, Cargo, codtienda) 
VALUES (300, '87654321B', 'Marcos', 'Pérez', 'Sanz', 'Vendedor Senior', 100);

INSERT INTO PRECIO (codprecio, Fecha_Inicio, Fecha_Fin, Monto_Precio, codmodelo) 
VALUES (40, TO_DATE('2023-09-22', 'YYYY-MM-DD'), NULL, 1219.00, 20);

INSERT INTO MOVIL (codmovil, Color, Capacidad, codmodelo, codtienda) 
VALUES (50, 'Titanio Natural', '256GB', 20, 100);

INSERT INTO VENTA (codventa, Fecha_Venta, Tipo_Venta, codcliente, codempleado) 
VALUES (1000, SYSDATE, 'Presencial', 1, 300);

INSERT INTO LINEA_VENTA (codlineaventa, Fecha_Cliente, Num_Linea, Precio_Final, codmovil, codventa, codprecio) 
VALUES (5000, SYSDATE, 1, 1219.00, 50, 1000, 40);


/* 3. ELIMINACIÓN DE TABLAS */

DROP TABLE LINEA_VENTA CASCADE CONSTRAINTS PURGE;
DROP TABLE VENTA CASCADE CONSTRAINTS PURGE;
DROP TABLE MOVIL CASCADE CONSTRAINTS PURGE;
DROP TABLE PRECIO CASCADE CONSTRAINTS PURGE;
DROP TABLE MODELO CASCADE CONSTRAINTS PURGE;
DROP TABLE MARCA CASCADE CONSTRAINTS PURGE;
DROP TABLE FISICA CASCADE CONSTRAINTS PURGE;
DROP TABLE ONLINES CASCADE CONSTRAINTS PURGE;
DROP TABLE EMPLEADO CASCADE CONSTRAINTS PURGE;
DROP TABLE TIENDA CASCADE CONSTRAINTS PURGE;
DROP TABLE PROVEEDOR CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE;