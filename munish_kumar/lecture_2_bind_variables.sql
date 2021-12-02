/*
Bind variables are also called host variables
these can be declared anywhere in host envirnment
according to oracle doc, bind variavles are such variables which can be declared in sql plus and then can be referred in pl/sql
we dont need to write a block to declare it, see below.
good article
    https://www.rittmanmead.com/blog/2004/03/bind-variables-explained/

*/

--declaration
VARIABLE v_pi NUMBER;

--initialisation
EXEC :v_pi := 3.14;
--or
EXECUTE :v_pi := 3.14;
--or
BEGIN
    :v_pi := 3.14;
END;
/

-- how to display
-- we can use dbms_ouput or print
-- if we omit any argument in print statement, i will display all bind variables
print :v_pi;

-- or we can use like below:
set AUTOPRINT ON;
VARIABLE x VARCHAR2(25);
EXEC :x := 5;

