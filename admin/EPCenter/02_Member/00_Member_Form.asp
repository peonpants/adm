<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<HTML>
<HEAD><TITLE>대한민국 최고의 배팅 사이트</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">
<LINK href="/_Common/inc/css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="/js/func.js" type=text/javascript></SCRIPT>
<SCRIPT src="/js/calendar.js" type=text/javascript></SCRIPT>
<META content="MSHTML 6.00.6000.16757" name=GENERATOR>
<script language="JavaScript" src="/Sc/Function.js"></script>
<script>
	function FrmChk1() {
		var frm = document.frm1;
		
		// id중복체크
		if (frm.ChkID.value != 1) {
			alert(" 아이디 중복체크를 해주세요.");
			frm.IU_ID.focus();
			return false;
		}
				
		// 아이디 체크 [오픈 체크시에도 씀] 
		if ((frm.IU_ID.value.length == 0) || (frm.IU_ID.value.length < 4) || (frm.IU_ID.value.length >12))	{
			alert(" 사용하실 아이디를 정확히 넣어주세요.\n아이디는 4~12까지만 입력이 가능합니다.");
			frm.IU_ID.focus();
			return false;
		}
		else if ( EnNumCheck(frm.IU_ID.value) == false)	{
			alert(" 아이디는 공백없이 영어와 숫자로만 입력이 가능합니다.");
			frm.IU_ID.focus();
			return false;
		}
		
		// 비밀번호 체크
		if ((frm.IU_PW.value.length == 0) || (frm.IU_PW.value.length < 4) || (frm.IU_PW.value.length > 10) )	{
			alert(" 사용하실 비밀번호를 정확히 넣어주세요.\n비밀번호는 4~10자 까지만 입력이 가능합니다.");
			frm.IU_PW.select();
			frm.IU_PW.focus();
			return false;
		}
		
		if (EnNumCheck(frm.IU_PW.value) == false)	{
			alert(" 비밀번호는 공백없이 영어와 숫자로만 입력이 가능합니다.");
			frm.IU_PW.focus();
			return false;
		}
		
		// 닉네임체크
		if ((frm.IU_NickName.value.length == 0) || (frm.IU_NickName.value.length < 3) || (frm.IU_NickName.value.length >10))	{
			alert(" 닉네임을 정확히 넣어주세요.\n닉네임은 3~10까지만 입력이 가능합니다.");
			frm.IU_NickName.focus();
			return false;
		}

		// 닉네임중복체크
		if (frm.ChkNN.value != 1) {
			alert(" 아이디 중복체크를 해주세요.");
			frm.IU_NickName.focus();
			return false;
		}
		
		if (frm.IU_BankName.value == "" )	{
			alert("은행명을 정확하게 입력해주세요.");
			frm.IU_BankName.focus();
			return false;
		}
		
		if ((frm.IU_BankNum.value == "" ) || (frm.IU_BankNum.value.length < 10))	{
			alert("계좌번호를 정확하게 입력해주세요.");
			frm.IU_BankNum.focus();
			return false;
		}
		
		if (NumDash(frm.IU_BankNum.value) == false)		{
			alert("계좌번호는 숫자와 '-' 만을 사용해서 입력해주세요.");
			frm.IU_BankNum.value = "";
			frm.IU_BankNum.focus();
			return false;
		}
		
		if ((frm.IU_BankOwner.value == "" ) || (frm.IU_BankOwner.value.length < 2))	{
			alert("예금주를  정확하게 입력해주세요.");
			frm.IU_BankOwner.focus();
			return false;
		}
		
		// Email 형식체크
		if (frm.Email1.value == "" ) {
			alert("이메일을 정확하게 입력해주세요.");
			frm.Email1.focus();
			return false;
		}
		
		if (frm.Email3.value == "" ) {
			alert("이메일을 정확하게 입력해주세요.");
			frm.Email2.focus();
			return false;
		}
		
		// 핸드폰 체크
		if (IsPhoneChek(frm.IU_Mobile2.value) == false) {
			alert(" 핸드폰번호를 정확히 입력해주세요.");
			frm.IU_Mobile2.value="";
			frm.IU_Mobile2.focus();
			return false;
		}
		if (IsPhoneChek(frm.IU_Mobile3.value) == false) {
			alert("핸드폰번호를 정확히 입력해주세요.");
			frm.IU_Mobile3.value="";
			frm.IU_Mobile3.focus();
			return false;
		}
		
		frm.action = "00_Member_Proc.asp";
		return true;
	}
	
	function idDblChk() {
		var frm = document.frm1;
		
		if (frm.IU_ID.value == "" ) {
			alert("중복체크하실 아이디를 적어주세요.");
			frm.IU_ID.focus();
			return false;
		}
		else
		{
			top.hidden_page.location.href="00_Member_Check.asp?IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";
		}
	}

	function nnDblChk() {
		var frm = document.frm1;
		
		if (frm.IU_NickName.value == "" ) {
			alert("중복체크하실 닉네임을 적어주세요.");
			frm.IU_NickName.focus();
			return false;
		}
		else
		{
			top.hidden_page.location.href="00_Member_Check.asp?IU_NickName="+frm.IU_NickName.value+"&IU_SITE="+frm.JoinSite.value+"";
		}
	}

	function clickemail() {
		var frm = document.frm1;
		
		frm1.Email3.readOnly = true;
		frm1.Email3.value = frm1.Email2[frm1.Email2.selectedIndex].value;
		if (frm1.Email2[0].selected)
		{
			frm1.Email3.readOnly = false;
		}
	}
	
