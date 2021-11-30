/*
Here we are just going to run two cursors 
    ref cursor
    normal cursor with for loop
*/


--================================================================================================================================================
-- This is ref cursor
--================================================================================================================================================


DECLARE
    returned_type SYS_REFCURSOR;
    v_name        VARCHAR2(40);
    v_id          NUMBER;
BEGIN
    dbms_output.put_line('********************************** Employee Details **********************************');
    OPEN returned_type FOR SELECT
                               first_name
                               || ' '
                               || last_name,
                               employee_id
                           FROM
                               hr.employees;

    LOOP
        FETCH returned_type INTO
            v_name,
            v_id;
        EXIT WHEN returned_type%notfound;
        dbms_output.put_line('Employee Name: '
                             || v_name
                             || '('
                             || v_id
                             || ')');

    END LOOP;

    CLOSE returned_type;
    dbms_output.put_line(chr(10));
    dbms_output.put_line('********************************** Employee Details **********************************');
    OPEN returned_type FOR SELECT
                               department_name,
                               department_id
                           FROM
                               hr.departments;

    LOOP
        FETCH returned_type INTO
            v_name,
            v_id;
        EXIT WHEN returned_type%notfound;
        dbms_output.put_line('Department Name: '
                             || v_name
                             || '('
                             || v_id
                             || ')');

    END LOOP;

    CLOSE returned_type;
END;