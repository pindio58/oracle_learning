/*
This is the documentation fro the application design wich will note down the steps fro creating and codumneting each and every step without fail
    1) About the application
    2) Creating Schema for the application
        *   total five schemas:
                a)  app_data
                b)  app_code
                c)  app_admin
                d)  app_user
                e)  app_admin_user
        
        *   Created Stored Procedure sp_create_schema
    
    3)  Granting privileges
        *   Granting Privileges to the APP_DATA Schema only the privileges to do the following:
                Connect to Oracle Database:
                Create the tables, views, triggers, and sequences for the application:
                Load data from four tables in the sample schema HR into its own tables:
        *   Granting Privileges to the app_code Schema only the privileges to do the following:
                Connect to Oracle Database:
                Create the package employees_pkg:   
                Create synonyms (for convenience):
        *   Granting Privileges to the app_admin Schema only the privileges to do the following:
                Connect to Oracle Database:
                Create the package admin_pkg:
                Create synonyms (for convenience)
        *   Granting Privileges to the app_user and app_admin_user Schemas only the privileges to do the following:
                Connect to Oracle Database:
                Create synonyms (for convenience):
    
    4)  Creating the Schema Objects and Loading the Data
        *   This section shows how to create the tables, editioning views, triggers, and sequences for the application, how to load data into the tables, and how to 
                grant privileges on these schema objects to the users that need them.

        *   To create the schema objects and load the data:
                Connect to Oracle Database as user app_data.
                create the tables, with all necessary constraints except the foreign key constraint that you must add after you load the data.
                Create the editioning views.
                Create the triggers.
                Create the sequences.
                Load the data into the tables.
                Add the foreign key constraint.
                
        *   Create the view
        *   Create the triggers


*/
