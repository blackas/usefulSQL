--단축키 쿼리
/*
도구 > 옵션 > 환경 > 키보드 > 쿼리 바로 가기
*/
--ctrl+3 : stored procedure, function 내용 보기
sp_helptext test_procedure

--ctrl+4 : 해당 문자열을 포함하는 프로시저 찾기
SELECT DISTINCT A.NAME FROM dbo.SYSOBJECTS AS A INNER JOIN dbo.SYSCOMMENTS AS B ON A.ID = B.ID WHERE A.TYPE = 'P' AND B.TEXT LIKE 

--ctrl+5 : 해당 컬럼명을 사용하는 테이블 찾기
SELECT T.name AS table_name, C.name AS column_name FROM sys.tables AS T INNER JOIN sys.columns AS C ON T.object_id = C.object_id WHERE C.name =
