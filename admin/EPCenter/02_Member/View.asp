<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<%
	Page			= REQUEST("Page")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))


	SQLMSG = "SELECT IU_ID, IU_LEVEL, IU_PW, IU_NICKNAME, IU_CASH, IU_MOBILE, IU_EMAIL, IU_BANKNAME, IU_BANKNUM, IU_BANKOWNER, IU_REGDATE, IU_STATUS "
	SQLMSG = SQLMSG & " , IU_SITE, RECOM_ID, RECOM_NUM, IU_CODES,IU_POINT, IU_SMSCK,  IU_DETAIL,iu_ip5,iu_ip10,iu_is5,iu_is10,iu_isa , IU_CHARGE, IU_EXCHANGE, IU_mooney_pw FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
	SET RS = DbCon.Execute(SQLMSG)

	IU_ID			= RS(0)
	IU_PW			= RS(2)
	IU_Cash			= RS(4)
	IU_NickName		= Trim(RS(3))
	IU_BankName		= Trim(RS(7))
	IU_BankNum		= Trim(RS(8))
	IU_BankOwner	= Trim(RS(9))
	IU_Mobile		= Trim(RS(5))
	IU_Email		= Trim(RS(6))
	IU_Level		= CDbl(RS(1))
	IU_RegDate		= RS(10)				'등록일
	IU_Status		= CDbl(Trim(RS(11)))	'사용자 상태
	IU_SITE			= RS(12)
	RECOM_ID        = Trim(Rs(13))
	RECOM_NUM        = Trim(Rs(14))
	IU_CODES        = Trim(Rs(15))
	IU_POINT        = Trim(Rs(16))
    IU_SMSCK        = Trim(Rs(17))
    IU_DETAIL        = RTrim(Rs(18))
    iu_ip5        = RTrim(Rs(19))
    iu_ip10        = RTrim(Rs(20))
    iu_is5        = RTrim(Rs(21))
    iu_is10        = RTrim(Rs(22))
    iu_isa        = RTrim(Rs(23))
    IU_CHARGE        = RTrim(Rs(24))
    IU_EXCHANGE        = RTrim(Rs(25))
    IU_mooney_pw        = RTrim(Rs(26))
	RS.Close
	Set RS = Nothing
	
	IF IU_Status  = 1 THEN
		Status = "정상"
	ELSEIF IU_Status = 0 THEN
		Status = "정지"
	ELSEIF IU_Status = 9 THEN
		Status = "탈퇴"
	END If
	
 sumIB_Amount = 0
    cntIB_Amount = 0
    avgIB_Amount = 0
    avgIB_cnt = 0 
    sumIB_AmountBenefit = 0
    cntIB_AmountBenefit = 0 
    cntBF_COUNT = 0
    SQLMSG = "select isNull(sum(ib_amount),0) ,count(*) , isNull(avg(ib_amount),0)  , isNull(avg(ib_cnt),0)   from info_betting where ib_id = '"&IU_ID&"' and IB_SITE <> 'None'"
    
    SET sRS = DbCon.Execute(SQLMSG)
	
	IF NOT sRS.Eof Then
	    sumIB_Amount = sRS(0)
	    cntIB_Amount = sRS(1)	    
	    avgIB_Amount = sRS(2)
	    avgIB_cnt = sRS(3)
	End IF

    SQLMSG = "select sum(LC_CASH), count(*) from LOG_CASHINOUT where LC_ID = '"&IU_ID&"' and LC_CONTENTS = '배팅배당'"
    SET sRS = DbCon.Execute(SQLMSG)
	
	IF NOT sRS.Eof Then
	    sumIB_AmountBenefit = sRs(0)
	    cntIB_AmountBenefit = sRs(1)
	End IF	
	
    SQLMSG = "select count(*) from BOARD_FREE where BF_PW = '"&IU_ID&"'"
    SET sRS = DbCon.Execute(SQLMSG)
	
	IF NOT sRS.Eof Then
	    cntBF_COUNT = sRs(0)
	End IF		

