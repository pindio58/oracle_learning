CREATE OR REPLACE PROCEDURE sp_data_load (
    p_name VARCHAR2
) IS

    p_jobs        VARCHAR2(1000);
    p_departments VARCHAR2(1000);
    p_employees   VARCHAR2(5000);
    p_job_hist    VARCHAR2(1000);
BEGIN
    p_jobs := 'INSERT INTO jobs (job_id, job_title, min_salary, max_salary) ' || 'SELECT job_id, job_title, min_salary, max_salary FROM HR.JOBS';
    p_departments := 'INSERT INTO departments (department_id, department_name, manager_id) ' || 'SELECT department_id, department_name, manager_id FROM HR.DEPARTMENTS';
    p_job_hist := 'INSERT INTO job_history (employee_id, job_id, start_date, end_date, department_id) ' || 'SELECT employee_id, job_id, start_date, end_date, department_id 
            FROM HR.JOB_HISTORY';
    p_employees := 'INSERT INTO employees (
                            employee_id,
                            first_name,
                            last_name,
                            email_addr,
                            hire_date,
                            country_code,
                            phone_number,
                            job_id,
                            job_start_date,
                            salary,
                            manager_id,
                            department_id
                        )
                            SELECT
                                employee_id,
                                first_name,
                                last_name,
                                email,
                                hire_date,
                                CASE
                                    WHEN phone_number LIKE ''011.%'' THEN
                                        ''+''
                                        || substr(phone_number, instr(phone_number, ''.'') + 1, instr(phone_number, ''.'', 1, 2) - instr(phone_number, ''.'') -
                                        1)
                                    ELSE
                                        ''+1''
                                END country_code,
                                CASE
                                    WHEN phone_number LIKE ''011.%'' THEN
                                        substr(phone_number, instr(phone_number, ''.'', 1, 2) + 1)
                                    ELSE
                                        phone_number
                                END phone_number,
                                job_id,
                                nvl((
                                    SELECT
                                        MAX(end_date + 1)
                                    FROM
                                        hr.job_history jh
                                    WHERE
                                        jh.employee_id = employees.employee_id
                                ), hire_date),
                                salary,
                                manager_id,
                                department_id
                            FROM
                                hr.employees';
                                
--Loading starts

    IF ( upper(p_name) = 'JOBS' ) THEN
        EXECUTE IMMEDIATE p_jobs;
    ELSIF ( upper(p_name) = 'DEPARTMENTS' ) THEN
        EXECUTE IMMEDIATE p_departments;
    ELSIF ( upper(p_name) = 'EMPLOYEES' ) THEN
        EXECUTE IMMEDIATE p_employees;
    ELSE
        EXECUTE IMMEDIATE p_job_hist;
    END IF;

END sp_data_load;