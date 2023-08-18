/*계정생성 */
ALtER session SET "_ORACLE_SCRIPT"=TRUE;
--계정생성 ID:STUDY/PW:STUDY
CREATE USER study IDENTIFIED BY study;
--권한 설정
GRANT CONNECT, RESOURCE TO study;
--테이블 스페이스 접근 권한
GRANT UNLIMITED TABLESPACE TO study;