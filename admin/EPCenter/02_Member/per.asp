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
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search2     = Trim(dfRequest.Value("Search2"))
	Search4     = Trim(dfRequest.Value("Search4"))
	Search5     = Trim(dfRequest.Value("Search5"))
	Search6     = Trim(dfRequest.Value("Search6"))
	Search7     = Trim(dfRequest.Value("Search7"))
	Search      = Trim(dfRequest.Value("Search"))
	Find        = Trim(dfRequest.Value("Find"))
	site        = request.Cookies("JOBSITE")'Trim(dfRequest.Value("JOBSITE"))
	
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
    	
	'######### 적중률 리스트를 불러옴                 ################
   
	Call dfmemberSql.RetrieveInfo_HitByUser(dfDBConn.Conn, page, pageSize, Search, Find, search2, search4, search5, search6, search7, sStartDate, sEndDate, site)

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
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

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
		form.action = "Update.asp?page=<%=PAGE%>&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist2(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("완전삭제 처리할 회원을 선택해 주세요."); 
			return;
		} 
		
		if (!confirm("완전삭제처리가 되면 다시 복구하실 수 없습니다. 정말 삭제 처리하시겠습니까?")) return;		
		form.action = "00_Member_Del.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist3(form)
	{
		var v_cnt = 0;
		var v_data = "";

		if (!confirm("개인정보삭제처리가 되면 다시 복구하실 수 없습니다. 정말 삭제 처리하시겠습니까?")) return;		
		form.action = "00_Member_P_Del.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist4(form)
	{
		var v_cnt = 0;
		var v_data = "";

		if (!confirm("전화번호이전처리를 정말 하시겠습니까?")) return;		
		form.action = "00_Member_P_MO.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function MM_openBrWindow(theURL,winName,features) { 
	  window.open(theURL,winName,features);
	}
	
	function SearchFrm() {
		document.frmchk.submit();
	}
	
	// 모든 체크박스 on/off
	function AllChk() {
		var chkAll = document.frmchk.chkAll;
		var cbox = document.frmchk.SelUser;
		if (cbox.length) {
			for(var i=0; i<cbox.length; i++) {
				cbox[i].checked = chkAll.checked;
			}
		}
		else {
			cbox.checked = chkAll.checked;
		}
	}

	function MemJoin(URL) {
		//alert("플러스윈 오픈끝나고 작업하겠음!!");
		window.open(URL, 'MemJoin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=758,height=465');
		}

</SCRIPT>

<!--마우스 우클릭 막기-->
<script src="/Sc/Base.js"></script>

</head>

<body topmargin="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="per.asp">
<tr align="right">
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="IU_ID" <%if Search = "IU_ID" then Response.Write "selected"%>>아이디</option>
		<option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>닉네임</option>
	</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	</tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frmchk" method="post">
<tr>
	<td align="center" height="30" bgcolor="e7e7e7"><b>No.</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>아이디</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>닉네임</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>입금액
	</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>출금액
	</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>보유머니
	</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>TOTAL
	</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>수익율
	</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>사이트</b></td>
	</tr>

<%
    IF dfMemberSql.RsCount = 0 Then
%>

<tr><td align="center" colspan="7" height="35">현재 등록된 회원이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfmemberSql.RsCount -1
		
	    IU_IDX			= dfmemberSql.Rs(i, "IU_IDX")
		IU_ID			= dfmemberSql.Rs(i, "IU_ID")
		IU_SITE			= dfmemberSql.Rs(i, "IU_SITE")
		IU_NICKNAME		= dfmemberSql.Rs(i, "IU_NICKNAME")
		IU_CASH			= dfmemberSql.Rs(i, "IU_CASH")
		CNT1			= dfmemberSql.Rs(i, "CNT1")
		CNT2			= dfmemberSql.Rs(i, "CNT2")
		TOTAL			= dfmemberSql.Rs(i, "TOTAL")
		PER				= dfmemberSql.Rs(i, "PER")
		TC				= dfmemberSql.Rs(i, "TC")
		ROWNUMBER       = dfmemberSql.Rs(i, "ROWNUMBER")

		NN = TC -ROWNUMBER + 1

%>
<tr bgcolor="#FFFFFF" height="25">
	<td align="center"><%=NN %></td>
	<td>&nbsp;<%=IU_ID%></td>
	<td align="center"><%=IU_NICKNAME%></td>
	<td align="center"><%=FORMATNUMBER(CNT1,0)%>원</td>
	<td align="center"><%=FORMATNUMBER(CNT2,0)%>원</td>
	<td align="center"><%=FORMATNUMBER(IU_CASH,0)%>원</td>
	<td align="center"><%=FORMATNUMBER(TOTAL,0)%>원</td>
	<td align="center">
	<%
    
    IF PER = "" Then
    %>	
            <%="0.00"%>
    <%
	    else 
    %>
            <%=formatnumber(PER,2)%>
    <% 
        end if
    %>%</td>
	<%
	If IU_SITE = "Life" Then
		response.write "<td align='center' bgcolor='#ffcccc'>"
	elseIf IU_SITE = "Media" Then
		response.write "<td align='center' bgcolor='#648ba6'>"
	Else 
		response.write "<td align='center'>"
	End If 
	%>
	<%=IU_SITE%></td>
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
<!-- paging End -->

</form>

</body>
</html>