</script></HEAD>

<BODY bgColor=#ffffff leftMargin=0 topMargin=0>

<table width="760" border="0" cellspacing="0" cellpadding="0">
<form name="frm1" method="post" onsubmit="return FrmChk1();">
<input type="hidden" name="EMODE" value="MEMADD">
<input type="hidden" name="ChkID" value="0">
<input type="hidden" name="ChkNN" value="0">
  <tr>
    <td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
	  <table width="746" border=0 cellSpacing=1>
	    <tr>
		  <td height="25" align=left bgColor=#B9B9B9 style="PADDING-RIGHT: 20px; PADDING-LEFT: 20px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" class="text11">
		    <STRONG class="text12"><FONT COLOR="#FFFFFF">◎ 회 원 가 입</FONT></STRONG>
	      </td>
		</tr>
	    <tr>
		  <td align=left style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
		    <table width="100%" border="2" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1">
		      <tr>
			    <td height="25" align=center bgColor=#ffffff style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
			      <table width="81%" border="0" cellspacing="2" cellpadding="5">
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>사 이 트 명</strong>
				      </td>
				      <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				        <select name="JoinSite">
				         
						<%'사이트명을 DB에서 불러와서 개수에 따라 셀렉트로 넣음 
						    'PML 은 DB에서 불러온 레코드 
							'PMLC 는 DB에서 불러온 레코드의 갯수
						   Set PML = Server.CreateObject("ADODB.Recordset")
					         PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

					         PMLC = PML.RecordCount
				   
					         IF PMLC > 0 THEN

					           FOR PM = 1 TO PMLC
				   
					             IF PML.EOF THEN
						         
								 EXIT FOR
					             END IF
                          'SITE01은 첫번째 레코드
					      SITE01=PML(0) 
					    %>
				        <option value="<%=SITE01%>"><%=SITE01%></option>
				        <!--레코드의 갯수만큼 셀렉트로 뿌려준다.-->
						<%	PML.Movenext
					        Next
					       END IF %>
				      </select>
				      <!--<input type="radio" name="JoinSite" value="Eproto" Checked> 이프로토 <input type="radio" name="JoinSite" value="Pluswin"> 플러스윈-->
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>회원 아이디</strong>
				      </td>
				      <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
					    <input name="IU_ID" style="WIDTH: 150px; HEIGHT: 20px" maxLength="12" class="box2">&nbsp;<IMG onclick="idDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;영문,숫자 4~12자 (특수문자불가)
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>비밀번호</strong>
				      </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input type="password" class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_PW">
				      </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>비밀번호확인</strong>
					  </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input type="password" class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_PW1">
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>닉 네 임</strong>
					  </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_NickName">&nbsp;
						<IMG onclick="nnDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;&nbsp;(한글,영문,숫자조합 3~10자이내)
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>휴대폰번호</strong>
					</td>
				    <td width="76%" bgcolor="#EAEAEA">
				      <select name="IU_Mobile1" style="width:50px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
				        <OPTION>010</OPTION> 
				        <OPTION>011</OPTION>
				        <OPTION>016</OPTION> 
				        <OPTION>017</OPTION>
				        <OPTION>018</OPTION> 
				        <OPTION>019</OPTION>
					  </SELECT> - 
				        <input class=box2 style="WIDTH: 50px; HEIGHT: 20px" maxLength="4" name="IU_Mobile2" onkeypress="keyCheck();"> - 
				<input class=box2 style="WIDTH: 50px; HEIGHT: 20px" maxLength="4" name="IU_Mobile3" onkeypress="keyCheck();"></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>이 메 일</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input name="Email1" type="text" size="15" maxlength="15" width="150px" class="box2"> @ 
				<SELECT size=1 name="Email2" class="SELECT" onChange="javascript:clickemail();">	
				<option value="" selected>직접입력</OPTION>
				<OPTION value='yahoo.co.kr'>야후</OPTION>
				<OPTION value='naver.com'>네이버</OPTION>
				<OPTION value='nate.com'>네이트</OPTION>
				<OPTION value='empal.com'>엠팔</OPTION>
				<OPTION value='freechal.com'>프리첼</OPTION>
				<OPTION value='paran.com'>파란</OPTION>
				<OPTION value='hanmail.net'>다음</OPTION>
				<OPTION value='hitel.net'>하이텔</OPTION>
				<OPTION value='hotmail.com'>핫메일</OPTION>
				<OPTION value='korea.com'>코리아</OPTION>
				<OPTION value='lycos.co.kr'>라이코스</OPTION>
				<OPTION value='chollian.net'>천리안</OPTION>
				<OPTION value='dreamwiz.com'>드림위즈</OPTION>
				<OPTION value='netian.com'>네띠앙</OPTION>
				<option value="hanafos.com">하나포스</option></SELECT> <input type="text" size=20 maxlength="30" name="Email3" class="box2"> </td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>은 행 명</strong></td>
				<td width="76%" bgcolor="#EAEAEA">
				<select name="IU_BankName" class="box2">
				<option value="">선택</option>
				<option value="국민은행">국민은행</option>
				<option value="광주은행">광주은행</option>
				<option value="경남은행">경남은행</option>
				<option value="기업은행">기업은행</option>
				<option value="농협">농협</option>
				<option value="대구은행">대구은행</option>
				<option value="도이치은행">도이치은행</option>
				<option value="부산은행">부산은행</option>
				<option value="산업은행">산업은행</option>
				<option value="상호저축은행">상호저축은행</option>
				<option value="새마을금고">새마을금고</option>
				<option value="수협">수협</option>
				<option value="신한은행">신한은행</option>
				<option value="외환은행">외환은행</option>
				<option value="우리은행">우리은행</option>
				<option value="우체국">우체국</option>
				<option value="전북은행">전북은행</option>
				<option value="조흥은행">조흥은행</option>
				<option value="제주은행">제주은행</option>
				<option value="하나은행">하나은행</option>
				<option value="한미은행">한미은행</option>
				<option value="신협">신협</option>
				<option value="한국씨티은행">한국씨티은행</option>
				<option value="HSBC은행">HSBC은행</option>
				<option value="SC제일은행">SC제일은행</option></select></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>계좌번호</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxlength="16" name="IU_BankNum"></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>예 금 주</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input class=box2 style="WIDTH: 150px; HEIGHT: 20px" name="IU_BankOwner"></td></tr></table></td></tr></table></td></tr>
	<tr><td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 20px; PADDING-TOP: 0px" align=center>
		<input type="image" src="/images/btn_enter.gif" border="0">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:self.close();"><img src="/images/btn_can.gif" border=0></a></td></form></tr></table></td></tr>
<tr><td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px"></td></tr></table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>

</BODY>
</HTML>