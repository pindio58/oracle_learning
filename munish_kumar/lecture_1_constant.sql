-- This is rhe right way to do it
--we have to declare and assign in declare section itself
DECLARE
    v_num CONSTANT NUMBER := 0.1;
BEGIN
    dbms_output.put_line(v_num);
END;
/

--Below will give error
DECLARE
    v_num CONSTANT NUMBER;
BEGIN
    v_num := 0.1;
    dbms_output.put_line(v_num);
END;
/

-- another concepts

-- by using 'DEFAULT' keyword, the bracker next to NUMBER tell us the precision..
DECLARE
    v_pi CONSTANT NUMBER(7, 6) DEFAULT 3.14;
BEGIN
    dbms_output.put_line('This string breaks here: '||v_pi);
END;
/

-- by using not Null
--This thing can bse used with variables also

DECLARE
    v_pi CONSTANT NUMBER(7, 6) NOT NULL DEFAULT 3.14;
BEGIN
    dbms_output.put_line('This string breaks here: '||v_pi);
END;
/