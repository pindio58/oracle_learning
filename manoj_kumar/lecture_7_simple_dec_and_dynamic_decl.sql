/*
Here we will study simple and dynamic declartions
    Simple we alredy know
    for dynamic, we use some other table's column's datatype
    
When we face issue ehile declaring datatype because of size, type etc. 
we can avoid this kind of problem by using type comparabliy %type
*/

DROP PROCEDURE procedure_name;
--
CREATE PROCEDURE procedure_name AS
    v_name VARCHAR2(100);
BEGIN
    SELECT
        first_name
        || ' '
        || last_name
    INTO v_name
    FROM
        hr.employees
    WHERE
        employee_id = 100;

    dbms_output.put_line(v_name);
END;

SET SERVEROUTPUT ON;

BEGIN
    procedure_name;
END;

DROP TABLE emps;

CREATE TABLE emps
    AS
        SELECT
            *
        FROM
            hr.employees
        WHERE
            ROWNUM <= 10;

SELECT
    *
FROM
    emps;

----- dynamic ---

CREATE or REPLACE PROCEDURE procedure_name AS
    v_name emps.last_name%TYPE;
    v_sal  emps.salary%TYPE;
BEGIN
    SELECT
        last_name,
        salary
    INTO
        v_name,
        v_sal
    FROM
        hr.employees
    WHERE
        employee_id = 100;

    dbms_output.put_line(v_name);
EXCEPTION
    WHEN OTHERS THEN
--v_name='Name';
        dbms_output.put_line('singh');
END; 
/
----------------



