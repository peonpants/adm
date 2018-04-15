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
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->

<% 
	Session.CodePage = 949
	Response.ChaRset = "euc-kr"
    
	BF_IDX			= Trim(REQUEST("BF_IDX"))
	IB_IDX		= Trim(REQUEST("IB_IDX"))


	SQL = "UPDATE BOARD_FREE SET IB_IDX = '"& IB_IDX &"'
	SQL = SQL & " WHERE BF_IDX = '" & BF_IDX & "'"
	

		
	DbCon.execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
	
	response.Write "베팅번호  "& IB_IDX &"  가 등록되었습니다."
	
	
%>