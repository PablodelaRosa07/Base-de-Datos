/* CREATES */

CREATE TABLE Alumno(
CodAlum NUMBER(16) PRIMARY KEY,
DNI VARCHAR2(9),
Nombre VARCHAR2(64),
PrimerAp VARCHAR2(32),
SegundoAp VARCHAR2(32)
);
CREATE TABLE Departamento (
CodDep NUMBER(16) PRIMARY KEY,
Nombre VARCHAR2(64),
Abreviatura VARCHAR2(5)
);
CREATE TABLE CicloFormativo (
CodCF NUMBER(16) PRIMARY KEY,
Nombre VARCHAR2(64),
Abreviatura VARCHAR2(5)
);
CREATE TABLE Docente(
CodDocente NUMBER(16) PRIMARY KEY,
DNI VARCHAR2(9),
Nombre VARCHAR2(64),
PrimerAp VARCHAR2(32),
SegundoAp VARCHAR2(32),
CodDep NUMBER(16),
CONSTRAINT fk_docente_dep FOREIGN KEY (CodDep)
REFERENCES Departamento(CodDep) ON DELETE CASCADE
);
CREATE TABLE Asignatura(
CodAsig NUMBER(16) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Abreviatura VARCHAR2(6),
NumHoras NUMBER(3),
Curso VARCHAR2(10),
CodCF NUMBER(16),
CONSTRAINT fk_asig_ciclo FOREIGN KEY (CodCF)
REFERENCES CicloFormativo (CodCF)
);
CREATE TABLE DocAsig(
CodDocente NUMBER(16),
CodAsig NUMBER(16),
PerAcademico VARCHAR2(5),
CONSTRAINT pk_DocAsig PRIMARY KEY(CodDocente, CodAsig, PerAcademico),
CONSTRAINT fk_DocAsig_doc FOREIGN KEY (CodDocente)
REFERENCES Docente(CodDocente) ON DELETE CASCADE,
CONSTRAINT fk_DocAsig_asi FOREIGN KEY (CodAsig)
REFERENCES Asignatura(CodAsig) ON DELETE CASCADE
);
CREATE TABLE Matricula(
CodAlumno NUMBER(16),
CodAsig NUMBER(16),
PerAcademico VARCHAR2(5),
Nota NUMBER(4,2),
CONSTRAINT pk_Matricula PRIMARY KEY(CodAlumno, CodAsig, PerAcademico),
CONSTRAINT fk_CodAlumno_matric FOREIGN KEY (CodAlumno)
REFERENCES Alumno(CodAlum) ON DELETE CASCADE,
CONSTRAINT fk_CodAsig_matric FOREIGN KEY (CodAsig)
REFERENCES Asignatura(CodAsig) ON DELETE CASCADE
);



/* SEQUENCES */

CREATE SEQUENCE seqAlumno START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqDepartamento START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqCF START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqDocente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seqAsignatura START WITH 1 INCREMENT BY 1;



/* INSERTS */

