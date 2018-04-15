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
<%
    
    '######### Request Check                    ################	    

    
    pageSize      = 15             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	sortColumn = Trim(dfRequest.Value("sortColumn"))
	sortDirection = Trim(dfRequest.Value("sortDirection"))
	IF sortDirection = "" Then
	    sortDirection ="DESC"  
	End IF 
	site        = Trim(dfRequest.Value("JOBSITE"))


	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '######### 총 회원수              ################	
    Dim dfmemberSql1
    Set dfmemberSql1 = new memberSql
	
	Call dfmemberSql1.GetINFO_USERTotalCount( dfDBConn.Conn ) 
	
	TOMEM = dfmemberSql1.RsOne("TOMEM")
    
    
    	
	'######### 회원 리스트를 불러옴                 ################	
            
	Call dfmemberSql.RetrieveINFO_USER_REAL_2lvup(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, site)
    'dfmemberSql.debug
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
		
    sortimg_cash = ""		
    sortimg_point = ""
    sortimg_date = ""
    sortimg_incash = ""
    sortimg_outcash = ""
    sortimg_login = ""
    sorting_cashinout = ""
    
    IF sortDirection ="DESC" Then
        sortDirection1 ="ASC"
        sortimg = "▼"
    Else
        sortDirection1 ="DESC"        
        sortimg = "▲"
    End IF	  
    
    if sortColumn = "IU_CASH" Then sortimg_cash = sortimg
    if sortColumn = "IU_POINT" Then sortimg_point = sortimg    
    if sortColumn = "IU_CHARGE" Then sortimg_incash = sortimg
    if sortColumn = "IU_EXCHANGE" Then sortimg_outcash = sortimg
    if sortColumn = "IU_REGDATE" Then sortimg_date = sortimg
    if sortColumn = "IU_LOGIN_CNT" Then sortimg_login = sortimg
    if sortColumn = "IU_CASHINOUT" Then sorting_cashinout = sortimg

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
		form.action = "Update.asp?page=<%=Page%>&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}
    function go_update1(IU_IDX, st)
    {
        if (!confirm("정말 삭제하시겠습니까?")) return;	
        location.href = "Update.asp?page=<%=Page%>&IU_IDX="+IU_IDX+"&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
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
		form.action = "00_Member_Del.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist3(form)
	{
		var v_cnt = 0;
		var v_data = "";
		if (!confirm("개인정보삭제처리가 되면 다시 복구하실 수 없습니다. 정말 삭제 처리하시겠습니까?")) return;		
		form.action = "00_Member_P_Del.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist4(form)
	{
		var v_cnt = 0;
		var v_data = "";

		if (!confirm("전화번호 및 계좌번호이전처리를 정말 하시겠습니까?")) return;		
		form.action = "00_Member_P_MO.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
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

		window.open(URL, 'MemJoin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=758,height=665');
		}
function changeTrColor(IG_IDX)
{

    if(document.getElementById("tr" + IG_IDX).bgColor == "#b7d1fc" )
    {
        document.getElementById("tr" + IG_IDX).bgColor = "#ffffff" ;
    }
    else
    {
        document.getElementById("tr" + IG_IDX).bgColor = "#b7d1fc" ;    
    }        
}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">2레벨업 대상회원 
	      <% IF REQUEST("sStartDate") <> "" Or REQUEST("sEndDate") <> "" Or REQUEST("Search") <> "" Or REQUEST("Find") <> "" THEN %>
	        [검색 인원 : <%=formatnumber(TN,0)%> 명]
	      <% END IF %></b></td>
</tr>
</table>    
<div style="height:10px;"></div>


<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="List_Real.asp">
  <tr>
    <td>시작일자 :</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  <div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99">
	  </div>
	  <input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input">
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>~
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>종료일자 :
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  <input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input">
	</td>
	<td>
	  <img src="blank.gif" border="0" width="50" height="1">
	</td>

	<td>
	  <select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>닉네임</option>
	    <option value="IU_MOBILE" <%if Search = "IU_MOBILE" then Response.Write "selected"%>>전화번호</option>
		<option value="IU_ID" <%if Search = "IU_ID" then Response.Write "selected"%>>아이디</option>		
		<option value="IU_BANKOWNER" <%if Search = "IU_BANKOWNER" then Response.Write "selected"%>>이름</option>
		<option value="RECOM_ID" <%if Search = "RECOM_ID" then Response.Write "selected"%>>추천인</option>
	  </select>
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  <input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input">
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  <input type="submit" value="검 색" class="input">
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	<td>

	</td>
	<% END IF %>
  </tr>
  </form>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td>
	  <img src="blank.gif" border="0" width="1" height="10">
	</td>
  </tr>
</table>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<col width="15" />
<col width="60" />
<col width="15" />
<col width="70" />
<col width="60" />
<col width="65" />
<col width="65" />
<col width="55" />
<col width="75" />
<col width="80" />
<col width="60" />
<col width="40" />
<col width="90" />
<col width="40" />
<col width="30" />
<col width="20" />
<col width="20" />
  <form name="frmchk" method="post">
  <tr bgcolor="e7e7e7">
    <td align="center"   width="15">
	  <input type="Checkbox" name="chkAll" onclick="AllChk();">
	</td>
	<!--
	<td align="center"  ><b>
	  <%Response.Write "<a href=List_Real.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search5=vip>No</td>"
	  %>
    -->	  	
	<td align="center"  >
	  <b>아이디</b>
	</td>
	<!--
	<td align="center"  >
	  <b>비번</b>
	</td>
	-->
	<td align="center"  >
	  <b>lv</b>
	</td>	
	<td align="center"  >
	  <b>닉네임</b>
	</td>
	<td align="center"  >
	  <b>추천인아이디</b>
	</td>
	<td align="center"  ><b>연락처</b></td>
	<!--
	<td align="center"  ><b>
	  <%
	  Response.Write "<a href=List_Real.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search6=email>이메일</a></b></td>"
	  %>
    -->	  
	<td align="center"  >
	<b>
	  <a href="List_Real.asp?sortColumn=IU_CASH&sortDirection=<%= sortDirection1 %>">배팅머니<%= sortimg_cash %></a>
    </b>
    </td>
	<td align="center"  >
	  <b><a href="List_Real.asp?sortColumn=IU_POINT&sortDirection=<%= sortDirection1 %>">포인트<%= sortimg_point %></a></b>
	</td>	
	<!--  
	<td align="center"  >
	  <b>계좌정보</b>
	</td>
	-->
	<td align="center"  >
        <a href="List_Real.asp?sortColumn=IU_CHARGE&sortDirection=<%= sortDirection1 %>"><b>입금<%= sortimg_incash %></b></a>
	</td>
	<td align="center"  >
       <a href="List_Real.asp?sortColumn=IU_EXCHANGE&sortDirection=<%= sortDirection1 %>"> <b>출금<%= sortimg_outcash %></b></a>
	</td>	
	<td align="center"  >
       <a href="List_Real.asp?sortColumn=IU_CASHINOUT&sortDirection=<%= sortDirection1 %>"><b>정산<%= sortimg_login %></b></a>
	</td>		
	<td align="center"  >
        <a href="List_Real.asp?sortColumn=IU_LOGIN_CNT&sortDirection=<%= sortDirection1 %>"><b>로그인<%= sortimg_login %></b></a>
	</td>		
	<td align="center"  >
	  <b><a href="List_Real.asp?sortColumn=IU_REGDATE&sortDirection=<%= sortDirection1 %>">등록일<%= sortimg_date %></a></b>
	</td>	
	<td align="center"  >
	  <b>사이트</b>
	</td>
	<td align="center"   >
	  <b>상태</b>
	</td>		
	<td align="center"  >
	  <b>쪽지</b>
	</td>	
	<td align="center"  >
	  <b>등업</b>
	</td>	
  </tr>

<%
IF dfMemberSql.RsCount = 0 Then
%>

  <tr>
    <td align="center" colspan="13" height="35">현재 등록된 회원이 없습니다.</td>
  </tr>

<%
ELSE

	FOR i = 0 TO dfMemberSql.RsCount -1
      
		IU_Idx			= dfMemberSql.Rs(I,"IU_IDX")
		IU_ID			= dfMemberSql.Rs(I,"IU_ID")
		IU_PW			= dfMemberSql.Rs(I,"IU_PW")
		IU_NickName		= dfMemberSql.Rs(I,"IU_NICKNAME")
		RECOM_ID		= dfMemberSql.Rs(I,"RECOM_ID")
		IU_Mobile		= dfMemberSql.Rs(I,"IU_MOBILE")
		IU_Email		= dfMemberSql.Rs(I,"IU_EMAIL")
		IU_Cash			= dfMemberSql.Rs(I,"IU_CASH")
		IU_Level		= dfMemberSql.Rs(I,"IU_LEVEL")
		IU_BankName		= dfMemberSql.Rs(I,"IU_BANKNAME")
		IU_BankNum		= dfMemberSql.Rs(I,"IU_BANKNUM")
		IU_BankOwner	= dfMemberSql.Rs(I,"IU_BANKOWNER")
		IU_RegDate		= dfMemberSql.Rs(I,"IU_REGDATE")
		IU_Status		= dfMemberSql.Rs(I,"IU_STATUS")
		IU_SITE			= dfMemberSql.Rs(I,"IU_SITE")
		IU_POINT		= dfMemberSql.Rs(I,"IU_POINT")
		IU_LOGINDATE	= dfMemberSql.Rs(I,"IU_LOGINDATE")
		IU_CHARGE	        = dfMemberSql.Rs(i,"IU_CHARGE")
		IU_EXCHANGE	    = dfMemberSql.Rs(I,"IU_EXCHANGE")
		IU_LOGIN_CNT	    = dfMemberSql.Rs(I,"IU_LOGIN_CNT")		
		LC_IDX_CK       = dfMemberSql.Rs(I,"LC_IDX_CK")
		VIP             = dfMemberSql.Rs(I,"VIP")
		IDUSECK         = dfMemberSql.Rs(I,"IDUSECK")
		IU_CASHINOUT    = dfMemberSql.Rs(I,"IU_CASHINOUT")

		IF IU_Status  = 1 THEN
			IU_Status = "<font color=blue>정상</font>"
		ELSEIF IU_Status = 0 THEN
			IU_Status = "<font color=gray>정지</font>"
		ELSEIF IU_Status = 9 THEN
			IU_Status = "<font color=red>탈퇴</font>"
		END IF	
		
		if i mod 2 = 0 Then
		    trColor = "#FFFFFF"
		Else
		    trColor = "#F0F0F0"
		End IF
%>
<tr bgcolor="<%= trColor %>" id="tr<%= IU_Idx %>">


<td align="center">
<input type="checkbox" name="SelUser" value="<%=IU_Idx%>" onclick="changeTrColor(this.value)">
</td>
	
<%
    IF isNull(VIP) Or Vip = "" Then
%>	
    <td >
<%
	else 
%>
    <td bgcolor="#sbfcgt">         
<%  end if %>		  
        <a href="View.asp?IU_IDX=<%=IU_IDX%>&IU_SITE=<%=IU_SITE%>&PAGE=<%=PAGE%>"><%=iu_id%></a>
	</td>
	
	<td align="center">
	  <%=IU_Level%>
	</td>
	
	<td align="left">
	  <%=IU_NickName%>
	</td>
	<td align="left">
	  <%=RECOM_ID%>
	</td>

	<td align="center">
	  <%=IU_Mobile%>
	</td>
	<!--
	<td>
	  <%=IU_Email%>
	</td>		
	-->
	<td align='right'>
	<%=formatnumber(IU_CASH,0)%>
	</td>
	<td align='right'>
	<%=formatnumber(IU_POINT,0)%>
	</td>	
	<!--
	<td align='right'>
	    <%=IU_BankName%> - <%=IU_BankOwner%> : <%=IU_BankNum%>
	</td>
	-->
	<td align="right">
        <%= formatnumber(IU_CHARGE,0)%>
	</td>
	<td align="right">
        <%= formatnumber(IU_EXCHANGE,0)%>
	</td>
	<td align="right" bgcolor="#FEE5E5">
        <%= formatnumber(IU_CASHINOUT,0)%>
	</td>	
	<td  align="right">
        <%= formatnumber(IU_LOGIN_CNT,0)%>
	</td>
	<td align="center">
	  <%=right(dfStringUtil.GetFullDate(IU_RegDate),14)%>
	</td>		
	<td  align="center">
        <%= IU_SITE%>
	</td>
	<td align="center"><%=IU_Status%></td>	
	<td align="center"> 
	<% IF request.Cookies("AdminLevel") = 1 THEN %> 
	    <input type="button" class="input" value="쪽지" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'"> 
	<% ELSE %>
	    -
	<% END IF %> 
	</td>	
	<td>
	<% IF request.Cookies("AdminLevel") = 1 THEN %> 
	    
	    <input type="button" value="등업" onclick="location.href='levelup_proc.asp?iu_id=<%=IU_ID%>&iu_idx=<%=IU_IDX%>&page=<%=page%>'" class="input">
	    
	<% ELSE %>
    -
	<% END IF %> 	
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
<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="80"><!--<input type="reset" value="회원등록" onclick="javascript:MemJoin('00_Member_Form.asp');" class="input">--></td>
        <td width="*">&nbsp;</td>
        <td align="right" width="40"><input type="reset" value="정상" onclick="javascript:go_update(document.frmchk,1);" class="input"></td>
        <td align="right" width="40"><input type="reset" value="정지" onclick="javascript:go_update(document.frmchk,0);" class="input"></td>
        <td align="right" width="40"><input type="reset" value="탈퇴" onclick="javascript:go_update(document.frmchk,9);" class="input"></td>
        <td align="right" width="40"><input type="reset" value="삭제" onclick="javascript:go_update(document.frmchk,8);" class="input"></td>
	</tr>
</table>
<% END IF %>
	
</form>

</body>
</html>