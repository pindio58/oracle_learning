--== From app_code

--== create synonyms
CREATE OR REPLACE PROCEDURE sp_generate_syns AS
BEGIN
    EXECUTE IMMEDIATE 'CREATE SYNONYM employees FOR app_data.employees';
    EXECUTE IMMEDIATE 'CREATE SYNONYM departments FOR app_data.departments';
    EXECUTE IMMEDIATE 'CREATE SYNONYM jobs FOR app_data.jobs';
    EXECUTE IMMEDIATE 'CREATE SYNONYM job_history FOR app_data.job_history';
END sp_generate_syns;
/

--=== create the package ===

CREATE OR REPLACE PACKAGE employees_pkg AS
    PROCEDURE get_employees_in_dept (
        p_deptno     IN employees.department_id%TYPE,
        p_result_set IN OUT SYS_REFCURSOR
    );

    PROCEDURE get_job_history (
        p_employee_id IN employees.department_id%TYPE,
        p_result_set  IN OUT SYS_REFCURSOR
    );

    PROCEDURE sp_create_view;

    PROCEDURE show_employee (
        p_employee_id IN employees.employee_id%TYPE,
        p_result_set  IN OUT SYS_REFCURSOR
    );

    PROCEDURE update_salary (
        p_employee_id IN employees.employee_id%TYPE,
        p_new_salary  IN employees.salary%TYPE
    );

    PROCEDURE change_job (
        p_employee_id IN employees.employee_id%TYPE,
        p_new_job     IN employees.job_id%TYPE,
        p_new_salary  IN employees.salary%TYPE := NULL,
        p_new_dept    IN employees.department_id%TYPE := NULL
    );

END employees_pkg;
/

--=== create the package body ===

