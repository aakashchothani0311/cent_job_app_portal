CREATE OR REPLACE PROCEDURE REC_USER_CREATION (
    PI_FNAME USERS.FIRSTNAME%TYPE DEFAULT NULL,
    PI_LNAME USERS.LASTNAME%TYPE DEFAULT NULL,
    PI_USERNAME USERS.USERNAME%TYPE,
    PI_EMAIL USERS.EMAIL%TYPE,
    PI_PASSWORD USERS.PASSWORD%TYPE,
    PI_COMPANY_ID COMPANIES.COMPANY_ID%TYPE 
) AS
    V_COMPANY_ID NUMBER;
    V_NEW_USER_ID USERS.USER_ID%TYPE;
    --V_COMPANY_DOES_NOT_EXIST EXCEPTION;
    NULL_FNAME_EXEC EXCEPTION;
    NULL_LNAME_EXEC EXCEPTION;
    NULL_USERNAME_EXEC EXCEPTION;
    NULL_EMAIL_EXEC EXCEPTION;
    NULL_PASSWORD_EXEC EXCEPTION;
    NULL_COMPANY_ID_EXEC EXCEPTION;
    
BEGIN
        IF PI_COMPANY_ID IS NULL THEN
            RAISE NULL_COMPANY_ID_EXEC;
        END IF;
        
        BEGIN
            SELECT COMPANY_ID INTO V_COMPANY_ID
            FROM COMPANIES
            WHERE LOWER(COMPANY_ID) = LOWER(PI_COMPANY_ID);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                RAISE NULL_COMPANY_ID_EXEC; 
        END;
        
        
    --    IF COMPANY_ID = -1 THEN 
    --        RAISE V_COMPANY_DOES_NOT_EXIST;
    --    END IF;
    
        IF PI_FNAME IS NULL OR LENGTH(TRIM(PI_FNAME)) IS NULL THEN
            RAISE NULL_FNAME_EXEC;
            RETURN;
        END IF;
        
        IF PI_LNAME IS NULL OR LENGTH(TRIM(PI_LNAME)) IS NULL THEN
            RAISE NULL_LNAME_EXEC;
            RETURN;
        END IF;
        
        IF PI_USERNAME IS NULL OR LENGTH(TRIM(PI_USERNAME)) IS NULL THEN
            RAISE NULL_USERNAME_EXEC;
            RETURN;
        END IF;
        
        IF PI_EMAIL IS NULL OR LENGTH(TRIM(PI_EMAIL)) IS NULL THEN
            RAISE NULL_EMAIL_EXEC;
            RETURN;
        END IF;
        
        IF PI_PASSWORD IS NULL OR LENGTH(TRIM(PI_PASSWORD)) = 0 OR LENGTH(PI_PASSWORD) < 8 THEN
            RAISE NULL_PASSWORD_EXEC;
            RETURN;
        END IF;
        
        -- Insert New User
            INSERT INTO USERS(FIRSTNAME, LASTNAME, USERNAME,EMAIL, PASSWORD)
            VALUES (PI_FNAME, PI_LNAME, PI_USERNAME, PI_EMAIL, PI_PASSWORD)
            RETURNING USER_ID INTO V_NEW_USER_ID;
            
            INSERT INTO RECRUITERS (USER_ID, COMPANY_ID)
            VALUES (V_NEW_USER_ID, V_COMPANY_ID);
            
            DBMS_OUTPUT.PUT_LINE('USER CREATED SUCCESSFULLY. USER_ID:' || V_NEW_USER_ID);
    COMMIT;
    
EXCEPTION
    -- Handle exceptions
    WHEN NULL_FNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE ('Error creating PROFILE: FIRSTNAME cannot be empty.');
    WHEN NULL_LNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE ('Error creating PROFILE: LASTNAME cannot be empty.');
    WHEN NULL_USERNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE('Error creating PROFILE: USERNAME cannot be empty. ');
    WHEN NULL_EMAIL_EXEC THEN
            DBMS_OUTPUT.PUT_LINE('Error creating PROFILE: EMAIL cannot be empty. ');
    WHEN NULL_PASSWORD_EXEC THEN
            DBMS_OUTPUT.PUT_LINE('Error creating PROFILE: PASSWORD cannot be empty or less than 8 characters. ');
    WHEN NULL_COMPANY_ID_EXEC THEN
            DBMS_OUTPUT.PUT_LINE('Error creating PROFILE: COMPANY_ID cannot be empty or does not exist.');
