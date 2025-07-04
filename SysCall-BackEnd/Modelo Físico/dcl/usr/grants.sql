GRANT USAGE 
    ON SCHEMA sys_call
    TO usr;

GRANT EXECUTE 
    ON FUNCTION sys_call.view_insert_function_t_call_user_r_sys_usr()
    TO usr;

GRANT INSERT
    ON sys_call.view_insert_t_call_user_r_sys_usr 
    TO usr;

GRANT EXECUTE 
    ON FUNCTION sys_call.function_login_t_call_user_r_sys_usr(VARCHAR(32))
    TO usr;