%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="JavaScript" type="text/javascript" src="/Sc/Function.js"></script>
<script>
	function FrmChk()
	{
		document.frm1.submit();
	}
	
	function FrmChk1()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm2;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm2.submit();
		}
	}
	
	function FrmChk2()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm3;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm3.submit();
		}
	}	

	function p5Chk()
	{
		if (!confirm("플러스5%아이템 증감하시겠습니까?")) {
			return;
		}
			document.itemP5.submit();

	}
	function p10Chk()
	{
		if (!confirm("플러스10%아이템 증감하시겠습니까?")) {
			return;
		}
			document.itemP10.submit();

	}
		function s5Chk()
	{
		if (!confirm("세이브5%아이템 증감하시겠습니까?")) {
			return;
		}
			document.itemS5.submit();

	}
		function s10Chk()
	{
		if (!confirm("세이브10%아이템 증감하시겠습니까?")) {
			return;
		}
			document.itemS10.submit();

	}
		function isaChk()
	{
		if (!confirm("적중특례아이템 증감하시겠습니까?")) {
			return;
		}
			document.itemISA.submit();

	}
</script><head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">회원관리</font><font color="ffffff">&nbsp;&nbsp;▶ 회원 상세정보</b></font></td></tr></table><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td width="50%" class="bu03"><strong>☞&nbsp;회원기본정보 - [ 사이트명 : <FONT COLOR="RED"><%=IU_SITE%></FONT> ]</strong></td>
	<td width="50%" align="right"><b>가입일자 : <%=IU_RegDate%></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<form name="frm1" action="Edit_Proc.asp" method="post">
<input type="hidden" name = "IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name = "PAGE" value="<%=PAGE%>">
<input type="hidden" name = "IUSITEBEFORE" value="<%=IU_SITE%>">

