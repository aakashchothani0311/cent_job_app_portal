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
        PI_GENDER IN CANDIDATES.GENDER%TYPE,
        PI_VETERAN IN CANDIDATES.VETERAN%TYPE,
        PI_DISABILITY IN CANDIDATES.DISABILITY%TYPE
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
        PI_GENDER IN CANDIDATES.GENDER%TYPE,
        PI_VETERAN IN CANDIDATES.VETERAN%TYPE,
        PI_DISABILITY IN CANDIDATES.DISABILITY%TYPE
    ) AS
        V_USER_ID USERS.USER_ID%TYPE;
        V_ADDRESS_ID ADDRESS.ADDRESS_ID%TYPE;
        NULL_FNAME EXCEPTION;
        NULL_LNAME EXCEPTION;
        NULL_EMAIL EXCEPTION;
        NULL_USERNAME EXCEPTION;
        NULL_PASSWORD EXCEPTION;
        NULL_ST1 EXCEPTION;
        NULL_CITY EXCEPTION;
        NULL_STATE EXCEPTION;
        NULL_COUNTRY EXCEPTION;
        INVALID_GENDER EXCEPTION;
        INVALID_AGE EXCEPTION;
        INVALID_VETERAN EXCEPTION;
        INVALID_DISABILITY EXCEPTION;
        DUPLICATE_EMAIL EXCEPTION;
        DUPLICATE_USERNAME EXCEPTION;
        V_COUNT NUMBER;
        
    BEGIN
        IF PI_FNAME IS NULL THEN
            RAISE NULL_FNAME;
        END IF;

        IF PI_LNAME IS NULL THEN
            RAISE NULL_LNAME;
        END IF;

        IF PI_EMAIL IS NULL THEN
            RAISE NULL_EMAIL;
        END IF;

        IF PI_UNAME IS NULL THEN
            RAISE NULL_USERNAME;
        END IF;

        IF PI_PW IS NULL THEN
            RAISE NULL_PASSWORD;
        END IF;
        
        IF PI_ST1 IS NULL THEN
            RAISE NULL_ST1;
        END IF;
        
        IF PI_CITY IS NULL THEN
            RAISE NULL_CITY;
        END IF;
        
        IF PI_STATE IS NULL THEN 
            RAISE NULL_STATE;
        END IF;
        
        IF PI_COUNTRY IS NULL THEN
            RAISE NULL_COUNTRY;
        END IF;
        
        IF PI_GENDER IS NULL OR PI_GENDER NOT IN ('male', 'female') THEN
            RAISE INVALID_GENDER;
        END IF;

        IF PI_AGE IS NULL OR PI_AGE <= 16 THEN
            RAISE INVALID_AGE;
        END IF;
        
        IF PI_VETERAN IS NULL OR PI_VETERAN NOT IN 
        ('do not wish to disclose','not a veteran','I am a protected veteran')
          THEN  RAISE INVALID_VETERAN;
        END IF;
        
        IF PI_DISABILITY IS NULL OR PI_DISABILITY NOT IN
        ('do not wish to disclose','no, i do not have a disability','yes, I have a disability')
            THEN RAISE INVALID_DISABILITY;
        END IF;
        
        --For Uniqueness check of email 
        SELECT COUNT(*)
        INTO V_COUNT
        FROM USERS
        WHERE EMAIL = PI_EMAIL;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_EMAIL;
        END IF;
        
        --For Uniqueness check of username
        SELECT COUNT(*)
        INTO V_COUNT
        FROM USERS
        WHERE USERNAME = PI_UNAME;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_USERNAME;
        END IF;
        
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
    
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate profile created successfully. User ID: ' || V_USER_ID));
    EXCEPTION
        WHEN NULL_FNAME THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: First name cannot be empty.'));
        WHEN NULL_LNAME THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Last name cannot be empty.'));
        WHEN NULL_EMAIL THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Email cannot be empty.'));
        WHEN NULL_USERNAME THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Username cannot be empty.'));
        WHEN NULL_PASSWORD THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Password cannot be empty.'));
        WHEN NULL_ST1 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Street 1 cannot be empty.'));
        WHEN NULL_CITY THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: City cannot be empty.'));
        WHEN NULL_STATE THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: State cannot be empty.'));
        WHEN NULL_COUNTRY THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Country cannot be empty.'));
        WHEN INVALID_GENDER THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Gender must be "male" or "female".'));
        WHEN INVALID_AGE THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Age must be greater than 16.'));
        WHEN INVALID_VETERAN THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: 
            Veteran status must be in "do not wish to disclose" or "not a veteran" or "I am a protected veteran".'));
        WHEN INVALID_DISABILITY THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: 
            Disability status must be in "do not wish to disclose" or "no, i do not have a disability" or "yes, I have a disability"'));
            
        WHEN DUPLICATE_EMAIL THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This Email already exists. Please try a different email')); 
        
        WHEN DUPLICATE_USERNAME THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This username already exists. Please try a different username'));
            
      --For Uniqueness check on email and username 
      /*  WHEN DUP_VAL_ON_INDEX THEN
            IF SQLERRM LIKE '%USERS_EMAIL%' THEN
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This Email already exists. Please try a different Email.'));
            ELSIF SQLERRM LIKE '%USERS_USERNAME%' THEN
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This Username already exists. Please try a different Username.'));
            ELSE
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Duplicate value encountered. ' || SQLERRM));
            END IF;    */
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: ' || SQLERRM));
            ROLLBACK;
    END CREATE_CANDIDATE_PROFILE;

