/*

two types of sequential controls
    goto statement , which  goes to specified location/line
    null statement which does nothing
*/

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);
        IF i = 5 THEN
            GOTO jmp;
        END IF;
    END LOOP;

    << jmp >> 
    dbms_output.put_line('outised loop and number is 5');
END;


-- with null goto

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);
        IF i = 5 THEN
            GOTO jmp;
        END IF;
    END LOOP;

    << jmp >> 
    null;
END;