use AMSMASTER

Declare @i Int, @maxi Int
Declare @j Int, @maxj Int
Declare @no int
Declare @Output nvarchar(MAX)
Declare @last varchar(155), @current varchar(255), @typ varchar(255), @description nvarchar(MAX), @tablename nvarchar(MAX)
Declare @text nvarchar(MAX)

create Table #Tables      (id int identity(1,1), Object_id int,      Name nvarchar(MAX), Type varchar(20),    [description] nvarchar(MAX), [tablename] nvarchar(MAX))
create Table #Columns     (id int identity(1,1), Name nvarchar(MAX), Type Varchar(155),  Nullable varchar(2), [description] varchar(4000))
create Table #Fk          (id int identity(1,1), Name nvarchar(MAX), col Varchar(155),   refObj varchar(155), refCol varchar(155))
create Table #Indexes     (id int identity(1,1), Name nvarchar(MAX), Type Varchar(25),   cols varchar(1000))
create Table #constraints (id int identity(1,1), Name nvarchar(MAX), Type Varchar(25),   cols varchar(1000),  definition varchar(1000))

set @text = N'
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style>
.font712580
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.xl1520912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6320912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6420912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl6520912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl6620912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl6720912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl6820912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl6920912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl7020912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7120912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7220912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl7320912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:black none;
	white-space:normal;}
.xl7420912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7520912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7620912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7720912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7820912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7920912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8020912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8120912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#D9D9D9;
	mso-pattern:black none;
	white-space:normal;}
.xl8220912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D9D9D9;
	mso-pattern:black none;
	white-space:normal;}
.xl8320912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D9D9D9;
	mso-pattern:black none;
	white-space:normal;}
.xl8420912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D9D9D9;
	mso-pattern:black none;
	white-space:nowrap;}
.xl8520912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#DAEEF3;
	mso-pattern:black none;
	white-space:normal;}
.xl8620912
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#DAEEF3;
	mso-pattern:black none;
	white-space:normal;}

</style>
</head>

<body>
<div id="div" align=center x:publishsource="Excel">
'
PRINT CAST(@text AS TEXT)

set nocount on




--create Table #Tables  (id int identity(1, 1), Object_id int, Name varchar(155), Type varchar(20), [description] varchar(4000), [tablename] varchar(4000))

insert into #Tables (Object_id, Name, Type, [description],  [tablename])

Select o.object_id,  '[' + s.name + '].[' + o.name + ']', 
    case when type = 'V' then 'View' when type = 'U' then 'Table' end,  
    cast(p.value as varchar(4000)),
    CONVERT(varchar(4000),p.value)
    from sys.objects o 
       left outer join sys.schemas s on s.schema_id = o.schema_id 
       left outer join sys.extended_properties p on p.major_id = o.object_id and minor_id = 0 and p.name = 'MS_Description' and p.name = '테이블명'
       where type in ('U', 'V')
       and o.is_ms_shipped = 0 -- 1: sql server 생성시 자동 생성 / 0 : 유저 생성
    order by type, s.name, o.name
    
Set @maxi = @@rowcount


set @i = 1
While(@i <= @maxi)
begin
   --table header
   select @tablename = name, @description = [description] from #Tables where id = @i
      
   print '
<table border=0 cellpadding=0 cellspacing=0 width=838 style="border-collapse: collapse;table-layout:fixed;width:900pt">
    <col width=24  style="width:18pt">
    <col width=99  style="width:64pt">
    <col width=194 style="width:156pt">
    <col width=115 style="width:100pt">
    <col width=118 style="width:90pt">
    <col width=288 style="width:201pt">

    <tr>
        <td class=xl1520912 width=24 style="height:15.95pt;width:18pt"></td>
        <td class=xl6320912 ></td>
        <td class=xl6320912 ></td>
        <td class=xl6320912 ></td>
        <td class=xl6320912 ></td>
        <td class=xl6320912 ></td>
    </tr>
    <tr>
        <td class=xl1520912 ></td>
        <td class=xl8520912 width=99 >Table ID</td>
        <td colspan=4 class=xl7520912 style="border-right:1.0pt solid black; border-left:none">'+ isnull(@tablename, '') +'</td>
    </tr>
    <tr>
        <td class=xl1520912></td>
        <td class=xl8620912 >Description</td>
        <td colspan=4 class=xl7820912 style="border-right:1.0pt solid black; border-left:none">' + isnull(@description, '') + '</td>
    </tr>
