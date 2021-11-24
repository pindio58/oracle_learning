/*

This video covers three topics:
    what happens when we define s user-defined exception with the same name as some pre-defined exception and how to hanlde it
    what does rasie(multiple blocks)
    how to raise implicity and explicitly pre-defined exceptions
    
*/


--=========================================================================================================================
-- Example one

-- When I runn this, it will not go to invalid_number exception because there are two these exceptions:
--    one is predefined in oracle
--    other is predefined in declare section
--So, it will go to OTHERS part
--=========================================================================================================================

DECLARE
    invalid_number EXCEPTION;
BEGIN
    INSERT INTO emps ( employee_id ) VALUES ( 'major' );

EXCEPTION
    WHEN invalid_number THEN
        dbms_output.put_line('This was done manually');
    WHEN OTHERS THEN
        dbms_output.put_line('This was AUTOMATIC');
END;

--======================================================================================================================================
--In order to have the program EXECUTE invalid_number exception, we will use like 'STANDARD.INVALID_NUMBER', please see below:
--======================================================================================================================================

DECLARE
    invalid_number EXCEPTION;
BEGIN
    INSERT INTO emps ( employee_id ) VALUES ( 'major' );

EXCEPTION
    WHEN STANDARD.invalid_number THEN
        dbms_output.put_line('This was done manually');
    WHEN OTHERS THEN
        dbms_output.put_line('This was AUTOMATIC');
END;




--===============================================================================================================================================
--example 2
--===============================================================================================================================================

DECLARE
    curr_salary NUMBER := 20000;
    max_salary  NUMBER := 1000;
    new_salary  NUMBER;
BEGIN
    BEGIN
        IF ( curr_salary > max_salary ) THEN
            RAISE invalid_number;
        END IF;
    EXCEPTION
        WHEN invalid_number THEN
            dbms_output.put_line('salary is out of range: ' || curr_salary);
            RAISE;  -- here we can name the exception also, but that is optional. By default it will take last occured exception
    END;
EXCEPTION
    WHEN invalid_number THEN
        new_salary := curr_salary;
        dbms_output.put_line('Salary has been revised from '
                             || max_salary
                             || ' to '
                             || new_salary);
END;



/*
Example 3
*/


DECLARE BEGIN
    IF ( 1 < 3 ) THEN
        RAISE invalid_number;
    ELSE
        INSERT INTO emps ( employee_id ) VALUES ( 'major' );

    END IF;
EXCEPTION
    WHEN invalid_number THEN
        dbms_output.put_line('This was done manually');
    WHEN OTHERS THEN
        dbms_output.put_line('This was AUTOMATIC');
END;