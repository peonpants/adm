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
	IU_RegDate		= RS(10)				'�����
	IU_Status		= CDbl(Trim(RS(11)))	'����� ����
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
		Status = "����"
	ELSEIF IU_Status = 0 THEN
		Status = "����"
	ELSEIF IU_Status = 9 THEN
		Status = "Ż��"
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

    SQLMSG = "select sum(LC_CASH), count(*) from LOG_CASHINOUT where LC_ID = '"&IU_ID&"' and LC_CONTENTS = '���ù��'"
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
		if (!confirm("�����Ͻðڽ��ϱ�?")) {
			return;
		}
		else {
			var frm = document.frm2;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("�߰�/�����Ͻ÷��� �ݾ��� �����ּ���.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm2.submit();
		}
	}
	
	function FrmChk2()
	{
		if (!confirm("�����Ͻðڽ��ϱ�?")) {
			return;
		}
		else {
			var frm = document.frm3;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("�߰�/�����Ͻ÷��� �ݾ��� �����ּ���.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm3.submit();
		}
	}	

	function p5Chk()
	{
		if (!confirm("�÷���5%������ �����Ͻðڽ��ϱ�?")) {
			return;
		}
			document.itemP5.submit();

	}
	function p10Chk()
	{
		if (!confirm("�÷���10%������ �����Ͻðڽ��ϱ�?")) {
			return;
		}
			document.itemP10.submit();

	}
		function s5Chk()
	{
		if (!confirm("���̺�5%������ �����Ͻðڽ��ϱ�?")) {
			return;
		}
			document.itemS5.submit();

	}
		function s10Chk()
	{
		if (!confirm("���̺�10%������ �����Ͻðڽ��ϱ�?")) {
			return;
		}
			document.itemS10.submit();

	}
		function isaChk()
	{
		if (!confirm("����Ư�ʾ����� �����Ͻðڽ��ϱ�?")) {
			return;
		}
			document.itemISA.submit();

	}
</script><head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">ȸ������</font><font color="ffffff">&nbsp;&nbsp;�� ȸ�� ������</b></font></td></tr></table><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td width="50%" class="bu03"><strong>��&nbsp;ȸ���⺻���� - [ ����Ʈ�� : <FONT COLOR="RED"><%=IU_SITE%></FONT> ]</strong></td>
	<td width="50%" align="right"><b>�������� : <%=IU_RegDate%></b></td></tr></table>

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
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_ID" class="input" style="width:210" value="<%=IU_ID%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">��й�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_PW" class="input" style="width:210" value="<%=IU_PW%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_NickName" class="input" style="width:210" value="<%=IU_NickName%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�����Ӵ�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=formatnumber(IU_Cash,0)%>" READONLY></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Mobile" class="input" style="width:210" value="<%=IU_Mobile%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_Email" class="input" style="width:210" value="<%=IU_Email%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><select name="IU_BankName" style="width:210px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="box2">
					<option value="">����</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="�泲����" <% if IU_BankName = "�泲����" then response.write "selected" end if %>>�泲����</option>
					<option value="�������" <% if IU_BankName = "�������" then response.write "selected" end if %>>�������</option>
					<option value="����" <% if IU_BankName = "����" then response.write "selected" end if %>>����</option>
					<option value="�뱸����" <% if IU_BankName = "�뱸����" then response.write "selected" end if %>>�뱸����</option>
					<option value="����ġ����" <% if IU_BankName = "����ġ����" then response.write "selected" end if %>>����ġ����</option>
					<option value="�λ�����" <% if IU_BankName = "�λ�����" then response.write "selected" end if %>>�λ�����</option>
					<option value="�������" <% if IU_BankName = "�������" then response.write "selected" end if %>>�������</option>
					<option value="��ȣ��������" <% if IU_BankName = "��ȣ��������" then response.write "selected" end if %>>��ȣ��������</option>
					<option value="�������ݰ�" <% if IU_BankName = "�������ݰ�" then response.write "selected" end if %>>�������ݰ�</option>
					<option value="����" <% if IU_BankName = "����" then response.write "selected" end if %>>����</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="��ȯ����" <% if IU_BankName = "��ȯ����" then response.write "selected" end if %>>��ȯ����</option>
					<option value="�츮����" <% if IU_BankName = "�츮����" then response.write "selected" end if %>>�츮����</option>
					<option value="��ü��" <% if IU_BankName = "��ü��" then response.write "selected" end if %>>��ü��</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="��������" <% if IU_BankName = "��������" then response.write "selected" end if %>>��������</option>
					<option value="�ϳ�����" <% if IU_BankName = "�ϳ�����" then response.write "selected" end if %>>�ϳ�����</option>
					<option value="�ѹ�����" <% if IU_BankName = "�ѹ�����" then response.write "selected" end if %>>�ѹ�����</option>
					<option value="�ѱ���Ƽ����" <% if IU_BankName = "�ѱ���Ƽ����" then response.write "selected" end if %>>�ѱ���Ƽ����</option>
					<option value="������" <% if IU_BankName = "������" then response.write "selected" end if %>>����������</option>
					<option value="���" <% if IU_BankName = "���" then response.write "selected" end if %>>���</option>
					<option value="�츮��������" <% if IU_BankName = "�츮��������" then response.write "selected" end if %>>�츮��������</option>
					<option value="casino" <% if IU_BankName = "casino" then response.write "selected" end if %>>casino</option>
					<option value="�Ϸ�" <% if IU_BankName = "�Ϸ�" then response.write "selected" end if %>>�Ϸ�</option>					
					<option value="����" <% if IU_BankName = "����" then response.write "selected" end if %>>����</option>	
					<option value="SC��������" <% if IU_BankName = "SC��������" then response.write "selected" end if %>>SC��������</option></select></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">���¹�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankNum" class="input" style="width:210" value="<%=IU_BankNum%>" ></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_BankOwner" class="input" style="width:210" value="<%=IU_BankOwner%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">ȸ������</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><table border="0" cellpadding="0" cellspacing="0">
					<tr><td><select name="IU_Level" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=0 <% If IU_Level = 0 Then response.write "selected" %>>Ż��ȸ��</option>
							<option value=1 <% If IU_Level = 1 Then response.write "selected" %>>LV1ȸ��</option>
							<option value=2 <% If IU_Level = 2 Then response.write "selected" %>>Lv2ȸ��</option>
							<option value=3 <% If IU_Level = 3 Then response.write "selected" %>>Lv3ȸ��</option>				
							<option value=4 <% If IU_Level = 4 Then response.write "selected" %>>Lv4ȸ��</option>
							<option value=5 <% If IU_Level = 5 Then response.write "selected" %>>Lv5ȸ��</option>
							<option value=6 <% If IU_Level = 6 Then response.write "selected" %>>Lv6ȸ��</option>
							<option value=7 <% If IU_Level = 7 Then response.write "selected" %>>Lv7ȸ��</option>
							<option value=8 <% If IU_Level = 8 Then response.write "selected" %>>Lv8ȸ��</option>
							<option value=9 <% If IU_Level = 9 Then response.write "selected" %>>������</option>							
							</select></td>
						<td><img src="blank.gif" border="0" width="10" height="1"></td>
						<td><select name="IU_Status" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=1 <% If IU_Status = 1 Then response.write "selected" %>>����</option>
							<option value=0 <% If IU_Status = 0 Then response.write "selected" %>>����</option>
							<option value=9 <% If IU_Status = 9 Then response.write "selected" %>>Ż��</option>
							<option value=8>����</option></select></td></tr></table></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="RECOM_ID" class="input" style="width:210" value="<%=RECOM_ID%>" ></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_CODES" class="input" style="width:210" value="<%=IU_CODES%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ Ƚ ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="input" style="width:210" value="<%=RECOM_NUM%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">����Ʈ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_POINT %></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">���Ի���Ʈ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_SITE" class="input" style="width:210" value="<%=IU_SITE%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">ȯ�����</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>

	<td width="210"><input type="text" name="IU_mooney_pw" class="input" style="width:210" value="<%=IU_mooney_pw%>"></td>
	    
	</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">ȸ���󼼱��</td></tr></table>
	</td>
	<td colspan="5"><input type = "text" name = "IU_DETAIL" value = "<%=IU_DETAIL%>" size = "100" maxlength="100"></td></tr>
<tr><td colspan = "7" align = "center">*�������� 100�� �̳��� �����ּ���.*</td></tr>	
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>

<!----------------------------------------------------------------------------------------------apple �߰� 150108 --------------------------->
<tr>
    <td bgcolor="#ececec" width="180">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">ȸ����������</td></tr></table>    
    </td>
    <td colspan="6">
    <table cellpadding=5 cellspacing=1  bgcolor="aaaaaa" width=100%>

    <tr bgcolor="#ffffff">
        <td>�ѹ��ñݾ� : <b> <%= formatnumber(sumIB_Amount,0)  %>��</b></td>
        <td>����Ƚ��  : <b><%= cntIB_Amount %>ȸ</b> ��� ������(<b><%= avgIB_cnt %></b>)</td>
        <td align="right" bgcolor="#f9fecc">������ձݾ� : <b><%= formatnumber(avgIB_Amount,0)  %>��</b></td>
    </tr>

    <% IF sumIB_AmountBenefit <> 0 AND cntIB_Amount <> 0  Then %>
    <tr bgcolor="#ffffff">
        <td> ���ô�÷�� :  <b><%= formatnumber(sumIB_AmountBenefit,0)  %>��</b></td>
        <td>���ô�÷Ƚ�� : <b><%= cntIB_AmountBenefit  %>ȸ</b></td>
        <td align="right" bgcolor="#ccfef5">���߷� : <b>
        <% response.Write  formatnumber(cntIB_AmountBenefit/cntIB_Amount*100,0)  %>%
        </b></td>
    </tr>  
     <% End IF %>  
    <tr bgcolor="#ffffff">
        <td> ���� :  <b><%= formatnumber(IU_CHARGE,0)  %>��</b></td>
        <td> ȯ�� :  <b><%= formatnumber(IU_EXCHANGE,0)  %>��</b></td>
        <td align="right" bgcolor="#ccfef5">���� : 
          <b><%= formatnumber(IU_CHARGE-IU_EXCHANGE,0)  %>��</b><br />
          �Խñ� ī��Ʈ : <b><%= cntBF_COUNT %> ȸ</b>
        </td>
    </tr>       
    </table>
    

       
    </td>
</tr>
<!-- ȸ���������� -->
<Tr>
    <td bgcolor="#ececec">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr><td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
		        <td class="td_01">ȸ����������</td></tr></table>    
            </td>
            <td colspan="6" >
            <table cellpadding=5 cellspacing=1  bgcolor="aaaaaa" width=100%>
            <tr>
        <%

'������ �Ǽ� �ۼ������� ǥ��
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
<!-- ȸ���������� -->


<!----------------------------------------------------------------------------------------------apple �߰�--------------------------->


<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td colspan="7" align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	<input type="button" value="�����ϱ�" onclick="FrmChk();" style="border: 1 solid; background-color:#C5BEBD;"><% END IF %>
	<input type="button" value="�������" onclick="location.href='List.asp?page=<%=PAGE%>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="���ø���Ʈ" onclick="location.href='/EPCenter/04_Game/Betting_List1.asp?Search=IB_ID&Find=<%= IU_ID %>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input type="button" value="����������" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'" class="input"> 
	</td></tr></form></table>
<!------------------------------------------------------------------------------------------------------------------------->

<table border='0'><tr>
		<td class="td_01" bgcolor="#CECEF6"><strong>������������Ȳ</strong>&nbsp;&nbsp;&nbsp;</td>
											<td >&nbsp;&nbsp;&nbsp;�÷���5%������&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_ip5,0)%>��</strong></td>
