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
   
	Call dfmemberSql.RetrieveLog_LoginByUser(dfDBConn.Conn,  page, pageSize, USERID, USERSITE)

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
<script src="/Sc/Base.js"></script></head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr><td align="center" height="25" bgcolor="e7e7e7"><b>No.</b></td>
	<td align="center" height="25" bgcolor="e7e7e7"><b>접속아이피</b></td>
	<td align="center" height="25" bgcolor="e7e7e7"><b>접속일자</b></td></tr>

<%	IF dfMemberSql.RsCount = 0 THEN	%>

<tr><td align="center" colspan="4" height="35">회원 로그인내역이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfMemberSql.RsCount - 1
		
		LL_IDX		= dfMemberSql.Rs(i, "LL_IDX")
		LL_IP		= dfMemberSql.Rs(i, "LL_IP")
		LL_REGDATE		= dfMemberSql.Rs(i, "LL_REGDATE")
					
%>
<tr bgcolor="#FFFFFF" height="25"><td width="50" align="center"><%=LL_IDX%></td>
	<td align="center"><%=LL_IP%></td>
	<td width="160" align="center"><%=LL_REGDATE%></td></tr>

	<%  
		Next 
	%>
		
	<% END IF %>

</table><br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

</body>
</html>
