-- Creating/Declaring a package

CREATE OR REPLACE PACKAGE funcandproc AS

/*******************************************************************************
Few Notes:
    We have to create package and its body separately
    paramter names must be same
    whatever functions/procudres are declared in package, must be implemented
*******************************************************************************/

--function 
    FUNCTION circle_area (
        radius NUMBER
    ) RETURN NUMBER;

--procedure
    PROCEDURE area_values (
        inpradius NUMBER,
        area      NUMBER
    );

END funcandproc;
/

--Creating its body

CREATE OR REPLACE PACKAGE BODY funcandproc AS

-------------Implementing function----------

    FUNCTION circle_area (
        radius NUMBER
    ) RETURN NUMBER AS
        v_pi CONSTANT NUMBER := 3.14;
        v_area NUMBER;
    BEGIN
        v_area := v_pi * power(radius, 2);
        RETURN v_area;
    END circle_area;

-------------Implementing procedure----------

    PROCEDURE area_values (
        inpradius NUMBER,
        area      NUMBER
    ) AS
    BEGIN
        INSERT INTO areas VALUES (
            inpradius,
            area
        );

    END area_values;

END funcandproc;
/
commit;


--Try out some things
DECLARE
--    v_input NUMBER := 4;
    v_area NUMBER;
BEGIN
    FOR i IN (
        SELECT
            level v_num
        FROM
            dual
        CONNECT BY
            level <= 10
    ) LOOP
        v_area := funcandproc.circle_area(i.v_num);
        funcandproc.area_values(i.v_num, v_area);
    END LOOP;
END;
/
select * from areas ;
truncate table areas;
commit;

select level giveninput , (3.14 * power(level,2)) area from dual connect by level<=10;