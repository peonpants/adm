<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IL_GUID		= REQUEST("IL_GUID")
	If IL_GUID = "" Then
		Response.Write "<script>self.close()</script>"
		Response.End
	End If
%>

<html>
<head>
<title>��¥ ��÷�� �Է�</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript" src="/js/func.js"></script>
<script language="javascript">
<!--
	function FrmChk()
	{
		var frm = document.frm1;
		
		if (frm.cnt.value == "") {
			alert("�ο����� �Է��� �ּ���.");
			frm.cnt.focus();
			return false;
		}
		if (!chkNumEngComma(frm.cnt.value))
		{
			alert("�ο����� ���ڸ� �Է��� �ּ���.");
			return false;
		}
		if (parseInt(frm.cnt.value) <= 0)
		{
			alert("�ο����� 0���� ū ���� �Է��� �ּ���.");
			return false;
		}

		return true;
	}
//-->
</script>
</head>

<body marginheight="0" marginwidth="0">
<form name="frm1" action="Pop_Fake_Add_Proc.asp" onSubmit="return FrmChk();">
<input type="hidden" name="IL_GUID" value="<%=IL_GUID%>" />
<table width="100%" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr>
	<td width="30%" align="center"><b>�ο���</b></td>
	<td width="40%" align="center"><input type="text" name="cnt" style="width:40px;border:1px solid;text-align:center;"></td></tr>
</table>
<br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="submit" value="Ȯ��" style="height:18px;border:1px solid #999999;cursor:hand;"></td></tr></table></form>
</body>
</html>