drop table startup_table;
CREATE TABLE startup_table (
    event_type  VARCHAR2(20),
    event_tdate DATE
);

commit;

CREATE OR REPLACE TRIGGER startup_trigger AFTER STARTUP ON DATABASE BEGIN
    insert into startup_table values(ora_sysevent,sysdate);
END;
/

select * from startup_table;