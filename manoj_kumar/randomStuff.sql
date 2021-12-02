CREATE OR REPLACE FUNCTION abc (
    a VARCHAR2
) RETURN VARCHAR2 IS
    namess VARCHAR2(100) := '1';
BEGIN
    WITH details AS (
        SELECT
            decode(lower(a), 'capital', 64, 96) nums
        FROM
            dual
    )
    SELECT
        LISTAGG(chr(level + det.nums), '') WITHIN GROUP(
        ORDER BY
            NULL
        )
    INTO namess
    FROM
        details det
    CONNECT BY
        level <= 26;

    RETURN namess;
END;

SELECT
    abc('small') letters
FROM
    dual;

WITH alll AS (
    SELECT
        'jeet' aaa
    FROM
        dual
)
SELECT
    CASE aaa
        WHEN regexp_like('[:lower:]') THEN
            ''
        ELSE
            'kidda'
    END naam
FROM
    alll;

SELECT
    tzname,
    COUNT(*)
FROM
    gv$timezone_names
GROUP BY
    tzname;

SELECT
    systimestamp AT TIME ZONE 'Africa/Johannesburg' south_africa_time
FROM
    dual;


--=====================

CREATE OR REPLACE FUNCTION details (
    query_selector VARCHAR2 DEFAULT NULL
) RETURN SYS_REFCURSOR AS
    return_cursor SYS_REFCURSOR;
BEGIN
    IF upper(query_selector) = 'EMP' THEN
        OPEN return_cursor FOR SELECT
                                   last_name,
                                   employee_id
                               FROM
                                   hr.employees;

    ELSE
        OPEN return_cursor FOR SELECT
                                   department_name,
                                   department_id
                               FROM
                                   hr.departments;

    END IF;

    RETURN return_cursor;
END;
 --==================================================================================================================================================

DECLARE
    return_cursor SYS_REFCURSOR;
    v_name        VARCHAR2(40);
    v_number      NUMBER;
BEGIN
    dbms_output.put_line('************************ EMPLOYEE DETAILS ************************');
    return_cursor := details('emp');
    LOOP
        FETCH return_cursor INTO
            v_name,
            v_number;
        EXIT WHEN return_cursor%notfound;
        dbms_output.put_line(return_cursor%rowcount
                             || '-'
                             || v_name
                             || '|salary is:-'
                             || v_number);

    END LOOP;

    dbms_output.put_line(chr(10));
---

    dbms_output.put_line('************************ DEPARTMENT DETAILS ************************');
    return_cursor := details();
    LOOP
        FETCH return_cursor INTO
            v_name,
            v_number;
        EXIT WHEN return_cursor%notfound;
        dbms_output.put_line(return_cursor%rowcount
                             || '-'
                             || v_name);
    END LOOP;

END;

--==================================================================================================================================================

SELECT
    column_value
FROM
    TABLE ( sys.dbms_debug_vc2coll(60, 100) );
/

--==================================== Create a procedure for creating table depending on whether it exists or not ====================================
CREATE OR REPLACE PROCEDURE p_table_create (
    p_name    IN VARCHAR2 DEFAULT 'EMPS',
    p_name_of IN VARCHAR2 DEFAULT 'EMPLOYEES'
) AS

-- =============================================
-- Author:      pindio58
-- Create date: 30/Nov/2021
-- Description: Creates a table after dropping if already exists
--
-- Parameters:
--   @p_name - name of table to create
--   @p_name_of - name of table to create it from

--
-- Change History:
--   30/Nov/2021   pindio58: Initial date
-- =============================================

    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = upper(p_name);

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'drop table ' || p_name;
    END IF;
    EXECUTE IMMEDIATE 'CREATE table '
                      || p_name
                      || ' as select * from hr.'
                      || p_name_of
                      || ' UNION ALL select * from hr.'
                      || p_name_of
                      || ' where 1=2';

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Something wrong in procedure, please check');
        COMMIT;
END;
/

BEGIN
    p_table_create;
    COMMIT;
    dbms_output.put_line(SQL%rowcount);
END;
/
 
 --============================================ CREATE A VIEW  ===========================================================

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMPS';
/

BEGIN
    EXECUTE IMMEDIATE 'create or replace view v_emps as select employee_id, department_id, first_name,last_name from emps';
    COMMIT;
END;
/ 

--============================================= CREATE A SEQUENCE  =======================================================

DECLARE
    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_objects
    WHERE
        upper(object_name) = 'NEW_NUMBERS';

    IF ( v_num > 0 ) THEN
        EXECUTE IMMEDIATE 'DROP sequence new_numbers';
    END IF;
    SELECT
        MAX(employee_id)
    INTO v_num
    FROM
        v_emps;

    EXECUTE IMMEDIATE 'CREATE  SEQUENCE new_numbers
 START WITH     '
                      || v_num
                      || '
 INCREMENT BY   1
 NOCACHE
 NOCYCLE';
    COMMIT;
END;
/


---========================  This is what i am looking for 

SELECT
    column_value
FROM
    TABLE ( sys.odcinumberlist(1, 1, 2, 3, 3,
                               4, 4, 5) );

SELECT
    column_value
FROM
    TABLE ( sys.dbms_debug_vc2coll(1, 1, 2, 3, 3,
                                   4, 4, 5) );
                                   
--===================
SELECT
    column_value
FROM
    TABLE ( sys.dbms_debug_vc2coll(1, 2, 3, 3, 4,
                                   4, 5) );