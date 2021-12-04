SELECT
    column_value
FROM
    TABLE ( sys.dbms_debug_vc2coll('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER') );
    
    

BEGIN
    EXECUTE IMMEDIATE 'CREATE USER APP_ADMIN_USER IDENTIFIED BY APP_ADMIN_USER123';
END;
/
commit;
select * from user_objects where upper(object_name) in ('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER');

BEGIN
    sp_create_schema('app_data');
END;
/
drop user APP_ADMIN_USER;

--

select * from dba_users ;
select * from dba_users where upper(username) in ('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER');

--
BEGIN
    dbms_output.put_line('string(''x'',10)= '
                         || dbms_random.string('x', 10));
END;
/