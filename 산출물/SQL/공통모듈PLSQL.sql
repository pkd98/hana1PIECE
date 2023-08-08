
-- 레퍼럴 코드 : 랜덤 5자리 대문자, 숫자 조합 생성
DECLARE
  v_string VARCHAR2(100);
  v_output VARCHAR2(5);
BEGIN
  v_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  FOR i IN 1..5 LOOP
    v_output := v_output || SUBSTR(v_string, DBMS_RANDOM.VALUE(1, 36), 1);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE(v_output);
END;
/