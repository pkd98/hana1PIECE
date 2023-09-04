select * from ANNOUNCEMENT;
insert into ANNOUNCEMENT(title, CONTENT) VALUES ('test', 'test');
commit;

desc ANNOUNCEMENT;


SELECT * FROM (
    SELECT a.*, ROWNUM rnum FROM (
        SELECT * FROM announcement ORDER BY write_date DESC
    ) a WHERE ROWNUM <= (10 * 1)
)
WHERE rnum > 10 * (1 - 1);

select count(*) from ANNOUNCEMENT;