INSERT INTO Alumno VALUES
(seqAlumno.NEXTVAL,'12121212D','Rosa','Blanco','Montero');
INSERT INTO Alumno VALUES
(seqAlumno.NEXTVAL,'23232323R','Concepción','García','Ramos');
INSERT INTO Alumno VALUES (seqAlumno.NEXTVAL,'12121212T','Ángel','Luque','Nieto');
INSERT INTO Alumno VALUES (seqAlumno.NEXTVAL,'23232323E','Juan','Muñoz','Sanz');
INSERT INTO Alumno VALUES (seqAlumno.NEXTVAL,'12121212V','Jose
María','López','Gómez');
INSERT INTO Alumno VALUES
(seqAlumno.NEXTVAL,'23232323W','Antonio','Domínguez','López');
INSERT INTO Alumno VALUES (seqAlumno.NEXTVAL,'12121212X','María','Cea','Ruíz');
INSERT INTO Alumno VALUES
(seqAlumno.NEXTVAL,'23232323Y','Elizabeth','Fournie',NULL);
INSERT INTO Departamento VALUES (seqDepartamento.NEXTVAL,'Tecnología de la
Información y Comunicación','TIC');
INSERT INTO Departamento VALUES (seqDepartamento.NEXTVAL,'Administración y
Finanzas','AYF');
INSERT INTO CicloFormativo VALUES (seqCF.NEXTVAL,'Desarrollo de Aplicaciones
Web','DAW');
INSERT INTO CicloFormativo VALUES (seqCF.NEXTVAL,'Desarrollo de Aplicaciones
Multiplataforma','DAM');
INSERT INTO CicloFormativo VALUES (seqCF.NEXTVAL,'Administración de Sistemas
Informáticos en Red','ASIR');
INSERT INTO Docente VALUES
(seqDocente.NEXTVAL,'11111111Y','Javier','Prada','Oliva',1);
INSERT INTO Docente VALUES
(seqDocente.NEXTVAL,'222222H','Daniel','Muñiz','Amian',1);
INSERT INTO Docente VALUES
(seqDocente.NEXTVAL,'333333K','Soraya','López',NULL,1);
INSERT INTO Docente VALUES
(seqDocente.NEXTVAL,'44444444I','María','Pastor',NULL,2);
INSERT INTO Asignatura (CodAsig, Nombre, Abreviatura, NumHoras, Curso, CodCF)
VALUES (1,'Base de datos','BBDD',165,'Primero',1);
INSERT INTO Asignatura VALUES (2,'Lenguajes de Marcas','LDM',120,'Primero',1);
INSERT INTO Asignatura VALUES (3,'Sistemas Informáticos','SI',NULL,'Primero',1);
INSERT INTO Asignatura VALUES (4,'Entornos de Desarrollo','EDD',NULL,'Primero',1);
INSERT INTO Asignatura VALUES (5,'Programación','PROG',190,'Primero',1);
INSERT INTO Asignatura VALUES (6,'Formación y Orientación
Laboral','FOL',90,'Primero',1);
INSERT INTO Asignatura VALUES (7,'Base de datos','BBDD',165,'Primero',2);
INSERT INTO Asignatura VALUES (8,'Lenguajes de Marcas','LDM',120,'Primero',2);
INSERT INTO Asignatura VALUES (9,'Sistemas Informáticos','SI',NULL,'Primero',2);
INSERT INTO Asignatura VALUES (10,'Programación','PROG',190,'Primero',2);
INSERT INTO Asignatura VALUES (11,'IPE I','FOL',90,'Primero',3);
INSERT INTO DocAsig VALUES (1,1,'21/22');
INSERT INTO DocAsig VALUES (1,2,'21/22');
INSERT INTO DocAsig VALUES (1,7,'21/22');
INSERT INTO DocAsig VALUES (1,8,'21/22');
INSERT INTO DocAsig VALUES (2,3,'21/22');
INSERT INTO DocAsig VALUES (2,4,'21/22');
INSERT INTO DocAsig VALUES (2,9,'21/22');
INSERT INTO DocAsig VALUES (3,5,'21/22');
INSERT INTO DocAsig VALUES (3,10,'21/22');
INSERT INTO DocAsig VALUES (4,6,'21/22');
INSERT INTO DocAsig VALUES (4,11,'21/22');
INSERT INTO Matricula VALUES (1,1,'21/22',4);
INSERT INTO Matricula VALUES (1,2,'21/22',5);
INSERT INTO Matricula VALUES (1,3,'21/22',NULL);
INSERT INTO Matricula VALUES (1,4,'21/22',NULL);
INSERT INTO Matricula VALUES (2,1,'21/22',8);
INSERT INTO Matricula VALUES (2,2,'21/22',NULL);
INSERT INTO Matricula VALUES (2,3,'21/22',NULL);
INSERT INTO Matricula VALUES (3,1,'21/22',5);
INSERT INTO Matricula VALUES (3,2,'21/22',6);
INSERT INTO Matricula VALUES (4,1,'21/22',9);
INSERT INTO Matricula VALUES (4,2,'21/22',3);



/* DROPS */

DROP TABLE Matricula CASCADE CONSTRAINTS;
DROP TABLE DocAsig CASCADE CONSTRAINTS;
DROP TABLE Asignatura CASCADE CONSTRAINTS;
DROP TABLE Docente CASCADE CONSTRAINTS;
DROP TABLE CicloFormativo CASCADE CONSTRAINTS;
DROP TABLE Departamento CASCADE CONSTRAINTS;
DROP TABLE Alumno CASCADE CONSTRAINTS;
DROP SEQUENCE seqAlumno;
DROP SEQUENCE seqDepartamento;
DROP SEQUENCE seqCF;
DROP SEQUENCE seqDocente;
DROP SEQUENCE seqAsignatura;