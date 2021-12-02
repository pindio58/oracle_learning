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