<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%

    '######### Request Check                    ################	    
    
    pageSize      = 30             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
    
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	
    '######### 회원 리스트를 불러옴                 ################	
   
	Call dfCpSql.RetrieveBLOCK_IPByAdmin(dfDBConn.Conn,  page, pageSize)

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
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> IP 블럭 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<script type="text/javascript">
function checkForm(form)
{
    if(form.ipNum1.value == "")
    {
        alert("IP를 입력하세요");
        form.ipNum1.focus();
        return false;
    }
    if(form.ipNum2.value == "")
    {
        alert("IP를 입력하세요");
        form.ipNum2.focus();
        return false;
    }
    if(form.ipNum3.value == "")
    {
        alert("IP를 입력하세요");
        form.ipNum3.focus();
        return false;
    }
    if(form.ipNum4.value == "")
    {
        alert("IP를 입력하세요");
        form.ipNum4.focus();
        return false;
    }         
}
function delIP(SEQ)
{
    location.href = "Block_IP_PROC.asp?mode=del&SEQ=" + SEQ
}
</script>
<form name="ipForm" action="Block_IP_PROC.asp" onsubmit="return checkForm(this);">
<input type="hidden" name="mode" value="add" />
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr>
    <td align="center" height="30" bgcolor="e7e7e7" width="10%"><b>IP</b></td>
    <td bgcolor="#FFFFFF">
        <input type="text" name="ipNum1" class="input" size="4" maxlength="4" />.
        <input type="text" name="ipNum2" class="input" size="4" maxlength="4" />.
        <input type="text" name="ipNum3" class="input" size="4" maxlength="4" />.
        <input type="text" name="ipNum4" class="input" size="4" maxlength="4" /> 
        ~ 
        <input type="text" name="ipNum5" class="input"  size="4" maxlength="4"/>
        <br />마지막 칸은 pc등 연결된 아이피 입력시에만 사용하세요
    </td>
</tr>
</table>	
<table width="100%">
<tr>
    <td align="right">
        <input type="submit" value="  등록  " class="input" />
    </td>
</tr>
</table>
</form>
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<tr>
    <td align="center"  bgcolor="e7e7e7" width=""><b>IP</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>등록일</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>해제</b></td>
</tr>

<%
    IF dfCpSql.RsCount <> 0 THEN	
        FOR i = 0 TO dfCpSql.RsCount -1
            SEQ			= dfCpSql.Rs(i,"SEQ")
		    BLOCKIP		= dfCpSql.Rs(i,"BLOCKIP")
		    BLOCKDATE	= dfCpSql.Rs(i,"BLOCKDATE")
%>
<tr bgcolor="#FFFFFF">
    <td align="center"><%= BLOCKIP %></td>
    <td align="center"><%= dfStringUtil.GetFullDate(BLOCKDATE) %></td>
    <td align="center">
    <input type="button" class="input" value="해제" onclick="delIP('<%= SEQ %>')" /> </td>
</tr>    
<%        
        Next
    End IF        		    
%>
</table>
<!-- paging Start -->
<br />
<%= objPager.Render %>
<!-- paging End -->

<br /><br /><br /><br />
</body>
</html>
