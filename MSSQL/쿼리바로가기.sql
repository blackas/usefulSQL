--����Ű ����
/*
���� > �ɼ� > ȯ�� > Ű���� > ���� �ٷ� ����
*/
--ctrl+3 : stored procedure, function ���� ����
sp_helptext test_procedure

--ctrl+4 : �ش� ���ڿ��� �����ϴ� ���ν��� ã��
SELECT DISTINCT A.NAME FROM dbo.SYSOBJECTS AS A INNER JOIN dbo.SYSCOMMENTS AS B ON A.ID = B.ID WHERE A.TYPE = 'P' AND B.TEXT LIKE 

--ctrl+5 : �ش� �÷����� ����ϴ� ���̺� ã��
SELECT T.name AS table_name, C.name AS column_name FROM sys.tables AS T INNER JOIN sys.columns AS C ON T.object_id = C.object_id WHERE C.name =
