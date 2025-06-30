 --CHECK CONSTRAINTS DA TABELA call_user
 -- Garante que o nome seja maior que três caracteres 
 ALTER TABLE public.call_user 
 ADD CONSTRAINT 
 check_s_public_t_call_user_c_name
 CHECK (
    char_length(name)> 3
 );
 
 -- Garante que o sobrenome seja diferente do nome e que o sobrenome tenha no mínimo 2 caaracteres 
 ALTER TABLE public.call_user 
 ALTER CONSTRAINT 
 check_s_public_t_call_user_c_lastname
 CHECK (
    last_name IS DISTINCT FROM name AND char_length(name) > 2
 );
 
 -- Garante que os dois primeiros digitos do telefone serão um DDD válido no Brasil
 ALTER TABLE public.call_user 
 ADD CONSTRAINT 
 check_s_public_t_call_user_c_telephone 
 CHECK (
    left(telephone, 2) IN  (
    '11','12','13','14','15','16','17','18','19',
    '21','22','24',
    '27','28',
    '31','32','33','34','35','37','38',
    '41','42','43','44','45','46',
    '47','48','49',
    '51','53','54','55',
    '61',
    '62','64',
    '63',
    '65','66',
    '67',
    '68',
    '69',
    '71','73','74','75','77',
    '79',
    '81','87',
    '82',
    '83',
    '84',
    '85','88',
    '86','89',
    '91','92','93','94','95','96','97','98','99')
 );
 
 -- Garante que o email sera gmail, outlook, baymetrics ou yahoo
 ALTER TABLE public.call_user 
 ADD CONSTRAINT 
 check_s_public_t_call_user_c_email
 CHECK (
    email SIMILAR TO '%@(gmail.com|yahoo.com|outlook.com|baymetrics.com)%'
 );

 -- Garante que a senha tenha no mínimo 12 caracteres, tenha pelo menos 1 letra minúscula, pelo menos 1 maiúsucula, se contém pelo menos 1 número e no mínimo 1 caractere especial

 ALTER TABLE public.call_user
 ADD CONSTRAINT
 check_s_public_t_call_user_c_password
 CHECK(
   LENGTH(password) >= 12  AND
        password ~ '[A-Z]' AND               
        password ~ '[a-z]' AND               
        password ~ '[0-9]' AND               
        password ~ '[!@#\$%\^&\*\(\)]'  
);

-- CHECK CONSTRAINTS DA TABELA contact

-- Garante que o status seja U ou B (Unblocked ou Blocked)
ALTER TABLE public.contact 
ADD CONSTRAINT check_s_public_t_contact_c_status
CHECK(
   status IN ('U', 'B') 
);

-- CHECK CONSTRAINTS DA TABELA call_history 
ALTER TABLE public.call_history 
ADD CONSTRAINT check_s_public_t_call_history_c_status
CHECK(
   status IN ('A', 'R')
);