--    WHEN NO_DATA_FOUND THEN
--        DBMS_OUTPUT.PUT_LINE('ERROR: COMPANY DOES NOT EXIST');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        
END REC_USER_CREATION;
/

CREATE OR REPLACE PROCEDURE REC_USER_UPDATION(
    PI_FNAME USERS.FIRSTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
    PI_LNAME USERS.LASTNAME%TYPE DEFAULT 'DEFAULT_FLAG',
    PI_USERNAME USERS.USERNAME%TYPE,
    PI_PASSWORD USERS.PASSWORD%TYPE DEFAULT 'DEFAULT_FLAG'
) AS
    V_USER_EXISTS NUMBER DEFAULT 0;
    V_USER_DATA USERS%ROWTYPE;
    NULL_USERNAME_EXEC EXCEPTION;
    NULL_FNAME_EXEC EXCEPTION;
    NULL_LNAME_EXEC EXCEPTION;
    NULL_PASSWORD_EXEC EXCEPTION;

BEGIN
    
    IF PI_USERNAME IS NULL OR LENGTH(TRIM(PI_USERNAME)) IS NULL THEN
        RAISE NULL_USERNAME_EXEC;
        RETURN;
    END IF;
    
    -- Check if the user exists
    BEGIN
        SELECT * INTO V_USER_DATA
        FROM USERS
        WHERE LOWER(USERNAME) = LOWER(PI_USERNAME);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('USERNAME: "' || PI_USERNAME || '" DOES NOT EXIST.');
            RETURN;
    END;
    
    IF PI_FNAME IS NULL OR LENGTH(TRIM(PI_FNAME)) IS NULL THEN
        RAISE NULL_FNAME_EXEC;
        RETURN;
    END IF;
    
    IF PI_LNAME IS NULL OR LENGTH(TRIM(PI_LNAME)) IS NULL THEN
        RAISE NULL_LNAME_EXEC;
        RETURN;
    END IF;
    
    IF LENGTH(TRIM(PI_PASSWORD)) = 0 OR LENGTH(TRIM(PI_PASSWORD)) < 8 THEN
        RAISE NULL_PASSWORD_EXEC;
        RETURN;
    END IF;
    
    -- Update User
    UPDATE USERS
    SET
        FIRSTNAME = CASE WHEN PI_FNAME = 'DEFAULT_FLAG' THEN V_USER_DATA.FIRSTNAME ELSE PI_FNAME  END,
        LASTNAME = CASE WHEN PI_LNAME = 'DEFAULT_FLAG' THEN V_USER_DATA.LASTNAME ELSE PI_LNAME END,
        PASSWORD = CASE WHEN PI_PASSWORD = 'DEFAULT_FLAG' THEN V_USER_DATA.PASSWORD ELSE PI_PASSWORD END
    WHERE LOWER(USERNAME) = LOWER(PI_USERNAME);

    -- Output the result
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('USER "' || PI_USERNAME || '" UPDATED SUCCESSFULLY.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO CHANGES WERE MADE TO THE USER.');
    END IF;

    COMMIT;
    
    EXCEPTION
        WHEN NULL_USERNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE('Error updating USERNAME: USERNAME cannot be empty. ');
        WHEN NULL_FNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE ('Error updating FIRSTNAME: FIRSTNAME cannot be empty.');
        WHEN NULL_LNAME_EXEC THEN
            DBMS_OUTPUT.PUT_LINE ('Error updating LASTNAME: LASTNAME cannot be empty.');
        WHEN NULL_PASSWORD_EXEC THEN
            DBMS_OUTPUT.PUT_LINE ('Error updating PASSWORD: PASSWORD cannot be empty or less than 8 characters.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: An unexpected error occurred while updating the user: ' || SQLERRM);

END REC_USER_UPDATION;
/


SELECT * FROM USERS;
SET SERVEROUTPUT ON;
BEGIN
    REC_USER_CREATION(
        PI_FNAME => 'MARK',
        PI_LNAME => 'TAYLOR',
        PI_USERNAME => 'Mark123',
        PI_EMAIL => 'mark1234@jmail.com',
        PI_PASSWORD => 'MARK1234@',
        PI_COMPANY_ID => '10'
);
END;
/


BEGIN
    REC_USER_UPDATION(
        PI_USERNAME => 'Mark123',
        PI_PASSWORD => 'MARK1234@'
);
END;
/
