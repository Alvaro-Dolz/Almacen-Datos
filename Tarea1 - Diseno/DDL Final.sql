-- Crear la base de datos AlmacenDatos
CREATE DATABASE ProyectoA_V2;
GO

-- Usar la base de datos AlmacenDatos
USE ProyectoA_V2;
GO

-- Definici�n de la dimensi�n Tiempo
CREATE TABLE TiempoCalificaciones (
	cod_curso INT PRIMARY KEY IDENTITY(1,1),
    curso VARCHAR(255),
    a�oiniciocurso INT,
    a�ofincurso INT
);

-- Definici�n de la dimensi�n Alumno
CREATE TABLE Alumno (
    alumnoID BIGINT PRIMARY KEY,
    nota_acceso DECIMAL(4, 2),
    a�o_acceso INT,
    via_acceso VARCHAR(255),
    forma_acceso VARCHAR(255),
    genero VARCHAR(255),
    fin_estudio DATE,
    inglespresentado VARCHAR(255),
    cod_titulacion_FinEstudios VARCHAR(255),
    cod_titulacion_Ingreso VARCHAR(255)
);

-- Definici�n de la dimensi�n Universidad
CREATE TABLE Universidad (
    UniversidadKey INT PRIMARY KEY IDENTITY(1,1),
    nombreuniversidad VARCHAR(100)
);


-- Definici�n de la dimensi�n Centro
CREATE TABLE Centro (
    centrokey INT PRIMARY KEY IDENTITY(1,1),
    nombrecentro VARCHAR(100),
    universidadkey INT,
    FOREIGN KEY (universidadkey) REFERENCES Universidad(UniversidadKey)
);

-- Definici�n de la dimensi�n Titulaci�n
CREATE TABLE Titulaci�n (
    codtitulacion VARCHAR(255) PRIMARY KEY,
    titulacionmec VARCHAR(120),
    creditosmax INT,
    centrokey INT,
    FOREIGN KEY (centrokey) REFERENCES Centro(centrokey)
);


-- Definici�n de la dimensi�n Asignatura
CREATE TABLE Asignaturas (
    cod_asignatura INT PRIMARY KEY,
    nombreasig VARCHAR(255),
    cr�ditos INT,
    tipocredito VARCHAR(255),
	curso_asignatura VARCHAR(255),
    codtitulacion VARCHAR(255),
    FOREIGN KEY (codtitulacion) REFERENCES Titulaci�n(codtitulacion)
);

-- Definici�n de la tabla de hechos: Calificaciones
CREATE TABLE Calificaciones (
    alumnoID BIGINT,
    cod_asignatura INT,
    cod_curso INT,
    notacalificacion DECIMAL(4, 2),
    notacalificacionconvalidada DECIMAL(4, 2),
    calificacionconv VARCHAR(255),
    notaconvalidada VARCHAR(255),
    calificacion VARCHAR(255),
    PRIMARY KEY (alumnoID, cod_asignatura, cod_curso),
    FOREIGN KEY (alumnoID) REFERENCES Alumno(alumnoID),
    FOREIGN KEY (cod_asignatura) REFERENCES Asignaturas(cod_asignatura),
	FOREIGN KEY (cod_curso) REFERENCES TiempoCalificaciones(cod_curso)
);

--Definici�n de la dimensi�n Materia

CREATE TABLE Materia (
    CodMateria INT PRIMARY KEY IDENTITY(1,1),
    NombreMateria VARCHAR(255)
);

--Definici�n de la dimensi�n Tiempo

CREATE TABLE Tiempo (
	TiempoKey INT PRIMARY KEY IDENTITY(1,1),
    A�o INT,
    Convocatoria VARCHAR(30)
);

--Definici�n de la dimensi�n AsignaturaSelectividad

CREATE TABLE AsignaturaSelectividad (
    AsignaturaKey INT PRIMARY KEY IDENTITY(1,1),
    nombreAsignatura VARCHAR(255),
    CodMateria INT,
    FOREIGN KEY (CodMateria) REFERENCES Materia(CodMateria)
);

--Definici�n de la tabla de hechos: NotasSelectividad

CREATE TABLE NotasSelectividad (
    AlumnoID BIGINT,
    AsignaturaKey INT,
   	TiempoKey INT,
    Nota DECIMAL(4, 2),
    PRIMARY KEY (AlumnoID, AsignaturaKey, TiempoKey),
    FOREIGN KEY (AsignaturaKey) REFERENCES AsignaturaSelectividad(AsignaturaKey),
    FOREIGN KEY (TiempoKey) REFERENCES Tiempo(TiempoKey),
    FOREIGN KEY (AlumnoID) REFERENCES Alumno(alumnoID)
);