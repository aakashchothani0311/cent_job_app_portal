-- USERS TABLE INSERT DATA 
INSERT INTO USERS 
    (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD) 
VALUES
    ('john', 'deer', 'jdeer@jmail.com', 'JDEER', 'Jdeer@123'),
    ('missy', 'rodriguez', 'jrodriguez@jmail.com', 'JRODRI', 'Jrodri@123'),
    ('lionel', 'turner', 'lturner@jmail.com', 'LTURNER', 'Lturner@123'),
    ('chris', 'jones', 'cjones@jmail.com', 'CJONES', 'Cjones@123'),
    ('adam', 'blake', 'ablake@jmail.com', 'ABLAKE', 'Ablake@123'),
    ('allen', 'lugo', 'alugo@jmail.com', 'ALUGO', 'Alugo@123'),
    ('ross', 'miller', 'rmiller@jmail.com', 'RMILLER', 'Rmiller@123'),
    ('david', 'austin', 'daustin@jmail.com', 'DAUSTIN', 'Daustin@123'),
    ('mat', 'henry', 'mhenry@jmail.com', 'MHENRY', 'Mhenry@123'),
    ('ravin', 'patel', 'rpatel@jmail.com', 'RPATEL', 'Rpatel@123'),
    ('aakash', 'choksy', 'aakash@jmail.com', 'ACHOKSY', 'Achoksy@123');


-- ADDRESS TABLE INSERT DATA
INSERT INTO ADDRESS 
    (STREET1, STREET2, CITY, COUNTY, STATE, ZIPCODE, COUNTRY) 
VALUES
    ('123 Main St', 'Apt 1A', 'Boston', 'Suffolk', 'Massachusetts', '02101', 'USA'),
    ('456 Elm St', NULL, 'Cambridge', 'Middlesex', 'Massachusetts', '02139', 'USA'),
    ('789 Maple Ave', 'Suite 3', 'Dallas', NULL, 'Texas', '02903', 'USA'),
    ('101 Oak St', NULL, 'Hartford', 'Hartford', 'Connecticut', '06106', 'USA'),
    ('202 Pine St', 'Apt 2B', 'Worcester', 'Worcester', 'Massachusetts', '01608', 'USA'),
    ('303 Cedar St', NULL, 'Tampa', NULL, 'Floria', '01103', 'USA'),
    ('404 Birch St', NULL, 'West Lafayette', NULL, 'Indiana', '06510', 'USA'),
    ('505 Walnut St', 'Apt 3C', 'Manhattan', NULL, 'New York', '01852', 'USA'),
    ('408 Birch St', NULL, 'New Haven', 'New Haven', 'Connecticut', '06510', 'USA'),
    ('515 Apricot St', 'Apt 3C', 'Fremont', NULL, 'California', '01852', 'USA');


INSERT INTO CANDIDATES 
    (USER_ID, ADD_ID, PHONE, AGE, GENDER, VETERAN, DISABILITY, DATE_OF_JOIN) 
VALUES
    (1, 1, '555-1234-321', 25, 'male', 'not a veteran', 'no, i do not have a disability', TO_DATE('2024-10-01','YYYY-MM-DD')),
    (2, 2, '111-2345-678', 24, 'female', 'not a veteran', 'do not wish to disclose', TO_DATE('2024-10-08','YYYY-MM-DD')),
    (3, 3, '857-3456-411', 26, 'male', 'do not wish to disclose', 'yes, I have a disability', TO_DATE('2024-10-07','YYYY-MM-DD')),
    (4, 4, '980-4567-911', 25, 'male', 'not a veteran', 'no, i do not have a disability', TO_DATE('2024-10-03','YYYY-MM-DD')),
    (5, 5, '555-5678-087', 25, 'male', 'not a veteran', 'do not wish to disclose', TO_DATE('2024-10-09','YYYY-MM-DD'));


