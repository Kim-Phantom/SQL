/*
   주석설정
   1.테이블명 컬럼명의 최대 크기는 30 바이트
   2.테이블명 컬럼명으로 예약어는 사용할 수 없다
   3.테이블명 컬럼명으로 문자, 숫자, $,%을 사용할 수 있지만 첫 글자는 문자만 올 수 있음.
   4.한 테이블에 사용가능한 컬럼은 최대 255개까지
   */
   CREATE TABLE ex2_1(
   col1 CHAR(10),
   col2 VARCHAR2(10) --컬럼을 , <--로 구분 하나의 컬럼에는 하나의 타입과 사이즈를 가짐
   );
-- INSERT 데이터 삽입
INSERT INTO ex2_1(col1, col2)
VALUES('abc','abc');
--select 데이터 조회
SELECT col1
    , LENGTH(col1)  --char는 고졍형
    , col2
    , LENGTH(col2)
FROM ex2_1;
-- 데이터 조직어(DML, DATA Manipilation Language)
-- 조회 select 삽입 INSERT수정 UPDATE, 삭제 DELETE
SELECT * --*전체 칼럼을 의미함
FROM employees;
--특정 칼럼만 조회
SELECT emp_name --컬럼의 구분은 ,
        , email
FROM employees;
--allas(별칭, 가명)as
SELECT emp_name as nm
    , hire_date hd  -- 별칭은 as를 붙이고 쓰지만 디폴트로 인식됨
    , salary 봉급    -- 한글도 사용 가능하지만 영문 지향
    , department_id "부서 아이디" --띄어쓰기를 포험하려면 "" <-사용
FROM employees;    -- 띄어쓰기는 안쓰는게 좋음 __ <-사용
--검색 조건이 있다면 where절 사용
SELECT emp_name
      , salary
FROM employees
WHERE salary >= 12000; -- salary가 12000 이상 --검색조건이 여러개면 and, or를 사용
SELECT emp_name
     , salary
     , department_id
FROM employees
WHERE salary >= 12000
AND department_id = 90;
--정렬 조건 ORDER BY default [ASC 오름차순], 내림차순으로 정렬은 DESC
SELECT *
FROM departments
ORDER BY department_id; -- 디폴트 ASC
SELECT *
FROM departments
ORDER BY department_id DESC; --내림차순

SELECT emp_name -- 1
      ,salary   -- 2
FROM employees
ORDER BY salary desc, emp_name;

SELECT emp_name -- 1
      ,salary   -- 2
FROM employees
ORDER BY 2 desc, 1; -- 위에와 같은 값이 나옴

SELECT emp_name -- 1
      ,salary   -- 2
FROM employees
ORDER BY hire_date; -- 위 3개와 같은 명령어 마지막은 잘 쓰이지 않음

--수식 연산자 : + - * /
SELECT employee_id                  as 직원아이디
      , emp_name                    as 직원이름
      , salary / 30                 as 일당
      , salary                      as 월급
      , salary - salary * 0.1       as 실수령액
      , salary * 12                 as 연봉
FROM employees;
--논리 연산자
SELECT * FROM employees WHERE salary = 2600;  --같다
SELECT * FROM employees WHERE salary <> 2600; --같지 않다
SELECT * FROM employees WHERE salary != 2600; --같지 않다
SELECT * FROM employees WHERE salary < 2600;  --미만
SELECT * FROM employees WHERE salary > 2600; -- 초과
SELECT * FROM employees WHERE salary <= 2600;  --이하
SELECT * FROM employees WHERE salary >= 2600; --이상
--departments 테이블에서 30 부서를 조회하시오
select *
FROM departments
where department_id = 30
or department_id = 60;
--PRODUCTS 테이블에서 '상품 최저 금액(PROD_MIN_PRICE)'가 30원 "이상" 50원 "미만" 의 상품명과,카테고리, 최저금액을 출력
SELECT PROD_NAME,prod_subcategory, PROD_MIN_PRICE 
FROM products
WHERE PROD_MIN_PRICE >= 30
AND PROD_MIN_PRICE <= 50
ORDER BY prod_subcategory, PROD_MIN_PRICE DESC;
--표현식:원하는 표현으로 변경 CASE WHEN 조건1 THEN 해당조건변경 표현
                             --WHEN 조건2 THEN 해당조건변경 표현
                             --END AS 별칭
