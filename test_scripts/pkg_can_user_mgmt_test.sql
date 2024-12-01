--Testing for PROCEDURE: CREATE_CANDIDATE_PROFILE
SET SERVEROUTPUT ON;

BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing of PKG_CANDIDATE_MANAGEMENT.CREATE_CANDIDATE_PROFILE');
    -- Testing 1: Successful creation of a candidate profile
    DBMS_OUTPUT.PUT_LINE('1. Testing for successful creation of a candidate user profile:-');
    CAN_MGMT.CREATE_CANDIDATE_PROFILE(
        'NALINI', 'SHARMA', 'nsharma@jmail.com', 'NSHARMA', 'Nsharma@123',
        '118 Cedar Street', NULL, 'Boston', 'MA', '01103', 'USA',
        '878-900-1562', 25, 'male', 'not a veteran', 'no, i do not have a disability'
    );

    -- Testing 2: Duplicate Email
    DBMS_OUTPUT.PUT_LINE('2. Testing for duplicate email id constraint:-');
    CAN_MGMT.CREATE_CANDIDATE_PROFILE(
        'CHRISTINA', 'JONAH', 'cjones@jmail.com', 'CJONAH', 'Ssmith@123',
        '456 Oak Street', NULL, 'Boston', 'MA', '02115', 'USA',
        '787-099-5654', 26, 'male', 'do not wish to disclose', 'no, i do not have a disability'
    );

    -- Testing 3: Duplicate Username
    DBMS_OUTPUT.PUT_LINE('3. Testing for duplicate username constraint:-');
    CAN_MGMT.CREATE_CANDIDATE_PROFILE(
        'CHRISTINA', 'JONES', 'chjone@jmail.com', 'CJONES', 'Cjones@123',
        '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
        '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );

    -- Testing 4: Null First Name 
        DBMS_OUTPUT.PUT_LINE('4. Testing for null value in firstname:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            NULL, 'JONES', 'cjones@jmail.com', 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 5: Null Last Name 
        DBMS_OUTPUT.PUT_LINE('5. Testing for null value in last name:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', NULL, 'cjones@jmail.com', 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 6: Null Email ID
        DBMS_OUTPUT.PUT_LINE('6. Testing for null value in email address:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', NULL, 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 7: Null Username
        DBMS_OUTPUT.PUT_LINE('7. Testing for null value in username:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', NULL, 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
     -- Testing 8: Null Password
        DBMS_OUTPUT.PUT_LINE('8. Testing for null value in password:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', NULL,
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 9: Null Street 1 Address
        DBMS_OUTPUT.PUT_LINE('9. Testing for null value in Street 1 of Address:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CRISTIANO', 'RONALDO', 'cronaldo@jmail.com', 'CRONALDO', 'Cronaldo@123',
            NULL, NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
     -- Testing 10: Null City Address
        DBMS_OUTPUT.PUT_LINE('10. Testing for null value in City of Address:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'siop@jmail.com', 'LMESS', 'Cjones@123',
            '789 Pine Street', NULL, NULL, 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 11: Null State Address
        DBMS_OUTPUT.PUT_LINE('11. Testing for null value in State of Address:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjs@jmail.com', 'KKOL', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', NULL, '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 12: Null Country Address
        DBMS_OUTPUT.PUT_LINE('12. Testing for null value in Country of Address:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'uio@jmail.com', 'TYE', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', NULL,
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 13: Invalid Gender 
        DBMS_OUTPUT.PUT_LINE('13. Testing for invalid Gender:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'ytune@jmail.com', 'OPPPP', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'gel', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 14: Invalid AGE 
        DBMS_OUTPUT.PUT_LINE('14. Testing for invalid AGE:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'ghhye@jmail.com', 'BHJD', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 12, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 15: Invalid Veteran  
        DBMS_OUTPUT.PUT_LINE('15. Testing for invalid Veteran:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cgvjhvbj@jmail.com', 'VHHGS', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'No', 'do not wish to disclose'
    );
    
    -- Testing 16: Invalid Disability status  
        DBMS_OUTPUT.PUT_LINE('16. Testing for invalid Disability Status:-');
        CAN_MGMT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'vhbkjbjs@jmail.com', 'CGHDD', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', NULL, 'WHY'
    );
  COMMIT;
END;
/

--Testing for Procedure: UPDATE_CANDIDATE_PROFILE
DECLARE
    VALID_CANID CONSTANT CANDIDATES.CANDIDATE_ID%TYPE := 1; 
    NON_EXISTENT_CANID CONSTANT CANDIDATES.CANDIDATE_ID%TYPE := 10078;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE');
    
    -- Testing 1: Successful Update - Update phone, age, and gender
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('1. Testing for Successful Candidate profile Update - Update phone, age, and gender.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_PHONE => '987-654-3210',
        PI_AGE => 30,
        PI_GENDER => 'male'
    );

    -- Testing 2: Update with NULL values - No changes should be made
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('2. Testing for No Updates - All parameters NULL.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_PHONE => NULL,
        PI_AGE => NULL,
        PI_GENDER => NULL,
        PI_VETERAN => NULL,
        PI_DISABILITY => NULL
    );

    -- Testing 3: Invalid Gender
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('3. Testing for Invalid Gender.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_GENDER => 'invalid_gender'
    );

    -- Testing 4: Invalid Age (less than 16)
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('4. Testing for Invalid Age.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_AGE => 10
    );

    -- Testing 5: Non-existent Candidate ID
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('5. Testing for Non-existent Candidate ID.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => NON_EXISTENT_CANID,
        PI_PHONE => '123-456-7890'
    );

    -- Testing 6: Invalid Veteran Status
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('6. Testing for Invalid Veteran Status.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_VETERAN => 'invalid_status'
    );

    -- Testing 7: Invalid Disability Status
    UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('7. Testing for Invalid Disability Status.'));
    PKG_CANDIDATE_MANAGEMENT.UPDATE_CANDIDATE_PROFILE(
        PI_CANID => VALID_CANID,
        PI_DISABILITY => 'invalid_disability'
    );
    COMMIT;
END;
/



--Testing for PROCEDURE: DEACTIVATE_CANDIDATE
BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing of PKG_CANDIDATE_MANAGEMENT.DEACTIVATE_CANDIDATE');
    -- Testing 1: Valid Candidate ID  
        DBMS_OUTPUT.PUT_LINE('1. Testing for valid Candidate ID Account Deactivation:-');
    DEACTIVATE_CANDIDATE(3); 
    
    -- Testing 2: Invalid Candidate ID  
        DBMS_OUTPUT.PUT_LINE('2. Testing for invalid Candidate ID Account Deactivation:-');
    DEACTIVATE_CANDIDATE(100); 

END;
/

--Testing for FUNCTION: Checking Candidate Account Status
DECLARE
    V_STATUS NUMBER;
BEGIN
    SELECT IS_CANDIDATE_ACTIVE(4) INTO V_STATUS FROM DUAL; 
    IF V_STATUS = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Candidate account is active.');
    ELSIF V_STATUS = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Candidate account is inactive.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Candidate account status is unknown.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('This Candidate ID not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Something went wrong: ' || SQLERRM);
END;
/