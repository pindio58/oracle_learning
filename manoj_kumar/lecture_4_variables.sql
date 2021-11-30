/*
What are variables ?
    it allocates mempry for the variable
    should be valid NAME
    valid datatype
    valid width

how to initialise
    assigning a value to variable

where can we initialise
    declare section
    begin section
    exception section
*/


-- First case

declare

v_name VARCHAR2(100) := 'Oracle Shooter';

begin
dbms_output.put_line('We are in deckare section '|| v_name );

exception
  when others then
    dbms_output.put_line('Exception has occured, please chevk the porcess' );
END;



-- Second case

declare

v_name VARCHAR2(100) ;

begin
v_name := 'Oracle Shooter';
dbms_output.put_line('We are in deckare section '|| v_name );

exception
  when others then
    dbms_output.put_line('Exception has occured, please chevk the porcess' );
END;



-- third case

declare

v_name VARCHAR2(10) ;

begin
v_name := 'Oracle Shooter who is genius';
dbms_output.put_line('We are in deckare section '|| v_name );

exception
  when others then
    v_name:='Singh';
    dbms_output.put_line('Exception has occured, please check the porcess, ' || v_name);
END;
