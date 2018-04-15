<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/01_CP/_Sql/cpSql.Class.asp"-->
<%

    pageSize        = 50             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate      = Trim(dfRequest.Value("sStartDate"))
	sEndDate        = Trim(dfRequest.Value("sEndDate"))
	Search          = Trim(dfRequest.Value("Search"))
	Find            = Trim(dfRequest.Value("Find"))	
	
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	

    
    Call dfCpSql.RetrieveLOG_ADMIN_CASHINOU(dfDBConn.Conn, page, pageSize,  "LAC_SITE", JOBSITE, sStartDate, sEndDate)
    
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
	
	'response.Write page
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
<link rel="stylesheet" type="text/css" href="/Seller/Css/style.css">
</head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b style="color:#ffffff"> 총판 캐시 적립 기록</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table cellpadding="5" cellspacing="1" bgcolor="#AAAAAA" width="100%">
<tr height="25" bgcolor="#EEEEEE">
    <td>No</td>
    <td>총판싸이트</td>
    <td>금액</td>
    <td>구분</td>
    <td>내용</td>
    <td>날짜</td>
</tr>
<%
    IF dfCpSql.RsCount <> 0 Then
        For i =0 to dfCpSql.RsCount -1            
%>
<tr height="25" bgcolor="#FFFFFF">
    <td>
        <%= dfCpSql.Rs(i,"LAC_IDX") %>
    </td>
    <td>
        <%= dfCpSql.Rs(i,"LAC_SITE") %>
    </td>
    <td>
        <%= formatnumber(dfCpSql.Rs(i,"LAC_CASH"),0) %>원
    </td>
    <td>
        <%
        IF dfCpSql.Rs(i,"LAC_TYPE") = 1 Then
            response.Write "적립"
        ElseIF dfCpSql.Rs(i,"LAC_TYPE") = 2 Then
            response.Write "차감"
        End IF
        %>
    </td>  
    <td>
        <%= dfCpSql.Rs(i,"LAC_CONTENT") %>
    </td>      
    <td>
        <%= dfCpSql.Rs(i,"LAC_REGDATE") %>
    </td>
</tr>
<% 
    Next
End IF 
%>
</table>
<br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
</body>
</html>

