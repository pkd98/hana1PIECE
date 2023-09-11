INSERT INTO MANAGER (ID, NAME, PASSWORD, ENROLL_DATE, IMAGE, POSITION, INTRODUCTION)
VALUES ('admin', '관리자', 'admin', TO_DATE('2023-08-08', 'YYYY-MM-DD'), 'manager.jpg', 'Web Back-end Developer', '매사 긍정적이고 성실하게 배우려 노력하는<br>IT 개발자입니다.');


select * from ANNOUNCEMENT;
insert into ANNOUNCEMENT(title, CONTENT) VALUES ('test', 'test');
commit;

desc ANNOUNCEMENT;
desc ONE_MEMBERS;

SELECT * FROM (
    SELECT a.*, ROWNUM rnum FROM (
        SELECT * FROM announcement ORDER BY write_date DESC
    ) a WHERE ROWNUM <= (10 * 1)
)
WHERE rnum > 10 * (1 - 1);

select count(*) from ANNOUNCEMENT;

select * from ONE_MEMBERS;
truncate table ONE_MEMBERS;

select HANA1PIECE_MNG.GENERATE_REFERRAL_CODE from dual;

select * from EXCEPTION_LOG;


select * from account;
delete from account where not ACCOUNT_NUMBER = 99900000009394;
select * from BANK_TRANSACTION;

select * from wallet;

update wallet set BALANCE = BALANCE + 1000000 where wallet_number = 6;

select * from WALLET_TRANSACTION;
desc WALLET_TRANSACTION;

insert into WALLET_TRANSACTION()
VALUES();


commit;


-- 계좌 입금
BEGIN
    hana_bank_mng.deposit(
    p_account_number => '99900000009394',
    p_amount=>500000,
    p_name=>'무통장 입금',
    p_recipient_account_number=>'CD'
    );
END;
/
select * from account;

select * from BANK_TRANSACTION;


select * from manager;