<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/02_Member/_Sql/memberSql.Class.asp"-->

<%
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	pageSize = 10
	USERID = REQUEST("USERID")
	USERSITE = REQUEST("USERSITE")



    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfmemberSql.RetrieveInfo_Exchange(dfDBConn.Conn,  page, pageSize, USERID, USERSITE)

	IF dfMemberSql.RsCount <> 0 Then
	    nTotalCnt = dfMemberSql.RsOne("TC")
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
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- 부트스트랩 추가테마 ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- 부트스트랩  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->

<script src="/Sc/Base.js"></script></head>

<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color:#ffffff;padding:0px 3px 3px 3px;">
<div style="border:1px solid #f0f0f0">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >


<tr class="title-backgra"><th align="center" height="25" bgcolor="e7e7e7"><b>No.</b></th>
	<th align="center" height="25" bgcolor="e7e7e7"><b>환전금액</b></th>
	<th align="center" height="25" bgcolor="e7e7e7"><b>신청일자</b></th>
	<!-- <th align="center" height="25" bgcolor="e7e7e7"><b>처리일자</b></th> -->
	<th align="center" height="25" bgcolor="e7e7e7"><b>결과</b></th></tr>

<%	IF dfMemberSql.RsCount = 0 THEN	%>

<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="4" height="35">회원 환전내역이 없습니다.</td></tr>

<%
	ELSE


	FOR i = 0 TO dfMemberSql.RsCount - 1

		IE_AMOUNT		= dfMemberSql.Rs(i, "IE_AMOUNT")
		IE_REGDATE		= dfMemberSql.Rs(i, "IE_REGDATE")
		IE_SETDATE		= dfMemberSql.Rs(i, "IE_SETDATE")
		IE_STATUS		= CDbl(dfMemberSql.Rs(i, "IE_STATUS"))
		
		IF IE_STATUS  = 0 THEN
			IE_STATUS = "<font color=gray>신청</font>"
		ELSEIF IE_STATUS = 1 THEN
			IE_STATUS = "<font color=blue>완료</font>"
		ELSEIF IE_STATUS = 2 THEN
			IE_STATUS = "<font color=red>대기</font>"
		ELSEIF IE_STATUS = 3 THEN
			IE_STATUS = "<font color=red>취소</font>"
		END IF	%>
<tr bgcolor="#FFFFFF" height="24"><td width="50" align="center"><%=i%></td>
	<td align="right"><%=FORMATNUMBER(IE_AMOUNT,0)%> 원&nbsp;</td>
	<td width="160" align="center"><%=IE_REGDATE%></td>
	<!-- <td align="center"><%=IE_SETDATE%></td> -->
	<td width="40" align="center"><%=IE_STATUS%></td></tr>

	<%  
		Next %>
		
	<% END IF %>

</table> 
<div style="width:100%;text-align:center;padding:0px;margin:0px;">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
</div>
</div>
</body>
</html>