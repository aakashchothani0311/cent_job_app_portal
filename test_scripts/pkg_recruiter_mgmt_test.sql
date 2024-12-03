-- Test script for PKG_RECRUITER_MANAGEMENT.CREATE_RECRUITER_PROFILE
SET SERVEROUTPUT ON;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_RECRUITER_MANAGEMENT.CREATE_RECRUITER_PROFILE');
    -- Testing 1: Successful creation of a recruiter profile
    DBMS_OUTPUT.PUT_LINE('1. Testing for successful creation of a recruiter user profile:- ');
    REC_MGMT.CREATE_RECRUITER_PROFILE('DWAYANE', 'JOHNSON' , 'dwayane123@jmail.com', 'DWAYANE123' , 'DWAYANE@123' , '11');
    
    -- Testing 2: Duplicate Email
    DBMS_OUTPUT.PUT_LINE('2. Testing for duplicate email id constraint:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('ALLEN', 'LUGO' , 'alugo@jmail.com', 'ALLEN' , 'Alugo@123', '11');
    
    -- Testing 3: Duplicate Username
    DBMS_OUTPUT.PUT_LINE('3. Testing for duplicate username constraint:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('ALLEN', 'LUGO' , 'allen@jmail.com', 'ALUGO' , 'Alugo@123', '11');
    
    -- Testing 4: Null First Name 
    DBMS_OUTPUT.PUT_LINE('4. Testing for null value in firstname:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE(NULL, 'LUGO', 'john123@jmail.com', 'JOHN123', 'JOHN123@', '11');
        
    -- Testing 5: Null Last Name 
    DBMS_OUTPUT.PUT_LINE('5. Testing for null value in last name:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', NULL , 'john123@jmail.com', 'JOHN123', 'JOHN123@', '11');
    
    -- Testing 6: Null Email ID
    DBMS_OUTPUT.PUT_LINE('6. Testing for null value in email address:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', 'JOHNSON' , NULL, 'Mark123', 'JOHN123@', '11');
    
    -- Testing 7: Null Username
    DBMS_OUTPUT.PUT_LINE('7. Testing for null value in username:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', 'JOHNSON' ,'john123@jmail.com', NULL , 'JOHN123@', '11');
    
    -- Testing 8: Null Password
    DBMS_OUTPUT.PUT_LINE('8. Testing for null value in password:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', 'JOHNSON' , 'mark12345@jmail.com', 'Marrie@123', NULL, '11');
    
    -- Testing 9: Null Company_ID
    DBMS_OUTPUT.PUT_LINE('9. Testing for null value in company_id:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', 'JOHNSON' , 'mark12345@jmail.com', 'Marrie@123' , 'JOHN123' , NULL);
    
    -- Testing 10: Invalid Company_ID
    DBMS_OUTPUT.PUT_LINE('10. Testing for invalid company_id:-');
    REC_MGMT.CREATE_RECRUITER_PROFILE('MARRIE', 'JOHNSON' , 'mark12345@jmail.com', 'Marrie@123' , 'JOHN123' , '152');
    
    COMMIT;
END;
/

-- Test script for PKG_RECRUITER_MANAGEMENT.UPDATE_RECRUITER_PROFILE
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_RECRUITER_MANAGEMENT.UPDATE_RECRUITER_PROFILE');
    -- Testing 1: Successful updation of a recruiter profile
    DBMS_OUTPUT.PUT_LINE('1. Testing for successful creation of a recruiter user profile:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_FNAME => 'DWAYANE_UPDATED', PI_LNAME => 'JOHNSON_UPDATED', PI_PW => 'PASS_UPDATED', PI_UNAME => 'DWAYANE123');
    
    -- Testing 2: Null Firstname
    DBMS_OUTPUT.PUT_LINE('2. Testing for null firstname:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_FNAME => NULL, PI_UNAME => 'ALUGO');
    
    -- Testing 3: Null Lastname
    DBMS_OUTPUT.PUT_LINE('3. Testing for null lastname:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_LNAME => NULL, PI_UNAME => 'ALUGO');
    
    -- Testing 4: Null Username
    DBMS_OUTPUT.PUT_LINE('4. Testing for null username:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_LNAME => 'MILLER', PI_UNAME => NULL);
    
    -- Testing 5: Invalid Username
    DBMS_OUTPUT.PUT_LINE('5. Testing for Invalid username:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_FNAME => 'JOHN', PI_UNAME => 'JDEER');
    
    -- Testing 6: Null Password
    DBMS_OUTPUT.PUT_LINE('6. Testing for null password:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_PW => NULL, PI_UNAME => 'ALUGO');
    
    -- Testing 7: Password less than 8 characters
    DBMS_OUTPUT.PUT_LINE('7. Testing for password less than 8 characters:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_PW => 'MARK!@', PI_UNAME => 'ALUGO');
    
    -- Testing 8: Testing for passing only username
    DBMS_OUTPUT.PUT_LINE('8. Testing for No updating fields provided with username:- ');
    REC_MGMT.UPDATE_RECRUITER_PROFILE(PI_UNAME => 'ALUGO');
    
    COMMIT;
END;
/
