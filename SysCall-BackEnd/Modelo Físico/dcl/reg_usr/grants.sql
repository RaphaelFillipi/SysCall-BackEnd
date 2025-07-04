GRANT USAGE 
    ON SCHEMA sys_call 
    TO reg_usr;

GRANT EXECUTE 
ON FUNCTION sys_call.view_update_function_t_call_user_r_sys_reg_usr() 
TO reg_usr;

GRANT UPDATE 
ON sys_call.view_update_t_call_user_r_sys_reg_usr 
TO reg_usr;

GRANT SELECT 
ON sys_call.view_update_t_call_user_r_sys_reg_usr
TO reg_usr;