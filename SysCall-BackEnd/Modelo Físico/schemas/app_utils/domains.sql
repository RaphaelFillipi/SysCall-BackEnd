 CREATE DOMAIN app_utils.domain_location AS CHAR(2);
 ALTER DOMAIN app_utils.domain_location
 ADD CONSTRAINT check_s_app_utils_d_domain_location
 CHECK (
  VALUE IN (
    'AC', 'AP', 'AM', 'PA', 'RO', 'RR', 'TO',
    'AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE',
    'DF', 'GO', 'MT', 'MS',
    'ES', 'MG', 'RJ', 'SP',
    'PR', 'RS', 'SC'
  )
 );