-- WORK_EXP TABLE INSERT DATA
INSERT INTO WORK_EXP 
    (CANDIDATE_ID, COMPANY_NAME, JOB_TITLE, START_DATE, END_DATE, DESCRIPTION) 
VALUES
    (1, 'Tech Solutions', 'Systems Associate', TO_TIMESTAMP('2021-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2022-05-31', 'YYYY-MM-DD'), 'Developed software solutions.'),
    (1, 'Web Innovators', 'Frontend Developer', TO_TIMESTAMP('2022-06-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-07-30', 'YYYY-MM-DD'), 'Created responsive web designs.'),
    (2, 'FinServe Inc.', 'Finance Intern', TO_TIMESTAMP('2020-01-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-05-25', 'YYYY-MM-DD'), 'Analyzed financial data.'),
    (2, 'BizCorp', 'Financial Analyst', TO_TIMESTAMP('2021-07-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2022-05-31', 'YYYY-MM-DD'), 'Managed financial analysis data.'),
    (3, 'Era Automotive', 'Trainee', TO_TIMESTAMP('2020-06-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2021-07-31', 'YYYY-MM-DD'), 'Automation of control systems.'),
    (3, 'EcoEnergy', 'Robotics Engineer', TO_TIMESTAMP('2021-08-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-08-15', 'YYYY-MM-DD'), 'Designed PLC and HMI systems along with automation of MIG Welding Robots.'),
    (4, 'Hub Tech', 'Dev Intern', TO_TIMESTAMP('2023-01-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-08-15', 'YYYY-MM-DD'), 'Software Developement Solutions work.'),
    (5, 'Simplify', 'Data Analyst', TO_TIMESTAMP('2021-01-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2021-12-01', 'YYYY-MM-DD'), 'Managed and optimized database systems.'),
    (5, 'TechVerse', 'Data Engineer', TO_TIMESTAMP('2022-01-05', 'YYYY-MM-DD'),  TO_TIMESTAMP('2022-07-05', 'YYYY-MM-DD'), 'Managed IT infrastructure.');


-- EDUCATION TABLE INSERT DATA
INSERT INTO EDUCATION 
    (CANDIDATE_ID, UNIVERSITY_NAME, DEGREE, MAJOR, START_DATE, END_DATE, DEGREE_COMPLETED) 
