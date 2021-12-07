/*
This is FIRST step and has to run admin/sys privelege

Objective:
    1)  This will create all 5 schemas/users
    2)  This will provide required roles to all of those schemas/users

*/

BEGIN
    sp_create_schema;                       -- create Schemas/users

    sp_execute_grant_privs;                 -- grant required priveleges
END;
/