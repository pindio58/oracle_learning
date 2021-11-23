-- multivalue or composite variables
DECLARE
-- var1 varchar2(100)
-- var2 number
-- var3 emp.enp_name%type

-- how to use 
--  var4.emp_name

var4 emps%ROWTYPE;
BEGIN
SELECT employee_id into var4.employee_id from emps where last_name=:v_name;
dbms_output.put_line(var4.employee_id);
END;

select * from emps;