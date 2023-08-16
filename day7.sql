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
AND MEMBER.MEM_NAME = '������';

/* ANSI JOIN : American National Standards Institute
               �̱� ǥ�� SQL �������� (������ �� �ǹ����� �� �Ⱦ�)
*/

SELECT MEM_NAME
,CART_NO
,CART_PROD
,CART_QTY
FROM MEMBER,
INNER JOIN CART
NO(MEMVER.MEM_ID = CART.CART_MEMBER)
WHERE MEMBER.MEM_NAME = '������';

--��ǰ ���� ���
SELECT MEMBER.MEM_NAME, MEMBER.MEM_ID, CART.CART_MEMBER
,CART.CART_NO
,CART.CART_PROD, PROD.PROD_ID
,CART.CART_QTY
,PROD.PROD_NAME
,PROD.PROD_SALE
FROM MEMBER, CART, PROD
WHERE CART.CART_MEMBER = MEMBER.MEM_ID
AND MEMBER.MEM_NAME = '������'
AND CART.CART_PROD = PROD.PROD_ID;

--������ΰ� ������ ��ü ��ǰ�� �հ� �ݾ���?
SELECT MEM_NAME
,MEM_ID
,SUM(  CART_QTY * PROD_SALE) AS �հ�ݾ�
FROM MEMBER, CART, PROD
WHERE CART.CART_MEMBER = MEMBER.MEM_ID
AND MEMBER.MEM_NAME = '������'
AND CART.CART_PROD = PROD.PROD_ID
group by MEM_NAME
,MEM_ID;

SELECT*
FROM PROD;
-- �����Ͱ� ������ �Լ�
SELECT MEM_NAME
,MEM_ID
,SUM(  CART_QTY * PROD_SALE) AS �հ�ݾ�
FROM MEMBER INNER JOIN CART
ON(MEMBER.MEM_ID = CART.CART_MEMBER)
INNER JOIN PROD
ON (CART.CART_PROD = PROD.PROD_ID)
WHERE MEMBER.MEM_NAME = '������'
group by MEM_NAME
,MEM_ID;


-- EMPLOYEES, JOBS ���̺��� Ȱ���Ͽ�
-- SALARY�� 15000 �̻��� ������ ���, �̸�, SALARY, ���� ���̵�, �������� ����Ͻÿ�
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

/*�������� (�����ȿ� ����)
1. ��Į�� �������� (select ��)
2. �ζ��� �� (from��)
3. ��ø ���� (where��)
*/
--��Į�� ���������� ������ ��ȯ
--���� �ڵ尪�� �̸��� �����ö� ���� ���
--���������� �����������̺��� �� �Ǽ� ��ŭ ���������� ��ȸ�ϱ� ������
--���������� ���̺��� �Ǽ��� ������ �ڿ��� ���� ����ϰ� ��.(<-- �̷���� ������ �̿��ϴ°� �� ����)
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

--��ø��������
--��ü ������ ������� ���� ������ ū ������ ����Ͻÿ�
select emp_name
,salary
from employees
where salary >= (select avg(salary)
                 from employees);
                 
--���ÿ� 2���̻��� �÷� ���� ���� �� ��ȸ
select employee_id, emp_name, job_id
from employees
where (employee_id, job_id) in (select employee_id, job_id
                                from job_history);
                                
select *
from member;
--cart��� �̷��� ���� ȸ���� ��ȸ�Ͻÿ�
select cart_member
from cart;


select *
from member
where mem_id not in(select cart_member 
                    from cart);
                    
select*
from member
where mem_id not in ('a001', 'b001');
--member �߿��� ��ü ȸ���� ���ϸ��� ��հ� �̻��� ȸ���� ��ȸ�Ͻÿ�
--���� (���ϸ��� ��������)
select mem_name
,mem_job
,mem_mileage
from member
where mem_mileage >= (select avg(mem_mileage)
                 from member)
ORDER BY mem_mileage DESC;

CREATE TABLE ���ǳ��� (
     ���ǳ�����ȣ NUMBER(3)
    ,������ȣ NUMBER(3)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,����  NUMBER(3)
    ,�����ο� NUMBER(5)
    ,��� date
);
CREATE TABLE ���� (
     �����ȣ NUMBER(3)
    ,�����̸� VARCHAR2(50)
    ,���� NUMBER(3)
);
CREATE TABLE ���� (
     ������ȣ NUMBER(3)
    ,�����̸� VARCHAR2(20)
    ,���� VARCHAR2(50)
    ,���� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
);
CREATE TABLE �������� (
    ����������ȣ NUMBER(3)
    ,�й� NUMBER(10)
    ,�����ȣ NUMBER(3)
    ,���ǽ� VARCHAR2(10)
    ,���� NUMBER(3)
    ,������� VARCHAR(10)
    ,��� DATE 
);
CREATE TABLE �л� (
     �й� NUMBER(10)
    ,�̸� VARCHAR2(50)
    ,�ּ� VARCHAR2(100)
    ,���� VARCHAR2(50)
    ,������ VARCHAR2(500)
    ,������� DATE
    ,�б� NUMBER(3)
    ,���� NUMBER
);
ALTER TABLE �л� ADD CONSTRAINT PK_�л�_�й� PRIMARY KEY (�й�);
ALTER TABLE �������� ADD CONSTRAINT PK_��������_����������ȣ PRIMARY KEY (����������ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_����_�����ȣ PRIMARY KEY (�����ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_����_������ȣ PRIMARY KEY (������ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT PK_���ǳ���_���ǳ�����ȣ PRIMARY KEY (���ǳ�����ȣ);

 ALTER TABLE �������� ADD CONSTRAINT FK_�л�_�й� FOREIGN KEY(�й�)REFERENCES �л�(�й�);
ALTER TABLE �������� ADD CONSTRAINT FK_����_�����ȣ FOREIGN KEY(�����ȣ)REFERENCES ����(�����ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT FK_����_������ȣ FOREIGN KEY(������ȣ)REFERENCES ����(������ȣ);
ALTER TABLE ���ǳ��� ADD CONSTRAINT FK_����_�����ȣ1 FOREIGN KEY(�����ȣ)REFERENCES ����(�����ȣ);

select �̸�
,�л�.�й�
,COUNT(����������ȣ) AS �����Ǽ�
from �л�,��������
WHERE �л�.�й� = ��������.�й�
AND �̸� = '�ּ���'
GROUP BY �̸�, �л�.�й�;

select*
FROM ��������;


