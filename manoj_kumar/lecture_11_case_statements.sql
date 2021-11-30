/*
This videeo is about the case statement

There are two types of case statemnets:
    simple case
    search case statement
*/



-- simple case

select * from emps;

SELECT
    first_name,
    CASE first_name
        WHEN 'Steven' THEN
            100
        ELSE
            0
    END AS grade
FROM
    emps;
    
    
-- Second (search statement)


SELECT
    first_name,
    CASE 
        WHEN first_name='Steven' THEN
            100
        ELSE
            0
    END AS grade
FROM
    emps;
     