VALUES
    (1, 'Boston University', 'BSc', 'Computer Science', TO_DATE('2017-06-15', 'YYYY-MM-DD'), TO_DATE('2021-04-08', 'YYYY-MM-DD'), 1),
    (1, 'University of California', 'MSc', 'Data Science', TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL, 0),
    (2, 'University of Florida', 'BBA', 'Finance', TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('2020-05-01', 'YYYY-MM-DD'), 1),
    (2, 'Harvard University', 'MBA', 'Business Administration', TO_DATE('2022-08-01', 'YYYY-MM-DD'), NULL, 0),
    (3, 'Northeastern University', 'BEng', 'Mechanical Engineering', TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('2020-05-08', 'YYYY-MM-DD'), 1),
    (3, 'Northeastern University', 'MEng', 'Mechatronics Engineering', TO_DATE('2023-09-02', 'YYYY-MM-DD'), NULL, 0),
    (4, 'New York University', 'BSc', 'Information Technology', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2024-08-01', 'YYYY-MM-DD'), 1), 
    (5, 'Emerson University', 'Bsc', 'Data Science', TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('2020-12-01', 'YYYY-MM-DD'), 1),
    (5, 'Purdue University', 'MSc', 'Computer Science', TO_DATE('2022-09-01', 'YYYY-MM-DD'), TO_DATE('2024-08-08', 'YYYY-MM-DD'), 1);


-- RESUME TABLE INSERT DATA
INSERT INTO RESUME 
    (CANDIDATE_ID, RES_DOC, DESCRIPTION)
VALUES
    (1, 'TGVkIGEgdGVhbSBvZiA1IGluIGRldmVsb3BpbmcgYSBoaWdoLXBlcmZvcm1hbmNlIHNpbmdsZS1wYWdlIGFwcGxpY2F0aW9uIHVzaW5nIE5leHRKUyBhbmQgUmVhY3QsIHJlZHVjaW5nIGxvYWQgdGltZXMgYnkgMzAlLg==
SW1wbGVtZW50ZWQgcmVzcG9uc2l2ZSBhbmQgYWNjZXNzaWJsZSBkZXNpZ24sIGVuc3VyaW5nIGNvbXBhdGliaWxpdHkgYWNyb3NzIG11bHRpcGxlIGRldmljZXMgYW5kIGJyb3dzZXJzLCBib29zdGluZyB1c2VyIGVuZ2FnZW1lbnQgYnkgMjUlLg==
T3B0aW1pemVkIHdlYiBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSBieSBpbnRlZ3JhdGluZyBhZHZhbmNlZCBKYXZhU2NyaXB0IGFuZCBUeXBlU2NyaXB0IHRlY2huaXF1ZXMsIGVuaGFuY2luZyBzcGVlZCBieSAyMCUu
RGV2ZWxvcGVkIGFuZCBtYWludGFpbmVkIGNvZGUgcXVhbGl0eSB0aHJvdWdoIHJpZ29yb3VzIHRlc3RpbmcgYW5kIGRlYnVnZ2luZywgcmVkdWNpbmcgYnVnIHJhdGUgYnkgMTUlLg==
TWVudG9yZWQganVuaW9yIGRldmVsb3BlcnMgaW4gZnJvbnQgZW5kIHRlY2hub2xvZ2llcywgaW1wcm92aW5nIHRlYW0gc2tpbGxzIGFuZCBwcm9qZWN0IGRlbGl2ZXJ5IHNwZWVkIGJ5IDQwJS4=', 'Frontend Developer Resume'),
    (2, 'Q29uZHVjdGVkIGluLWRlcHRoIGZpbmFuY2lhbCBhbmFseXNpcywgaW5jbHVkaW5nIGZvcmVjYXN0aW5nIGFuZCB0cmVuZCBldmFsdWF0aW9ucywgdG8gc3VwcG9ydCBzdHJhdGVnaWMgZGVjaXNpb24tbWFraW5nIGFuZCBpbXByb3ZlIGNvc3QgZWZmaWNpZW5jeSBieSAxNSUu
UHJlcGFyZWQgZGV0YWlsZWQgbW9udGhseSwgcXVhcnRlcmx5LCBhbmQgYW5udWFsIGZpbmFuY2lhbCByZXBvcnRzIGZvciBzZW5pb3IgbWFuYWdlbWVudCwgcHJvdmlkaW5nIGluc2lnaHRzIGludG8gcHJvZml0YWJpbGl0eSwgdmFyaWFuY2VzLCBhbmQgS1BJcy4=
RGV2ZWxvcGVkIGZpbmFuY2lhbCBtb2RlbHMgdG8gYXNzZXNzIGludmVzdG1lbnQgb3Bwb3J0dW5pdGllcywgb3B0aW1pemluZyByZXNvdXJjZSBhbGxvY2F0aW9uIGFuZCBhY2hpZXZpbmcgYSAyMCUgaW5jcmVhc2UgaW4gUk9JLg==
Q29sbGFib3JhdGVkIHdpdGggY3Jvc3MtZnVuY3Rpb25hbCB0ZWFtcyB0byBpbXBsZW1lbnQgYnVkZ2V0aW5nIHByb2Nlc3NlcywgcmVkdWNpbmcgb3ZlcmhlYWQgZXhwZW5zZXMgYnkgJDUwMEsgYW5udWFsbHku', 'Financial Analyst Resume'),
    (3, 'RGVzaWduZWQgYW5kIHByb2dyYW1tZWQgcm9ib3RpYyBzeXN0ZW1zIGZvciBhdXRvbWF0aW9uIGluIG1hbnVmYWN0dXJpbmcsIGltcHJvdmluZyBhc3NlbWJseSBsaW5lIGVmZmljaWVuY3kgYnkgMzAlLg==
RGV2ZWxvcGVkIGVsZWN0cmljYWwgYW5kIG1lY2hhbmljYWwgbGF5b3V0cyBmb3Igcm9ib3RpYyB3b3JrIGNlbGxzLCBlbnN1cmluZyBjb21wbGlhbmNlIHdpdGggc2FmZXR5IHN0YW5kYXJkcyBhbmQgb3BlcmF0aW9uYWwgcmVxdWlyZW1lbnRzLg==
SW50ZWdyYXRlZCB2aXNpb24gc3lzdGVtcyBhbmQgYWR2YW5jZWQgc2Vuc29ycyBpbnRvIHJvYm90aWMgc29sdXRpb25zIHRvIGVuaGFuY2UgcHJlY2lzaW9uIGFuZCByZWxpYWJpbGl0eSBpbiBkeW5hbWljIGVudmlyb25tZW50cy4=
TGVkIHRlc3RpbmcgYW5kIGRlYnVnZ2luZyBpbml0aWF0aXZlcywgcmVzb2x2aW5nIG9wZXJhdGlvbmFsIGVycm9ycyBhbmQgcmVkdWNpbmcgZG93bnRpbWUgYnkgMjUlLg==', 'Robotics Engineer Resume'),
    (4, 'RGVzaWduZWQsIGRldmVsb3BlZCwgYW5kIG1haW50YWluZWQgd2ViIGFwcGxpY2F0aW9ucyB1c2luZyB0ZWNobm9sb2dpZXMgbGlrZSBKYXZhU2NyaXB0LCBSZWFjdCwgYW5kIFB5dGhvbiwgZW5oYW5jaW5nIHVzZXIgc2F0aXNmYWN0aW9uIGJ5IDQwJS4=
QnVpbHQgYW5kIG9wdGltaXplZCBiYWNrZW5kIHN5c3RlbXMsIGluY2x1ZGluZyBkYXRhYmFzZSBzY2hlbWEgZGVzaWduIGFuZCBBUEkgaW50ZWdyYXRpb25zLCBpbXByb3ZpbmcgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgYnkgMjUlLg==
Q29sbGFib3JhdGVkIHdpdGggY3Jvc3MtZnVuY3Rpb25hbCB0ZWFtcyBpbiBBZ2lsZSBlbnZpcm9ubWVudHMgdG8gZGVsaXZlciBoaWdoLXF1YWxpdHkgc29mdHdhcmUgd2l0aGluIHN0cmljdCBkZWFkbGluZXMu
SW1wbGVtZW50ZWQgYXV0b21hdGVkIHRlc3RpbmcgcHJvdG9jb2xzLCBhY2hpZXZpbmcgYSA5NSUgcmVkdWN0aW9uIGluIHByb2R1Y3Rpb24gZGVmZWN0cy4=', 'Software Developer Resume'),
    (5, 'RGV2ZWxvcGVkIHByZWRpY3RpdmUgbW9kZWxzIHVzaW5nIG1hY2hpbmUgbGVhcm5pbmcgYWxnb3JpdGhtcyAoZS5nLiwgUmFuZG9tIEZvcmVzdCwgWEdCb29zdCkgdG8gaW1wcm92ZSBjdXN0b21lciByZXRlbnRpb24gYnkgMjAlLg==
QW5hbHl6ZWQgbGFyZ2UgZGF0YXNldHMgdG8gdW5jb3ZlciB0cmVuZHMgYW5kIGFjdGlvbmFibGUgaW5zaWdodHMsIGRyaXZpbmcgZGF0YS1pbmZvcm1lZCBkZWNpc2lvbnMgZm9yIGJ1c2luZXNzIGdyb3d0aC4=
Q3JlYXRlZCBpbnRlcmFjdGl2ZSBkYXNoYm9hcmRzIGFuZCB2aXN1YWxpemF0aW9ucyB1c2luZyB0b29scyBsaWtlIFRhYmxlYXUgYW5kIFBvd2VyIEJJLCBlbmhhbmNpbmcgZXhlY3V0aXZlIGRlY2lzaW9uLW1ha2luZyBlZmZpY2llbmN5Lg==
RGVwbG95ZWQgRVRMIHBpcGVsaW5lcyBmb3IgZGF0YSBwcmVwcm9jZXNzaW5nLCBlbnN1cmluZyBkYXRhIHF1YWxpdHkgYW5kIGltcHJvdmluZyBwcm9jZXNzaW5nIHNwZWVkIGJ5IDMwJS4=', 'Data Scientist Resume');

-- SKILLS TABLE INSERT DATA
INSERT INTO SKILLS 
    (SKILL_NAME) 
VALUES
    ('HTML'),
    ('CSS'),
    ('JavaScript'),
    ('Financial Modeling'), 
    ('Excel'), 
    ('Risk Analysis'),
    ('Robotics Programming'), 
    ('PLC'), 
    ('Machine Learning'),
    ('Java'),
    ('SQL'),
    ('Python'),
    ('Statistical Analysis'),
    ('Data Visualization'),
    ('Project Management'),
    ('Data Analysis'),
    ('Network Security'),
    ('Cloud Computing'),
    ('Marketing'),
    ('Financial Analysis'),
    ('Quality Management'),
    ('Product Management'),
    ('ERP'),
    ('SAP'),
    ('Manufacturing'),
    ('Software Development');


-- CANDIDATE_SKILLS TABLE INSERT DATA
INSERT INTO CANDIDATE_SKILLS 
    (CANDIDATE_ID, SKILL_ID) 
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 26),
    (1, 12),
    (2, 4),
    (2, 5),
    (2, 6),
    (2, 13),
    (2, 20),
    (3, 7),
    (3, 8),
    (3, 9),
    (3, 15),
    (3, 21),
    (3, 23),
    (3, 25),
    (4, 10),
    (4, 11),
    (4, 12),
    (4, 26),
    (5, 14),
    (5, 15),
    (5, 16),
    (5, 17),
    (5, 24);


-- COMPANIES TABLE INSERT DATA
INSERT INTO COMPANIES 
    (ADD_ID, NAME, EMAIL, PHONE) 
VALUES
    (1, 'Tech Solutions', 'contact@techsolutions.com', '567-123-0987'),
    (2, 'Hub Tech', 'info@hubtech.com', '867-564-6389'),
    (4, 'Web Innovators', 'hr@webinno.com', '565-676-6575'),
    (5, 'EcoEnergy', 'support@ecoenergy.com', '989-989-9898'),
    (3, 'TechVerse', 'contact@techverse.com', '090-434-0987'),
    (6, 'Era Automotive', 'careers@eraauto.com', '444-878-0989'),
    (7, 'Simplify', 'info@simplify.com', '132-656-2781'),
    (8, 'BizCorp', 'hr@bizcorp.com', '555-121-4589'),
    (9, 'FinServe Inc.', 'contact@finserve.com', '565-980-1323'),
    (10, 'AutoWorks', 'contact@autoworks.com', '867-982-5433'),
    (10, 'Retina IT Solutions', 'retina@IT.com', '857-321-0981'),
    (3, 'Persistent', 'persistent@hr.com', '123-098-1023'),
    (2, 'TCS', 'careers@tcs.com' , '856-564-2911'),
    (1, 'IBM' , 'ibm@careers.com', '857-577-3433');
    

-- RECRUITERS TABLE INSERT DATA
INSERT INTO RECRUITERS 
    (USER_ID, COMPANY_ID) 
VALUES
    (6, 13),
    (7, 13),
    (8, 12),
    (9, 11),
    (10, 10),
    (11, 14);


-- JOB_REQUISITION TABLE INSERT DATA
INSERT INTO JOB_REQUISITION 
    (COMPANY_ID, RECRUITER_ID, JOB_TITLE, JOB_DESCRIPTION, DATE_POSTED, 
    APPLICATION_DEADLINE, EXPECTED_START_DATE, RELOCATION_ALLOWANCE, STATUS) 
VALUES
    (10, 5, 'Automation Engineer', 'Develop and implement automation systems to enhance efficiency.', TO_DATE('2024-10-26', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1, 'open'),
    (10, 5, 'Control systems Engineer', 'Design control systems to regulate machinery and processes.', TO_DATE('2024-10-26', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1, 'open'),
    (11, 4, 'Data Scientist', 'Analyze data and build predictive models.', TO_DATE('2024-10-26', 'YYYY-MM-DD'), TO_DATE('2025-01-05', 'YYYY-MM-DD'), TO_DATE('2025-02-11', 'YYYY-MM-DD'), 1, 'open'),
    (12, 3, 'Machine Learning Engineer', 'Build machine learning models to solve complex problems.', TO_DATE('2024-10-27', 'YYYY-MM-DD'), TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2025-02-02', 'YYYY-MM-DD'), 0, 'open'),
    (13, 5, 'Mechanical Engineer', 'Design automotive parts and systems.', TO_DATE('2024-10-28', 'YYYY-MM-DD'), TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2025-01-05', 'YYYY-MM-DD'), 0, 'open'),
    (13, 1, 'Data Analyst', 'Interpret data trends and provide actionable business insights.', TO_DATE('2024-10-29', 'YYYY-MM-DD'), TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'), 0, 'open'),
    (13, 1, 'Accountant', 'Manage financial records and budgeting.', TO_DATE('2024-11-02', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2025-05-05', 'YYYY-MM-DD'), 0, 'open'),
    (13, 1, 'Financial Analyst', 'Analyze investment opportunities and provide strategic recommendations.', TO_DATE('2024-11-04', 'YYYY-MM-DD'), TO_DATE('2024-12-28', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'), 1, 'open'),
    (13, 1, 'Web Developer', 'Build and maintain functional and responsive websites.', TO_DATE('2024-11-04', 'YYYY-MM-DD'), TO_DATE('2024-12-17', 'YYYY-MM-DD'), TO_DATE('2025-02-10', 'YYYY-MM-DD'), 1, 'open'),
    (13, 2, 'Network Administrator', 'Manage and secure network infrastructure.', TO_DATE('2024-11-04', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'), 1, 'open'),
    (14, 6, 'Full Stack Developer', 'Develop and manage frontend and backend of applications.', TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 0, 'open'),
    (14, 6, 'Backend Developer', 'Create and optimize server-side logic and database structures.', TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 0, 'open');


-- CANDIDATE_APPLICATION TABLE INSERT DATA
INSERT INTO CANDIDATE_APPLICATION 
    (CANDIDATE_ID, REQ_ID, STATUS, RESUME_ID) 
VALUES
    (1, 3, 'submitted',1),
    (1, 6, 'in review',1),
    (2, 7, 'in review',2),
    (2, 8, 'in review',2),
    (2, 6, 'submitted',2),
    (3, 1, 'submitted',3),
    (3, 2, 'in review',3),
    (3, 5, 'in review',3),
    (3, 6, 'submitted',3),
    (4, 11, 'submitted',4),
    (4, 12, 'submitted',4),
    (4, 9, 'submitted',4),
    (4, 4, 'submitted',4),
    (4, 6, 'draft',4),
    (5, 3, 'submitted',5),
    (5, 6, 'draft',5),
    (5, 10, 'in review',5);

COMMIT;