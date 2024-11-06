-- CANDIDATE USER - "Chris Jones" creation
SET SERVEROUTPUT ON;
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'CJONES';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "USERS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE USER CJONES IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO CJONES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ADMIN_SUPER_USER.REQUISITION TO CJONES';
    
    
    dbms_output.put_line('CANDIDATE USER "Chris Jones" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/