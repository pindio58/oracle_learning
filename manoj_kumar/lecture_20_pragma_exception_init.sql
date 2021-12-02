/*
This is third type of exception

    * predefined exception
    * user defined exception
    * internally defined exception
        *   It has code but not name
    *   system defined exception has three things below:
        * exception name
        * exception code
        * exception message


we will not handel with name. so we use OTHERS EXCEPTION class in this , IF you wan to handel with Name then option is 
available in Oracle i.e. PRAGMA_EXCEPTION_INIT
for giving the Proper name to any UN-NAME exception in Oracle we will use PRAGMA EXCEPTION_INIT (exception_name, error_code)

So, this is mainly used to name un-named exception in order to handle them as usual way

Syntax:
    PRAGMA_EXCEPTION_INIT(sqlcode, sqlerrm)

code has range 20000 to 20999
sqlerrm has range of 2048 bytes
    
*/

--===========
--Example, we are inserting value of large number
-- Run this , there is no name  altough description is defined
-- but we have got the sql code from running below
--===========
BEGIN
    INSERT INTO emps ( employee_id ) VALUES ( 2333994490011 );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('sqlcode: '|| sqlcode);
        dbms_output.put_line('sqlcode: '|| sqlerrm);
END;




--=================
--Let's name and handle this exception now
--=================


DECLARE
    large_value EXCEPTION;
    PRAGMA exception_init ( large_value, -01438 );
BEGIN
    INSERT INTO emps ( employee_id ) VALUES ( 344800500500 );

EXCEPTION
    WHEN large_value THEN
        dbms_output.put_line('insert some samller valu please!');
END;


create table emps (employee_id nUMBER);