'
   --table columns
   truncate table #Columns 
   
  insert into #Columns  (Name, Type, Nullable, [description])
  --FOR 2005   
  Select c.name, 
           type_name(c.user_type_id) + (
           case when (type_name(c.user_type_id) = 'varchar' or type_name(c.user_type_id) = 'nvarchar' or type_name(c.user_type_id) ='char' or type_name(c.user_type_id) ='nchar')
              then '(' + cast(max_length as varchar) + ')' 
            when type_name(user_type_id) = 'decimal'  
                 then '(' + cast([precision] as varchar) + ',' + cast(scale as varchar)   + ')' 
           else ''
           end            
           ), 
           case when c.is_nullable = 1 then 'Y' else 'N'  end,
           cast(p.value as varchar(4000))
  from sys.columns c
        inner join #Tables t on t.object_id = c.object_id
        left outer join sys.extended_properties p on p.major_id = c.object_id and p.minor_id  = c.column_id and p.name = 'MS_Description' 
  where t.id = @i
  order by c.column_id
    
   Set @maxj =   @@rowcount
   set @j = 1
   
   
print '   
    <tr>
        <td class=xl1520912></td>
        <td class=xl7120912>Table Columns</td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl7020912>　</td>
    </tr>
    <tr>
        <td class=xl1520912></td>
        <td class=xl8120912> No. </td>
        <td class=xl8220912> Name </td>
        <td class=xl8220912> Datatype </td>
        <td class=xl8220912> Nullable </td>
        <td class=xl8320912> Description </td>
    </tr>
