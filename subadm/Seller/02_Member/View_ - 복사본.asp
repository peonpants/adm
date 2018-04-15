<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/Seller/05_Account/_Sql/accountSql.Class.asp"-->
<%
	Page			= REQUEST("Page")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))

	SQLMSG = "SELECT IU_ID, IU_LEVEL, IU_PW, IU_NICKNAME, IU_CASH, IU_MOBILE, IU_EMAIL, IU_BANKNAME, IU_BANKNUM, IU_BANKOWNER, IU_REGDATE, IU_STATUS "
	SQLMSG = SQLMSG & " , IU_SITE, RECOM_ID, RECOM_NUM, IU_CODES,IU_POINT, IU_SMSCK FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
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
    
	RS.Close
	Set RS = Nothing
	
	IF IU_Status  = 1 THEN
		Status = "정상"
	ELSEIF IU_Status = 0 THEN
		Status = "정지"
	ELSEIF IU_Status = 9 THEN
		Status = "탈퇴"
	END IF
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
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
	
</script>
</head>

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

<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">아 이 디</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=IU_ID%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">비밀번호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_PW" class="input" style="width:210" value="<%=IU_PW%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">닉 네 임</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_NickName" class="input" style="width:210" value="<%=IU_NickName%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">보유머니호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=formatnumber(IU_Cash,0)%>" READONLY></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">핸 드 폰</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Mobile" class="input" style="width:210" value="<%=IU_Mobile%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">이 메 일</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Email" class="input" style="width:210" value="<%=IU_Email%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
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
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">계좌번호</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankNum" class="input" style="width:210" value="<%=IU_BankNum%>" ></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">예 금 주</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankOwner" class="input" style="width:210" value="<%=IU_BankOwner%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">회원상태</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><table border="0" cellpadding="0" cellspacing="0">
					<tr><td><select name="IU_Level" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=0 <% If IU_Level = 0 Then response.write "selected" %>>준회원</option>
							<option value=1 <% If IU_Level = 1 Then response.write "selected" %>>정회원</option>
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
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 인</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="RECOM_ID" class="input" style="width:210" value="<%=RECOM_ID%>" readonly></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 코 드</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_CODES" class="input" style="width:210" value="<%=IU_CODES%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">추 천 횟 수</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=RECOM_NUM%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">포인트</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_POINT %></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">가입사이트</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%=IU_SITE%></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">당첨문자전송</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">
        <select name="IU_SMSCK" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
		<option value=1 <% If IU_SMSCK = 1 Then response.write "selected" %>>전송</option>
		<option value=0 <% If IU_SMSCK = 0 Then response.write "selected" %>>전송금지</option>

		</select>	    
	</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td colspan="7" align="right">
	<input type="button" value="목록으로" onclick="location.href='List.asp?page=<%=PAGE%>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="배팅리스트" onclick="location.href='/Seller/04_Game/Betting_List.asp?Search=IB_ID&Find=<%= IU_ID %>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="쪽지보내기" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'" class="input"> 
	</td></tr></form></table>


	



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
        <iframe src="/Seller/05_Account/Money_AddSub.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LC_ID&Find=<%= IU_ID %>" width="500" height="300"></iframe>
    </td>
    <td width="500">
        <iframe src="/Seller/05_Account/point_list.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LP_ID&Find=<%= IU_ID %>" width="500" height="300"></iframe>
    </td>
</tr>
</table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>