INSERT INTO MANAGER (ID, NAME, PASSWORD, ENROLL_DATE, IMAGE, POSITION, INTRODUCTION)
VALUES ('admin', '관리자', 'admin', TO_DATE('2023-08-08', 'YYYY-MM-DD'), 'manager.jpg', 'Web Back-end Developer', '매사 긍정적이고 성실하게 배우려 노력하는<br>IT 개발자입니다.');

select * from account;

-- 계좌 입금
BEGIN
    hana_bank_mng.deposit(
    p_account_number => '99900000016394',
    p_amount=>500000000,
    p_name=>'무통장 입금',
    p_recipient_account_number=>'CD'
    );
END;
/


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

select HANA1PIECE_MNG.GENERATE_REFERRAL_CODE from dual;

select * from EXCEPTION_LOG;


select * from account;
delete from account where not ACCOUNT_NUMBER = 99900000009394;
select * from BANK_TRANSACTION;

select * from wallet;
select * from WALLET_TRANSACTION;

update wallet set BALANCE = BALANCE + 10000000000 where wallet_number = 6;

select * from WALLET_TRANSACTION;
desc WALLET_TRANSACTION;


commit;


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

select * from REAL_ESTATE_SALE where state='청약';

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


select listingNumber, walletNumber, QUANTITY, image1, buildingName, expirationDate, state from
        (select pi.listing_number  as listingNumber,
               WALLET_NUMBER   as walletNumber,
               QUANTITY,
               image1,
               BUILDING_NAME   as buildingName,
               EXPIRATION_DATE as expirationDate
        from (select po.listing_number as listing_number, po.wallet_number, po.QUANTITY, rei.BUILDING_NAME, rei.IMAGE1
              from PUBLIC_OFFERING po
                       inner join real_estate_info rei
                                  on po.LISTING_NUMBER = rei.LISTING_NUMBER) a
                 inner join PUBLICATION_INFO pi
                            on a.listing_number = pi.LISTING_NUMBER) b inner join REAL_ESTATE_SALE RES
                                on b.LISTINGNUMBER = RES.LISTING_NUMBER
        where walletNumber = 6 and state = '청약';





select count(WALLET_NUMBER) AS countWalletNumber, NVL(sum(quantity), 0) as sumQuantity
from public_offering
where LISTING_NUMBER = 19;



select NVL(SUM(QUANTITY), 0) / VOLUME ,count(WALLET_NUMBER) AS countWalletNumber, NVL(sum(quantity), 0) as sumQuantity
from (select PUBLIC_OFFERING.LISTING_NUMBER, WALLET_NUMBER, QUANTITY,volume
from PUBLICATION_INFO inner join PUBLIC_OFFERING
on publication_info.listing_number = PUBLIC_OFFERING.LISTING_NUMBER)
where LISTING_NUMBER = 19;


select * from (
select res.LISTING_NUMBER as listingNumber, evaluation, introduction, price, state, building_name as buildingName, image1 from REAL_ESTATE_SALE res inner join REAL_ESTATE_INFO rei
on res.listing_number = rei.listing_number)
where state = '거래';

update order_book set amount = 1
where listing_number = 20 and type = 'SELL' and price >= 5000;
update order_book set amount = 1
where listing_number = 20 and type = 'BUY' and price < 5000;

update order_book set amount = 0;
commit;

select * from order_book;
select * from order_book where listing_number = 20 and amount > 0 and type = 'SELL' order by price desc;
select * from order_book where listing_number = 20 and amount > 0 and type = 'BUY' order by price desc;

        update order_book set amount = amount + 10
        where listing_number = 20 and type = 'BUY' and price = 4990;

select * from EXECUTION;
select * from STO_ORDERS;
select * from stos;


update stos set amount = 100
where WALLET_NUMBER = 6 and LISTING_NUMBER = 20;
select * from stos;

select * from RESERVATION_ORDERS;
desc RESERVATION_ORDERS;

select * from reservation_orders
where wallet_number = 6 and not status = 'T'
order by id desc;

select * from REAL_ESTATE_INFO;


select * from stos;
select * from PUBLIC_OFFERING;
delete from PUBLIC_OFFERING where WALLET_NUMBER = 6;
commit;

select * from REAL_ESTATE_SALE;

-- 토큰 현재 가격
select LISTING_NUMBER, PRICE as currentPrice FROM REAL_ESTATE_SALE;

-- 빌딩명
select LISTING_NUMBER, BUILDING_NAME as buildingName FROM REAL_ESTATE_INFO;

-- 보유 토큰 수량
select * from STOS where WALLET_NUMBER = :walletNumber;

-- 매수 평균 가격
SELECT 
    LISTING_NUMBER,
    WALLET_NUMBER,
    AVG(EXECUTED_PRICE_AVG) AS avgBuyAmount
FROM 
    STO_ORDERS
WHERE 
    WALLET_NUMBER = :walletNumber
    AND ORDER_TYPE = 'BUY'
    AND NOT STATUS = 'N'
GROUP BY 
    LISTING_NUMBER, WALLET_NUMBER;


-- 매수 평균 가격
SELECT 
    LISTING_NUMBER,
    WALLET_NUMBER,
    EXECUTED_PRICE_AVG * EXECUTED_QUANTITY
FROM 
    STO_ORDERS
WHERE 
    WALLET_NUMBER = :walletNumber
    AND ORDER_TYPE = 'BUY'
    AND NOT STATUS = 'N';


select * from stos;



-- 보유 빌딩 정보
SELECT
    STOS.WALLET_NUMBER as walletNumber,
    RE.LISTING_NUMBER as listingNumber,
    RI.BUILDING_NAME AS buildingName,
    round((STOS.amount * RE.PRICE) - (STOS.amount * STO.avgBuyPrice), 0) as profit,
    round(((STOS.amount * RE.PRICE - STOS.amount * STO.avgBuyPrice) / (STOS.amount * STO.avgBuyPrice))  * 100, 2) as ROI,
    STOS.amount,
    RE.PRICE AS currentPrice,
    STOS.amount * RE.PRICE as assessmentAmount,
    round(STO.avgBuyPrice, 0) as avgBuyPrice
FROM
    REAL_ESTATE_SALE RE
JOIN
    REAL_ESTATE_INFO RI
ON
    RE.LISTING_NUMBER = RI.LISTING_NUMBER
LEFT JOIN
    STOS
ON
    RE.LISTING_NUMBER = STOS.LISTING_NUMBER
    AND STOS.WALLET_NUMBER = :walletNumber
LEFT JOIN
    (
        SELECT
            LISTING_NUMBER,
            WALLET_NUMBER,
            AVG(EXECUTED_PRICE_AVG) AS avgBuyPrice
        FROM
            STO_ORDERS
        WHERE
            WALLET_NUMBER = :walletNumber
            AND ORDER_TYPE = 'BUY'
            AND not STATUS = 'N'
        GROUP BY
            LISTING_NUMBER, WALLET_NUMBER
    ) STO
ON
    RE.LISTING_NUMBER = STO.LISTING_NUMBER
WHERE
    STOS.WALLET_NUMBER = :walletNumber;



select * from REAL_ESTATE_SALE;