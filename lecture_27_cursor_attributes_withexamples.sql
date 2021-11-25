-- to check whether the cursor is open or not
--close if open otherwise vice versa
select * from emps;
set serveroutput on size unlimited;

DECLARE
    TYPE tworecords IS RECORD (
        emp_name emps.last_name%TYPE,
        emp_id   emps.employee_id%TYPE
    );
    v_all tworecords;
    CURSOR c1 IS
    SELECT
        last_name,
        employee_id
    FROM
        emps;

BEGIN

    IF NOT c1%isopen THEN
        OPEN c1;
    END IF;
    LOOP
        FETCH c1 INTO v_all;
        EXIT WHEN c1%notfound;
        dbms_output.put_line('Employee: '
                             || v_all.emp_name
                             || '; employee_id: '
                             || v_all.emp_id);

    END LOOP;

    IF c1%isopen THEN
        CLOSE c1;
    END IF;
END;



--===============================================================================================================================================
DECLARE
    TYPE tworecords IS RECORD (
        emp_name emps.last_name%TYPE,
        emp_id   emps.employee_id%TYPE
    );
    v_all tworecords;
    CURSOR c1 IS
    SELECT
        last_name,
        employee_id
    FROM
        emps;

BEGIN
    IF NOT c1%isopen THEN
        OPEN c1;
    END IF;
    LOOP
        FETCH c1 INTO v_all;
        IF c1%found THEN
            dbms_output.put_line('Employee: '
                                 || v_all.emp_name
                                 || '; employee_id: '
                                 || v_all.emp_id);

        ELSE
            EXIT;
        END IF;

    END LOOP;

    IF c1%isopen THEN
        CLOSE c1;
    END IF;
END;