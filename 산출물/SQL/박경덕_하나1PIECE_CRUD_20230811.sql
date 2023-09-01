REM  ***************************************************************************
REM  제목 : [최종프로젝트] 하나1PIECE 조각투자 플랫폼 : 더미 데이터 생성 및 각 시나리오 스크립트
REM  작성자 : 박경덕
REM  작성 일자 : 2023-08-08 최초 작성
REM            2023-08-11 각 시나리오 DML 작성
REM            2023-08-14 시스템 프로시저 적용 시나리오 수정(배당금, 호가창 초기화)
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
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('minjoon1', '김민준', 'test123', '01012341234', 'alice@naver.com', v_referral_code);
  COMMIT; -- 변경 사항을 커밋
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('seoyeon2', '김서연', 'test123', '01022222222', 'alice2@gmail.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('jimin3', '윤지민', 'test123', '01033333333', 'alice3@yahoo.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('hyeonwoo4', '최현우', 'test123', '01012312323', 'alice4@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('joonwoo5', '박준우', 'test123', '01055555555', 'alice5@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('seojoon6', '박서준', 'test123', '01066666666', 'alice6@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('jiho7', '유지호', 'test123', '01077777777', 'alice7@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('doyoon8', '이도윤', 'test123', '01088888888', 'alice8@naver.com', v_referral_code);
  COMMIT;
END;
/
DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('gunwoo9', '강건우', 'test123', '01099999999', 'alice9@naver.com', v_referral_code);
  COMMIT;
END;
/
DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
  INSERT INTO ONE_MEMBERS (ID, NAME, PASSWORD, PHONE, EMAIL, REFERRAL_CODE)
  VALUES ('woojin10', '김우진', 'test123', '01010101010', 'alice10@naver.com', v_referral_code);
  COMMIT;
END;
/

DECLARE
  v_referral_code VARCHAR2(5);
BEGIN
  -- 레퍼럴 코드 생성 프로시저 실행. 랜덤으로 생성된 5자리 레퍼럴 코드 저장
  v_referral_code := HANA1PIECE_MNG.GENERATE_REFERRAL_CODE;
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

BEGIN
    -- 계좌 개설 : 계정계 공통 모듈 사용
    hana_bank_mng.account_opening(
        p_account_number => '99900000021394',
        p_password=>'1234',
        p_resident_number1=>'981010',
        p_resident_number2=>'1122334',
        p_name=>'김우진'
    );
    
    -- 조각투자 지갑 연동
    INSERT INTO WALLET(MEMBER_ID, ACCOUNT_NUMBER, PASSWORD) VALUES ('woojin10', '99900000021394', '1234');
    commit;
END;
/

select * from wallet;
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

BEGIN
    -- 입금
    hana_bank_mng.deposit(
    p_account_number => '99900000021394',
    p_amount=>1000000,
    p_name=>'무통장 입금',
    p_recipient_account_number=>'CD'
    );
END;
/

select * from account;
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
    update wallet set balance = (select balance from wallet where wallet_number = 1) + 500000
    where wallet_number = 1;
    commit;    
END;
/

BEGIN
    -- 관리자 법인 계좌로 이체
    hana_bank_mng.transfer(
        p_account_number=>'99900000021394',
        p_password=>'1234',
        p_amount=>500000,
        p_name=>'하나1PIECE',
        p_recipient_account_number=>'99900000001394'
    );
    
    -- 지갑 잔액 충전 [시스템계]
    update wallet set balance = (select balance from wallet where wallet_number = 2) + 500000
    where wallet_number = 2;
    commit;
END;
/

BEGIN
    hana_bank_mng.withdraw(
        p_account_number=>'99900000001394',
        p_password=>'1234',
        p_amount=>50000000,
        p_name=>'출금테스트',
        p_recipient_account_number=>'CD'
    );
END;
/

select * from account;
--------------------------------------------------------------------------------
-- 지갑 현금 출금 : 연동 계좌로 현금 이체 - 마이페이지
--------------------------------------------------------------------------------
BEGIN
    -- 지갑 잔액 출금 [시스템계]
    update wallet set balance = (select balance from wallet where wallet_number = 1) - 100000
    where wallet_number = 1;

    -- 관리자 법인 계좌에서 해당 사용자 계좌로 이체
    hana_bank_mng.transfer(
        p_account_number=>'99900000001394',
        p_password=>'1234',
        p_amount=>100000,
        p_name=>'하나1PIECE',
        p_recipient_account_number=>'99900000011394'
    );
    
    commit;    
END;
/

select * from account;
select * from bank_transaction;
select * from bank_exception_log;
select * from wallet;

REM  ***************************************************************************
REM                             매물 더미 데이터 생성
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 관리자 : 부동산 매물 정보 및 청약 등록 + 공지사항 자동 등록
--------------------------------------------------------------------------------
BEGIN
    -- 매물 등록
    INSERT INTO REAL_ESTATE_SALE(LISTING_NUMBER, STATE) VALUES (1, '청약');
    
    -- 해당 매물 부동산 상세 정보 등록
    INSERT INTO REAL_ESTATE_INFO(listing_number, building_name, address, floors, usage, land_area, floor_area, coverage_ratio, floor_area_ratio, completion_date, latitude, longitude)
    VALUES(1, '롯데월드타워 시그니엘 1층 1호', '서울시 송파구 올림픽로 300', 1, '오피스텔', '87,182m^2', '805,872m^2', 41.8, 573.2, TO_DATE('2016-12-22', 'YYYY-MM-DD'), 37.5125000, 127.1027780);
    
    -- 임차인 정보
    INSERT INTO TENANT_INFO(LISTING_NUMBER, LESSEE, SECTOR, CONTRACT_DATE, EXPIRATION_DATE)
    VALUES(1, '박경덕', '주거', TO_DATE('2023-08-11', 'YYYY-MM-DD'), TO_DATE('2025-08-11', 'YYYY-MM-DD'));
    
    -- 발행 정보
    INSERT INTO PUBLICATION_INFO(LISTING_NUMBER, SUBJECT, TYPE, PUBLISHER, VOLUME, ISSUE_PRICE, TOTAL_AMOUNT, START_DATE, EXPIRATION_DATE, FIRST_DIVIDEND_DATE, DIVIDEND_CYCLE, DIVIDEND)
    VALUES(1, '롯데월드타워 시그니엘 1층 1호', '수익증권', '하나자산신탁', 840000, 5000, 4200000000, TO_DATE('2023-08-11', 'YYYY-MM-DD'), TO_DATE('2023-08-18', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), '1개월', 20);
    
    -- 공지사항 등록
    INSERT INTO ANNOUNCEMENT(TITLE, CONTENT)
    VALUES('[청약]롯데월드타워 시그니엘 1층 1호', '롯데월드타워 시그니엘 1층 1호 공모 청약이 등록되었습니다.');
    
    commit;
END;
/

select * from REAL_ESTATE_SALE;
select * from REAL_ESTATE_INFO;
select * from TENANT_INFO;
select * from PUBLICATION_INFO;
select * from ANNOUNCEMENT;

REM  ***************************************************************************
REM                             사용자 청약 신청
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 사용자 : 공모 청약 신청 -> 총 발행량 다 팔리거나, 만료일에 마감 후 상장(상태->거래가능)
--------------------------------------------------------------------------------
DECLARE
    v_BALANCE NUMBER;
BEGIN
    -- 10개 5만원치 청약 신청
    -- 지갑 보유 금액 차감
    update wallet set balance = (select balance from wallet where wallet_number = 1) - 50000
    where wallet_number = 1;
    
    -- 지갑 거래 내역 기록
    select balance INTO v_BALANCE from wallet where wallet_number = 1;
    HANA1PIECE_MNG.WRITE_WALLET_TRANSACTION(1, 'OUT', '청약', 50000, v_BALANCE);
    
    /*
    insert into wallet_transaction(wallet_number, classification, name, amount, balance)
    values(1, 'OUT', '청약', 50000, (select balance from wallet where wallet_number = 1));
    */
    
    -- 공모 청약 신청
    INSERT INTO PUBLIC_OFFERING(LISTING_NUMBER, WALLET_NUMBER, QUANTITY)
    VALUES (1, 1, 10);
    
    -- 청약 마감 해당 매물 상태 '상장' 변경
    update real_estate_sale set state = '상장'
    where listing_number = 1;
    
    -- 공지사항 등록
    INSERT INTO ANNOUNCEMENT(TITLE, CONTENT)
    VALUES('[상장]롯데월드타워 시그니엘 1층 1호', '롯데월드타워 시그니엘 1층 1호 상장되었습니다.');

    -- 청약 마감시, 보유 토큰 지급
    insert into stos(wallet_number, listing_number, amount)
    values(1, 1, 10);
    
    -- 호가 테이블 셋팅 [프로시저 활용]
    HANA1PIECE_MNG.INIT_ORDER_BOOK(1);
    /*
    insert into order_book(listing_number, type, price, amount)
    values(1, 'sell', 5000, 0);
    */
    
    commit;
END;
/

select * from wallet;
select * from wallet_transaction;
select * from PUBLIC_OFFERING;
select * from real_estate_sale;
select * from stos;
REM  ***************************************************************************
REM                                 주문 시나리오
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 보유 토큰 매도 주문
--------------------------------------------------------------------------------
BEGIN
    -- 매도 주문
    insert into sto_orders(LISTING_NUMBER, wallet_number, order_type, amount, quantity, status)
    values(1, 1, 'SELL', 5000, 10, '미체결');
    
    -- 호가창 반영
    update order_book set amount = (select amount from order_book where listing_number = 1 and type = 'SELL' and price = 5000) + 10
    where listing_number = 1 and type = 'SELL' and price = 5000;

    commit;
END;
/

select * from sto_orders;
select * from order_book;

--------------------------------------------------------------------------------
-- 다른 사용자 해당 매물 매수 주문 및 주문 체결
--------------------------------------------------------------------------------
BEGIN
    -- 매수자 지갑 현금 차감
    update wallet set balance = (select balance from wallet where wallet_number = 2) - 50000
    where wallet_number = 2;
    
    -- 매수 주문 등록
    insert into sto_orders(LISTING_NUMBER, wallet_number, order_type, amount, quantity, status)
    values(1, 2, 'BUY', 5000, 10, '미체결');
    
    -- 체결 테이블 체결 주문 삽입
    insert into execution(order_id, executed_price, executed_quantity)
    values(1, 5000, 10);
    
    insert into execution(order_id, executed_price, executed_quantity)
    values(2, 5000, 10);
    
    -- 주문 테이블 체결 상태 반영 (부분 체결되면 '부분 체결')
    update sto_orders set status = '체결'
    where order_id = '1';
    
    update sto_orders set status = '체결'
    where order_id = '2';
    
    -- 체결로 인한 호가창 반영
    update order_book set amount = (select amount from order_book where listing_number = 1 and type = 'SELL' and price = 5000) - 10
    where listing_number = 1 and type = 'SELL' and price = 5000;
    
    -- 매도자 보유토큰 차감
    update stos set amount = (select amount from stos where wallet_number = 1 and listing_number = 1) - 10
    where wallet_number = 1 and listing_number = 1;    
    
    -- 매도자 현금 지급
    update wallet set balance = (select balance from wallet where wallet_number = 1) + 50000
    where wallet_number = 1;
    
    -- 매수자 토큰 지급
    insert into stos(wallet_number, listing_number)
    values(2, 1);
    
    update stos set amount = (select amount from stos where wallet_number = 2 and listing_number = 1) + 10
    where wallet_number = 2 and listing_number = 1;
        
    commit;
END;
/

select * from wallet;
select * from execution;
select * from sto_orders;
select * from order_book;
select * from stos;

--------------------------------------------------------------------------------
-- 배당금 지급 + 공지사항 자동 등록
--------------------------------------------------------------------------------
BEGIN
    -- 1번 매물 보유 회원지갑에 토큰당 20원씩 배당금 지급
    HANA1PIECE_MNG.PAY_DIVIDEND(
        p_listing_number=>1,
        p_payout=>20
    );

    -- 공지사항 등록
    INSERT INTO ANNOUNCEMENT(TITLE, CONTENT)
    VALUES('[0월 배당금]롯데월드타워 시그니엘 1층 1호', '롯데월드타워 시그니엘 1층 1호 0월 배당금 지급되었습니다.');

    /*
    -- 배당금 지급 내역 기록
    INSERT INTO DIVIDEND_DETAILS(wallet_number, listing_number, payout)
    VALUES(2, 1, 200);
    
    -- 관리자 법인 계좌에서 해당 사용자 계좌로 배당금 지급
    hana_bank_mng.transfer(
        p_account_number=>'99900000001394',
        p_password=>'1234',
        p_amount=>200,
        p_name=>'배당금 지급',
        p_recipient_account_number=>'99900000021394'
    );
    */
    
    commit;
END;
/

select * from dividend_details;
select * from wallet;
select * from wallet_transaction;
--------------------------------------------------------------------------------
-- 매각 투표 등록
--------------------------------------------------------------------------------
BEGIN
    -- 해당 매물 매각 투표 상태 변경
    update real_estate_sale set state = '매각투표'
    where listing_number = 1;
    
    -- 매각 투표
    insert into sell_vote(listing_number, wallet_number, pros_cons, quantity)
    values(1, 2, '찬성', 10);
    
    -- 매각 완료
    update real_estate_sale set state = '매각'
    where listing_number = 1;
    
    -- 1번 매물 보유 회원 지갑에 토큰당 매각 배당금 지급 및 내역 기록 
    HANA1PIECE_MNG.PAY_DIVIDEND(
        p_listing_number=>1,
        p_payout=>5500
    );
    /*
    INSERT INTO DIVIDEND_DETAILS(wallet_number, listing_number, payout)
    VALUES(2, 1, 55000);
    
    -- 관리자 법인 계좌에서 해당 사용자 계좌로 매각 배당금 지급
    hana_bank_mng.transfer(
        p_account_number=>'99900000001394',
        p_password=>'1234',
        p_amount=>55000,
        p_name=>'매각 배당금 지급',
        p_recipient_account_number=>'99900000021394'
    );
    */
    -- 공지사항 등록
    INSERT INTO ANNOUNCEMENT(TITLE, CONTENT)
    VALUES('[매각 완료]롯데월드타워 시그니엘 1층 1호', '롯데월드타워 시그니엘 1층 1호 0월 매각되었습니다.');
    
    COMMIT;
END;
/

select * from real_estate_sale;
select * from sell_vote;
select * from DIVIDEND_DETAILS;
select * from account;
select * from bank_transaction;
select * from wallet;
select * from wallet_transaction;