CREATE OR REPLACE PACKAGE PKG_USER_MANAGEMENT AS
    FUNCTION CREATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE,
        PI_LNAME IN USERS.LASTNAME%TYPE,
        PI_EMAIL IN USERS.EMAIL%TYPE,
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE
    ) RETURN NUMBER;
    
    FUNCTION UPDATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_LNAME IN USERS.LASTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE DEFAULT 'DEFAULT_FLAG'
    ) RETURN NUMBER;
    
END PKG_USER_MANAGEMENT;
/

CREATE OR REPLACE PACKAGE BODY PKG_USER_MANAGEMENT AS 
-- PROCEDURE FOR Creating User
    FUNCTION CREATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE,
        PI_LNAME IN USERS.LASTNAME%TYPE,
        PI_EMAIL IN USERS.EMAIL%TYPE,
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE
    ) RETURN NUMBER IS  
        V_USER_ID USERS.USER_ID%TYPE;
        V_COUNT NUMBER;
                
        NULL_FNAME_EXEC EXCEPTION;
        NULL_LNAME_EXEC EXCEPTION;
        NULL_EMAIL_EXEC EXCEPTION;
        NULL_USERNAME_EXEC EXCEPTION;
        NULL_PASSWORD_EXEC EXCEPTION;
        DUPLICATE_EMAIL_EXEC EXCEPTION;
        DUPLICATE_USERNAME_EXEC EXCEPTION;
        
    BEGIN 
        IF PI_FNAME IS NULL OR TRIM(PI_FNAME) IS NULL THEN
            RAISE NULL_FNAME_EXEC;
        END IF;

        IF PI_LNAME IS NULL OR TRIM(PI_LNAME) IS NULL THEN
            RAISE NULL_LNAME_EXEC;
        END IF;

        IF PI_EMAIL IS NULL OR TRIM(PI_EMAIL) IS NULL THEN
            RAISE NULL_EMAIL_EXEC;
        END IF;

        IF PI_UNAME IS NULL OR TRIM(PI_UNAME) IS NULL THEN
            RAISE NULL_USERNAME_EXEC;
        END IF;

        IF PI_PW IS NULL OR TRIM(PI_PW) IS NULL THEN
            RAISE NULL_PASSWORD_EXEC;
        END IF;
        
        
        --For Uniqueness check of email 
        SELECT COUNT(USER_ID)
        INTO V_COUNT
        FROM USERS
        WHERE EMAIL = PI_EMAIL;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_EMAIL_EXEC;
        END IF;
        
        --For Uniqueness check of username
        SELECT COUNT(USER_ID)
        INTO V_COUNT
        FROM USERS
        WHERE USERNAME = PI_UNAME;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_USERNAME_EXEC;
        END IF;
        
         -- Insert into USERS table
        INSERT INTO USERS (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD)
        VALUES (LOWER(PI_FNAME), LOWER(PI_LNAME), PI_EMAIL, PI_UNAME, PI_PW)
        RETURNING USER_ID INTO V_USER_ID;
        
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('User Account created successfully with User ID: ' || V_USER_ID));
        RETURN V_USER_ID;
        
    EXCEPTION
        WHEN NULL_FNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: First name cannot be empty.'));
            RETURN -1;
        
        WHEN NULL_LNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Last name cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_EMAIL_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Email cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Username cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_PASSWORD_EXEC THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Password cannot be empty.'));
            RETURN -1;
                   
        WHEN DUPLICATE_EMAIL_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This Email already exists. Please try a different email'));
            RETURN -1;
            
        WHEN DUPLICATE_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This username already exists. Please try a different username'));
            RETURN -1;
            
        WHEN OTHERS THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating User Account: ' || SQLERRM));
            RETURN -1;
        ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error Transactions if any are rolled back'));
            
    END CREATE_USER;
    
-- PROCEDURE FOR Updating User    
    FUNCTION UPDATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_LNAME IN USERS.LASTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE DEFAULT 'DEFAULT_FLAG'
    ) RETURN NUMBER IS  
        V_COUNT NUMBER;
        V_USER_ID USERS.USER_ID%TYPE;
        
        NULL_USERNAME_EXEC EXCEPTION;
        NULL_FNAME_EXEC EXCEPTION;
        NULL_LNAME_EXEC EXCEPTION;
        NULL_PASSWORD_EXEC EXCEPTION;
        USER_NOT_FOUND_EXEC EXCEPTION;
        
    BEGIN
        -- Validate that username is not null or empty
        IF PI_UNAME IS NULL OR TRIM(PI_UNAME) IS NULL THEN
            RAISE NULL_USERNAME_EXEC;
        END IF;
    
        -- Check if the user exists
        SELECT COUNT(USER_ID) INTO V_USER_ID
        FROM USERS
        WHERE LOWER(USERNAME) = LOWER(PI_UNAME);
        
        IF V_USER_ID = 0 THEN
            RAISE USER_NOT_FOUND_EXEC;
        END IF;
        
        IF PI_FNAME IS NULL OR TRIM(PI_FNAME) IS NULL THEN
            RAISE NULL_FNAME_EXEC;
        END IF;
        
        IF PI_LNAME IS NULL OR TRIM(PI_LNAME) IS NULL THEN
            RAISE NULL_LNAME_EXEC;
        END IF;
        
        IF PI_PW IS NULL OR TRIM(PI_PW) IS NULL THEN
            RAISE NULL_PASSWORD_EXEC;
        END IF;
        
        -- Update the user
        UPDATE USERS
        SET
            FIRSTNAME = CASE WHEN PI_FNAME != 'DEFAULT_FLAG' THEN LOWER(PI_FNAME) ELSE FIRSTNAME END,
            LASTNAME = CASE WHEN PI_LNAME != 'DEFAULT_FLAG' THEN LOWER(PI_LNAME) ELSE LASTNAME END,
            PASSWORD = CASE WHEN PI_PW != 'DEFAULT_FLAG' THEN PI_PW ELSE PASSWORD END
        WHERE LOWER(USERNAME) = LOWER(PI_UNAME);
        
        IF SQL%ROWCOUNT > 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('User Account updated successfully for User: ' || PI_UNAME));
            COMMIT;
            RETURN V_USER_ID;
        END IF;
    
    EXCEPTION
        WHEN NULL_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating User Account: Username cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_FNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating FIRSTNAME: First name cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_LNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating LASTNAME: Last name cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_PASSWORD_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating PASSWORD: Password cannot be empty.'));
            RETURN -1;
            
        WHEN USER_NOT_FOUND_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating USERNAME: "' || PI_UNAME || '" DOES NOT EXIST.'));
            RETURN -1;
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating User Account: ' || SQLERRM));
            RETURN -1;
        ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error Transactions if any are rolled back.'));
            
    END UPDATE_USER;


END PKG_USER_MANAGEMENT;
/
        
CREATE OR REPLACE SYNONYM USER_MGMT
FOR ADMIN_SUPER_USER.PKG_USER_MANAGEMENT;