GRANT USAGE 
    ON SCHEMA sys_call 
    TO reg_usr;

GRANT EXECUTE 
	ON FUNCTION sys_call.function_select_all_t_call_user_r_sys_reg_usr(contact_id INTEGER)
	TO usr;

GRANT EXECUTE 
    ON FUNCTION sys_call.view_update_function_t_call_user_r_sys_reg_usr() 
    TO reg_usr;

GRANT UPDATE 
    ON sys_call.view_update_t_call_user_r_sys_reg_usr 
    TO reg_usr;

GRANT SELECT 
    ON sys_call.view_update_t_call_user_r_sys_reg_usr
    TO reg_usr;

GRANT EXECUTE 
	ON PROCEDURE sys_call.procedure_delete_t_call_user_r_sys_reg_usr(INTEGER)
	TO reg_usr;

GRANT EXECUTE
	ON FUNCTION sys_call.view_insert_function_t_contact_r_sys_reg_usr()
	TO reg_usr;
	
GRANT INSERT 
	ON sys_call.view_insert_t_contact_r_sys_reg_usr
	TO reg_usr;

GRANT EXECUTE 
	ON FUNCTION sys_call.function_select_t_contact_r_sys_reg_usr(contact_id INTEGER)
	TO usr;

GRANT EXECUTE 
    ON FUNCTION sys_call.view_update_function_t_contact_r_sys_reg_usr() 
    TO reg_usr;

GRANT UPDATE 
    ON sys_call.view_update_t_contact_r_sys_reg_usr 
    TO reg_usr;

GRANT SELECT 
    ON sys_call.view_update_t_contact_r_sys_reg_usr
    TO reg_usr;

GRANT EXECUTE 
	ON PROCEDURE sys_call.procedure_delete_t_contact_r_sys_reg_usr(INTEGER) 
	TO reg_usr;