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
	
	score            = Trim(dfRequest.Value("score"))
	team            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("team")), 0, 0, 2) 
	ig_idx            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("ig_idx")), 1, 1, 9999999) 
    
    IF dfStringUtil.ExistIsNumeric(score) Then
	    '// DB ют╥б......
	    UPDSQL = "UPDATE INFO_GAME SET "
	    IF team = 1 Then
	        UPDSQL = UPDSQL & " IG_Score1=" & score 	
	    Else
	        UPDSQL = UPDSQL & " IG_Score2=" & score 
        End IF	    
	    UPDSQL = UPDSQL & " WHERE IG_IDX=" & ig_idx

	    DbCon.Execute (UPDSQL)
        'response.Write UPDSQL
    End IF
    	    
	DbCon.Close
	Set DbCon=Nothing
%>