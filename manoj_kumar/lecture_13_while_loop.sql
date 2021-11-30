/*

While LOOP
Syntax:

    while cindition loop
    statements
    value ++ (increment)
    end loop;
*/

DECLARE
    n NUMBER := 0;
BEGIN
    WHILE n < 10 LOOP
        dbms_output.put_line(n);
        n := n + 1;
    END LOOP;
END;


-- another example with boolean

set serveroutput on size unlimited;
DECLARE
    v_bool BOOLEAN := FALSE;
BEGIN
    WHILE v_bool LOOP
        dbms_output.put_line('when condition is true');
        v_bool := true;
    END LOOP;
    
    WHILE NOT v_bool LOOP
        dbms_output.put_line('when condition is false');
        v_bool := TRUE;
    END LOOP;

END;

