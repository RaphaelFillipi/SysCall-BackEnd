GRANT CREATE 
    ON SCHEMA sys_call
    TO sys_usr;

-- CADASTRO

CREATE OR REPLACE VIEW sys_call.view_insert_t_call_user_r_sys_usr AS 
SELECT name, last_name, telephone, email, password 
FROM sys_call.call_user;

SET ROLE sys_usr;
CREATE OR REPLACE FUNCTION 
sys_call.view_insert_function_t_call_user_r_sys_usr()
RETURNS trigger AS $$
BEGIN 
    INSERT INTO sys_call.call_user (name, last_name, telephone, email, password) 
    VALUES (NEW.name, NEW.last_name, NEW.telephone, NEW.email, NEW.password);
    RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;
RESET ROLE;

CREATE OR REPLACE TRIGGER view_insert_trigger_t_call_user_r_sys_usr
INSTEAD OF INSERT ON sys_call.view_insert_t_call_user_r_sys_usr
FOR EACH ROW
EXECUTE FUNCTION sys_call.view_insert_function_t_call_user_r_sys_usr;


SET ROLE sys_usr;
-- CREATE OR REPLACE FUNCTION 
-- sys_call.function_login_t_call_user_r_sys_usr()
-- RETURNS TABLE(email VARCHAR(32), password VARCHAR(128)) AS $$
-- BEGIN 
--     RETURN QUERY 
--     SELECT 
--         sys_call.email, sys_call.password
--         FROM sys_call.call_user sys_call
--         WHERE sys_call.email = sys_call.get_session_variable_email()
--         LIMIT 1;
-- END;
-- $$
-- LANGUAGE plpgsql
-- SECURITY DEFINER
-- SET search_path = sys_call, pg_temp;
-- RESET ROLE;
-- (Função que realiza o login por meio de variáveis de função acima)

-- LOGIN 

CREATE OR REPLACE FUNCTION 
sys_call.function_login_t_call_user_r_sys_usr(usr_email VARCHAR(32))
RETURNS TABLE(email VARCHAR(32), password VARCHAR(128)) AS $$
BEGIN 
    RETURN QUERY 
    SELECT 
        sys_call.email, sys_call.password
        FROM sys_call.call_user sys_call
        WHERE sys_call.email = usr_email;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_usr;