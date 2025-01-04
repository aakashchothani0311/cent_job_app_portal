## Centralized Job Application Portal:
This project was built to complete the requirements of "DAMG6210 Database Management & Database Design" course which I took at Northeastern University as part of my Master's degree.

This OracleDB based project simplifies the job application process by creating a centralized platform where candidates can enter their details once and apply to multiple jobs seamlessly. It eliminates redundancy for job seekers and provides recruiters with consistent, accurate data. 

#### ER Diagram:

<kbd>![jobAppTracker](https://github.com/user-attachments/assets/71d4911b-e423-443b-99cc-4cacb278b36c)</kbd>

## Steps to Run the Script files:

1. Run the 'admin_super_user_creation.sql' from the pre_setup_scripts folder using the Oracle Database Admin user. This will create the portal's admin user. All the subsequent scripts will be run under this user.

2. Once the 'ADMIN_SUPER_USER' is created, create a connection using the wallet.

3. Run the below scripts in the following order:
    1. pre_setup_scripts folder
        - main_script.sql
        - insert_script.sql
        - view.sql
        
    2. packages folder
        - pkg_util.sql
        - pkg_address_mgmt.sql
        - pkg_user_mgmt.sql
        - pkg_recruiter_mgmt.sql
        - pkg_job_req_mgmt.sql
        - pkg_can_app_mgmt.sql
        - pkg_candidate_mgmt.sql
    
    3. post_setup folder
        - can_rec_users_creation
    
    4. Run the below test script files as needed.
        - pkg_recruiter_mgmt_test.sql
        - pkg_job_req_mgmt_test.sql
        - pkg_candidate_mgmt_test.sql
        - pkg_can_app_mgmt_test.sql
        - views_test.sql

## Note:
In case if the scripts need to be re-run, please run the scripts in the above specified order. The script - 'admin_super_user_creation.sql' needs to be run only once at the start.


