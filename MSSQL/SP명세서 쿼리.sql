/*
       SP추출
*/
--변수
DECLARE @maxi AS INT , @maxj AS INT
DECLARE @i AS INT , @j AS INT
DECLARE @Output VARCHAR(4000),@description VARCHAR(4000)
 
CREATE TABLE #Tables  (id int identity(1, 1), Object_id int, name varchar(155), type varchar(20), [definition] varchar(MAX))
CREATE TABLE #Parameters (id int identity(1,1), name varchar(155), type Varchar(155))
 
--웹타이틀
Print '<head>'
Print '<title>::' + DB_name() + '::</title>'
--스타일
PRINT '<style>'   
PRINT '             body {'
PRINT '             font-family:verdana;'
PRINT '             font-size:9pt;'
PRINT '             }'          
PRINT '             td {'
PRINT '             font-family:verdana;'
PRINT '             font-size:9pt;'
PRINT '             }'          
PRINT '             th {'
PRINT '             font-family:verdana;'
PRINT '             font-size:9pt;'
PRINT '             background:#d3d3d3;'
PRINT '             }'
PRINT '             table'
PRINT '             {'
PRINT '             background:#d3d3d3;'
PRINT '             }'
PRINT '             tr'
PRINT '             {'
PRINT '             background:#ffffff;'
PRINT '             }'
PRINT '      </style>'
PRINT '</head>'
PRINT '<body>'
SET NOCOUNT ON


INSERT INTO #Tables (Object_id, name, type, [definition])
SELECT OJ.object_Id,'[' + S.name + '].[' + OJ.name + ']' AS name
,CASE WHEN type = 'V' THEN 'View' WHEN type = 'U' THEN 'Table' WHEN type = 'P' THEN 'PROCEDURE' WHEN type = 'FN' THEN 'FUNCTION' END,SM.definition
FROM sys.sql_modules AS SM
JOIN sys.objects AS OJ ON SM.object_id = OJ.object_id
LEFT OUTER JOIN sys.schemas AS S ON OJ.schema_id = S.schema_id
WHERE OJ.type IN ('P','FN') AND is_ms_shipped = 0


SET @maxi = @@rowcount
--SP 리스트
PRINT '<table border="0" cellspacing="0" cellpadding="0" width="550px" align="center"><tr><td colspan="3" style="height:50;font-size:14pt;text-align:center;"><a name="index"></a><b>Procedure Index</b></td></tr></table>'
PRINT '<table border="0" cellspacing="1" cellpadding="0" width="550px" align="center"><tr><th>Sr</th><th>Object</th><th>Type</th></tr>'
SET @i = 1
WHILE(@i <= @maxi)
BEGIN
       SELECT  @output =  '<tr><td align="center">' + Cast((@i) as varchar) + '</td><td><a href="#' + type + ':' + name + '">' + name + '</a></td><td>' + type + '</td></tr>'
       FROM #Tables WHERE id = @i
      
       PRINT @Output
       SET @i = @i + 1
END
PRINT '</table><br />'

--SP 쿼리문
PRINT '<table border="0" cellspacing="0" cellpadding="0" width="750px" style="table-layout:fixed;"><tr><td><b>Description</b></td></tr><tr><td>' + isnull(@description, '') + '</td></tr></table><br />'
SET @i = 1
WHILE(@i <= @maxi)
BEGIN 
--table header
SELECT @Output =  '<tr><th align="left"><a name="' + type + ':' + name + '"></a><b>' + type + ':' + name + '</b></th><td align="right"><a href="#index">Index</a></td></tr>'
, @description = [definition]
FROM #Tables WHERE id = @i

PRINT '<br /><br /><br /><table border="0" cellspacing="0" cellpadding="0" width="750px"><tr><td align="right"></td></tr>'
PRINT @Output
PRINT '</table><br />'
--Parameters정보테이블넣기
TRUNCATE table #Parameters

INSERT INTO #Parameters (Name, Type)
SELECT AP.name,type_name(user_type_id) +
CASE WHEN (type_name(user_type_id) = 'varchar' or type_name(user_type_id) = 'nvarchar' or type_name(user_type_id) ='char' or type_name(user_type_id) ='nchar')
        THEN '(' + cast(max_length AS VARCHAR) + ')'
    WHEN type_name(user_type_id) = 'decimal' 
        THEN '(' + cast([precision] AS VARCHAR) + ',' + cast(scale AS VARCHAR)   + ')'
    ELSE ''
    END
FROM sys.all_parameters AP
INNER JOIN #Tables T on T.object_id = AP.object_id
WHERE t.id = @i

SET @maxj =   @@rowcount
SET @j = 1

PRINT '<table border="0" cellspacing="0" cellpadding="0" width="750px"><tr><td><b>Procedure Prameters</b></td></tr></table>'
PRINT '<table border="0" cellspacing="1" cellpadding="0" width="750px"><tr><th>Sr.</th><th>Name</th><th>Datatype</th></tr>'

WHILE(@j <= @maxj)
BEGIN
      SELECT @Output = '<tr><td width="20px" align="center">' + Cast((@j) AS varchar) + '</td><td width="150px">' + isnull(name,'')  + '</td><td width="150px">' +  upper(isnull(type,'')) + '</td></tr>'
             from #Parameters  where id = @j        
      PRINT @Output      
      SET @j = @j + 1;
END
PRINT '</table><br />'
--Parameters정보테이블끝
--SP 쿼리
PRINT '<table border="0" cellspacing="0" cellpadding="0" width="750px"><tr><td><b>Description</b></td></tr><tr><td style="word-break:break-all;"><pre>' + isnull(@description, '') + '</pre></td></tr></table><br />'
--SP 쿼리끝
SET @i = @i + 1
END
 
--Parameters정보테이블
SET @i = 1
WHILE(@i <= @maxi)
BEGIN
      
       SET @i = @i + 1
END
DROP Table #Tables
DROP Table #Parameters