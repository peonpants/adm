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
	PGSIZE = 10
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")    
	site = JOBSITE

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfAccountSql.RetrieveExchange_List(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    
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
<title></title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script src="/Sc/Base.js"></script>
</head>

<body topmargin="25" marginheight="25">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">환전관리</font><font color="ffffff"> &nbsp;&nbsp;▶ 환전신청 리스트</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Exchange_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,12)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,12)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1'></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="A.IE_ID" <%if Search = "A.IE_ID" then Response.Write "selected"%>>아이디</option>
		<option value="A.IE_NICKNAME" <%if Search = "A.IE_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="B.IU_BankOwner" <%if Search = "B.IU_BankOwner" then Response.Write "selected"%>>입금자이름</option>		
		</select></td>
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
<tr>
	<td align="center" bgcolor="e7e7e7"><b>아이디</b></td>
	<td align="center" bgcolor="e7e7e7"><b>신청자</b></td>
	<td align="center" bgcolor="e7e7e7"><b>환전신청금액</b></td>
	<td align="center" bgcolor="e7e7e7"><b>상태</b></td>	
	<td align="center" bgcolor="e7e7e7"><b>등록날짜</b></td>
	<td align="center" bgcolor="e7e7e7"><b>처리날짜</b></td>
	
</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr><td align="center" colspan="11" height="35"  bgcolor="#FFFFFF">현재 등록된 입금신청 내용이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfAccountSql.RsCount -1


		IE_Idx = dfAccountSql.Rs(i,"IE_Idx")
		IE_ID = dfAccountSql.Rs(i,"IE_ID")
		IE_NickName = dfAccountSql.Rs(i,"IE_NickName")
		IE_Amount = dfAccountSql.Rs(i,"IE_Amount")
		IU_BankName = dfAccountSql.Rs(i,"IU_BankName")
		IU_BankNum = dfAccountSql.Rs(i,"IU_BankNum")
		IU_BankOwner = dfAccountSql.Rs(i,"IU_BankOwner")
		IE_RegDate = dfAccountSql.Rs(i,"IE_REGDATE")
		IE_SetDate = dfAccountSql.Rs(i,"IE_SetDate")
		IE_Status = dfAccountSql.Rs(i,"IE_Status")
		IE_SITE = dfAccountSql.Rs(i,"IE_SITE")
		IU_IDX = dfAccountSql.Rs(i,"IU_IDX")

		IF IE_Status = "1" THEN
			FlagName = "완료"
		ELSEIF IE_Status = "0" THEN
			FlagName = "<font color='red'>신청</font>"
		ELSEIF IE_Status = "2" THEN
			FlagName = "<font color='blue'>대기</font>"
		ELSEIF IE_Status = "3" THEN
			FlagName = "<font color='blue'>취소</font>"
		END IF	%>

<tr  bgcolor="#FFFFFF" height="25">	
	<td align="center"><%=IE_ID%></td>
	<td align="center"><%=IE_NickName%></td>
	<td align="right"><%=formatnumber(IE_Amount,0)%> 원</td>
	<td align="center"><%=FlagName%></td>
	<td align="center"><%=IE_RegDate%></td>
	<td align="center"><%=IE_SetDate%></td>
</tr>

	<%  
		Next %>
		
	<% END IF %></table><br clear="all">

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