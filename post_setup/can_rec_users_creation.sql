-- CANDIDATE USER creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'CANDIDATE';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER CANDIDATE CASCADE';
        dbms_output.put_line('"CANDIDATE" user dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER CANDIDATE IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO CANDIDATE';
    
    -- Access to tables
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON USERS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON ADDRESS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON CANDIDATES TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON WORK_EXP TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON EDUCATION TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON RESUME TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON SKILLS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, DELETE ON CANDIDATE_SKILLS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON COMPANIES TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON RECRUITERS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOB_REQUISITION TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT ON CANDIDATE_APPLICATION TO CANDIDATE';
    
    -- Acccess to views
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_APPLIED_HISTORY TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON OPEN_JOBS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON CANDIDATE_PROFILE TO CANDIDATE';
    
    -- Access to packages
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON CAN_MGMT TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON CAN_APP_MGMT TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PKG_UTIL TO CANDIDATE';
    
    DBMS_OUTPUT.PUT_LINE('"CANDIDATE" user created successfully.');

EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- COMP_ADMIN USER creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'COMP_ADMIN';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER COMP_ADMIN CASCADE';
        DBMS_OUTPUT.PUT_LINE('"COMP_ADMIN" user dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER COMP_ADMIN IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO COMP_ADMIN';
    
     -- Access to tables
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON USERS TO COMP_ADMIN';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON ADDRESS TO COMP_ADMIN';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON COMPANIES TO COMP_ADMIN';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON RECRUITERS TO COMP_ADMIN';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOB_REQUISITION TO COMP_ADMIN';
    
    -- Acccess to views
    EXECUTE IMMEDIATE 'GRANT SELECT ON OPEN_JOBS TO COMP_ADMIN';
    
    -- Access to packages
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON REC_MGMT TO COMP_ADMIN';
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PKG_UTIL TO COMP_ADMIN';
    
    DBMS_OUTPUT.PUT_LINE('"COMP_ADMIN" user created successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- RECRUITER USER creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'RECRUITER';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER RECRUITER CASCADE';
        DBMS_OUTPUT.PUT_LINE('"RECRUITER" user dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER RECRUITER IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO RECRUITER';
    
     -- Access to tables
    EXECUTE IMMEDIATE 'GRANT SELECT ON USERS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON ADDRESS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATES TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON WORK_EXP TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON EDUCATION TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON RESUME TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON SKILLS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATE_SKILLS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON COMPANIES TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON RECRUITERS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON JOB_REQUISITION TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE (STATUS) ON CANDIDATE_APPLICATION TO RECRUITER';
    
    -- Acccess to views
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON JOBS_CREATED_HISTORY TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATES_JOBS_APPLIED TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON OPEN_JOBS TO RECRUITER';
    
    -- Access to packages
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON JOB_REQ_MGMT TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PKG_UTIL TO RECRUITER';
    
    DBMS_OUTPUT.PUT_LINE('"RECRUITER" user created successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/