<form name="itemP5" id="itemP5" method="post" action="P5_Proc.asp">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">

	<td width="60">
	    +<input type="Radio" name="ProcFlag" value="+" checked>
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
    <td align="right">

	    <input type="button" value="����" onclick="p5Chk();" style="border: 1 solid; background-color:#C5BEBD;">

    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;�÷���10%������&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_ip10,0)%>��</strong></td>
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
	    <input type="button" value="����" onclick="p10Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>											>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;���̺�5%������&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_is5,0)%>��</strong></td>
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
	    <input type="button" value="����" onclick="s5Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;���̺�10%������&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_is10,0)%>��</strong></td>
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
	    <input type="button" value="����" onclick="s10Chk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>
<td width="5" align="right">&nbsp;</td>
											<td >&nbsp;����Ư�ʾ�����&nbsp;:&nbsp;</td>
											<td ><strong><%=formatnumber(iu_isa,0)%>��</strong></td>
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
	    <input type="button" value="����" onclick="isaChk();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
	</form>											</tr></table>
<!------------------------------------------------------------------------------------------------------------------------->
<form name="frm2" id="frm2" method="post" action="Cash_Proc.asp">
<table>
<tr>
    <td class="bu03">
        <strong>ȸ��ĳ����ȯ��</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
<tr  bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="100">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> ĳ������
	</td>
	
	<td width="180">
        ����ĳ��:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		ȯ��ĳ��:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="100">
	    �߰�/����
	</td>	
	<td width="150">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
	    �Է±ݾ�
	</td>	
	<td width="110">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value="">��
    </td>
	<td bgcolor="#ececec" width="100">
	    ���(����)
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
	    <input type="button" value=" ĳ����ȯ�� " onclick="FrmChk1();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
