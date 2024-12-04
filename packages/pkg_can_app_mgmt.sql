CREATE OR REPLACE PACKAGE PKG_CAN_APP_MGMT AS
    PROCEDURE CREATE_CAN_APP (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE, 
        REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE, 
        STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE DEFAULT 'submitted'
    );
    
    PROCEDURE CANDIDATE_STATUS (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE, 
        PI_REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE, 
        PI_STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE
    );
    
    PROCEDURE UPDATE_APPLICATION_STATUS (
        PI_CANID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE,
        PI_REQID IN CANDIDATE_APPLICATION.REQ_ID%TYPE,
        PI_STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE
    );
    
    PROCEDURE WITHDRAW_APP (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE,
        PI_REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE
    );
END PKG_CAN_APP_MGMT;
/

CREATE OR REPLACE PACKAGE BODY PKG_CAN_APP_MGMT AS
    PROCEDURE CREATE_CAN_APP (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE, 
        REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE, 
        STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE DEFAULT 'submitted'
    ) AS
    BEGIN
        INSERT INTO CANDIDATE_APPLICATION
            (CANDIDATE_ID, REQ_ID, STATUS)
        VALUES
            (PI_CAN_ID, REQ_ID, LOWER(STATUS));
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating application: ' || SQLERRM);
            
    END CREATE_CAN_APP;
    
    PROCEDURE CANDIDATE_STATUS (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE, 
        PI_REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE, 
        PI_STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE
    ) AS
        V_STATUS CANDIDATE_APPLICATION.STATUS%TYPE;
        
        INVALID_STATUS_EXEC EXCEPTION;
        NULL_APPLICATION_EXEC EXCEPTION;
    BEGIN
        IF PI_STATUS NOT IN ('offer accepted', 'offer rejected') THEN
            RAISE INVALID_STATUS_EXEC;
        END IF;
        
        BEGIN
            SELECT STATUS INTO V_STATUS
            FROM CANDIDATE_APPLICATION
            WHERE CANDIDATE_ID = PI_CAN_ID AND REQ_ID = PI_REQ_ID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE NULL_APPLICATION_EXEC;
        END;
    
        -- Update the application status to accepted or rejected
        UPDATE CANDIDATE_APPLICATION
        SET STATUS = PI_STATUS
        WHERE CANDIDATE_ID = PI_CAN_ID AND REQ_ID = PI_REQ_ID;
    
        IF SQL%ROWCOUNT > 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Application for Candidate ID ' || PI_CAN_ID || ' updated successfully to status ' || PI_STATUS));
        ELSE
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('No matching application found for Candidate ID ' || PI_CAN_ID || ' and Job Requisition ID ' || PI_REQ_ID));
        END IF;
    
    EXCEPTION
        WHEN INVALID_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: Status must be "offer accepted" or "offer rejected" when the candidate updates the application.'));
            
        WHEN NULL_APPLICATION_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: The candidate must submit an application before it can be accepted or rejected.'));
            
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in CANDIDATE_STATUS procedure: ' || SQLERRM);
            RAISE;
            
    END CANDIDATE_STATUS;
    
    PROCEDURE UPDATE_APPLICATION_STATUS (
        PI_CANID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE,
        PI_REQID IN CANDIDATE_APPLICATION.REQ_ID%TYPE,
        PI_STATUS IN CANDIDATE_APPLICATION.STATUS%TYPE
    ) AS
        V_COUNT NUMBER;
        
        INVALID_STATUS_EXEC EXCEPTION;
        INVALID_CANDIDATE_EXEC EXCEPTION;
        INVALID_REQUISITION_EXEC EXCEPTION;
    BEGIN
        IF PI_STATUS IN ('withdrawn', 'requisition closed/ transfered') THEN
            RAISE INVALID_STATUS_EXEC;
        END IF;
    
        SELECT COUNT(CANDIDATE_ID)
        INTO V_COUNT
        FROM CANDIDATES
        WHERE CANDIDATE_ID = PI_CANID;
    
        IF V_COUNT = 0 THEN
            RAISE INVALID_CANDIDATE_EXEC;
        END IF;
    
        SELECT COUNT(REQ_ID)
        INTO V_COUNT
        FROM JOB_REQUISITION
        WHERE REQ_ID = PI_REQID;
    
        IF V_COUNT = 0 THEN
            RAISE INVALID_REQUISITION_EXEC;
        END IF;
    
        UPDATE CANDIDATE_APPLICATION
        SET STATUS = PI_STATUS
        WHERE CANDIDATE_ID = PI_CANID 
        AND REQ_ID = PI_REQID;
    
        IF SQL%ROWCOUNT = 0 THEN
             UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('No matching application found for Candidate ID: ' || PI_CANID || ' and Requisition ID: ' || PI_REQID));
        ELSE
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Application status updated successfully for Candidate ID: ' || PI_CANID || ' and Requisition ID: ' || PI_REQID  || 'and Status as: ' || PI_STATUS));
        END IF;
    
    EXCEPTION
        WHEN INVALID_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: Invalid status provided.'));
            
        WHEN INVALID_CANDIDATE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: Candidate ID ' || PI_CANID || ' does not exist.'));
            
        WHEN INVALID_REQUISITION_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error: Requisition ID ' || PI_REQID || ' does not exist.'));
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating application status: ' || SQLERRM));
            ROLLBACK;
            
    END UPDATE_APPLICATION_STATUS;

    PROCEDURE WITHDRAW_APP (
        PI_CAN_ID IN CANDIDATE_APPLICATION.CANDIDATE_ID%TYPE,
        PI_REQ_ID IN CANDIDATE_APPLICATION.REQ_ID%TYPE
    ) AS
        C_WITHDRAWN_STATUS CONSTANT CANDIDATE_APPLICATION.STATUS%TYPE := 'withdrawn';
        V_CND_COUNT NUMBER := 0;
        V_REQ_COUNT NUMBER := 0;
        
        NULL_CND_ID_EXEC EXCEPTION;
        NULL_REQ_ID_EXEC EXCEPTION;
        CAND_NOT_FOUND_EXEC EXCEPTION;
        REQ_NOT_FOUND_EXEC EXCEPTION;
    BEGIN
        IF PI_CAN_ID IS NULL THEN
            RAISE NULL_CND_ID_EXEC;
        END IF;
        
        IF PI_REQ_ID IS NULL THEN
            RAISE NULL_REQ_ID_EXEC;
        END IF;
        
        SELECT COUNT(CANDIDATE_ID)
        INTO V_CND_COUNT
        FROM CANDIDATES
        WHERE CANDIDATE_ID = PI_CAN_ID;
        
        IF V_CND_COUNT = 0 THEN
            RAISE CAND_NOT_FOUND_EXEC;
        END IF;
        
        SELECT COUNT(REQ_ID)
        INTO V_REQ_COUNT
        FROM JOB_REQUISITION
        WHERE REQ_ID = PI_REQ_ID;
        
        IF V_REQ_COUNT = 0 THEN
            RAISE REQ_NOT_FOUND_EXEC;
        END IF;
        
        UPDATE CANDIDATE_APPLICATION
        SET STATUS = C_WITHDRAWN_STATUS
        WHERE CANDIDATE_ID = PI_CAN_ID AND REQ_ID = PI_REQ_ID;
        
        IF SQL%ROWCOUNT > 0 THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Application for Job Requsition ' || PI_REQ_ID || ' withdrawn successfully.'));
        ELSE
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Candidate has not applied to the JOB ID: ' || PI_REQ_ID));
        END IF;
        
    EXCEPTION
        WHEN NULL_CND_ID_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error withdrawing APPLICATION: CANDIDATE_ID is needed to withdraw the application.'));
                        
        WHEN NULL_REQ_ID_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error withdrawing APPLICATION: REQ_ID is needed to withdraw the application.'));
            
        WHEN CAND_NOT_FOUND_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Invalid CANDIDATE_ID. Candidate not found.'));
            
        WHEN REQ_NOT_FOUND_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Invalid REQ_ID. Requistion ' || PI_REQ_ID || ' not found'));
        
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error withdrawing application: ' || SQLERRM);
            
    END WITHDRAW_APP;
