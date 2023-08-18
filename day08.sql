/*INNER JOIN 내부조인 (동등조인)*/
SELECT *
FROM 학생;
SELECT *
FROM 수강내역;

SELECT a.학번
,a.이름
,a.전공
,b.수강내역번호
,b.과목번호
,c.과목이름
FROM 학생 a , 수강내역 b , 과목 c
WHERE a.학번 = b.학번 
AND b.과목번호 = c.과목번호
AND a.이름 = '최숙경';

--최숙경의 수강 총학점을 출력하시오

select a.이름
,a.학번
,sum(c.학점) as 수강학점
from 학생 a, 수강내역 b, 과목 c
where b.과목번호 = c.과목번호
and a.학번 = b.학번 
and a.이름 = '최숙경'
GROUP BY a.이름 , a.학번; 

-- 학생의 수강이력 건수, 총수강 학점을 출력하세요
--모든학생 출력 null이면 0으로  (nvl 0)

select 학생.학번
,학생.이름
,sum(nvl(과목.학점,0)) as 총수강학점
,count(수강내역.수강내역번호) as 수강내역건수
from 학생, 수강내역, 과목
where 학생.학번 = 수강내역.학번(+)
and 수강내역.과목번호 = 과목.과목번호(+)
group by 학생.학번
,학생.이름;




SELECT a.학번
      ,a.이름
      ,a.전공
      ,b.수강내역번호
      ,(select 과목이름   -- 스칼라 서브쿼리 (단일행 사용가능)
        from 과목
        where 과목번호 = b.과목번호) as 과목이름
FROM 학생 a , 수강내역 b 

where a.학번 = b.학번 
AND a.이름 = '최숙경';


select *
from 과목;

select *
from 학생;
select *
from 수강내역;
/*학생의 전공별 인원수를 출력하시오*/
select 전공
,count(*) as 전공인원수
from 학생
group by 전공
order by 2 desc;

/*학생의 '평균평점' 보다 높은 학생을 출력하세요*/

select 이름
,평점
from 학생
where 평점 >= (select avg(평점) from 학생)
order by 2 desc;

select 이름
, ROUND(평점, 2)
from 학생
where 평점 >= (select max(평점) from 학생)
order by 2 desc;

--수강내역이 없는 학생은?
select *
from 학생
where 학번 not in (select 학번 from 수강내역);

/*인라인 뷰 (from절) select 문의 질의 결과를 마치 테이블처럼 사용*/                           
select *
from(select rownum as rnum
,학번, 이름, 전공
from 학생) a 
where a.rnum between 2 and 5;


select *
from(select rownum as runm
,a.*
from(select employee_id
,emp_name
,salary
from employees
where emp_name LIKE 'K%'
order by emp_name) a)
where runm between 1 and 7; 



/*학생중에 평점 높은 5명만 출력하시오*/
select *
from(select rownum as runm
           ,a.*
     from(select 이름
              , ROUND(평점, 2)
        from 학생
        where 평점 >= (select avg (평점) from 학생) 
        ) a
    )
where runm between 1 and 5;

-- member, cart, prod 를 사용하여
-- 고객별 카트사용횟수, 상품품목건수, 상품구매수량, 총구매금액을 출력하시오
-- 구매이력이 없다면 0 <- 으로 출력되도록
select *
from member;
select *
from cart;
select *
from prod;



select a.mem_id
,a.mem_name
,count(distinct b.cart_no)
,count(c.prod_id) as 상품품목건수
,sum(nvl(b.cart_qty,0)) as 상품구매수량
,sum(nvl(b.cart_qty * c.prod_sale,0)) as 구매합산금액 
from member a , cart b , prod c 
where a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
GROUP BY a.mem_id, a.mem_name
order by 6 desc;

/*ANSI OUTER JOIN*/
select a.mem_id
,a.mem_name
,count(distinct b.cart_no) 카트사용횟수
,count(c.prod_id)          상품품목수
from member a 
LEFT OUTER JOIN cart b
on(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
on(b.cart_prod = c.prod_id) 
group by a.mem_id, a.mem_name;

