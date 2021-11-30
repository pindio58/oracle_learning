-- Lecture 2 ( Anonymous block) --

/*
    Mainly one time activity
    No name is give
    No need to create or save
    Syntax is:
        BEGIN
        <CODE>
        END;
    Two types:
        Static   ->  Everything is hardcodes
        Dynamic  ->  Paramterised (ask for input)
    
    Structure:
        DECLARE     (Optional)
        BEGIN       (Mandatory)
        EXCEPTION   (Optional)
        END;         (Mandaotory)
*/

-- Annoymous

-- BEGIN
-- dbms_output.put_line('Hello Oracle');
-- END;





-- Static Anonymous block  --

DECLARE
    v_value_1 NUMBER;
    v_value_2 NUMBER;
    v_total NUMBER;

BEGIN
    v_value_1 :=1;
    v_value_2 :=5;

    v_total := v_value_1+v_value_2;

    dbms_output.put_line('Total:');


    dbms_output.put_line( v_total);
    dbms_output.put_line('Total again: ' || v_total);
END;


-- Dynamic Anonymous block  --

DECLARE
    v_value_1 NUMBER;
    v_value_2 NUMBER;
    v_total NUMBER;

BEGIN
    v_total := &v_value_1+ &v_value_2;

    dbms_output.put_line('Total:');


    dbms_output.put_line( v_total);
    dbms_output.put_line('Total again: ' || v_total);
END;
