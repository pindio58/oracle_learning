--===================
--Defining Package
--===================
CREATE OR REPLACE PACKAGE create_db_objects authid current_user AS
    PROCEDURE sp_create_objects ;

    PROCEDURE sp_create_views;

    PROCEDURE sp_create_sequence;

END create_db_objects;
/


--======================
--Defining Package body
--======================

CREATE OR REPLACE PACKAGE BODY create_db_objects AS

--=================================
--First Procedure (create Tables)
--=================================
    PROCEDURE sp_create_objects IS

        v_num         NUMBER;
                                
                                --jobs--

        v_jobs        VARCHAR2(5000) := 'CREATE TABLE jobs (
                                    job_id     VARCHAR2(10)
                                        CONSTRAINT jobs_pk PRIMARY KEY,
                                    job_title  VARCHAR2(35)
                                        CONSTRAINT jobs_job_title_not_null NOT NULL,
                                    min_salary NUMBER(6)
                                        CONSTRAINT jobs_min_salary_not_null NOT NULL,
                                    max_salary NUMBER(6)
                                        CONSTRAINT jobs_max_salary_not_null NOT NULL
                                )';

                                
                                --departments --

        v_departments VARCHAR2(5000) := 'CREATE TABLE departments (
                                    department_id   NUMBER(4)
                                        CONSTRAINT departments_pk PRIMARY KEY,
                                    department_name VARCHAR2(30)
                                        CONSTRAINT department_name_not_null NOT NULL
                                        CONSTRAINT department_name_unique UNIQUE,
                                    manager_id      NUMBER(6)
                                )';

                                --employees--

        v_employees   VARCHAR2(5000) := 'CREATE TABLE employees (
                                    employee_id    NUMBER(6)
                                        CONSTRAINT employees_pk PRIMARY KEY,
                                    first_name     VARCHAR2(20)
                                        CONSTRAINT emp_first_name_not_null NOT NULL,
                                    last_name      VARCHAR2(25)
                                        CONSTRAINT emp_last_name_not_null NOT NULL,
                                    email_addr     VARCHAR2(25)
                                        CONSTRAINT emp_email_addr_not_null NOT NULL,
                                    hire_date      DATE DEFAULT trunc(sysdate)
                                        CONSTRAINT emp_hire_date_not_null NOT NULL
                                        CONSTRAINT emp_hire_date_check CHECK ( trunc(hire_date) = hire_date ),
                                    country_code   VARCHAR2(5)
                                        CONSTRAINT emp_country_code_not_null NOT NULL,
                                    phone_number   VARCHAR2(20)
                                        CONSTRAINT emp_phone_number_not_null NOT NULL,
                                    job_id
                                        CONSTRAINT emp_job_id_not_null NOT NULL
                                        CONSTRAINT emp_jobs_fk
                                            REFERENCES jobs,
                                    job_start_date DATE
                                        CONSTRAINT emp_job_start_date_not_null NOT NULL,
                                    CONSTRAINT emp_job_start_date_check CHECK ( trunc(job_start_date) = job_start_date ),
                                    salary         NUMBER(6)
                                        CONSTRAINT emp_salary_not_null NOT NULL,
                                    manager_id
                                        CONSTRAINT emp_mgr_to_empno_fk
                                            REFERENCES employees,
                                    department_id
                                        CONSTRAINT emp_to_dept_fk
                                            REFERENCES departments
                                )';

        
                                    -- job_history --

        v_job_hist    VARCHAR2(5000) := 'CREATE TABLE job_history (
                                    employee_id
                                        CONSTRAINT job_hist_to_employees_fk
                                            REFERENCES employees,
                                    job_id
                                        CONSTRAINT job_hist_to_jobs_fk
                                            REFERENCES jobs,
                                    start_date DATE
                                        CONSTRAINT job_hist_start_date_not_null NOT NULL,
                                    end_date   DATE
                                        CONSTRAINT job_hist_end_date_not_null NOT NULL,
                                    department_id
                                        CONSTRAINT job_hist_to_departments_fk  REFERENCES departments
                                        CONSTRAINT job_hist_dept_id_not_null NOT NULL,
                                        CONSTRAINT job_history_pk PRIMARY KEY ( employee_id, start_date ),
                                        CONSTRAINT job_history_date_check CHECK ( start_date < end_date )
                                )';
    BEGIN
        --EXECUTE IMMEDIATE 'CREATE TABLE AUD (obj_id NUMBER, obj_name VARCHAR2(25),create_dt VARCHAR2(25))';  -- create a fresh AUD table
        FOR i IN ( SELECT column_value FROM  TABLE ( sys.dbms_debug_vc2coll( 'jobs', 'departments', 'employees', 'job_history') ) ) LOOP
            v_num:=0;
            SELECT COUNT(1) INTO v_num  FROM user_tables WHERE upper(table_name) = upper(i.column_value);
            
            --audit --
            INSERT INTO aud VALUES ( v_num, upper(i.column_value), sysdate);
            
            --to drop --
            IF ( v_num = 1 ) THEN
                EXECUTE IMMEDIATE 'drop table ' || i.column_value||' CASCADE CONSTRAINTS';
            END IF;

            -- to actually create the tables --

            IF upper(i.column_value) = 'JOBS' THEN
                EXECUTE IMMEDIATE v_jobs;
            ELSIF upper(i.column_value) = 'DEPARTMENTS' THEN
                EXECUTE IMMEDIATE v_departments;
            ELSIF upper(i.column_value) = 'EMPLOYEES' THEN
                EXECUTE IMMEDIATE v_employees;
            ELSE
                EXECUTE IMMEDIATE v_job_hist;
            END IF;

        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(sqlcode
                                 || ': '
                                 || sqlerrm);
    END sp_create_objects;

--=================================
--Second Procedure (create Views)
--=================================

    PROCEDURE sp_create_views AS
    BEGIN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW v_jobs AS SELECT * FROM jobs';
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW v_departments AS SELECT * FROM departments';
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW v_employees AS SELECT * FROM employees';
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW v_job_history AS SELECT * FROM job_history';
    END sp_create_views;

--=================================
--Third Procedure (create Sequences)
--=================================

    PROCEDURE sp_create_sequence IS
        v_emp          NUMBER;
        v_dept         NUMBER;
        v_emp_max_num  NUMBER;
        v_dept_max_num NUMBER;
    BEGIN
        v_emp:=0;
        v_dept:=0;
        
        SELECT COUNT(1) INTO v_emp  FROM user_sequences   WHERE lower(sequence_name) = 'employees_sequence';
        SELECT COUNT(1) INTO v_dept FROM user_sequences   WHERE lower(sequence_name) = 'departments_sequence';

        SELECT COUNT(1) INTO v_emp_max_num  FROM hr.employees;
        SELECT COUNT(1) INTO v_dept_max_num FROM hr.departments;

        IF ( v_emp = 1 ) THEN
            EXECUTE IMMEDIATE 'DROP SEQUENCE employees_sequence';
        END IF;
        
        IF ( v_dept = 1 ) THEN
            EXECUTE IMMEDIATE 'DROP SEQUENCE departments_sequence';
        END IF;
        
        EXECUTE IMMEDIATE 'CREATE SEQUENCE employees_sequence START WITH ' || v_emp_max_num;
        EXECUTE IMMEDIATE 'CREATE SEQUENCE departments_sequence START WITH ' || v_dept_max_num;
    END sp_create_sequence;

END create_db_objects;
/