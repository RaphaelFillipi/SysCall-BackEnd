 -- Garante que o nome seja maior que três caracteres 
 ALTER TABLE public.call_user 
 ADD CONSTRAINT 
 check_s_public_t_call_user_c_name
 CHECK (
    char_length(name)> 3
 );
 
 -- Garante que o sobrenome seja diferente do nome 
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