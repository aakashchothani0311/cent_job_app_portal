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
-- Function for creating user
    FUNCTION CREATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE,
        PI_LNAME IN USERS.LASTNAME%TYPE,
        PI_EMAIL IN USERS.EMAIL%TYPE,
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE
    ) RETURN NUMBER IS  
        V_USER_ID USERS.USER_ID%TYPE DEFAULT -1;
        V_COUNT NUMBER DEFAULT 0;
                
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

        IF PI_PW IS NULL OR LENGTH(TRIM(PI_PW)) < 8  THEN
            RAISE NULL_PASSWORD_EXEC;
        END IF;
        
        -- Check for unique email
        SELECT COUNT(USER_ID)
        INTO V_COUNT
        FROM USERS
        WHERE EMAIL = PI_EMAIL;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_EMAIL_EXEC;
        END IF;
        
        -- Check for unique username
        SELECT COUNT(USER_ID)
        INTO V_COUNT
        FROM USERS
        WHERE USERNAME = PI_UNAME;

        IF V_COUNT > 0 THEN
            RAISE DUPLICATE_USERNAME_EXEC;
        END IF;
        
         -- Insert into USERS table
        INSERT INTO USERS 
            (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD)
        VALUES 
            (LOWER(PI_FNAME), LOWER(PI_LNAME), PI_EMAIL, PI_UNAME, PI_PW)
        RETURNING USER_ID INTO V_USER_ID;
        
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('User Account created successfully with User ID: ' || V_USER_ID));
        
        RETURN V_USER_ID;
        
    EXCEPTION
        WHEN NULL_FNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: First name cannot be empty.'));
            RETURN V_USER_ID;
        
        WHEN NULL_LNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Last name cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NULL_EMAIL_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Email cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NULL_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Username cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NULL_PASSWORD_EXEC THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: Password cannot be empty or less than 8 characters.'));
            RETURN V_USER_ID;
                   
        WHEN DUPLICATE_EMAIL_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This Email already exists. Please try a different email.'));
            RETURN V_USER_ID;
            
        WHEN DUPLICATE_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating candidate user profile: This username already exists. Please try a different username.'));
            RETURN V_USER_ID;
            
        WHEN OTHERS THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating User Account: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
            RETURN V_USER_ID;

    END CREATE_USER;
    
-- Function FOR Updating User    
    FUNCTION UPDATE_USER(
        PI_FNAME IN USERS.FIRSTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_LNAME IN USERS.LASTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
        PI_UNAME IN USERS.USERNAME%TYPE,
        PI_PW IN USERS.PASSWORD%TYPE DEFAULT 'DEFAULT_FLAG'
    ) RETURN NUMBER IS
        V_USER_ID USERS.USER_ID%TYPE DEFAULT -1;
        V_COUNT NUMBER DEFAULT 0;
        
        NULL_USERNAME_EXEC EXCEPTION;
        NO_UPDATED_FIELDS_EXEC EXCEPTION;
        NULL_FNAME_EXEC EXCEPTION;
        NULL_LNAME_EXEC EXCEPTION;
        NULL_PASSWORD_EXEC EXCEPTION;
        USER_NOT_FOUND_EXEC EXCEPTION;
    BEGIN
        -- Validate that username is not null or empty
        IF PI_UNAME IS NULL OR TRIM(PI_UNAME) IS NULL THEN
            RAISE NULL_USERNAME_EXEC;
        END IF;
        
        IF PI_FNAME = 'DEFAULT_FLAG' AND PI_LNAME = 'DEFAULT_FLAG' AND PI_PW = 'DEFAULT_FLAG' THEN
            RAISE NO_UPDATED_FIELDS_EXEC;
        END IF;
    
        -- Check if the user exists
        SELECT COUNT(USER_ID)
        INTO V_COUNT
        FROM USERS
        WHERE LOWER(USERNAME) = LOWER(PI_UNAME);
        
        IF V_COUNT = 0 THEN
            RAISE USER_NOT_FOUND_EXEC;
        END IF;
        
        IF PI_FNAME IS NULL OR TRIM(PI_FNAME) IS NULL THEN
            RAISE NULL_FNAME_EXEC;
        END IF;
        
        IF PI_LNAME IS NULL OR TRIM(PI_LNAME) IS NULL THEN
            RAISE NULL_LNAME_EXEC;
        END IF;
        
        IF PI_PW IS NULL OR TRIM(PI_PW) IS NULL OR LENGTH(TRIM(PI_PW)) < 8 THEN
            RAISE NULL_PASSWORD_EXEC;
        END IF;
        
        -- Update the user
        UPDATE USERS
        SET
            FIRSTNAME = CASE WHEN PI_FNAME != 'DEFAULT_FLAG' THEN LOWER(PI_FNAME) ELSE FIRSTNAME END,
            LASTNAME = CASE WHEN PI_LNAME != 'DEFAULT_FLAG' THEN LOWER(PI_LNAME) ELSE LASTNAME END,
            PASSWORD = CASE WHEN PI_PW != 'DEFAULT_FLAG' THEN PI_PW ELSE PASSWORD END
        WHERE LOWER(USERNAME) = LOWER(PI_UNAME)
        RETURNING USER_ID INTO V_USER_ID;
        
        IF SQL%ROWCOUNT > 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('User Account updated successfully for User: ' || PI_UNAME));
            RETURN V_USER_ID;
        END IF;
    
    EXCEPTION
        WHEN NULL_USERNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating User Account: Username cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NO_UPDATED_FIELDS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Warning: No value found to update.'));
            RETURN V_USER_ID;
            
        WHEN NULL_FNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating FIRSTNAME: First name cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NULL_LNAME_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating LASTNAME: Last name cannot be empty.'));
            RETURN V_USER_ID;
            
        WHEN NULL_PASSWORD_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating PASSWORD: Password cannot be empty or less than 8 characters.'));
            RETURN V_USER_ID;
            
        WHEN USER_NOT_FOUND_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating USERNAME: "' || PI_UNAME || '" does not exist.'));
            RETURN V_USER_ID;
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating User Account: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
            RETURN V_USER_ID;
            
    END UPDATE_USER;
END PKG_USER_MANAGEMENT;
/


-- Create Synonym for the package        
CREATE OR REPLACE SYNONYM USER_MGMT
FOR ADMIN_SUPER_USER.PKG_USER_MANAGEMENT;
