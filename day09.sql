CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 1, '¿øÀ¯Á¦¿Ü ¼®À¯·ù');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 2, 'ÀÚµ¿Â÷');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 3, 'ÀüÀÚÁýÀûÈ¸·Î');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 4, '¼±¹Ú');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 6,  'ÀÚµ¿Â÷ºÎÇ°');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 7,  'ÈÞ´ëÀüÈ­');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 8,  'È¯½ÄÅºÈ­¼ö¼Ò');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 9,  '¹«¼±¼Û½Å±â µð½ºÇÃ·¹ÀÌ ºÎ¼ÓÇ°');
INSERT INTO exp_goods_asia VALUES ('ÇÑ±¹', 10,  'Ã¶ ¶Ç´Â ºñÇÕ±Ý°­');

INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 1, 'ÀÚµ¿Â÷');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 2, 'ÀÚµ¿Â÷ºÎÇ°');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 3, 'ÀüÀÚÁýÀûÈ¸·Î');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 4, '¼±¹Ú');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 5, '¹ÝµµÃ¼¿þÀÌÆÛ');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 6, 'È­¹°Â÷');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 7, '¿øÀ¯Á¦¿Ü ¼®À¯·ù');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 8, '°Ç¼³±â°è');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 9, '´ÙÀÌ¿Àµå, Æ®·£Áö½ºÅÍ');
INSERT INTO exp_goods_asia VALUES ('ÀÏº»', 10, '±â°è·ù');

COMMIT;
select seq, goods
from exp_goods_asia
where country = 'ÇÑ±¹'
union   -- Á¾º¹ Á¦°ÅµÊ
select seq, goods
from exp_goods_asia
where country = 'ÀÏº»'
union
SELECT 10, 'ÄÄÇ»ÅÍ'
FROM dual;

select goods
from exp_goods_asia
where country = 'ÇÑ±¹'
union all   -- ÀüÃ¼ Ãâ·Â °áÇÕ
select goods
from exp_goods_asia
where country = 'ÀÏº»';



select goods
from exp_goods_asia
where country = 'ÇÑ±¹'
intersect -- ±³ÁýÇÕ
select goods
from exp_goods_asia
where country = 'ÀÏº»';

select goods
from exp_goods_asia
where country = 'ÇÑ±¹'
intersect -- ±³ÁýÇÕ
select goods
from exp_goods_asia
where country = 'ÀÏº»';

select goods
from exp_goods_asia
where country = 'ÇÑ±¹'
minus -- Â÷ÁýÇÕ
select goods
from exp_goods_asia
where country = 'ÀÏº»';
--ORACLE ÁýÇÕÀº Ãâ·Â ÄÃ¸²ÀÇ ¼ö¿Í Å¸ÀÔÀÌ °°¾Æ¾ßÇÔ
--Á¤·ÄÀº ¸¶Áö¸· SELECT¹®¿¡¸¸ »ç¿ë
SELECT TO_CHAR(department_id) AS ºÎ¼­
,COUNT(*) ºÎ¼­º°Á÷¿ø¼ö
FROM EMPLOYEES
GROUP BY department_id
SELECT 'ÀüÃ¼' 
COUNT(*) AS ÀüÃ¼Á÷¿ø¼ö
FROM EMPLOYEES;

--¼ö°­³»¿ªÀÌ ¾ø´Â ÇÐ»ý Á¶È¸
select *
from ÇÐ»ý a
where not exists (select *
from ¼ö°­³»¿ª b
where b.ÇÐ¹ø = a.ÇÐ¹ø);

/*Á¤±Ô Ç¥Çö½Ä '°Ë»ö','Ä¡È¯' ÇÏ´Â °úÁ¤À» °£ÆíÇÏ°Ô Ã³¸®ÇÒ ¼ö ÀÖµµ·Ï ÇÏ´Â ¼ö´Ü
  oracleÀº 10g ºÎÅÍ »ç¿ë (java, python, js ´Ù Á¤±ÔÇ¥Çö½Ä »ç¿ë°¡´É)Á¶±Ý¾¿ ´Ù¸§
  .(dot) or [] Àº ¸ðµç ¹®ÀÚ 1±ÛÀÚ¸¦ ÀÇ¹ÌÇÔ
   ^ <-- ½ÃÀÛÀ» ÀÇ¹ÌÇÔ ^[0-9] <-- ¼ýÀÚ·Î ½ÃÀÛÇÏ´Â 
   [^0-9] <-- ´ë°ýÈ£ ¾ÈÀÇ ^ <-- notÀ» ÀÇ¹ÌÇÔ*/
  --REGEXP_LIKE : Á¤±Ô½Ä ÆÐÅÏÀ» °Ë»ö
