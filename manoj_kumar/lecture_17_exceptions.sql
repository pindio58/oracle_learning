/*

what is exception
    which basically halts the program with inforseen issues

why use
    to hanlde unwanted things and convey usefule message to end usesr
    
where we use
    pl/sql prgrams where business requirements are not met
    
how many types
    * Named exception / system defined exception / pre defined exceptions
    * unnamed exception/ user-defined exception

*we should write exceptions to avoid loopholes

* all we need to do is 
    declare an exception in declare
    raise it
    print something
*/

DECLARE
    v_name VARCHAR2(3);
BEGIN
    v_name := :namess;
END;