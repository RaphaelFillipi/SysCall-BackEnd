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
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;


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
EXECUTE FUNCTION sys_call.view_update_function_t_call_user_r_sys_reg_usr();

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;

-- DELETAR PERFIL 
SET ROLE sys_reg_usr;

CREATE OR REPLACE PROCEDURE 
sys_call.procedure_delete_t_call_user_r_sys_reg_usr(id INTEGER) AS $$
BEGIN 
    DELETE FROM sys_call.call_user
    WHERE user_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;

-- =========== CONTACT TABLE ===========

-- ADICIONAR CONTATO

CREATE OR REPLACE VIEW sys_call.view_insert_t_contact_r_sys_reg_usr AS 
SELECT saved_name, saved_user, owner_user
FROM sys_call.contact;

SET ROLE sys_reg_usr;
CREATE OR REPLACE FUNCTION 
sys_call.view_insert_function_t_contact_r_sys_reg_usr()
RETURNS trigger AS $$
BEGIN 
    INSERT INTO sys_call.contact (saved_name, saved_user, owner_user) 
    VALUES (NEW.saved_name, NEW.saved_user, NEW.owner_user);
    RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;
RESET ROLE;

CREATE OR REPLACE TRIGGER view_insert_trigger_t_contact_r_sys_reg_usr
INSTEAD OF INSERT ON sys_call.view_insert_t_contact_r_sys_reg_usr
FOR EACH ROW
EXECUTE FUNCTION sys_call.view_insert_function_t_contact_r_sys_reg_usr();

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;

-- VER CONTATO 
SET ROLE sys_reg_usr;
CREATE OR REPLACE FUNCTION 
sys_call.function_select_t_contact_r_sys_reg_usr(contact_id INTEGER)
RETURNS TABLE(id INTEGER, saved_name VARCHAR(32), saved_user INTEGER, owner_user INTEGER) AS $$
BEGIN 
    RETURN QUERY 
    SELECT 
        sys_call.id, sys_call.saved_name, sys_call.saved_user, sys_call.owner_user
    FROM sys_call.contact sys_call
    WHERE sys_call.id = contact_id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;


-- EDITAR CONTATO

CREATE OR REPLACE VIEW sys_call.view_update_t_contact_r_sys_reg_usr AS
SELECT id, saved_name, status 
FROM sys_call.contact;

CREATE OR REPLACE FUNCTION 
sys_call.view_update_function_t_contact_r_sys_reg_usr()
RETURNS TRIGGER AS $$ 
BEGIN 
    UPDATE sys_call.contact
        SET saved_name = COALESCE(NEW.saved_name, saved_name),
            status = COALESCE(NEW.status, status),
        WHERE id = OLD.id;

		RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

CREATE OR REPLACE TRIGGER 
view_update_trigger_t_contact_r_sys_reg_usr
INSTEAD OF UPDATE ON sys_call.view_update_t_contact_r_sys_reg_usr
FOR EACH ROW
EXECUTE FUNCTION sys_call.view_update_function_t_contact_r_sys_reg_usr();

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;

-- DELETAR CONTATO

CREATE OR REPLACE PROCEDURE 
sys_call.procedure_delete_t_contact_r_sys_reg_usr(contact_id INTEGER) AS $$
BEGIN 
    DELETE FROM sys_call.contact
    WHERE id = contact_id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;

-- =========== CALL_HISTORY TABLE ===========

-- Inserir registro no historico de chamadas

CREATE OR REPLACE TRIGGER view_insert_trigger_t_call_history_r_sys_reg_usr
INSTEAD OF INSERT ON sys_call.view_insert_t_call_history_r_sys_reg_usr
FOR EACH ROW
EXECUTE FUNCTION sys_call.view_insert_function_t_call_history_r_sys_reg_usr();

-- Ver registros no historico de chamadas 

SET ROLE sys_reg_usr;
CREATE OR REPLACE FUNCTION 
sys_call.function_select_t_call_history_r_sys_reg_usr(contact_id INTEGER)
RETURNS TABLE(id INTEGER, status VARCHAR(2), date TIMESTAMP, duration INTERVAL, recived_user UUID, requester_user UUID) AS $$
BEGIN 
    RETURN QUERY 
    SELECT 
        sys_call.id, sys_call.status, sys_call.date, sys_call.duration, sys_call.recived_user, sys_call.requester_user
    FROM sys_call.contact sys_call
    WHERE sys_call.id = contact_id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sys_call, pg_temp;

RESET ROLE;
REVOKE CREATE 
    ON SCHEMA sys_call
    FROM sys_reg_usr;
