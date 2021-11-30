CREATE OR REPLACE FUNCTION abc (
    a   VARCHAR2    
) RETURN VARCHAR2 AS
    namess VARCHAR2(100) := '1';
BEGIN
    with details as (select decode (lower(a),'capital',64,96) nums from dual)
    select listagg(chr(level+det.nums),'') within group (order by null) into namess from details det
    connect by level<=26;
    return namess;
END;


select abc('small') letters from dual;

with alll as (select 'jeet' aaa from dual)
select case aaa
when regexp_like('[:lower:]') then''
else 'kidda' end naam from alll;

SELECT tzname, COUNT(*) FROM   gv$timezone_names GROUP by tzname;

select 
       SYSTIMESTAMP at time zone 'Africa/Johannesburg' south_africa_time
from dual;



--=====================


create or replace function details(query_selector varchar2 DEFAULT NULL) return SYS_REFCURSOR  as
return_cursor SYS_REFCURSOR;
begin
    if upper(query_selector)='EMP' then
    open return_cursor for select last_name,employee_id from hr.employees;
    else
    open return_cursor for select department_name,department_id from hr.departments;
    end if;
    
    return return_cursor;
end ;

 --==================================================================================================================================================
 
 
declare

return_cursor SYS_REFCURSOR;
v_name VARCHAR2(40);
v_number number;

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
    commit;
    DBMS_OUTPUT.put_line(SQL%ROWCOUNT);
END;
/
 
 --========================================= CREATE A VIEW  =================================================
 
select * from user_constraints where table_name='EMPS';
/

BEGIN
    EXECUTE IMMEDIATE 'create or replace view v_emps as select employee_id, department_id, first_name,last_name from emps';
    commit;
END;
/ 
--========================================= CREATE A SEQUENCE  ===============================================

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
