REM  ***************************************************************************
REM  제목 : [최종프로젝트] 하나1PIECE 조각투자 플랫폼 테이블 생성 스크립트
REM  작성자 : 박경덕
REM  작성 일자 : 2023-08-06 최초 작성
REM            2023-08-07 제약 조건 및 초기화, 주석 추가
REM            2023-08-11 체결 테이블 추가
REM            2023-08-29 위도, 경도 (15,13), (15,12) 수정
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 초기화
--------------------------------------------------------------------------------
-- 제약조건 비활성화
ALTER TABLE EXECUTION DROP CONSTRAINT FK_EXECUTION_BUY_ORDER_ID;
ALTER TABLE EXECUTION DROP CONSTRAINT FK_EXECUTION_SELL_ORDER_ID;
ALTER TABLE STOS DROP CONSTRAINT FK_STOS_LISTING_NUMBER;
ALTER TABLE STOS DROP CONSTRAINT FK_STOS_WALLET_NUMBER;
ALTER TABLE STO_ORDERS DROP CONSTRAINT FK_ORDER_LISTING_NUMBER;
ALTER TABLE STO_ORDERS DROP CONSTRAINT FK_ORDER_WALLET_NUMBER;
ALTER TABLE ORDER_BOOK DROP CONSTRAINT FK_ORDER_BOOK_LISTING_NUMBER;
ALTER TABLE DIVIDEND_DETAILS DROP CONSTRAINT FK_DIVIDEND_DETAILS_WALLET_NUMBER;
ALTER TABLE DIVIDEND_DETAILS DROP CONSTRAINT FK_DIVIDEND_DETAILS_LISTING_NUMBER;
ALTER TABLE PUBLIC_OFFERING DROP CONSTRAINT FK_PUBLIC_OFFERING_WALLET_NUMBER;
ALTER TABLE PUBLIC_OFFERING DROP CONSTRAINT FK_PUBLIC_OFFERING_LISTING_NUMBER;
ALTER TABLE SELL_VOTE DROP CONSTRAINT FK_SELL_VOTE_WALLET_NUMBER;
ALTER TABLE SELL_VOTE DROP CONSTRAINT FK_SELL_VOTE_LISTING_NUMBER;
ALTER TABLE WALLET_TRANSACTION DROP CONSTRAINT FK_WALLET_TRANSACTION_WALLET_NUMBER;
ALTER TABLE WALLET DROP CONSTRAINT FK_WALLET_MEMBER_ID;
ALTER TABLE WALLET DROP CONSTRAINT FK_WALLET_ACCOUNT_NUMBER;
ALTER TABLE BANK_TRANSACTION DROP CONSTRAINT FK_BANK_TRANSACTION_ACCOUNT_NUMBER;

-- 전체 테이블 삭제
DROP TABLE STOS;
DROP TABLE STO_ORDERS;
DROP TABLE ORDER_BOOK;
DROP TABLE Execution;
DROP TABLE DIVIDEND_DETAILS;
DROP TABLE PUBLIC_OFFERING;
DROP TABLE SELL_VOTE;
DROP TABLE WALLET_TRANSACTION;
DROP TABLE WALLET;
DROP TABLE BANK_TRANSACTION;
DROP TABLE ANNOUNCEMENT;
DROP TABLE COMMON_CODE_D;
DROP TABLE COMMON_CODE_M;
DROP TABLE EXCEPTION_LOG;
DROP TABLE TENANT_INFO;
DROP TABLE SOLD_BUILDING;
DROP TABLE REAL_ESTATE_INFO;
DROP TABLE PUBLICATION_INFO;
DROP TABLE ONE_MEMBERS;
DROP TABLE MANAGER;
DROP TABLE REAL_ESTATE_SALE;
DROP TABLE ACCOUNT;
DROP TABLE BANK_EXCEPTION_LOG;

