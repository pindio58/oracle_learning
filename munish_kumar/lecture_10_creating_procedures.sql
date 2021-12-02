/****************************************************************************************************************************************
Few Notes:
    AUDTHID:- It basically gives the "authoirity" to the procedure, to what user we need to give the
    Suppose there are two users(powerful and temp). Both have same table in their schemas (areas)
    Procedure originally created in 'powerful' schema.
    If I use AUTHID as CURRENT USER and run the procesure from 'temp' user, it will populate the table areas in 'temp' schema only
    If I use AUTHID as DEFINER      and run the procesure from 'temp' user, it will populate the table areas in 'powerful' schema only

****************************************************************************************************************************************/

create table areas (givenInput NUMBER,area NUMBER);
commit;
drop table areas;
--============================================


CREATE OR REPLACE PROCEDURE calc_areas (
    radius NUMBER DEFAULT 1
) AUTHID DEFINER AS 

--==============================================================================
--Unlike pl/sql functions, procedures' values cannot be assigned to a varaible
--==============================================================================
    v_pi   CONSTANT NUMBER := 3.14;
    v_area NUMBER;
BEGIN
    v_area := v_pi * ( power(radius, 2) );
    DBMS_OUTPUT.put_line(v_area);
    INSERT INTO areas VALUES (radius, v_area );
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Something is wrong in procedure.');
END;
/

--=======
TRUNCATE TABLE areas;

begin
for i in (select level p_value from dual connect by level<=10) loop
calc_areas(i.p_value);

END LOOP ;
end;

select * from areas;

grant all on calc_areas to temp;
commit;
/

DELETE FROM areas
WHERE
    ROWID NOT IN (
        SELECT
            MAX(ROWID)
            OVER(PARTITION BY p.giveninput) rnk
        FROM
            areas p
    );
    
select * from areas;