/***********************************************************************************
Few points:
    This is second type of collection
    This is bounded 1.e. there is LIMIT to it
    VARRAY is keyword which means variable array
    There are three types of creating it. All given below
        1)  Declare a type 
            Use it to initialise empty
            use EXTEND method to allocate memory of how many values. For e.g in below, 4 null will be assigned/allocated memory in new_array
            
        2)  Declare a type 
            Use it to initialise empty and at the same type assign 'null's of as many elemnrs we want
            
        3)  Create a type of varray , like we used to do and use it further in program
            This way we dont need to mention/assign null values. We can simply tell it while creating type
        
    Subscript (with round brackets) is used to retrive values
***********************************************************************************/

--=== First Method =====
DECLARE
    TYPE new_array IS
        VARRAY(4) OF VARCHAR2(5);
    arr new_array := new_array();
BEGIN
    arr.extend(4);
    FOR i IN 1..arr.limit LOOP
        arr(i) := i * 1000;
        dbms_output.put_line(arr(i));
    END LOOP;

END;
/

--=== Second Method =====
DECLARE
    TYPE new_array IS
        VARRAY(4) OF VARCHAR2(5);
    arr new_array := new_array(NULL, NULL, NULL, NULL);
BEGIN
    FOR i IN 1..arr.limit LOOP              -- Limit is collection which returns mx numnber of elements ALLOWED in the VARRAY
        arr(i) := i * 1000;
        dbms_output.put_line(arr(i));
    END LOOP;
END;


--=== Creating as a Database object ===
CREATE OR REPLACE TYPE varr IS
    VARRAY(5) OF NUMBER;
    
CREATE TABLE calender (
    dayname    VARCHAR2(25),
    day_values varr
);
/

INSERT INTO calender VALUES (
    'Sunday',
    varr(5, 4)
);

SELECT
    column_value
FROM
    TABLE (
        SELECT
            day_values
        FROM
            calender
    );

SELECT
    dayname,
    column_value
FROM
    calender,
    TABLE ( day_values );