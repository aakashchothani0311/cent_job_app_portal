-- Package Creation
CREATE OR REPLACE PACKAGE PKG_CANDIDATE_USER_MANAGEMENT AS
    PROCEDURE CREATE_CANDIDATE_PROFILE(
        PI_FNAME IN USERS.FIRSTNAME%TYPE,
        PI_LNAME IN USERS.LASTNAME%TYPE,
        PI_EMAIL IN USERS.EMAIL%TYPE,
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE,
        PI_ST1 IN ADDRESS.STREET1%TYPE,
        PI_ST2 IN ADDRESS.STREET2%TYPE,
        PI_CITY IN ADDRESS.CITY%TYPE,
        PI_STATE IN ADDRESS.STATE%TYPE,
        PI_ZIP IN ADDRESS.ZIPCODE%TYPE,
        PI_COUNTRY IN ADDRESS.COUNTRY%TYPE,
        PI_PHONE IN CANDIDATES.PHONE%TYPE,
        PI_AGE IN CANDIDATES.AGE%TYPE,
        PI_GENDER IN CANDIDATES.GENDER%TYPE
    );
    PROCEDURE DEACTIVATE_CANDIDATE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    );
    FUNCTION IS_CANDIDATE_ACTIVE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) RETURN NUMBER;
END PKG_CANDIDATE_USER_MANAGEMENT;
/


-- Package Body 
CREATE OR REPLACE PACKAGE BODY PKG_CANDIDATE_USER_MANAGEMENT AS 
-- PROCEDURE FOR Creating Candidate User
    PROCEDURE CREATE_CANDIDATE_PROFILE(
        PI_FNAME IN USERS.FIRSTNAME%TYPE,
        PI_LNAME IN USERS.LASTNAME%TYPE,
        PI_EMAIL IN USERS.EMAIL%TYPE,
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE,
        PI_ST1 IN ADDRESS.STREET1%TYPE,
        PI_ST2 IN ADDRESS.STREET2%TYPE,
        PI_CITY IN ADDRESS.CITY%TYPE,
        PI_STATE IN ADDRESS.STATE%TYPE,
        PI_ZIP IN ADDRESS.ZIPCODE%TYPE,
        PI_COUNTRY IN ADDRESS.COUNTRY%TYPE,
        PI_PHONE IN CANDIDATES.PHONE%TYPE,
        PI_AGE IN CANDIDATES.AGE%TYPE,
        PI_GENDER IN CANDIDATES.GENDER%TYPE
    ) AS
        V_USER_ID USERS.USER_ID%TYPE;
        V_ADDRESS_ID ADDRESS.ADDRESS_ID%TYPE;
    BEGIN
        -- Insert into USERS table
        INSERT INTO USERS (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD)
        VALUES (PI_FNAME, PI_LNAME, PI_EMAIL, PI_UNAME, PI_PW)
        RETURNING USER_ID INTO V_USER_ID;
        
        -- Insert into ADDRESS table
        INSERT INTO ADDRESS (STREET1, STREET2, CITY, STATE, ZIPCODE, COUNTRY)
        VALUES (PI_ST1, PI_ST2, PI_CITY, PI_STATE, PI_ZIP, PI_COUNTRY)
        RETURNING ADDRESS_ID INTO V_ADDRESS_ID;
        
        -- Insert into CANDIDATES table
        INSERT INTO CANDIDATES (USER_ID, ADD_ID, PHONE, AGE, GENDER)
        VALUES (V_USER_ID, V_ADDRESS_ID, PI_PHONE, PI_AGE, PI_GENDER);
    
        DBMS_OUTPUT.PUT_LINE('Candidate profile created successfully. User ID: ' || V_USER_ID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating candidate profile: ' || SQLERRM);
            ROLLBACK;
    END CREATE_CANDIDATE_PROFILE;

-- PROCEDURE FOR Deactivating Candidate account
    PROCEDURE DEACTIVATE_CANDIDATE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) AS
        V_CANDIDATE_ID CANDIDATES.CANDIDATE_ID%TYPE;
    BEGIN
        UPDATE USERS
        SET IS_ACTIVE = 0
        WHERE USER_ID = (
            SELECT USER_ID
            FROM CANDIDATES
            WHERE CANDIDATE_ID = PI_CANDIDATE_ID
        );
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Candidate not found.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Candidate account deactivated successfully.User ID: ' || V_CANDIDATE_ID);
        END IF;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error deactivating candidate: ' || SQLERRM);
            ROLLBACK;
    END DEACTIVATE_CANDIDATE;

-- FUNCTION FOR Checking if a Candidate is active in our database
    FUNCTION IS_CANDIDATE_ACTIVE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) RETURN NUMBER AS
        V_IS_ACTIVE USERS.IS_ACTIVE%TYPE;
    BEGIN
        SELECT U.IS_ACTIVE
        INTO V_IS_ACTIVE
        FROM USERS U
        JOIN CANDIDATES C ON U.USER_ID = C.USER_ID
        WHERE C.CANDIDATE_ID = PI_CANDIDATE_ID;
        RETURN V_IS_ACTIVE;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Candidate not found.');
            RETURN 0;
            
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error checking candidate status: ' || SQLERRM);
            RETURN 0;
    END IS_CANDIDATE_ACTIVE;
END PKG_CANDIDATE_USER_MANAGEMENT;
/


-- CREATE SYNONYMS 
CREATE OR REPLACE SYNONYM PKG_CANDIDATE_USER_MGMT
    FOR ADMIN_SUPER_USER.PKG_CANDIDATE_USER_MANAGEMENT;
    
CREATE OR REPLACE SYNONYM CREATE_CANDIDATE_PROFILE 
    FOR ADMIN_SUPER_USER.CREATE_CANDIDATE_PROFILE;
    
CREATE OR REPLACE SYNONYM DEACTIVATE_CANDIDATE 
    FOR ADMIN_SUPER_USER.DEACTIVATE_CANDIDATE;
    
CREATE OR REPLACE SYNONYM IS_CANDIDATE_ACTIVE 
    FOR ADMIN_SUPER_USER.IS_CANDIDATE_ACTIVE;