-- 시퀀스 삭제
DROP SEQUENCE ACCOUNT_SERIAL_NUMBER_SEQ;
DROP SEQUENCE BT_SEQ;
DROP SEQUENCE LN_SEQ;
DROP SEQUENCE BLOG_SEQ;
DROP SEQUENCE WN_SEQ;
DROP SEQUENCE WT_SEQ;
DROP SEQUENCE ORDER_SEQ;
DROP SEQUENCE OB_SEQ;
DROP SEQUENCE EID_SEQ;
DROP SEQUENCE PN_SEQ;
DROP SEQUENCE POI_SEQ;
DROP SEQUENCE SV_SEQ;
DROP SEQUENCE ANNOUNCEMENT_SEQ;
DROP SEQUENCE LOG_SEQ;

--------------------------------------------------------------------------------
-- 전체 시퀸스 생성
--------------------------------------------------------------------------------
-- 은행 계좌번호 일련번호 생성 용도
CREATE SEQUENCE ACCOUNT_SERIAL_NUMBER_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 은행 거래내역 : 은행 거래내역 번호
CREATE SEQUENCE BT_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 은행 예외 로그 : 예외 로그 id
CREATE SEQUENCE BLOG_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 지갑 : 지갑 번호
CREATE SEQUENCE WN_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


-- 지갑 거래내역 : 지갑 거래내역 번호
CREATE SEQUENCE WT_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 부동산 매물 : 매물 번호
CREATE SEQUENCE LN_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 주문 : 주문 번호
CREATE SEQUENCE ORDER_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 호가 : 호가 id
CREATE SEQUENCE OB_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
-- 체결 : 체결 id
CREATE SEQUENCE EID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 공지사항 : 공지사항 id
CREATE SEQUENCE ANNOUNCEMENT_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 시스템 예외 로그 : 예외 로그 id
CREATE SEQUENCE LOG_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 배당금 지급내역 : 배당금 지급 번호
CREATE SEQUENCE PN_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 공모 청약 : 공모, 청약 번호
CREATE SEQUENCE POI_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE; 

-- 매각 투표 : 매각 투표 id
CREATE SEQUENCE SV_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE; 

--------------------------------------------------------------------------------
-- [계정계] 테이블 생성
--------------------------------------------------------------------------------
-- 은행 계좌
CREATE TABLE ACCOUNT (
  ACCOUNT_NUMBER VARCHAR2(20) PRIMARY KEY,      -- 계좌 번호
  PASSWORD VARCHAR2(4) NOT NULL,                  -- 계좌 비밀번호
  BALANCE NUMBER(13) DEFAULT 0 NOT NULL,        -- 잔액
  OPENING_DATE DATE DEFAULT SYSDATE NOT NULL,   -- 계좌 개설일
  RESIDENT_NUMBER1 VARCHAR2(6) NOT NULL,          -- 주민등록번호
  RESIDENT_NUMBER2 VARCHAR2(7) NOT NULL,          -- 주민등록번호
  NAME VARCHAR2(20) NOT NULL                    -- 성명
);

-- 은행 거래내역
CREATE TABLE BANK_TRANSACTION (
  TRANSACTION_NUMBER NUMBER(8) DEFAULT BT_SEQ.NEXTVAL PRIMARY KEY, -- 거래내역 번호
  ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,                            -- 계좌번호
  CLASSIFICATION VARCHAR2(3) NOT NULL,                             -- 거래구분
  NAME VARCHAR2(100) NOT NULL,                                     -- 거래명
  AMOUNT NUMBER(10) NOT NULL,                                      -- 거래금액
  BALANCE NUMBER(13) NOT NULL,                                     -- 거래후잔액
  BANK_CODE VARCHAR2(5) DEFAULT '080' NOT NULL,                    -- 상대 은행 코드 (자행 080)
  RECIPIENT_ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,                  -- 상대계좌번호
  TRANSACTION_DATE DATE DEFAULT SYSDATE NOT NULL,                  -- 거래일시
  
  -- 외래키 지정 : 계좌번호
  CONSTRAINT FK_BANK_TRANSACTION_ACCOUNT_NUMBER FOREIGN KEY (ACCOUNT_NUMBER) REFERENCES account(account_number)
);

