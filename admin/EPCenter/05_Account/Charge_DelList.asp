<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 100
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
	


    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfAccountSql.RetrieveCharge_delList(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    'dfAccountSql.debug
	IF dfAccountSql.RsCount <> 0 Then
	    nTotalCnt = dfAccountSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 10
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
%>

<html>
<head>
<title>▒ 관리자 ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function go_regist(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("입금 처리할 정보를 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("입금처리가 되면 사용자 캐쉬가 충전이 이뤄집니다.\n정말 입금 처리하시겠습니까?")) return;		
		form.action = "Charge_Regists.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=<%=Search%>&Find=<%=Find%>";
		//form.target = "HiddenFrm";
		form.submit();
	}

	function go_regist2(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("대기 처리할 정보를 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("대기처리가 되면 신청알람이 울리지 않습니다..\n정말 대기 처리하시겠습니까?")) return;		
		form.action = "Charge_Regists2.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
		form.submit();
	}
	
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
			alert("삭제할 정보를 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("정말 삭제하시겠습니까?")) return;		
		form.action = "Charge_Delete.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
		form.submit();
	}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 충전 삭제로그</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Charge_delList.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="IC_ID" <%if Search = "IC_ID" then Response.Write "selected"%>>사용자아이디</option>
		<option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="IC_NAME" <%if Search = "IC_NAME" then Response.Write "selected"%>>입금자이름</option>
		<option value="IC_SITE" <%if Search = "IC_SITE" then Response.Write "selected"%>>사이트명</option>
		<option value="IC_STATUS" <%if Search = "IC_STATUS" then Response.Write "selected"%>>상태</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td></td>
	
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td></td> </tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="e7e7e7" >
	<td align="center" ><b>번호</b></td>
	<td align="center"><b>아이디</b></td>
	<td align="center"><b>레벨</b></td>
	<td align="center"><b>입금자</b></td>
	<td align="center"><b>입금금액</b></td>
	<td align="center"><b>보너스</b></td>
	<td align="center"><b>등록날짜</b></td>
	<td align="center"><b>처리날짜</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>상태</b></td>
	<td align="center" ><b>회원</b></td>
	<td align="center" ><b>배팅</b></td>
	<td align="center" ><b>머니</b></td>
	<td align="center" ><b>추천인</b></td>
	</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="9" height="35">현재 등록된 입금신청 내용이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfAccountSql.RsCount -1

		IC_Idx = dfAccountSql.Rs(i,"IC_IDX")
		IC_ID = dfAccountSql.Rs(i,"IC_ID")
		IC_Name = dfAccountSql.Rs(i,"IC_NAME")
		IC_Amount = dfAccountSql.Rs(i,"IC_AMOUNT")
		IC_RegDate = dfAccountSql.Rs(i,"IC_REGDATE")
		IC_SetDate = dfAccountSql.Rs(i,"IC_SETDATE")
		IC_Status = dfAccountSql.Rs(i,"IC_STATUS")
		IC_SITE	= dfAccountSql.Rs(i,"IC_SITE")
		IU_NICKNAME = dfAccountSql.Rs(i,"IU_NICKNAME")
		IC_T_YN = dfAccountSql.Rs(i,"IC_T_YN")
        IU_IDX = dfAccountSql.Rs(i,"IU_IDX")
        IC_BONUS_AMOUNT  = dfAccountSql.Rs(i,"IC_BONUS_AMOUNT")
        IU_LEVEL  = dfAccountSql.Rs(i,"IU_LEVEL")
        RECOM_ID  = dfAccountSql.Rs(i,"RECOM_ID") 
        
        IF IC_SetDate <> "" Then
            IC_SetDate = dfStringUtil.GetFullDate(IC_SetDate)
        End IF       
        
        IF IC_BONUS_AMOUNT <> "" Then
            IC_BONUS_AMOUNT = formatnumber(IC_BONUS_AMOUNT,0)
        Else
            IC_BONUS_AMOUNT = 0
        End IF
		IF IC_Status = "1" THEN
			FlagName = "완료"
		ELSEIF IC_Status = "0" then
			FlagName = "<font color='red'>신청</font>"
		ELSEIF IC_Status = "2" then
			FlagName = "<font color='blue'>대기</font>"
		END IF
%>

<tr <% if IC_Status <> "1" then Response.Write "bgcolor='#f2f8f9'" Else Response.Write "bgcolor='#ffffff'" End IF %>>
	
	<td align="center"><%=IC_IDX%></td>
<%
	iduseck = ""
	If IC_SITE = "Life" then
	sql = "select * from log_cashinout where lc_id = '"&ic_id&"' and lc_contents = '관리자증감' and lc_site = 'Life' "
	'response.write sql
	Set rsidck =  DbCon.execute(sql)
	If Not rsidck.eof Then
		iduseck = "true"
	End If 
	rsidck.close
	Set rsidck = Nothing
	End If 
%>
<%
	If iduseck <> "" Then
		response.write "<td align='center' bgcolor='#f0c8d7'>"
	Else
		response.write "<td align='center'>"
	End If 
%>
	<a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_ID&Find=<%=IC_ID%>"><%=IC_ID%>&nbsp;(<%=IU_NICKNAME%>)</a></td>
	<td align="center"><%=IU_LEVEL%></td>
	<td align="center"><a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_NAME&Find=<%=IC_Name%>"><%=IC_Name%></a></td>
	<td align="right">
	   <%=formatnumber(IC_Amount,0)%> 원 	    
	</td>
	<td align="right">
	   <%=formatnumber(IC_BONUS_AMOUNT,0)%> 원 	    
	</td>
	<td align="center"><%= dfStringUtil.GetFullDate(IC_RegDate)%>&nbsp;</td>
	<td align="center"><%=IC_SetDate%>&nbsp;</td>
	<td align='center'>
        <a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_SITE&Find=<%=IC_SITE%>"><%=IC_SITE%></a>
    </td>
	<td align="center"><%=FlagName%></td>
	<td align="center"><input type="button" value="정보" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/02_Member/View.asp?IU_IDX=<%=IU_IDX%>');"></td>
	<td align="center"><input type="button" value="배팅" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/04_Game/Betting_List1.asp?Search=IB_ID&Find=<%=IC_ID%>');"></td>
    <td align="center"><input type="button" value="머니" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/05_Account/Money_AddSub.asp?sStartDate=&sEndDate=&Search=LC_ID&Find=<%=IC_ID%>');"></td>	
	<td align="center"><%=RECOM_ID%></td>
	
	</tr>

	<%  
		Next
	%>
		
	<% END IF %></table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>


</body>
</html>
