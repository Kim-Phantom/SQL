/*�������� */
ALtER session SET "_ORACLE_SCRIPT"=TRUE;
--�������� ID:STUDY/PW:STUDY
CREATE USER study IDENTIFIED BY study;
--���� ����
GRANT CONNECT, RESOURCE TO study;
--���̺� �����̽� ���� ����
GRANT UNLIMITED TABLESPACE TO study;