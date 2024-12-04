-- Test script for PKG_CAN_APP_MGMT.CANDIDATE_STATUS Procedure
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING CANDIDATE_STATUS PROCEDURE');
    
    -- 1. Test for updating candidate_status successfully
    DBMS_OUTPUT.PUT_LINE('1. Testing for candidate status successfully updated.');
    CAN_APP_MGMT.CANDIDATE_STATUS(2, 8, 'offer accepted');
    
    -- 2. Test for valid CANDIDATE_ID and REQ_ID
    DBMS_OUTPUT.PUT_LINE('2. Testing for valid candidate_id and req_id');
    CAN_APP_MGMT.CANDIDATE_STATUS(9, 3, 'offer accepted');
    
    -- 3. Test for Invalid candidate_status
    DBMS_OUTPUT.PUT_LINE('3. Testing for Invalid candidate status');
    CAN_APP_MGMT.CANDIDATE_STATUS(2, 8, 'accepted');
    
    COMMIT;
END;
/


-- Test script for PKG_CAN_APP_MGMT.UPDATE_APPLICATION_STATUS
BEGIN
    UTIL_PKG.ADD_NEW_LINE('Testing UPDATE_APPLICATION_STATUS Procedure');

    -- Test 1: Valid update
    DBMS_OUTPUT.PUT_LINE('1. Test 1: Updating application status to "offer".');
    CAN_APP_MGMT.UPDATE_APPLICATION_STATUS(1, 6, 'candidate rejected');

    -- Test 2: Invalid status
    DBMS_OUTPUT.PUT_LINE('2. Test 2: Updating application with invalid status.');
    CAN_APP_MGMT.UPDATE_APPLICATION_STATUS(1, 3, 'withdrawn');

    -- Test 3: Invalid Candidate ID
    DBMS_OUTPUT.PUT_LINE('3. Test 3: Updating application with invalid Candidate ID.');
    CAN_APP_MGMT.UPDATE_APPLICATION_STATUS(10990, 5, 'candidate rejected');

    -- Test 4: Invalid Requisition ID
    DBMS_OUTPUT.PUT_LINE('4. Test 4: Updating application with invalid Requisition ID.');
    CAN_APP_MGMT.UPDATE_APPLICATION_STATUS(4, 10098, 'role offered');

    -- Test 5: No matching application
    DBMS_OUTPUT.PUT_LINE('5. Test 5: No matching application for the given Candidate ID and Requisition ID.');
    CAN_APP_MGMT.UPDATE_APPLICATION_STATUS(4, 2, 'role offered');
    
    COMMIT;
END;
/


-- Test script for PKG_CAN_APP_MGMT.WITHDRAW_APP
DECLARE    
    C_VALID_CAN_ID CONSTANT CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE := 2;
    C_VALID_REQ_ID CONSTANT CANDIDATE_APPLICATION.REQ_ID%TYPE := 7;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_CAN_APP_MGMT.WITHDRAW_APP PROCEDURE');
    
    DBMS_OUTPUT.PUT_LINE('1. Testing for NULL CANDIDATE_ID:');
    CAN_APP_MGMT.WITHDRAW_APP('', 23);
    
    DBMS_OUTPUT.PUT_LINE('2. Testing for NULL REQUISITION_ID:');
    CAN_APP_MGMT.WITHDRAW_APP(23, '');
    
    DBMS_OUTPUT.PUT_LINE('3. Testing for invalid CANDIDATE_ID: CANDIDATE does not exist:');
    CAN_APP_MGMT.WITHDRAW_APP(100, C_VALID_REQ_ID);
    
    DBMS_OUTPUT.PUT_LINE('4. Testing for invalid REQUISITION_ID: REQUISITION does not exist:');
    CAN_APP_MGMT.WITHDRAW_APP(C_VALID_CAN_ID, 30);
    
    DBMS_OUTPUT.PUT_LINE('5. Valid CANDIDATE_ID and REQ_ID but candidate has not applied to this job posting:');
    CAN_APP_MGMT.WITHDRAW_APP(C_VALID_CAN_ID, 2);
    
    DBMS_OUTPUT.PUT_LINE('6. Valid CANDIDATE_ID and REQ_ID - candidate applied to this job posting:');
    CAN_APP_MGMT.WITHDRAW_APP(C_VALID_CAN_ID, C_VALID_REQ_ID);
    
  --  DBMS_OUTPUT.PUT_LINE('7. Valid CANDIDATE_ID and REQ_ID, job posting already withdrawn:');
 --   CAN_APP_MGMT.WITHDRAW_APP(C_VALID_CAN_ID, C_VALID_REQ_ID);
 
    COMMIT;
END;
/
