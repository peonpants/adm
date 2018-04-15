<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))

	SQLR = " Info_Charge WHERE IC_Status = 1 "

	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And IC_REGDATE Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF

	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF	


	Set RS = Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT * FROM "& SQLR &" ORDER BY IC_RegDate Desc"
	RS.CursorLocation = 3
	RS.Open SQL, DbCon, 0, 1, &H0001
	TotalSql = SQL
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition", "attachment;filename=CashAccount_In_Excel.xls" 
%>
<style>
	td{font-size:9pt;}
</style></head>

<body>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	<tr height="30" bgcolor="e7e7e7"> 
		<td align="center"><b>아이디</b></td>
		<td align="center"><b>닉네임</b></td>
		<td align="center"><b>사이트</b></td>
		<td align="center"><b>결제금액</b></td>
		<td align="center"><b>신청일</b></td>
		<td align="center"><b>확인일</b></td>
	</tr>
	
<%
	
	Do Until rs.EOF
		IC_ID = rs("IC_ID")
		IC_Name = rs("IC_Name")
		IC_Amount = rs("IC_Amount")
		IC_RegDate = rs("IC_RegDate")
		IC_SetDate = rs("IC_SetDate")
		IC_SITE = rs("IC_SITE")
		
		TotAmount = Cdbl(TotAmount) + IC_Amount
%>
	<tr bgcolor="#FFFFFF" height="25">
		<td>&nbsp;<b><%=IC_ID%></b></td>
		<td>&nbsp;<%=IC_Name%></td>
		<td>&nbsp;<%=IC_SITE%></td>
		<td align="right"><%=formatnumber(IC_Amount,0)%> 원&nbsp;</td>
		<td align="center"><%=IC_RegDate%></td>
		<td align="center"><%=IC_SetDate%></td>
	</tr>
<%
		total = total - 1
		i = i + 1
		rs.MoveNext
		Loop
%>
	<tr bgcolor="#FFFFFF" height="25">
		<td colspan="2" align="center"><b>합 계</b></td>
		<td align="right"><b><%=formatnumber(TotAmount,0)%>&nbsp;원&nbsp;</b></td>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
</table>
</body>
</html>

<%
	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>