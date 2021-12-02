CREATE OR REPLACE FUNCTION circle_area (
    radius NUMBER
) RETURN NUMBER AS
    v_pi   CONSTANT NUMBER := 3.14;
    v_area NUMBER;
BEGIN
    v_area := v_pi * ( power(radius, 2) );
    DBMS_OUTPUT.PUT_LINE('Something is wrong in function: '||dbms_utility.format_call_stack||'.Please check.');
    RETURN v_area;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Something is wrong in function: '||dbms_utility.format_call_stack||'.Please check.');
END;
/

select circle_area(3) area from dual;

set SERVEROUTPUT ON;
begin
DBMS_OUTPUT.PUT_LINE(circle_area(3));
end;