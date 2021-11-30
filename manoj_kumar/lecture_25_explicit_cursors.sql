
--====================================================
--Explicit Cursor
/*
An explicit cursor is a session cursor that you           construct and manage.
You must declare and define an explicit cursor, giving it a name and associating it with a query (typically, the query returns multiple rows).

we can process  Explicit cursor  data by using two ways as below

1. 
    *   Open the explicit cursor (with the OPEN statement), 
    *   fetch rows from the result set (with the FETCH statement)
    *   close the explicit cursor (with the CLOSE statement).
2. Use the explicit cursor in a cursor FOR LOOP statement

*/


-- first example

--emps table has 10rows , so i fetch more than 10 times, it will continue with the last name,
--so we have to know the number of counts of cursor;

DECLARE
    v_name emps.last_name%TYPE;
    CURSOR c1 IS
    SELECT
        last_name
    FROM
        emps;

BEGIN
    OPEN c1;
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    FETCH c1 INTO v_name;
    dbms_output.put_line(c1%ROWCOUNT || ': '||v_name);
    CLOSE c1;
END;






-- Second example



--IN order to reduce redundancy, we will do it ina  loop , so that we dont have to write all the codes again and again



DECLARE
    v_name emps.last_name%TYPE;
    CURSOR c1 IS
    SELECT
        last_name
    FROM
        emps;

BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_name;
        EXIT WHEN c1%notfound;
        dbms_output.put_line(c1%rowcount
                             || ': '
                             || v_name);
    END LOOP;

    CLOSE c1;
END;




--exampke 3, taking all columns in cursor

DECLARE
    v_emp emps%rowtype;
    CURSOR c1 IS
    SELECT
        *
    FROM
        emps;

BEGIN
    OPEN c1;
    LOOP
        --FETCH c1.last_name INTO v_emp.last_name;   -- this is wrong
        FETCH c1 INTO v_emp;
        dbms_output.put_line(c1%rowcount||': '||v_emp.last_name);
        EXIT WHEN c1%notfound;
    END LOOP;

    CLOSE c1;
END;


--========================================
-- For loop cursor
--========================================


DECLARE
    CURSOR c1 IS
    SELECT
        *
    FROM
        emps;

BEGIN
    FOR varr IN c1 LOOP
        dbms_output.put_line(c1%rowcount
                             || ': '
                             || varr.last_name);
    END LOOP;
END;



--==== 
--my own testing
--=====


BEGIN
    FOR i IN (SELECT  * FROM  emps ) 
    LOOP
        dbms_output.put_line(SQL%ROWCOUNT||': '||i.last_name);
    END LOOP;
END;


begin
for 1 in 1..23
LOOP
    dbms_ouput.put_line(SQL%rowcount);
END LOOP;

end;
