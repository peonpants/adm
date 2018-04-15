<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<%
	SSSITE        = Trim(dfRequest.Value("SSSITE"))
    IF SSSITE = "" Then
		if left(request.Cookies("AdminID"),2) = "s1" then
			SSSITE = "DAOLs1%"
		ElseIf left(request.Cookies("AdminID"),2) = "ad" then
			SSSITE = "DAOL%"
		ElseIf left(request.Cookies("AdminID"),2) = "s2" then
			SSSITE = "DAOLs2%"
		ElseIf left(request.Cookies("AdminID"),2) = "s3" then
			SSSITE = "DAOLs3%"
		ElseIf left(request.Cookies("AdminID"),2) = "s4" then
			SSSITE = "DAOLs4%"
		ElseIf left(request.Cookies("AdminID"),2) = "s5" then
			SSSITE = "DAOLs5%"
		ElseIf left(request.Cookies("AdminID"),2) = "s6" then
			SSSITE = "DAOLs6%"
		ElseIf left(request.Cookies("AdminID"),2) = "s7" then
			SSSITE = "DAOLs7%"
		ElseIf left(request.Cookies("AdminID"),2) = "s8" then
			SSSITE = "DAOLs8%"
		ElseIf left(request.Cookies("AdminID"),2) = "s9" then
			SSSITE = "DAOLs9%"

		end if
    End IF
    site = SSSITE 'REQUEST("JOBSITE")

	SQLR = " Info_Exchange A where A.IE_Status = 1 "

	'검색일자 존재시
	IF REQUEST("sStartDate") = "" AND REQUEST("sEndDate") = "" THEN
		sStartDate = date() &" 00:00:00"
		sEndDate = date() &" 23:59:59"
		SQLR = SQLR &" And A.IE_SetDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	ELSEIF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		sStartDate = REQUEST("sStartDate")&" 00:00:00"
		sEndDate = REQUEST("sEndDate")&" 23:59:59"
		SQLR = SQLR &" And A.IE_SetDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF


	'검색항목 존재시
	Search = REQUEST("Search")
	Find = REQUEST("Find")
	'site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF

	IF site <> "all" THEN
	    SQLR = SQLR &" AND Ie_SITE LIKE '"& site &"' "
	END IF

	SET LIST = Server.CreateObject("ADODB.Recordset")
	LIST.Open "SELECT A.IE_Idx, A.IE_ID, A.IE_NickName, A.IE_Amount,(select IU_BankName from info_user where iu_id=a.ie_id and iu_site=a.ie_site) as  IU_BankName,(select IU_BankNum from info_user where iu_id=a.ie_id and iu_site=a.ie_site) as  IU_BankNum,(select IU_BankOwner from info_user where iu_id=a.ie_id and iu_site=a.ie_site) as IU_BankOwner, A.IE_REGDATE, A.IE_SetDate, A.IE_SITE FROM "& SQLR &" ORDER BY A.IE_RegDate Desc", dbCon, 1

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
<form name="SubForm" method="get" action="CashAccount_out.asp">
<% if left(request.Cookies("AdminID"),2) = "s1" then%>
	<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="" <%if SSSITE = "" then Response.Write "selected"%>>DAOLs100(ALL)</option>
	    <option value="DAOLs100" <%if SSSITE = "DAOLs100" then Response.Write "selected"%>>DAOLs100(메인)</option>
	    <option value="DAOLs101" <%if SSSITE = "DAOLs101" then Response.Write "selected"%>>DAOLs101</option>
	    <option value="DAOLs102" <%if SSSITE = "DAOLs102" then Response.Write "selected"%>>DAOLs102</option>
	    <option value="DAOLs103" <%if SSSITE = "DAOLs103" then Response.Write "selected"%>>DAOLs103</option>
	    <option value="DAOLs104" <%if SSSITE = "DAOLs104" then Response.Write "selected"%>>DAOLs104</option>
	    <option value="DAOLs105" <%if SSSITE = "DAOLs105" then Response.Write "selected"%>>DAOLs105</option>
	    <option value="DAOLs106" <%if SSSITE = "DAOLs106" then Response.Write "selected"%>>DAOLs106</option>
	    <option value="DAOLs107" <%if SSSITE = "DAOLs107" then Response.Write "selected"%>>DAOLs107</option>
	    <option value="DAOLs108" <%if SSSITE = "DAOLs108" then Response.Write "selected"%>>DAOLs108</option>
	    <option value="DAOLs109" <%if SSSITE = "DAOLs109" then Response.Write "selected"%>>DAOLs109</option>
	    <option value="DAOLs110" <%if SSSITE = "DAOLs110" then Response.Write "selected"%>>DAOLs110</option>

		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s2"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs200" <%if SSSITE = "DAOLs200" then Response.Write "selected"%>>DAOLs200</option>
	    <option value="DAOLs201" <%if SSSITE = "DAOLs201" then Response.Write "selected"%>>DAOLs201</option>
	    <option value="DAOLs202" <%if SSSITE = "DAOLs202" then Response.Write "selected"%>>DAOLs202</option>
		<option value="DAOLs203" <%if SSSITE = "DAOLs203" then Response.Write "selected"%>>DAOLs203</option>
	    <option value="DAOLs204" <%if SSSITE = "DAOLs204" then Response.Write "selected"%>>DAOLs204</option>
		<option value="DAOLs205" <%if SSSITE = "DAOLs205" then Response.Write "selected"%>>DAOLs205</option>
	    <option value="DAOLs206" <%if SSSITE = "DAOLs206" then Response.Write "selected"%>>DAOLs206</option>
	    <option value="DAOLs207" <%if SSSITE = "DAOLs207" then Response.Write "selected"%>>DAOLs207</option>
	    <option value="DAOLs208" <%if SSSITE = "DAOLs208" then Response.Write "selected"%>>DAOLs208</option>
	    <option value="DAOLs209" <%if SSSITE = "DAOLs209" then Response.Write "selected"%>>DAOLs209</option>
		<option value="DAOLs210" <%if SSSITE = "DAOLs210" then Response.Write "selected"%>>DAOLs210</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s3"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs300" <%if SSSITE = "DAOLs300" then Response.Write "selected"%>>DAOLs300</option>
	    <option value="DAOLs301" <%if SSSITE = "DAOLs301" then Response.Write "selected"%>>DAOLs301</option>
	    <option value="DAOLs302" <%if SSSITE = "DAOLs302" then Response.Write "selected"%>>DAOLs302</option>
		<option value="DAOLs303" <%if SSSITE = "DAOLs303" then Response.Write "selected"%>>DAOLs303</option>
	    <option value="DAOLs304" <%if SSSITE = "DAOLs304" then Response.Write "selected"%>>DAOLs304</option>
		<option value="DAOLs305" <%if SSSITE = "DAOLs305" then Response.Write "selected"%>>DAOLs305</option>
	    <option value="DAOLs306" <%if SSSITE = "DAOLs306" then Response.Write "selected"%>>DAOLs306</option>
	    <option value="DAOLs307" <%if SSSITE = "DAOLs307" then Response.Write "selected"%>>DAOLs307</option>
	    <option value="DAOLs308" <%if SSSITE = "DAOLs308" then Response.Write "selected"%>>DAOLs308</option>
	    <option value="DAOLs309" <%if SSSITE = "DAOLs309" then Response.Write "selected"%>>DAOLs309</option>
		<option value="DAOLs310" <%if SSSITE = "DAOLs310" then Response.Write "selected"%>>DAOLs310</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s4"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs400" <%if SSSITE = "DAOLs400" then Response.Write "selected"%>>DAOLs400</option>
	    <option value="DAOLs401" <%if SSSITE = "DAOLs401" then Response.Write "selected"%>>DAOLs401</option>
	    <option value="DAOLs402" <%if SSSITE = "DAOLs402" then Response.Write "selected"%>>DAOLs402</option>
		<option value="DAOLs403" <%if SSSITE = "DAOLs403" then Response.Write "selected"%>>DAOLs403</option>
	    <option value="DAOLs404" <%if SSSITE = "DAOLs404" then Response.Write "selected"%>>DAOLs404</option>
		<option value="DAOLs405" <%if SSSITE = "DAOLs405" then Response.Write "selected"%>>DAOLs405</option>
	    <option value="DAOLs406" <%if SSSITE = "DAOLs406" then Response.Write "selected"%>>DAOLs406</option>
	    <option value="DAOLs407" <%if SSSITE = "DAOLs407" then Response.Write "selected"%>>DAOLs407</option>
	    <option value="DAOLs408" <%if SSSITE = "DAOLs408" then Response.Write "selected"%>>DAOLs408</option>
	    <option value="DAOLs409" <%if SSSITE = "DAOLs409" then Response.Write "selected"%>>DAOLs409</option>
		<option value="DAOLs410" <%if SSSITE = "DAOLs410" then Response.Write "selected"%>>DAOLs410</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s5"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs500" <%if SSSITE = "DAOLs500" then Response.Write "selected"%>>DAOLs500</option>
	    <option value="DAOLs501" <%if SSSITE = "DAOLs501" then Response.Write "selected"%>>DAOLs501</option>
	    <option value="DAOLs502" <%if SSSITE = "DAOLs502" then Response.Write "selected"%>>DAOLs502</option>
		<option value="DAOLs503" <%if SSSITE = "DAOLs503" then Response.Write "selected"%>>DAOLs503</option>
	    <option value="DAOLs504" <%if SSSITE = "DAOLs504" then Response.Write "selected"%>>DAOLs504</option>
		<option value="DAOLs505" <%if SSSITE = "DAOLs505" then Response.Write "selected"%>>DAOLs505</option>
	    <option value="DAOLs506" <%if SSSITE = "DAOLs506" then Response.Write "selected"%>>DAOLs506</option>
	    <option value="DAOLs507" <%if SSSITE = "DAOLs507" then Response.Write "selected"%>>DAOLs507</option>
	    <option value="DAOLs508" <%if SSSITE = "DAOLs508" then Response.Write "selected"%>>DAOLs508</option>
	    <option value="DAOLs509" <%if SSSITE = "DAOLs509" then Response.Write "selected"%>>DAOLs509</option>
		<option value="DAOLs510" <%if SSSITE = "DAOLs510" then Response.Write "selected"%>>DAOLs510</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s6"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs600" <%if SSSITE = "DAOLs600" then Response.Write "selected"%>>DAOLs600</option>
	    <option value="DAOLs601" <%if SSSITE = "DAOLs601" then Response.Write "selected"%>>DAOLs601</option>
	    <option value="DAOLs602" <%if SSSITE = "DAOLs602" then Response.Write "selected"%>>DAOLs602</option>
		<option value="DAOLs603" <%if SSSITE = "DAOLs603" then Response.Write "selected"%>>DAOLs603</option>
	    <option value="DAOLs604" <%if SSSITE = "DAOLs604" then Response.Write "selected"%>>DAOLs604</option>
		<option value="DAOLs605" <%if SSSITE = "DAOLs605" then Response.Write "selected"%>>DAOLs605</option>
	    <option value="DAOLs606" <%if SSSITE = "DAOLs606" then Response.Write "selected"%>>DAOLs606</option>
	    <option value="DAOLs607" <%if SSSITE = "DAOLs607" then Response.Write "selected"%>>DAOLs607</option>
	    <option value="DAOLs608" <%if SSSITE = "DAOLs608" then Response.Write "selected"%>>DAOLs608</option>
	    <option value="DAOLs609" <%if SSSITE = "DAOLs609" then Response.Write "selected"%>>DAOLs609</option>
		<option value="DAOLs610" <%if SSSITE = "DAOLs610" then Response.Write "selected"%>>DAOLs610</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s7"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs700" <%if SSSITE = "DAOLs700" then Response.Write "selected"%>>DAOLs700</option>
	    <option value="DAOLs701" <%if SSSITE = "DAOLs701" then Response.Write "selected"%>>DAOLs701</option>
	    <option value="DAOLs702" <%if SSSITE = "DAOLs702" then Response.Write "selected"%>>DAOLs702</option>
		<option value="DAOLs703" <%if SSSITE = "DAOLs703" then Response.Write "selected"%>>DAOLs703</option>
	    <option value="DAOLs704" <%if SSSITE = "DAOLs704" then Response.Write "selected"%>>DAOLs704</option>
		<option value="DAOLs705" <%if SSSITE = "DAOLs705" then Response.Write "selected"%>>DAOLs705</option>
	    <option value="DAOLs706" <%if SSSITE = "DAOLs706" then Response.Write "selected"%>>DAOLs706</option>
	    <option value="DAOLs707" <%if SSSITE = "DAOLs707" then Response.Write "selected"%>>DAOLs707</option>
	    <option value="DAOLs708" <%if SSSITE = "DAOLs708" then Response.Write "selected"%>>DAOLs708</option>
	    <option value="DAOLs709" <%if SSSITE = "DAOLs709" then Response.Write "selected"%>>DAOLs709</option>
		<option value="DAOLs710" <%if SSSITE = "DAOLs710" then Response.Write "selected"%>>DAOLs710</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s8"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs800" <%if SSSITE = "DAOLs800" then Response.Write "selected"%>>DAOLs800</option>
	    <option value="DAOLs801" <%if SSSITE = "DAOLs801" then Response.Write "selected"%>>DAOLs801</option>
	    <option value="DAOLs802" <%if SSSITE = "DAOLs802" then Response.Write "selected"%>>DAOLs802</option>
		<option value="DAOLs803" <%if SSSITE = "DAOLs803" then Response.Write "selected"%>>DAOLs803</option>
	    <option value="DAOLs804" <%if SSSITE = "DAOLs804" then Response.Write "selected"%>>DAOLs804</option>
		<option value="DAOLs805" <%if SSSITE = "DAOLs805" then Response.Write "selected"%>>DAOLs805</option>
	    <option value="DAOLs806" <%if SSSITE = "DAOLs806" then Response.Write "selected"%>>DAOLs806</option>
	    <option value="DAOLs807" <%if SSSITE = "DAOLs807" then Response.Write "selected"%>>DAOLs807</option>
	    <option value="DAOLs808" <%if SSSITE = "DAOLs808" then Response.Write "selected"%>>DAOLs808</option>
	    <option value="DAOLs809" <%if SSSITE = "DAOLs809" then Response.Write "selected"%>>DAOLs809</option>
		<option value="DAOLs810" <%if SSSITE = "DAOLs810" then Response.Write "selected"%>>DAOLs810</option>		
		</select>
