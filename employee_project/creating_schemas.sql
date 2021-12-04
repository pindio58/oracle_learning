--=========================================
-- Creating the schemas
--=========================================
CREATE OR REPLACE PROCEDURE sp_create_schema (
    v_name VARCHAR2
) IS

    v_num        NUMBER;
    v_password   VARCHAR2(10) := v_name || '123';
    stmt         VARCHAR2(150);
    tblespace    VARCHAR2(30) := 'DEFAULT TABLESPACE USERS ';
    quotaclause  VARCHAR2(30) := 'QUOTA UNLIMITED ON USERS ';
    enabledition VARCHAR2(30) := 'ENABLE EDITIONS';
BEGIN
    SELECT
        CASE
            WHEN upper(v_name) IN ( 'APP_DATA', 'APP_CODE', 'APP_ADMIN' ) THEN
                'CREATE USER '
                || v_name
                || 'IDENTIFIED BY '
                || v_password
                || tblespace
                || quotaclause
                || enabledition
            ELSE
                'CREATE USER '
                || v_name
                || 'IDENTIFIED BY '
                || enabledition
        END
    INTO stmt
    FROM
        dual;

    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_objects
    WHERE
        upper(object_name) = upper(v_name);

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'DROP user '
                          || v_name
                          || ' CASCADE';
    END IF;

    EXECUTE IMMEDIATE stmt;
    COMMIT;
END sp_create_schema;
/