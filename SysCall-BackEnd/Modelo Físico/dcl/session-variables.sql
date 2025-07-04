CREATE OR REPLACE FUNCTION 
sys_call.set_session_variable_email(email VARCHAR(32))
RETURNS VOID AS $$
BEGIN 
    PERFORM set_config('call_user.email', email);
END;
$$
LANGUAGE plpgsql
SECURITY INVOKER 
SET search_path = sys_call, pg_temp;

CREATE OR REPLACE FUNCTION 
sys_call.get_session_variable_email()
RETURNS TEXT AS $$ 
BEGIN 
    RETURN current_settings('call_user.email');
END;
$$ 
LANGUAGE plpgsql 
SECURITY INVOKER 
SET search_path = sys_call, pg_temp;