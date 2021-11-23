/*
how to use and pass bind variables

variables:
    user variables
    bind variables/global variables/ host variables

Bind variavles ar faster than user variables
*/


-- example 1 (user variables)

declare
v_name varchar2(100):='Jeet';
begin
  dbms_output.put_line('My Name is '|| v_name );

  exception
    when others then
      dbms_output.put_line(SQLERRM);
end;



-- example 2 (BIND variables)

declare
variable v_name varchar2(100);
begin
EXEC  :v_name:='Jeet';
  dbms_output.put_line('My Name is '|| :v_name );

  exception
    when others then
      dbms_output.put_line(SQLERRM);
end;
