DROP IF EXISTS SCHEMA sys_call;
CREATE SCHEMA sys_call;


  -- CRIANDO TABELA DO USUÁRIO 

CREATE TABLE sys_call.call_user(
  -- Chaves primárias
  user_id INTEGER GENERATED ALWAYS AS IDENTITY,
 
  -- Dados do usuário
  name      VARCHAR(16)  NOT NULL,
  last_name VARCHAR(64)  NOT NULL,
  telephone VARCHAR(20)  NOT NULL, 
  email     VARCHAR(32)  NOT NULL, 
  password  VARCHAR(128) NOT NULL, 
  picture   TEXT,
  possible_location app_utils.DOMAIN_LOCATION, 
 
  -- Declaração de chaves primárias 
  CONSTRAINT pk_s_auth_t_user PRIMARY KEY (user_id),
 
  -- Declaração de chaves únicas 
  CONSTRAINT uq_s_sys_call_t_call_user_c_telephone UNIQUE (telephone),
  CONSTRAINT uq_s_sys_call_t_call_user_c_email     UNIQUE (email), 
 
  -- Declaração de chaves únicas compostas 
  CONSTRAINT cuq_s_sys_call_t_call_user_c_email    UNIQUE (user_id, picture)
 
 );

 -- CRIANDO TABELA DE CONTATOS

  CREATE TABLE sys_call.contact(
  -- Chaves primárias 
  id INTEGER GENERATED ALWAYS AS IDENTITY, 
  
  -- Dados do contato 
  saved_name VARCHAR(32) NOT NULL, 
  status     CHAR(1)     DEFAULT 'U' ,
                          
  -- Chaves estrangeiras 
  saved_user INTEGER     NOT NULL,
  owner_user INTEGER     NOT NULL,
  
  -- Declaração das chaves primárias 
  CONSTRAINT s_sys_call_t_contact PRIMARY KEY (id),
  
  -- Declaração de chaves estrangeiras 
  CONSTRAINT fk_s_sys_call_t_call_user_c_saved_user
    FOREIGN KEY (saved_user)
    REFERENCES sys_call.call_user(user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT, 
    
  CONSTRAINT fk_s_sys_call_t_call_user_c_owner_user
    FOREIGN KEY (owner_user)
    REFERENCES sys_call.call_user(user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
 );


-- CRIANDO A TABELA DE HISTORICO DE CONTATOS 

 CREATE TABLE sys_call.call_history(
 -- Chaves primárias
 id INTEGER GENERATED ALWAYS AS IDENTITY,
 
 -- Dados do histórico de chamada
 status CHAR(1) NOT NULL, 
 date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 
 -- Chaves estrangeiras
 recived_user   INTEGER NOT NULL,
 requester_user INTEGER NOT NULL,
 
 -- Declaração das chaves primárias 
 CONSTRAINT s_sys_call_t_call_history PRIMARY KEY (id),
 
 -- Declaração das chaves estrangeiras 
 CONSTRAINT fk_s_sys_call_t_call_history_c_recived_user
    FOREIGN KEY (recived_user)
    REFERENCES sys_call.call_user(user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,
 
 CONSTRAINT fk_s_sys_call_t_call_history_c_requester_user
    FOREIGN KEY (requester_user)
    REFERENCES sys_call.call_user(user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
 );

 -- Declaração de chave unica composta
 ALTER TABLE sys_call.contact 
    ADD CONSTRAINT cuq_s_sys_call_t_contact_c_owner_user_saved_user
    UNIQUE (owner_user, saved_user);
