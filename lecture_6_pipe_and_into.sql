/*
how to assign a value by using into keyword
and how to use concatenate "||" operator
*/


-- Usage of INTO

declare
    v_name varchar2(100);
    v_empno number;
begin
    select ename,empno into v_name,v_empno from employess where empno=502;
    dbms_output.put_line('emplyee Name: '||v_name||', employee number: '||v_empno);
  exception
    when others then
      dbms_output.put_line(sqlcode,||'  '||SQLERRM);;
end;