<% ElseIf left(request.Cookies("AdminID"),2) = "s9"  then%>
		<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="DAOLs900" <%if SSSITE = "DAOLs900" then Response.Write "selected"%>>DAOLs900</option>
	    <option value="DAOLs901" <%if SSSITE = "DAOLs901" then Response.Write "selected"%>>DAOLs901</option>
	    <option value="DAOLs902" <%if SSSITE = "DAOLs902" then Response.Write "selected"%>>DAOLs902</option>
		<option value="DAOLs903" <%if SSSITE = "DAOLs903" then Response.Write "selected"%>>DAOLs903</option>
	    <option value="DAOLs904" <%if SSSITE = "DAOLs904" then Response.Write "selected"%>>DAOLs904</option>
		<option value="DAOLs905" <%if SSSITE = "DAOLs905" then Response.Write "selected"%>>DAOLs905</option>
	    <option value="DAOLs906" <%if SSSITE = "DAOLs906" then Response.Write "selected"%>>DAOLs906</option>
	    <option value="DAOLs907" <%if SSSITE = "DAOLs907" then Response.Write "selected"%>>DAOLs907</option>
	    <option value="DAOLs908" <%if SSSITE = "DAOLs908" then Response.Write "selected"%>>DAOLs908</option>
	    <option value="DAOLs909" <%if SSSITE = "DAOLs909" then Response.Write "selected"%>>DAOLs909</option>
		<option value="DAOLs910" <%if SSSITE = "DAOLs910" then Response.Write "selected"%>>DAOLs910</option>		
		</select>
