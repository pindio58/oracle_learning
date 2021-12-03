/**************************************************************************************************************************************************
Collection Methods

    *   There are certain methods of tehse collections. Some of them can be applied on all, some on few collections(nested table, varrays, 
        associative array)
    *   These are built-in functions and procedures
    *   There are total 10 types of methods:
            
            7 collection functions: 
                
                Count:        Gives us the count of elements
                Exists:       checks the existence of element at specified location
                First/Last:   returns the first and last index (NOT THE VALUE). Can be used with all three collections
                              raises exception if applied to uninitialised collection
                Limit:        Maximum number of elemnets a varray can hold
                Prior/Next    Gives the index of next, last  elemnt(NOT THE VALUE)
            
            
            3 collection methods:   
                
                Delete:       Can be used in three different ways
                                    call without parameters:
                                        will delete all values
                                    call with index number:
                                        delete the value at specified location
                                    call with two numbers:
                                        this will be a range, so it will delete values form 1st paramter till second parameter
                
                Extend:       Cannot be used with associative array
                              Can be used in three different ways
                                    call without parameters:
                                        will apend a single NULL value at last
                                    call with index number:
                                        will append number of NULLs as mentioned by that number
                                    call with two numbers:
                                        IN this case, first value indicates, how many places/values to be appended
                                        second number is the index number whose value will be copued over to all appended places
                                
                                        
                Trim:         Can be used in two different ways
                                    call without parameters:
                                        will remove a single value from last
                                    call with index number: - TRIM(n)
                                        will remove number of elements as mentioned by that number
                                     
                
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
    IF ( my_table.EXISTS(2) ) THEN
        dbms_output.put_line('value at specified location: ' || my_table(2));
    ELSE
        dbms_output.put_line('No data found');
    END IF;
        IF ( my_table.EXISTS(9) ) THEN
        dbms_output.put_line('value at specified location: ' || my_table(2));
    ELSE
        dbms_output.put_line('No data found');
    END IF;
END;
/


--=== First and last ===

DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 3, 5, 6, 7,
                                         1, 97);
BEGIN
    dbms_output.put_line('First Value: ' || my_table.first);
    dbms_output.put_line('Last Value: ' || my_table.last);
END;
/



--=== Limit ===

DECLARE
    TYPE varr IS
        VARRAY(5) OF varchar(25);
    v_arr varr := varr(NULL, 4);
BEGIN
    dbms_output.put_line('Size of vArray is: ' || v_arr.limit);
    dbms_output.put_line('Size of vArray using count function is: ' || v_arr.count); -- 2 since we supplied 2 nulls only
END;
/


--=== Prior and Next ===


DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 9, 5, 6, 7,
                                         1, 97);
BEGIN
    dbms_output.put_line('Prior to index 3 --> '||my_table.prior(3));
    dbms_output.put_line('Value at Prior to index 3 --> '||my_table(my_table.prior(3)));
END;
/


DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 9, 5, 6, 7,
                                         1, 97);
BEGIN
    dbms_output.put_line('Next to index 3 --> '||my_table.next(3));
    dbms_output.put_line('Value at Next to index 3 --> '||my_table(my_table.next(3)));
END;
/



--=== Delete ===


DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 9, 5, 6, 7,
                                         1, 97);
BEGIN
    dbms_output.put_line('Value to index 3 before applying DELETE--> '||my_table(3));
    my_table.delete(3);
    dbms_output.put_line('Value to index 3 before applying DELETE--> '||my_table(3));
    
-- handling exception since after deleting no data will be found at locations 3
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Deleted the data, so there is no data at specified location');
END;
/


-----


DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 9, 5, 6, 7,
                                         1, 97);
BEGIN
    my_table.DELETE(3, 5);
    FOR i IN 1..my_table.last LOOP
        IF ( my_table.EXISTS(i) ) THEN
            dbms_output.put_line('Value to index ['
                                 || i
                                 || '] is '
                                 || my_table(i));

        END IF;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Deleted the data, so there is no data at specified location');
END;
/

------
DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 9, 5, 6, 7,
                                         1, 97);
BEGIN
    FOR i IN 1..my_table.last LOOP
        IF ( my_table.EXISTS(i) ) THEN
            dbms_output.put_line('Value to index ['
                                 || i
                                 || '] is '
                                 || my_table(i));

        END IF;
    END LOOP;
-- deleted all --
    my_table.DELETE;
    dbms_output.put_line(my_table.last);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Deleted the data, so there is no data at specified location');
END;
/



--===== EXTEND =====

DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2);
BEGIN
    my_table.EXTEND(5,1);                       -- Hope this single example covers all types
    FOR i IN 1..my_table.last LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;
END;
/




--===== TRIM ====
DECLARE
    TYPE nested_table IS
        TABLE OF VARCHAR2(5);
    my_table nested_table := nested_table(2, 3, 5, 6, 7,
                                         1, 97);
BEGIN
    FOR i IN 1..my_table.last LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;

    my_table.trim(3);
    dbms_output.put_line(chr(10));
    dbms_output.put_line('After trimming:');
    FOR i IN 1..my_table.last LOOP
        dbms_output.put_line(my_table(i));
    END LOOP;

END;
/