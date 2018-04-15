<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<%
Response.CacheControl	= "no-cache"
Response.Expires		= -1
Response.Buffer			= true
Response.ContentType	="text/html"
Response.CharSet		= "euc-kr"
Response.AddHeader "pragma","no-cache"
%>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" -->
<%
    nn = 1 
    
	SQLLIST2 = "select  IU_IDX, iu_id, iu_nickName, iu_cash,iu_point, (select top 1 c_dir from realtime_log where iu_id = a.iu_id order by REGDATE desc) as c_dir from  info_user a where a.iu_id IN (select iu_id from realtime_log) and a.iu_level <> 9"
	'SQLLIST2 = "select IU_IDX, iu_id, iu_nickName, iu_cash,iu_point, 1 as c_dir from info_user where iu_level <> 9 And iu_id IN (select iu_id from realtime_log)"
	
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

%>


<%
    i = 0
	IF NOT RS2.EOF Then
        DO WHILE NOT RS2.EOF
%>

<!--<div style="color:#000000;width:155px;font-size:10px;overflow:hidden;"><%= RS2("IU_ID") %> | <%= RS2("c_dir") %> | <a href="/EPCenter/02_Member/View.asp?IU_IDX=<%= RS2("IU_IDX")%>" target="_blank"><span style="font-size:10px;color:red;"><%= RS2("IU_nickname") %></span></a></div>-->

<%
		   RS2.MOVENEXT
		   i = i + 1
		LOOP
	END IF 
%>

<div style="color:#000000;width:155px;font-size:10px;overflow:hidden;"><span style="font-size:15px;color:red;">현재접속자:<%= i %></span></div>
<%
	SET DbRec=Server.CreateObject("ADODB.Recordset")
	DbRec.CursorType=1

	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"
	SQLLIST = "SELECT COUNT(DISTINCT IB_ID) FROM INFO_BETTING WITH(NOLOCK) WHERE IB_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL = 9) AND IB_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
    
%>
<div style="color:#000000;width:155px;font-size:10px;overflow:hidden;"><span style="font-size:15px;color:red;">일배터수:<%= BTSUM %></span></div>