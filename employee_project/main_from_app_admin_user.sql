/*
This is an end user (ADMIN user) who doesnt have admin rights.
This can be done after FOURTH step is performed

Functionalities provided:
    Update job
    Add new job
    Update department
    add new department
            

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
VARIABLE n NUMBER REFCURSOR

*/


BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM admin_pkg FOR app_admin.admin_pkg';
END;
/


-- Increase the maximums salary
SELECT * FROM jobs WHERE job_id = 'AD_VP';
EXEC admin_pkg.update_job( 'AD_VP', p_max_salary => 31000 );
SELECT * FROM jobs WHERE job_id = 'AD_VP';

-- Increase minimum salary
EXEC admin_pkg.update_job( 'IT_PROG', p_max_salary => 4001 );

-- Add a new job and show the information about it:
EXEC admin_pkg.add_job( 'AD_CLERK', 'Administrative Clerk', 3000, 7000 );
SELECT * FROM jobs WHERE job_id = 'AD_CLERK';


-- Change the name and manager of department 100 and show the information about it:
EXEC admin_pkg.update_department( 100, 'Financial Services' );
EXEC admin_pkg.update_department( 100, p_manager_id => 111,  p_update_manager_id => true );
