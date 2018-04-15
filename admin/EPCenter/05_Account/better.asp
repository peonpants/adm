<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<%
Response.CacheControl	= "no-cache"
Response.Expires		= -1
Response.Buffer			= true
Response.ContentType	="text/html"
Response.CharSet		= "euc-kr"
Response.AddHeader "pragma","no-cache"
%>
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/smsUtil.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	SQLLIST = "select count(*) from info_betting where ib_id = 'parlia' and ib_status = 0 and IB_RESULT_CNT = IB_CNT"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TBOD = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	IF TBOD > 0 Then
%>
<embed src="/midi/toto.wav" hidden=true></embed>
<%
    End IF
%>
