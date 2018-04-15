<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    

    
    pageSize      = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    	
	'######### 회원 리스트를 불러옴                 ################	
            
	Call dfmemberSql.RetrieveDoubleLogin(dfDBConn.Conn,  page, pageSize)
		
	IF dfmemberSql.RsCount <> 0 Then
	    nTotalCnt = dfmemberSql.RsOne("TC")
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
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 회원관리 - 중복 로그인 </b></td>
</tr>
</table>    
<div style="height:10px;"></div>




<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm1" method="get" action="../01_CP/Login_ListById.asp" target="_blank">
<tr align="right">
    <td>
        중복 IP 의심자 검사 : 
        <select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">		
	    <option value="LL_NICKNAME">닉네임</option>
	    <option value="LL_ID">아이디</option>
    </td>
    <td><img src="blank.gif" border="0" width="5" height="1"></td>
    <td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
    <td><img src="blank.gif" border="0" width="5" height="1"></td>
    <td><input type="submit" value="검 색" class="input"></td>
    <td><img src="blank.gif" border="0" width="5" height="1"></td>
</tr>
</form>
</table>
<div style="height:10px;"></div>	
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<tr bgcolor="e7e7e7">
    <td align="center" width="20">CNT</td>
    <td align="center" width="100">IP</td>
    <td align="center"><b>아이디</b></td>

</tr>

<%
IF dfMemberSql.RsCount <> 0 Then

	FOR i = 0 TO dfMemberSql.RsCount -1
      
		LL_IP			= dfMemberSql.Rs(I,"LL_IP")
		LL_CNT			= dfMemberSql.Rs(I,"LL_CNT")
		LL_SITE			= dfMemberSql.Rs(i,"LL_SITE")
%>
<tr bgcolor="ffffff">
    <td align="center"><%= LL_CNT %></td>
    <td ><%= LL_IP %></td>
    <td >&nbsp;
    <%
        SQL = "SELECT * FROM dbo.LOG_LOGIN"
		SQL = "DELETE dbo.LOG_LOGIN WHERE LL_SITE = 'DEVIL'"
		SET RS = Dbcon.Execute(SQL)

		SQL = "select LL_NICKNAME from dbo.LOG_LOGIN where LL_IP = '"&LL_IP&"' group by LL_NICKNAME"

		SET RS = Dbcon.Execute(SQL)
		
		j = 0 
		IF NOT RS.EOF THEN
		     DO WHILE NOT RS.EOF
		        if j mod 2 = 0  then
		            response.Write "<font color='000000'>"
		        else
		            response.Write "<font color='blue'>"
		        end if
		        
		        response.Write RS("LL_NICKNAME") 
		        response.Write "</font>&nbsp;|&nbsp;"
		        RS.MOVENEXT
		        
		        j = j + 1
		    LOOP
        END IF
    %>
    </td>
</tr>
<%
    Next 
END IF
%>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<br /><br />
<!-- paging End -->

</form>

</body>
</html>