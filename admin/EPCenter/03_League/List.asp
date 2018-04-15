<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/03_League/_Sql/LeagueSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '### 디비 관련 클래스(Command) 호출
    Set Dber = new clsDBHelper 
    
        
    '######### Request Check                    ################	    
    pageSize        = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	Find            = Trim(REQUEST("Find"))
	RL_Sports       = REQUEST("RL_Sports")	
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
   
	Call dfLeagueSql.RetrieveRef_League(dfDBConn.Conn,  page, pageSize, Find, RL_Sports)

	IF dfLeagueSql.RsCount <> 0 Then
	    nTotalCnt = dfLeagueSql.RsOne("TC")
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
<title>리그 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

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
	
	form.action = "delete.asp";
	form.submit();
}
	
	function SearchPart(r) {
		document.frmSearch.action = "List.asp?RS_Sports="+r;	
		document.frmSearch.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<form name="frmSearch" method="get">
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td width="100" bgcolor="e7e7e7"><b>* 종목구분</b></td>
	<td width="200">
	<select name="RL_Sports" onchange="SearchPart(this.value);" class="box03">
	<option value="" <%If RS_Sports = "" then Response.write "Selected"%>>==전체보기==</option>
	<%	
	
        SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"        
        Set Rs = Dber.ExecSQLReturnRS(SQLR,nothing,nothing) 
    		
		RSCount = RS.RecordCount

		FOR a =1 TO RSCount
		
			RLS = RS(0) 
	%>
	<option value="<%=RLS%>" <% IF REQUEST("RL_Sports") = RLS THEN %>SELECTED<% END IF %>><%=RLS%></option>
	<%	
	    RS.movenext
		NEXT
		
		RS.Close
		Set RS=Nothing	
	%>
		
		</select></td>
		<td width="400"><font color="#000000"><strong>리그명 : </strong></font>
		<input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input">
		<input type="submit" value="검 색">
		</td>
		</tr></table>
		</form>
		<br>
<form name="frm1" method="get">
<input type="hidden" name="page" value="<%= page %>" />
<input type="hidden" name="RS_Sports" value="<%= RS_Sports %>" />
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임리그 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 게임리그  리스트</font></b></td></tr></table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr bgcolor="e7e7e7"> 
	<td align="center" height="30" width="40"><b>선택</b></td>
	<td align="center" width="60"><b>종목</b></td>
	<td align="center" width="50"><b>이미지</b></td>
	<td align="center" width="235"><b>리그명(7m)</b></td>
	<td align="center" width="235"><b>리그명(노출)</b></td>
</tr>
<%	

    IF dfLeagueSql.RsCount = 0 THEN	
%>

<tr><td align="center" colspan="5" height="35">현재 등록된 리그가 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfLeagueSql.RsCount -1

		RL_IDX			= dfLeagueSql.Rs(i,"RL_IDX")
		RL_SPORTS_LIST	= dfLeagueSql.Rs(i,"RL_SPORTS")
		RL_LEAGUE		= dfLeagueSql.Rs(i,"RL_LEAGUE")
		RL_IMAGE		= dfLeagueSql.Rs(i,"RL_IMAGE")
		IF RL_IMAGE <> "" THEN
		    RL_IMAGE = "<img src='"& dfStringUtil.GetLeagueImage(RL_IMAGE) &"' width='20' height='14' style='border:1px solid;'>"
		END IF
		RL_STATUS		= dfLeagueSql.Rs(i,"RL_STATUS")
		RL_KR_LEAGUE	= dfLeagueSql.Rs(i,"RL_KR_LEAGUE")
%>
<tr><td align="center"><input type="checkbox" name="SelUser" value="<%=RL_Idx%>"></td>
	<td align="center">&nbsp;<%=RL_SPORTS_LIST%></td>
	<td align="center">&nbsp;<%=RL_Image%>&nbsp;</td>
	<td>&nbsp;<a href="View.asp?RL_Idx=<%=RL_Idx%>&Find=<%= Find %>&RL_Sports=<%= RL_Sports %>&page=<%=PAGE%>"><%=RL_League%></a></td>
	<td>&nbsp;<a href="View.asp?RL_Idx=<%=RL_Idx%>&Find=<%= Find %>&RL_Sports=<%= RL_Sports %>&page=<%=PAGE%>"><%=RL_KR_League%></a></td>
	</tr>
<%  
	Next 
%>
		
	<% END IF %>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%">
	<input type="button" value="등록" onclick="window.location='Regist.asp?RS_Sports=<%=RS_Sports%>&Find=<%= Find %>&RL_Sports=<%= RL_Sports %>&page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;"></td>
	<td align="right" width="40%"><input type="reset" value="삭제"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table>
</form>
</body>
</html>
<%
	Dber.Dispose
	Set Dber = Nothing 		
%>