-- Procedure to create JOB_REQUISTION
CREATE OR REPLACE PACKAGE PKG_JOB_REQ_MGMT AS
    PROCEDURE CREATE_JOB_REQ (
        PI_REC_ID IN JOB_REQUISITION.RECRUITER_ID%TYPE,
        PI_JOB_TITLE IN JOB_REQUISITION.JOB_TITLE%TYPE,
        PI_JOB_DESC IN JOB_REQUISITION.JOB_DESCRIPTION%TYPE,
        PI_DATE_POSTED IN JOB_REQUISITION.DATE_POSTED%TYPE DEFAULT SYSDATE, 
        PI_APP_DEADLINE IN JOB_REQUISITION.APPLICATION_DEADLINE%TYPE DEFAULT NULL,
        PI_EXP_START_DATE IN JOB_REQUISITION.EXPECTED_START_DATE%TYPE DEFAULT NULL,
        PI_RELOCATION_ALLOWANCE IN JOB_REQUISITION.RELOCATION_ALLOWANCE%TYPE DEFAULT 0,
        PI_STATUS IN JOB_REQUISITION.STATUS%TYPE DEFAULT 'open'
    );
    
    PROCEDURE UPDATE_REQ_STATUS (
        PI_REQ_ID IN JOB_REQUISITION.REQ_ID%TYPE,
        PI_JOB_TITLE IN JOB_REQUISITION.JOB_TITLE%TYPE DEFAULT '##DEFAULT_FLAG##',
        PI_JOB_DESC IN JOB_REQUISITION.JOB_DESCRIPTION%TYPE DEFAULT '##DEFAULT_FLAG##',
      --  PI_APP_DEADLINE IN JOB_REQUISITION.APPLICATION_DEADLINE%TYPE,
      --  PI_EXP_START_DATE IN JOB_REQUISITION.EXPECTED_START_DATE%TYPE,
        PI_RELOCATION_ALLOWANCE IN JOB_REQUISITION.RELOCATION_ALLOWANCE%TYPE DEFAULT -1,
        PI_STATUS IN JOB_REQUISITION.STATUS%TYPE DEFAULT '##DEFAULT_FLAG##'
    );
END PKG_JOB_REQ_MGMT;
/

