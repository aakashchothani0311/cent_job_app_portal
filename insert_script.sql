-- USERS TABLE INSERT DATA 
INSERT INTO USERS 
    (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD) 
VALUES
    ('JOHN', 'DEER', 'jdeer@jmail.com', 'JDEER', 'Jdeer@123'),
    ('JAMES', 'RODRIGUEZ', 'jrodriguez@jmail.com', 'JRODRI', 'Jrodri@123'),
    ('LIONEL', 'TURNER', 'lturner@jmail.com', 'LTURNER', 'Lturner@123'),
    ('CHRIS', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123'),
    ('ADAM', 'BLAKE', 'ablake@jmail.com', 'ABLAKE', 'Ablake@123'),
    ('ALLEN', 'LUGO', 'alugo@jmail.com', 'ALUGO', 'Alugo@123'),
    ('ROSS', 'MILLER', 'rmiller@jmail.com', 'RMILLER', 'Rmiller@123'),
    ('DAVID', 'AUSTIN', 'daustin@jmail.com', 'DAUSTIN', 'Daustin@123'),
    ('MAT', 'HENRY', 'mhenry@jmail.com', 'MHENRY', 'Mhenry@123'),
    ('RAVIN', 'PATEL', 'rpatel@jmail.com', 'RPATEL', 'Rpatel@123'),
    ('AAKASH', 'CHOTHANI', 'aakash@jmail.com', 'ACHOT', 'Aadmin@123' );


-- ADDRESS TABLE INSERT DATA
INSERT INTO ADDRESS 
    (STREET1, STREET2, CITY, COUNTY, STATE, ZIPCODE, COUNTRY) 
VALUES
    ('123 Main St', 'Apt 1A', 'Boston', 'Suffolk', 'Massachusetts', '02101', 'USA'),
    ('456 Elm St', NULL, 'Cambridge', 'Middlesex', 'Massachusetts', '02139', 'USA'),
    ('789 Maple Ave', 'Suite 3', 'Providence', 'Providence', 'Rhode Island', '02903', 'USA'),
    ('101 Oak St', NULL, 'Hartford', 'Hartford', 'Connecticut', '06106', 'USA'),
    ('202 Pine St', 'Apt 2B', 'Worcester', 'Worcester', 'Massachusetts', '01608', 'USA'),
    ('303 Cedar St', NULL, 'Springfield', 'Hampden', 'Massachusetts', '01103', 'USA'),
    ('404 Birch St', NULL, 'New Haven', 'New Haven', 'Connecticut', '06510', 'USA'),
    ('505 Walnut St', 'Apt 3C', 'Lowell', 'Middlesex', 'Massachusetts', '01852', 'USA'),
    ('408 Birch St', NULL, 'New Haven', 'New Haven', 'Connecticut', '06510', 'USA'),
    ('515 Apricot St', 'Apt 3C', 'Lowell', 'Middlesex', 'Massachusetts', '01852', 'USA');


INSERT INTO CANDIDATES 
    (USER_ID, ADD_ID, PHONE, AGE, GENDER, VETERAN, DISABILITY) 
VALUES
    (1, 1, '555-1234-321', 25, 'male', 'not a veteran', 'no, i do not have a disability'),
    (2, 2, '111-2345-678', 23, 'female', 'not a veteran', 'do not wish to disclose'),
    (3, 3, '857-3456-411', 26, 'male', 'do not wish to disclose', 'yes, I have a disability'),
    (4, 4, '980-4567-911', 25, 'female', 'not a veteran', 'no, i do not have a disability'),
    (5, 5, '555-5678-087', 44, 'male', 'I am a protected veteran', 'do not wish to disclose');


-- WORK_EXP TABLE INSERT DATA
INSERT INTO WORK_EXP 
    (CANDIDATE_ID, COMPANY_NAME, JOB_TITLE, START_DATE, END_DATE, DESCRIPTION) 
VALUES
    (1, 'Tech Solutions', 'Software Engineer', TO_TIMESTAMP('2019-06-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2022-05-31', 'YYYY-MM-DD'), 'Developed software solutions.'),
    (1, 'Web Innovators', 'Frontend Developer', TO_TIMESTAMP('2018-03-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2021-09-30', 'YYYY-MM-DD'), 'Created responsive web designs.'),
    (2, 'FinServe Inc.', 'Data Analyst', TO_TIMESTAMP('2020-01-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-01-01', 'YYYY-MM-DD'), 'Analyzed financial data.'),
    (2, 'BizCorp', 'Product Manager', TO_TIMESTAMP('2019-04-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-10-31', 'YYYY-MM-DD'), 'Managed product lifecycle.'),
    (2, 'AutoWorks', 'Quality Engineer', TO_TIMESTAMP('2018-11-05', 'YYYY-MM-DD'), NULL, 'Ensured product quality.'),
    (3, 'SmartTech', 'System Administrator', TO_TIMESTAMP('2019-05-10', 'YYYY-MM-DD'), NULL, 'Managed IT infrastructure.'),
    (3, 'HealthWorks', 'Project Coordinator', TO_TIMESTAMP('2016-01-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2019-06-30', 'YYYY-MM-DD'), 'Coordinated health projects and resources.'),
    (3, 'EcoEnergy', 'Environmental Consultant', TO_TIMESTAMP('2017-08-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2021-07-31', 'YYYY-MM-DD'), 'Advised on environmental impact and sustainability.'),
    (3, 'RetailHub', 'Sales Manager', TO_TIMESTAMP('2015-05-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2018-11-15', 'YYYY-MM-DD'), 'Managed sales operations and staff.'),
    (4, 'Urban Planning Co.', 'Urban Planner', TO_TIMESTAMP('1995-04-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2022-08-01', 'YYYY-MM-DD'), 'Designed urban planning projects.'),
    (5, 'DataCorp', 'Database Administrator', TO_TIMESTAMP('2019-09-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2022-06-01', 'YYYY-MM-DD'), 'Managed and optimized database systems.'),
    (5, 'TechVerse', 'IT Support Specialist', TO_TIMESTAMP('2021-02-01', 'YYYY-MM-DD'), NULL, 'Provided technical support and troubleshooting.');


-- EDUCATION TABLE INSERT DATA
INSERT INTO EDUCATION 
    (CANDIDATE_ID, UNIVERSITY_NAME, DEGREE, MAJOR, START_DATE, END_DATE, DEGREE_COMPLETED) 
VALUES
    (1, 'Boston University', 'BSc', 'Computer Science', TO_DATE('2015-09-01', 'YYYY-MM-DD'), TO_DATE('2019-05-01', 'YYYY-MM-DD'), 1),
    (1, 'University of California', 'MSc', 'Data Science', TO_DATE('2018-09-01', 'YYYY-MM-DD'), NULL, 0),
    (2, 'Harvard University', 'MBA', 'Business Administration', TO_DATE('2016-08-01', 'YYYY-MM-DD'), NULL, 0),
    (3, 'MIT', 'BEng', 'Mechanical Engineering', TO_DATE('2013-09-01', 'YYYY-MM-DD'), TO_DATE('2017-05-01', 'YYYY-MM-DD'), 1),
    (5, 'Stanford University', 'PhD', 'Data Science', TO_DATE('2015-09-01', 'YYYY-MM-DD'), NULL, 0),
    (3, 'University of Texas', 'BA', 'Accounting', TO_DATE('2014-09-01', 'YYYY-MM-DD'), NULL, 0),
    (2, 'University of Florida', 'BBA', 'Marketing', TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('2020-05-01', 'YYYY-MM-DD'), 1),
    (3, 'Georgia Tech', 'MEng', 'Civil Engineering', TO_DATE('2017-09-01', 'YYYY-MM-DD'), NULL, 0),
    (4, 'New York University', 'BSc', 'Information Technology', TO_DATE('2014-09-01', 'YYYY-MM-DD'), TO_DATE('2018-05-01', 'YYYY-MM-DD'), 1),
    (5, 'University of Chicago', 'MSc', 'Biology', TO_DATE('2018-09-01', 'YYYY-MM-DD'), NULL, 0);


-- RESUME TABLE INSERT DATA
INSERT INTO RESUME 
    (CANDIDATE_ID, RES_DOC, DESCRIPTION)
VALUES
    (1, EMPTY_BLOB(), 'Software Engineering Resume'),
    (2, EMPTY_BLOB(), 'Frontend Development Resume'),
    (3, EMPTY_BLOB(), 'Data Analysis Resume'),
    (4, EMPTY_BLOB(), 'Product Management Resume'),
    (5, EMPTY_BLOB(), 'Quality Engineering Resume');


-- SKILLS TABLE INSERT DATA
INSERT INTO SKILLS 
    (SKILL_NAME) 
VALUES
    ('Java'), 
    ('SQL'),
    ('Python'),
    ('Project Management'),
    ('Data Analysis'),
    ('Machine Learning'),
    ('Network Security'),
    ('Cloud Computing'),
    ('Marketing'),
    ('Financial Analysis'),
    ('Quality Management'),
    ('Product Management'),
    ('ERP'),
    ('Software Development');


-- CANDIDATE_SKILLS TABLE INSERT DATA
INSERT INTO CANDIDATE_SKILLS 
    (CANDIDATE_ID, SKILL_ID) 
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (4, 4),
    (5, 6),
    (3, 7),
    (4, 8),
    (3, 8);


-- COMPANIES TABLE INSERT DATA
INSERT INTO COMPANIES 
    (ADD_ID, NAME, EMAIL, PHONE) 
VALUES
    (1, 'Tech Solutions', 'contact@techsolutions.com', '5551234567'),
    (2, 'Innovate Inc', 'info@innovateinc.com', '5559876543'),
    (3, 'HealthCorp', 'hr@healthcorp.com', '5552345678'),
    (4, 'AutoWorks', 'contact@autoworks.com', '5558765432'),
    (5, 'DataDrive', 'support@datadrive.com', '5553456789'),
    (6, 'SoftBank', 'contact@softbank.com', '5554567890'),
    (7, 'MegaRetail', 'careers@megaretail.com', '5556543210'),
    (8, 'BuildIt', 'info@buildit.com', '5559876543'),
    (9, 'SkyNet', 'hr@skynet.com', '5551236540'),
    (10, 'BioLab', 'contact@biolab.com', '5554321098');


-- RECRUITERS TABLE INSERT DATA
INSERT INTO RECRUITERS 
    (USER_ID, COMPANY_ID) 
VALUES
    (6, 1),
    (7, 1),
    (8, 3),
    (9, 4),
    (10, 6),
    (11, 6);


-- JOB_REQUISITION TABLE INSERT DATA
INSERT INTO JOB_REQUISITION 
    (COMPANY_ID, RECRUITER_ID, JOB_TITLE, JOB_DESCRIPTION, APPLICATION_DEADLINE, 
EXPECTED_START_DATE, RELOCATION_ALLOWANCE, STATUS) 
VALUES
    (1, 1, 'Software Engineer', 'Develop and maintain software applications.', TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), 1, 'open'),
    (1, 2, 'Data Scientist', 'Analyze data and build predictive models.', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), 1, 'open'),
    (3, 3, 'Project Manager', 'Oversee healthcare projects.', TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), 0, 'open'),
    (4, 4, 'Mechanical Engineer', 'Design automotive parts and systems.', TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 0, 'open'),
    (6, 5, 'Data Analyst', 'Interpret data to improve decision-making.', TO_DATE('2024-03-15', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), 0, 'open'),
    (6, 6, 'Accountant', 'Manage financial records and budgeting.', TO_DATE('2024-03-25', 'YYYY-MM-DD'), TO_DATE('2024-05-05', 'YYYY-MM-DD'), 0, 'open'),
    (4, 1, 'Retail Manager', 'Oversee retail operations.', TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'), 1, 'open'),
    (3, 2, 'Construction Engineer', 'Manage construction projects.', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), 1, 'open'),
    (6, 3, 'Network Administrator', 'Manage and secure network infrastructure.', TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1, 'open'),
    (4, 4, 'Research Scientist', 'Conduct scientific research and analysis.', TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-05-15', 'YYYY-MM-DD'), 0, 'open');


-- CANDIDATE_APPLICATION TABLE INSERT DATA
INSERT INTO CANDIDATE_APPLICATION 
    (CANDIDATE_ID, REQ_ID, STATUS) 
VALUES
    (1, 1, 'submitted'),
    (2, 2, 'in review'),
    (3, 3, 'role offered'),
    (4, 4, 'submitted'),
    (5, 5, 'withdrawn'),
    (2, 6, 'submitted'),
    (2, 7, 'offer accepted');

commit;