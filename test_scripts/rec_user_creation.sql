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

