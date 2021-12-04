/************************************************************************************************************
What is Bull Collect
    It is about redcuing context switching and improve perfromance

What is context switching
    whenever you write a pl/sql block and execute it , The PL/SQL runtime engine starts running all statements line by line
    But it passes all SQL statements to SQL engine to get processed
    Once it is done, the SQL engine returns back the result to PL/SQL block
    This to and fro hoping of control is called context switching
    More these actions, degrade the perfromance
    BULK COLLECT reduces this multiple control hoping and does all actions in one go
    
Like BULK COLLECT, there is one more such clause for batch processing, which is called FORALL

BULK COLLECT can be used with
    FETCH INTO
    SELECT INTO
    RETURNING INTO
************************************************************************************************************/

--=== SELECT INTO ===
DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(50);
    my_table nested_table;
BEGIN
    SELECT
        last_name
    BULK COLLECT
    INTO my_table
    FROM
        hr.employees
    WHERE
        ROWNUM <= 100;

    FOR i IN 1..my_table.last LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;

END;
/

--=== FETCH INTO ===
--This is basically used along with cursor
DECLARE
    TYPE nams IS
        TABLE OF hr.employees.last_name%TYPE;
    v_name nams;
    CURSOR c1 IS
    SELECT
        last_name
    FROM
        hr.employees;

BEGIN
    OPEN c1;
    LOOP
        FETCH c1
        BULK COLLECT INTO v_name;
/*      EXIT WHEN c1%notfound;                                  -- This will work as well

        dbms_output.put_line(c1%rowcount
                             || ': '
                             || v_name);*/
        EXIT WHEN v_name.count = 0;
        FOR idx IN v_name.first..v_name.last LOOP
            dbms_output.put_line(v_name(idx));
        END LOOP;                                   -- \
                                                    --  ----> I had tried putting these two above the for loop but didnt work 
    END LOOP;                                       -- /

    CLOSE c1;
END;
/


-- it works this wa as well, so no issues
DECLARE
    TYPE nams IS
        TABLE OF hr.employees.last_name%TYPE;
    v_name nams;
    CURSOR c1 IS
    SELECT
        last_name
    FROM
        hr.employees;

BEGIN
    OPEN c1;
    FETCH c1
    BULK COLLECT INTO v_name;
    CLOSE c1;
    FOR idx IN v_name.first..v_name.last LOOP
        dbms_output.put_line(v_name(idx));
    END LOOP;

END;
/



--=== Using LIMIT clause along wth cursor ===

DECLARE
    TYPE nams IS
        TABLE OF hr.employees.last_name%TYPE;
    v_name nams;

    CURSOR c1 IS
    SELECT
        last_name
    FROM
        hr.employees;

BEGIN
    OPEN c1;
    FETCH c1
    BULK COLLECT INTO v_name LIMIT 20;
    CLOSE c1;

    FOR idx IN v_name.first..v_name.last LOOP
        dbms_output.put_line(v_name(idx));
    END LOOP;

END;
/