'

   While(@j <= @maxj)
   begin
      select	@Output = '
    <tr>
        <td class=xl1520912></td>
        <td class=xl6420912 >' + Cast((@j) as varchar) + '</td>
        <td class=xl6520912 >' + isnull(name,'')  + '</td>
        <td class=xl6520912 >' +  upper(isnull(Type,'')) + '</td>
        <td class=xl6620912 >' + isnull(Nullable,'N') + '</td>
        <td class=xl6720912 >' + isnull([description],'') + '</td>
    </tr>'
         from #Columns  where id = @j      
      print    @Output    
      Set @j = @j + 1;
   end

   --Indexes 
   truncate table #Indexes
   
   print '
    <tr>
        <td class=xl1520912></td>
        <td class=xl7120912>Indexs</td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl7020912>　</td>
    </tr>
    <tr>
        <td class=xl1520912></td>
        <td class=xl8120912 > No. </td>
        <td class=xl8220912 > Name </td>
        <td class=xl8220912 > Type </td>
        <td class=xl8220912 > Columns </td>
        <td class=xl8420912>　</td>
    </tr>'  
      insert into #Indexes  (Name, type, cols)
         select i.name, case when i.type = 0 then 'Heap' when i.type = 1 and i.is_unique_constraint =1 then 'Clustered, Unique'
                                                         when i.type = 1 and i.is_unique_constraint =0 then 'Clustered' 
                                                         when i.type = 0 and i.is_unique_constraint =1 then 'Nonclustered, Unique'
                                                         else 'Nonclustered' end,  col_name(i.object_id, c.column_id)
            from sys.indexes i 
               inner join sys.index_columns c on i.index_id = c.index_id and c.object_id = i.object_id 
               inner join #Tables t on t.object_id = i.object_id
            where t.id = @i
            order by i.name, c.column_id
  

   Set @maxj =   @@rowcount
   
   set @j = 1
   set @no = 1
   if (@maxj >0)
   begin
      set @Output = ''
      set @last = ''
      set @current = ''
      While(@j <= @maxj)
      begin
         select @current = isnull(name,'') from #Indexes  where id = @j
                
         if @last <> @current  and @last <> ''
            begin   
            print
			'
    <tr>
        <td class=xl1520912 ></td>
        <td class=xl6420912 >' + Cast((@no) as varchar) + '</td>
        <td class=xl6520912 >' + @last + '</td>
        <td class=xl6520912 >' + @typ + '</td>
        <td class=xl6620912 >' + @Output  + '</td>
        <td class=xl6720912>　</td>
    </tr>'
            set @Output  = ''
            set @no = @no + 1
            end
         
            
         select @Output = @Output + cols + '<br />' , @typ = type
               from #Indexes  where id = @j
         
         set @last = @current    
         Set @j = @j + 1;
      end
      if @Output <> ''
            begin   
            print '
    <tr>
        <td class=xl1520912></td>
        <td class=xl6420912 >' + Cast((@no) as varchar) + '</td>
        <td class=xl6520912 >' + @last + '</td>
        <td class=xl6520912 >' + @typ + '</td>
        <td class=xl6620912 >' + @Output  + '</td>
        <td class=xl6720912>　</td>
    </tr>'
            end
   end

   --constraints 
   truncate table #constraints
   
   print '
   <tr>
        <td class=xl1520912></td>
        <td class=xl7120912> constraints </td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl6320912></td>
        <td class=xl7020912>　</td>
    </tr>
    <tr>
        <td class=xl1520912></td>
        <td class=xl8120912 > No. </td>
        <td class=xl8220912 > Name </td>
        <td class=xl8220912 > Type </td>
        <td class=xl8220912 > Column </td>
        <td class=xl8320912 > Definition </td>
    </tr>'  
    insert into #constraints  (Name, type, cols, definition)
    select dc.name, dc.type_desc, c.name as cols, dc.definition
    from #Tables t 
    inner join sys.default_constraints dc on t.Object_id = dc.parent_object_id
    inner join sys.columns c on dc.Object_id = c.default_object_id
    where t.id = @i
    order by t.id,c.column_id
  

   Set @maxj =   @@rowcount
   
   set @j = 1
   set @no = 1

   if (@maxj >0) begin
        set @Output = ''

        While(@j <= @maxj) begin
            select	@Output = '
    <tr>
        <td class=xl1520912></td>
        <td class=xl6420912 >' + Cast((@j) as varchar) + '</td>
        <td class=xl6520912 >' + isnull(name,'')  + '</td>
        <td class=xl6520912 >' +  upper(isnull(Type,'')) + '</td>
        <td class=xl6620912 >' + isnull(cols,'') + '</td>
        <td class=xl6720912 >' + isnull([definition],'') + '</td>
    </tr>'
                from #constraints  where id = @j      
            print    @Output    
            Set @j = @j + 1;
        end

    end
    Set @i = @i + 1;
    print '
    <tr>
        <td class=xl1520912></td>
        <td class=xl6820912 style="border-top:1.0pt solid black;">　</td>
        <td class=xl6920912 style="border-top:1.0pt solid black;">　</td>
        <td class=xl6920912 style="border-top:1.0pt solid black;">　</td>
        <td class=xl6920912 style="border-top:1.0pt solid black;">　</td>
        <td class=xl6320912 style="border-top:1.0pt solid black;"></td>
    </tr>
    <tr>
        <td class=xl1520912></td>
        <td class=xl6820912>　</td>
        <td class=xl6920912>　</td>
        <td class=xl6920912>　</td>
        <td class=xl6920912>　</td>
        <td class=xl6320912></td>
    </tr>'
end

print'
</table>
</div>
</body>
</html>
'
drop table #Tables
drop table #Columns
drop table #FK
drop table #Indexes 
drop table #constraints 
set nocount off
