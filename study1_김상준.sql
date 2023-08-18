-----------1번 문제 ---------------------------------------------------
--1988년 이후 출생자의 직업이 의사,자영업 고객을 출력하시오 (어린 고객부터 출력)
select customer_name
    ,birth
    ,job
from customer
where birth > 19880101
and (job = '의사' or job = '자영업');