<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">아 이 디</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_ID" class="input" style="width:210" value="<%=IU_ID%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">비밀번호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_PW" class="input" style="width:210" value="<%=IU_PW%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">닉 네 임</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_NickName" class="input" style="width:210" value="<%=IU_NickName%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">보유머니호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=formatnumber(IU_Cash,0)%>" READONLY></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">핸 드 폰</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Mobile" class="input" style="width:210" value="<%=IU_Mobile%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">이 메 일</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Email" class="input" style="width:210" value="<%=IU_Email%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">은 행 명</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><select name="IU_BankName" style="width:210px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="box2">
					<option value="">선택</option>
					<option value="국민은행" <% if IU_BankName = "국민은행" then response.write "selected" end if %>>국민은행</option>
					<option value="광주은행" <% if IU_BankName = "광주은행" then response.write "selected" end if %>>광주은행</option>
					<option value="경남은행" <% if IU_BankName = "경남은행" then response.write "selected" end if %>>경남은행</option>
					<option value="기업은행" <% if IU_BankName = "기업은행" then response.write "selected" end if %>>기업은행</option>
					<option value="농협" <% if IU_BankName = "농협" then response.write "selected" end if %>>농협</option>
					<option value="대구은행" <% if IU_BankName = "대구은행" then response.write "selected" end if %>>대구은행</option>
					<option value="도이치은행" <% if IU_BankName = "도이치은행" then response.write "selected" end if %>>도이치은행</option>
					<option value="부산은행" <% if IU_BankName = "부산은행" then response.write "selected" end if %>>부산은행</option>
					<option value="산업은행" <% if IU_BankName = "산업은행" then response.write "selected" end if %>>산업은행</option>
					<option value="상호저축은행" <% if IU_BankName = "상호저축은행" then response.write "selected" end if %>>상호저축은행</option>
					<option value="새마을금고" <% if IU_BankName = "새마을금고" then response.write "selected" end if %>>새마을금고</option>
					<option value="수협" <% if IU_BankName = "수협" then response.write "selected" end if %>>수협</option>
					<option value="신한은행" <% if IU_BankName = "신한은행" then response.write "selected" end if %>>신한은행</option>
					<option value="외환은행" <% if IU_BankName = "외환은행" then response.write "selected" end if %>>외환은행</option>
					<option value="우리은행" <% if IU_BankName = "우리은행" then response.write "selected" end if %>>우리은행</option>
					<option value="우체국" <% if IU_BankName = "우체국" then response.write "selected" end if %>>우체국</option>
					<option value="전북은행" <% if IU_BankName = "전북은행" then response.write "selected" end if %>>전북은행</option>
					<option value="조흥은행" <% if IU_BankName = "조흥은행" then response.write "selected" end if %>>조흥은행</option>
					<option value="제주은행" <% if IU_BankName = "제주은행" then response.write "selected" end if %>>제주은행</option>
					<option value="하나은행" <% if IU_BankName = "하나은행" then response.write "selected" end if %>>하나은행</option>
					<option value="한미은행" <% if IU_BankName = "한미은행" then response.write "selected" end if %>>한미은행</option>
					<option value="한국씨티은행" <% if IU_BankName = "한국씨티은행" then response.write "selected" end if %>>한국씨티은행</option>
					<option value="스위스" <% if IU_BankName = "스위스" then response.write "selected" end if %>>스위스은행</option>
					<option value="상와" <% if IU_BankName = "상와" then response.write "selected" end if %>>상와</option>
					<option value="우리투자증권" <% if IU_BankName = "우리투자증권" then response.write "selected" end if %>>우리투자증권</option>
					<option value="casino" <% if IU_BankName = "casino" then response.write "selected" end if %>>casino</option>
					<option value="암로" <% if IU_BankName = "암로" then response.write "selected" end if %>>암로</option>					
					<option value="신협" <% if IU_BankName = "신협" then response.write "selected" end if %>>신협</option>	
					<option value="SC제일은행" <% if IU_BankName = "SC제일은행" then response.write "selected" end if %>>SC제일은행</option></select></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">계좌번호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankNum" class="input" style="width:210" value="<%=IU_BankNum%>" ></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">예 금 주</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankOwner" class="input" style="width:210" value="<%=IU_BankOwner%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">회원상태</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><table border="0" cellpadding="0" cellspacing="0">
					<tr><td><select name="IU_Level" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=0 <% If IU_Level = 0 Then response.write "selected" %>>탈퇴회원</option>
							<option value=1 <% If IU_Level = 1 Then response.write "selected" %>>LV1회원</option>
							<option value=2 <% If IU_Level = 2 Then response.write "selected" %>>Lv2회원</option>
							<option value=3 <% If IU_Level = 3 Then response.write "selected" %>>Lv3회원</option>				
							<option value=4 <% If IU_Level = 4 Then response.write "selected" %>>Lv4회원</option>
							<option value=5 <% If IU_Level = 5 Then response.write "selected" %>>Lv5회원</option>
							<option value=6 <% If IU_Level = 6 Then response.write "selected" %>>Lv6회원</option>
							<option value=7 <% If IU_Level = 7 Then response.write "selected" %>>Lv7회원</option>
							<option value=8 <% If IU_Level = 8 Then response.write "selected" %>>Lv8회원</option>
							<option value=9 <% If IU_Level = 9 Then response.write "selected" %>>관리자</option>							
							</select></td>
						<td><img src="blank.gif" border="0" width="10" height="1"></td>
						<td><select name="IU_Status" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=1 <% If IU_Status = 1 Then response.write "selected" %>>정상</option>
							<option value=0 <% If IU_Status = 0 Then response.write "selected" %>>정지</option>
							<option value=9 <% If IU_Status = 9 Then response.write "selected" %>>탈퇴</option>
							<option value=8>삭제</option></select></td></tr></table></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 인</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="RECOM_ID" class="input" style="width:210" value="<%=RECOM_ID%>" ></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 코 드</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_CODES" class="input" style="width:210" value="<%=IU_CODES%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 횟 수</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=RECOM_NUM%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">포인트</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_POINT %></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">가입사이트</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_SITE" class="input" style="width:210" value="<%=IU_SITE%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">환전비번</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>

	<td width="210"><input type="text" name="IU_mooney_pw" class="input" style="width:210" value="<%=IU_mooney_pw%>"></td>
	    
	</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">회원상세기록</td></tr></table>
	</td>
	<td colspan="5"><input type = "text" name = "IU_DETAIL" value = "<%=IU_DETAIL%>" size = "100" maxlength="100"></td></tr>
