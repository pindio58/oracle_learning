/*
This is practical example of strongly typed cursor
*/
DECLARE
--cursor_name SYS_REFCURSOR return HR.employees%rowtype;
    TYPE cursor_name IS REF CURSOR RETURN hr.employees%rowtype; -- this is the only way we can define strongly typed
    retur cursor_name;
BEGIN
    NULL;
END;


--========================================================================================================================================


DECLARE
    type  return_wala is RECORD(v_name varchar2(40), v_num NUMBER);
    TYPE typed IS REF CURSOR return return_wala;
    return_cursor typed;
    v_name        VARCHAR2(40);
    v_number      NUMBER;
BEGIN
    dbms_output.put_line('************************ EMPLOYEE DETAILS ************************');
    OPEN return_cursor FOR SELECT
                               last_name,
                               employee_id
                           FROM
                               hr.employees;

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
    OPEN return_cursor FOR SELECT
                               department_name,
                               department_id
                           FROM
                               hr.departments;

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
END;