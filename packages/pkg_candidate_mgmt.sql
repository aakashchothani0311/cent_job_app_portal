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
    
    PROCEDURE UPDATE_CANDIDATE_PROFILE(
        PI_CANID IN VARCHAR2,
        PI_PHONE IN CANDIDATES.PHONE%TYPE DEFAULT NULL,
        PI_AGE IN CANDIDATES.AGE%TYPE DEFAULT NULL,
        PI_GENDER IN CANDIDATES.GENDER%TYPE DEFAULT NULL,
        PI_VETERAN IN CANDIDATES.VETERAN%TYPE DEFAULT NULL,
        PI_DISABILITY IN CANDIDATES.DISABILITY%TYPE DEFAULT NULL
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
        V_COUNT NUMBER := 0;
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
        
        IF PI_VETERAN IS NULL OR TRIM(PI_VETERAN) IS NULL OR PI_VETERAN NOT IN ('do not wish to disclose', 'not a veteran', 'I am a protected veteran')
          THEN  RAISE INVALID_VETERAN_EXEC;
        END IF;
        
        IF PI_DISABILITY IS NULL OR TRIM(PI_DISABILITY) IS NULL OR PI_DISABILITY NOT IN ('do not wish to disclose', 'no, i do not have a disability', 'yes, I have a disability')
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

   -- PROCEDURE FOR UPDATING CANDIDATE PROFILE
    PROCEDURE UPDATE_CANDIDATE_PROFILE(
        PI_CANID IN VARCHAR2,
        PI_PHONE IN CANDIDATES.PHONE%TYPE DEFAULT NULL,
        PI_AGE IN CANDIDATES.AGE%TYPE DEFAULT NULL,
        PI_GENDER IN CANDIDATES.GENDER%TYPE DEFAULT NULL,
        PI_VETERAN IN CANDIDATES.VETERAN%TYPE DEFAULT NULL,
        PI_DISABILITY IN CANDIDATES.DISABILITY%TYPE DEFAULT NULL
    ) AS
        V_COUNT NUMBER;
        
        INVALID_GENDER_EXEC EXCEPTION;
        INVALID_AGE_EXEC EXCEPTION;
        INVALID_VETERAN_EXEC EXCEPTION;
        INVALID_DISABILITY_EXEC EXCEPTION;
        INVALID_FORMAT_EXEC EXCEPTION;
    BEGIN
        -- Check if Candidate ID exists
        SELECT COUNT(CANDIDATE_ID)
        INTO V_COUNT
        FROM CANDIDATES
        WHERE CANDIDATE_ID = PI_CANID;
    
        IF V_COUNT = 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: Candidate ID ' || PI_CANID || ' does not exist.'));
            RETURN;
        END IF;
    
        IF NOT REGEXP_LIKE(PI_CANID, '^[0-9]+$') THEN
            RAISE INVALID_FORMAT_EXEC;
        END IF;
        
        -- Validate inputs
        IF PI_GENDER IS NOT NULL AND PI_GENDER NOT IN ('male', 'female') THEN
            RAISE INVALID_GENDER_EXEC;
        END IF;
    
        IF PI_AGE IS NOT NULL AND PI_AGE <= 16 THEN
            RAISE INVALID_AGE_EXEC;
        END IF;
    
        IF PI_VETERAN IS NOT NULL AND TRIM(PI_VETERAN) NOT IN ('do not wish to disclose','not a veteran','I am a protected veteran') THEN
            RAISE INVALID_VETERAN_EXEC;
        END IF;
    
        IF PI_DISABILITY IS NOT NULL AND TRIM(PI_DISABILITY) NOT IN ('do not wish to disclose','no, i do not have a disability','yes, I have a disability') THEN
            RAISE INVALID_DISABILITY_EXEC;
        END IF;
    
        -- Update CANDIDATES table
        UPDATE CANDIDATES
        SET
            PHONE = NVL(PI_PHONE, PHONE),
            AGE = NVL(PI_AGE, AGE),
            GENDER = NVL(PI_GENDER, GENDER),
            VETERAN = NVL(PI_VETERAN, VETERAN),
            DISABILITY = NVL(PI_DISABILITY, DISABILITY)
        WHERE CANDIDATE_ID = PI_CANID;
    
        -- Output the result
        IF SQL%ROWCOUNT > 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate Profile "' || PI_CANID || '" updated successfully.'));
            COMMIT;
        ELSE
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('No changes were made to the Candidate Profile.'));
        END IF;
    
    EXCEPTION
        WHEN INVALID_FORMAT_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: Invalid format.'));
        
        WHEN INVALID_GENDER_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: Gender must be "male" or "female".'));
            
        WHEN INVALID_AGE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: Age must be greater than 16.'));
            
        WHEN INVALID_VETERAN_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: Invalid veteran status.'));
            
        WHEN INVALID_DISABILITY_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: Invalid disability status.'));
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating candidate profile: ' || SQLERRM));
            ROLLBACK;
            
    END UPDATE_CANDIDATE_PROFILE;
            
    -- PROCEDURE FOR Deactivating Candidate account
    PROCEDURE DEACTIVATE_CANDIDATE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) AS
        V_CANDIDATE_ID CANDIDATES.CANDIDATE_ID%TYPE;
        V_USER USERS%ROWTYPE;
        
        NULL_CANDIDATE_ID EXCEPTION;
    BEGIN
        IF PI_CANDIDATE_ID IS NULL THEN
            RAISE NULL_CANDIDATE_ID;
        END IF;
        
        BEGIN
            SELECT U.USER_ID, IS_ACTIVE
            INTO V_USER.USER_ID, V_USER.IS_ACTIVE
            FROM USERS U
            JOIN CANDIDATES C ON U.USER_ID = C.USER_ID
            WHERE C.CANDIDATE_ID = PI_CANDIDATE_ID;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate not found.'));
        END;
        
        IF V_USER.IS_ACTIVE = 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate is already inactive'));
        ELSE
            UPDATE USERS
            SET IS_ACTIVE = 0
            WHERE USER_ID = V_USER.USER_ID;
        END IF;
        
        IF SQL%ROWCOUNT = 1 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate account deactivated successfully. Candidate ID: ' || PI_CANDIDATE_ID));
        END IF;

    EXCEPTION
        WHEN NULL_CANDIDATE_ID THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error deactivating candidate account: Candidate ID cannot be empty.'));
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error deactivating candidate account: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
            
    END DEACTIVATE_CANDIDATE;

    -- FUNCTION FOR Checking if a Candidate is active in our database
    FUNCTION IS_CANDIDATE_ACTIVE(
        PI_CANDIDATE_ID IN CANDIDATES.CANDIDATE_ID%TYPE
    ) RETURN NUMBER AS
        V_IS_ACTIVE USERS.IS_ACTIVE%TYPE DEFAULT -1;
        
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
            RETURN V_IS_ACTIVE;
            
        WHEN NO_DATA_FOUND THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error in checking candidate account status: Candidate not found.'));
            RETURN V_IS_ACTIVE;
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error in checking candidate account status:: ' || SQLERRM));
            RETURN V_IS_ACTIVE;
            
    END IS_CANDIDATE_ACTIVE; 
END PKG_CANDIDATE_MANAGEMENT;
/


-- Create Synonym for the package
CREATE OR REPLACE SYNONYM CAN_MGMT
FOR ADMIN_SUPER_USER.PKG_CANDIDATE_MANAGEMENT;
