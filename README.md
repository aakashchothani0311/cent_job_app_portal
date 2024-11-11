# team12_damg6210_project

## Steps to Run the Script files:

1. Run the 'admin_super_user_creation.sql' using the Oracle Database Admin user. This will create the portal's admin user. All the subsequent scripts will be run under this user.

2. Once the 'ADMIN_SUPER_USER' is created, create a connection using the wallet.

3. Run the below scripts in the following order:
- main_script.sql
- insert_script.sql
- view.sql
- can_rec_users_creation.sql

## Note
- In case if the scripts need to be re-run, please run main_script.sql, insert_script.sql, view.sql and can_rec_users_creation.sql in the above sequence. The script - 'admin_super_user_creation.sql' needs to be run only once at the start.