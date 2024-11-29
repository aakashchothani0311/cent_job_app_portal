-- Package Creation
CREATE OR REPLACE PACKAGE PKG_CANDIDATE_MANAGEMENT AS
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
END PKG_CANDIDATE_MANAGEMENT;
/

-- Package Body 
CREATE OR REPLACE PACKAGE BODY PKG_CANDIDATE_MANAGEMENT AS 
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
        V_COUNT NUMBER;
        V_USER_ID NUMBER := -1;
        V_ADDRESS_ID NUMBER := -1;
        
        INVALID_GENDER_EXEC EXCEPTION;
        INVALID_AGE_EXEC EXCEPTION;
        INVALID_VETERAN_EXEC EXCEPTION;
        INVALID_DISABILITY_EXEC EXCEPTION;
        
    BEGIN       
        IF PI_GENDER IS NULL OR PI_GENDER NOT IN ('male', 'female') THEN
            RAISE INVALID_GENDER_EXEC;
        END IF;

        IF PI_AGE IS NULL OR PI_AGE <= 16 THEN
            RAISE INVALID_AGE_EXEC;
        END IF;
        
        IF PI_VETERAN IS NULL OR TRIM(PI_VETERAN) IS NULL OR PI_VETERAN NOT IN 
        ('do not wish to disclose','not a veteran','I am a protected veteran')
          THEN  RAISE INVALID_VETERAN_EXEC;
        END IF;
        
        IF PI_DISABILITY IS NULL OR TRIM(PI_DISABILITY) IS NULL OR PI_DISABILITY NOT IN
        ('do not wish to disclose','no, i do not have a disability','yes, I have a disability')
            THEN RAISE INVALID_DISABILITY_EXEC;
        END IF;
            
        -- Insert into USERS table
        V_USER_ID := USER_MGMT.CREATE_USER(PI_FNAME, PI_LNAME, PI_EMAIL, PI_UNAME, PI_PW);
          
        IF V_USER_ID != -1 THEN
            -- Insert into ADDRESS table
            V_ADDRESS_ID := ADD_MGMT.CREATE_ADDRESS(PI_ST1, PI_ST2, PI_CITY, PI_STATE, PI_ZIP, PI_COUNTRY);
            IF V_ADDRESS_ID != -1 THEN
                -- Insert into CANDIDATES table
                INSERT INTO CANDIDATES (USER_ID, ADD_ID, PHONE, AGE, GENDER)
                VALUES (V_USER_ID, V_ADDRESS_ID, PI_PHONE, PI_AGE, PI_GENDER);
                
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate profile created successfully. User ID: ' || V_USER_ID));
            ELSE
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error Transactions are rolled back'));
                ROLLBACK;
            END IF;
        END IF;
       
    EXCEPTION     
        WHEN INVALID_GENDER_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Gender must be "male" or "female".'));
            
        WHEN INVALID_AGE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Age must be greater than 16.'));
            
        WHEN INVALID_VETERAN_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: 
            Veteran status must be in "do not wish to disclose" or "not a veteran" or "I am a protected veteran".'));
            
        WHEN INVALID_DISABILITY_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: 
            Disability status must be in "do not wish to disclose" or "no, i do not have a disability" or "yes, I have a disability"'));   
                      
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: ' || SQLERRM));
        ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error Transactions if any are rolled back'));
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
END PKG_CANDIDATE_MANAGEMENT;
/

CREATE OR REPLACE SYNONYM CAN_MGMT
FOR ADMIN_SUPER_USER.PKG_CANDIDATE_MANAGEMENT;