END PKG_CAN_APP_MGMT;
/


-- Trigger
CREATE OR REPLACE TRIGGER BEFORE_CAN_APP_UPDATE
AFTER UPDATE ON JOB_REQUISITION
FOR EACH ROW
BEGIN
    /*IF STATUS IS 'draft', only candidate can update.
    IF SUBMITTED, CANDIDATE CAN ONLY UPDATE STATUS TO WITHDRAWN
    IF 'requisition closed/ transfered', WITHDRAWN, NOBODY SHOULD BE ABLE TO UPDATE ANYTHING,
    else ONLY RECRUITER CAN UPDATE STATUS COLUMN  */
    
    IF :NEW.STATUS = 'draft' AND :USER != 'candidate' THEN
        RAISE;
    ELSIF :OLD.STATUS = 'submitted' AND :NEW.STATUS != :OLD.STATUS THEN
        IF :USER != 'candidate' OR :NEW.STATUS != 'withdrawn' THEN
            RAISE_APPLICATION_ERROR(-20002, 'Candidates can only update the status to "withdrawn" when the status is "submitted".');
        END IF;
    ELSIF :NEW.STATUS IN ('requisition closed', 'transferred', 'withdrawn') THEN
        RAISE;
    ELSIF :USER != 'recruiter' THEN
        RAISE;
    END IF;

END;
/


-- Create Synonym for the package
CREATE OR REPLACE SYNONYM CAN_APP_MGMT
FOR ADMIN_SUPER_USER.PKG_CAN_APP_MGMT;


-- APP CREATION (DUP VALIDATION) (AAKASH)
-- WITHDRAWN/ REJECTED RECORD SHOULD NOT BE UPDATED (TRIGGER - Aakash)