<tr><td colspan = "7" align = "center">*공백포함 100자 이내로 적어주세요.*</td></tr>	
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>

<!----------------------------------------------------------------------------------------------apple 추가 150108 --------------------------->
<tr>
    <td bgcolor="#ececec" width="180">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">회원배팅집계</td></tr></table>    
    </td>
    <td colspan="6">
    <table cellpadding=5 cellspacing=1  bgcolor="aaaaaa" width=100%>

    <tr bgcolor="#ffffff">
        <td>총배팅금액 : <b> <%= formatnumber(sumIB_Amount,0)  %>원</b></td>
        <td>배팅횟수  : <b><%= cntIB_Amount %>회</b> 평균 폴더수(<b><%= avgIB_cnt %></b>)</td>
        <td align="right" bgcolor="#f9fecc">배팅평균금액 : <b><%= formatnumber(avgIB_Amount,0)  %>원</b></td>
    </tr>

    <% IF sumIB_AmountBenefit <> 0 AND cntIB_Amount <> 0  Then %>
    <tr bgcolor="#ffffff">
        <td> 배팅당첨금 :  <b><%= formatnumber(sumIB_AmountBenefit,0)  %>원</b></td>
        <td>배팅당첨횟수 : <b><%= cntIB_AmountBenefit  %>회</b></td>
        <td align="right" bgcolor="#ccfef5">적중률 : <b>
        <% response.Write  formatnumber(cntIB_AmountBenefit/cntIB_Amount*100,0)  %>%
        </b></td>
    </tr>  
     <% End IF %>  
    <tr bgcolor="#ffffff">
        <td> 충전 :  <b><%= formatnumber(IU_CHARGE,0)  %>원</b></td>
        <td> 환전 :  <b><%= formatnumber(IU_EXCHANGE,0)  %>원</b></td>
        <td align="right" bgcolor="#ccfef5">정산 : 
          <b><%= formatnumber(IU_CHARGE-IU_EXCHANGE,0)  %>원</b><br />
          게시글 카운트 : <b><%= cntBF_COUNT %> 회</b>
        </td>
    </tr>       
    </table>
    

       
    </td>
</tr>
<!-- 회원배팅폴더 -->
<Tr>
    <td bgcolor="#ececec">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		        <td class="td_01">회원배팅폴더</td></tr></table>    
            </td>
            <td colspan="6" >
            <table cellpadding=5 cellspacing=1  bgcolor="aaaaaa" width=100%>
            <tr>
        <%

'폴더당 건수 퍼센테이지 표시
str3 = "select ib_cnt , count(*) as Cnt" & _
" , Percentage = convert(DECIMAL(5,1),convert(MONEY,100.0 * count(*) / " & _
"                    (SELECT count(*) FROM   info_betting where ib_site <> 'None' and ib_id = '"&IU_ID&"')), 1) " & _
" from info_betting where ib_site <> 'None' and ib_id = '"&IU_ID&"' " & _
" group by ib_cnt " & _
" order by Cnt" 


SET sRS3 = DbCon.Execute(str3)


arrPer = Array(0,0,0,0,0,0,0,0) 
arrCnt = Array(0,0,0,0,0,0,0,0) 
arrValue = Array(0,0,0,0,0,0,0,0) 



sumPercentage = 0 
sumCnt = 0
sumCnt1 = 0

IF NOT sRS3.Eof Then
    DO UNTIL sRS3.Eof
        ib_cnt =  sRs3("ib_cnt")
        Percentage =  sRs3("Percentage")
        Cnt =  sRs3("Cnt")

        IF ib_cnt < 5 Then
            arrPer(ib_cnt) = Percentage
            arrCnt(ib_cnt) = Cnt
            arrValue(ib_cnt) = Cnt
                        
            sumPercentage = sumPercentage + CDBL(Percentage)
            sumCnt = sumCnt + Cnt
        End IF
        sumCnt1 = sumCnt1 +  Cnt
        sRS3.MoveNext 
    Loop
    arrPer(7) =  100- sumPercentage
    arrCnt(7) =  sumCnt1 - sumCnt
    arrValue(7) =  sumCnt1 - sumCnt
