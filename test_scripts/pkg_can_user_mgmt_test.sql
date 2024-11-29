--Testing for PROCEDURE: CREATE_CANDIDATE_PROFILE
SET SERVEROUTPUT ON;

BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing of PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE');
    -- Testing 1: Successful creation of a candidate profile
    DBMS_OUTPUT.PUT_LINE('1. Testing for successful creation of a candidate user profile:-');
    PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
        'ALEX', 'BROOK', 'abrook@jmail.com', 'ABROOK', 'Abrook@123',
        '118 Cedar Street', NULL, 'Boston', 'MA', '01103', 'USA',
        '878-900-1562', 25, 'male', 'not a veteran', 'no, i do not have a disability'
    );

    -- Testing 2: Duplicate Email
    DBMS_OUTPUT.PUT_LINE('2. Testing for duplicate email id constraint:-');
    PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
        'STEVE', 'SMITH', 'ssmith@jmail.com', 'SSMITH', 'Ablake@123',
        '456 Oak Street', NULL, 'Boston', 'MA', '02115', 'USA',
        '787-099-5654', 26, 'male', 'do not wish to disclose', 'no, i do not have a disability'
    );

    -- Testing 3: Duplicate Username
    DBMS_OUTPUT.PUT_LINE('3. Testing for duplicate username constraint:-');
    PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
        'CHRISTINA', 'JONES', 'cjones@jmail.com', 'LTURNER', 'Cjones@123',
        '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
        '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );

    -- Testing 4: Null First Name 
        DBMS_OUTPUT.PUT_LINE('4. Testing for null value in firstname:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            NULL, 'JONES', 'cjones@jmail.com', 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 5: Null Last Name 
        DBMS_OUTPUT.PUT_LINE('5. Testing for null value in last name:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', NULL, 'cjones@jmail.com', 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 6: Null Email ID
        DBMS_OUTPUT.PUT_LINE('6. Testing for null value in email address:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', NULL, 'LTURNER', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 7: Null Username
        DBMS_OUTPUT.PUT_LINE('7. Testing for null value in username:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', NULL, 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
     -- Testing 8: Null Password
        DBMS_OUTPUT.PUT_LINE('8. Testing for null value in password:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', NULL,
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 9: Null Street 1 Address
        DBMS_OUTPUT.PUT_LINE('9. Testing for null value in Street 1 of Address:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            NULL, NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
     -- Testing 10: Null City Address
        DBMS_OUTPUT.PUT_LINE('10. Testing for null value in City of Address:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, NULL, 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 11: Null State Address
        DBMS_OUTPUT.PUT_LINE('11. Testing for null value in State of Address:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', NULL, '02139', 'USA',
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 12: Null Country Address
        DBMS_OUTPUT.PUT_LINE('12. Testing for null value in Country of Address:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', NULL,
            '455-8900-988', 28, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 13: Invalid Gender 
        DBMS_OUTPUT.PUT_LINE('13. Testing for invalid Gender:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'gel', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 14: Invalid AGE 
        DBMS_OUTPUT.PUT_LINE('14. Testing for invalid AGE:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 12, 'female', 'I am a protected veteran', 'do not wish to disclose'
    );
    
    -- Testing 15: Invalid Veteran  
        DBMS_OUTPUT.PUT_LINE('15. Testing for invalid Veteran:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', 'No', 'do not wish to disclose'
    );
    
    -- Testing 16: Invalid Disability status  
        DBMS_OUTPUT.PUT_LINE('16. Testing for invalid Disability Status:-');
        PKG_CANDIDATE_USER_MANAGEMENT.CREATE_CANDIDATE_PROFILE(
            'CHRISTINA', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123',
            '789 Pine Street', NULL, 'Cambridge', 'MA', '02139', 'USA',
            '455-8900-988', 28, 'female', NULL, 'WHY'
    );
    
  --  COMMIT;
END;
/



--Testing for PROCEDURE: DEACTIVATE_CANDIDATE
BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing of PKG_CANDIDATE_USER_MANAGEMENT.DEACTIVATE_CANDIDATE');
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