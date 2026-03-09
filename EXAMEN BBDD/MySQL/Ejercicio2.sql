/* 1. CREACIÓN DE TABLAS */

CREATE TABLE UNIVERSIDAD (
    coduniversidad INT PRIMARY KEY,
    Nombre_Universidad VARCHAR(100) NOT NULL
);

CREATE TABLE GRADO (
    codgrado INT PRIMARY KEY,
    Nombre_Grado VARCHAR(100) NOT NULL,
    Curso_Grado VARCHAR(50)
);

CREATE TABLE MASTER (
    codmaster INT PRIMARY KEY,
    Nombre_Master VARCHAR(100) NOT NULL,
    Curso_Master VARCHAR(50)
);

CREATE TABLE SEDE (
    codsede INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) UNIQUE
);

CREATE TABLE PERSONAL (
    codpersonal INT PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(50),
    Ap1 VARCHAR(50),
    Ap2 VARCHAR(50),
    Rol VARCHAR(50)
);

CREATE TABLE LIBRO (
    codlibro INT PRIMARY KEY,
    Nombre_Libro VARCHAR(150) NOT NULL,
    codsede INT,
    CONSTRAINT fk_sede_libro FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede) ON DELETE CASCADE
);

CREATE TABLE CAMARA (
    codcamara INT PRIMARY KEY,
    Nombre_Camara VARCHAR(100),
    codsede INT,
    CONSTRAINT fk_sede_camara FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede) ON DELETE CASCADE
);

CREATE TABLE BIBLIOTECA (
    codbiblioteca INT PRIMARY KEY,
    codpersonal INT,
    codlibro INT,
    codsede INT,
    CONSTRAINT fk_personal_biblio FOREIGN KEY (codpersonal) 
        REFERENCES PERSONAL(codpersonal),
    CONSTRAINT fk_libro_biblio FOREIGN KEY (codlibro) 
        REFERENCES LIBRO(codlibro),
    CONSTRAINT fk_sede_biblio FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede)
);

CREATE TABLE ALUMNO (
    codalumno INT PRIMARY KEY,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Ap1 VARCHAR(50) NOT NULL,
    Ap2 VARCHAR(50),
    Curso VARCHAR(20),
    Contacto VARCHAR(100),
    CONSTRAINT chk_curso_alumno CHECK (Curso IN ('Grado', 'Master', 'Universidad'))
);

CREATE TABLE PRESTAMO (
    codprestamo INT PRIMARY KEY,
    Fecha_Reserva DATE,
    Fecha_Retiro DATE,
    Fecha_Devolucion DATE,
    Estado VARCHAR(15),
    Dias_Retraso INT DEFAULT 0,
    CONSTRAINT chk_estado_prestamo CHECK (Estado IN ('Activo', 'Devuelto', 'Perdido', 'Retraso'))
);

CREATE TABLE SERVICIO_TECNICO (
    codserviciotecnico INT PRIMARY KEY,
    codpersonal INT,
    codcamara INT,
    codsede INT,
    CONSTRAINT fk_personal_st FOREIGN KEY (codpersonal) 
        REFERENCES PERSONAL(codpersonal),
    CONSTRAINT fk_camara_st FOREIGN KEY (codcamara) 
        REFERENCES CAMARA(codcamara),
    CONSTRAINT fk_sede_st FOREIGN KEY (codsede) 
        REFERENCES SEDE(codsede)
);

/* 2. INSERCIÓN DE DATOS */

INSERT INTO UNIVERSIDAD (coduniversidad, Nombre_Universidad) 
VALUES (1, 'Universidad Complutense de Madrid');

INSERT INTO GRADO (codgrado, Nombre_Grado, Curso_Grado) 
VALUES (1, 'Ingeniería Informática', '2023-2024');

INSERT INTO MASTER (codmaster, Nombre_Master, Curso_Master) 
VALUES (1, 'Inteligencia Artificial', '2024-2025');

INSERT INTO SEDE (codsede, Nombre, Direccion) 
VALUES (1, 'Campus Central', 'Calle de la Victoria, 25');
INSERT INTO SEDE (codsede, Nombre, Direccion) 
VALUES (2, 'Campus Tecnológico', 'Avenida del Software, 10');

INSERT INTO PERSONAL (codpersonal, DNI, Nombre, Ap1, Ap2, Rol) 
VALUES (1, '12345678A', 'Juan', 'Pérez', 'García', 'Bibliotecario');
INSERT INTO PERSONAL (codpersonal, DNI, Nombre, Ap1, Ap2, Rol) 
VALUES (2, '87654321B', 'Ana', 'López', 'Sánchez', 'Técnico');

INSERT INTO LIBRO (codlibro, Nombre_Libro, codsede) 
VALUES (1, 'Fundamentos de SQL', 1);

INSERT INTO CAMARA (codcamara, Nombre_Camara, codsede) 
VALUES (1, 'Nikon D850 - Vigilancia 01', 2);

INSERT INTO ALUMNO (codalumno, DNI, Nombre, Ap1, Ap2, Curso, Contacto) 
VALUES (1, '11223344C', 'Carlos', 'Ruiz', 'Mera', 'Grado', 'carlos.ruiz@email.com');

INSERT INTO PRESTAMO (codprestamo, Fecha_Reserva, Fecha_Retiro, Fecha_Devolucion, Estado, Dias_Retraso) 
VALUES (1, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-02', 'YYYY-MM-DD'), NULL, 'Activo', 0);

INSERT INTO BIBLIOTECA (codbiblioteca, codpersonal, codlibro, codsede) 
VALUES (1, 1, 1, 1);

INSERT INTO SERVICIO_TECNICO (codserviciotecnico, codpersonal, codcamara, codsede) 
VALUES (1, 2, 1, 2);



/* 3. ELIMINACIÓN DE TABLAS */

DROP TABLE ALUMNO CASCADE CONSTRAINTS PURGE;
DROP TABLE BIBLIOTECA CASCADE CONSTRAINTS PURGE;
DROP TABLE CAMARA CASCADE CONSTRAINTS PURGE;
DROP TABLE GRADO CASCADE CONSTRAINTS PURGE;
DROP TABLE LIBRO CASCADE CONSTRAINTS PURGE;
DROP TABLE MASTER CASCADE CONSTRAINTS PURGE;
DROP TABLE PERSONAL CASCADE CONSTRAINTS PURGE;
DROP TABLE PRESTAMO CASCADE CONSTRAINTS PURGE;
DROP TABLE SEDE CASCADE CONSTRAINTS PURGE;
DROP TABLE SERVICIO_TECNICO CASCADE CONSTRAINTS PURGE;
DROP TABLE UNIVERSIDAD CASCADE CONSTRAINTS PURGE;