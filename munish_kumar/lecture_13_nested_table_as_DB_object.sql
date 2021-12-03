/***********************************************************************************************************************************************
Syntax of creating/assigning nested table

CREATE OR REPLACE TYPE <type name> IS
    TABLE OF <data type (e.g. varchar2(10)>;

Few points:
    When we use this type in a table we have to follow some other additional points
    After declaring column names in bracket, we use syntax -->  NESTED TABLE <column which is nested loop> STORE AS <some name to give to storage>
    
    How we insert values in table column
       *    type name() 
       *    e.g. INSERT INTO subjects VALUES (3,'Comp.Sci', my_nested_table('Tue', 'Fri'));
    
    How to retrive this specific column values
        *   SELECT * FROM TABLE ( SELECT schedule  FROM subjects WHERE sub_id = 1 );

    How to update
        *   UPDATE subjects SET  schedule = my_nested_table('Mon', 'Tue', 'Wed', 'Thu', 'fri', 'Sat') WHERE sub_id = 1;

***********************************************************************************************************************************************/


CREATE OR REPLACE TYPE my_nested_table IS
    TABLE OF VARCHAR2(100);

COMMIT;

---- create table
CREATE TABLE subjects (
    sub_id   NUMBER,
    sub_name VARCHAR(20),
    schedule my_nested_table
)
NESTED TABLE schedule STORE AS scheduled_schedule;

COMMIT;

--
INSERT INTO subjects VALUES (
    1,
    'Maths',
    my_nested_table('Mon', 'Wed')
);

INSERT INTO subjects VALUES (
    2,
    'Physics',
    my_nested_table('Mon', 'Thu')
);

INSERT INTO subjects VALUES (
    3,
    'Comp.Sci',
    my_nested_table('Tue', 'Fri')
);

COMMIT;

BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE subjects';
END;
/

SELECT
    *
FROM
    subjects;

SELECT
    *
FROM
    TABLE (
        SELECT
            schedule
        FROM
            subjects
        WHERE
            sub_id = 1
    );

-- Update 

UPDATE subjects
SET
    schedule = my_nested_table('Mon', 'Tue', 'Wed', 'Thu', 'fri',
                               'Sat')
WHERE
    sub_id = 1;

COMMIT;

-- Update single instance of nested table
UPDATE TABLE (
    SELECT
        schedule
    FROM
        subjects
    WHERE
        sub_id = 1
) a
SET
    a.column_value = 'Sunday'
WHERE
    a.column_value = 'Sat';
/*
DECLARE
    v_names VARCHAR2(50);
BEGIN
    SELECT
        listagg(to_char(sysdate + level, 'DAY'),',') within group(order by null)
    INTO v_names
    FROM
        dual
    CONNECT BY
        level <= 7;

    UPDATE subjects
    SET
        schedule = my_nested_table(v_names)
    WHERE
        sub_id = 1;

END;
/
*/