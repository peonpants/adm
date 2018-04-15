<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
    '######### request 값                    ################	
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20  
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 로또 내역을 볼러옴                 ################	
   
	Call dfeventSql.RetrieveINFO_LOTTO(dfDBConn.Conn,  page, pageSize)
    
	IF dfeventSql.RsCount <> 0 Then
	    nTotalCnt = dfeventSql.RsOne("TC")
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
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 로또 이벤트</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">

<tr><td align="center" height="30" bgcolor="e7e7e7" width="60"><b>활성</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="250"><b>제목</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="150"><b>기본당첨금액</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="150"><b>사용자배팅금액</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="150"><b>기본배팅금액</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>일정</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>등록일시</b></td>
</tr>

<%	IF dfeventSql.RsCount = 0 THEN	%>

<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="8" height="35">현재 등록된 로또 이벤트가 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfeventSql.RsCount -1 

		IL_GUID					= dfeventSql.Rs(i,"IL_GUID")
		IL_NUM					= Int(dfeventSql.Rs(i,"IL_NUM"))
		IL_TITLE				= dfeventSql.Rs(i,"IL_TITLE")
		IL_DEFAULT_PRIZE_MONEY	= CDbl(dfeventSql.Rs(i,"IL_DEFAULT_PRIZE_MONEY"))
		IL_ACCRUE_BET_MONEY		= CDbl(dfeventSql.Rs(i,"IL_ACCRUE_BET_MONEY"))
		IL_BASIC_BET_MONEY		= CDbl(dfeventSql.Rs(i,"IL_BASIC_BET_MONEY"))
		IL_ENABLE				= dfeventSql.Rs(i,"IL_ENABLE")
		IL_DATE					= dfeventSql.Rs(i,"IL_DATE")
		IL_SITE					= dfeventSql.Rs(i,"IL_SITE")
		IL_BET_COUNT			= Int(dfeventSql.Rs(i,"IL_BET_COUNT"))
		IL_REGDATE				= dfeventSql.Rs(i,"IL_REGDATE")
%>

<tr bgcolor="#FFFFFF"><td align="center"><%IF IL_ENABLE = "0" Then%>비활성<%ElseIf IL_ENABLE = "1" Then%>활성<%End If%></td>
	<td><a href="Edit.asp?IL_GUID=<%=IL_GUID%>&page=<%=page%>"><%=IL_TITLE%></a></td>
	<td align="right"><%=IL_DEFAULT_PRIZE_MONEY%></td>
	<td align="right"><%=IL_ACCRUE_BET_MONEY%></td>
	<td align="right"><%=IL_BASIC_BET_MONEY%></td>
	<td align="center"><%=IL_DATE%></td>
	<td align="center"><%=IL_REGDATE%></td>
</tr>

	<% 
		Next 
	END IF 
	%>

</table>

<table>
<tr>
<td><input type="button" value=" 새 로또 이벤트 " onclick="javascript:location.href='Regist.asp';" style="border: 1 solid; background-color: #C5BEBD; cursor:hand"></td>
</tr>
</table>

<br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>