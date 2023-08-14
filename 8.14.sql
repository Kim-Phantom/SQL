SELECT mbti
   , COUNT(*) as cnt
   FROM tb_info
   GROUP BY mbti
   ORDER BY 2 DESC;
   
 SELECT hobby
   , COUNT(*) as cnt
   FROM tb_info
   GROUP BY hobby
   ORDER BY 2 DESC;
   
 /* 집계함수 대상 데이터를 특정 그룹으로 묶은 다음 그룹에 대한 
 총합, 평균, 최댓값, 최솟값 등을 구하는 함수
 COUNT(EXPR) 로우 수를 반한하는 집계함수
 */
 SELECT COUNT(*)                    --null 포함
    , COUNT(department_id)          --default all
    , COUNT(ALL department_id)      --중복 포함 null x
    , count(DISTINCT department_id) -- 중복제거
    , COUNT(employee_id)
FROM employees;

SELECT department_id
    , SUM(salary)
    , ROUND(AVG(salary),2)
    , MAX(salary)
    , MIN(salary)
FROM employees
GROUP BY department_id
ORDER BY 1;
--50번 부서의 최대 최소급여
SELECT MIN(salary)
, max(salary)
FROM employees
WHERE department_id = 50;

SELECT count(MEM_JOB)  AS 회원수
, MEM_JOB AS 직업
FROM member
GROUP BY MEM_JOB
ORDER BY  회원수 DESC;

SELECT period
    ,SUM(LOAN_JAN_AMT) as 총잔액
FROM kor_loan_status
WHERE period LIKE '2013%'
group by period
order by 1;
--2013년도 지역별 총 대출 잔액
--select 절에 오는 컬럼은 집계함수를 제외하고
--group by 절에 포함되어야함
SELECT REGION As 지역별
, gubun
   ,SUM(LOAN_JAN_AMT) as 총잔액
from kor_loan_status
where period like '2013%'
group by REGION, gubun
order by 1 asc;
--년도별 대출의 총 합계

SELECT SUBSTR(period, 1, 4) AS 년도
 ,SUM(load_jan_amt) AS 총잔액
FROM kor_loan_status
GROUP BY SUBSTR(period, 1, 4), region
ORDER BY 1;
--employees 직원들의 고용 년도별 직원수를 출력하시오
DESC employees;
--그룹핑 대상의 데이터에 대해 검색조건을 쓰려면
--HAVING 사용
--입사직원이 10명이상인 년도와 직원수
-- from > where > group by > having > select > order by
SELECT TO_CHAR(hire_date, 'YYYY') AS 입사년도
     ,COUNT(employee_id) as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
--HAVING COUNT(employee_id)>= 10
ORDER BY 1;


--member 테이블을 활용하여
--직업별 마일리지 평균금액을 구하시오 (소수점 2째 자리까지 반올림하여 출력)
--정렬 평균마일리지 내림차순
--평균 마일리지가 반올림하여 출력
SELECT MEM_JOB
   ,ROUND(AVG(MEM_MILEAGE),2) as avg_mileage
FROM member
GROUP BY mem_job
HAVING ROUND(AVG(mem_mileage),2) >= 3000
ORDER BY 2 DESC;

---------------------------
--직업별 마일리지의 합계 마일리지 전체합계를 출력하시오

SELECT mem_job
,COUNT(mem_id)   as 회원수
,SUM(mem_mileage) as 합계
FROM member
GROUP BY ROLLUP(mem_job); -- 롤업 말아올린다라는 뜻으로 
                          -- 집계결과의 합을 출력함
                          
-- products 상품테이블의 카테고리별 상품수와 전체 상품 수를 출력하시오

SELECT (PROD_CATEGORY, '합계') AS 카테고리
,prod_subcategory as 서브카테고리
,COUNT(prod_id) as 상품수
FROM products


SELECT SUBSTR(period, 1, 4) AS 년도
 ,SUM(load_jan_amt) AS 총잔액
FROM kor_loan_status
GROUP BY SUBSTR(period, 1, 4), region
ORDER BY 1;

SELECT cust_id
,cust_name
,cust_gender
,cust_year_of_birth
FROM customers;
--년도별 회원수를 출력하시오 단 (남, 녀 구분하여서)
SELECT cust_year_of_birth
,DECODE(cust_gender, 'M', 1, 0) as 남자
,DECODE(cust_gender, 'F', 1, 0) as 여자
FROM customers
GROUP BY cust_year_of_birth
ORDER BY 1;