select *
from member
where REGEXP_LIKE(mem_comtel, '^..-');
--¿µ¹®ÀÚ 3¹ø ÃâÇö ÈÄ @ ÆÐÅÏ Á¶È¸ (abc@gmail.com)
/*¹Ýº¹½ÃÄö½º
* : 0°³ÀÌ»ó
+ : 1°³ÀÌ»ó
? : 0,1°³
{n} : n¹ø
{n,} : n¹ø ÀÌ»ó
{n, m} : n¹ø ÀÌ»ó m¹ø ÀÌÇÏ
*/
select*
from member
where REGEXP_LIKE(mem_mail, '^[a-zA-Z]{3,5}@');
-- mem_add2 ¹®ÀÚ ¶ç¾î¾²±â ¹®ÀÚ ÆÐÅÏÀÇ µ¥ÀÌÅÍ¸¦ Ãâ·ÂÇÏ½Ã¿À
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '. .'); -- ¾î´À ¹®ÀÚµç

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '[°¡-ÆR]$'); -- ÇÑ±Û·Î ³¡³ª´Â

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[°¡-ÆR]*$'); -- ÇÑ±Û·Î ³¡³ª´Â

--ÇÑ±ÛÀÌ ¾ø´Â ÁÖ¼Ò°Ë»ö
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[^°¡-ÆR]*$');
-- | <-- ¶Ç´Â
-- () <-- ÆÐÅÏ±×·ì
-- J·Î ½ÃÀÛÇÏ¸ç, ¼¼¹øÂ° ¹®ÀÚ°¡ M¶Ç´Â NÀÎ Á÷¿øÀÌ¸§ Á¶È¸ÇÏ±â

select emp_name
from employees
where regexp_like(emp_name, 'J.(n|m)');

--REGEXP_SUBSTR Á¤±ÔÇ¥Çö½Ä ÆÐÅÏÀ» ÀÏÄ¡ÇÏ´Â ¹®ÀÚ¿­ ¹ÝÈ¯
--ÀÌ¸ÞÀÏ @¸¦ ±âÁØÀ¸·Î ¾Õ°ú µÚ ¸¦ Ãâ·ÂÇÏ½Ã¿À
--ÆÐÅÏ, ½ÃÀÛÀ§Ä¡, ¸ÅÄª¼ø¹ø
SELECT REGEXP_SUBSTR(MEM_MAIL, '[^@]+', 1, 1) AS MEM_ID
,REGEXP_SUBSTR(MEM_MAIL, '[^@]+', 1, 2) AS MEM_DOMAIN
FROM MEMBER;

SELECT REGEXP_SUBSTR('A1233-B-C', '[^-]+', 1, 1) AS a
,REGEXP_SUBSTR('A1233-B-C', '[^-]+', 1, 2) AS b
,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) AS c
from dual;

select regexp_substr('pang su hi 1234', '[0-9]')--default 1,1
,regexp_substr('pang su hi 1234', '[^0-9]')
,regexp_substr('pang su hi 1234', '[^0-9]+')
from dual;

select mem_add1 --¶ç¾î¾²±â¸¦ ±âÁØÀ¸·Î 2¹øÂ° ÃâÇöÇÏ´Â ÁÖ¼Ò¸¦ Ãâ·ÂÇÏ½Ã¿ä
from member;
select REGEXP_SUBSTR(MEM_add1, '[^ ]+', 1, 2)
from member;

select *
from(
select 'abcd1234' as id from dual
union
select 'Abcd123456' as id from dual
union
select 'A1234' as id from dual
union
select 'A123456789' as id from dual
)
where regexp_like(id, '^.{8,14}$'); -- 8~ 14 »çÀÌ ÅØ½ºÆ® ¸¸Á·ÇÏ´Â µ¥ÀÌÅÍ Ãâ·Â

