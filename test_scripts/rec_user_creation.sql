SET SERVEROUTPUT ON;

BEGIN
    REC_USER_CREATION(
        PI_FNAME => 'jack',               -- First name
        PI_LNAME => 'howard',             -- Last name
        PI_USERNAME => 'jackhoward',      -- Username
        PI_EMAIL => 'jackhoward@example.com',  -- Email address
        PI_PASSWORD => 'password123',     -- Password
        PI_COMPANY_NAME => 'Tech Solutions'  -- Company name
    );
END;

--Testing for PROCEDURE: CREATE_CANDIDATE_PROFILE
BEGIN
    CREATE_CANDIDATE_PROFILE(
        'John', 'Doe', 'john.doe@example.com', 'john_doe', 'jdoe@',
        '123 Elm Street', NULL, 'Springfield', 'MA', '01103', 'USA',
        '123-456-7890', 25, 'male'
    );
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: This candidate record already exists and violates uniqueness).');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Something went wrong: ' || SQLERRM);
END;
/

--Testing for PROCEDURE: DEACTIVATE_CANDIDATE
BEGIN
    DEACTIVATE_CANDIDATE(1); 
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: This candidate ID does not exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Something went wrong: ' || SQLERRM);
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