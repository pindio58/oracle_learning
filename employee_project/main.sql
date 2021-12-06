--==========================
-- Create Schemas
--==========================

BEGIN
    sp_create_schema;
END;
/

--==========================
--Grant required priveleges
--==========================

BEGIN
    sp_execute_grant_privs;
END;
/

--=========================
-- Create DB objects/tables
-- Run it from app_data
--=========================
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE AUD';
    EXECUTE IMMEDIATE 'CREATE TABLE AUD (obj_id NUMBER, obj_name VARCHAR2(25),create_dt VARCHAR2(25))';
END;
/

BEGIN
    create_db_objects.sp_create_objects;
END;
/


--=========================
-- Create views
-- Run it from app_data
--=========================
BEGIN
    create_db_objects.sp_create_views;
END;
/

--=========================
-- Create Sequences
-- Run it from app_data
--=========================
BEGIN
    create_db_objects.sp_create_sequence;
END;
/

--=========================
-- Loading the data
-- Run it from app_data
--=========================

BEGIN
--    create_db_objects.sp_create_objects;
    FOR i IN ( SELECT  column_value FROM TABLE ( sys.dbms_debug_vc2coll('jobs', 'departments', 'employees', 'job_history') ) ) LOOP
        sp_data_load(i.column_value);
    END LOOP;
END;
/


--====================================
--Adding the Foreign Key Constraint
--====================================
ALTER TABLE departments ADD CONSTRAINT dept_to_emp_fk FOREIGN KEY ( manager_id )
    REFERENCES employees;
    
    
    
--===================================================
--Granting Privileges on the Schema Objects to Users    
--===================================================

BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO app_code';
    EXECUTE IMMEDIATE 'GRANT SELECT ON departments TO app_code';
    EXECUTE IMMEDIATE 'GRANT SELECT ON jobs TO app_code';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT on job_history TO app_code';
    EXECUTE IMMEDIATE 'GRANT SELECT ON employees_sequence TO app_code';

-- for app_admin

    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON jobs TO app_admin';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON departments TO app_admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON employees_sequence TO app_admin';
    EXECUTE IMMEDIATE 'GRANT SELECT ON departments_sequence TO app_admin';
END;
/


--== Testing how it works (app_code)===

VARIABLE c REFCURSOR;
print ;
BEGIN
    employees_pkg.get_employees_in_dept( 90, :c );
end;
/

--==  grant provs to app_user and ap_admin_user
BEGIN
    sp_grant_pkg_privs;
END;
/