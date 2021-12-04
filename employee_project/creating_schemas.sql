--=========================================
-- Creating the schemas
--=========================================
CREATE OR REPLACE PROCEDURE sp_create_schema (
    v_name VARCHAR2
) IS

    v_num        NUMBER;
    v_password   VARCHAR2(30) := v_name || '123';
    stmt         VARCHAR2(250);
    tblespace    VARCHAR2(30) := ' DEFAULT TABLESPACE USERS';
    quotaclause  VARCHAR2(30) := ' QUOTA UNLIMITED ON USERS';
    enabledition VARCHAR2(30) := ' ENABLE EDITIONS';
BEGIN
    SELECT
        CASE
            WHEN upper(v_name) IN ( 'APP_DATA', 'APP_CODE', 'APP_ADMIN' ) THEN
                'CREATE USER '
                || v_name
                || ' IDENTIFIED BY '
                || v_password
                || tblespace
                || quotaclause
          --       || enabledition
            ELSE
                'CREATE USER '
                || v_name
                || ' IDENTIFIED BY '
                || v_password
          --      || enabledition
        END
    INTO stmt
    FROM
        dual;

    SELECT
        COUNT(1)
    INTO v_num
    FROM
        all_users
    WHERE
        upper(username) = upper(v_name);

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'DROP user '
                          || v_name
                          || ' CASCADE';
    END IF;

    EXECUTE IMMEDIATE stmt;
    COMMIT;
END sp_create_schema;
/

-- call to create the schemas --
BEGIN
    FOR i IN (
        SELECT
            column_value
        FROM
            TABLE ( sys.dbms_debug_vc2coll('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER') )
    ) LOOP
        sp_create_schema(i.column_value);
    END LOOP;
END;
/

