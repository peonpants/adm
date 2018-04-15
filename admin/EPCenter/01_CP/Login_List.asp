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
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	sortColumn = ""
	sortDirection = ""
	site        = request.Cookies("JOBSITE")'Trim(dfRequest.Value("JOBSITE"))
	
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '######### 총 회원수              ################	
    Dim dfCpSql1
    Set dfCpSql1 = new CpSql
	
	Call dfCpSql1.GetLOG_LOGINTotalCount( dfDBConn.Conn ) 
	
	TOMEM = dfCpSql1.RsOne("TOMEM")
    
    	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfCpSql.RetrieveLOG_LOGIN(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, site)

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
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<!--##########################################################################################	-->
<!--# Whois 검색																												-->
<!--##########################################################################################	-->
<script type="text/javascript"> 
function whoisSearch(ip) 
{

		document.forms["whois_search_form"].ip.value = ip
 
		document.forms["whois_search_form"].target	= "_blank";
		document.forms["whois_search_form"].method	= "get";
		document.forms["whois_search_form"].action	= "http://www.findip.kr/where.php?ip=" + ip;
		document.forms["whois_search_form"].submit();
}
 
</script>
<SCRIPT LANGUAGE="JavaScript">
	function go_update(form,st)
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
			alert("변경할 정보를 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("정말 변경하시겠습니까?")) return;		
		form.action = "Update.asp?page=<%=PAGE%>&IU_Status="+st;
		form.submit();
	}
	
	function MM_openBrWindow(theURL,winName,features) { 
	  window.open(theURL,winName,features);
	}
	
	function SearchFrm() {
		document.frmchk.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<form name="whois_search_form">
<input name="ip" type="hidden" />
</form>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ▶ 총로그인수  
	        [<%=nTotalCnt%> 명] <% IF REQUEST("sStartDate") <> "" Or REQUEST("sEndDate") <> "" Or REQUEST("Search") <> "" Or REQUEST("Find") <> "" THEN %>[검색 인원 : <%=formatnumber(nTotalCnt,0)%> 명]<% END IF %></b></td>
</tr>
</table>    
<div style="height:10px;"></div>


<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Login_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%= sStartDate %>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%= sEndDate %>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="LL_ID" <%if Search = "LL_ID" then Response.Write "selected"%>>아이디</option>
		<option value="LL_NICKNAME" <%if Search = "LL_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="LL_IP" <%if Request.QueryString("Search") = "LL_IP" then Response.Write "selected"%>>아이피</option>
		<option value="LL_SITE" <%if Request.QueryString("Search") = "LL_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색" class="input"></td></tr></form></table>
	<br />
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm1" method="get" action="Login_ListById.asp" target="_blank">
<tr align="right">
	<td>
	    중복 IP 의심자 검사 : 
	    <select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="LL_ID">아이디</option>
		<option value="LL_NICKNAME">닉네임</option>
	</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	</tr></form></table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<form name="frmchk" method="post">
<tr><td align="center"  bgcolor="e7e7e7" width=""><b>No.</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>아이디</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>닉네임</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>사이트</b></td>
	<td align="center"  bgcolor="e7e7e7" width=""><b>IP</b></td>
	<td align="center"  bgcolor="e7e7e7"><b>Login Time</b></td>
	<td align="center"  bgcolor="e7e7e7"><b>Login URL</b></td>
	<td align="center"  bgcolor="e7e7e7">ip조회</td>
	<td align="center"  bgcolor="e7e7e7">회원정보</td>
	</tr>
	

<%
IF dfCpSql.RsCount = 0 THEN	
%>

<tr bgcolor="#FFFFFF"><td align="center" colspan="9" height="35">로그인 정보가 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfCpSql.RsCount -1


		LL_IDX			= dfCpSql.Rs(i,"LL_IDX")
		LL_ID			= dfCpSql.Rs(i,"LL_ID")
		LL_NICKNAME		= dfCpSql.Rs(i,"LL_NICKNAME")
		LL_IP			= dfCpSql.Rs(i,"LL_IP")
		LL_REGDATE		= dfCpSql.Rs(i,"LL_REGDATE")
		LL_SITE			= dfCpSql.Rs(i,"LL_SITE")
		LL_DOMAIN		= dfCpSql.Rs(i,"LL_DOMAIN")
		BLOCKFLAG       = dfCpSql.Rs(i,"BLOCKFLAG")
	    VIP             = dfCpSql.Rs(i,"VIP")

		IF isNull(BLOCKFLAG) OR BLOCKFLAG ="" THEN
			BLOCKFLAG = "NO"
		ELSE
			BLOCKFLAG = "YES"
		END IF	

%>

<tr  bgcolor="#FFFFFF" ><td width="" align="center"><%= LL_IDX %></td>
<%
	IF isNULL(VIP) Then
%>
	<td width=""  bgcolor="#sbfcgt">&nbsp;<a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_ID&Find=<%=LL_ID%>"><%=LL_ID%>
<%
	else 
%>
	<td width="">&nbsp;<a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_ID&Find=<%=LL_ID%>"><%=LL_ID%>
<%
	end if 
%>
</a></td>
	<td width="" align="center"><a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_NICKNAME&Find=<%=LL_NickName%>"><%=LL_NickName%></a></td>
	<%
		response.write "<td align='center'>"
	%>
	<a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_SITE&Find=<%=LL_SITE%>"><%=LL_SITE%></a></td>
	<td width="" align="center">
	<% IF BLOCKFLAG = "NO" THEN %>
	<table border="0" cellpadding="0" cellspacing="0">
	<tr><td width="100"><a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_IP&Find=<%=LL_IP%>"><%=LL_IP%></a></td>
		<td><img src="blank.gif" border="0" width="10" height="1"></td>
		<td><a href="Login_Proc.asp?BIP=<%=LL_IP%>&page=<%=PAGE%>&FLAG=NO&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=<%=Search%>&Find=<%=Find%>">[IP차단]</a></td></tr></table>
	<% ELSEIF BLOCKFLAG = "YES" THEN %>
	<table border="0" cellpadding="0" cellspacing="0">
	    <tr><td width="100"><a href="/EPCenter/01_CP/Login_List.asp?sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=LL_IP&Find=<%=LL_IP%>"><FONT COLOR="RED"><B><%=LL_IP%></B></FONT></a></td>
		    <td><img src="blank.gif" border="0" width="10" height="1"></td>
		    <% IF request.Cookies("AdminLevel")  = 1 THEN %><td><a href="Login_Proc.asp?BIP=<%=LL_IP%>&page=<%=PAGE%>&FLAG=YES&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=<%=Search%>&Find=<%=Find%>"><FONT COLOR="RED"><B>[IP허용]</B></FONT></a></td><% END IF %>
	    </tr>
	</table>
	<% END IF %></td>
	<td align="center"><%=LL_RegDate%></td>
	<td align="center"><%=LL_DOMAIN%></td>
    <td align="center">
    <input type="button" value="조회" class="input" onclick="whoisSearch('<%=LL_IP%>')" />
    </td>	
    <td align="center">
    <input type="button" value="회원정보" class="input" onclick="location.href='/EPcenter/02_member/list.asp?Search=IU_ID&Find=<%= LL_ID %>';" />
    </td>
	</tr>
<%  
	Next 
END IF 
%>

</table><br clear="all">

<!-- paging Start -->

<%= objPager.Render %>
<!-- paging End -->
<br /><br /><br /><br />
</body>
</html>
