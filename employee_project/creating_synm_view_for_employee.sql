--to be run before creating emp package

--== create synonyms
CREATE OR REPLACE PROCEDURE sp_generate_syns AS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM employees FOR app_data.employees';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM departments FOR app_data.departments';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM jobs FOR app_data.jobs';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM job_history FOR app_data.job_history';
END sp_generate_syns;
/

--== CREATE A VIEW

CREATE OR REPLACE PROCEDURE sp_create_view AS
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
/