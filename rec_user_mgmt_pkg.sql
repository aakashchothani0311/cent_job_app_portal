CREATE OR REPLACE PROCEDURE REC_USER_CREATION (
    PI_FNAME USERS.FIRSTNAME%TYPE,
    PI_LNAME USERS.LASTNAME%TYPE,
    PI_USERNAME USERS.USERNAME%TYPE,
    PI_EMAIL USERS.EMAIL%TYPE,
    PI_PASSWORD USERS.PASSWORD%TYPE,
    PI_COMPANY_NAME COMPANIES.NAME%TYPE
) AS
    COMPANY_ID NUMBER DEFAULT -1;
    V_COMPANY_DOES_NOT_EXIST EXCEPTION;
    V_NEW_USER_ID USERS.USER_ID%TYPE;
BEGIN
    SELECT COMPANY_ID INTO COMPANY_ID
    FROM COMPANIES
    WHERE LOWER(NAME) = LOWER(PI_COMPANY_NAME);
    
--    IF COMPANY_ID = -1 THEN 
--        RAISE V_COMPANY_DOES_NOT_EXIST;
--    END IF;
    
    INSERT INTO USERS(FIRSTNAME, LASTNAME, USERNAME,EMAIL, PASSWORD)
    VALUES (PI_FNAME, PI_LNAME, PI_USERNAME, PI_EMAIL, PI_PASSWORD)
    RETURNING USER_ID INTO V_NEW_USER_ID;
    
    INSERT INTO RECRUITERS (USER_ID, COMPANY_ID)
    VALUES (V_NEW_USER_ID, COMPANY_ID);
    
    DBMS_OUTPUT.PUT_LINE('USER CREATED SUCCESSFULLY. USER_ID:' || V_NEW_USER_ID);
    
EXCEPTION
    -- Handle exceptions
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: COMPANY DOES NOT EXIST');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        
END REC_USER_CREATION;
/