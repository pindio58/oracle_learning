SELECT
    column_value
FROM
    TABLE ( sys.dbms_debug_vc2coll('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER') );
    
    

BEGIN
    EXECUTE IMMEDIATE 'CREATE USER APP_ADMIN_USER IDENTIFIED BY APP_ADMIN_USER123';
END;
/
commit;
select * from user_objects where upper(object_name) in ('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER');

BEGIN
    sp_create_schema('app_data');
END;
/
drop user APP_ADMIN_USER;

--

select * from dba_users ;
select * from dba_users where upper(username) in ('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER');

--
BEGIN
    dbms_output.put_line('string(''x'',10)= '
                         || dbms_random.string('x', 10));
END;
/

SELECT
            column_value,  dbms_random.string('p', 20)
        FROM
            TABLE ( sys.dbms_debug_vc2coll('APP_DATA', 'APP_CODE', 'APP_ADMIN', 'APP_USER', 'APP_ADMIN_USER')), dual;
            
--== lock / unlock
ALTER USER hr IDENTIFIED BY hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY hr ACCOUNT LOCK;


--===

DROP TABLE JOBS CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;

--===

SELECT  * FROM jobs;
SELECT  * FROM aud;
SELECT  * FROM user_tables WHERE upper(table_name) IN ( SELECT  upper(obj_name)  FROM  aud);

--== from app_code ===
SET LINESIZE 80
SET SPACE 2
SET RECSEP WRAPPED
SET RECSEPCHAR "="
COLUMN NAME FORMAT A15 WORD_WRAPPED
COLUMN HIRE_DATE FORMAT A20 WORD_WRAPPED
COLUMN DEPARTMENT_NAME FORMAT A10 WORD_WRAPPED
COLUMN JOB_TITLE FORMAT A29 WORD_WRAPPED
COLUMN MANAGER FORMAT A11 WORD_WRAPPED;

begin
    employees_pkg.change_job( 101, 'AD_VP', 17500, 90 );
end;
/

--===============  For sql plus ================

SET LINESIZE 80
SET RECSEP WRAPPED
SET RECSEPCHAR "="
COLUMN NAME FORMAT A15 WORD_WRAPPED
COLUMN HIRE_DATE FORMAT A20 WORD_WRAPPED
COLUMN DEPARTMENT_NAME FORMAT A10 WORD_WRAPPED
COLUMN JOB_TITLE FORMAT A29 WORD_WRAPPED
COLUMN MANAGER FORMAT A11 WORD_WRAPPED

--============ rough work ==========

SELECT naam,subject, round(AVG(percentage),2) AS percentage
FROM (
    SELECT naam,DECODE(unpivot_row, 1, 'Math',
                               2, 'Science',
                               3, 'Computer') AS subject,
           DECODE(unpivot_row, 1, math,
                               2, science,
                               3, computer) AS percentage
    FROM tablea
    CROSS JOIN (SELECT level AS unpivot_row FROM dual CONNECT BY level <= 3)
)
GROUP BY naam,subject
ORDER BY subject;

drop table tablea;
create table tablea (naam varchar(15),math number, science number, computer number);
insert into tablea values(90,89,95);
insert into tablea values(99,98,98);
insert into tablea values('JIm',85,75,90);
select * from tablea;
delete from tablea;