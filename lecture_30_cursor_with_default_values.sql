/*
Below is some randoms stuff
*/

SELECT
    column_value name
FROM
    TABLE ( sys.dbms_debug_vc2coll(60, 100) );

--========================================================================

DECLARE
    v2 VARCHAR2(40);
    CURSOR c1 IS
    SELECT
        column_value name
    FROM
        TABLE ( sys.dbms_debug_vc2coll(60, 100) );
BEGIN
    OPEN c1;
    FETCH c1 INTO v2;
    LOOP
        dbms_output.put_line(v2);
    END LOOP;
    CLOSE c1;
END;


--========================================================================
-- Here starts the actual lecture
--========================================================================
create table emps as select * from hr.employees;

DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE
    ) IS
    SELECT
        last_name,
        employee_id
    FROM
        emps
    WHERE
        department_id = dept;

    TYPE refs IS RECORD (
        last_name   emps.last_name%TYPE,
        employee_id emps.employee_id%TYPE
    );
    v2 refs;
BEGIN
    OPEN c1(60);
    LOOP
        FETCH c1 INTO v2;
        EXIT WHEN c1%notfound;
        dbms_output.put_line('<--------------------employee_id: '
                             || v2.employee_id
                             || ' -------------------->');
        dbms_output.put_line(v2.employee_id
                             || ' '
                             || v2.last_name);
        dbms_output.put_line(chr(10));
    END LOOP;

    CLOSE c1;
END;

--================================= Next experiment =============================================

DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE
    ) IS
    SELECT
        last_name,
        employee_id
    FROM
        emps
    WHERE
        department_id = dept;

    TYPE refs IS RECORD (
        last_name   emps.last_name%TYPE,
        employee_id emps.employee_id%TYPE
    );
    v2 refs;
BEGIN
    FOR val IN (
        SELECT
            department_id
        FROM
            emps
    ) LOOP
        OPEN c1(val.department_id);
        LOOP
            FETCH c1 INTO v2;
            EXIT WHEN c1%notfound;
            dbms_output.put_line('<--------------------employee_id: '
                                 || v2.employee_id
                                 || ' -------------------->');
            dbms_output.put_line(v2.employee_id
                                 || ' '
                                 || v2.last_name);
            dbms_output.put_line(chr(10));
        END LOOP;

        CLOSE c1;
    END LOOP;
END;

--========================================================================================================
DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE
    ) IS
    SELECT
        last_name, employee_id, department_id FROM  emps WHERE department_id = dept;

--

    TYPE refs IS RECORD (
        last_name     emps.last_name%TYPE,
        employee_id   emps.employee_id%TYPE,
        department_id emps.department_id%TYPE
    );
   
--    
    v2 refs;

BEGIN
    FOR val IN (SELECT department_id FROM emps) LOOP
        OPEN c1(val.department_id);
        dbms_output.put_line('<--------------------department_id: '
                             || val.department_id
                             || ' -------------------->');
        LOOP
            FETCH c1 INTO v2;
            EXIT WHEN c1%notfound;
            dbms_output.put_line('Employee Id('
                                 || v2.employee_id
                                 || ')'
                                 || ' '
                                 || v2.last_name);

        END LOOP;

        CLOSE c1;
        dbms_output.put_line(chr(10));
    END LOOP;
END;

--=========================  Now starts with default type  ==========================

DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE DEFAULT 110
    ) IS
    SELECT
        last_name, employee_id, department_id FROM  emps WHERE department_id = dept;

--

    TYPE refs IS RECORD (
        last_name     emps.last_name%TYPE,
        employee_id   emps.employee_id%TYPE,
        department_id emps.department_id%TYPE
    );
   
--    
    v2 refs;
BEGIN
    OPEN c1();
    LOOP
        FETCH c1 INTO v2;
        EXIT WHEN c1%notfound;
        dbms_output.put_line('Employee Id('
                             || v2.employee_id
                             || ')'
                             || ' with last name '
                             || v2.last_name||' of department('||v2.department_id||')');

    END LOOP;

    CLOSE c1;
    dbms_output.put_line(chr(10));
END;