<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script language="javascript" src="/js/jquery-1.4.1.min.js"></script>
<script language="javascript" src="/js/func.js"></script>
<script language="javascript">
<!--
	function sel_league(lname, tob, numi)
	{
		if (lname == "")
			document.getElementById(tob).innerHTML = "<select name='RL_League_" + numi + "' style='width:190px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px'></select>";
		else
			$("div#" + tob).load("/EPCenter/11_Event/lotto/sel_league.asp?lname=" + escape(lname) + "&num=" + numi);
	}

	function checkValue(frm)
	{
		if (frm.IL_TITLE.value == "")
		{
			alert("������ �Է��� �ּ���.");
			return false;
		}
		if (frm.IL_DATE.value == "")
		{
			alert("������ �Է��� �ּ���.");
			return false;
		}
		if (frm.IL_DEFAULT_PRIZE_MONEY.value == "")
		{
			alert("�⺻ ��÷ �ݾ��� �Է��� �ּ���.");
			return false;
		}
		if (!chkNumEngComma(frm.IL_DEFAULT_PRIZE_MONEY.value))
		{
			alert("�⺻ ��÷ �ݾ��� ���ڸ� �Է��� �ּ���.");
			return false;
		}
		if (frm.IL_BASIC_BET_MONEY.value == "")
		{
			alert("�⺻ ���� �ݾ��� �Է��� �ּ���.");
			return false;
		}
		if (!chkNumEngComma(frm.IL_BASIC_BET_MONEY.value))
		{
			alert("�⺻ ���� �ݾ��� ���ڸ� �Է��� �ּ���.");
			return false;
		}
		if (parseInt(frm.IL_BASIC_BET_MONEY.value) <= 0)
		{
			alert("�⺻ ���� �ݾ��� �ʹ� �۽��ϴ�.");
			return false;
		}
		
		var emptyCnt = 0;
		var ea = parseInt(frm["input_ea"].value);
		for (var i = 0; i < ea; i++)
		{
			if (frm["ILG_STARTTIME_" + (i+1)].value == "" 
				&& frm["RL_Sports_" + (i+1)].value == "" 
				&& frm["RL_League_" + (i+1)].value == "" 
				&& frm["ILG_TYPE_" + (i+1)].value == "" 
				&& frm["ILG_TEAM1_" + (i+1)].value == "" 
				&& frm["ILG_TEAM2_" + (i+1)].value == "")
			{
				emptyCnt++;
			}
		}

		if (emptyCnt == ea)
		{
			alert("������ �Է��� �ּ���.");
			return false;
		}

		for (var i = 0; i < ea; i++)
		{
			if (frm["ILG_HANDICAP_" + (i+1)].value == "")
			{
				alert("���º�/�ڵ�ĸ/�ջ����� ���� �Է��� �ּ���.\n\n�¹����� ��� ���ºθ� ��Ȱ��ȭ �Ϸ��� 0��\nȰ��ȭ �Ϸ��� 0���� ū ���� �Է��� �ּ���.");
				return false;
				break;
			}
		}

		return true;
	}

	function get_ea(v)	
    {
	    var cnt = parseInt(v);
		for (var i = 1; i <= 10; i++)
		{
			if (i <= cnt)
				document.getElementById("tr" + i.toString()).style.display = "block";
			else
				document.getElementById("tr" + i.toString()).style.display = "none";
		}
    }
//-->
</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �ζ� �̺�Ʈ ���</b></td>
</tr>
</table>

<form name="frmInput" method="post" action="Regist_Proc.asp" onsubmit="return checkValue(this);">
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<%
	SQLMSG = "SELECT ISNULL(MAX(IL_NUM), 0) AS IL_NUM FROM dbo.INFO_LOTTO WITH(NOLOCK)"
	SET RS = DbCon.Execute(SQLMSG)
	IL_NUM = RS("IL_NUM")
	RS.Close
	Set RS = Nothing
%>
<tr><td width="200" bgcolor="e7e7e7" align="center">&nbsp;<b>�ֱ� �ζ� ����</b></td>
	<td width="500"><%If IL_NUM = 0 Then %>����<%Else%><%=IL_NUM%><%End If%></td></tr>
