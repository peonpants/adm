<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/01_CP/_Sql/cpSql.Class.asp"-->
<%
	
  '######### Request Check                    ################	    

    
    pageSize      = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	sortColumn = ""
	sortDirection = ""
	site        = JOBSITE
	IA_SITE = Session("rJOBSITE")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_Type = RS2("IA_Type")

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '######### 총 회원수              ################	
    Dim dfCpSql1
    Set dfCpSql1 = new CpSql
	
	Call dfCpSql1.GetLOG_LOGINTotalCount( dfDBConn.Conn ) 
	
	TOMEM = dfCpSql1.RsOne("TOMEM")
    
	'######### 회원 리스트를 불러옴                 ################	
	If IA_LEVEL = "2" THEN
		Call dfCpSql.RetrieveLOG_LOGINs1(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, IA_GROUP, IA_GROUP1)
	ELSEIf IA_LEVEL = "3" THEN
		Call dfCpSql.RetrieveLOG_LOGINs2(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, IA_GROUP, IA_GROUP1, IA_GROUP2)
	ELSEIf IA_LEVEL = "4" THEN
		Call dfCpSql.RetrieveLOG_LOGINs3(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3)
	ELSEIf IA_LEVEL = "5" THEN
		Call dfCpSql.RetrieveLOG_LOGINs4(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
	End If



	IF dfCpSql.RsCount <> 0 Then
	    nTotalCnt = dfCpSql.RsOne("TC")
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
<title></title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- 부트스트랩 추가테마 ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- 부트스트랩  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->

<script src="/Sc/Base.js"></script>
</head>


<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<form name="whois_search_form">
<input name="domain_name" type="hidden" />
</form>
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> ▶ </span>

	<b><font color="#000000">로그관리</font><font color="#777777">&nbsp;&nbsp; - 총로그인수 </b> [총 인원 : <%=TOMEM%> 명] <% IF REQUEST("sStartDate") <> "" Or REQUEST("sEndDate") <> "" Or REQUEST("Search") <> "" Or REQUEST("Find") <> "" THEN %>[검색 인원 : <%=formatnumber(nTotalCnt,0)%> 명]<% END IF %></font>

	</div>


<div style="height:10px;"></div>


 




<table border="0" cellpadding="0" cellspacing="0" align="center">


<form name="MainForm" method="get" action="Login_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,12)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,12)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="LL_ID" <%if Search = "LL_ID" then Response.Write "selected"%>>아이디</option>
		<option value="LL_NICKNAME" <%if Search = "LL_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="LL_IP" <%if Request.QueryString("Search") = "LL_IP" then Response.Write "selected"%>>아이피</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>

	<div class="input-group input-group-sm">
			<input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input text_box1 form-control " style="width:100px;">
		  <span class="input-group-btn">
				  <input type="submit" value="검 색" class="btn btn-info">
			  </span>
		  </div>
	
	
	</td></tr></form></table>
	<br />


<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >

<form name="frmchk" method="post">
 

  <tr bgcolor="e7e7e7" class="title-backgra">
	<th align="center" height="30"><b>아이디</b></th>
	<th align="center" height="30"><b>닉네임</b></th>	
	<th align="center" height="30"><b>IP</b></th>
	<th align="center" height="30"><b>Login Time</b></th>
</tr>
	

<%
IF dfCpSql.RsCount = 0 THEN	
%>

<tr><td align="center" colspan="6" height="35" bgcolor="#FFFFFF">로그인 정보가 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfCpSql.RsCount -1


		LL_IDX			= dfCpSql.Rs(i,"LL_IDX")
		LL_ID			= dfCpSql.Rs(i,"LL_ID")
		LL_NICKNAME		= dfCpSql.Rs(i,"LL_NICKNAME")
		LL_IP			= dfCpSql.Rs(i,"LL_IP")
		LL_REGDATE		= dfCpSql.Rs(i,"LL_REGDATE")
		LL_SITE			= dfCpSql.Rs(i,"LL_SITE")
		BLOCKFLAG       = dfCpSql.Rs(i,"BLOCKFLAG")
	    VIP             = dfCpSql.Rs(i,"VIP")

		IF isNull(BLOCKFLAG) OR BLOCKFLAG ="" THEN
			BLOCKFLAG = "NO"
		ELSE
			BLOCKFLAG = "YES"
		END IF	

%>
<tr height="25" bgcolor="#FFFFFF">
	<td ><%=LL_ID%></td>
	<td  align="center"><a href="/Seller/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_NICKNAME&Find=<%=LL_NickName%>"><%=LL_NickName%></a></td>
	<td  align="center"  style="font-color:#666666;">
	<%=LL_IP%>
	</td>
	<td align="center" style="font-color:#666666;"><%=LL_RegDate%></td>

	</tr>
<%  
	Next 
END IF 
%>

</table>
</div>
<br />

<div style="text-align:center; width:95%;">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

</div>
</body>
</html>
