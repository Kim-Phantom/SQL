/*INNER JOIN �������� (��������)*/
SELECT *
FROM �л�;
SELECT *
FROM ��������;

SELECT a.�й�
,a.�̸�
,a.����
,b.����������ȣ
,b.�����ȣ
,c.�����̸�
FROM �л� a , �������� b , ���� c
WHERE a.�й� = b.�й� 
AND b.�����ȣ = c.�����ȣ
AND a.�̸� = '�ּ���';

--�ּ����� ���� �������� ����Ͻÿ�

select a.�̸�
,a.�й�
,sum(c.����) as ��������
from �л� a, �������� b, ���� c
where b.�����ȣ = c.�����ȣ
and a.�й� = b.�й� 
and a.�̸� = '�ּ���'
GROUP BY a.�̸� , a.�й�; 

-- �л��� �����̷� �Ǽ�, �Ѽ��� ������ ����ϼ���
--����л� ��� null�̸� 0����  (nvl 0)

select �л�.�й�
,�л�.�̸�
,sum(nvl(����.����,0)) as �Ѽ�������
,count(��������.����������ȣ) as ���������Ǽ�
from �л�, ��������, ����
where �л�.�й� = ��������.�й�(+)
and ��������.�����ȣ = ����.�����ȣ(+)
group by �л�.�й�
,�л�.�̸�;




SELECT a.�й�
      ,a.�̸�
      ,a.����
      ,b.����������ȣ
      ,(select �����̸�   -- ��Į�� �������� (������ ��밡��)
        from ����
        where �����ȣ = b.�����ȣ) as �����̸�
FROM �л� a , �������� b 

where a.�й� = b.�й� 
AND a.�̸� = '�ּ���';


select *
from ����;

select *
from �л�;
select *
from ��������;
/*�л��� ������ �ο����� ����Ͻÿ�*/
select ����
,count(*) as �����ο���
from �л�
group by ����
order by 2 desc;

/*�л��� '�������' ���� ���� �л��� ����ϼ���*/

select �̸�
,����
from �л�
where ���� >= (select avg(����) from �л�)
order by 2 desc;

select �̸�
, ROUND(����, 2)
from �л�
where ���� >= (select max(����) from �л�)
order by 2 desc;

--���������� ���� �л���?
select *
from �л�
where �й� not in (select �й� from ��������);

/*�ζ��� �� (from��) select ���� ���� ����� ��ġ ���̺�ó�� ���*/                           
select *
from(select rownum as rnum
,�й�, �̸�, ����
from �л�) a 
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



/*�л��߿� ���� ���� 5�� ����Ͻÿ�*/
select *
from(select rownum as runm
           ,a.*
     from(select �̸�
              , ROUND(����, 2)
        from �л�
        where ���� >= (select avg (����) from �л�) 
        ) a
    )
where runm between 1 and 5;

-- member, cart, prod �� ����Ͽ�
-- ���� īƮ���Ƚ��, ��ǰǰ��Ǽ�, ��ǰ���ż���, �ѱ��űݾ��� ����Ͻÿ�
-- �����̷��� ���ٸ� 0 <- ���� ��µǵ���
select *
from member;
select *
from cart;
select *
from prod;



select a.mem_id
,a.mem_name
,count(distinct b.cart_no)
,count(c.prod_id) as ��ǰǰ��Ǽ�
,sum(nvl(b.cart_qty,0)) as ��ǰ���ż���
,sum(nvl(b.cart_qty * c.prod_sale,0)) as �����ջ�ݾ� 
from member a , cart b , prod c 
where a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
GROUP BY a.mem_id, a.mem_name
order by 6 desc;

/*ANSI OUTER JOIN*/
select a.mem_id
,a.mem_name
,count(distinct b.cart_no) īƮ���Ƚ��
,count(c.prod_id)          ��ǰǰ���
from member a 
LEFT OUTER JOIN cart b
on(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
on(b.cart_prod = c.prod_id) 
group by a.mem_id, a.mem_name;

