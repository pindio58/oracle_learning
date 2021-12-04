/*******************************************************************************
How do we use dynamic SQL?
    execute Immediate statement
    Open-For, Fetch & Close
    
    Bulk fetch
    Bulk Execute
    Bulk FORALL
    BULK collect into statement
    
Syntax:
    EXECUTE IMMEDIATE dynamic_query
    [INTO var1, var2..]
    [USING bind_argument1, bind_variable2..]
    [RETURNING|RETURN INTO clause]
*******************************************************************************/


--== Using INTO ==

DECLARE
    v_num NUMBER;
    stmt  VARCHAR2(250);
BEGIN
    stmt := 'SELECT COUNT(1) from HR.EMPLOYEES';
    EXECUTE IMMEDIATE stmt
    INTO v_num;
    dbms_output.put_line(v_num);
END;
/

--== TO CREATE TABLE==
DECLARE
    stmt VARCHAR2(250);
BEGIN
    stmt := 'CREATE TABLE test (
    noo   NUMBER,
    namee VARCHAR2(25))';
    EXECUTE IMMEDIATE stmt;
END;
/

--==how to concatentae when in multiple lines ==
DECLARE
    stmt VARCHAR2(250) := 'CREATE TABLE test ('
                          || 'noo   NUMBER,'
                          || 'namee VARCHAR2(25)'
                          || ')';
BEGIN
    EXECUTE IMMEDIATE stmt;
END;
/

--== same way alter, drop ==


--== Use USING Clause ==

CREATE OR REPLACE PROCEDURE sp_bind (
    v_name VARCHAR2 DEFAULT 'Jeet',
    v_no   NUMBER DEFAULT 1
) IS

    table_name  VARCHAR2(4) := 'EMPS';
    create_stmt VARCHAR2(250);
    insert_stmt VARCHAR2(250);
    v_num       NUMBER;
BEGIN
    create_stmt := 'CREATE TABLE '
                   || table_name
                   || '(namee VARCHAR2(25),numm NUMBER)';
    insert_stmt := 'INSERT INTO '
                   || table_name
                   || ' VALUES (:v_nam, :v_n)';
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = table_name;

    IF ( v_num = 0 ) THEN
        EXECUTE IMMEDIATE create_stmt;
    END IF;
    
    EXECUTE IMMEDIATE insert_stmt
        USING v_name, v_no;
END;
/

begin
sp_bind('Anum',2);
end;
/


--=======  BULK COLLECT ===
-- this is how we use bulk collect into

DECLARE
    TYPE nested_table IS
        TABLE OF employees.last_name%TYPE;
    arr  nested_table;
    stmt VARCHAR2(250) := 'select last_name from employees';
BEGIN
    EXECUTE IMMEDIATE stmt
    BULK COLLECT
    INTO arr;
    
    for i in arr.first..arr.last loop
    dbms_output.put_line(arr(i));
    end loop;
END;
/


--== EXECUTE PL/SQL block ==

DECLARE
    pl_sql_blk VARCHAR2(250) := 'DECLARE
    v_name VARCHAR2(30);
BEGIN
    SELECT
        user
    INTO v_name
    FROM
        dual;

    dbms_output.put_line(''current user is: ''||v_name);
END;';
BEGIN
    EXECUTE IMMEDIATE pl_sql_blk;
END;
/