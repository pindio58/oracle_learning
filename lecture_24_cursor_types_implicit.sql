/*
Cursor:-
A cursor is a pointer to a private SQL area that stores information about processing a specific SELECT or DML statement.

types of cursors
1. Implicit cursor
2. Explicit cursor

1. Implicit cursor :- A cursor that is constructed and managed by PL/SQL is an implicit cursor.  
these cursors are automatically created by oracle every time when you run any DML statements and very imporatant thing we can not control the behviour of these cursors.

2. Explicit Cursor:-
first of all my dear friends Explicit cursors are user defined cursors it means these cursors are created by user only and its bheaviour is controled by user only .

*/
--====================================================
--Example:- --Implicit cursor
--DML events are:-
--
--1. Insert
--2. Update
--3. Delete

-- these all are cursors(implicit)
--====================================================

-- Simple cursor

begin
update  emps
SET
    employee_id = 100
WHERE
    upper(email) = 'SKING';
end;

--==================================================================================================
--we are going to mention sql%found here.
--    sql here is last cursor name (oracke by default name last implicit cursor as sql)
--    so basically it tells us if something inserted/upated, print this...
--==================================================================================================

BEGIN
    INSERT INTO emps VALUES (
        1009,
        'Nitin',
        'Kumar',
        'kumarNitin',
        456525,
        '19-NOV-21',
        'vp',
        21000,
        NULL,
        784,
        10
    );

    IF ( SQL%found ) THEN
        dbms_output.put_line('Done');
    ELSE
        dbms_output.put_line('Not Done');
    END IF;

END;