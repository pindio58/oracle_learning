DECLARE
    v_emp hr.employees%rowtype;
BEGIN
    dbms_output.put_line('singh');
END;

---

DECLARE
    CURSOR c1 IS
    SELECT
        *
    FROM
        hr.employees
    WHERE
        department_id = 60;

    CURSOR c2 IS
    SELECT
        *
    FROM
        hr.employees
    WHERE
        department_id = 100;

BEGIN
    dbms_output.put_line('---------- Department 60 employees ---------');
    FOR i IN c1 LOOP
        dbms_output.put_line(i.last_name);
    END LOOP;
    dbms_output.put_line(chr(10));
    dbms_output.put_line('---------- Department 100 employees ---------');
    FOR i IN c1 LOOP
        dbms_output.put_line(i.last_name);
    END LOOP;
END;


------



--===================================================================================
-- using paramterised cursor 
--===================================================================================
DECLARE
    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = 'EMPS';

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'drop table emps';
    END IF;
    EXECUTE IMMEDIATE 'create table emps as select * from hr.employees';
END;


declare
cursor c1 (dept emps.department_id%type) is select * from emps where department_id=dept;


BEGIN
    dbms_output.put_line('---------- Department 60 employees ---------');
    FOR i IN c1(60) LOOP
        dbms_output.put_line(i.last_name);
    END LOOP;
    dbms_output.put_line(chr(10));
    dbms_output.put_line('---------- Department 100 employees ---------');
    FOR i IN c1(100) LOOP
        dbms_output.put_line(i.last_name);
    END LOOP;
END;


--=================================================================================================
DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE
    ) IS
    SELECT
        *
    FROM
        emps
    WHERE
        department_id = dept;

BEGIN
    FOR i IN (
        SELECT
            column_value
        FROM
            TABLE ( sys.dbms_debug_vc2coll(60, 100) )
    ) LOOP
        dbms_output.put_line('---------- Department '
                             || i.column_value
                             || ' employees ---------');
        FOR j IN c1(i.column_value) LOOP
            dbms_output.put_line(j.last_name);
        END LOOP;

        dbms_output.put_line(chr(10));
    END LOOP;
END;


--====================================================================================================================


DECLARE
    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = 'EMPS';

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'drop table emps';
    END IF;
    EXECUTE IMMEDIATE 'create table emps as select * from hr.employees';
END;


DECLARE
    CURSOR c1 (
        dept emps.department_id%TYPE
    ) IS
    SELECT
        *
    FROM
        emps
    WHERE
        department_id = dept;

BEGIN
    FOR i IN (
        SELECT
            column_value
        FROM
            TABLE ( sys.dbms_debug_vc2coll(60, 100) )
    ) LOOP
        dbms_output.put_line('---------- Department '
                             || i.column_value
                             || ' employees ---------');
        FOR j IN c1(i.column_value) LOOP
            insert into t values(j.last_name);
        END LOOP;

        dbms_output.put_line(chr(10));
   