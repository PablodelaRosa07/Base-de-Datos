-- 1. (Cursor) Elabora un cursor cuando acceda a todas las notas aprobadas en el sistema actualice nombre de la siguiente forma:
-- Nombre - APROBADO.

DECLARE
    CURSOR c1 IS
        SELECT alum.Nombre, mat.Nota
        FROM Alumno alum
        JOIN Matricula mat ON alum.CodAlum = mat.CodAlumno
        WHERE mat.Nota >= 5;
        
    v_Alumno Alumno.Nombre%TYPE;
    v_Nota   Matricula.Nota%TYPE;

BEGIN
    -- 1. Apertura del cursor
    OPEN c1;

    LOOP
        -- 2. Recuperación de los datos fila por fila
        FETCH c1 INTO v_Alumno, v_Nota;

        -- 3. Condición de salida si ya no hay más registros
        EXIT WHEN c1%NOTFOUND;

        -- 4. Modificación solicitada: Actualizamos el nombre en la tabla Alumno
        UPDATE Alumno
        SET Nombre = v_Alumno || ' - APROBADO'
        WHERE Nombre = v_Alumno;

    END LOOP;

    -- 5. Cierre del cursor
    CLOSE c1;
    
    -- Guardamos los cambios en la base de datos de forma permanente
    COMMIT;
END;





-- 2. (Trigger) Crea un disparador que después de actualizar cualquier asignatura aumente en un 15% su horas

CREATE OR REPLACE TRIGGER trg_aumentar_horas_asig
AFTER UPDATE ON Asignatura
FOR EACH ROW
BEGIN
    -- Mostramos la información informativa tal como tenías planteado
    DBMS_OUTPUT.PUT_LINE('Se ha actualizado la asignatura: ' || :OLD.Nombre);
    DBMS_OUTPUT.PUT_LINE('Horas anteriores: ' || :OLD.NumHoras);
    DBMS_OUTPUT.PUT_LINE('Nuevas horas reales (+15%): ' || (:OLD.NumHoras * 1.15));

    -- Modificación: Realizamos la actualización real del campo en la base de datos
    -- Nota: Usamos la clave primaria para identificar la fila exacta (asumiendo que es CodAsig)
    UPDATE Asignatura
    SET NumHoras = :OLD.NumHoras * 1.15
    WHERE CodAsig = :OLD.CodAsig;

END;
