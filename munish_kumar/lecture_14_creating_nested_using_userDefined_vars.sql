/***********************************************************************************
Few points:
    This is similar to previous lecture
    For this, we need to first create a user defined type/variable/object
    Then use that object as table of ..
***********************************************************************************/


--create a type (object like number/varchar) first
CREATE OR REPLACE TYPE object_type AS OBJECT (
    obj_id   NUMBER,
    obj_name VARCHAR2(30)
);
/

-- create a nested table
CREATE OR REPLACE TYPE nested_table IS
    TABLE OF object_type;
/

--create a table
CREATE TABLE demo (
    subject VARCHAR(20),
    details nested_table
)
NESTED TABLE details STORE AS temp;
/

--insert values
INSERT INTO demo VALUES (
    1,
    NULL
);

COMMIT;

SELECT
    *
FROM
    demo;

delete from demo where (subject,rowid ) in (
select subject,max(rowid) over (PARTITION BY subject)from demo where subject=1);

-- This is how you insert values into such types
INSERT INTO demo VALUES (
    3,
    nested_table(object_type(5, 'char'))
);

SELECT
    *
FROM
    TABLE (
        SELECT
            details
        FROM
            demo
        WHERE
            subject = 2
    );