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

	BF_IDX			= Trim(REQUEST("BF_IDX"))
	IB_IDX		= Trim(REQUEST("IB_IDX"))
    
	    '// DB ют╥б......
	    UPDSQL = "UPDATE BOARD_FREE SET IB_IDX = "& IB_IDX
        UPDSQL = UPDSQL & " WHERE BF_IDX = '" & BF_IDX & "'"

	    DbCon.Execute (UPDSQL)
        'response.Write UPDSQL
			
	DbCon.Close
	Set DbCon=Nothing
%>