CREATE TABLE emp_audit (
    new_name   VARCHAR(20),
    old_name   VARCHAR(20),
    user_name  VARCHAR(20),
    entry_date VARCHAR(20),
    operation  VARCHAR(20)
);

commit;

CREATE OR REPLACE TRIGGER employees_audit BEFORE
    INSERT OR DELETE OR UPDATE ON emps
    FOR EACH ROW
DECLARE
    v_user VARCHAR2(100);
    v_date VARCHAR2(100);
BEGIN
    SELECT
        user,
        to_date(sysdate, 'DD/MON/YYYY HH24:MI:SS')
    INTO
        v_user,
        v_date
    FROM
        dual;

    IF inserting THEN
        INSERT INTO emp_audit VALUES (
            :new.first_name,
            NULL,
            v_user,
            v_date,
            'Inserted'
        );

    ELSIF deleting THEN
        INSERT INTO emp_audit VALUES (
            NULL,
            :old.first_name,
            v_user,
            v_date,
            'Deleted'
        );

    ELSIF updating THEN
        INSERT INTO emp_audit VALUES (
            :new.first_name,
            :old.first_name,
            v_user,
            v_date,
            'Updated'
        );

    END IF;

END;
/