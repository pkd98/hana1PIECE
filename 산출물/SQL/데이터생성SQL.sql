REM  ***************************************************************************
REM  제목 : [최종프로젝트] 하나1PIECE 조각투자 플랫폼 : 더미 데이터 생성 스크립트
REM  작성자 : 박경덕
REM  작성 일자 : 2023-08-08 최초 작성
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 기본 데이터 : 관리자 계정, 관리자(사업자) 계좌
--------------------------------------------------------------------------------
-- 관리자 계정 등록
INSERT INTO MANAGER (ID, NAME, PASSWORD, ENROLL_DATE)
VALUES ('admin', '관리자', 'admin', TO_DATE('2023-08-08', 'YYYY-MM-DD'));

INSERT INTO ACCOUNT (ACCOUNT_NUMBER, PASSWORD, BALANCE, RESIDENT_NUMBER1, RESIDENT_NUMBER2, NAME)
VALUES ('99900000001394', '1234', 99999999999, 981010, 0000000, '(주)하나1PIECE');

commit;

select * from manager;
select * from account;
REM  ***************************************************************************
REM                          초기 회원 가입 및 계좌개설 시나리오
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 회원가입 : 회원 데이터 생성, 레퍼럴 코드 생성 프로시저 사용
--------------------------------------------------------------------------------
DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('minjoon1', '김민준', 'test123', '01012341234', 'alice@naver.com', v_referral_code);
  COMMIT; -- 변경 사항을 커밋
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('seoyeon2', '김서연', 'test123', '01022222222', 'alice2@gmail.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('jimin3', '윤지민', 'test123', '01033333333', 'alice3@yahoo.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('hyeonwoo4', '최현우', 'test123', '01012312323', 'alice4@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('joonwoo5', '박준우', 'test123', '01055555555', 'alice5@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('seojoon6', '박서준', 'test123', '01066666666', 'alice6@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('jiho7', '유지호', 'test123', '01077777777', 'alice7@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('doyoon8', '이도윤', 'test123', '01088888888', 'alice8@naver.com', v_referral_code);
  COMMIT;
END;
/
DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('gunwoo9', '강건우', 'test123', '01099999999', 'alice9@naver.com', v_referral_code);
  COMMIT;
END;
/
DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('woojin10', '김우진', 'test123', '01010101010', 'alice10@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('pkd98', '박경덕', 'test123', '01055550000', 'alice11@naver.com', v_referral_code);
  COMMIT;
END;
/

select * from ONE_MEMBERS;

--------------------------------------------------------------------------------
-- 계좌 개설 및 지갑 연동 : 회원 계좌 개설 및 조각투자 지갑 연동
--------------------------------------------------------------------------------
BEGIN
    -- 계좌 개설 : 계정계 공통 모듈 사용
    hana_bank_mng.account_opening(
    p_account_number => '99900000011394',
    p_password=>'1234',
    p_resident_number1=>'981010',
    p_resident_number2=>'1122334',
    p_name=>'박경덕'
    );
    
    -- 조각투자 지갑 연동
    INSERT INTO WALLET(MEMBER_ID, ACCOUNT_NUMBER, PASSWORD) VALUES ('pkd98', '99900000011394', '1234');
    commit;
END;
/

--------------------------------------------------------------------------------
-- 하나은행 계좌 현금 입금 (100만원 입금)
--------------------------------------------------------------------------------
BEGIN
    -- 입금
    hana_bank_mng.deposit(
    p_account_number => '99900000011394',
    p_amount=>1000000,
    p_name=>'무통장 입금',
    p_recipient_account_number=>'CD'
    );
END;
/

--------------------------------------------------------------------------------
-- 지갑 현금 입금 : 계좌에 연동된 지갑에 현금 입금 - 마이페이지
--------------------------------------------------------------------------------
BEGIN
    -- 관리자 법인 계좌로 이체
    hana_bank_mng.transfer(
        p_account_number=>'99900000011394',
        p_password=>'1234',
        p_amount=>500000,
        p_name=>'하나1PIECE',
        p_recipient_account_number=>'99900000001394'
    );
    
    -- 지갑 잔액 충전 [시스템계]
    update wallet set balance = (select balance from wallet where member_id = 'pkd98') + 500000;
    commit;    
END;
/

select * from account;
select * from bank_transaction;
select * from bank_exception_log;

REM  ***************************************************************************
REM                             매물 더미 데이터 생성
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------



REM  ***************************************************************************
REM                              주문 시나리오
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------




REM  ***************************************************************************
REM                              관리자 시나리오
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 부동산 청약 등록 + 공지사항 자동 등록
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 부동산 청약 마감 및 상장 + [매물 상태 변경]
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- 배당금 지급 + 공지사항 자동 등록
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 매각 투표 등록
--------------------------------------------------------------------------------




