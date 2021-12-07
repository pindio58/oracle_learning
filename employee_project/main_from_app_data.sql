/*
This is SECOND step and has to run from user app_data

Objective:
    1)  This will create a sample AUDIT table (AUD) which will just have enrty logs of createing db objects
    2)  This will create all tables with all the details/constraints required
    3)  This will create 2 Sequence
    4)  This will load the data into table with Business logic
    5)  This will add forign key to departments table
    
TODO:
    To have the proper auditing with proper Audit table
    
*/

DECLARE
    v_num NUMBER;
BEGIN
    SELECT COUNT(1) INTO v_num  FROM user_tables  WHERE upper(table_name) = 'AUD';                       -- check whether the 'AUD' table exists

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'DROP TABLE AUD';                                                              -- drop if exists
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE AUD (obj_id NUMBER, obj_name VARCHAR2(25),create_dt VARCHAR2(25))';  -- create a fresh AUD table
    
    create_db_objects.sp_create_objects;                                                                 -- create the tables
    create_db_objects.sp_create_views;                                                                   -- create the desired views
    create_db_objects.sp_create_sequence;                                                                -- create the desired sequences
    
    FOR i IN ( SELECT column_value  FROM TABLE ( sys.dbms_debug_vc2coll( 'jobs','departments', 'employees', 'job_history') ) ) LOOP
        sp_data_load(i.column_value);                                                                    -- load the data into tables
    END LOOP;
    
    EXECUTE IMMEDIATE 'ALTER TABLE departments ADD CONSTRAINT dept_to_emp_fk FOREIGN KEY ( manager_id )' -- add the foreign key    
                       ||' REFERENCES employees';
                       

-- This is to provide required priveleges to the other user                

--for app_code                       
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
