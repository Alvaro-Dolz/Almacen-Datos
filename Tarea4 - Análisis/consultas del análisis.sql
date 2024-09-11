select AVG(Nota) from NotasSelectividad;

select AVG(COALESCE(notacalificacion, notacalificacionconvalidada)) from Calificaciones;

select distinct t.Año, AVG(Nota) over (partition by t.Año) as 'Nota Media' from NotasSelectividad n join Tiempo t on n.TiempoKey = t.TiempoKey order by t.Año;

select distinct a.genero, AVG(Nota) over (partition by a.genero)  as 'Nota Media' from NotasSelectividad n join Alumno a on n.AlumnoID = a.alumnoID;

select distinct a.genero, COUNT(DISTINCT n.AlumnoID) as 'Número Alumnos' from NotasSelectividad n join Alumno a on n.AlumnoID = a.alumnoID GROUP BY a.genero;

select distinct a.cod_asignatura, a.nombreasig, COUNT(*) over (partition by a.cod_asignatura) as 'Número Suspensos' from Calificaciones c join Asignaturas a on c.cod_asignatura = a.cod_asignatura where calificacion = 'SUSPENSO';

select distinct t.titulacionmec, COUNT(Distinct(alumnoID)) as 'Número Alumnos' from (select * from (select alumnoID, AVG(COALESCE(notacalificacion, notacalificacionconvalidada)) over (Partition by alumnoID) as 'Media', cod_asignatura from Calificaciones) as Subconsulta where Media >=5) as c join Asignaturas a on c.cod_asignatura = a.cod_asignatura join Titulación t on t.codtitulacion = a.codtitulacion group by t.titulacionmec;


select * from (select alumnoID, AVG(COALESCE(notacalificacion, notacalificacionconvalidada)) over (Partition by alumnoID) as 'Media', cod_asignatura from Calificaciones) as Subconsulta where Media >=5;