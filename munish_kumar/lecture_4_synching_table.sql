--==============================================================
-- This hs been created to keep track of a table
-- It will synch the table
-- By synch means, keep track of operations on table etc..
--==============================================================

-- create a bakcup table first

DROP TABLE emps_bkp;

COMMIT;
--
CREATE TABLE emps_bkp (
    employee_id NUMBER(6),
    first_name  VARCHAR2(20),
    last_name   VARCHAR2(20),
    email       VARCHAR2(20),
    operation   VARCHAR2(20),
    updatedate  TIMESTAMP
);

COMMIT;

SELECT
    *
FROM
    emps_bkp
WHERE
    first_name = 'Tommy';

CREATE OR REPLACE TRIGGER backup_trigger AFTER
    INSERT OR DELETE OR UPDATE ON emps
    FOR EACH ROW
DECLARE
    v_num NUMBER;
BEGIN
    IF inserting THEN
        INSERT INTO emps_bkp VALUES (
            :new.employee_id,
            :new.first_name,
            :new.last_name,
            :new.email,
            'Insert',
            sysdate
        );

    ELSIF deleting THEN
        INSERT INTO emps_bkp VALUES (
            :old.employee_id,
            :old.first_name,
            :old.last_name,
            :old.email,
            'Delete',
            sysdate
        );

    ELSIF updating THEN
        INSERT INTO emps_bkp VALUES (
            :new.employee_id,
            :new.first_name,
            :new.last_name,
            :new.email,
            'Updated',
            sysdate
        );


    END IF;
END;
/

commit;

INSERT INTO emps VALUES (
    95,
    'Tommy',
    'Shelby',
    'dummy.com'
);

COMMIT;

update emps set first_name='Tommy' where employee_id=95;
commit;
rollback;
delete from emps where employee_id=95 and first_name='Thomas' and rownum=1;

select * from emps_bkp;
select * from emps;
--=====================================================================================