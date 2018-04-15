<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")
	site = JOBSITE
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfAccountSql.RetrieveCharge_List(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
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
	objPager.PageButtonCount = 5
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

  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script src="/Sc/Base.js"></script>

</head>

<body topmargin="25" marginheight="25">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">충전관리</font><font color="ffffff"> &nbsp;&nbsp;▶ 입금신청 리스트</font></b></td></tr></table>
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Charge_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,12)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,12)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="IC_ID" <%if Search = "IC_ID" then Response.Write "selected"%>>사용자아이디</option>
		<option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="IC_NAME" <%if Search = "IC_NAME" then Response.Write "selected"%>>입금자이름</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"> 상태값 : 1 (완료) / 2 (대기)</td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="엑셀저장" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr>
	<td align="center" bgcolor="e7e7e7"><b>사용자아이디</b></td>
	<td align="center" bgcolor="e7e7e7"><b>입금예정금액</b></td>
	<td align="center" bgcolor="e7e7e7"><b>등록날짜</b></td>
	<td align="center" bgcolor="e7e7e7"><b>처리날짜</b></td>
	<td align="center" bgcolor="e7e7e7"><b>상태</b></td>
</tr>
<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr><td align="center" colspan="9" height="35" bgcolor="#FFFFFF">현재 등록된 입금신청 내용이 없습니다.</td></tr>

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
        
		IF IC_Status = "1" THEN
			FlagName = "완료"
		ELSEIF IC_Status = "0" then
			FlagName = "<font color='red'>신청</font>"
		ELSEIF IC_Status = "2" then
			FlagName = "<font color='blue'>대기</font>"
		END IF	%>

<tr height="25" bgcolor="#FFFFFF">	
    <td align='center'>
	<%=IC_ID%>&nbsp;(<%=IU_NICKNAME%>)</td>
	<td align="right"><%=formatnumber(IC_Amount,0)%> 원&nbsp;</td>
	<td align="center"><%=IC_RegDate%>&nbsp;</td>
	<td align="center"><%=IC_SetDate%>&nbsp;</td>
	<td align="center"><%=FlagName%></td>
</tr>

	<%  
		Next
	%>
		
	<% END IF %></table>
	<br />
<div align="center">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
</div>

</body>
</html>