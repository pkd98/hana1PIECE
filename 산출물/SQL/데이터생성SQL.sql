REM  ***************************************************************************
REM  제목 : [최종프로젝트] 하나1PIECE 조각투자 플랫폼 : 더미 데이터 생성 스크립트
REM  작성자 : 박경덕
REM  작성 일자 : 2023-08-08 최초 작성
REM  ***************************************************************************
REM                             회원 가입 시나리오
REM  ***************************************************************************

--------------------------------------------------------------------------------
-- 회원가입 : 회원 데이터 생성
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
-- 계좌 개설 및 지갑 연동 : 회원 계좌 개설 및 조각투자 지갑 연동 + 추천인 적용 -> 5000원 입금
--------------------------------------------------------------------------------






--------------------------------------------------------------------------------
-- 하나은행 계좌 현금 입금 (미구현)
--------------------------------------------------------------------------------





--------------------------------------------------------------------------------
-- 지갑 현금 입금 : 계좌에 연동된 지갑에 현금 입금 - 마이페이지
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------
REM  ***************************************************************************
REM                            관리자 페이지 시나리오
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 관리자 계정 등록
--------------------------------------------------------------------------------
INSERT INTO MANAGER (ID, NAME, PASSWORD, ENROLL_DATE)
VALUES ('admin', '박경덕', 'admin', TO_DATE('2023-08-08', 'YYYY-MM-DD'));




select * from manager;
rollback;
commit;