<% elseif left(request.Cookies("AdminID"),2) = "ad" then%>
	<select name="SSSITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="" <%if SSSITE = "" then Response.Write "selected"%>>전체(ALL)</option>
	    <option value="DAOL%" <%if SSSITE = "DAOL%" then Response.Write "selected"%>>DAOL(전체)</option>

		</select>

<% end if %>
	  <input type="submit" value="선택" class="input">
		</form>
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">정산관리</font><font color="ffffff">&nbsp;&nbsp;▶ 출금 상세정보</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="CashAccount_Out.asp">
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
		<option value="A.IE_ID" <%if Search = "A.IE_ID" then Response.Write "selected"%>>사용자아이디</option>
		<option value="B.IU_BankOwner" <%if Search = "B.IU_BankOwner" then Response.Write "selected"%>>입금자이름</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="엑셀저장" onclick="location.href='CashAccount_Out_Excel.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frm" method="post">
<tr height="30" bgcolor="e7e7e7"> 
	<!-- <td align="center"><b>선택</b></td> -->
	<td align="center"><b>No.</b></td>
	<td align="center"><b>아이디(닉네임)</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>결제금액</b></td>
	<td align="center"><b>은행</b></td>
	<td align="center"><b>예금주</b></td>
	<td align="center"><b>계좌번호</b></td>
	<td align="center"><b>신청일</b></td>
	<td align="center"><b>확인일</b></td></tr>

