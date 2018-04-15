<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<%
	site        = SESSION("rJOBSITE")
	SQLR = " Info_betting Where Ib_Status = 1 and ib_site <> 'None' "


	'검색일자 존재시
	IF REQUEST("sStartDate") = "" AND REQUEST("sEndDate") = "" THEN
		sStartDate = date() &" 00:00:00"
		sEndDate = date() &" 23:59:59"
		SQLR = SQLR &" And Ib_regDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	ELSEIF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		sStartDate = REQUEST("sStartDate")&" 00:00:00"
		sEndDate = REQUEST("sEndDate")&" 23:59:59"
		SQLR = SQLR &" And Ib_regDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF


	'검색항목 존재시
	Search = REQUEST("Search")
	Find = REQUEST("Find")

	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF
	
	IF site <> "all" THEN
	    SQLR = SQLR &" AND Ib_SITE LIKE '"& site &"' "
	END IF


	SET LIST = Server.CreateObject("ADODB.Recordset")
	LIST.Open "SELECT Ib_Idx, Ib_ID, Ib_nickname, Ib_Amount, Ib_RegDate, Ib_SITE FROM "& SQLR &" ORDER BY Ib_RegDate Desc", dbCon, 1

	LISTCount = LIST.RecordCount
%>

<html>
<head>
<title>▒ 총판관리자 ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒</title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/seller/Css/Style.css">
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
		form.action = "betAccount_Cancel.asp?page=<%=PAGE%>";
		form.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">정산관리</font><font color="ffffff">&nbsp;&nbsp;▶ 입금 상세정보</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="betAccount_In.asp">
<tr><td>시작 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="Ib_id" <%if Search = "Ib_id" then Response.Write "selected"%>>아이디</option>
		<option value="Ib_nickNAME" <%if Search = "Ib_nickNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="Ib_SITE" <%if Search = "Ib_SITE" then Response.Write "selected"%>>사이트</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
</tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frm" method="post">
<tr height="30" bgcolor="e7e7e7"> 
	<!-- <td align="center"><b>선택</b></td> -->
	<td align="center"><b>베팅번호</b></td>
	<td align="center"><b>아이디</b></td>
	<td align="center"><b>닉네임</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>베팅액</b></td>
	<td align="center"><b>베팅시간</b></td></tr>
<%	IF LISTCount = 0 THEN %>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="7" height="35">현재 등록된 베팅정보가 없습니다.</td></tr>

<%	ELSE

		TotAmount = 0

		FOR i = 1 TO ListCount

			Ib_Idx = List(0)
			Ib_ID = List(1)
			Ib_nickName = List(2)
			Ib_Amount = List(3)
			Ib_RegDate = List(4)
			Ib_SITE = List(5)
			
			TotAmount = Cdbl(TotAmount) + Ib_Amount	%>
<tr bgcolor="#FFFFFF" height="25">
	<td align="center" width="50"><%=Ib_Idx%></td>
	<td align="center"><a href="/EPCenter/05_Account/betAccount_In.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=Ib_id&Find=<%=Ib_id%>"><%=Ib_id%></a></td>
	<td align="center" width="50"><%=Ib_nickname%></td>
	<td align="center"><a href="/EPCenter/05_Account/betAccount_In.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=Ib_SITE&Find=<%=Ib_SITE%>"><%=Ib_SITE%></a></td>
	<td align="right"><%=formatnumber(Ib_Amount,0)%> 원&nbsp;</td>
	<td align="center"><%=Ib_regDate%></td></tr>
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