-- PROCEDURE FOR Deactivating Candidate account
    PROCEDURE DEACTIVATE_CANDIDATE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) AS
        V_CANDIDATE_ID CANDIDATES.CANDIDATE_ID%TYPE;
        NULL_CANDIDATE_ID EXCEPTION;
    BEGIN
        IF PI_CANDIDATE_ID IS NULL THEN
            RAISE NULL_CANDIDATE_ID;
        END IF;
        
        UPDATE USERS
        SET IS_ACTIVE = 0
        WHERE USER_ID = (
            SELECT USER_ID
            FROM CANDIDATES
            WHERE CANDIDATE_ID = PI_CANDIDATE_ID
        );
        
        IF SQL%ROWCOUNT = 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate not found.'));
        ELSE
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate account deactivated successfully.User ID: ' || V_CANDIDATE_ID));
        END IF;
        
        COMMIT;
    EXCEPTION
        WHEN NULL_CANDIDATE_ID THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error deactivating candidate account: Candidate ID cannot be empty.'));
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error deactivating candidate account: ' || SQLERRM));
            ROLLBACK;
    END DEACTIVATE_CANDIDATE;

-- FUNCTION FOR Checking if a Candidate is active in our database
    FUNCTION IS_CANDIDATE_ACTIVE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) RETURN NUMBER AS
        V_IS_ACTIVE USERS.IS_ACTIVE%TYPE;
        NULL_CANDIDATE_ID EXCEPTION;
        
    BEGIN
        IF PI_CANDIDATE_ID IS NULL THEN 
            RAISE NULL_CANDIDATE_ID;
        END IF;
        
        SELECT U.IS_ACTIVE
        INTO V_IS_ACTIVE
        FROM USERS U
        JOIN CANDIDATES C 
        ON U.USER_ID = C.USER_ID
        WHERE C.CANDIDATE_ID = PI_CANDIDATE_ID;
        RETURN V_IS_ACTIVE;
        
    EXCEPTION
        WHEN NULL_CANDIDATE_ID THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error in checking candidate account status: Candidate ID cannot be empty.'));
            RETURN 0;
            
        WHEN NO_DATA_FOUND THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error in checking candidate account status: Candidate not found.'));
            RETURN 0;
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error in checking candidate account status:: ' || SQLERRM));
            RETURN 0;
    END IS_CANDIDATE_ACTIVE;
END PKG_CANDIDATE_USER_MANAGEMENT;
/


-- CREATE SYNONYMS 
CREATE OR REPLACE SYNONYM PKG_CANDIDATE_USER_MGMT
    FOR ADMIN_SUPER_USER.PKG_CANDIDATE_USER_MANAGEMENT;
    
CREATE OR REPLACE SYNONYM CANDIDATE_PROFILE_CREATE 
    FOR ADMIN_SUPER_USER.CREATE_CANDIDATE_PROFILE;
    
CREATE OR REPLACE SYNONYM CANDIDATE_PROFILE_DEACTIVATE 
    FOR ADMIN_SUPER_USER.DEACTIVATE_CANDIDATE;
    
CREATE OR REPLACE SYNONYM CANDIDATE_ACC_STATUS 
    FOR ADMIN_SUPER_USER.IS_CANDIDATE_ACTIVE;