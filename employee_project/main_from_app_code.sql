/*
This is THIRD step and has to be run from app_code

Objective:
    1)  Create synonyms
    2)  "Create"/ Compile employees package (employees_pkg) having following functionalities:
            get employees of give department id
            get employee's job history
            get all the attributes of an employee
            update employee's salary
            change employee's job
            
    3)  Grant the privelege to the actual end users 
            app_user
            app_admin_user

Notes: 
    *   There is a separate section for perfroming testing on these created 
    *   This is basically a technical user. All the functionalities will be used by typical end user(app_user) or admin user (app_admin_user)
    
*/

BEGIN
    sp_generate_syns;
    sp_create_view;
    /*Create/ compile the package at this step as defined in @creating_syns_emp_pks.sql*/
    sp_grant_pkg_privs;
END;
/