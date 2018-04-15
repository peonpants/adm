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
<%

	IG_IDX		= REQUEST("IG_IDX")
	betCnt		= REQUEST("betCnt")
    
    arrBetCnt = split(betCnt,",")
    IF ubound(arrBetCnt) <> 2 Then
%>
<script>
alert("배팅카운트 확인 바람");
</script>
<%    
        response.End
    End IF
	IG_TEAM1BET_CNT			= arrBetCnt(0)
	IG_TEAM2BET_CNT			= arrBetCnt(2)
	IG_DRAWBET_CNT			= arrBetCnt(1)
	
	'// DB 입력......
	UPDSQL = "UPDATE INFO_GAME SET IG_TEAM1BET_CNT=" & Cdbl(IG_TEAM1BET_CNT)
	UPDSQL = UPDSQL & ", IG_TEAM2BET_CNT=" & Cdbl(IG_TEAM2BET_CNT)
	UPDSQL = UPDSQL & ", IG_DRAWBET_CNT=" & Cdbl(IG_DRAWBET_CNT)	
	UPDSQL = UPDSQL & " WHERE IG_IDX=" & IG_IDX

	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script>
alert("배팅 카운트 수정됨");
</script>