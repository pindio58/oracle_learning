CREATE OR REPLACE PROCEDURE sp_create_syns_admin AS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM departments FOR app_data.departments';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM jobs FOR app_data.jobs';
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM departments_sequence FOR app_data.departments_sequence';
    
END sp_create_syns_admin;
/

--Below is not required as of now

/* 
CREATE OR REPLACE PROCEDURE sp_generate_syns AS
BEGIN
    sp_create_syns_admin;
END sp_generate_syns;

*/
--==
