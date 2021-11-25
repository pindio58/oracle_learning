/*
implicit cursor always return isopen false since its too fast

mainly here, there are 4 types of cursor attributes:
    found
    notfound
    isopen
    rowcount
Other two types
SQL%BULK_ROWCOUNT : Getting Number of Rows Affected by FORALL Statement

SQL%BULK_EXCEPTIONS : Handling FORALL Exceptions After FORALL Statement Complete


--====================================================
-- Use of Cursors Attributes with Implicit cursor :-( an implicit cursor is also called a SQL cursor )
/*
An implicit cursor is a session cursor that is constructed and managed by PL/SQL.
PL/SQL opens an implicit cursor every time you run a SELECT or DML statement.
You cannot control an implicit cursor, but you can get information from its attributes.

Syntax:-
SQLattribute :- SQLattribute always refers to the most recently run SELECT or DML statement. If no such statement has run, the value of SQLattribute is NULL.

*/ 
    
--example 1:
BEGIN
    DELETE FROM emps
    WHERE
        department_id = 10;

    IF ( SQL%notfound ) THEN     -- we can use here sql%found also
        dbms_output.put_line('Nothing for this dept no');
    ELSE
        dbms_output.put_line(SQL%rowcount || ' deleted for this dept no');
    END IF;

END;