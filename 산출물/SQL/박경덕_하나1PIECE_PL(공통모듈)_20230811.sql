REM  ***************************************************************************
REM  제목 : [최종프로젝트] 하나1PIECE 조각투자 플랫폼 : PLSQL 공통 모듈 패키지 및 프로시저
REM  작성자 : 박경덕
REM  작성 일자 : 2023-08-10 최초 작성 - [계정계] 공통 모듈 패키지
REM            2023-08-14 - [시스템계] 공통 모듈 패키지
REM  ***************************************************************************
REM                           [공통 라이브러리 선정 업무]
REM  [계정계]: 계좌 개설, 입금 및 출금, 자행 이체, 거래내역 기록, 은행 예외 로그 기록
REM      - 은행 업무의 예외처리 및 트랜잭션 제어 등 무결성 보장을 위해 해당 계정계 업무를 선정했다.
REM
REM  [시스템계]: 호가테이블 셋팅, 배당금 지급, 지갑 거래내역 기록, 시스템 예외 로그 기록
REM           - 배치성 프로그램 (OLAP)의 효과적인 트랜잭션 제어 및 처리 성능의 이유로 선정
REM
REM            기타 추가기능 : 회원 레퍼럴 코드 생성 함수
REM  ***************************************************************************
REM             [계정계] HANA_BANK_MNG PACKAGE HEADER 정의
REM  ***************************************************************************
CREATE OR REPLACE PACKAGE HANA_BANK_MNG AS
    -- 예외 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
    PROCEDURE WRITE_BANK_LOG(
        A_LOG_CODE IN BANK_EXCEPTION_LOG.LOG_CODE%TYPE,
        A_PROGRAM IN BANK_EXCEPTION_LOG.PROGRAM%TYPE,
        A_MSG IN BANK_EXCEPTION_LOG.MSG%TYPE,
        A_NOTE IN BANK_EXCEPTION_LOG.NOTE%TYPE
    );
    
    -- 은행 거래내역 기록 프로시저
    PROCEDURE WRITE_BANK_TRANSACTION(
        A_ACCOUNT_NUMBER IN BANK_TRANSACTION.ACCOUNT_NUMBER%TYPE,
        A_CLASSIFICATION IN BANK_TRANSACTION.CLASSIFICATION%TYPE,
        A_NAME IN BANK_TRANSACTION.NAME%TYPE,
        A_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        A_BALANCE IN BANK_TRANSACTION.BALANCE%TYPE,
        A_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    );
    
    -- 계좌 개설
    PROCEDURE ACCOUNT_OPENING(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_RESIDENT_NUMBER1 IN ACCOUNT.RESIDENT_NUMBER1%TYPE,
        P_RESIDENT_NUMBER2 IN ACCOUNT.RESIDENT_NUMBER2%TYPE,
        P_NAME IN ACCOUNT.NAME%TYPE
    );
    
    -- 입금
    PROCEDURE DEPOSIT(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    );
    
    -- 출금
    PROCEDURE WITHDRAW(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    );
    
    -- 자행 이체
    PROCEDURE TRANSFER(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    );

END HANA_BANK_MNG;
/

