/*

    Here we will use ref cursor with a function
    This lecture is basicalla a guide or just an explantion about details
    Next lecture is practical examples

*/

--====================================================================================================================================================
-- Normal way to createa function
--====================================================================================================================================================

/*

create or REPLACE FUNCTION eq_f(a VARCHAR2, b VARCHAR2) RETURN NUMBER AS
BEGIN
   IF a = b THEN RETURN 1;
   ELSE RETURN 0;
   END IF;
END;

*/



--====================================================================================================================================================
-- Use a reference cursor with a fucntion
--====================================================================================================================================================
CREATE OR REPLACE FUNCTION first_one (
    a VARCHAR2
) RETURN SYS_REFCURSOR AS
    c1 SYS_REFCURSOR;
BEGIN
    OPEN c1 FOR SELECT
                    *
                FROM
                    hr.employees;

    RETURN c1;
END;