</tr>
</table>
</form>
	

<form name="frm3" id="frm3" method="post" action="Point_Proc.asp">	
<table>
<tr>
    <td class="bu03"><strong>
    ȸ������Ʈ��ȯ��</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_IDX" value="<%=IU_IDX%>">
<input type="hidden" name="IU_ID" value="<%=IU_ID%>">
<input type="hidden" name="Page" value="<%=Page%>">
<tr bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="100">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> ����Ʈ����
	</td>	
	<td width="220">
	    ��������Ʈ:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ȯ������Ʈ:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="150">
	    �߰�/����
	</td>	
	<td width="210">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		-<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
    �Է�����Ʈ
    </td>	
	<td width="210">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value=""> P
    </td>
	<td bgcolor="#ececec" width="100">
	    ���(����)
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
	    <input type="button" value=" ����Ʈ��ȯ�� " onclick="FrmChk2();" style="border: 1 solid; background-color:#C5BEBD;">
	<% END IF %>
	</td>
</tr>
</table>	
</form>
<!--
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>
<table><tr><td class="bu03"><strong>��&nbsp;SMS��������</strong></td></tr></table>

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
          <td width="100" align="left" class="td_01">SMS �� ��ȣ</td>
          <td width="200" align="center"><input type="text" name="smsnum" style="width:100px;"></td>
					<td width="18"><img src="/EPCenter/Images/subimg_06.gif" border="0"></td>
          <td width="100" align="left" class="td_01">SMS���ſ���</td>
          <td width="100" align="center"><input type="checkbox" name="smsyn"></td>
          <td width="100" align="center"><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="submit" value="SMS��������"><% END IF %></td>
          <td><% IF request.Cookies("AdminLevel") = 1 THEN %> 
	    <input type="button" value="����������" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'"> 
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
    <td width="33%"><strong>��&nbsp;��������&nbsp;&nbsp;(<%=FORMATNUMBER(INSUM,0)%> ��)</strong></td>
	<td width="33%"><strong>��&nbsp;ȯ������&nbsp;&nbsp;(<%=FORMATNUMBER(OUTSUM,0)%> ��)</strong></td>
	<td width="33%"><strong>��&nbsp;�α�������</strong></td></tr>
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