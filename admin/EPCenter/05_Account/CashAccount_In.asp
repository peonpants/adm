<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SQLR = " Info_Charge Where IC_Status = 1 "


	'검색일자 존재시
	IF REQUEST("sStartDate") = "" AND REQUEST("sEndDate") = "" THEN
		sStartDate = date() &" 00:00:00"
		sEndDate = date() &" 23:59:59"
		SQLR = SQLR &" And IC_SetDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	ELSEIF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		sStartDate = REQUEST("sStartDate")&" 00:00:00"
		sEndDate = REQUEST("sEndDate")&" 23:59:59"
		SQLR = SQLR &" And IC_SetDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF


	'검색항목 존재시
	Search = REQUEST("Search")
	Find = REQUEST("Find")
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF
	
	IF site <> "all" THEN
	    SQLR = SQLR &" AND IC_SITE = '"& site &"' "
	END IF


	SET LIST = Server.CreateObject("ADODB.Recordset")
	LIST.Open "SELECT IC_Idx, IC_ID, IC_Name, IC_Amount, IC_RegDate, IC_SetDate, IC_SITE FROM "& SQLR &" ORDER BY IC_RegDate Desc", dbCon, 1

	LISTCount = LIST.RecordCount
%>

<html>
<head>
<title>▒ 관리자 ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
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
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">정산관리</font><font color="ffffff">&nbsp;&nbsp;▶ 입금 상세정보</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="CashAccount_In.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="IC_ID" <%if Search = "IC_ID" then Response.Write "selected"%>>사용자아이디</option>
		<option value="IC_NAME" <%if Search = "IC_NAME" then Response.Write "selected"%>>입금자이름</option>
		<option value="IC_SITE" <%if Search = "IC_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="엑셀저장" onclick="location.href='CashAccount_In_Excel.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frm" method="post">
<tr height="30" bgcolor="e7e7e7"> 
	<!-- <td align="center"><b>선택</b></td> -->
	<td align="center"><b>No.</b></td>
	<td align="center"><b>아이디</b></td>
	<td align="center"><b>닉네임</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>결제금액</b></td>
	<td align="center"><b>신청일</b></td>
	<td align="center"><b>확인일</b></td></tr>

<%	IF LISTCount = 0 THEN %>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="7" height="35">현재 등록된 충전정보가 없습니다.</td></tr>

<%	ELSE

		TotAmount = 0

		FOR i = 1 TO ListCount

			IC_Idx = List(0)
			IC_ID = List(1)
			IC_Name = List(2)
			IC_Amount = List(3)
			IC_RegDate = List(4)
			IC_SetDate = List(5)
			IC_SITE = List(6)
			
			TotAmount = Cdbl(TotAmount) + IC_Amount	%>
<tr bgcolor="#FFFFFF" height="25">
	<td align="center" width="50"><%=i%></td>
	<td align="center"><a href="/EPCenter/05_Account/CashAccount_In.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_ID&Find=<%=IC_ID%>"><b><%=IC_ID%></b></a></td>
	<td align="center"><a href="/EPCenter/05_Account/CashAccount_In.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_NAME&Find=<%=IC_Name%>"><%=IC_Name%></a></td>
	<%
	If IC_SITE = "Life" Then
		response.write "<td align='center' bgcolor='#ffcccc'>"
	elseIf IC_SITE = "Media" Then
		response.write "<td align='center' bgcolor='#648ba6'>"
	Else 
		response.write "<td align='center'>"
	End If 
	%>
<a href="/EPCenter/05_Account/CashAccount_In.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_SITE&Find=<%=IC_SITE%>"><%=IC_SITE%></a></td>
	<td align="right"><%=formatnumber(IC_Amount,0)%> 원&nbsp;</td>
	<td align="center"><%=IC_RegDate%></td>
	<td align="center"><%=IC_SetDate%></td></tr>

<%	List.Movenext
	Next	%>

<tr><td colspan="4" align="center"><b>합 계</b></td>
	<td align="right"><b><%=formatnumber(TotAmount,0)%> 원&nbsp;</b></td>
	<td colspan="2" align="center">&nbsp;</td></tr>
	
<%	END IF	%></table>

</body>
</html>

<%
	List.Close
	Set List=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>