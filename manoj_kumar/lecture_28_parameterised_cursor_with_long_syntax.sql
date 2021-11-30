/*
Paramterised cursor came into existance to avoid redundancy in code
    suppose we want information of our own department
    I will have to use three cursors --10,20,30
    To avoid this, I can use parameteric cursors, see below:
*/
DECLARE
    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = 'EMPS';

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'drop table emps';
    END IF;
    EXECUTE IMMEDIATE 'create table emps as select * from HR.employees where department_id IN (10, 20, 90)';
END;


--========================================================================================================
--      we prepared below to remove redundancy
--========================================================================================================


DECLARE
    TYPE tworecords IS RECORD (
        emp_name emps.last_name%TYPE,
        emp_id   emps.employee_id%TYPE,
        dept_id  emps.department_id%TYPE
    );
    v_all tworecords;
    CURSOR c1 (
        dept NUMBER
    ) IS
    SELECT
        last_name,
        employee_id,
        department_id
    FROM
        emps
    WHERE
        department_id = dept;

BEGIN
    OPEN c1(10);
    LOOP
        FETCH c1 INTO v_all;
        EXIT WHEN c1%notfound;
        dbms_output.put_line(v_all.dept_id);
    END LOOP;

    CLOSE c1;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Done');
END;