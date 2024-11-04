-- USERS table sample data
INSERT INTO USERS (FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD, IS_ACTIVE) 
VALUES
('JOHN', 'DEER', 'jdeer@jmail.com', 'JDEER', 'Jdeer@123', TRUE),
('JAMES', 'RODRIGUEZ', 'jrodriguez@jmail.com', 'JRODRI', 'Jrodri@123', TRUE),
('LIONEL', 'TURNER', 'lturner@jmail.com', 'LTURNER', 'Lturner@123', TRUE),
('CHRIS', 'JONES', 'cjones@jmail.com', 'CJONES', 'Cjones@123', TRUE),
('ADAM', 'BLAKE', 'ablake@jmail.com', 'ABLAKE', 'Ablake@123', TRUE),
('ALLEN', 'LUGO', 'alugo@jmail.com', 'ALUGO', 'Alugo@123', TRUE),
('ROSS', 'MILLER', 'rmiller@jmail.com', 'RMILLER', 'Rmiller@123', TRUE),
('DAVID', 'AUSTIN', 'daustin@jmail.com', 'DAUSTIN', 'Daustin@123', TRUE),
('MAT', 'HENRY', 'mhenry@jmail.com', 'MHENRY', 'Mhenry@123', TRUE),
('RAVIN', 'PATEL', 'rpatel@jmail.com', 'RPATEL', 'Rpatel@123', TRUE);

-- ADDRESS table sample data
INSERT INTO ADDRESS (STREET1, CITY, COUNTY, STATE, ZIPCODE, COUNTRY) VALUES
('123 Main St', 'Boston', 'Suffolk', 'MA', '02118', 'USA'),
('456 Elm St', 'San Francisco', 'San Francisco', 'CA', '94102', 'USA'),
('789 Oak St', 'New York', 'New York', 'NY', '10001', 'USA'),
('101 Maple St', 'Seattle', 'King', 'WA', '98101', 'USA'),
('202 Pine St', 'Chicago', 'Cook', 'IL', '60601', 'USA'),
('303 Cedar St', 'Miami', 'Miami-Dade', 'FL', '33101', 'USA'),
('404 Birch St', 'Denver', 'Denver', 'CO', '80201', 'USA'),
('505 Spruce St', 'Austin', 'Travis', 'TX', '73301', 'USA'),
('606 Walnut St', 'Los Angeles', 'Los Angeles', 'CA', '90001', 'USA'),
('707 Willow St', 'Phoenix', 'Maricopa', 'AZ', '85001', 'USA');

-- CANDIDATES table sample data
INSERT INTO CANDIDATES (USER_ID, ADD_ID, PHONE, AGE, GENDER, VETERAN, DISABILITY, DATE_OF_JOIN) VALUES
(1, 1, '1234567890', 30, 'male', 'not a veteran', 'no, I do not have a disability', TO_DATE('2022-01-15', 'YYYY-MM-DD')),
(2, 2, '0987654321', 28, 'female', 'protected veteran', 'do not want to share', TO_DATE('2023-03-20', 'YYYY-MM-DD')),
(3, 3, '5551234567', 32, 'male', 'not a veteran', 'yes, I have a disability', TO_DATE('2022-05-10', 'YYYY-MM-DD')),
(4, 4, '5557654321', 26, 'female', 'not a veteran', 'no, I do not have a disability', TO_DATE('2023-06-15', 'YYYY-MM-DD')),
(5, 5, '5552345678', 29, 'male', 'do not want to share', 'no, I do not have a disability', TO_DATE('2023-01-01', 'YYYY-MM-DD')),
(6, 6, '5558765432', 31, 'female', 'not a veteran', 'do not want to share', TO_DATE('2022-11-25', 'YYYY-MM-DD')),
(7, 7, '5553456789', 27, 'male', 'protected veteran', 'yes, I have a disability', TO_DATE('2023-07-10', 'YYYY-MM-DD')),
(8, 8, '5559876543', 33, 'female', 'not a veteran', 'no, I do not have a disability', TO_DATE('2023-09-15', 'YYYY-MM-DD')),
(9, 9, '5554567890', 24, 'male', 'do not want to share', 'no, I do not have a disability', TO_DATE('2022-12-20', 'YYYY-MM-DD')),
(10, 10, '5556543210', 30, 'female', 'not a veteran', 'do not want to share', TO_DATE('2023-02-28', 'YYYY-MM-DD'));

