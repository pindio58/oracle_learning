/*


*    This is used when we need to make a dynamic cursor
        what it means is when we have to make to different queries from different tables and have to use same cursor
        this is where ref cursor comes to our rescue
    
*    This is basically a data type , like others
        
*    There are two ways we can define our ref cursor :
         test sys_refcursor;
         type xx is ref cursor;
        

*/

--==================================================================================================================================================
/*

DECLARE
    flag SYS_REFCURSOR;
BEGIN
    OPEN flag FOR SELECT
                      *
                  FROM
                      hr.employees;

    LOOP
        FETCH flag INTO testy;
        EXIT WHEN flag%notfound;
        dbms_output.put_line(flag.last_name);
    END LOOP;

    CLOSE flag;
END;

*/