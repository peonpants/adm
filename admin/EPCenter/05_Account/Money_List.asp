<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Set RS = Server.CreateObject("ADODB.Recordset")

	SDOP = REQUEST("SDOP")

	IF REQUEST("sStartDate") = "" AND REQUEST("sEndDate") = "" THEN
		IF SDOP = "MM" THEN
			sStartDate	= Replace(LEFT(date,8),"-","")
			sEndDate	= Replace(LEFT(date,8),"-","")
		ELSE
			sStartDate	= Replace(LEFT(date,10),"-","")
			sEndDate	= Replace(LEFT(date,10),"-","")
		END IF
	ELSEIF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		IF SDOP = "MM" THEN
			sStartDate	= Left(REQUEST("sStartDate"),6)
			sEndDate	= Left(REQUEST("sEndDate"),6)
		ELSE
			sStartDate	= REQUEST("sStartDate")
			sEndDate	= REQUEST("sEndDate")
		END IF
	END IF
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script></head>

<body topmargin="0" marginheight="0">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">자금 현황 리스트</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Money_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,8)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,8)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><select name="SDOP" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="DD" <%if SDOP = "DD" then Response.Write "selected"%>>일별검색</option>
		<option value="MM" <%if SDOP = "MM" then Response.Write "selected"%>>월별검색</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="엑셀저장" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr><td width="20%" align="center" bgcolor="e7e7e7"><b>검색일</b></td>
	<td width="20%" align="center" bgcolor="e7e7e7"><b>입 금</b></td>
	<td width="20%" align="center" bgcolor="e7e7e7"><b>출 금</b></td>
	<td width="20%" align="center" bgcolor="e7e7e7"><b>배 팅</b></td>
	<td width="20%" align="center" bgcolor="e7e7e7"><b>배 당</b></td></tr>

<%
	FOR	SD = sStartDate To sEndDate

		IF CDbl(sStartDate) = CDbl(sEndDate+1) THEN
			EXIT FOR
		END IF

		IF SDOP = "MM" THEN
			SQLR		= " LC_REGDATE >= '"& sStartDate &"' AND LC_REGDATE <= '"& sEndDate &"'"
		ELSE
			SQLR		= " LC_REGDATE >= '"& sStartDate &"' AND LC_REGDATE <= '"& sEndDate &"'"
		END IF

		SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE LC_CONTENTS='머니충전' AND "& SQLR &" "
		SET RSLIST = DbCon.Execute(SQLLIST)
		INSUM = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = NOTHING

		SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE LC_CONTENTS='환전차감' AND "& SQLR &" "
		SET RSLIST = DbCon.Execute(SQLLIST)
		OUTSUM = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = NOTHING

		SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE LC_CONTENTS='배팅차감' AND "& SQLR &" "
		SET RSLIST = DbCon.Execute(SQLLIST)
		BINSUM = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = NOTHING

		SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE LC_CONTENTS='배팅취소' AND "& SQLR &" "
		SET RSLIST = DbCon.Execute(SQLLIST)
		BOUSUM = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = NOTHING

		SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE LC_CONTENTS='배팅배당' AND "& SQLR &" "
		SET RSLIST = DbCon.Execute(SQLLIST)
		BTOSUM = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = NOTHING

		TINSUM = TINSUM + INSUM
		TOUTSUM = TOUTSUM + OUTSUM
		TBINSUM = TBINSUM + BINSUM
		TBOUSUM = TBOUSUM + BOUSUM
		TBTOSUM = TBTOSUM + BTOSUM
%>

<tr bgcolor="#FFFFFF" height="25"><td align="center"><%=sStartDate%></td>
	<td align="right"><%=FORMATNUMBER(INSUM,0)%> 원&nbsp;</td>
	<td align="right"><%=FORMATNUMBER(ABS(OUTSUM),0)%> 원&nbsp;</td>
	<td align="right"><%=FORMATNUMBER(ABS(BINSUM)-BOUSUM,0)%> 원&nbsp;</td>
	<td align="right"><%=FORMATNUMBER(BTOSUM,0)%> 원&nbsp;</td></tr>

<%
	IF SDOP = "DD" THEN
		IF Right(sStartDate,2) = "31" THEN
			sSm = CDbl(Mid(sStartDate,5,2)) + 1
			IF Len(sSm) = 1 THEN
				sStartDate = Left(sStartDate,4)&"0"&sSm&"01"
			ELSE
				sStartDate = Left(sStartDate,4)&sSm&"01"
			END IF
		ELSE
			sStartDate = sStartDate + 1
		END IF
	ELSEIF SDOP = "MM" THEN
		sStartDate = sStartDate + 1
	END IF

	NEXT
%>

<tr><td align="center"><b>합 계</b></td>
	<td align="right"><b><%=FORMATNUMBER(TINSUM,0)%> 원&nbsp;</b></td>
	<td align="right"><b><%=FORMATNUMBER(ABS(TOUTSUM),0)%> 원&nbsp;</b></td>
	<td align="right"><b><%=FORMATNUMBER(ABS(TBINSUM)-TBOUSUM,0)%> 원&nbsp;</b></td>
	<td align="right"><b><%=FORMATNUMBER(TBTOSUM,0)%> 원&nbsp;</b></td></tr>

</table><br clear="all">

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>