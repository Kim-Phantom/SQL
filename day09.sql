CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('한국', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('한국', 6,  '자동차부품');
INSERT INTO exp_goods_asia VALUES ('한국', 7,  '휴대전화');
INSERT INTO exp_goods_asia VALUES ('한국', 8,  '환식탄화수소');
INSERT INTO exp_goods_asia VALUES ('한국', 9,  '무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia VALUES ('한국', 10,  '철 또는 비합금강');

INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');

COMMIT;
select seq, goods
from exp_goods_asia
where country = '한국'
union   -- 종복 제거됨
select seq, goods
from exp_goods_asia
where country = '일본'
union
SELECT 10, '컴퓨터'
FROM dual;

select goods
from exp_goods_asia
where country = '한국'
union all   -- 전체 출력 결합
select goods
from exp_goods_asia
where country = '일본';



select goods
from exp_goods_asia
where country = '한국'
intersect -- 교집합
select goods
from exp_goods_asia
where country = '일본';

select goods
from exp_goods_asia
where country = '한국'
intersect -- 교집합
select goods
from exp_goods_asia
where country = '일본';

select goods
from exp_goods_asia
where country = '한국'
minus -- 차집합
select goods
from exp_goods_asia
where country = '일본';
--ORACLE 집합은 출력 컬림의 수와 타입이 같아야함
--정렬은 마지막 SELECT문에만 사용
SELECT TO_CHAR(department_id) AS 부서
,COUNT(*) 부서별직원수
FROM EMPLOYEES
GROUP BY department_id
SELECT '전체' 
COUNT(*) AS 전체직원수
FROM EMPLOYEES;

--수강내역이 없는 학생 조회
select *
from 학생 a
where not exists (select *
from 수강내역 b
where b.학번 = a.학번);

/*정규 표현식 '검색','치환' 하는 과정을 간편하게 처리할 수 있도록 하는 수단
  oracle은 10g 부터 사용 (java, python, js 다 정규표현식 사용가능)조금씩 다름
  .(dot) or [] 은 모든 문자 1글자를 의미함
   ^ <-- 시작을 의미함 ^[0-9] <-- 숫자로 시작하는 
   [^0-9] <-- 대괄호 안의 ^ <-- not을 의미함*/
  --REGEXP_LIKE : 정규식 패턴을 검색
select *
from member
where REGEXP_LIKE(mem_comtel, '^..-');
--영문자 3번 출현 후 @ 패턴 조회 (abc@gmail.com)
/*반복시퀀스
* : 0개이상
+ : 1개이상
? : 0,1개
{n} : n번
{n,} : n번 이상
{n, m} : n번 이상 m번 이하
*/
select*
from member
where REGEXP_LIKE(mem_mail, '^[a-zA-Z]{3,5}@');
-- mem_add2 문자 띄어쓰기 문자 패턴의 데이터를 출력하시오
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '. .'); -- 어느 문자든

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '[가-힣]$'); -- 한글로 끝나는

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[가-힣]*$'); -- 한글로 끝나는

--한글이 없는 주소검색
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[^가-힣]*$');
-- | <-- 또는
-- () <-- 패턴그룹
-- J로 시작하며, 세번째 문자가 M또는 N인 직원이름 조회하기

select emp_name
from employees
where regexp_like(emp_name, 'J.(n|m)');

--REGEXP_SUBSTR 정규표현식 패턴을 일치하는 문자열 반환
--이메일 @를 기준으로 앞과 뒤 를 출력하시오
--패턴, 시작위치, 매칭순번
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

select mem_add1 --띄어쓰기를 기준으로 2번째 출현하는 주소를 출력하시요
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
where regexp_like(id, '^.{8,14}$'); -- 8~ 14 사이 텍스트 만족하는 데이터 출력

