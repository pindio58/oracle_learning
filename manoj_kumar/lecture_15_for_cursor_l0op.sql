DECLARE
    CURSOR c1 IS
    SELECT
        *
    FROM
        emps;

BEGIN
    FOR i IN c1 LOOP
        dbms_output.put_line(i.last_name);
    END LOOP;
END;