--here we are going to study if statement only


DECLARE
    v_hindi NUMBER;
BEGIN
    v_hindi := :hindi;
    IF ( v_hindi > 33 ) THEN
        dbms_output.put_line('PASSED');
    END IF;
END;



--here we are going to study if else statement only

DECLARE
    v_hindi NUMBER;
BEGIN
    v_hindi := :hindi;
    IF ( v_hindi > 33 ) THEN
        dbms_output.put_line('PASSED');
    ELSE
        dbms_output.put_line('FAILED');
    END IF;

END;





--here we are going to study NESTED IF (and also elsif) statement only

DECLARE
    v_hindi   NUMBER;
    v_english NUMBER;
BEGIN
    v_hindi := :hindi;
    v_english := :english;
    IF ( v_hindi > 33 ) THEN
        IF ( v_english > 33 ) THEN
            dbms_output.put_line('passed in both');
        ELSE
            dbms_output.put_line('passed only in hindi');
        END IF;
    ELSIF ( v_english > 33 ) THEN
        dbms_output.put_line('passed only in english');
    ELSE
        dbms_output.put_line('failed in both');
    END IF;

END;