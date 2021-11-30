/*
exception has two parts:
    ORA code
    its description


when using implicit exception, syntax:

    exception
    when <<exception name>> then
    <handler>
    when others then
    <hanlder>
    end;


SQLCODE -->  returns the  code of last ocuurued error
SQLERRM -->  returns the  description of last ocuurued error
*/
DECLARE
    last_name emps.last_name%TYPE;
BEGIN
    SELECT
        last_name
    INTO last_name
    FROM
        emps
    WHERE
        employee_id = 200;

EXCEPTION
    WHEN no_data_found then
        dbms_output.put_line(' NO data found for this employee');
END;

--m exampke 2 , zero division

begin
dbms_output.put_line(1/0); EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('Company had zero earnings.');
end;





-- This is good examplem please see below:
DECLARE
    v_name NUMBER;
BEGIN
    SELECT
        'jeet'
    INTO v_name
    FROM
        dual;

EXCEPTION
    WHEN value_error THEN
        dbms_output.put_line('Error in '
                             || $$plsql_unit
                             || ' at '
                             || $$plsql_line);
        DBMS_OUTPUT.put_line ( 'Error raised: '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ' - '||sqlerrm);
END;