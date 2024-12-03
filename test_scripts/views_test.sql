--View/Report 1 Testing - JOBS_APPLIED_HISTORY
-- LIST OF ALL JOBS THAT CHRIS JONES HAS APPLIED TO
SELECT INITCAP(CANDIDATE_NAME) AS "CANDIDATE_NAME", REQ_ID AS "JOB REQUISTION ID", 
       COMPANY_NAME AS "COMPANY NAME", JOB_TITLE AS "JOB TITLE", 
       DATE_APPLIED AS "DATE OF APPLICATION", INITCAP(STATUS) AS "CURRENT STATUS"
FROM JOBS_APPLIED_HISTORY
WHERE CANDIDATE_NAME='chris jones';

--View/Report 2 Testing - JOBS_CREATED_HISTORY
-- LIST OF ALL JOB REQUISITIONS THAT ALLEN LUGO HAS POSTED 
SELECT RECRUITER_ID, INITCAP(RECRUITER_NAME) AS "RECRUITER NAME", REQ_ID, 
         JOB_TITLE, JOB_DESCRIPTION, DATE_POSTED, STATUS
FROM JOBS_CREATED_HISTORY
WHERE RECRUITER_ID =1;

--View/Report 3 Testing - CANDIDATES_JOBS_APPLIED
-- LIST OF ALL CANDIDATES THAT HAD APPLIED TO A SINGLE JOB POSTING 
SELECT  REQ_ID, JOB_TITLE, CANDIDATE_ID, CANDIDATE_NAME, PHONE_NUMBER, 
         EMAIL AS "CANDIDATE EMAILID", WILLING_TO_RELOCATE AS "WILLING TO RELOCATE?",
         APPLICATION_STATUS
FROM CANDIDATES_JOBS_APPLIED
WHERE REQ_ID = 6;

--View/Report 4 Testing - OPEN_JOBS
-- LIST OF ALL OPEN JOB POSTINGS UNDER A COMPANY 
SELECT  COMPANY_NAME, REQ_ID, JOB_TITLE, JOB_DESCRIPTION, JOB_POSTED,
        DEADLINE, INITCAP(JOB_STATUS) AS "JOB STATUS", RELOCATION_ALLOWANCE
FROM OPEN_JOBS
WHERE COMPANY_NAME = 'TCS' 
AND JOB_STATUS = 'open';

--View/Report 5 Testing - CANDIDATE_PROFILE
-- CANDIDATE PROFILE CURRENT DATA FOR "JOHN DEER"
SELECT CANDIDATE_ID, INITCAP(CANDIDATE_NAME) AS "CANDIDATE NAME", EMAIL, 
       PHONE, SKILLS, AGE, GENDER, VETERAN, DISABILITY, JOINED_DATE, 
       STREET1, STREET2, CITY, STATE, ZIPCODE
FROM CANDIDATE_PROFILE
WHERE CANDIDATE_ID =1;