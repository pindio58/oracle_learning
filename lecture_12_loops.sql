/*
 Simple loop 

    *   Just write and start a loop and exit when our condition meets
    *   we decide inside the loop when to exit
    *   Points to note:
            EXIT Statement
            EXIT WHEN statement
            CONTINUE statement
            CONTINUE WHEN statement
            
While Loop

    *   runs till condition doesn become True
    *   condition in while loop only

For loop
    *   for a number of iterates
    *   Can be run in reverse (optional)
    
    *   Synatx:    
    
        *    FOR i IN 1..3 LOOP
                 DBMS_OUTPUT.PUT_LINE (i);
              END LOOP;
              
        *    FOR i IN REVERSE 1..3 LOOP
                 DBMS_OUTPUT.PUT_LINE (i);
              END LOOP;
              
Cursor for loop
    * mainly runs as long as cursor has the data

*/



-- SIMPLE LOOP


/*
Syntax:
    LOOP
        statements (containg logic when to exit)
    END LOOP
*/
DECLARE
    n NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('Inside the for loop: ' || n);
        n := n + 1;
        IF n > 10 THEN
            EXIT;
        END IF;
    END LOOP;
    dbms_output.put_line('After the loop: ' || n);
END;




-- EXIT WHEN statement --

DECLARE
    n NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('LOOP NUMBER: ' || n);
        n := n + 1;
        EXIT WHEN n > 5;
    END LOOP;

    dbms_output.put_line('EXITED: ' || n);
END;

--- continue
DECLARE
    n NUMBER := 10;
BEGIN
    LOOP
        dbms_output.put_line('Inside loop:  N = ' || to_char(n));
        n := n + 1;
        IF n < 3 THEN
            CONTINUE;  -- will not work since it only started supporting in realses 11 onwards
        END IF;
        dbms_output.put_line('AFTER LOOP: ' || n);
        EXIT WHEN n > 6;
    END LOOP;

    dbms_output.put_line('LOOP AFTER CONTINUE');
END;


-- contrinue when


DECLARE
    n NUMBER := 10;
BEGIN
    LOOP
        dbms_output.put_line('Inside loop:  N = ' || to_char(n));
        n := n + 1;
        CONTINUE WHEN n < 3;  -- will not work since it only started supporting in realses 11 onwards

        dbms_output.put_line('AFTER LOOP: ' || n);
        EXIT WHEN n > 6;
    END LOOP;

    dbms_output.put_line('LOOP AFTER CONTINUE');
END;



-- we can also label/ name loops using << loop name >>, see below:



DECLARE
    n NUMBER := 0;
    m NUMBER := 0;
BEGIN
    << outerloop >> LOOP                            --- labelling was inherited in 11g
    n := n + 1;
    m := 0;
    << inner_loop >> LOOP
        m := m + 1;
        dbms_output.put_line('m = ' || m);
        EXIT inner_loop WHEN ( m > 3 );
    END LOOP;

    EXIT outer_loop WHEN n > 5;
    end loop;   
end;