-- WORK_EXP table sample data
INSERT INTO WORK_EXP (CANDIDATE_ID, COMPANY_NAME, JOB_TITLE, START_DATE, END_DATE, DESCRIPTION) VALUES
(1, 'Tech Solutions', 'Software Engineer', TO_DATE('2019-06-01', 'YYYY-MM-DD'), TO_DATE('2021-12-31', 'YYYY-MM-DD'), 'Developed software solutions for clients.'),
(2, 'Innovate Inc', 'Data Analyst', TO_DATE('2020-01-01', 'YYYY-MM-DD'), NULL, 'Analyzed data trends for business growth.'),
(3, 'HealthCorp', 'Project Manager', TO_DATE('2018-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Managed healthcare projects.'),
(4, 'AutoWorks', 'Mechanical Engineer', TO_DATE('2017-03-15', 'YYYY-MM-DD'), TO_DATE('2020-08-15', 'YYYY-MM-DD'), 'Designed automotive parts.'),
(5, 'DataDrive', 'Data Scientist', TO_DATE('2019-05-01', 'YYYY-MM-DD'), NULL, 'Developed machine learning models.'),
(6, 'SoftBank', 'Accountant', TO_DATE('2021-01-10', 'YYYY-MM-DD'), NULL, 'Managed financial records.'),
(7, 'MegaRetail', 'Retail Manager', TO_DATE('2019-07-20', 'YYYY-MM-DD'), TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'Oversaw retail operations.'),
(8, 'BuildIt', 'Construction Engineer', TO_DATE('2021-02-05', 'YYYY-MM-DD'), NULL, 'Led construction projects.'),
(9, 'SkyNet', 'Network Administrator', TO_DATE('2018-10-10', 'YYYY-MM-DD'), TO_DATE('2021-10-10', 'YYYY-MM-DD'), 'Managed network infrastructure.'),
(10, 'BioLab', 'Research Scientist', TO_DATE('2020-12-01', 'YYYY-MM-DD'), NULL, 'Conducted scientific research.');

-- EDUCATION table sample data
INSERT INTO EDUCATION (CANDIDATE_ID, UNIVERSITY_NAME, DEGREE, MAJOR, START_DATE, END_DATE, DEGREE_COMPLETED) VALUES
(1, 'Boston University', 'BSc', 'Computer Science', TO_DATE('2015-09-01', 'YYYY-MM-DD'), TO_DATE('2019-05-01', 'YYYY-MM-DD'), TRUE),
(2, 'University of California', 'MSc', 'Data Science', TO_DATE('2018-09-01', 'YYYY-MM-DD'), TO_DATE('2020-06-01', 'YYYY-MM-DD'), TRUE),
(3, 'Harvard University', 'MBA', 'Business Administration', TO_DATE('2016-08-01', 'YYYY-MM-DD'), TO_DATE('2018-06-01', 'YYYY-MM-DD'), TRUE),
(4, 'MIT', 'BEng', 'Mechanical Engineering', TO_DATE('2013-09-01', 'YYYY-MM-DD'), TO_DATE('2017-05-01', 'YYYY-MM-DD'), TRUE),
(5, 'Stanford University', 'PhD', 'Data Science', TO_DATE('2015-09-01', 'YYYY-MM-DD'), NULL, FALSE),
(6, 'University of Texas', 'BA', 'Accounting', TO_DATE('2014-09-01', 'YYYY-MM-DD'), TO_DATE('2018-05-01', 'YYYY-MM-DD'), TRUE),
(7, 'University of Florida', 'BBA', 'Marketing', TO_DATE('2016-09-01', 'YYYY-MM-DD'), TO_DATE('2020-05-01', 'YYYY-MM-DD'), TRUE),
(8, 'Georgia Tech', 'MEng', 'Civil Engineering', TO_DATE('2017-09-01', 'YYYY-MM-DD'), TO_DATE('2019-05-01', 'YYYY-MM-DD'), TRUE),
(9, 'New York University', 'BSc', 'Information Technology', TO_DATE('2014-09-01', 'YYYY-MM-DD'), TO_DATE('2018-05-01', 'YYYY-MM-DD'), TRUE),
(10, 'University of Chicago', 'MSc', 'Biology', TO_DATE('2018-09-01', 'YYYY-MM-DD'), TO_DATE('2020-06-01', 'YYYY-MM-DD'), TRUE);

-- SKILLS table sample data
INSERT INTO SKILLS (SKILL_NAME) VALUES
('Java'), 
('SQL'),
('Python'),
('Project Management'),
('Data Analysis'),
('Machine Learning'),
('Network Security'),
('Cloud Computing'),
('Marketing'),
('Financial Analysis');

-- CANDIDATE_SKILLS table sample data
INSERT INTO CANDIDATE_SKILLS (CANDIDATE_ID, SKILL_ID) VALUES
(1, 1), (1, 2), (1, 3), 
(2, 4), (2, 5), 
(3, 6), (3, 7), 
(4, 8), 
(5, 9), 
(6, 10);

-- COMPANIES table sample data
INSERT INTO COMPANIES (ADD_ID, NAME, EMAIL, PHONE, IS_ACTIVE) VALUES
(1, 'Tech Solutions', 'contact@techsolutions.com', '5551234567', TRUE),
(2, 'Innovate Inc', 'info@innovateinc.com', '5559876543', TRUE),
(3, 'HealthCorp', 'hr@healthcorp.com', '5552345678', TRUE),
(4, 'AutoWorks', 'contact@autoworks.com', '5558765432', TRUE),
(5, 'DataDrive', 'support@datadrive.com', '5553456789', TRUE),
(6, 'SoftBank', 'contact@softbank.com', '5554567890', TRUE),
(7, 'MegaRetail', 'careers@megaretail.com', '5556543210', TRUE),
(8, 'BuildIt', 'info@buildit.com', '5559876543', TRUE),
(9, 'SkyNet', 'hr@skynet.com', '5551236540', TRUE),
(10, 'BioLab', 'contact@biolab.com', '5554321098', TRUE);

-- RECRUITERS table sample data
INSERT INTO RECRUITERS (USER_ID, COMPANY_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- JOB_REQUISITION table sample data
INSERT INTO JOB_REQUISITION (COMPANY_ID, RECRUITER_ID, JOB_TITLE, JOB_DESCRIPTION, DATE_POSTED, APPLICATION_DEADLINE, EXPECTED_START_DATE, RELOCATION_ALLOWANCE, STATUS) VALUES
(1, 1, 'Software Engineer', 'Develop and maintain software applications.', TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), TRUE, 'open'),
(2, 2, 'Data Scientist', 'Analyze data and build predictive models.', TO_DATE('2024-01-20', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), FALSE, 'open'),
(3, 3, 'Project Manager', 'Oversee healthcare projects.', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), TRUE, 'open'),
(4, 4, 'Mechanical Engineer', 'Design automotive parts and systems.', TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), FALSE, 'open'),
(5, 5, 'Data Analyst', 'Interpret data to improve decision-making.', TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-03-15', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), TRUE, 'open'),
(6, 6, 'Accountant', 'Manage financial records and budgeting.', TO_DATE('2024-02-05', 'YYYY-MM-DD'), TO_DATE('2024-03-25', 'YYYY-MM-DD'), TO_DATE('2024-05-05', 'YYYY-MM-DD'), FALSE, 'open'),
(7, 7, 'Retail Manager', 'Oversee retail operations.', TO_DATE('2024-01-25', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'), TRUE, 'open'),
(8, 8, 'Construction Engineer', 'Manage construction projects.', TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), FALSE, 'open'),
(9, 9, 'Network Administrator', 'Manage and secure network infrastructure.', TO_DATE('2024-01-30', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), TRUE, 'open'),
(10, 10, 'Research Scientist', 'Conduct scientific research and analysis.', TO_DATE('2024-02-18', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-05-15', 'YYYY-MM-DD'), FALSE, 'open');

-- CANDIDATE_APPLICATION table sample data
INSERT INTO CANDIDATE_APPLICATION (CANDIDATE_ID, REQ_ID, STATUS, WILLING_TO_RELOCATE) VALUES
(1, 1, 'submitted', TRUE),
(2, 2, 'in review', FALSE),
(3, 3, 'role offered', TRUE),
(4, 4, 'submitted', FALSE),
(5, 5, 'withdrawn', TRUE),
(6, 6, 'submitted', FALSE),
(7, 7, 'offer accepted', TRUE),
(8, 8, 'candidate rejected', FALSE),
(9, 9, 'in review', TRUE),
(10, 10, 'submitted', TRUE);

COMMIT;

