--==============================================================================================================================================
--              This is practical example of using function with ref cursor
--==============================================================================================================================================

CREATE OR REPLACE FUNCTION details (
    query_selector VARCHAR2 DEFAULT NULL
) RETURN SYS_REFCURSOR AS
    return_cursor SYS_REFCURSOR;
BEGIN
    IF upper(query_selector) = 'EMP' THEN
        OPEN return_cursor FOR SELECT
                                   last_name,
                                   employee_id
                               FROM
                                   hr.employees;

    ELSE
        OPEN return_cursor FOR SELECT
                                   department_name,
                                   department_id
                               FROM
                                   hr.departments;

    END IF;

    RETURN return_cursor;
END;
/
 --==================================================================================================================================================

CREATE OR REPLACE PROCEDURE named IS
    return_cursor SYS_REFCURSOR;
    v_name        VARCHAR2(40);
    v_number      NUMBER;
BEGIN
    dbms_output.put_line('************************ EMPLOYEE DETAILS ************************');
    return_cursor := details('emp');
    LOOP
        FETCH return_cursor INTO
            v_name,
            v_number;
        EXIT WHEN return_cursor%notfound;
        dbms_output.put_line(return_cursor%rowcount
                             || '-'
                             || v_name
                             || '|salary is:-'
                             || v_number);

    END LOOP;

    CLOSE return_cursor;
    dbms_output.put_line(chr(10));
---

    dbms_output.put_line('************************ DEPARTMENT DETAILS ************************');
    return_cursor := details();
    LOOP
        FETCH return_cursor INTO
            v_name,
            v_number;
        EXIT WHEN return_cursor%notfound;
        dbms_output.put_line(return_cursor%rowcount
                             || '-'
                             || v_name);
    END LOOP;

    CLOSE return_cursor;
END;
/

BEGIN
    named;
END;
/