End IF

For i = 0 to Ubound(arrValue) 
    For j = i+1 to Ubound(arrValue) 
        If arrValue(i)<arrValue(j) Then 
            temp = arrValue(i) 
            arrValue(i) = arrValue(j) 
            arrValue(j) = temp 
        End If 
    Next 
Next 


For i = 1 to 7
    IF arrPer(i) <> "" Then
        IF arrValue(0)  = arrCnt(i) Then
            str = "<font color=red>"
            strBgColor = "pink"
        ElseIF arrValue(1) = arrCnt(i) Then
            str = "<font color=blue>"
            strBgColor = "skyblue"
        Else
            str = "<font color=black>"    
            strBgColor = "ffffff"    
        End IF
        
        IF arrCnt(i) = 0 Then
            str = "<font color=black>"    
            strBgColor = "ffffff"            
        End IF
        
        response.Write "<td bgcolor="&strBgColor&">"& i &"</td><td bgcolor="&strBgColor&">" & str &  arrPer(i) & "%("&  arrCnt(i) & ")</font></td>"
    End IF
Next
%>	
            </tr>    
            </table>    
    </td>
</Tr>
<!-- 회원배팅폴더 -->


<!----------------------------------------------------------------------------------------------apple 추가--------------------------->


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td colspan="7" align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	<input type="button" value="수정하기" onclick="FrmChk();" style="border: 1 solid; background-color:#C5BEBD;"><% END IF %>
	<input type="button" value="목록으로" onclick="location.href='List.asp?page=<%=PAGE%>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="배팅리스트" onclick="location.href='/EPCenter/04_Game/Betting_List1.asp?Search=IB_ID&Find=<%= IU_ID %>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="쪽지보내기" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'" class="input"> 
	</td></tr></form></table>
<!------------------------------------------------------------------------------------------------------------------------->

<table border='0'><tr>
		<td class="td_01" bgcolor="#CECEF6"><strong>보유아이템현황</strong>&nbsp;&nbsp;&nbsp;</td>
											<td >&nbsp;&nbsp;&nbsp;플러스5%아이템&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_ip5,0)%>개</strong></td>
<form name="itemP5" id="itemP5" method="post" action="P5_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">

	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">

	    <input type="button" value="증감" onclick="p5Chk();" style="border: 1 solid; background-color:#C5BEBD;">

    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;플러스10%아이템&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_ip10,0)%>개</strong></td>
<form name="itemP10" id="itemP10" method="post" action="P10_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value="증감" onclick="p10Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>											>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;세이브5%아이템&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_is5,0)%>개</strong></td>
<form name="itemS5" id="itemS5" method="post" action="S5_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value="증감" onclick="s5Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;세이브10%아이템&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_is10,0)%>개</strong></td>
<form name="itemS10" id="itemS10" method="post" action="S10_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value="증감" onclick="s10Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;적중특례아이템&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_isa,0)%>개</strong></td>
<form name="itemISA" id="itemISA" method="post" action="ISA_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value="증감" onclick="isaChk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>											</tr></table>
<!------------------------------------------------------------------------------------------------------------------------->
<form name="frm2" id="frm2" method="post" action="Cash_Proc.asp">
<table>
<tr>
    <td class="bu03">
        <strong>회원캐쉬충환전</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
<tr  bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="100">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> 캐쉬구분
	</td>
	
	<td width="180">
        충전캐쉬:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		환전캐쉬:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="100">
	    추가/삭제
	</td>	
	<td width="150">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
	    입력금액
	</td>	
	<td width="110">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value="">원
    </td>
	<td bgcolor="#ececec" width="100">
	    비고(내역)
	</td>	
	<td width="210">
	    <input type="text" name="IC_CONTENTS1" class="input" style="width:210;text-align:right;" value="">
    </td>    
</tr>	
</table>
<table width="100%">
<tr>
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value=" 캐쉬충환전 " onclick="FrmChk1();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
</tr>
</table>
</form>
	

<form name="frm3" id="frm3" method="post" action="Point_Proc.asp">	
<table>
<tr>
    <td class="bu03"><strong>
    회원포인트충환전</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
