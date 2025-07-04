GRANT CREATE 
    ON SCHEMA sys_call
    TO sys_reg_usr;

-- VER PERFIL (CALL_USER TABLE)

SET ROLE sys_reg_usr;
CREATE OR REPLACE FUNCTION 
sys_call.function_select_all_t_call_user_r_sys_reg_usr(id INTEGER)
RETURNS TABLE(user_id INTEGER, name VARCHAR(16), last_name VARCHAR(64), telephone VARCHAR(20), email VARCHAR(32), password VARCHAR(128)) AS $$
BEGIN 
    RETURN QUERY 
    SELECT 
        sys_call.user_id, sys_call.name, sys_call.last_name, sys_call.telephone, sys_call.email, sys_call.password
        FROM sys_call.call_user sys_call
        WHERE sys_call.user_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;
RESET ROLE;

-- EDITAR PERFIL (CALL_USER TABLE)

CREATE OR REPLACE VIEW sys_call.view_update_t_call_user_r_sys_reg_usr AS
SELECT user_id, name, last_name, telephone, email, password 
FROM sys_call.call_user;

CREATE OR REPLACE FUNCTION 
sys_call.view_update_function_t_call_user_r_sys_reg_usr()
RETURNS TRIGGER AS $$ 
BEGIN 
    UPDATE sys_call.call_user
        SET name = COALESCE(NEW.name, name),
            last_name = COALESCE(NEW.last_name, last_name),
            email = COALESCE(NEW.email, email),
            telephone = COALESCE(NEW.telephone, telephone),
            password = COALESCE(NEW.password, password)
        WHERE user_id = OLD.user_id;

		RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

CREATE OR REPLACE TRIGGER 
view_update_trigger_t_call_user_r_sys_reg_usr
INSTEAD OF UPDATE ON sys_call.view_update_t_call_user_r_sys_reg_usr
FOR EACH ROW
EXECUTE FUNCTION sys_call.view_update_function_t_call_user_r_sys_reg_usr;




REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;


