/*
This is FOURTH step and has to be run from app_admin

Objective:
    1)  Create synonyms for required tables/views
    2)  "Create"/ Compile admin package (admin_pkg) having following functionalities:
            Update job
            Add new job
            Update department
            add new department
            
    3)  Grant the privelege to the actual end users 
            app_admin_user

Notes: 
    *   There is a separate section for perfroming testing on these created 
    *   This is basically a technical user. All the functionalities will be used by admin user (app_admin_user)
    
*/

BEGIN
    sp_create_syns_admin;
END;
/
/*create admin package here as defined in creating_syns_admin_pkg.sql*/
BEGIN
    sp_grant_privs;
END;
/