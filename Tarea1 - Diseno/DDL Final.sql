-- Crear la base de datos AlmacenDatos
CREATE DATABASE ProyectoA_V2;
GO

-- Usar la base de datos AlmacenDatos
USE ProyectoA_V2;
GO

-- Definición de la dimensión Tiempo
CREATE TABLE TiempoCalificaciones (
	cod_curso INT PRIMARY KEY IDENTITY(1,1),
    curso VARCHAR(255),
    añoiniciocurso INT,
    añofincurso INT
);

-- Definición de la dimensión Alumno
CREATE TABLE Alumno (
    alumnoID BIGINT PRIMARY KEY,
    nota_acceso DECIMAL(4, 2),
    año_acceso INT,
    via_acceso VARCHAR(255),
    forma_acceso VARCHAR(255),
    genero VARCHAR(255),
    fin_estudio DATE,
    inglespresentado VARCHAR(255),
    cod_titulacion_FinEstudios VARCHAR(255),
    cod_titulacion_Ingreso VARCHAR(255)
);

-- Definición de la dimensión Universidad
CREATE TABLE Universidad (
    UniversidadKey INT PRIMARY KEY IDENTITY(1,1),
    nombreuniversidad VARCHAR(100)
);


-- Definición de la dimensión Centro
CREATE TABLE Centro (
    centrokey INT PRIMARY KEY IDENTITY(1,1),
    nombrecentro VARCHAR(100),
    universidadkey INT,
    FOREIGN KEY (universidadkey) REFERENCES Universidad(UniversidadKey)
);

-- Definición de la dimensión Titulación
CREATE TABLE Titulación (
    codtitulacion VARCHAR(255) PRIMARY KEY,
    titulacionmec VARCHAR(120),
    creditosmax INT,
    centrokey INT,
    FOREIGN KEY (centrokey) REFERENCES Centro(centrokey)
);


-- Definición de la dimensión Asignatura
CREATE TABLE Asignaturas (
    cod_asignatura INT PRIMARY KEY,
    nombreasig VARCHAR(255),
    créditos INT,
    tipocredito VARCHAR(255),
	curso_asignatura VARCHAR(255),
    codtitulacion VARCHAR(255),
    FOREIGN KEY (codtitulacion) REFERENCES Titulación(codtitulacion)
);

-- Definición de la tabla de hechos: Calificaciones
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

--Definición de la dimensión Materia

CREATE TABLE Materia (
    CodMateria INT PRIMARY KEY IDENTITY(1,1),
    NombreMateria VARCHAR(255)
);

--Definición de la dimensión Tiempo

CREATE TABLE Tiempo (
	TiempoKey INT PRIMARY KEY IDENTITY(1,1),
    Año INT,
    Convocatoria VARCHAR(30)
);

--Definición de la dimensión AsignaturaSelectividad

CREATE TABLE AsignaturaSelectividad (
    AsignaturaKey INT PRIMARY KEY IDENTITY(1,1),
    nombreAsignatura VARCHAR(255),
    CodMateria INT,
    FOREIGN KEY (CodMateria) REFERENCES Materia(CodMateria)
);

--Definición de la tabla de hechos: NotasSelectividad

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