-- 은행 예외 로그
CREATE TABLE BANK_EXCEPTION_LOG (
  ID NUMBER(8) DEFAULT BLOG_SEQ.NEXTVAL PRIMARY KEY,    -- 아이디
  LOG_CODE VARCHAR2(20),                                -- 로그코드
  OCCUR_DATE DATE DEFAULT SYSDATE,                      -- 발생일시
  PROGRAM VARCHAR2(30),                                 -- 발생프로그램
  MSG VARCHAR2(10000),                                  -- 에러메시지
  NOTE VARCHAR2(50)                                     -- 비고
);

--------------------------------------------------------------------------------
-- [조각투자 시스템] 테이블 생성
--------------------------------------------------------------------------------
-- 관리자
CREATE TABLE MANAGER (
  ID VARCHAR2(15) PRIMARY KEY,                      -- 관리자 아이디
  NAME VARCHAR2(30) NOT NULL,                       -- 관리자 이름
  PASSWORD VARCHAR2(30) NOT NULL,                   -- 비밀번호
  ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,        -- 등록일
  IMAGE VARCHAR2(100),                              -- 이미지
  POSITION VARCHAR2(100),                           -- 직책
  INTRODUCTION VARCHAR2(200)                        -- 소개글
);

-- 통합 회원
CREATE TABLE ONE_MEMBERS (
  ID VARCHAR2(15) PRIMARY KEY,                      -- 회원 아이디
  NAME VARCHAR2(30) NOT NULL,                       -- 회원 이름
  PASSWORD VARCHAR2(30) NOT NULL,                   -- 비밀번호
  PHONE VARCHAR2(11) NOT NULL,                      -- 휴대전화
  EMAIL VARCHAR2(50) NOT NULL,                      -- 이메일
  REFERRAL_CODE VARCHAR2(5) NOT NULL,               -- 추천코드
  REFERRAL_COUNT NUMBER(8) DEFAULT 0 NOT NULL,      -- 추천수
  
  -- 유니크 키 지정 : 휴대전화, 이메일, 추천코드
  CONSTRAINT uk_one_members_phone UNIQUE (phone),
  CONSTRAINT uk_one_members_email UNIQUE (email),
  CONSTRAINT uk_one_members_referral_code UNIQUE (referral_code)
);

-- 지갑
CREATE TABLE WALLET (
  WALLET_NUMBER NUMBER(8) DEFAULT WN_SEQ.NEXTVAL PRIMARY KEY,       -- 지갑번호
  MEMBER_ID VARCHAR2(20) NOT NULL,                                     -- 회원 아이디
  ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,                                -- 연동 계좌번호
  PASSWORD VARCHAR2(4) NOT NULL,                                       -- 지갑 비밀번호
  BALANCE NUMBER(13) DEFAULT 0 NOT NULL,                                       -- 잔액
  OPENING_DATE DATE DEFAULT SYSDATE NOT NULL,                          -- 지갑 개설일
  
  -- 외래키 지정 : 회원 아이디, 연동 계좌번호
  CONSTRAINT FK_WALLET_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES one_members(id),
  CONSTRAINT FK_WALLET_ACCOUNT_NUMBER FOREIGN KEY (ACCOUNT_NUMBER) REFERENCES account(account_number)
);

-- 지갑 거래내역
CREATE TABLE WALLET_TRANSACTION (
  TRANSACTION_NUMBER NUMBER(8) DEFAULT WT_SEQ.NEXTVAL PRIMARY KEY,  -- 거래내역 번호
  WALLET_NUMBER NUMBER(8) NOT NULL,                                 -- 지갑번호
  CLASSIFICATION VARCHAR2(10) NOT NULL,                              -- 거래구분
  NAME VARCHAR2(100),                                               -- 거래명
  AMOUNT NUMBER(10) NOT NULL,                                       -- 거래금액
  BALANCE NUMBER(13) NOT NULL,                                      -- 거래후잔액
  TRANSACTION_DATE DATE DEFAULT SYSDATE NOT NULL,                   -- 거래일시
  
  -- 외래키 지정 : 지갑번호
  CONSTRAINT FK_WALLET_TRANSACTION_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER)
);

