/*
FORALL
    *   FORALL reduces context switching during execution of DML statemnets    
    *   It is bulk loop construct which executes one dml statement multiple times at once
    *   It is reverse of BULK COLLECT, as in FORALL, it takes data from collection to TABLE
Syntax:
    FORALL  index in bound_clause [SAVE EXCEPTION]
    DML Statements;
    
        *   [SAVE EXCEPTION] -> This saves the program from exiting even after having exeception
        *   bound_clause ->     It controls the value of index as well as decides the number of iterations
                                There are three types of bound_clause:
                                1)  specify the starting and ending index. For such, make sure the collection is not sparse
                                2)  INDICES OF: This is when the collection is sparse and don't have consecutive index numbers to specify
                                3)  VALUES OF:  this is when we need to mention a group of indices which don't need to be wither unique or consecutive
                                                (i.e. pre defined)
                            
Unlike for loop, in FORALL , we can use one DML at a time
*Sparse means there are no consecutive indexes.

*/


--== with Upper and lower bound ==

CREATE TABLE checks (
    valuess NUMBER
);

DECLARE
    TYPE v_arr IS
        TABLE OF number;
    arr v_arr := v_arr(3, 4, 5, 23, 57,
                      90, 5, 78, 42, 4);
BEGIN
    FORALL i IN arr.first..arr.last
        INSERT INTO checks VALUES ( arr(i) );

END;
/

select * from checks order by 1;



--== By using INDEX of ===

TRUNCATE TABLE checks DROP STORAGE;


DECLARE
    TYPE v_arr IS
        TABLE OF number;
    arr v_arr := v_arr(3, 4, 5, 23, 57,
                      90, 5, 78, 42, 4);
BEGIN
    arr.delete(3,6);
    FORALL i IN INDICES OF arr                               --arr.first..arr.last  this will give error since we have deletd values of 3 and 6 indices
        INSERT INTO checks VALUES ( arr(i) );

END;
/

select * from checks ;



--== Using values of ===

/*
So what we have done here 
    created nested table type
    created associated array 
        this will be used as source index whose values we will use to insert into table

Point to note here that when we are inserting data into 'arr' , doesnt matter what index we are using for arr, mainly matters what values are stored
    In this case-> 5,10,3
    These values will be used as indexes for nested ttable
*/

DECLARE
    TYPE nested_table IS
        TABLE OF NUMBER;
    TYPE v_varray IS
        TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
    nested_arr nested_table := nested_table(3, 4, 5, 23, 57,
                                           90, 5, 78, 42, 4);
    arr        v_varray;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE table checks drop STORAGE';
    arr(1) := 5;
    arr(5) := 10;
    arr(2) := 3;
    FORALL i IN VALUES OF arr
        INSERT INTO checks VALUES ( nested_arr(i) );

END;
/

select * from checks;