REM  ***************************************************************************
REM                 [계정계] HANA_BANK_MNG PACKAGE BODY 정의
REM  ***************************************************************************
CREATE OR REPLACE PACKAGE BODY HANA_BANK_MNG AS
    -- 사용자 정의 예외 타입 선언
    EXC_WRONG_PASSWORD EXCEPTION; -- 계좌 비밀번호 틀림 예외 발생
    EXC_INSUFFICIENT_BALANCE EXCEPTION; -- 잔액 부족 예외 발생
    
    -- 유효성 검사용 계좌 비밀번호 저장 변수
    PW VARCHAR2(4);

    -- 계정계 예외 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
    PROCEDURE WRITE_BANK_LOG(
        A_LOG_CODE IN BANK_EXCEPTION_LOG.LOG_CODE%TYPE,
        A_PROGRAM IN BANK_EXCEPTION_LOG.PROGRAM%TYPE,
        A_MSG IN BANK_EXCEPTION_LOG.MSG%TYPE,
        A_NOTE IN BANK_EXCEPTION_LOG.NOTE%TYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
    BEGIN
        -- 발생 EXCEPTION을 LOG 테이블에 기록
        INSERT INTO BANK_EXCEPTION_LOG(LOG_CODE, PROGRAM, MSG, NOTE)
          VALUES(A_LOG_CODE, A_PROGRAM, A_MSG, A_NOTE);
          
        -- AUTONOMOUS TRANSACTION 종료
        COMMIT; 
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END WRITE_BANK_LOG;
    
    
    -- 은행 거래내역 기록 프로시저 정의
    PROCEDURE WRITE_BANK_TRANSACTION(
        A_ACCOUNT_NUMBER IN BANK_TRANSACTION.ACCOUNT_NUMBER%TYPE,
        A_CLASSIFICATION IN BANK_TRANSACTION.CLASSIFICATION%TYPE,
        A_NAME IN BANK_TRANSACTION.NAME%TYPE,
        A_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        A_BALANCE IN BANK_TRANSACTION.BALANCE%TYPE,
        A_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    ) IS
    BEGIN
        -- 은행 거래내역을 기록
        INSERT INTO BANK_TRANSACTION(ACCOUNT_NUMBER, CLASSIFICATION, NAME, AMOUNT, BALANCE, RECIPIENT_ACCOUNT_NUMBER)
          VALUES(A_ACCOUNT_NUMBER, A_CLASSIFICATION, A_NAME, A_AMOUNT, A_BALANCE, A_RECIPIENT_ACCOUNT_NUMBER);
          
        -- OLTP Transaction 종료
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:WBT', 'WRITE_BANK_TRANSACTION', SQLERRM, '거래 내역 기록 실패');
    END WRITE_BANK_TRANSACTION;
    
    
    -- 계좌 개설
    PROCEDURE ACCOUNT_OPENING(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_RESIDENT_NUMBER1 IN ACCOUNT.RESIDENT_NUMBER1%TYPE,
        P_RESIDENT_NUMBER2 IN ACCOUNT.RESIDENT_NUMBER2%TYPE,
        P_NAME IN ACCOUNT.NAME%TYPE
    ) IS
    BEGIN
        -- 계좌 생성
        INSERT INTO ACCOUNT(ACCOUNT_NUMBER, PASSWORD, RESIDENT_NUMBER1, RESIDENT_NUMBER2, NAME)
            VALUES(P_ACCOUNT_NUMBER, P_PASSWORD, P_RESIDENT_NUMBER1, P_RESIDENT_NUMBER2, P_NAME);
        
        -- OLTP Transaction 종료
        COMMIT; 
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:AO', 'ACCOUNT_OPENING', SQLERRM, '계좌 개설 실패');
    END ACCOUNT_OPENING;
    
    
    -- 입금
    PROCEDURE DEPOSIT(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    )IS
        OLD_BALANCE NUMBER;
        NEW_BALANCE NUMBER;
    BEGIN
        SELECT BALANCE INTO OLD_BALANCE FROM ACCOUNT WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
        NEW_BALANCE := OLD_BALANCE + P_AMOUNT;
        
        -- 계좌 거래 내역 기록
        WRITE_BANK_TRANSACTION(P_ACCOUNT_NUMBER, 'IN', P_NAME, P_AMOUNT, NEW_BALANCE, P_RECIPIENT_ACCOUNT_NUMBER);
        
        -- 입금 반영
        UPDATE ACCOUNT SET 
            BALANCE = NEW_BALANCE
        WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
        
        -- OLTP Transaction 종료
        COMMIT; 
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:DEPOSIT', 'DEPOSIT', SQLERRM, '입금 실패');
    END DEPOSIT;
    
    
    -- 출금
    PROCEDURE WITHDRAW(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    )IS
        OLD_BALANCE NUMBER;
        NEW_BALANCE NUMBER;
    BEGIN
        SELECT PASSWORD, BALANCE INTO PW, OLD_BALANCE FROM ACCOUNT WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
        -- 계좌 비밀번호 입력 값 유효성 검사
        IF P_PASSWORD != PW THEN
            RAISE EXC_WRONG_PASSWORD;
        END IF;
        
        IF OLD_BALANCE < P_AMOUNT THEN
            RAISE EXC_INSUFFICIENT_BALANCE;
        END IF;
        
        NEW_BALANCE := OLD_BALANCE - P_AMOUNT;
        
        -- 계좌 거래 내역 기록
        WRITE_BANK_TRANSACTION(P_ACCOUNT_NUMBER, 'OUT', P_NAME, P_AMOUNT, NEW_BALANCE, P_RECIPIENT_ACCOUNT_NUMBER);
        
        -- 출금 반영
        UPDATE ACCOUNT SET 
            BALANCE = NEW_BALANCE
        WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER AND PASSWORD = P_PASSWORD;
        
        -- OLTP Transaction 종료
        COMMIT;

    EXCEPTION
        WHEN EXC_INSUFFICIENT_BALANCE THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:WITHDRAW', 'WITHDRAW', 'EXC_INSUFFICIENT_BALANCE', '출금 실패');

        WHEN EXC_WRONG_PASSWORD THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:WITHDRAW', 'WITHDRAW', 'EXC_WRONG_PASSWORD', '출금 실패');

        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:WITHDRAW', 'WITHDRAW', SQLERRM, '출금 실패');
    END WITHDRAW;

    
    -- 자행 이체
    PROCEDURE TRANSFER(
        P_ACCOUNT_NUMBER IN ACCOUNT.ACCOUNT_NUMBER%TYPE,
        P_PASSWORD IN ACCOUNT.PASSWORD%TYPE,
        P_AMOUNT IN BANK_TRANSACTION.AMOUNT%TYPE,
        P_NAME IN BANK_TRANSACTION.NAME%TYPE,
        P_RECIPIENT_ACCOUNT_NUMBER IN BANK_TRANSACTION.RECIPIENT_ACCOUNT_NUMBER%TYPE
    )IS
        OLD_BALANCE NUMBER;
        NEW_BALANCE NUMBER;
    BEGIN
        SELECT PASSWORD, BALANCE INTO PW, OLD_BALANCE FROM ACCOUNT WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
        -- 계좌 비밀번호 입력 값 유효성 검사
        IF P_PASSWORD != PW THEN
            RAISE EXC_WRONG_PASSWORD;
        END IF;
        
        IF OLD_BALANCE < P_AMOUNT THEN
            RAISE EXC_INSUFFICIENT_BALANCE;
        END IF;
        
        NEW_BALANCE := OLD_BALANCE - P_AMOUNT;
        
        -- 출금
        WITHDRAW(P_ACCOUNT_NUMBER, P_PASSWORD, P_AMOUNT, P_NAME, P_RECIPIENT_ACCOUNT_NUMBER);
        
        -- 상대 계좌 입금
        DEPOSIT(P_RECIPIENT_ACCOUNT_NUMBER, P_AMOUNT, P_NAME, P_ACCOUNT_NUMBER);
        
        -- OLTP Transaction 종료
        COMMIT; 

    EXCEPTION
        WHEN EXC_INSUFFICIENT_BALANCE THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:TRANSFER', 'TRANSFER', 'EXC_INSUFFICIENT_BALANCE', '이체 실패');

        WHEN EXC_WRONG_PASSWORD THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:TRANSFER', 'TRANSFER', 'EXC_WRONG_PASSWORD', '이체 실패');

        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_BANK_LOG('ERR:TRANSFER', 'TRANSFER', SQLERRM, '이체 실패');
    END TRANSFER;
END HANA_BANK_MNG;
/

REM  ***************************************************************************
REM                 [시스템계] HANA_1PIECE_MNG PACKAGE HEADER 정의
REM  ***************************************************************************
CREATE OR REPLACE PACKAGE HANA1PIECE_MNG AS
    
    -- 예외 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
    PROCEDURE WRITE_LOG(
        A_LOG_CODE IN EXCEPTION_LOG.LOG_CODE%TYPE,
        A_PROGRAM IN EXCEPTION_LOG.PROGRAM%TYPE,
        A_MSG IN EXCEPTION_LOG.MSG%TYPE,
        A_NOTE IN EXCEPTION_LOG.NOTE%TYPE
    );

    -- 지갑 거래내역 기록 프로시저
    PROCEDURE WRITE_WALLET_TRANSACTION(
        A_WALLET_NUMBER IN WALLET_TRANSACTION.WALLET_NUMBER%TYPE,
        A_CLASSIFICATION IN WALLET_TRANSACTION.CLASSIFICATION%TYPE,
        A_NAME IN WALLET_TRANSACTION.NAME%TYPE,
        A_AMOUNT IN WALLET_TRANSACTION.AMOUNT%TYPE,
        A_BALANCE IN WALLET_TRANSACTION.BALANCE%TYPE
    );

    -- 호가 초기화 : 매물 상장시, 해당 매물번호에 해당하는 종목 호가 테이블 셋팅 (30호가)
    PROCEDURE INIT_ORDER_BOOK(
        P_LISTING_NUMBER IN REAL_ESTATE_SALE.LISTING_NUMBER%TYPE
    );
    
    -- 배당금 지급 : 해당 토큰 보유 회원 지갑에 배당금 지급 및 배당금 지급 내역, 지갑 거래내역 기록
    PROCEDURE PAY_DIVIDEND(
        P_LISTING_NUMBER IN REAL_ESTATE_SALE.LISTING_NUMBER%TYPE,
        P_PAYOUT IN DIVIDEND_DETAILS.PAYOUT%TYPE
    );
    
    -- 레퍼럴 코드 생성 : 랜덤 5자리 대문자, 숫자 조합 생성
    FUNCTION GENERATE_REFERRAL_CODE RETURN VARCHAR2;
    
END HANA1PIECE_MNG;
/



REM  ***************************************************************************
REM                 [시스템계] HANA_1PIECE_MNG PACKAGE BODY 정의
REM  ***************************************************************************
CREATE OR REPLACE PACKAGE BODY HANA1PIECE_MNG AS

    -- 시스템 예외 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
    PROCEDURE WRITE_LOG(
        A_LOG_CODE IN EXCEPTION_LOG.LOG_CODE%TYPE,
        A_PROGRAM IN EXCEPTION_LOG.PROGRAM%TYPE,
        A_MSG IN EXCEPTION_LOG.MSG%TYPE,
        A_NOTE IN EXCEPTION_LOG.NOTE%TYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
    BEGIN
        -- 발생 EXCEPTION을 LOG 테이블에 기록
        INSERT INTO EXCEPTION_LOG(LOG_CODE, PROGRAM, MSG, NOTE)
          VALUES(A_LOG_CODE, A_PROGRAM, A_MSG, A_NOTE);
          
        -- AUTONOMOUS TRANSACTION 종료
        COMMIT; 
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END WRITE_LOG;


    -- 지갑 거래내역 기록 프로시저
    PROCEDURE WRITE_WALLET_TRANSACTION(
        A_WALLET_NUMBER IN WALLET_TRANSACTION.WALLET_NUMBER%TYPE,
        A_CLASSIFICATION IN WALLET_TRANSACTION.CLASSIFICATION%TYPE,
        A_NAME IN WALLET_TRANSACTION.NAME%TYPE,
        A_AMOUNT IN WALLET_TRANSACTION.AMOUNT%TYPE,
        A_BALANCE IN WALLET_TRANSACTION.BALANCE%TYPE
    ) IS
    BEGIN
        -- 지갑 거래내역을 기록
        INSERT INTO WALLET_TRANSACTION(WALLET_NUMBER, CLASSIFICATION, NAME, AMOUNT, BALANCE)
          VALUES(A_WALLET_NUMBER, A_CLASSIFICATION, A_NAME, A_AMOUNT, A_BALANCE);
          
        -- OLTP Transaction 종료
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_LOG('ERR:WWT', 'WRITE_WALLET_TRANSACTION', SQLERRM, '거래 내역 기록 실패');
    END WRITE_WALLET_TRANSACTION;


    -- 호가 초기화 : 매물 상장시, 해당 매물번호에 해당하는 종목 호가 테이블 셋팅
    PROCEDURE INIT_ORDER_BOOK(
        P_LISTING_NUMBER IN REAL_ESTATE_SALE.LISTING_NUMBER%TYPE
    ) IS
        -- 1호가 당 10원 간격
        v_number NUMBER := 10;
    BEGIN
        -- 상장 호가 5000원 셋팅
        INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
            VALUES(P_LISTING_NUMBER, 'BUY', 5000); 
        INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
            VALUES(P_LISTING_NUMBER, 'SELL', 5000);
        
        -- 30호가 셋팅
        FOR i IN 1..30 LOOP
            INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
                VALUES(P_LISTING_NUMBER, 'BUY', 5000 + (v_number * i)); 
            INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
                VALUES(P_LISTING_NUMBER, 'SELL', 5000 + (v_number * i)); 
            INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
                VALUES(P_LISTING_NUMBER, 'BUY', 5000 - (v_number * i)); 
            INSERT INTO ORDER_BOOK(LISTING_NUMBER, TYPE, PRICE)
                VALUES(P_LISTING_NUMBER, 'SELL', 5000 - (v_number * i)); 
        END LOOP;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_LOG('ERR:IRB', 'INIT_ORDER_BOOK', SQLERRM, '호가 초기화 실패');
    END INIT_ORDER_BOOK;


    -- 배당금 지급 : 해당 토큰 보유 회원 지갑에 배당금 지급 및 배당금 지급 내역, 지갑 거래내역 기록
    PROCEDURE PAY_DIVIDEND(
        P_LISTING_NUMBER IN REAL_ESTATE_SALE.LISTING_NUMBER%TYPE,
        P_PAYOUT IN DIVIDEND_DETAILS.PAYOUT%TYPE
    )IS
        OLD_BALANCE NUMBER;
        NEW_BALANCE NUMBER;
        TOTAL_PAYOUT NUMBER;
    BEGIN
        -- 암시적 CURSOR를 활용해 토큰 보유 회원 및 보유수량을 가져오고, 해당 회원지갑에 수량에 비례한 배당금 지급
        FOR HOLDING_MEMBERS IN (SELECT WALLET_NUMBER, AMOUNT FROM STOS WHERE LISTING_NUMBER = P_LISTING_NUMBER AND AMOUNT > 0) LOOP
            -- 최종 지급될 배당금
            TOTAL_PAYOUT := HOLDING_MEMBERS.AMOUNT * P_PAYOUT;
            
            -- 해당 회원지갑 이전 보유 금액
            SELECT BALANCE INTO OLD_BALANCE FROM WALLET WHERE WALLET_NUMBER = HOLDING_MEMBERS.WALLET_NUMBER;

            -- 해당 회원지갑 배당금 지급 이후 잔액
            NEW_BALANCE := OLD_BALANCE + TOTAL_PAYOUT;

            -- 배당금 지급내역 기록
            INSERT INTO DIVIDEND_DETAILS(WALLET_NUMBER, LISTING_NUMBER, PAYOUT)
                VALUES(HOLDING_MEMBERS.WALLET_NUMBER, P_LISTING_NUMBER, TOTAL_PAYOUT);
            
            -- 지갑 거래내역 기록
            WRITE_WALLET_TRANSACTION(HOLDING_MEMBERS.WALLET_NUMBER, 'IN', '배당금 지급', TOTAL_PAYOUT, NEW_BALANCE);
            
            -- 회원 지갑에 배당금 입금
            UPDATE WALLET SET BALANCE = NEW_BALANCE
            WHERE WALLET_NUMBER = HOLDING_MEMBERS.WALLET_NUMBER;
            
        END LOOP;
        
        -- OLAP 트랜잭션 종료
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_LOG('ERR:PD', 'PAY_DIVIDEND', SQLERRM, '배당금 지급 실패');
    END PAY_DIVIDEND;
    
    
    -- 레퍼럴 코드 생성 : 랜덤 5자리 대문자, 숫자 조합 생성
    FUNCTION GENERATE_REFERRAL_CODE RETURN VARCHAR2 IS
        v_string VARCHAR2(100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        v_output VARCHAR2(5) := '';
    BEGIN
    
      FOR i IN 1..5 LOOP
        v_output := v_output || SUBSTR(v_string, DBMS_RANDOM.VALUE(1, 36), 1);
      END LOOP;
    
      RETURN v_output;
      
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            WRITE_LOG('ERR:GRC', 'GENERATE_REFERRAL_CODE', SQLERRM, '레퍼럴 코드 생성 실패');
    END GENERATE_REFERRAL_CODE;

END HANA1PIECE_MNG;
/

-- select ACCOUNT_SERIAL_NUMBER_SEQ.nextval from dual;
-- select * from bank_exception_log;
