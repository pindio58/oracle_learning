/**************************************************************************************************************************************************
Collection Methods

    *   There are certain methods of tehse collections. Some of them can be applied on all, some on few collections(nested table, varrays, 
        associative array)
    *   These are built-in functions and procedures
    *   There are total 10 types of methods:
            7 collection functions: 
                Count: Gives us the count of elements
                Exists: checks the existence of element at specified location
                First/Last
                Limit
                Prior/Next
            3 collection methods:   
                Delete
                Extend
                Trim
    *   All explained below                
**************************************************************************************************************************************************/

--=== Count ===

DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 3, 5, 6, 7,
                                         1, 97);
BEGIN
    dbms_output.put_line(my_table.count);
END;
/
--

DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 3, 5, 6, 7,
                                         1, 97);
BEGIN
    FOR i IN 1..my_table.count LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;
END;
/


--=== Exists ===

DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 3, 5, 6, 7,
                                         1, 97);
BEGIN
    FOR i IN 1..my_table.count LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;
END;
/


