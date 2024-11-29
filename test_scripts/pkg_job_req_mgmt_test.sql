-- Test script for PKG_JOB_REQ_MGMT.CREATE_JOB_REQ
DECLARE
    C_VALID_REC_ID CONSTANT JOB_REQUISITION.RECRUITER_ID%TYPE := 2;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_JOB_REQ_MGMT.CREATE_JOB_REQ PROCEDURE');
    
    DBMS_OUTPUT.PUT_LINE('1. Testing for NULL RECRUITER_ID:');
    CREATE_JOB_REQ(NULL, 'TEST TITLE', 'TEST DESC');
    
    DBMS_OUTPUT.PUT_LINE('2. Testing for invalid RECRUITER_ID:');
    CREATE_JOB_REQ(2342, 'TEST TITLE', 'TEST DESC');
    
    DBMS_OUTPUT.PUT_LINE('3. Testing for invalid TITLE by passing an empty value:');
    CREATE_JOB_REQ(C_VALID_REC_ID, '', 'TEST DESC');
    
    DBMS_OUTPUT.PUT_LINE('4. Testing for invalid DESCRIPTION by passing an empty value:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', '');
    
    DBMS_OUTPUT.PUT_LINE('5. Testing for invalid APPLICATION_DEADLINE: APPLICATION_DEADLINE less than JOB_POSTED:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, SYSDATE - 3);
    
    DBMS_OUTPUT.PUT_LINE('6. Testing for invalid EXPECTED_START_DATE: EXPECTED_START_DATE less than JOB_POSTED:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, NULL, SYSDATE - 2, 0);
    
    DBMS_OUTPUT.PUT_LINE('7. Testing for invalid EXPECTED_START_DATE: EXPECTED_START_DATE less than APPLICATION_DEADLINE:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, SYSDATE + 7, SYSDATE - 3, 0);
    
    DBMS_OUTPUT.PUT_LINE('8. Testing for invalid EXPECTED_START_DATE: EXPECTED_START_DATE less than APPLICATION_DEADLINE:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, SYSDATE + 7, SYSDATE + 3, 0);
    
    DBMS_OUTPUT.PUT_LINE('9. Testing for invalid STATUS by passing NULL value:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, SYSDATE + 7, NULL, 0, NULL);
    
    DBMS_OUTPUT.PUT_LINE('10. Testing for invalid STATUS: STATUS other than valid (open, closed, cancelled) options:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'TEST TITLE', 'TEST DESC', SYSDATE, SYSDATE + 7, NULL, 0, 'rejected');
        
    DBMS_OUTPUT.PUT_LINE('11. Testing for valid JOB_REQUISTION record with default values:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'Software Engineering Intern', 'TEST DESC');
    
    DBMS_OUTPUT.PUT_LINE('12. Testing for valid JOB_REQUISTION record:');
    CREATE_JOB_REQ(C_VALID_REC_ID, 'Data Engineering Intern', 'TEST DESC', SYSDATE, SYSDATE + 3, SYSDATE + 180, 1, 'open');
    
    COMMIT;
END;
/


-- Test script for PKG_JOB_REQ_MGMT.UPDATE_REQ_STATUS
DECLARE
    C_VALID_REQ_ID CONSTANT JOB_REQUISITION.REQ_ID%TYPE := 2;
BEGIN
    UTIL_PKG.ADD_NEW_LINE('TESTING PKG_JOB_REQ_MGMT.UPDATE_REQ_STATUS PROCEDURE');
    
    DBMS_OUTPUT.PUT_LINE('1. Testing for NULL REQ_ID:');
    UPDATE_REQ_STATUS(NULL);
    
    DBMS_OUTPUT.PUT_LINE('2. Testing for invalid REQ_ID:');
    UPDATE_REQ_STATUS(2342, 'TEST TITLE', 'TEST DESC');
    
    DBMS_OUTPUT.PUT_LINE('3. Testing for invalid TITLE by passing an empty value:');
    UPDATE_REQ_STATUS(C_VALID_REQ_ID, '');
    
    DBMS_OUTPUT.PUT_LINE('4. Testing for invalid DESCRIPTION by passing an empty value:');
    UPDATE_REQ_STATUS(C_VALID_REQ_ID, 'TEST TITLE', NULL);
    
    DBMS_OUTPUT.PUT_LINE('5. Testing for invalid STATUS by passing an empty value:');
    UPDATE_REQ_STATUS(C_VALID_REQ_ID, 'TEST TITLE', 'TEST DESCRIPTION', 0, '');
    
    --IMPLICITLY MAKING NULL STATUS AS 0
    
    DBMS_OUTPUT.PUT_LINE('6. Testing for invalid STATUS: STATUS other than valid (open, closed, cancelled) options:');
    UPDATE_REQ_STATUS(C_VALID_REQ_ID, 'TEST TITLE', 'TEST DESCRIPTION', 0, 'rejected');
    
    DBMS_OUTPUT.PUT_LINE('7. Testing for valid STATUS: update status to close/ cancelled:');
   /* UPDATE_REQ_STATUS(
        PI_REQ_ID => C_VALID_REQ_ID,
        PI_STATUS => 'closed'
    );*/
    
    COMMIT;
END;
/