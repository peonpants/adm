<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition", "attachment;filename=bettingList.xls" 
%>
<%
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))

	SQLR = " INFO_BETTING WHERE 1=1 "

	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And IB_REGDATE Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF

	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF	


	Set RS = Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT * FROM "& SQLR &" ORDER BY IB_IDX Desc"
	rs.CursorLocation = 3
	rs.Open SQL, DbCon, 0, 1, &H0001
	TotalSql = SQL
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<style>
	td{font-size:9pt;}
</style></head>

<body>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr bgcolor="e7e7e7"> 
	<td align="center"><b>구분</b></td>
	<td align="center"><b>ID</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>게임수</b></td>
	<td align="center"><b>배당율</b></td>
	<td align="center"><b>배팅액</b></td>
	<td align="center"><b>예상배당율</b></td>
	<td align="center"><b>배팅시간</b></td>
	<td align="center"><b>상태</b></td></tr>
	<%  If rs.recordcount < 1 then %>
	<tr><td align="center" colspan="12" height="35">현재 등록된 베팅이 없습니다.</td></tr>
	<%
		else
			Do Until rs.EOF
				IB_Idx = rs("IB_Idx")
				IB_ID = rs("IB_ID")
				IB_Type = rs("IB_Type")
				IB_Benefit = rs("IB_Benefit")
				IB_Amount = rs("IB_Amount")
				IB_Status = rs("IB_Status")
				IB_RegDate = rs("IB_RegDate")
				IB_SITE = rs("IB_SITE")

				if IB_Type = "M" then
					arr_IB_Benefit = split(IB_Benefit, ",")
					arr_Len = UBound(arr_IB_Benefit)
					
					BenefitRate = 1
					for i=0 to arr_Len

					next
				else
					arr_Len = 1
					BenefitRate = formatnumber(IB_Benefit,2)
				end if
				
				Benefit = Cdbl(BenefitRate) * Cdbl(IB_Amount)
	%>
	<tr bgcolor="#FFFFFF" height="25">
		<td align="center"><% If IB_Type = M then response.write "복식" else response.write "단식" end if %></td>
		<td>&nbsp;<%=IB_ID%></td>
		<td>&nbsp;<%=IB_SITE%></td>
		<td align="center"><%=arr_Len%></td>
		<td align="right"><%=formatnumber(BenefitRate,2)%>&nbsp;</td>
		<td align="right"><%=formatnumber(IB_Amount,2)%>원&nbsp;</td>
		<td align="right"><%=formatnumber(Benefit,2)%>원&nbsp;</td>
		<td align="center"><%=IB_RegDate%></td>
		<td align="center">
		<% 
			If IB_Status = 0 then
				Response.write "미적용"
			Else
				Response.write "게임종료"
			end if
		%>
		</td>
	</tr>
	<%
			total = total - 1
			i = i + 1
			rs.MoveNext
			Loop
		end if
	%>
</table>
</body>
</html>

<%
	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>