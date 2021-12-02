select user FROM dual;

select * from emps;

create table emps as select employee_id, first_name, last_name,email from hr.employees;
commit;

drop table emps;
commit;

create user powerful identified by temp123;
grant all  PRIVILEGES to powerful; 
commit;

select * from emp_audit;
drop trigger tempo;
-- below was done from TEMP user --

select * from powerful.emps;

INSERT INTO powerful.emps VALUES (
    95,
    'Shelby'
);

commit;

select sum((bytes/1024)/1024) from dba_data_files;

---=======================================================================================================

select * from emps;

create user temp identified by temp123;
commit;
grant all PRIVILEGES to temp;

----================================================

show user;


commit;
TRUNCATE TABLE powerful.temp;

drop table POWERFUL.temp2;

create table powerful.temp7(c number);

--==

alter user powerful identified by temp123;
commit;

--===
execute <procdure name>;
exec <procdure name>;



--============================================================================================================================================
CREATE OR REPLACE FUNCTION calc_area (
    radius NUMBER DEFAULT 2
) RETURN NUMBER AS
    v_area NUMBER;
BEGIN
    v_area := 3.14 * power(radius, 2);
    RETURN v_area;
END;
/

--============================================================================================================================================
DECLARE
    v_num NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_num
    FROM
        user_tables
    WHERE
        upper(table_name) = 'EMPS';

    IF ( v_num = 1 ) THEN
        EXECUTE IMMEDIATE 'DROP TABLE EMPS';
    END IF;
END;
/


--============================================================================================================================================
-- how to write a csv file from pl sql
--============================================================================================================================================

create or replace directory temp_dir as '/home/jeet/'
/
commit;
grant read on DIRECTORY temp_dir to system;

DECLARE
    f    utl_file.file_type;
    CURSOR c1 IS
    SELECT
        employee_id,
        first_name,
        last_name,
        e.department_id,
        department_name
    FROM
        hr.employees   e,
        hr.departments d
    WHERE
        e.department_id = d.department_id
    ORDER BY
        employee_id;

    c1_r c1%rowtype;
BEGIN
    f := utl_file.fopen('temp_dir', 'EMP_DEPT.CSV', 'w', 32767);
    FOR c1_r IN c1 LOOP
        utl_file.put(f, c1_r.employee_id);
        utl_file.put(f, ',' || c1_r.first_name);
        utl_file.put(f, ',' || c1_r.last_name);
        utl_file.put(f, ',' || c1_r.department_id);
        utl_file.put(f, ',' || c1_r.department_name);
        utl_file.new_line(f);
    END LOOP;

    utl_file.fclose(f);
END;
/

--=========== hwo to connect as sysdba================

--connect sys/a@abcd as sysdba