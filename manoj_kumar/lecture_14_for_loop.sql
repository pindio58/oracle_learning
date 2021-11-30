/*
Syntax
FOR I IN 1..10 LOOP
STATEMNTS
END LOOP
*/

DECLARE
    x NUMBER := 10;
BEGIN
    FOR i IN 1..x LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    
    
    FOR i IN 2..2 LOOP
        DBMS_OUTPUT.PUT_LINE(2);
    END LOOP;
    
    FOR i IN 3..1 LOOP                  -- will not work
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    
END;



--we can use reverse also, see below


BEGIN
    FOR i IN REVERSE 1..3 LOOP
        sys.dbms_output.put_line(i);
    END LOOP;
END;


---


-- ANother example
begin
for rec in (select* from all_tables) loop
dbms_output.put_line(rec.table_name);
end loop;
end;