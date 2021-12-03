/***********************************************************************************
Associative array
    This is third type of collection
    Data is stored in the form of key-value pair
    Syntax:
        TYPE books IS  TABLE OF VARCHAR2(25) INDEX BY NUMBER;
        Here VARCHAR is key's data type and NUMBER is value's datatype
        INDEX by is used to denote how to create it...

***********************************************************************************/
DECLARE
    TYPE books IS
        TABLE OF VARCHAR2(25) INDEX BY VARCHAR2(25);
    v_book books;
BEGIN
    v_book('Jeet') := 'Anum';
    v_book('Tommy') := 'Grace';
    dbms_output.put_line(v_book('Jeet'));
    v_book('Jeet') := 'ANUM';
    dbms_output.put_line(v_book('Jeet'));
END;
/

--==========

DECLARE
    TYPE books IS
        TABLE OF VARCHAR2(25) INDEX BY VARCHAR2(25);
    v_book books;
    flag   VARCHAR2(25);
BEGIN
    v_book('Jeet') := 'Anum';
    v_book('Tommy') := 'Grace';
    v_book('John') := 'Glassy';
    flag := v_book.first;
    WHILE flag IS NOT NULL LOOP
        dbms_output.put_line('key '''
                             || flag
                             || ''' has the value: '
                             || v_book(flag));

        flag := v_book.next(flag);
    END LOOP;

END;
/