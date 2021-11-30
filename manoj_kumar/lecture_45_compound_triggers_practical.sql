CREATE OR REPLACE TRIGGER compound_trigger FOR
    INSERT OR DELETE OR UPDATE ON emps
COMPOUND TRIGGER

--first 
    BEFORE STATEMENT IS BEGIN
        dbms_output.put_line('************ Before statement ************');
    END BEFORE STATEMENT;

--second
    BEFORE EACH ROW IS BEGIN
        dbms_output.put_line('************ Before EACH ROW ************');
    END BEFORE EACH ROW;

--third
    AFTER EACH ROW IS BEGIN
        dbms_output.put_line('************ AFTER EACH ROW ************');
    END AFTER EACH ROW;

--fourth
    AFTER STATEMENT IS BEGIN
        dbms_output.put_line('************ AFTER statement ************');
    END AFTER STATEMENT;
END compound_trigger;


--=======================================================================================================================================================================

CREATE OR REPLACE TRIGGER compound_trigger FOR
    INSERT OR DELETE OR UPDATE ON emps
COMPOUND TRIGGER

--first 
    BEFORE STATEMENT IS BEGIN
        dbms_output.put_line('************ Before statement ************');
        IF inserting THEN
            dbms_output.put_line('INSERT');
        ELSIF updating THEN
            dbms_output.put_line('Update');
        ELSIF deleting THEN
            dbms_output.put_line('delete');
        END IF;

    END BEFORE STATEMENT;

--second
    BEFORE EACH ROW IS BEGIN
        dbms_output.put_line('************ Before EACH ROW ************');
        IF inserting THEN
            dbms_output.put_line('INSERT');
        ELSIF updating THEN
            dbms_output.put_line('Update');
        ELSIF deleting THEN
            dbms_output.put_line('delete');
        END IF;

    END BEFORE EACH ROW;

--third
    AFTER EACH ROW IS BEGIN
        dbms_output.put_line('************ AFTER EACH ROW ************');
        IF inserting THEN
            dbms_output.put_line('INSERT');
        ELSIF updating THEN
            dbms_output.put_line('Update');
        ELSIF deleting THEN
            dbms_output.put_line('delete');
        END IF;

    END AFTER EACH ROW;

--fourth
    AFTER STATEMENT IS BEGIN
        dbms_output.put_line('************ AFTER statement ************');
        IF inserting THEN
            dbms_output.put_line('INSERT');
        ELSIF updating THEN
            dbms_output.put_line('Update');
        ELSIF deleting THEN
            dbms_output.put_line('delete');
        END IF;

    END AFTER STATEMENT;
END compound_trigger;