CREATE OR REPLACE PACKAGE BODY PKG_JOB_REQ_MGMT AS
    PROCEDURE CREATE_JOB_REQ (
        PI_REC_ID IN JOB_REQUISITION.RECRUITER_ID%TYPE,
        PI_JOB_TITLE IN JOB_REQUISITION.JOB_TITLE%TYPE,
        PI_JOB_DESC IN JOB_REQUISITION.JOB_DESCRIPTION%TYPE,
        PI_DATE_POSTED IN JOB_REQUISITION.DATE_POSTED%TYPE DEFAULT SYSDATE, 
        PI_APP_DEADLINE IN JOB_REQUISITION.APPLICATION_DEADLINE%TYPE DEFAULT NULL,
        PI_EXP_START_DATE IN JOB_REQUISITION.EXPECTED_START_DATE%TYPE DEFAULT NULL,
        PI_RELOCATION_ALLOWANCE IN JOB_REQUISITION.RELOCATION_ALLOWANCE%TYPE DEFAULT 0,
        PI_STATUS IN JOB_REQUISITION.STATUS%TYPE DEFAULT 'open'
    ) IS
        V_COMP_ID COMPANIES.COMPANY_ID%TYPE;
        V_JOB_REQ_ID JOB_REQUISITION.REQ_ID%TYPE;
        
        NULL_REC_ID_EXEC EXCEPTION;
        NULL_TITLE_EXEC EXCEPTION;
        NULL_JOB_DESC_EXEC EXCEPTION;
        INVALID_APP_DLINE_EXEC EXCEPTION;
        INVALID_EXP_START_DATE_EXEC EXCEPTION;
        INVALID_STATUS_EXEC EXCEPTION;
        NULL_STATUS_EXEC EXCEPTION;
    BEGIN
        IF PI_REC_ID IS NULL THEN
            RAISE NULL_REC_ID_EXEC;
        END IF;
        
        IF PI_JOB_TITLE IS NULL OR TRIM(PI_JOB_TITLE) IS NULL THEN
            RAISE NULL_TITLE_EXEC;
        END IF;
        
         IF PI_JOB_DESC IS NULL OR TRIM(PI_JOB_DESC) IS NULL THEN
            RAISE NULL_JOB_DESC_EXEC;
        END IF;
        
        IF PI_APP_DEADLINE IS NOT NULL AND PI_APP_DEADLINE < PI_DATE_POSTED THEN
            RAISE INVALID_APP_DLINE_EXEC;
        END IF;
        
        IF PI_EXP_START_DATE IS NOT NULL THEN
            IF PI_EXP_START_DATE < PI_DATE_POSTED OR (PI_APP_DEADLINE IS NOT NULL AND PI_EXP_START_DATE < PI_APP_DEADLINE) THEN
                RAISE INVALID_EXP_START_DATE_EXEC;
            END IF;
        END IF;
        
        IF PI_STATUS IS NULL OR TRIM(PI_STATUS) IS NULL THEN
            RAISE NULL_STATUS_EXEC;
        END IF;
        
        IF LOWER(PI_STATUS) NOT IN ('cancelled', 'closed', 'open') THEN
            RAISE INVALID_STATUS_EXEC;
        END IF;
        
        SELECT COMPANY_ID
        INTO V_COMP_ID
        FROM RECRUITERS
        WHERE RECRUITER_ID = PI_REC_ID;
        
        INSERT INTO JOB_REQUISITION
            (COMPANY_ID, RECRUITER_ID, JOB_TITLE, JOB_DESCRIPTION, DATE_POSTED, APPLICATION_DEADLINE, EXPECTED_START_DATE, RELOCATION_ALLOWANCE, STATUS)
        VALUES
            (V_COMP_ID, PI_REC_ID, LOWER(PI_JOB_TITLE), LOWER(PI_JOB_DESC), PI_DATE_POSTED, PI_APP_DEADLINE, PI_EXP_START_DATE, PI_RELOCATION_ALLOWANCE, LOWER(PI_STATUS))
        RETURNING REQ_ID INTO V_JOB_REQ_ID;
            
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('New JOB REQUISTION Created: ' || PI_JOB_TITLE || '. Req Id: ' || V_JOB_REQ_ID));
            
    EXCEPTION
        WHEN NULL_REC_ID_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Invalid Recruiter ID: Recruiter ID can not be null.'));
        
        WHEN NULL_TITLE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: JOB_TITLE can not be null/ empty.'));
            
        WHEN NULL_JOB_DESC_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: JOB_DESCRIPTION can not be null/ empty.'));
        
        WHEN INVALID_APP_DLINE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: APPLICATION_DEADLINE should be greater than DATE_POSTED.'));
            
        WHEN INVALID_EXP_START_DATE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: EXPECTED_START_DATE should be greater than DATE_POSTED and APPLICATION_DEADLINE.'));
            
        WHEN NULL_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: STATUS can not be null/ empty.'));
            
        WHEN INVALID_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: STATUS can only be "open", "closed", "cancelled".'));
        
        WHEN NO_DATA_FOUND THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Invalid Recruiter ID: Recruiter ID ' || PI_REC_ID || ' does not exsit.'));
        
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating JOB_REQUISITION: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
            
    END CREATE_JOB_REQ;
    
    PROCEDURE UPDATE_REQ_STATUS (
        PI_REQ_ID IN JOB_REQUISITION.REQ_ID%TYPE,
        PI_JOB_TITLE IN JOB_REQUISITION.JOB_TITLE%TYPE DEFAULT '##DEFAULT_FLAG##',
        PI_JOB_DESC IN JOB_REQUISITION.JOB_DESCRIPTION%TYPE DEFAULT '##DEFAULT_FLAG##',
      --  PI_APP_DEADLINE IN JOB_REQUISITION.APPLICATION_DEADLINE%TYPE,
      --  PI_EXP_START_DATE IN JOB_REQUISITION.EXPECTED_START_DATE%TYPE,
        PI_RELOCATION_ALLOWANCE IN JOB_REQUISITION.RELOCATION_ALLOWANCE%TYPE DEFAULT -1,
        PI_STATUS IN JOB_REQUISITION.STATUS%TYPE DEFAULT '##DEFAULT_FLAG##'
    ) AS
        V_JOB_REQ JOB_REQUISITION%ROWTYPE;
        
        NULL_REQ_ID_EXEC EXCEPTION;
        NULL_JOB_TITLE_EXEC EXCEPTION;
        NULL_JOB_DESC_EXEC EXCEPTION;
        NULL_REL_ALL_EXEC EXCEPTION;
        NULL_STATUS_EXEC EXCEPTION;
        INVALID_STATUS_EXEC EXCEPTION;
    BEGIN
        IF PI_REQ_ID IS NULL THEN
            RAISE NULL_REQ_ID_EXEC;
        END IF;
        
        IF PI_JOB_TITLE IS NULL OR TRIM(PI_JOB_TITLE) IS NULL THEN
            RAISE NULL_JOB_TITLE_EXEC;
        END IF;
        
        IF PI_JOB_DESC IS NULL OR TRIM(PI_JOB_DESC) IS NULL THEN
            RAISE NULL_JOB_DESC_EXEC;
        END IF;
        
        IF PI_RELOCATION_ALLOWANCE IS NULL THEN
            UTIL_PKG.ADD_NEW_LINE('here');  
        END IF;
        
        IF PI_STATUS IS NULL OR TRIM(PI_STATUS) IS NULL THEN
            RAISE NULL_STATUS_EXEC;
        END IF;
        
        IF PI_STATUS != '##DEFAULT_FLAG##' AND LOWER(PI_STATUS) NOT IN ('cancelled', 'closed', 'open') THEN
            RAISE INVALID_STATUS_EXEC;
        END IF;
        
        SELECT JOB_TITLE, JOB_DESCRIPTION, APPLICATION_DEADLINE, EXPECTED_START_DATE, RELOCATION_ALLOWANCE, STATUS
        INTO V_JOB_REQ.JOB_TITLE, V_JOB_REQ.JOB_DESCRIPTION , V_JOB_REQ.APPLICATION_DEADLINE , V_JOB_REQ.EXPECTED_START_DATE , V_JOB_REQ.RELOCATION_ALLOWANCE , V_JOB_REQ.STATUS
        FROM JOB_REQUISITION
        WHERE REQ_ID = PI_REQ_ID;
        
        V_JOB_REQ.JOB_TITLE := CASE WHEN PI_JOB_TITLE = '##DEFAULT_FLAG##' THEN V_JOB_REQ.JOB_TITLE ELSE PI_JOB_TITLE END;
        V_JOB_REQ.JOB_DESCRIPTION := CASE WHEN PI_JOB_DESC = '##DEFAULT_FLAG##' THEN V_JOB_REQ.JOB_DESCRIPTION ELSE PI_JOB_DESC END;
        -- V_JOB_REQ.APPLICATION_DEADLINE := CASE WHEN PI_APP_DEADLINE = '##DEFAULT_FLAG##' THEN V_JOB_REQ.APPLICATION_DEADLINE ELSE PI_APP_DEADLINE END;
        -- V_JOB_REQ.EXPECTED_START_DATE := CASE WHEN PI_EXP_START_DATE = '##DEFAULT_FLAG##' THEN V_JOB_REQ.EXPECTED_START_DATE ELSE PI_EXP_START_DATE END;
        V_JOB_REQ.RELOCATION_ALLOWANCE := CASE WHEN PI_RELOCATION_ALLOWANCE = -1 THEN V_JOB_REQ.RELOCATION_ALLOWANCE ELSE PI_RELOCATION_ALLOWANCE END;
        V_JOB_REQ.STATUS := CASE WHEN PI_STATUS = '##DEFAULT_FLAG##' THEN V_JOB_REQ.STATUS ELSE PI_STATUS END;
        
        UPDATE JOB_REQUISITION
        SET
            JOB_TITLE = V_JOB_REQ.JOB_TITLE,
            JOB_DESCRIPTION = V_JOB_REQ.JOB_DESCRIPTION,
            RELOCATION_ALLOWANCE = V_JOB_REQ.RELOCATION_ALLOWANCE,
            STATUS = V_JOB_REQ.STATUS
        WHERE REQ_ID = PI_REQ_ID;
        
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('JOB_REQUISTION ' || PI_REQ_ID || ' updated successfully.'));
            
    EXCEPTION
        WHEN NULL_REQ_ID_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: REQ_ID is needed to update the record.'));
        
        WHEN NULL_JOB_TITLE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: JOB_TITLE can not be null/ empty.'));
        
        WHEN NULL_JOB_DESC_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: JOB_DESCRIPTION can not be null/ empty.'));
            
       -- WHEN NULL_REL_ALL_EXEC THEN
       --     UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: JOB_DESCRIPTION can not be null/ empty.'));
            
        WHEN NULL_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: STATUS can not be null/ empty.'));
            
        WHEN INVALID_STATUS_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: STATUS can only be "open", "closed", "cancelled".'));      
        
        WHEN NO_DATA_FOUND THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Invalid Requistion ID: ' || PI_REQ_ID || ' does not exsit.'));
            
        WHEN OTHERS THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error updating JOB_REQUISITION: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
            
    END UPDATE_REQ_STATUS;
END PKG_JOB_REQ_MGMT;
/

 
-- Trigger to update CANDIDATE_APPLICATION if JOB_REQUISITON is cancelled/ closed.
CREATE OR REPLACE TRIGGER UPDATE_CAN_APP_CANCELLED
AFTER UPDATE ON JOB_REQUISITION
FOR EACH ROW
DECLARE
    C_CANCELLED_STATUS CONSTANT CANDIDATE_APPLICATION.STATUS%TYPE := 'requisition closed/ transfered';
BEGIN
    IF :NEW.STATUS = 'cancelled' THEN
        UPDATE CANDIDATE_APPLICATION
        SET STATUS = C_CANCELLED_STATUS
        WHERE REQ_ID = :OLD.REQ_ID;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error cancelling candidate applciations: ' || SQLERRM));
        ROLLBACK;
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error, transactions if any are rolled back.'));
        
END;
/


-- Create Synonym for the package
CREATE OR REPLACE SYNONYM JOB_REQ_MGMT
FOR ADMIN_SUPER_USER.PKG_JOB_REQ_MGMT;
