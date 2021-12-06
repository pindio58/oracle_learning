DECLARE
    v_num NUMBER;
BEGIN
    SELECT COUNT(1) INTO v_num FROM USER_TABLES WHERE UPPER(TABLE_NAME)='AUD';

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'DROP TABLE AUD';
    END IF;

    EXECUTE IMMEDIATE 'CREATE TABLE AUD (obj_id NUMBER, obj_name VARCHAR2(25),create_dt VARCHAR2(25))';
    
    create_db_objects.sp_create_objects;
    
    create_db_objects.sp_create_views;
    
    create_db_objects.sp_create_sequence;
    
    FOR i IN ( SELECT  column_value FROM TABLE ( sys.dbms_debug_vc2coll('jobs', 'departments', 'employees', 'job_history') ) ) LOOP
        sp_data_load(i.column_value);
    END LOOP;
        
END;
/