-- 부동산 매물
CREATE TABLE REAL_ESTATE_SALE (
  LISTING_NUMBER NUMBER(8) DEFAULT LN_SEQ.NEXTVAL PRIMARY KEY,      -- 매물번호
  EVALUATION VARCHAR2(20) DEFAULT '평가없음',                         -- 평가
  INTRODUCTION VARCHAR2(300),                                       -- 소개글
  PRICE NUMBER(12) DEFAULT 5000,                                    -- 토큰 가격
  STATE VARCHAR2(20) DEFAULT '청약' NOT NULL                         -- 상태
);

-- 부동산 매물 상세 정보
CREATE TABLE REAL_ESTATE_INFO (
  LISTING_NUMBER NUMBER(8) PRIMARY KEY,         -- 매물번호
  BUILDING_NAME VARCHAR2(300) NOT NULL,         -- 건물명
  ADDRESS VARCHAR2(100) NOT NULL,               -- 건물 상세 주소
  FLOORS NUMBER(3) NOT NULL,                    -- 층 수
  USAGE VARCHAR2(30) NOT NULL,                  -- 주 용도
  LAND_AREA VARCHAR2(10) NOT NULL,              -- 대지면적
  FLOOR_AREA VARCHAR2(10) NOT NULL,             -- 연면적
  COVERAGE_RATIO NUMBER(3, 1) NOT NULL,         -- 건폐율
  FLOOR_AREA_RATIO NUMBER(5, 1) NOT NULL,       -- 용적률
  COMPLETION_DATE DATE NOT NULL,                -- 준공일
  LATITUDE NUMBER(15, 13) NOT NULL,               -- 위도
  LONGITUDE NUMBER(15, 12) NOT NULL,              -- 경도
  IMAGE1 VARCHAR2(1000),                         -- 이미지 1
  IMAGE2 VARCHAR2(1000),                         -- 이미지 2
  IMAGE3 VARCHAR2(1000),                         -- 이미지 3
  
  -- 외래키 지정 : 매물 번호 - 1:1 식별 관계
  CONSTRAINT FK_REAL_ESTATE_INFO_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 발행 정보
CREATE TABLE PUBLICATION_INFO (
  LISTING_NUMBER NUMBER(8) PRIMARY KEY,         -- 매물번호
  SUBJECT VARCHAR2(300) NOT NULL,               -- 공모대상
  TYPE VARCHAR2(30) NOT NULL,                   -- 증권 종류
  PUBLISHER VARCHAR2(30) NOT NULL,              -- 발행인
  VOLUME NUMBER(10) NOT NULL,                   -- 발행 증권 수
  ISSUE_PRICE NUMBER(7) NOT NULL,               -- 발행가액
  TOTAL_AMOUNT NUMBER(12) NOT NULL,             -- 총 모집액
  START_DATE DATE NOT NULL,                     -- 청약 시작일
  EXPIRATION_DATE DATE NOT NULL,                -- 청약 만료일
  FIRST_DIVIDEND_DATE DATE NOT NULL,            -- 최초 배당 기준일
  DIVIDEND_CYCLE VARCHAR2(10) NOT NULL,         -- 배당 주기
  DIVIDEND NUMBER(5) NOT NULL,                  -- 배당액
  
  -- 외래키 지정 : 매물번호 - 1:1 식별관계
  CONSTRAINT FK_RPUBLICATION_INFO_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 임차인 정보
CREATE TABLE TENANT_INFO (
  LISTING_NUMBER NUMBER(8) PRIMARY KEY,         -- 매물번호
  LESSEE VARCHAR(30) NOT NULL,                  -- 임차인명
  SECTOR VARCHAR(30) NOT NULL,                  -- 업종
  CONTRACT_DATE DATE NOT NULL,                  -- 계약 시작일
  EXPIRATION_DATE DATE NOT NULL,                -- 계약 종료일
  
  -- 외래키 지정 : 매물번호 - 1:1 식별관계
  CONSTRAINT FK_TENANT_INFO_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 매각 완료 건물
CREATE TABLE SOLD_BUILDING (
  LISTING_NUMBER NUMBER(8) PRIMARY KEY,         -- 매물번호
  SOLD_DATE DATE DEFAULT SYSDATE NOT NULL,      -- 매각일
  AMOUNT NUMBER(13) NOT NULL,                   -- 매각액
  
  -- 외래키 지정 : 매물번호 - 1:1 식별관계
  CONSTRAINT FK_SOLD_BUILDING_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 주문
CREATE TABLE STO_ORDERS (
  ORDER_ID NUMBER(8) DEFAULT ORDER_SEQ.NEXTVAL PRIMARY KEY,     -- 주문번호
  LISTING_NUMBER NUMBER(8),                                     -- 매물번호
  WALLET_NUMBER NUMBER(8),                                      -- 지갑번호
  ORDER_TYPE VARCHAR2(4) NOT NULL,                              -- 주문 유형
  AMOUNT NUMBER(8) NOT NULL,                                    -- 주문 금액
  QUANTITY NUMBER(8) NOT NULL,                                  -- 주문 수량
  STATUS VARCHAR2(10) DEFAULT 'N',                              -- 주문 상태
  ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,                     -- 주문일시
  EXECUTED_PRICE_AVG DEFAULT 0,                                 -- 체결 가격 평균
  EXECUTED_QUANTITY DEFAULT 0,                                  -- 체결 수량
  -- 외래키 지정 : 매물번호, 회원 아이디
  CONSTRAINT FK_ORDER_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER),
  CONSTRAINT FK_ORDER_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER)
);

-- 호가
CREATE TABLE ORDER_BOOK (
  ID NUMBER(8) DEFAULT OB_SEQ.NEXTVAL PRIMARY KEY,              -- 호가번호
  LISTING_NUMBER NUMBER(8),                                     -- 매물번호
  TYPE VARCHAR2(4) NOT NULL,                                    -- 매수매도 유형
  PRICE NUMBER(8) NOT NULL,                                     -- 호가 가격
  AMOUNT NUMBER(8) DEFAULT 0 NOT NULL,                                    -- 거래량
  
  -- 외래키 지정 : 매물번호
  CONSTRAINT FK_ORDER_BOOK_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 체결
CREATE TABLE Execution (
    execution_id NUMBER(8) DEFAULT EID_SEQ.NEXTVAL PRIMARY KEY,   -- 체결 ID (자동 증가)
    buy_order_id NUMBER(8) NOT NULL,                              -- 매수 주문 ID
    sell_order_id NUMBER(8) NOT NULL,                             -- 매도 주문 ID
    executed_price NUMBER(8) NOT NULL,                            -- 체결 가격
    executed_quantity NUMBER(8) NOT NULL,                         -- 체결 수량
    execution_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,  -- 체결 일시
    
    -- 외래키 지정 : 매수 주문 번호
    CONSTRAINT FK_EXECUTION_BUY_ORDER_ID FOREIGN KEY (buy_order_id) REFERENCES STO_ORDERS(order_id)
    -- 외래키 지정 : 매도 주문 번호
    CONSTRAINT FK_EXECUTION_SELL_ORDER_ID FOREIGN KEY (sell_order_id) REFERENCES STO_ORDERS(order_id)
);

-- 보유 토큰 (다대다 관계 중간 연결)
CREATE TABLE STOS (
  WALLET_NUMBER NUMBER(8),                    -- 지갑번호
  LISTING_NUMBER NUMBER(8),                   -- 매물번호
  AMOUNT NUMBER(8) default 0 NOT NULL,        -- 보유수량
  
  -- 복합 기본키 설정 : 지갑 번호, 매물번호
  CONSTRAINT PK_STOS PRIMARY KEY (WALLET_NUMBER, LISTING_NUMBER),
  -- 외래키 지정 : 지갑번호, 매물번호 - 식별관계
  CONSTRAINT FK_STOS_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER),
  CONSTRAINT FK_STOS_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 배당금 지급내역
CREATE TABLE DIVIDEND_DETAILS (
  PAYOUT_NUMBER NUMBER(8) DEFAULT PN_SEQ.NEXTVAL PRIMARY KEY,       -- 배당금 지급 번호
  WALLET_NUMBER NUMBER(8) NOT NULL,                                  -- 지갑 번호
  LISTING_NUMBER NUMBER(8) NOT NULL,                                -- 매물 번호
  PAYOUT NUMBER(8) NOT NULL,                                        -- 지급액
  PAYOUT_DATE DATE DEFAULT SYSDATE NOT NULL,                        -- 지급일
  
  -- 외래키 지정 : 회원 아이디, 매물 번호
  CONSTRAINT FK_DIVIDEND_DETAILS_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER),
  CONSTRAINT FK_DIVIDEND_DETAILS_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 공모 청약
CREATE TABLE PUBLIC_OFFERING (
  PUBLIC_OFFERING_ID NUMBER(8) DEFAULT POI_SEQ.NEXTVAL PRIMARY KEY, -- 청약번호
  LISTING_NUMBER NUMBER(8) NOT NULL,                                -- 매물번호
  WALLET_NUMBER NUMBER(8) NOT NULL,                                 -- 지갑번호
  QUANTITY NUMBER(8) NOT NULL,                                      -- 수량
  
  -- 외래키 지정 : 회원 아이디, 매물번호
  CONSTRAINT FK_PUBLIC_OFFERING_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER),
  CONSTRAINT FK_PUBLIC_OFFERING_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 매각 투표
CREATE TABLE SELL_VOTE (
  ID NUMBER(8) DEFAULT SV_SEQ.NEXTVAL PRIMARY KEY,      -- 매각투표번호
  LISTING_NUMBER NUMBER(8) NOT NULL,                    -- 매물번호
  WALLET_NUMBER NUMBER(8) NOT NULL,                      -- 지갑번호
  PROS_CONS VARCHAR2(10) NOT NULL,                      -- 찬반여부
  QUANTITY NUMBER(8) NOT NULL,                          -- 수량
  SELL_VOTE_DATE DATE DEFAULT SYSDATE NOT NULL,         -- 투표일
  
  -- 외래키 지정 : 회원 아이디, 매물번호
  CONSTRAINT FK_SELL_VOTE_WALLET_NUMBER FOREIGN KEY (WALLET_NUMBER) REFERENCES WALLET(WALLET_NUMBER),
  CONSTRAINT FK_SELL_VOTE_LISTING_NUMBER FOREIGN KEY (LISTING_NUMBER) REFERENCES REAL_ESTATE_SALE(LISTING_NUMBER)
);

-- 공지사항
CREATE TABLE ANNOUNCEMENT (
  ID NUMBER(8) DEFAULT ANNOUNCEMENT_SEQ.NEXTVAl PRIMARY KEY,    -- 공지사항번호
  TITLE VARCHAR2(300) NOT NULL,                                 -- 제목
  CONTENT VARCHAR2(1000) NOT NULL,                              -- 내용
  WRITE_DATE DATE DEFAULT SYSDATE NOT NULL,                     -- 등록일
  COUNT NUMBER(8) DEFAULT 0 NOT NULL                            -- 조회수
);

-- 공통코드M
CREATE TABLE COMMON_CODE_M (
  NAME VARCHAR2(30) PRIMARY KEY     -- 공통코드명
);

-- 공통코드D
CREATE TABLE COMMON_CODE_D (
  CODE VARCHAR2(30) PRIMARY KEY,    -- 공통코드
  NAME VARCHAR2(30) NOT NULL,       -- 공통코드명
  VALUE VARCHAR2(30) NOT NULL,      -- 코드 값
  
  -- 외래키 지정 : 공통코드명
  CONSTRAINT FK_COMMON_CODE_NAME FOREIGN KEY (NAME) REFERENCES COMMON_CODE_M(NAME)
);

-- 시스템 예외 로그
CREATE TABLE EXCEPTION_LOG (
  ID NUMBER(8) DEFAULT LOG_SEQ.NEXTVAL PRIMARY KEY, -- 예외 로그
  LOG_CODE VARCHAR2(20),                            -- 로그 코드
  OCCUR_DATE DATE DEFAULT SYSDATE,                  -- 발생일시
  PROGRAM VARCHAR2(30),                             -- 발생프로그램
  MSG VARCHAR2(10000),                              -- 에러메시지
  NOTE VARCHAR2(50)                                 -- 비고
);