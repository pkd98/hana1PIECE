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


-- 매물 등록
INSERT INTO REAL_ESTATE_SALE(STATE) VALUES ('청약');

-- 최근 매물 번호 가져오기
select * from (select listing_number from real_estate_sale order by LISTING_NUMBER desc) where rownum = 1;

INSERT INTO TENANT_INFO(LISTING_NUMBER, LESSEE, SECTOR, CONTRACT_DATE, EXPIRATION_DATE)
VALUES(1, 'test', 'test', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-02', 'YYYY-MM-DD'));

desc real_estate_sale;

select * from REAL_ESTATE_SALE;
select * from REAL_ESTATE_INFO;
select * from TENANT_INFO;
select * from PUBLICATION_INFO;

truncate table PUBLICATION_INFO;
truncate table TENANT_INFO;
truncate table REAL_ESTATE_INFO;
truncate table REAL_ESTATE_SALE;

select REI.LISTING_NUMBER as listingNumber, REI.IMAGE1 as image1, REI.IMAGE2 as image2, REI.IMAGE3 as image3, REI.BUILDING_NAME as buildingName, res.INTRODUCTION as introduction
from real_estate_sale res INNER JOIN real_estate_info rei
ON res.listing_number = rei.LISTING_NUMBER
where state = '청약';

select REI.LISTING_NUMBER as listingNumber, REI.IMAGE1 as image1, REI.IMAGE2 as image2, REI.IMAGE3 as image3, REI.BUILDING_NAME as buildingName,res.EVALUATION as evaluation
from real_estate_sale res INNER JOIN real_estate_info rei
ON res.listing_number = rei.LISTING_NUMBER
where state = '거래';

select * from PUBLIC_OFFERING;

select pi.listing_number as listingNumber, WALLET_NUMBER as walletNumber, QUANTITY, image1, BUILDING_NAME as buildingName, EXPIRATION_DATE as expirationDate
from (select po.listing_number as listing_number, po.wallet_number, po.QUANTITY, rei.BUILDING_NAME, rei.IMAGE1
from PUBLIC_OFFERING po inner join real_estate_info rei 
on po.LISTING_NUMBER = rei.LISTING_NUMBER) a inner join PUBLICATION_INFO pi
on a.listing_number = pi.LISTING_NUMBER
where wallet_number = 6;