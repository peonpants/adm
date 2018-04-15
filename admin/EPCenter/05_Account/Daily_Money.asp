<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SETSIZE = 20
	PGSIZE = 50


	IF REQUEST("PAGE") = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(REQUEST("PAGE")) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END IF


	SQLR = " Log_CashInOut Where 1=1 "


	'검색일자 존재시
	IF REQUEST("sStartDate") = "" AND REQUEST("sEndDate") = "" THEN
		sStartDate = Replace(LEFT(DateAdd("d",-1,date),10),"-","-")&" 00:00:00"
		sEndDate = Replace(LEFT(date,10),"-","-")&" 23:59:59"
		SQLR = SQLR &" And LC_RegDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	ELSEIF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		sStartDate = REQUEST("sStartDate")&" 00:00:00"
		sEndDate = REQUEST("sEndDate")&" 23:59:59"
		SQLR = SQLR &" And LC_RegDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF


	'검색항목 존재시
	Search = REQUEST("Search")
	Find = REQUEST("Find")
	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" = '"&Find&"'"
	END IF



	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLLIST = "SELECT COUNT(*) AS TN From "& SQLR &""
	
	
	SET RSLIST = DbCon.Execute(SQLLIST)
	TN = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing
	

	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END IF


	LISTSQL = "SELECT TOP "&PGSIZE*PAGE&" LC_IDX, LC_ID, LC_CASH, LC_GCASH, LC_CONTENTS, LC_REGDATE, LC_SITE FROM "& SQLR &" ORDER BY LC_RegDate DESC"

	DbRec.Open LISTSQL, DbCon

	IF NOT DbRec.EOF THEN
		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END IF
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function go_delete(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				//if (v_cnt == 0)
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0) 
		{ 
			alert("결제취소할 정보를 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("정말 취소하시겠습니까?")) return;		
		form.action = "CashAccount_Cancel.asp?page=<%=PAGE%>";
		form.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">정산관리</font><font color="ffffff">&nbsp;&nbsp;▶ Money 정보</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Daily_Money.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolo역:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="LC_ID" <%if Search = "LC_ID" then Response.Write "selected"%>>사용자아이디</option>
		<option value="LC_CONTENTS" <%if Search = "LC_CONTENTS" then Response.Write "selected"%>>처리내역</option>
		<option value="LC_SITE" <%if Search = "LC_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="엑셀저장" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frm" method="post">
<tr height="30" bgcolor="e7e7e7"> 
	<!-- <td align="center"><b>선택</b></td> -->
	<td align="center" width="60"><b>No.</b></td>
	<td align="center" width="80"><b>아이디</b></td>
	<td align="center" width="80"><b>사이트</b></td>
	<td align="center" width="120"><b>사용머니</b></td>
	<td align="center" width="120"><b>최종머니</b></td>
	<td align="center" width="100"><b>내&nbsp;&nbsp;역</b></td>
	<td align="center" width="150"><b>날짜</b></td>
	<td align="center"><b>비고</b></td></tr>

<%	IF TN = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="8" height="35">현재 등록된 정보가 없습니다.</td></tr>

<%
	ELSE

	TotCash = 0

	DbRec.Move PGSIZE * (PAGE-1)
	FOR i = 1 TO PGSIZE
		IF DbRec.EOF THEN
			EXIT FOR
		END IF

		LC_IDX		= DbRec(0)
		LC_ID		= DbRec(1)
		LC_CASH		= DbRec(2)
		LC_GCASH	= DbRec(3)
		LC_CONTENTS	= DbRec(4)
		LC_REGDATE	= DbRec(5)
		LC_SITE	= DbRec(6)
		
		TotCash = Cdbl(TotCash) + Cdbl(LC_CASH)		%>

<tr bgcolor="#FFFFFF" height="25">
    <td align="center" width="50"><%=NN%></td>
	<td>&nbsp;<a href="/EPCenter/05_Account/Daily_Money.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_ID&Find=<%=LC_ID%>"><%=LC_ID%></a></td>
	<td>&nbsp;<a href="/EPCenter/05_Account/Daily_Money.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_SITE&Find=<%=LC_SITE%>"><%=LC_SITE%></a></td>
	<td align="right"><%=FORMATNUMBER(LC_CASH,0)%> 원&nbsp;</td>
	<td align="right"><%=FORMATNUMBER(LC_GCASH,0)%> 원&nbsp;</td>
	<td align="center"><a href="/EPCenter/05_Account/Daily_Money.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_CONTENTS&Find=<%=LC_CONTENTS%>"><%=LC_CONTENTS%></a></td>
	<td align="center"><%=LC_REGDATE%></td>
	<td align="center">&nbsp;</td></tr>

	<%  NN = NN - 1 
		DbRec.MoveNext
		Next %>

<tr><td colspan="3" align="center"><b>합 계</b></td>
	<td align="right"><b><%=FORMATNUMBER(TotCash,0)%>&nbsp;원&nbsp;</b></td>
	<td align="right">&nbsp;</td>
	<td colspan="3" align="center">&nbsp;</td></tr>

	<% END IF %></table><br clear="all">

<%	IF TN > 0 THEN	%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><table border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
		
		<%	IF STARTPAGE = 1 THEN
				Response.Write "<td valign=bottom>[이전 10개]<img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			ELSEIF STARTPAGE > SETSIZE THEN
				Response.Write "<td valign=bottom><a href=Daily_money.asp?page="&STARTPAGE-SETSIZE&"&sStartDate="&Left(sStartDate,10)&"&sEndDate="&Left(sEndDate,10)&"&Search="& Search&"&Find="&Find&">[이전 10개]</a><img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			END IF %>

			<td valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0" height="20"><tr>
			<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1
		
				IF i > PGCOUNT THEN
					EXIT FOR
				END IF
	
			IF PAGE = i THEN
				Response.Write "<td width=20 bgcolor=#ff0000 align=center><font color=#ffffff size=2><b>"&i&"</b></font></td>"
			ELSE
				Response.Write "<td width=20 align=center valign=bottom><a href=Daily_money.asp?page="&i&"&sStartDate="&Left(sStartDate,10)&"&sEndDate="&Left(sEndDate,10)&"&Search="& Search&"&Find="&Find&">"&i&"</a></td>"
			END IF
			
			NEXT %></tr></table></td>

		<%	IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1>[다음 10개]</td>"
			ELSEIF i > PGCOUNT THEN
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1>[다음 10개]</td>"
			ELSE
				Response.Write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1><a href=Daily_money.asp?page="&STARTPAGE+SETSIZE&"&sStartDate="&Left(sStartDate,10)&"&sEndDate="&Left(sEndDate,10)&"&Search="& Search&"&Find="&Find&">[다음 10개]</a></td>"
			END IF %></tr>
		<tr><td colspan="3"><img src="../images/sub/blank.gif" border="0" width="1" height="10"></td></tr></table></tr></td></table>
<%	END IF	%>

</body>
</html>

<%
	DbRec.Close
	Set DbRec=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>