SELECT cust_name
       , cust_gender
       , CASE WHEN cust_gender = 'M' THEN '남자'
              WHEN cust_gender = 'F' THEN '여자'
              ELSE '??'
            END AS gender
FROM customers;            
      
SELECT employee_id
      , emp_name
      , CASE WHEN salary <= 5000 THEN 'C등급'
             WHEN salary > 5000 and salary <= 15000 THEN 'B등급'
             ELSE 'A등급'
        END AS grade
FROM employees;        
-- BETWEEN AND 조건식
SELECT employee_id
      ,salary
FROM employees --2000 ~ 2500
WHERE salary BETWEEN 2000 AND 2500;
--IN 조건식 OR 의 의미
SELECT employee_id, salary, department_id
FROM employees
WHERE department_id IN(90, 80, 10); -- 90 OR 80 OR 10
--문자열 연산자 || <-- +
SELECT emp_name || ':' || employee_id as 이름사번
FROM employees;
-- ** 많이 사용 LIKE
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%'; ---A 로 시작하는
SELECT emp_name
FROM emplyees
WHERE emp_name LIKE '%d'; -- d로 끝나는
SELECT emp_name
FROM emplyee
WHERE emp_name LIKE '%NA%'; -- NA가 포함되어있는
--
SELECT emp_name
FROM emplyee
WHERE department_id = :a
OR department_id = :b;      -- 콜론 :이름 <-- 바인드
                            -- 여러 값을 테스트해볼때 사용


SELECT emp_name
FROM emplyee
WHERE emp_name LIKE '%'||:val||'%';     -- %값%


CREATE TABLE ex2_2 (
       nm VARCHAR2(20)
);
INSERT INTO ex2_2 VALUES('길동');
INSERT INTO ex2_2 VALUES('홍길동');
INSERT INTO ex2_2 VALUES('길동홍');
INSERT INTO ex2_2 VALUES('홍길동상');
-- 홍길로 시작하는 3글자 조회
SELECT *
FROM ex2_2
WHERE nm LIKE '홍길%';   -- 홍길 들어간 값 추출
--WHERE NM LIKE '__'; --언더바는 자릿수 의미


CREATE TABLE students (

stu_id VARCHAR2(12) /* 학번 */
, stu_grade NUMBER(1)/* 학년 */
, stu_semester NUMBER(1) /* 학기 */
, stu_name VARCHAR2(10) /* 학생 이름 */
, stu_birth VARCHAR2(10) /* 학생 생년월일 */
, stu_kor NUMBER(3) /* 국어 점수 */
, stu_eng NUMBER(3) /* 영어 점수 */
, stu_math NUMBER(3) /* 수학 점수 */
, CONSTRAINTS stu_pk PRIMARY KEY (stu_id, stu_grade, stu_semester)
);


SELECT stu_name, stu_grade, (stu_kor + stu_eng + stu_math) /3 as subject_avg
FROM students --1학년 김씨만 조회하시요
WHERE stu_grade =1  AND (stu_kor + stu_eng + stu_math) /3 >= 90;



SELECT CUST_NAME
,CUST_CITY
,CUST_MARITAL_STATUS
,CUST_GENDER
,CUST_YEAR_OF_BIRTH
,CUST_STREET_ADDRESS
FROM CUSTOMERS
WHERE CUST_CITY = 'Los Angeles'
AND CUST_MARITAL_STATUS = 'single' 
AND CUST_GENDER = 'F' 
AND CUST_YEAR_OF_BIRTH >= 1983
ORDER BY CUST_YEAR_OF_BIRTH DESC, CUST_NAME ASC;

