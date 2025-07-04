GRANT USAGE 
    ON SCHEMA sys_call 
    TO sys_usr;

-- CALL USER TABLE 

GRANT INSERT 
    (name, last_name, telephone, email, password, picture, possible_location)
    ON sys_call.call_user
    TO sys_usr;

GRANT SELECT 
    (email, password)
    ON sys_call.call_user
    TO sys_usr;