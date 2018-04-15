<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	BC_TITLE	= Trim(REQUEST("BC_TITLE"))
	BC_MANAGER	= Trim(REQUEST("BC_MANAGER"))
	BC_CONTENTS	= Trim(REQUEST("BC_CONTENTS"))
	JOBSITE1		= Trim(REQUEST("BC_SITE1"))
	JOBSITE2		= Trim(REQUEST("BC_SITE2"))
	JOBSITE3		= Trim(REQUEST("BC_SITE3"))
	JOBSITE4		= Trim(REQUEST("BC_SITE4"))

	If JOBSITE1 <> "" then
	sql = "select iu_id from info_user where iu_site = '"&JOBSITE1&"' order by iu_idx desc"
	SET RSLIST = DbCon.Execute(sql)	
	Do While Not rslist.eof 
	
	SQLSTR = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY)"
	SQLSTR = SQLSTR& " VALUES ('包府磊', '"& RSLIST("iu_id") &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE1 &"', '"&BC_MANAGER&"', 1)"
	DbCon.execute(SQLSTR)
		RSLIST.MoveNext
	Loop
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	End If 

	If JOBSITE2 <> "" then
	sql = "select iu_id from info_user where iu_site = '"&JOBSITE2&"' order by iu_idx desc"
	SET RSLIST = DbCon.Execute(sql)	
	Do While Not rslist.eof 
	
	SQLSTR = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY)"
	SQLSTR = SQLSTR& " VALUES ( '包府磊', '"& RSLIST("iu_id") &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE2 &"', '"&BC_MANAGER&"', 1)"
	DbCon.execute(SQLSTR)
		RSLIST.MoveNext
	Loop
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	End If 

	If JOBSITE3 <> "" then
	sql = "select iu_id from info_user where iu_site = '"&JOBSITE3&"' order by iu_idx desc"
	SET RSLIST = DbCon.Execute(sql)	
	Do While Not rslist.eof 
	
	SQLSTR = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY)"
	SQLSTR = SQLSTR& " VALUES ( '包府磊', '"& RSLIST("iu_id") &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE3 &"', '"&BC_MANAGER&"', 1)"
	DbCon.execute(SQLSTR)
		RSLIST.MoveNext
	Loop
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	End If 

	If JOBSITE4 <> "" then
	sql = "select iu_id from info_user where iu_site = '"&JOBSITE4&"' order by iu_idx desc"
	SET RSLIST = DbCon.Execute(sql)	
	Do While Not rslist.eof 
	
	SQLSTR = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY)"
	SQLSTR = SQLSTR& " VALUES ( '包府磊', '"& RSLIST("iu_id") &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE4 &"', '"&BC_MANAGER&"', 1)"
	DbCon.execute(SQLSTR)
		RSLIST.MoveNext
	Loop
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	End If 

	DbCon.Close
	Set DbCon=Nothing
	
	'Response.Redirect "List.asp"
%>
<script type="text/javascript">
alert("傈价肯丰");
location.href = "list.asp";
</script>
