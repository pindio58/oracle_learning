select * from emps;

-- example (1) based on single table

DECLARE
    TYPE emp_info IS RECORD (
        emp_id   emps.employee_id%TYPE,
        emp_hire emps.hire_date%TYPE
    );
    v_emp_table emp_info;
BEGIN
    SELECT
        employee_id,
        hire_date
    INTO
        v_emp_table.emp_id,
        v_emp_table.emp_hire
    FROM
        emps
    WHERE
        employee_id = 100;
   dbms_output.put_line(v_emp_table.emp_id ||' '||v_emp_table.emp_hire);
   
   Exception when others then 
   dbms_output.put_line(SQLCODE||' : '|| SQLERRM);
END;

-- example (2) based on multple  table


DECLARE
    TYPE emp_info IS RECORD (
        emp_id   emps.employee_id%TYPE,
        mang_id depts.MANAGER_ID%TYPE
    );
    v_emp_table emp_info;
BEGIN
    SELECT
        emps.employee_id,
        depts.MANAGER_ID
    INTO
        v_emp_table.emp_id,
        v_emp_table.mang_id
    FROM
        emps join depts
    ON
        depts.DEPARTMENT_ID=emps.DEPARTMENT_ID 
        WHERE
        emps.employee_id = 100;
   dbms_output.put_line(v_emp_table.emp_id ||' '||v_emp_table.mang_id);
   
   Exception when others then 
   dbms_output.put_line(SQLCODE||' : '|| SQLERRM);
END;
