/*
This is an end user (typical user) who doesnt have admin rights.
This can be done after THIRD step is performed

Functionalities provided:
            get employees of given department id
            get employee's job history
            get all the attributes of an employee
            update employee's salary
            change employee's job

For easy use, juust create a synonym for package name

Connect to sqlplus with app_user and run below commands for good formatting

SET LINESIZE 80
SET RECSEP WRAPPED
SET RECSEPCHAR "="
COLUMN NAME FORMAT A15 WORD_WRAPPED
COLUMN HIRE_DATE FORMAT A20 WORD_WRAPPED
COLUMN DEPARTMENT_NAME FORMAT A10 WORD_WRAPPED
COLUMN JOB_TITLE FORMAT A29 WORD_WRAPPED
COLUMN MANAGER FORMAT A11 WORD_WRAPPED

--Declare a bind variable for the value of the subprogram parameter p_result_set:
VARIABLE c REFCURSOR

*/

BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM employees_pkg FOR app_code.employees_pkg';
end;
/

--Show the employees in a department
EXEC employees_pkg.get_employees_in_dept( 90, :c );
PRINT c

-- Show the job history
EXEC app_code.employees_pkg.get_job_history( 101, :c );
PRINT c

-- Show general information about employee 101:
EXEC employees_pkg.show_employee( 101, :c );
PRINT c

--Show the information about the job Administration Vice President:
SELECT * FROM jobs WHERE job_title = 'Administration Vice President';


--Try to give employee 101 a new salary outside the range for her job, this will fail as expected
EXEC employees_pkg.update_salary( 101, 30001 );


--Give employee 101 a new salary inside the range for her job and show general information about her again:
EXEC employees_pkg.update_salary( 101, 18000 );
EXEC employees_pkg.show_employee( 101, :c );
PRINT c


--Change the job of employee 101 to her current job with a lower salary, It will fail as expected:
EXEC employees_pkg.change_job( 101, 'AD_VP', 17500, 90 );