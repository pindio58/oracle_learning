--========================================== Triggers start here ===============================================

/*
Syntax:
    
    create or replace trigger <trigger name> 
    {BEFORE | AFTER | INSTEAD OF}                   --> any one
    {INSERT or DELETE or UPDATE}                    --> any one
    {OF <column name>}                              --> Optional, it will have the trigger on particular column of that table
    {on <table name>}                               --> Table name
    {REFRENCE OLD AS o NEW AS n}                    --> Optional, will tell us whether the old value and new values are same
    [FOR EACH ROW]                                  --> Optional , to specify ROW LEVEL Trigger
    BEGIN           
        executables
    EXCEPTION
    END;
    /

*/



--==============================  First trigger (before update statement level)  ===============================

CREATE OR REPLACE TRIGGER my_trigger_b_u_s BEFORE
    UPDATE ON emps
BEGIN
    dbms_output.put_line('******************* BEFORE UPDATE STATEMENT LEVEL *******************');
END;
/




--================================  Second trigger (BEFORE UPDATE ROW LEVEL) ===================================

CREATE OR REPLACE TRIGGER my_trigger_b_u_r BEFORE
    UPDATE ON emps FOR EACH ROW
BEGIN
    dbms_output.put_line('******************* BEFORE UPDATE ROW LEVEL *******************');
END;
/



--==============================  Third trigger (AFTER UPDATE ROW LEVEL )========================================

CREATE OR REPLACE TRIGGER my_trigger_a_u_r AFTER
    UPDATE ON emps FOR EACH ROW
BEGIN
    dbms_output.put_line('******************* AFTER UPDATE ROW LEVEL *******************');
END;
/



--===============================  Fourth trigger (AFTER UPDATE STATENT LEVEL ) =================================

CREATE OR REPLACE TRIGGER my_trigger_a_u_s AFTER
    UPDATE ON emps
BEGIN
    dbms_output.put_line('******************* AFTER UPDATE STATENT LEVEL *******************');
END;
/

--===============================================================================================================

select job_id,COUNT(*) "Total Empl" from emps
GROUP BY job_id;


select * from emps where job_id='IT_PROG';

update emps set last_name =last_name||'_updated'
where job_id='IT_PROG';

