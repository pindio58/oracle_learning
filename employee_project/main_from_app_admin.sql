CREATE OR REPLACE PROCEDURE sp_create_syns_admin AS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM departments FOR app_data.departments';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM jobs FOR app_data.jobs';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM departments_sequence FOR app_data.departments_sequence';
    
END sp_create_syns_admin;
/


CREATE OR REPLACE PROCEDURE sp_generate_syns AS
BEGIN
    sp_create_syns_admin;
END sp_generate_syns;
/
--==

CREATE OR REPLACE PACKAGE admin_pkg AS
    PROCEDURE update_job (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE := NULL,
        p_min_salary IN jobs.min_salary%TYPE := NULL,
        p_max_salary IN jobs.max_salary%TYPE := NULL
    );

    PROCEDURE add_job (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE
    );

    PROCEDURE update_department (
        p_department_id     IN departments.department_id%TYPE,
        p_department_name   IN departments.department_name%TYPE := NULL,
        p_manager_id        IN departments.manager_id%TYPE := NULL,
        p_update_manager_id IN BOOLEAN := false
    );

    FUNCTION add_department (
        p_department_name IN departments.department_name%TYPE,
        p_manager_id      IN departments.manager_id%TYPE
    ) RETURN departments.department_id%TYPE;

END admin_pkg;
/

--==

CREATE OR REPLACE PACKAGE BODY admin_pkg AS

    PROCEDURE update_job (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE := NULL,
        p_min_salary IN jobs.min_salary%TYPE := NULL,
        p_max_salary IN jobs.max_salary%TYPE := NULL
    ) IS
    BEGIN
        UPDATE jobs
        SET
            job_title = nvl(p_job_title, job_title),
            min_salary = nvl(p_min_salary, min_salary),
            max_salary = nvl(p_max_salary, max_salary)
        WHERE
            job_id = p_job_id;

    END update_job;

    PROCEDURE add_job (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE
    ) IS
    BEGIN
        INSERT INTO jobs (
            job_id,
            job_title,
            min_salary,
            max_salary
        ) VALUES (
            p_job_id,
            p_job_title,
            p_min_salary,
            p_max_salary
        );

    END add_job;

    PROCEDURE update_department (
        p_department_id     IN departments.department_id%TYPE,
        p_department_name   IN departments.department_name%TYPE := NULL,
        p_manager_id        IN departments.manager_id%TYPE := NULL,
        p_update_manager_id IN BOOLEAN := false
    ) IS
    BEGIN
        IF ( p_update_manager_id ) THEN
            UPDATE departments
            SET
                department_name = nvl(p_department_name, department_name),
                manager_id = p_manager_id
            WHERE
                department_id = p_department_id;

        ELSE
            UPDATE departments
            SET
                department_name = nvl(p_department_name, department_name)
            WHERE
                department_id = p_department_id;

        END IF;
    END update_department;

    FUNCTION add_department (
        p_department_name IN departments.department_name%TYPE,
        p_manager_id      IN departments.manager_id%TYPE
    ) RETURN departments.department_id%TYPE IS
        l_department_id departments.department_id%TYPE;
    BEGIN
        INSERT INTO departments (
            department_id,
            department_name,
            manager_id
        ) VALUES (
            departments_sequence.NEXTVAL,
            p_department_name,
            p_manager_id
        );

        RETURN l_department_id;
    END add_department;

END admin_pkg;
/

--=====   =======


CREATE OR REPLACE PROCEDURE sp_grant_privs AS
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON admin_pkg TO app_admin_user';
END sp_grant_privs;
/