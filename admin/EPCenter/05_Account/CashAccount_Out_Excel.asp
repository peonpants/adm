<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))


	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And A.IE_RegDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF

	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF	


	Set RS = Server.CreateObject("ADODB.RecordSet")
	SQL = "Select A.IE_ID, A.IE_NickName, A.IE_Amount, B.IU_BankName, B.IU_BankNum, B.IU_BankOwner, A.IE_REGDATE, A.IE_SetDate, A.IE_SITE from Info_Exchange A, Info_User B Where A.IE_ID = B.IU_ID "
	SQL = SQL & SQLR & " AND A.IE_SITE = B.IU_SITE AND A.IE_Status = 1"
	SQL = SQL & " Order by A.IE_RegDate Desc"
	
	RS.CursorLocation = 3
	RS.Open sql, DbCon, 0, 1, &H0001
	'// Call PageNation_Setting(30)
	TotalSql = SQL
%>

<html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition", "attachment;filename=CashAccount_Out_Excel.xls" 
%>
<style>
	td{font-size:9pt;}
</style></head>

<body>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	<tr height="30" bgcolor="e7e7e7"> 
		<td align="center"><b>아이디(닉네임)</b></td>
		<td align="center"><b>사이트</b></td>
		<td align="center"><b>결제금액</b></td>
		<td align="center"><b>은행</b></td>
		<td align="center"><b>예금주</b></td>
		<td align="center"><b>계좌번호</b></td>
		<td align="center"><b>신청일</b></td>
		<td align="center"><b>확인일</b></td>
	</tr>
<%
		Do Until rs.EOF
			IE_ID = rs(0)
			IE_NickName = rs(1)
			IE_Amount = rs(2)
			IE_BankName = rs(3)
			IE_BankOwner = rs(4)
			IE_BankNum = rs(5)
			IE_RegDate = rs(6)
			IE_SetDate = rs(7)
			IE_SITE = rs(8)
			
			TotAmount = Cdbl(TotAmount) + IE_Amount
%>
	<tr bgcolor="#FFFFFF" height="25">
		<td>&nbsp;<b><%=IE_ID%>(<%=IE_NickName%>)</b></td>
		<td>&nbsp;<%=IE_SITE%></td>
		<td align="right"><%=formatnumber(IE_Amount,0)%> 원&nbsp;</td>
		<td>&nbsp;<%=IE_BankName%></td>
		<td>&nbsp;<%=IE_BankOwner%></td>
		<td>&nbsp;<%=IE_BankNum%></td>
		<td align="center"><%=IE_RegDate%></td>
		<td align="center"><%=IE_SetDate%></td>
	</tr>
<%
	total = total - 1
	i = i + 1
	rs.MoveNext
	Loop

%>
	<tr>
		<td align="center"><b>합 계</b></td>
		<td align="right">&nbsp;<b><%=formatnumber(TotAmount,0)%>&nbsp;원&nbsp;</b></td>
		<td colspan="5" align="center">&nbsp;</td>
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