/*
There is slight difference between anonymous and named procedures
when we comment out the first line and write "DECLARE" instead, it becomes anonymoius block
format is same as anonymous, except declare...
we call it by calling its name as below:
    BEGIN
    XX_ADD_PROC
    END;
*/


CREATE OR REPLACE PROCEDURE XX_ADD_PROC AS

    V_EMPNO NUMBER;
    V_EMPNAME VARCHAR2(100);
    V_SALARY  NUMBER;
    V_DEPTNO NUMBER;
    V_JOB VARCHAR2(100);

BEGIN

    V_EMPNO := 100;
    V_EMPNAME := 'SHELBY';
    V_DEPTNO := 23;
    V_JOB := 'DEVELOPER';
    V_SALARY := 10000;

    dbms_output.put_line('THE EMPLOYEE '|| V_EMPNAME|| ' WHOSE EMPLOYEE NUMBER IS ' || V_EMPNO||' PASSED OUT FROM DEPARTMENT ('|| V_DEPTNO ||')AND IS EARNING SALARY '|| V_SALARY);


EXCEPTION 
WHEN OTHERS THEN
    dbms_output.put_line('WE ARE IN EXCEPTION, PLEASE CHECK THE PROCESS');

END;

BEGIN
XX_ADD_PROC;
END;




-- Below is boiler plate we have used , it's reallz good



-- --Create a new Procedure

-- -- Procedure definition

-- CREATE PROCEDURE PROCEDURE1 (
--   PARAM1 IN NUMBER) IS

-- -- Declare constants and variables in this section.
-- -- Example: <Variable Identifier> <DATATYPE>
-- --          <Variable Identifier> CONSTANT <DATATYPE>
-- --          varEname  VARCHAR2(40);
-- --          varComm   REAL;
-- --          varSalary CONSTANT NUMBER:=1000;
-- --          comm_missing EXCEPTION;
--   varSum NUMBER;

-- -- Executable part starts here
-- BEGIN

--   -- Write PL/SQL and SQL statements to implement the processing logic
--   -- of subprogram. Example:
--   --     SELECT ENAME,
--   --            COMM
--   --     INTO   varEname,
--   --            varComm
--   --     FROM   EMP
--   --     WHERE  EMPNO = 7369;
--   --
--   --     IF varComm IS NULL THEN
--   --         RAISE comm_missing;
--   --     END IF;

--   NULL;

--   -- EXCEPTION -- exception-handling part starts here
--   -- WHEN comm_missing THEN
--   --   dbms_output.put_line('Commision is NULL');

-- END PROCEDURE1;
-- -- 

