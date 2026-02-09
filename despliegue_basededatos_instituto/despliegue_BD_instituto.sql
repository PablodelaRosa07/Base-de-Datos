/*
*
* Creamos la estructur de la base de datos del instituto
*
*/

/*
*
*  1º DDL
*
*/


-- CREATE TABLES

CREATE TABLE Alumno(
	CodAlum number(16) PRIMARY KEY,
	DNI varchar2(9),
	Nombre varchar2(32),
	PrimerAp varchar2(32),
	SegundoAp varchar2(32)
);

CREATE TABLE Departamento	(
	CodDep number(16) PRIMARY KEY,
	Nombre varchar2(32),
	Abreviatura varchar2(5)
);

CREATE TABLE CicloFormativo	(
	CodCF number(16) PRIMARY KEY,
	Nombre varchar2(32),
	Abreviatura varchar2(5)
);

CREATE TABLE Docente(
	CodDocente number(16) PRIMARY KEY,
	DNI varchar2(9),
	Nombre varchar2(32),
	PrimerAp varchar2(32),
	SegundoAp varchar2(32),
	CodDep number(16),   
  CONSTRAINT fk_docente_dep FOREIGN KEY (CodDep) REFERENCES Departamento(CodDep) ON DELETE CASCADE
);

CREATE TABLE Asignatura(
CodAsig number(16) PRIMARY KEY,
CodCF number(16) ,
NumHoras number(3),
Nombre varchar2(50) NOT NULL,
Abreviatura varchar2(6),
Curso varchar2(10),
CONSTRAINT fk_asig_ciclo FOREIGN KEY (CodCF) REFERENCES CicloFormativo (CodCF)
);

CREATE TABLE DocAsig	(
	CodDocente number(16),
	CodAsig number(16),
	PerAcademico varchar(5),
  CONSTRAINT pk_DocAsig PRIMARY KEY(CodDocente, CodAsig, PerAcademico),
  CONSTRAINT fk_DocAsig_doc FOREIGN KEY (CodDocente) REFERENCES Docente(CodDocente) ON DELETE CASCADE,
  CONSTRAINT fk_DocAsig_asi FOREIGN KEY (CodAsig) REFERENCES Asignatura(CodAsig) ON DELETE CASCADE
);

CREATE TABLE Matricula (
	CodAlumno number (16),
  CodAsig number (16),
  PerAcademico varchar2 (5),
  Nota number (2),
  CONSTRAINT pk_Matricula PRIMARY KEY(CodAlumno, CodAsig, PerAcademico),
  CONSTRAINT fk_CodAlumno_matric FOREIGN KEY (CodAlumno) REFERENCES Alumno(CodAlum) ON DELETE CASCADE,
  CONSTRAINT fk_CodAsig_matric FOREIGN KEY (CodAsig) REFERENCES Asignatura(CodAsig) ON DELETE CASCADE
);




/*
*
*  2º DML
*
*/

-- INSERTS





-- DROP 