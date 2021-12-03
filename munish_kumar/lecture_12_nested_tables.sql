/**************************************************************************************************************
Few Notes:
    Nested table is one of the types of collection
    we can create it as standalon/ databse object    OR
    we can declate it in declare section and then use it in executable statements

Syntax of creating/assigning nested table

        DECLARE TYPE <type name> IS   TABLE OF PLS_INTEGER;
        <variable name> <type name> := nested_table(<values>);


**************************************************************************************************************/
DECLARE
    TYPE nested_table IS
        TABLE OF PLS_INTEGER;
    v_numbers nested_table := nested_table(3, 2, 4, 1, 3,
                                          43, 67, 90, 34, 16,
                                          78, 2);
BEGIN
    FOR i IN 1..v_numbers.count LOOP
        dbms_output.put_line('Value at index '
                             || i
                             || ': '
                             || v_numbers(i));
    END LOOP;
END;
/
--====================== aleternative ? ========================
BEGIN
    FOR i IN (
        SELECT
            ROWNUM nums,
            column_value
        FROM
            TABLE ( sys.odcinumberlist(3, 2, 4, 1, 3,
                                       43, 67, 90, 34, 16,
                                       78, 2) )
    ) LOOP
        dbms_output.put_line('Value at index '
                             || i.nums
                             || ': '
                             || i.column_value);
    END LOOP;
END;
/