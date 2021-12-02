/*
We will perfrom the testing on 'emps' table
So let's first give privilege to 'temp' user to perform DDLs
*/


create user temp identified by temp123; -- created from system schema

--give all roles to temp
grant all PRIVILEGES to temp;
commit;

-- create an audit table
CREATE TABLE schema_audit (
    ddl_date      DATE,
    ddl_user      VARCHAR2(20),
    object_type   VARCHAR2(20),
    object_name   VARCHAR2(20),
    ddl_operation VARCHAR2(20)
);
commit;


-- create the trigger
CREATE OR REPLACE TRIGGER powerful_audit AFTER DDL ON SCHEMA DECLARE
--==================================================================================================================
-- We are going to create a trigger which will keep audit on the schema
-- few learnings:
--      This will keep track of schema in which this is created
--      we cam keep audit of different DDLs instead of all DDLs
--          *   for this we need to replace 'trigger' with any other DDL operation such as 'Truncate', 'CREATE' etc.
--==================================================================================================================
 BEGIN
    INSERT INTO schema_audit VALUES (
        sysdate,
        --sys_context('USERENV','CURRENT_USER'),--user,
        user,
        ora_dict_obj_type,
        ora_dict_obj_name,
        ora_sysevent
    );

END;
/

commit;
--perfrom DDL operation from 'Temp' and 'powerful' both users
select * from schema_audit order by 1;
create table powerful.temp3 (val number);
select sys_context('USERENV','CURRENT_USER') from  dual;
-- to perfrom action using temp user
insert into temp values(9);
commit;
TRUNCATE TABLE powerful.temp6;

select * from temp3;