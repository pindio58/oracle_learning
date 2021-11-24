DECLARE
    v_lower NUMBER := 0;
    v_upper NUMBER := 2;
    v_new   NUMBER;
    devisor EXCEPTION;
BEGIN
    IF v_lower = 0 THEN
        RAISE devisor;
    ELSE
        v_new := v_upper / v_lower;
    END IF;
EXCEPTION
    WHEN devisor THEN
        --dbms_output.put_line('done pal');
        dbms_output.put_line(SQLCODE);
        dbms_output.put_line(SQLERRM);
END;

--  ===========================================================
--       now, we will try to use raise_application_error
--  ===========================================================

/*

This does not require to be declare an exception
*If we ignore the exception part, it will give a popup with that message and WILL NOT COMPILE It

*/

CREATE OR REPLACE PROCEDURE proc as
    v_lower NUMBER := 0;
    v_upper NUMBER := 2;
    v_new   NUMBER;
    
BEGIN
    IF v_lower = 0 THEN
        RAISE_APPLICATION_ERROR(-20008,'Please go man');
    ELSE
        v_new := v_upper / v_lower;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        --dbms_output.put_line('done pal');
        dbms_output.put_line(SQLCODE);
        dbms_output.put_line(SQLERRM);
END;


BEGIN
    proc;
END;
/