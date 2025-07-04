GRANT USAGE 
    ON SCHEMA sys_call 
    TO sys_reg_usr;

-- CALL_USER TABLE 

GRANT SELECT 
    (user_id, name, last_name, telephone, email, password, picture, possible_location)
    ON sys_call.call_user
    TO sys_reg_usr; 

GRANT UPDATE 
    (name, last_name, telephone, email, password, picture)
    ON sys_call.call_user
    TO sys_reg_usr;

GRANT DELETE
    ON sys_call.call_user
    TO sys_reg_usr;

-- CONTACT TABLE 

GRANT INSERT 
    (saved_name, saved_user, owner_user)
    ON sys_call.contact 
    TO sys_reg_usr;

GRANT SELECT 
    (id, saved_name, status, saved_user, owner_user)
    ON sys_call.contact
    TO sys_reg_usr;

GRANT UPDATE 
    (saved_name, status)
    ON sys_call.contact
    TO sys_reg_usr;

GRANT DELETE 
    ON sys_call.contact
    TO sys_reg_usr;

-- CALL_HISTORY TABLE

GRANT SELECT 
    (id, status, date, recived_user, requester_user)
    ON sys_call.call_history 
    TO sys_reg_usr;