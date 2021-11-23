/*
this was done by my own to study/test
DECLARE
    v_name NUMBER;
    rased EXCEPTION;
BEGIN
    BEGIN
    SELECT
        'jeet'
    INTO v_name
    FROM
        dual;

EXCEPTION
    WHEN value_error THEN
    raise rased;
    END;
EXCEPTION
when rased then
dbms_output.put_line('done');
end;

*/


--==================================================
-- to check if you are leigible for voting
--==================================================


DECLARE
    v_age NUMBER := 16;
    no_valid_age EXCEPTION;
    just_like_that EXCEPTION;
BEGIN
    IF v_age < 18 THEN
        RAISE no_valid_age;
    END IF;
EXCEPTION
    WHEN just_like_that THEN
        dbms_output.put_line('what just happened');
    WHEN no_valid_age THEN
        dbms_output.put_line('you are not eligible to vote, go home kid!');
END;
/



-- testing

create or REPLACE PROCEDURE voting as
    v_age NUMBER := 16;
    no_valid_age EXCEPTION;
    just_like_that EXCEPTION;
BEGIN
    IF v_age < 18 THEN
        RAISE no_valid_age;
    END IF;
EXCEPTION
    WHEN just_like_that THEN
        dbms_output.put_line('what just happened');
    WHEN no_valid_age THEN
        dbms_output.put_line('you are not eligible to vote, go home kid!');
END;
/


-- from his blog

DECLARE
  V_Your_age   NUMBER:=16;
  NOT_VALID_AGE EXCEPTION;
BEGIN
 
  IF V_Your_age < 18 THEN
    RAISE NOT_VALID_AGE;
  END IF;
  
EXCEPTION
WHEN NOT_VALID_AGE THEN
    DBMS_OUTPUT.PUT_LINE ('You are not authorized for vote you are below 18 years');   
END;


--====================================
-- By using raise_application_error
--====================================
DECLARE
    v_age NUMBER := 16;
BEGIN
    IF v_age < 18 THEN
        raise_application_error(-20008, 'go home kid');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;