<tr bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="100">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> 포인트구분
	</td>	
	<td width="220">
	    충전포인트:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        환전포인트:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="150">
	    추가/삭제
	</td>	
	<td width="210">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		-<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
    입력포인트
    </td>	
	<td width="210">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value=""> P
    </td>
	<td bgcolor="#ececec" width="100">
	    비고(내역)
	</td>	
	<td width="210">
	    <input type="text" name="LP_CONTENTS1" class="input" style="width:180;text-align:right;" value="">
    </td>      
</tr>
</table>
<table width="100%">
<tr>
    <td colspan="11" align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value=" 포인트충환전 " onclick="FrmChk2();" style="border: 1 solid; background-color:#C5BEBD;">
	<% END IF %>
	</td>
</tr>
</table>	
</form>
<!--
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>
<table><tr><td class="bu03"><strong>☞&nbsp;SMS정보변경</strong></td></tr></table>

<form name="frm_sms" method="post" action="edit_sms.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="IU_SITE" value="<%=IU_SITE%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="600" border="1" cellspacing="0" cellpadding="0">
        <tr> 
					<td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
          <td width="100" align="left" class="td_01">SMS 폰 번호</td>
          <td width="200" align="center"><input type="text" name="smsnum" style="width:100px;"></td>
					<td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
          <td width="100" align="left" class="td_01">SMS수신여부</td>
          <td width="100" align="center"><input type="checkbox" name="smsyn"></td>
          <td width="100" align="center"><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="submit" value="SMS정보변경"><% END IF %></td>
          <td><% IF request.Cookies("AdminLevel") = 1 THEN %> 
	    <input type="button" value="쪽지보내기" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'"> 
	<% ELSE %>
	    -
	<% END IF %></td>
        </tr>
      </table></td>
  </tr>
</table>
</form>
-->
<%
	SQLLIST = "SELECT ISNULL(SUM(IC_AMOUNT),0) FROM Info_Charge Where IC_ID = '"& IU_ID &"' "
	SET RSLIST = DbCon.Execute(SQLLIST)
	INSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(IE_AMOUNT),0) FROM Info_Exchange Where IE_STATUS != 3 and IE_ID = '"& IU_ID &"'  "
	SET RSLIST = DbCon.Execute(SQLLIST)
	OUTSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="20"></td></tr></table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
    <td width="33%"><strong>☞&nbsp;충전내역&nbsp;&nbsp;(<%=FORMATNUMBER(INSUM,0)%> 원)</strong></td>
	<td width="33%"><strong>☞&nbsp;환전내역&nbsp;&nbsp;(<%=FORMATNUMBER(OUTSUM,0)%> 원)</strong></td>
	<td width="33%"><strong>☞&nbsp;로그인정보</strong></td></tr>
<tr>
    <td><iframe Name="INMONEY" src="inc_inmoney.asp?USERID=<%=IU_ID%>&USERSITE=<%=IU_SITE%>" width="100%" height="320" marginwidth="0" marginheight="0" scrolling="No" frameborder="1"></iframe>
    </td>
	<td><iframe Name="OUTMONEY" src="inc_outmoney.asp?USERID=<%=IU_ID%>&USERSITE=<%=IU_SITE%>" width="100%" height="320" marginwidth="0" marginheight="0" scrolling="No" frameborder="1"></iframe>
	</td>
	<td><iframe Name="LOGINLOG" src="inc_login.asp?USERID=<%=IU_ID%>&USERSITE=<%=IU_SITE%>" width="100%" height="320" marginwidth="0" marginheight="0" scrolling="No" frameborder="1"></iframe>
	</td>
</tr>
</table>
<table width="1000">
<tr>
    <td width="500">
        <iframe src="/EPCenter/05_Account/Money_AddSub.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LC_ID&Find=<%= IU_ID %>" width="500" height="300"></iframe>
    </td>
    <td width="500">
        <iframe src="/EPCenter/05_Account/point_list.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LP_ID&Find=<%= IU_ID %>" width="500" height="300"></iframe>
    </td>
</tr>
</table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>