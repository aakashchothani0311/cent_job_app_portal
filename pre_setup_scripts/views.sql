--VIEWS/REPORT

--VIEW 1: JOBS-APPLIED HISTORY
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_VIEWS
    WHERE VIEW_NAME = 'JOBS_APPLIED_HISTORY';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP VIEW JOBS_APPLIED_HISTORY';
        DBMS_OUTPUT.PUT_LINE('Materialized View "JOBS_APPLIED_HISTORY" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE VIEW JOBS_APPLIED_HISTORY AS 
    SELECT
        U.FIRSTNAME || '' '' || U.LASTNAME AS CANDIDATE_NAME,
        COM.NAME COMPANY_NAME,
        JR.REQ_ID,
        JR.JOB_TITLE,
        TO_CHAR(CA.DATE_APPLIED, ''MM/DD/YYYY'') DATE_APPLIED,
        CA.STATUS
    FROM CANDIDATE_APPLICATION CA
    JOIN CANDIDATES C ON CA.CANDIDATE_ID = C.CANDIDATE_ID
    JOIN JOB_REQUISITION JR ON CA.REQ_ID = JR.REQ_ID
    JOIN COMPANIES COM ON JR.COMPANY_ID = COM.COMPANY_ID
    JOIN USERS U ON C.USER_ID = U.USER_ID';
        
    DBMS_OUTPUT.PUT_LINE('View "JOBS_APPLIED_HISTORY" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


--VIEW 2: JOBS-CREATED HISTORY
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_VIEWS
    WHERE VIEW_NAME = 'JOBS_CREATED_HISTORY';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP VIEW JOBS_CREATED_HISTORY';
        DBMS_OUTPUT.PUT_LINE('View "JOBS_CREATED_HISTORY" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE VIEW JOBS_CREATED_HISTORY AS
    SELECT
        JR.RECRUITER_ID,
        U.FIRSTNAME || '' '' || U.LASTNAME AS RECRUITER_NAME,
        JR.REQ_ID,
        JR.JOB_TITLE,
        JR.JOB_DESCRIPTION,
        TO_CHAR(JR.DATE_POSTED, ''MM/DD/YYYY'') DATE_POSTED,
        JR.STATUS
    FROM JOB_REQUISITION JR
    JOIN RECRUITERS R ON JR.RECRUITER_ID = R.RECRUITER_ID
    JOIN COMPANIES COM ON JR.COMPANY_ID = COM.COMPANY_ID
    JOIN USERS U ON R.USER_ID = U.USER_ID';
        
    DBMS_OUTPUT.PUT_LINE('View "JOBS_CREATED_HISTORY" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


--VIEW 3: CANDIDATES-JOBS APPLIED
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_VIEWS
    WHERE VIEW_NAME = 'CANDIDATES_JOBS_APPLIED';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP VIEW CANDIDATES_JOBS_APPLIED';
        DBMS_OUTPUT.PUT_LINE('View "CANDIDATES_JOBS_APPLIED" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE VIEW CANDIDATES_JOBS_APPLIED AS
    SELECT
        JR.REQ_ID,
        JR.JOB_TITLE,
        CA.CANDIDATE_ID,
        U.FIRSTNAME || '' '' || U.LASTNAME AS CANDIDATE_NAME,
        C.PHONE AS PHONE_NUMBER,
        U.EMAIL AS EMAIL,
        CASE WHEN CA.WILLING_TO_RELOCATE = 1 THEN ''Y'' ELSE ''N'' END AS WILLING_TO_RELOCATE,
        CA.STATUS AS APPLICATION_STATUS
    FROM CANDIDATE_APPLICATION CA
    JOIN CANDIDATES C ON CA.CANDIDATE_ID = C.CANDIDATE_ID
    JOIN JOB_REQUISITION JR ON CA.REQ_ID = JR.REQ_ID
    JOIN USERS U ON C.USER_ID = U.USER_ID';
        
    DBMS_OUTPUT.PUT_LINE('View "CANDIDATES_JOBS_APPLIED" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- VIEW 4: JOBS-OPEN
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_VIEWS
    WHERE VIEW_NAME = 'OPEN_JOBS';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP VIEW OPEN_JOBS';
        DBMS_OUTPUT.PUT_LINE('View "OPEN_JOBS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE VIEW OPEN_JOBS AS
    SELECT
        COM.NAME AS COMPANY_NAME,
        JR.REQ_ID,
        JR.JOB_TITLE,
        JR.JOB_DESCRIPTION,
        TO_CHAR(JR.DATE_POSTED, ''MM/DD/YYYY'') JOB_POSTED,
        TO_CHAR(JR.APPLICATION_DEADLINE, ''MM/DD/YYYY'') DEADLINE,
        JR.STATUS AS JOB_STATUS,       
        (CASE WHEN JR.RELOCATION_ALLOWANCE = 1 THEN ''Y'' ELSE ''N'' END) RELOCATION_ALLOWANCE
    FROM JOB_REQUISITION JR
    JOIN COMPANIES COM ON JR.COMPANY_ID = COM.COMPANY_ID
    WHERE JR.STATUS = ''open''';
        
    DBMS_OUTPUT.PUT_LINE('View "OPEN_JOBS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- VIEW 5: CANDIDATE-PROFILE
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_VIEWS
    WHERE VIEW_NAME = 'CANDIDATE_PROFILE';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP VIEW CANDIDATE_PROFILE';
        DBMS_OUTPUT.PUT_LINE('View "CANDIDATE_PROFILE" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE VIEW CANDIDATE_PROFILE AS
    SELECT
        C.CANDIDATE_ID,
        U.FIRSTNAME || '' '' || U.LASTNAME AS CANDIDATE_NAME,
        U.EMAIL,
        C.PHONE,
        LISTAGG(S.SKILL_NAME, '', '') WITHIN GROUP (ORDER BY S.SKILL_NAME) AS SKILLS,
        C.AGE,
        C.GENDER,
        C.VETERAN,
        C.DISABILITY,
        TO_CHAR(C.DATE_OF_JOIN,  ''MM/DD/YYYY'') JOINED_DATE,
        A.STREET1,
        A.STREET2,
        A.CITY,
        A.STATE,
        A.ZIPCODE
    FROM CANDIDATES C
    LEFT JOIN ADDRESS A ON C.ADD_ID = A.ADDRESS_ID
    JOIN USERS U ON C.USER_ID = U.USER_ID
    JOIN CANDIDATE_SKILLS CS ON C.CANDIDATE_ID = CS.CANDIDATE_ID 
    JOIN SKILLS S ON CS.SKILL_ID = S.SKILL_ID
    GROUP BY C.CANDIDATE_ID, U.FIRSTNAME, U.LASTNAME, U.EMAIL, C.PHONE, C.AGE, C.GENDER, C.VETERAN, C.DISABILITY, C.DATE_OF_JOIN, A.STREET1, A.STREET2, A.CITY, A.STATE, A.ZIPCODE';
        
    DBMS_OUTPUT.PUT_LINE('View "CANDIDATE_PROFILE" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/

-- Creating synonyms for all views
CREATE OR REPLACE PUBLIC SYNONYM JOBS_APPLIED_HISTORY_VIEW
FOR ADMIN_SUPER_USER.JOBS_APPLIED_HISTORY;

CREATE OR REPLACE PUBLIC SYNONYM JOBS_CREATED_HISTORY_VIEW
FOR ADMIN_SUPER_USER.JOBS_CREATED_HISTORY;

CREATE OR REPLACE PUBLIC SYNONYM CANDIDATES_JOBS_APPLIED_VIEW
FOR ADMIN_SUPER_USER.CANDIDATES_JOBS_APPLIED;

CREATE OR REPLACE PUBLIC SYNONYM OPEN_JOBS_VIEW
FOR ADMIN_SUPER_USER.OPEN_JOBS;

CREATE OR REPLACE PUBLIC SYNONYM CANDIDATE_PROFILE_VIEW
FOR ADMIN_SUPER_USER.CANDIDATE_PROFILE;