CREATE OR REPLACE PACKAGE BODY employees_pkg AS

    PROCEDURE get_employees_in_dept (
        p_deptno     IN employees.department_id%TYPE,
        p_result_set IN OUT SYS_REFCURSOR
    ) IS
        l_cursor SYS_REFCURSOR;
    BEGIN
        OPEN p_result_set FOR SELECT
                                  e.employee_id,
                                  e.first_name
                                  || ' '
                                  || e.last_name                            name,
                                  to_char(e.hire_date, 'Dy Mon ddth, yyyy') hire_date,
                                  j.job_title,
                                  m.first_name
                                  || ' '
                                  || m.last_name                            manager,
                                  d.department_name
                              FROM
                                       employees e
                                  INNER JOIN jobs        j ON ( e.job_id = j.job_id )
                                  LEFT OUTER JOIN employees   m ON ( e.manager_id = m.employee_id )
                                  INNER JOIN departments d ON ( e.department_id = d.department_id )
                              WHERE
                                  e.department_id = p_deptno;

    END get_employees_in_dept;

    PROCEDURE get_job_history (
        p_employee_id IN employees.department_id%TYPE,
        p_result_set  IN OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_result_set FOR SELECT
                                  e.first_name
                                  || ' '
                                  || e.last_name   name,
                                  j.job_title,
                                  e.job_start_date start_date,
                                  to_date(NULL)    end_date
                              FROM
                                       employees e
                                  INNER JOIN jobs j ON ( e.job_id = j.job_id )
                              WHERE
                                  e.employee_id = p_employee_id
                              UNION ALL
                              SELECT
                                  e.first_name
                                  || ' '
                                  || e.last_name name,
                                  j.job_title,
                                  jh.start_date,
                                  jh.end_date
                              FROM
                                       employees e
                                  INNER JOIN job_history jh ON ( e.employee_id = jh.employee_id )
                                  INNER JOIN jobs        j ON ( jh.job_id = j.job_id )
                              WHERE
                                  e.employee_id = p_employee_id
                              ORDER BY
                                  start_date DESC;

    END get_job_history;

    PROCEDURE sp_create_view AS
    BEGIN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW testing AS
                                with details as  (SELECT TO_CHAR(e.employee_id) employee_id,
                                                      e.first_name || '' '' || e.last_name name,
                                                      e.email_addr,
                                                      TO_CHAR(e.hire_date,''dd-mon-yyyy'') hire_date,
                                                      e.country_code,
                                                      e.phone_number,
                                                      j.job_title,
                                                      TO_CHAR(e.job_start_date,''dd-mon-yyyy'') job_start_date,
                                                      to_char(e.salary) salary,
                                                      m.first_name || '' '' || m.last_name manager,
                                                      d.department_name
                                                    FROM employees e INNER JOIN jobs j on (e.job_id = j.job_id)
                                                      RIGHT OUTER JOIN employees m ON (m.employee_id = e.manager_id)
                                                      INNER JOIN departments d ON (e.department_id = d.department_id)
                                                ) ,
                                
                                    sec_det as(
                                               select ''employee_id'' Attribute, employee_id value,1 ord , employee_id from details det
                                        union  select ''NAME'' Attribute, name value,2 ord,employee_id from details det
                                        union  select ''EMAIL ADDR'' Attribute, EMAIL_ADDR value,3 ord,employee_id from details det
                                        union  select ''HIRE DATE'' Attribute, HIRE_DATE value,4 ord,employee_id from details det
                                        union  select ''COUNTRY CODE'' Attribute, COUNTRY_CODE value,5 ord,employee_id from details det
                                        union  select ''PHONE NUMBER'' Attribute, PHONE_NUMBER value,6 ord,employee_id from details det
                                        union  select ''JOB TITLE'' Attribute, JOB_TITLE value,7 ord,employee_id from details det
                                        union  select ''JOB START DATE'' Attribute, job_start_date value,8 ord,employee_id from details det
                                        union  select ''SALARY'' Attribute, SALARY value,9 ord,employee_id from details det
                                        union  select ''MANAGER'' Attribute, MANAGER value,10 ord,employee_id from details det
                                        union  select ''DEPARTMENT NAME'' Attribute, DEPARTMENT_NAME value,11 ord,employee_id from details det)
                                    select attribute,value,employee_id from sec_det order by ord';
    END sp_create_view;

    PROCEDURE show_employee (
        p_employee_id IN employees.employee_id%TYPE,
        p_result_set  IN OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_result_set FOR SELECT
                                  *
                              FROM
                                  testing e
                              WHERE
                                  e.employee_id = p_employee_id;

    END show_employee;

    PROCEDURE update_salary (
        p_employee_id IN employees.employee_id%TYPE,
        p_new_salary  IN employees.salary%TYPE
    ) IS
    BEGIN
        UPDATE employees
        SET
            salary = p_new_salary
        WHERE
            employee_id = p_employee_id;

    END update_salary;

    PROCEDURE change_job (
        p_employee_id IN employees.employee_id%TYPE,
        p_new_job     IN employees.job_id%TYPE,
        p_new_salary  IN employees.salary%TYPE := NULL,
        p_new_dept    IN employees.department_id%TYPE := NULL
    ) IS
    BEGIN
        INSERT INTO job_history (
            employee_id,
            start_date,
            end_date,
            job_id,
            department_id
        )
            SELECT
                employee_id,
                job_start_date,
                trunc(sysdate),
                job_id,
                department_id
            FROM
                employees
            WHERE
                employee_id = p_employee_id;

        UPDATE employees
        SET
            job_id = p_new_job,
            department_id = nvl(p_new_dept, department_id),
            salary = nvl(p_new_salary, salary),
            job_start_date = trunc(sysdate)
        WHERE
            employee_id = p_employee_id;

    END change_job;

END employees_pkg;
/

--== Grant pivs to app_user and app_admin_user

CREATE OR REPLACE PROCEDURE sp_grant_pkg_privs AS
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON employees_pkg TO app_user';
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON employees_pkg TO app_admin_user';
END sp_grant_pkg_privs;
/