<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
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
    
	RS.Close
	Set RS = Nothing
	
	IF IU_Status  = 1 THEN
		Status = "����"
	ELSEIF IU_Status = 0 THEN
		Status = "����"
	ELSEIF IU_Status = 9 THEN
		Status = "Ż��"
	END IF
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script language="JavaScript" type="text/javascript" src="/Sc/Function.js"></script>
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- ��ڸ޴� ��Ÿ�� �׸�  ----------------->

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
	
</script>
</head>


<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> �� </span>
		 ȸ������ - &nbsp;&nbsp;�� ȸ�� ������
	</div>


<div style="height:10px;"></div>



  

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td width="50%" class="bu03"><strong>��&nbsp;ȸ���⺻���� - [ ����Ʈ�� : <FONT COLOR="RED"><%=IU_SITE%></FONT> ]</strong></td>
	<td width="50%" align="right"><b>�������� : <%=IU_RegDate%></b></td></tr></table>

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
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="text_box1" style="width:210" value="<%=IU_ID%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">��й�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">&nbsp;</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#c8c8c8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_NickName" class="text_box1" style="width:210" value="<%=IU_NickName%>"></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�����Ӵ�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="text_box1" style="width:210" value="<%=formatnumber(IU_Cash,0)%>" READONLY></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_Mobile %></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">&nbsp;</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">&nbsp;</td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">���¹�ȣ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">&nbsp;</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>


<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_BankOwner %></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">ȸ������</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><table border="0" cellpadding="0" cellspacing="0">
					<tr><td><select name="IU_Level" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
							<option value=0 <% If IU_Level = 0 Then response.write "selected" %>>��ȸ��</option>
							<option value=1 <% If IU_Level = 1 Then response.write "selected" %>>��ȸ��</option>
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


<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="RECOM_ID" class="text_box1" style="width:210" value="<%=RECOM_ID%>" readonly></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ �� ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="IU_CODES" class="text_box1" style="width:210" value="<%=IU_CODES%>"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">�� õ Ƚ ��</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><input type="text" name="" class="text_box1" style="width:210" value="<%=RECOM_NUM%>" READONLY></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">����Ʈ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%= IU_POINT %></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>


<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>
<tr><td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">���Ի���Ʈ</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210"><%=IU_SITE%></td>
	<td width="15"><img src="/images/sub/blank.gif" border="0" width="15" height="1"></td>
	<td bgcolor="#ececec" width="180">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="18"><img src="/Seller/Images/subimg_06.gif" border="0"></td>
		<td class="td_01">��÷��������</td></tr></table></td>
	<td width="20"><img src="/images/sub/blank.gif" border="0" width="20" height="1"></td>
	<td width="210">
        <select name="IU_SMSCK" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
		<option value=1 <% If IU_SMSCK = 1 Then response.write "selected" %>>����</option>
		<option value=0 <% If IU_SMSCK = 0 Then response.write "selected" %>>���۱���</option>

		</select>	    
	</td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="2"></td></tr>

<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td bgcolor="#d8d8d8" colspan="7"><img src="../images/sub/blank.gif" border="0" width="1" height="1"></td></tr>
<tr><td colspan="7"><img src="/images/sub/blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td colspan="7" align="right">
	<input class="btn btn-default btn-xs" type="button" value="�������" onClick="location.href='List.asp?page=<%=PAGE%>'" style="border: 1 solid; background-color:#C5BEBD;">
	<input class="btn btn-default btn-xs" type="button" value="���ø���Ʈ" onClick="location.href='/Seller/04_Game1/Betting_List.asp?Search=IB_ID&Find=<%= IU_ID %>'" style="border: 1 solid; background-color:#C5BEBD;">
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
    <td width="33%" ><strong>��&nbsp;��������&nbsp;&nbsp;(<%=FORMATNUMBER(INSUM,0)%> ��)</strong></td>
	<td width="33%"><strong>��&nbsp;ȯ������&nbsp;&nbsp;(<%=FORMATNUMBER(OUTSUM,0)%> ��)</strong></td>
<tr>
    <td><iframe Name="INMONEY" src="inc_inmoney.asp?USERID=<%=IU_ID%>&USERSITE=<%=IU_SITE%>" width="100%" height="350" marginwidth="0" marginheight="0" scrolling="No" frameborder="0"></iframe>
    </td>
	<td><iframe Name="OUTMONEY" src="inc_outmoney.asp?USERID=<%=IU_ID%>&USERSITE=<%=IU_SITE%>" width="100%" height="350" marginwidth="0" marginheight="0" scrolling="No" frameborder="0"></iframe>
	</td>

</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
    <td>
        <iframe src="/Seller/05_Account/Money_AddSub.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LC_ID&Find=<%= IU_ID %>" width="100%" height="300" marginwidth="0" marginheight="0" scrolling="No" frameborder="0"></iframe>
    </td>
    <td>
        <iframe src="/Seller/05_Account/point_list.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LP_ID&Find=<%= IU_ID %>" width="100%" height="300" marginwidth="0" marginheight="0" scrolling="No" frameborder="0"></iframe>
    </td>
</tr>
</table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>