<tr><td width="200" bgcolor="e7e7e7" align="center">&nbsp;<b>�� ��</b></td>
	<td width="500"><input type="text" name="IL_TITLE" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�� ��</b></td>
	<td><input type="text" name="IL_DATE" value="" style="border:1px solid #cacaca;"> <input type="button" value="<%= dfStringUtil.GetStartDate(now()) %>" onclick="frmInput.IL_DATE.value=this.value;" class="input" style="width:120px;" /></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�⺻ ��÷ �ݾ�</b></td>
	<td><input type="text" name="IL_DEFAULT_PRIZE_MONEY" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�⺻ ���� �ݾ�</b></td>
	<td><input type="text" name="IL_BASIC_BET_MONEY" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>Ȱ�� ����</b></td>
	<td><select name="IL_ENABLE" style="width:80px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"><option value="0">��Ȱ��</option><option value="1">Ȱ��</option></select> </td></tr>
	</table>

<div style="height:10px;"></div>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �ζ� ���� ���</b></td>
</tr>
</table>

<table width="1070">
<tr>    
	<td align="right">
	    ��� ���� ����Ʈ ��
		<select name="input_ea" onchange="get_ea(this.value)">
			<option value="1" selected>1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
		</select>
	</td>
  </tr>
</table>

<table width="1070">
	<tr><td><font color="red">���ӱ����� �¹����� ��� "��/��/��"�� ���� 0���� ū ���� �Է��ϸ� ���ºθ� ������ �� �ְ� �����˴ϴ�.(0�� ���� �°� �и� ���� ����)</font></td></tr>
</table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td width="250" bgcolor="e7e7e7" align="center"><b>�����Ͻ�</b></td>
	<td width="130" bgcolor="e7e7e7" align="center"><b>������</b></td>
	<td width="200" bgcolor="e7e7e7" align="center"><b>���׼���</b></td>
	<td width="90" bgcolor="e7e7e7" align="center"><b>���ӱ���</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>Ȩ����</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>��������</b></td>
	<td width="55" bgcolor="e7e7e7" align="center"><b>��/��/��</b></td>
</tr>

<%
	For i = 1 To 10
%>

<tr id="tr<%=i%>" style="display:<%If i = 1 Then%>block;<%Else%>none;<%End If%>"><td><input type="text" name="ILG_STARTTIME_<%=i%>" class="input" /> <input type="button" value="<%= dfStringUtil.GetStartDate(now()) %>" onclick="frmInput.ILG_STARTTIME_<%=i%>.value=this.value;" class="input" style="width:120px;" /></td>
	<td>
		<select name="RL_Sports_<%=i%>" style="width:120px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="javascript:sel_league(this.value, 'divLeague<%=i%>', '<%=i%>');">
			<option value=""></option>
<%
	SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	RSCount = RS.RecordCount

	FOR a =1 TO RSCount
		
		RLS = RS(0)
%>
			<option value="<%=RLS%>"><%=RLS%></option>
<%
		RS.movenext
	NEXT
		
	RS.Close
	Set RS=Nothing
%>
		</select>
	</td>
	<td><div id="divLeague<%=i%>"><select name="RL_League_<%=i%>" style="width:190px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"></div></td>
	<td><select name="ILG_TYPE_<%=i%>" style="width:80px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"><option value=""></option><option value="0">�¹���</option><option value="1">�ڵ�ĸ</option><option value="2">�������</option></select></td>
	<td><input type="text" name="ILG_TEAM1_<%=i%>" value="" style="width:145px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="ILG_TEAM2_<%=i%>" value="" style="width:145px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="ILG_HANDICAP_<%=i%>" value="" style="width:60px;border:1px solid #cacaca;"></td>
</tr>

<%
	Next
%>

</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td width="700"><input type="submit" value=" �� �� " style="border:1 solid;"> <input type="button" value=" �� �� "  onclick="history.back(-1);" style="border:1 solid;"></td></tr></table>
</form>	



</body>
</html>