CREATE OR REPLACE TRIGGER employees_aiufer AFTER
    INSERT OR UPDATE OF salary, job_id ON employees
    FOR EACH ROW
DECLARE
    l_cnt NUMBER;
BEGIN
    LOCK TABLE jobs IN SHARE MODE;  -- Ensure that jobs does not change
                                  -- during the following query.
    SELECT
        COUNT(*)
    INTO l_cnt
    FROM
        jobs
    WHERE
            job_id = :new.job_id
        AND :new.salary BETWEEN min_salary AND max_salary;

    IF ( l_cnt <> 1 ) THEN
        raise_application_error(-20002,
                               CASE
                                   WHEN :new.job_id = :old.job_id THEN
                                       'Salary modification invalid'
                                   ELSE 'Job reassignment puts salary out of range'
                               END
        );
    END IF;

END;
/



-- Second trigger
CREATE OR REPLACE TRIGGER jobs_aufer AFTER
    UPDATE OF min_salary, max_salary ON jobs
    FOR EACH ROW
    WHEN ( new.min_salary > old.min_salary
           OR new.max_salary < old.max_salary )
DECLARE
    l_cnt NUMBER;
BEGIN
    LOCK TABLE employees IN SHARE MODE;
    SELECT
        COUNT(*)
    INTO l_cnt
    FROM
        employees
    WHERE
            job_id = :new.job_id
        AND salary NOT BETWEEN :new.min_salary AND :new.max_salary;

    IF ( l_cnt > 0 ) THEN
        raise_application_error(-20001, 'Salary update would violate '
                                        || l_cnt
                                        || ' existing employee records');
    END IF;

END;
/