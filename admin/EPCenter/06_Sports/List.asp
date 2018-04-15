<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/06_Sports/_Sql/sportSql.Class.asp"-->
<%
    
    '######### Request Check                    ################	    
    
    pageSize        = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
   
	Call dfsportSql.RetrieveRef_sports(dfDBConn.Conn,  page, pageSize)

	IF dfsportSql.RsCount <> 0 Then
	    nTotalCnt = dfsportSql.RsOne("TC")
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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
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
	    form.action = "delete.asp?page=<%=PAGE%>&RS_Sports=<%=RS_Sports%>";
	    form.submit();
    }
    	
	function SearchPart(r) {
		document.frm1.action = "List.asp?RS_Sports="+r;	
		document.frm1.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임종목 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 게임종목  리스트</font></b></td></tr></table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr bgcolor="e7e7e7"> 
	<td align="center" height="30" width="70"><b>번호</b></td>
	<td align="center" height="30" width="70"><b>선택</b></td>
	<td align="center" width="560"><b>종목</b></td>
	<!-- <td align="center" width="520"><b>리그</b></td>
	<td align="center" width="80"><b>&nbsp;</b></td>--></tr>

<%	IF dfsportSql.RsCount = 0 THEN	%>

<tr><td align="center" colspan="4" height="35">현재 등록된 종목이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfsportSql.RsCount -1

		RL_IDX			= dfsportSql.Rs(i,"RS_IDX")
		RL_SPORTS_LIST	= dfsportSql.Rs(i,"RS_SPORTS")
		RL_IMAGE		= dfsportSql.Rs(i,"RS_ICON")
		IF RL_IMAGE <> "" THEN
		    RL_IMAGE = "<img src='/UpFile/League/"& RL_IMAGE &"' width='20' height='14' style='border:1px solid;'>"
		END IF
		RL_STATUS		= dfsportSql.Rs(i,"RS_STATUS")
%>
	
<tr>
<td align="center"><%=RL_IDX%></td>
<td align="center"><input type="checkbox" name="SelUser" value="<%=RL_Idx%>"></td>
	<td align="center">&nbsp;<%=RL_SPORTS_LIST%></td>
	<% 
		Next
    %>
		
	<% END IF %>

</table><br clear="all">

<%	IF TN > 0 THEN	%>
<table border="0" cellpadding="0" cellspacing="0" width="">
<tr><td><table border="0" cellpadding="0" cellspacing="0" align="center">
		
		<tr><td colspan="3"><img src="../images/sub/blank.gif" border="0" width="1" height="10"></td></tr></table></tr></td></table>
<%	END IF	%>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%">
	<input type="button" value="등록" onclick="window.location='Regist.asp?RS_Sports=<%=RS_Sports%>&page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;"></td>
	<td align="right" width="40%"><input type="reset" value="삭제"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table></form>

</body>
</html>