<%	IF LISTCount = 0 THEN %>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="9" height="35">현재 등록된 환전정보가 없습니다.</td></tr>

<%	ELSE

		TotAmount = 0

		FOR i = 1 TO ListCount

			IE_Idx = LIST(0)
			IE_ID = LIST(1)
			IE_NickName = LIST(2)
			IE_Amount = LIST(3)
			IU_BankName = LIST(4)
			IU_BankOwner = LIST(6)
			'IU_BankNum = LIST(5)
			IE_RegDate = LIST(7)
			IE_SetDate = LIST(8)
			IE_SITE	= LIST(9)
			
			TotAmount = Cdbl(TotAmount) + IE_Amount		%>

<tr bgcolor="#FFFFFF" height="25"><!-- <td align="center" width="40"><input type="checkbox" name="SelUser" value="<%=IE_Idx%>"></td> -->
	<td align="center" width="50"><%=i%></td>
	<td align="center"><a href="/EPCenter/05_Account/CashAccount_Out.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=A.IE_ID&Find=<%=IE_ID%>"><b><%=IE_ID%>(<%=IE_NickName%>)</b></a></td>
	<%
	If IE_SITE = "Life" Then
		response.write "<td align='center' bgcolor='#ffcccc'>"
	elseIf IE_SITE = "Media" Then
		response.write "<td align='center' bgcolor='#648ba6'>"
	Else 
		response.write "<td align='center'>"
	End If 
	%>
<a href="/EPCenter/05_Account/CashAccount_Out.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=A.IE_SITE&Find=<%=IE_SITE%>"><%=IE_SITE%></td>
	<td align="right"><%=formatnumber(IE_Amount,0)%> 원&nbsp;</td>
	<td align="center"><%=IU_BankName%></td>
	<td align="center"><a href="/EPCenter/05_Account/CashAccount_Out.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=B.IU_BankOwner&Find=<%=IU_BankOwner%>"><%=IU_BankOwner%></a></td>
	<td align="center"><%=IU_BankNum%></td>
	<td align="center"><%=IE_RegDate%></td>
	<td align="center"><%=IE_SetDate%></td></tr>

<%	List.Movenext
	Next	%>

<tr><td colspan="5" align="center"><b>합 계</b></td>
	<td align="right"><b><%=formatnumber(TotAmount,0)%> 원&nbsp;</b></td>
	<td colspan="3" align="center">&nbsp;</td></tr>
	
<%	END IF	%></table>

</body>
</html>

<%
	List.Close
	Set List=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>