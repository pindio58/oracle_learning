/*
Compound triggers
This is a compound of all triggers
when we need to get all triggers at once , we use these compound triggers 

Syntax:
    create or replace trigger xx for insert/update/delete on <table name>
    compound trigger
    before statement begin .. end;
    before each row begin .. end;
    after each row begin .. end;
    after statement begin .. end;
*/

