CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;
select seq, goods
from exp_goods_asia
where country = '�ѱ�'
union   -- ���� ���ŵ�
select seq, goods
from exp_goods_asia
where country = '�Ϻ�'
union
SELECT 10, '��ǻ��'
FROM dual;

select goods
from exp_goods_asia
where country = '�ѱ�'
union all   -- ��ü ��� ����
select goods
from exp_goods_asia
where country = '�Ϻ�';



select goods
from exp_goods_asia
where country = '�ѱ�'
intersect -- ������
select goods
from exp_goods_asia
where country = '�Ϻ�';

select goods
from exp_goods_asia
where country = '�ѱ�'
intersect -- ������
select goods
from exp_goods_asia
where country = '�Ϻ�';

select goods
from exp_goods_asia
where country = '�ѱ�'
minus -- ������
select goods
from exp_goods_asia
where country = '�Ϻ�';
--ORACLE ������ ��� �ø��� ���� Ÿ���� ���ƾ���
--������ ������ SELECT������ ���
SELECT TO_CHAR(department_id) AS �μ�
,COUNT(*) �μ���������
FROM EMPLOYEES
GROUP BY department_id
SELECT '��ü' 
COUNT(*) AS ��ü������
FROM EMPLOYEES;

--���������� ���� �л� ��ȸ
select *
from �л� a
where not exists (select *
from �������� b
where b.�й� = a.�й�);

/*���� ǥ���� '�˻�','ġȯ' �ϴ� ������ �����ϰ� ó���� �� �ֵ��� �ϴ� ����
  oracle�� 10g ���� ��� (java, python, js �� ����ǥ���� ��밡��)���ݾ� �ٸ�
  .(dot) or [] �� ��� ���� 1���ڸ� �ǹ���
   ^ <-- ������ �ǹ��� ^[0-9] <-- ���ڷ� �����ϴ� 
   [^0-9] <-- ���ȣ ���� ^ <-- not�� �ǹ���*/
  --REGEXP_LIKE : ���Խ� ������ �˻�
select *
from member
where REGEXP_LIKE(mem_comtel, '^..-');
--������ 3�� ���� �� @ ���� ��ȸ (abc@gmail.com)
/*�ݺ�������
* : 0���̻�
+ : 1���̻�
? : 0,1��
{n} : n��
{n,} : n�� �̻�
{n, m} : n�� �̻� m�� ����
*/
select*
from member
where REGEXP_LIKE(mem_mail, '^[a-zA-Z]{3,5}@');
-- mem_add2 ���� ���� ���� ������ �����͸� ����Ͻÿ�
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '. .'); -- ��� ���ڵ�

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '[��-�R]$'); -- �ѱ۷� ������

select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[��-�R]*$'); -- �ѱ۷� ������

--�ѱ��� ���� �ּҰ˻�
select mem_name
,mem_add2
from member      
where regexp_like(mem_add2, '^[^��-�R]*$');
-- | <-- �Ǵ�
-- () <-- ���ϱ׷�
-- J�� �����ϸ�, ����° ���ڰ� M�Ǵ� N�� �����̸� ��ȸ�ϱ�

select emp_name
from employees
where regexp_like(emp_name, 'J.(n|m)');

--REGEXP_SUBSTR ����ǥ���� ������ ��ġ�ϴ� ���ڿ� ��ȯ
--�̸��� @�� �������� �հ� �� �� ����Ͻÿ�
--����, ������ġ, ��Ī����
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

select mem_add1 --���⸦ �������� 2��° �����ϴ� �ּҸ� ����Ͻÿ�
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
where regexp_like(id, '^.{8,14}$'); -- 8~ 14 ���� �ؽ�Ʈ �����ϴ� ������ ���

