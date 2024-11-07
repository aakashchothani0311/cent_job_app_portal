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
        EXECUTE IMMEDIATE 'DROP USER CJONES CASCADE';
        dbms_output.put_line('CJONES "USERS" dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER CJONES IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO CJONES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_APPLIED_HISTORY TO CJONES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_OPEN TO CJONES';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATE_PROFILE TO CJONES';
    dbms_output.put_line('CANDIDATE USER "Chris Jones" created successfully.');

END;
/

-- RECRUITER USER - "Allen Lugo" creation
SET SERVEROUTPUT ON;
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'ALUGO';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER ALUGO CASCADE';
        dbms_output.put_line('ALUGO "USERS" dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER ALUGO IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO ALUGO';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_CREATED_HISTORY TO ALUGO';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATES_JOBS_APPLIED TO ALUGO';
    dbms_output.put_line('RECRUITER USER "Allen Lugo" created successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/

