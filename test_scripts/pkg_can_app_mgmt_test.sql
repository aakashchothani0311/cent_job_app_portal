-- Test script for PKG_CAN_APP_MGMT.WITHDRAW_APP
DECLARE    
    C_VALID_CAN_ID CONSTANT CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE := 2;
    C_VALID_REQ_ID CONSTANT CANDIDATE_APPLICATION.REQ_ID%TYPE := 7;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_CAN_APP_MGMT.WITHDRAW_APP PROCEDURE');
    
    DBMS_OUTPUT.PUT_LINE('1. Testing for NULL CANDIDATE_ID:');
    WITHDRAW_APP('', 23);
    
    DBMS_OUTPUT.PUT_LINE('2. Testing for NULL REQUISITION_ID:');
    WITHDRAW_APP(23, '');
    
    DBMS_OUTPUT.PUT_LINE('3. Testing for invalid CANDIDATE_ID: CANDIDATE does not exist:');
    WITHDRAW_APP(100, C_VALID_REQ_ID);
    
    DBMS_OUTPUT.PUT_LINE('4. Testing for invalid REQUISITION_ID: REQUISITION does not exist:');
    WITHDRAW_APP(C_VALID_CAN_ID, 30);
    
    DBMS_OUTPUT.PUT_LINE('5. Valid CANDIDATE_ID and REQ_ID but candidate has not applied to this job posting:');
    WITHDRAW_APP(C_VALID_CAN_ID, 2);
    
    DBMS_OUTPUT.PUT_LINE('6. Valid CANDIDATE_ID and REQ_ID - candidate applied to this job posting:');
    WITHDRAW_APP(C_VALID_CAN_ID, C_VALID_REQ_ID);
    
  --  DBMS_OUTPUT.PUT_LINE('7. Valid CANDIDATE_ID and REQ_ID, job posting already withdrawn:');
 --   WITHDRAW_APP(C_VALID_CAN_ID, C_VALID_REQ_ID);
END;
/

select * from candidate_application;