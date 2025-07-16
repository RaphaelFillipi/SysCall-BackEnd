-- Preenche o campo locale de forma automática com base no campo phone_number

CREATE OR REPLACE FUNCTION get_locale_by_phone(phone_number TEXT)
RETURNS TEXT AS $$
DECLARE
    ddd TEXT;
BEGIN
    ddd := SUBSTRING(phone_number FROM 1 FOR 2);

    CASE
        -- Região Sudeste
        WHEN ddd = '11' OR ddd = '12' OR ddd = '13' OR ddd = '14' OR ddd = '15' OR ddd = '16' OR ddd = '17' OR ddd = '18' OR ddd = '19' THEN RETURN 'SP';
        WHEN ddd = '21' OR ddd = '22' OR ddd = '24' THEN RETURN 'RJ';
        WHEN ddd = '27' OR ddd = '28' THEN RETURN 'ES';
        WHEN ddd = '31' OR ddd = '32' OR ddd = '33' OR ddd = '34' OR ddd = '35' OR ddd = '37' OR ddd = '38' THEN RETURN 'MG';

        -- Região Sul
        WHEN ddd = '41' OR ddd = '42' OR ddd = '43' OR ddd = '44' OR ddd = '45' OR ddd = '46' THEN RETURN 'PR';
        WHEN ddd = '47' OR ddd = '48' OR ddd = '49' THEN RETURN 'SC';
        WHEN ddd = '51' OR ddd = '53' OR ddd = '54' OR ddd = '55' THEN RETURN 'RS';

        -- Região Centro-Oeste
        WHEN ddd = '61' THEN RETURN 'DF';
        WHEN ddd = '62' OR ddd = '64' THEN RETURN 'GO';
        WHEN ddd = '65' OR ddd = '66' THEN RETURN 'MT';
        WHEN ddd = '67' THEN RETURN 'MS';

        -- Região Nordeste
        WHEN ddd = '71' OR ddd = '73' OR ddd = '74' OR ddd = '75' OR ddd = '77' THEN RETURN 'BA';
        WHEN ddd = '79' THEN RETURN 'SE';
        WHEN ddd = '81' OR ddd = '87' THEN RETURN 'PE';
        WHEN ddd = '82' THEN RETURN 'AL';
        WHEN ddd = '83' THEN RETURN 'PB';
        WHEN ddd = '84' THEN RETURN 'RN';
        WHEN ddd = '85' OR ddd = '88' THEN RETURN 'CE';
        WHEN ddd = '86' OR ddd = '89' THEN RETURN 'PI';
        WHEN ddd = '98' OR ddd = '99' THEN RETURN 'MA';

        -- Região Norte
        WHEN ddd = '92' OR ddd = '97' THEN RETURN 'AM';
        WHEN ddd = '91' OR ddd = '93' OR ddd = '94' THEN RETURN 'PA';
        WHEN ddd = '95' THEN RETURN 'RR';
        WHEN ddd = '96' THEN RETURN 'AP';
        WHEN ddd = '69' THEN RETURN 'RO';
        WHEN ddd = '68' THEN RETURN 'AC';
        WHEN ddd = '63' THEN RETURN 'TO';

        ELSE RETURN 'ND'; -- Não Definido ou inválido
    END CASE;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION set_default_locale()
RETURNS TRIGGER AS $$
BEGIN
    NEW.locale := get_locale_by_phone(NEW.phone_number);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_set_locale
BEFORE INSERT OR UPDATE ON auth.users
FOR EACH ROW
EXECUTE FUNCTION set_default_locale();


CREATE OR REPLACE FUNCTION sys_call.random_call_duration()
RETURNS INTERVAL AS $$
DECLARE
  call_status CHAR := sys_call.random_call_status();
  seconds INT;
BEGIN
  IF call_status = 'R' THEN
    RETURN INTERVAL '00:00:00';
  ELSE
    seconds := floor(random() * (600 - 10 + 1) + 10)::int;
    RETURN make_interval(secs => seconds);
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sys_call.random_call_status()
RETURNS CHAR AS $$
BEGIN
  RETURN CASE
    WHEN random() < 0.5 THEN 'A'
    ELSE 'R'
  END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION sys_call.set_random_status_and_duration()
RETURNS TRIGGER AS $$
DECLARE
  seconds INT;
BEGIN
  IF random() < 0.5 THEN
    NEW.status := 'A';
    seconds := floor(random() * (600 - 10 + 1) + 10)::int;
    NEW.duration := make_interval(secs => seconds);
  ELSE
    NEW.status := 'R';
    NEW.duration := INTERVAL '00:00:00';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_status_and_duration
BEFORE INSERT ON sys_call.call_history
FOR EACH ROW
WHEN (NEW.status IS NULL OR NEW.duration IS NULL)
EXECUTE FUNCTION sys_call.set_random_status_and_duration();