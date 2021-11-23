/*
Here we will study simple and dynamic declartions
    Simple we alredy know
    for dynamic, we use some other table's column's datatype
    
When we face issue ehile declaring datatype because of size, type etc. 
we can avoid this kind of problem by using type comparabliy %type
*/

DROP PROCEDURE procedure_name;
--
--CREATE PROCEDURE procedure_name AS
--    v_name VARCHAR2(100);
--BEGIN
--    select first_name||' '||last_name  into v_name from HR.employees where employee_id=100;
--    dbms_output.put_line(v_name);
--END;
--
--set SERVEROUTPUT ON;
--BEGIN
--procedure_name;
--END ;
--
--drop table emps;
--create table emps as select * from hr.employees where rownum<=10;
--select * from emps;
--
----- dynamic ---
--CREATE PROCEDURE procedure_name AS
--    v_name emps.last_name%TYPE;
--    v_sal  emps.salary%TYPE;
--BEGIN
--    SELECT
--        last_name,
--        salary 
--    INTO
--        v_name,
--        v_sal
--    FROM
--        hr.employees
--    WHERE
--        employee_id = 100;
--
--    dbms_output.put_line(v_name);
--Exception
--when others then
----v_name='Name';
--dbms_output.put_line('singh');
--
--end;
 

----------------



