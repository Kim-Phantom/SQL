SELECT *
FROM CART;

SELECT *
FROM MEMBER;


SELECT MEM_NAME
,CART_NO
,CART_PROD
,CART_QTY
FROM MEMBER, CART
WHERE CART.CART_MEMBER = MEMBER.MEM_ID
AND MEMBER.MEM_NAME = '김은대';

/* ANSI JOIN : American National Standards Institute
               미국 표준 SQL 문법형태 (구문이 길어서 실무에서 잘 안씀)
*/

SELECT MEM_NAME
,CART_NO
,CART_PROD
,CART_QTY
FROM MEMBER,
INNER JOIN CART
NO(MEMVER.MEM_ID = CART.CART_MEMBER)
WHERE MEMBER.MEM_NAME = '김은대';

--상품 정보 출력
SELECT MEMBER.MEM_NAME, MEMBER.MEM_ID, CART.CART_MEMBER
,CART.CART_NO
,CART.CART_PROD, PROD.PROD_ID
,CART.CART_QTY
,PROD.PROD_NAME
,PROD.PROD_SALE
FROM MEMBER, CART, PROD
WHERE CART.CART_MEMBER = MEMBER.MEM_ID
AND MEMBER.MEM_NAME = '김은대'
AND CART.CART_PROD = PROD.PROD_ID;

--김은대싸가 구매한 전체 상품의 합계 금액은?
SELECT MEM_NAME
,MEM_ID
,SUM(  CART_QTY * PROD_SALE) AS 합계금액
FROM MEMBER, CART, PROD
WHERE CART.CART_MEMBER = MEMBER.MEM_ID
AND MEMBER.MEM_NAME = '김은대'
AND CART.CART_PROD = PROD.PROD_ID
group by MEM_NAME
,MEM_ID;

SELECT*
FROM PROD;
-- 위에것과 동일한 함수
SELECT MEM_NAME
,MEM_ID
,SUM(  CART_QTY * PROD_SALE) AS 합계금액
FROM MEMBER INNER JOIN CART
ON(MEMBER.MEM_ID = CART.CART_MEMBER)
INNER JOIN PROD
ON (CART.CART_PROD = PROD.PROD_ID)
WHERE MEMBER.MEM_NAME = '김은대'
group by MEM_NAME
,MEM_ID;


-- EMPLOYEES, JOBS 테이블을 활용하여
-- SALARY가 15000 이상인 직원의 사번, 이름, SALARY, 직업 아이디, 직업명을 출력하시요
SELECT *
FROM EMPLOYEES;
SELECT *
FROM JOBS;

SELECT a.EMPLOYEE_ID
,a.EMP_NAME
,a.SALARY
,b.JOB_ID
,b.JOB_TITLE
FROM EMPLOYEES a , jobs b
WHERE a.job_id = b.JOB_ID
and SALARY >= 15000; 

/*서브쿼리 (쿼리안에 쿼리)
1. 스칼라 서브쿼리 (select 절)
2. 인라인 뷰 (from절)
3. 중첩 쿼리 (where절)
*/
--스칼라 서브쿼리는 단일행 반환
--보통 코드값에 이름을 가져올때 많이 사용
--주의할점은 메인쿼리테이블의 행 건수 만큼 서브쿼리를 조회하기 때문에
--서브쿼리의 테이블의 건수가 많으면 자원을 많이 사용하게 됨.(<-- 이럴경우 조인을 이용하는게 더 좋음)
select a.emp_name
,a.department_id
,(select department_name
from departments
where department_id = a.department_id) as dep_name
,a.job_id
,(select job_title
from jobs
where job_id = a.job_id) as job_name
from employees a;

--중첩서브쿼리
--전체 직원의 봉급평균 보다 봉급이 큰 직원만 출력하시오
select emp_name
,salary
from employees
where salary >= (select avg(salary)
                 from employees);
                 
--동시에 2개이상의 컬럼 값이 같은 껀 조회
select employee_id, emp_name, job_id
from employees
where (employee_id, job_id) in (select employee_id, job_id
                                from job_history);
                                
select *
from member;
--cart사용 이력이 없는 회원을 조회하시요
select cart_member
from cart;


select *
from member
where mem_id not in(select cart_member 
                    from cart);
                    
select*
from member
where mem_id not in ('a001', 'b001');
--member 중에서 전체 회원의 마일리지 평균값 이상인 회원만 조회하시요
--정렬 (마일리지 내림차순)
select mem_name
,mem_job
,mem_mileage
from member
where mem_mileage >= (select avg(mem_mileage)
                 from member)
ORDER BY mem_mileage DESC;

CREATE TABLE 강의내역 (
     강의내역번호 NUMBER(3)
    ,교수번호 NUMBER(3)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시  NUMBER(3)
    ,수강인원 NUMBER(5)
    ,년월 date
);
CREATE TABLE 과목 (
     과목번호 NUMBER(3)
    ,과목이름 VARCHAR2(50)
    ,학점 NUMBER(3)
);
CREATE TABLE 교수 (
     교수번호 NUMBER(3)
    ,교수이름 VARCHAR2(20)
    ,전공 VARCHAR2(50)
    ,학위 VARCHAR2(50)
    ,주소 VARCHAR2(100)
);
CREATE TABLE 수강내역 (
    수강내역번호 NUMBER(3)
    ,학번 NUMBER(10)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시 NUMBER(3)
    ,취득학점 VARCHAR(10)
    ,년월 DATE 
);
CREATE TABLE 학생 (
     학번 NUMBER(10)
    ,이름 VARCHAR2(50)
    ,주소 VARCHAR2(100)
    ,전공 VARCHAR2(50)
    ,부전공 VARCHAR2(500)
    ,생년월일 DATE
    ,학기 NUMBER(3)
    ,평점 NUMBER
);
ALTER TABLE 학생 ADD CONSTRAINT PK_학생_학번 PRIMARY KEY (학번);
ALTER TABLE 수강내역 ADD CONSTRAINT PK_수강내역_수강내역번호 PRIMARY KEY (수강내역번호);
ALTER TABLE 과목 ADD CONSTRAINT PK_과목_과목번호 PRIMARY KEY (과목번호);
ALTER TABLE 교수 ADD CONSTRAINT PK_교수_교수번호 PRIMARY KEY (교수번호);
ALTER TABLE 강의내역 ADD CONSTRAINT PK_강의내역_강의내역번호 PRIMARY KEY (강의내역번호);

 ALTER TABLE 수강내역 ADD CONSTRAINT FK_학생_학번 FOREIGN KEY(학번)REFERENCES 학생(학번);
ALTER TABLE 수강내역 ADD CONSTRAINT FK_과목_과목번호 FOREIGN KEY(과목번호)REFERENCES 과목(과목번호);
ALTER TABLE 강의내역 ADD CONSTRAINT FK_교수_교수번호 FOREIGN KEY(교수번호)REFERENCES 교수(교수번호);
ALTER TABLE 강의내역 ADD CONSTRAINT FK_과목_과목번호1 FOREIGN KEY(과목번호)REFERENCES 과목(과목번호);

select 이름
,학생.학번
,COUNT(수강내역번호) AS 수강건수
from 학생,수강내역
WHERE 학생.학번 = 수강내역.학번
AND 이름 = '최숙경'
GROUP BY 이름, 학생.학번;

select*
FROM 수강내역;


