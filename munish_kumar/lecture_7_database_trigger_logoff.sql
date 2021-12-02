CREATE TABLE database_audit (
    user_name   VARCHAR(20),
    event_type  VARCHAR(20),
    logon_date  DATE,
    logon_time  VARCHAR(20),
    logoff_date DATE,
    logoff_time VARCHAR(20)
);

SELECT
    *
FROM
    database_audit;

CREATE OR REPLACE TRIGGER database_schema BEFORE LOGOFF ON DATABASE BEGIN
    INSERT INTO database_audit VALUES (
        user,
        ora_sysevent,
        NULL,
        NULL,
        sysdate,
        to_char(sysdate, 'hh24:mi:ss')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20000, 'Unexpected error: ' || dbms_utility.format_error_stack);
END;
/
commit;