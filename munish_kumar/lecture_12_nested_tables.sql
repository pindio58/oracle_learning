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