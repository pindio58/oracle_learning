-- multivalue or composite variables
DECLARE
-- var1 varchar2(100)
-- var2 number
-- var3 emp.enp_name%type

-- how to use 
--  var4.emp_name

    var4 hr.employees%rowtype;
BEGIN
    SELECT
        employee_id
    INTO var4.employee_id
    FROM
        hr.employees
    WHERE
        rownum=1;

    dbms_output.put_line(var4.employee_id);
END;
/

SELECT
    *
FROM
    emps;