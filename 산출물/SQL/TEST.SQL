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

