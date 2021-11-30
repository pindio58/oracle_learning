--========================================
--=          Practical examples         ==
--========================================



--===========================================================================================================================================    
--                                          Let's perfrom DML on a view first (Simple View)
--===========================================================================================================================================    

-- create a view --

BEGIN
    EXECUTE IMMEDIATE 'create or replace view v_emps as select employee_id, department_id, first_name,last_name from emps';
    commit;
END;
/ 

-- perfrom operation (insert) --

DECLARE
    v_id NUMBER;
BEGIN
    SELECT
        new_numbers.NEXTVAL
    INTO v_id
    FROM
        dual;

    INSERT INTO v_emps (
        employee_id,
        department_id,
        first_name,
        last_name
    ) VALUES (
        v_id,
        90,
        'Tommy',
        'Shelby'
    );

    COMMIT;
END;
/

SELECT
    *
FROM
    v_emps;

--===========================================================================================
-- This was run in order to check if update statement is successful or not                 ==
-- Since this is a simple view, we can run an update on view, there is no problem in that  ==
--===========================================================================================

UPDATE v_emps
SET
    department_id = 85
WHERE
    employee_id = 100;


--=============================================== STARTS HERE (CREATING COMPOUND VIEW) ===============================================
--As we have seen there is no problem while running update/insert or any other dml on simple views
--Now we are going to work on compound views
--====================================================================================================================================

-- create local emp table --

BEGIN
    p_table_create;
END;
/

-- create local dept table --

BEGIN
    p_table_create('depts', 'departments');
END;
/

-- create a view --
CREATE OR REPLACE VIEW v_emps_depts AS
    SELECT
        emps.employee_id,
        emps.email,
        emps.department_id,
        depts.department_name,
        depts.location_id
    FROM
             emps emps
        JOIN depts depts ON ( depts.department_id = emps.department_id )
    UNION ALL
    SELECT
        emps.employee_id,
        emps.email,
        emps.department_id,
        depts.department_name,
        depts.location_id
    FROM
             hr.employees emps
        JOIN hr.departments depts ON ( depts.department_id = emps.department_id )
    WHERE
        1 = 2;

COMMIT;

-- Both below statements give error, So we will need trigger here
BEGIN
--update v_emps_depts set department_id=85 where employee_id=100;
    INSERT INTO v_emps_depts VALUES (
        1003,
        'dummy',
        53,
        'dumm_name',
        90
    );

    COMMIT;
END;
/

-- For this specific operaton we are createing tables differently since we need few columns

BEGIN
    EXECUTE IMMEDIATE 'drop table emps';
    EXECUTE IMMEDIATE 'drop table depts';
    EXECUTE IMMEDIATE 'create table emps  as select employee_id, email, department_id from hr.employees';
    EXECUTE IMMEDIATE 'create table depts as select department_id,department_name, location_id from hr.departments';
END;
/

-- Create a trigger
CREATE OR REPLACE TRIGGER insert_instead_of INSTEAD OF
    INSERT ON v_emps_depts
    FOR EACH ROW
DECLARE
    v_dept  NUMBER;
    v_count NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_count
    FROM
        emps
    WHERE
        employee_id = :new.employee_id;

    IF ( v_count = 1 ) THEN
        NULL;
    ELSE
        INSERT INTO emps (
            employee_id,
            email,
            department_id
        ) VALUES (
            :new.employee_id,
            :new.email,
            :new.department_id
        ) RETURNING department_id INTO v_dept;

        dbms_output.put_line('********* INSERT DONE INTO EMPLOYEES TABLE *********');
        dbms_output.put_line('********* RETURNING DEPARTMENT ID: '
                             || v_dept
                             || ' *********');
    END IF;

    SELECT
        COUNT(1)
    INTO v_count
    FROM
        emps
    WHERE
        department_id = v_dept;

    IF ( v_count = 1 ) THEN
        NULL;
    ELSE
        INSERT INTO depts (
            department_name,
            location_id,
            department_id
        ) VALUES (
            :new.department_name,
            :new.location_id,
            :new.department_id
        );

        dbms_output.put_line('********* INSERT DONE INTO DEPARTMENT TABLE *********');
    END IF;

END;
/

-- Insert now 
BEGIN
    INSERT INTO v_emps_depts VALUES (
        1003,
        'dummy',
        53,
        'dumm_name',
        90
    );

    COMMIT;
END;
/


--*********************************************************   Update Starts here  *********************************************************

-- Below didn't work, so we are creating update trigger here

UPDATE v_emps_depts
SET
    department_name = 'This is new department'
WHERE
    location_id = 1400;
/

-- createing trigger now --
CREATE OR REPLACE TRIGGER update_instead_of INSTEAD OF
    UPDATE ON v_emps_depts
    FOR EACH ROW
DECLARE
    v_dept NUMBER;
BEGIN

-- update on departments 
    UPDATE depts
    SET
        department_name = nvl(:new.department_name, :old.department_name),
        department_id = nvl(:new.department_id, :old.department_id)
    WHERE
        location_id = :new.location_id
    RETURNING department_id INTO v_dept;

    dbms_output.put_line('***** Update done on Department table ****');
    dbms_output.put_line('***** Returning department id: '
                         || v_dept
                         || ' ****');

-- update on employees
    UPDATE emps
    SET
        employee_id = nvl(:new.employee_id, :old.employee_id),
        email = nvl(:new.email, :old.email)
    WHERE
        department_id = v_dept;

    dbms_output.put_line('***** Update done on Employee table ****');
END;
/


--working now --
UPDATE v_emps_depts
SET
    department_name = 'This is new department'
WHERE
    location_id = 1400;
/