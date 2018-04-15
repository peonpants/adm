<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/seller/02_Member/_Sql/memberSql.Class.asp"-->
<%
 	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	IU_ID = dfRequest.Value("IU_ID")
	site        = SESSION("rJOBSITE")
    
    	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfmemberSql.RetrieveINFO_USERByRecomID1(dfDBConn.Conn, IU_ID)

	    
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script src="/Sc/Base.js"></script>
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

</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  회원관리 ▶ 추천 회원 리스트 > 추천인 회원수 : <%= IU_ID %>님을 추천한 회원수 : <%= dfMemberSql.RsCount %> 명 </b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">

  <tr>
	
	  
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>아이디<br>(로그인유무)</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>비번</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>닉네임</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>연락처</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>
	  <%
	  Response.Write "<a href=List.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search6=email>이메일</a></b></td>"
	  %>
	<td align="center" height="30" bgcolor="e7e7e7"><b>
	  <%
	  Response.Write "<a href=List.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search4=money>캐쉬</a></b></td>"
	  %>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>포인트</b>
	</td>	  
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>계좌정보</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>등록일</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7" width="40">
	  <b>상태</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>사이트</b>
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
		CNT	= dfMemberSql.Rs(I,"CNT")
		
		LC_IDX_CK       = dfMemberSql.Rs(I,"LC_IDX_CK")
		VIP             = dfMemberSql.Rs(I,"VIP")
		IDUSECK         = dfMemberSql.Rs(I,"IDUSECK")

		IF IU_Status  = 1 THEN
			IU_Status = "<font color=blue>정상</font>"
		ELSEIF IU_Status = 0 THEN
			IU_Status = "<font color=gray>정지</font>"
		ELSEIF IU_Status = 9 THEN
			IU_Status = "<font color=red>탈퇴</font>"
		END IF	%>
<tr bgcolor="#FFFFFF" height="25">	
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
	  <%=IU_PW%>
	</td>
	<td align="center">
	  <%=IU_NickName%>
	</td>
	<td align="center">
	  <%=IU_Mobile%>
	</td>
	<td>
	  <%=IU_Email%>
	</td>
	<td align='right'>
	<%=formatnumber(IU_Cash,0)%>&nbsp;원&nbsp;
	</td>
	<td align='right'>
	<%=formatnumber(IU_POINT,0)%>&nbsp;P&nbsp;
	</td>	
	<td align='right'>
	    <%=IU_BankName%> - <%=IU_BankOwner%><br /> <%=IU_BankNum%>
	</td>
	<td align="center">
	  <%=dfStringUtil.GetFullDate(IU_RegDate)%>
	</td>
	
	<td align="center"><%=IU_Status%></td>

	<td>&nbsp;
        <%= IU_SITE%>
	</td>
	</tr>
	    

<%
    Next 
END IF
%>

</table>


</body>
</html>