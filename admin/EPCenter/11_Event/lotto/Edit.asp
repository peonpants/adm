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
<%
	IL_GUID			= Trim(REQUEST("IL_GUID"))
	page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### �ζ� ������ ������                 ################	
   
	Call dfeventSql.GetINFO_LOTTO(dfDBConn.Conn, IL_GUID)
	IF dfeventSql.RsCount <> 0 THEN
		IL_TITLE				= dfeventSql.Rs(0,"IL_TITLE")
		IL_DEFAULT_PRIZE_MONEY	= Cdbl(dfeventSql.Rs(0,"IL_DEFAULT_PRIZE_MONEY"))
		IL_ACCRUE_BET_MONEY		= Cdbl(dfeventSql.Rs(0,"IL_ACCRUE_BET_MONEY"))
		IL_BASIC_BET_MONEY		= Cdbl(dfeventSql.Rs(0,"IL_BASIC_BET_MONEY"))
		IL_ENABLE				= dfeventSql.Rs(0,"IL_ENABLE")
		IL_DATE					= dfeventSql.Rs(0,"IL_DATE")
		
		IL_DATE2				= FormatDateTime(CDate(IL_DATE), 2) & " " & FormatDateTime(CDate(IL_DATE), 4)

		IL_BET_COUNT			= Int(dfeventSql.Rs(0,"IL_BET_COUNT"))
		IL_REGDATE				= dfeventSql.Rs(0,"IL_REGDATE")
		BET_COUNT				= Int(dfeventSql.Rs(0,"BET_COUNT"))
	End If

	'���ӻ��¿� ���� �ζ� ���� ����
	SQLMSG = "SELECT (SELECT COUNT(IL_GUID) FROM [dbo].[INFO_LOTTO_GAME] WHERE IL_GUID = '" & IL_GUID & "') AS TCNT "
	SQLMSG = SQLMSG & ", (SELECT COUNT([IL_GUID]) FROM [dbo].[INFO_LOTTO_GAME] WHERE IL_GUID = '" & IL_GUID & "' AND ILG_STATUS = 'F' OR ILG_STATUS = 'X') AS FCNT "
	SET RS = DbCon.Execute(SQLMSG)
	TCNT	= RS("TCNT")
	FCNT	= RS("FCNT")
	RS.Close
	Set RS = Nothing
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script language="javascript" src="/js/jquery-1.4.1.min.js"></script>
<script language="javascript" src="/js/func.js"></script>
<script language="javascript">
<!--
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

		return true;
	}

	function goList()
	{
		location.href = "list.asp?page=<%=page%>";
	}

	function cancelGame(num)
	{
		if (confirm("��⸦ ����Ͻðڽ��ϱ�?"))
		{
			location.href = "Edit_Proc.asp?edittype=GAMECANCEL&page=<%=page%>&IL_GUID=<%=IL_GUID%>&ILG_NUM=" + num;
		}
	}

	function openInsertResult(num)
	{
		var openUrl = "Pop_Game_Insert_Result.asp?IL_GUID=<%=IL_GUID%>&ILG_NUM=" + num;
		window.open(openUrl, '','left=400,top=400,width=400,height=300,0,0,0,0');
	}

	function openFakeAdd()
	{
		var openUrl = "Pop_Fake_Add.asp?IL_GUID=<%=IL_GUID%>";
		window.open(openUrl, '','left=400,top=400,width=300,height=200,0,0,0,0');
	}

	function openWinnerList()
	{
		var openUrl = "Pop_Winner_List.asp?IL_GUID=<%=IL_GUID%>";
		window.open(openUrl, '','left=400,top=400,width=400,height=300,0,0,0,0');
	}

	function deleteLotto()
	{
		if (confirm("���� �����Ͻðڽ��ϱ�?\n\n���� �� ����� ���ñݾ��� ��� ��ȯ�˴ϴ�."))
		{
			location.href = "/EPCenter/11_Event/lotto/deleteLotto.asp?IL_GUID=<%=IL_GUID%>";
		}
	}
//-->
</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �ζ� �̺�Ʈ ����</b></td>
</tr>
</table>

<form name="frmInput" method="post" action="Edit_Proc.asp" onsubmit="return checkValue(this);">
<input type="hidden" name="edittype" value="LOTTOMOD" />
<input type="hidden" name="IL_GUID" value="<%=IL_GUID%>" />
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td width="200" bgcolor="e7e7e7" align="center">&nbsp;<b>�� ��</b></td>
	<td width="500"><input type="text" name="IL_TITLE" value="<%=IL_TITLE%>" style="border:1px solid #cacaca;width:180px;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�� ��</b></td>
	<td><input type="text" name="IL_DATE" value="<%=IL_DATE2%>" style="border:1px solid #cacaca;width:180px;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�⺻ ��÷ �ݾ�</b></td>
	<td><input type="text" name="IL_DEFAULT_PRIZE_MONEY" value="<%=IL_DEFAULT_PRIZE_MONEY%>" style="border:1px solid #cacaca;width:180px;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>���� ���� �ݾ�</b></td>
	<td><%=IL_ACCRUE_BET_MONEY%></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>���� Ƚ��</b></td>
	<td><%=BET_COUNT%></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>�⺻ ���� �ݾ�</b></td>
	<td><%=IL_BASIC_BET_MONEY%></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>Ȱ�� ����</b></td>
	<td><select name="IL_ENABLE" style="width:80px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"><option value="0"<%If IL_ENABLE = "0" Then%> selected<%End If%>>��Ȱ��</option><option value="1"<%If IL_ENABLE = "1" Then%> selected<%End If%>>Ȱ��</option></select> </td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>���� ����</b></td>
	<td><%If TCNT = FCNT Then%>����<%Else%>������<%End If%></td></tr>
	</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td>
	<input type="submit" value=" �� �� " style="border:1 solid;">
	&nbsp;<input type="button" value=" �� �� " style="border:1 solid;" onClick="javascript:deleteLotto();">
<%
	If TCNT = FCNT Then	' ��Ⱑ ��� �����ٸ�..
%>
	&nbsp;<input type="button" value=" ��÷�� ���� " style="border:1 solid;" onclick="javascript:openWinnerList();">
	&nbsp;<input type="button" value=" ��¥ ��÷�� �߰� " style="border:1 solid;" onClick="javascript:openFakeAdd();">
<%
	End If
%>
</td></tr>
</table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �ζ� ����</b></td>
</tr>
</table>

<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td width="180" bgcolor="e7e7e7" align="center"><b>�����Ͻ�</b></td>
	<td width="130" bgcolor="e7e7e7" align="center"><b>������</b></td>
	<td width="200" bgcolor="e7e7e7" align="center"><b>���׼���</b></td>
	<td width="90" bgcolor="e7e7e7" align="center"><b>���ӱ���</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>Ȩ����</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>��������</b></td>
	<td width="70" bgcolor="e7e7e7" align="center"><b>��/��/��</b></td>
	<td width="55" bgcolor="e7e7e7" align="center"><b>����</b></td>
	<td width="70" bgcolor="e7e7e7" align="center"><b>���</b></td>
	<td width="65" bgcolor="e7e7e7" align="center">&nbsp;</td>
	<td width="65" bgcolor="e7e7e7" align="center">&nbsp;</td>
	<td width="65" bgcolor="e7e7e7" align="center">&nbsp;</td>
</tr>

<%
	'######### �ζ� ���� ����Ʈ�� ������                 ################	
   
	Call dfeventSql.RetrieveINFO_LOTTO_GAME(dfDBConn.Conn, IL_GUID)
    
	IF dfeventSql.RsCount = 0 THEN
%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="7" height="35">�ζ� ������ �����ϴ�.</td></tr>

<%
	Else

		FOR i = 0 TO dfeventSql.RsCount -1
			ILG_NUM				= dfeventSql.Rs(i,"ILG_NUM")
			RL_SPORTS			= dfeventSql.Rs(i,"RL_SPORTS")
			RL_LEAGUE			= dfeventSql.Rs(i,"RL_LEAGUE")
			ILG_STARTTIME		= dfeventSql.Rs(i,"ILG_STARTTIME")
			ILG_TEAM1			= dfeventSql.Rs(i,"ILG_TEAM1")
			ILG_TEAM2			= dfeventSql.Rs(i,"ILG_TEAM2")
			ILG_HANDICAP		= dfeventSql.Rs(i,"ILG_HANDICAP")
			ILG_RESULT			= dfeventSql.Rs(i,"ILG_RESULT")
			ILG_TYPE			= dfeventSql.Rs(i,"ILG_TYPE")
			strILG_TYPE			= ""
			IF ILG_TYPE	= "0" Then
				strILG_TYPE = "�¹���"
			ElseIf ILG_TYPE = "1" Then
				strILG_TYPE = "�ڵ�ĸ"
			ElseIF ILG_TYPE = "2" Then
				strILG_TYPE = "�������"
			End If
			ILG_STATUS			= Trim(dfeventSql.Rs(i,"ILG_STATUS"))
			ILG_SCORE1			= dfeventSql.Rs(i,"ILG_SCORE1")
			ILG_SCORE2			= dfeventSql.Rs(i,"ILG_SCORE2")
%>
<tr>
	<td><%=ILG_STARTTIME%></td>
	<td><%=RL_SPORTS%></td>
	<td><%=RL_LEAGUE%></td>
	<td><%=strILG_TYPE%></td>
	<td><%=ILG_TEAM1%></td>
	<td><%=ILG_TEAM2%></td>
	<td><%=ILG_HANDICAP%></td>
	<td align="center"><%If ILG_STATUS = "C" Then%>���<%ElseIf ILG_STATUS = "F" Then%>����<%ElseIf ILG_STATUS = "S" Then%>������<%ElseIf ILG_STATUS = "X" Then%>Ư��<%End If%></td>
	<td align="center"><%=ILG_SCORE1%>:<%=ILG_SCORE2%></td>
	<td align="center"><%If ILG_STATUS = "S" Then%><b><a href="javascript:openInsertResult('<%=ILG_NUM%>');">����Է�</a></b><%Else%>&nbsp;<%End If%></td>
	<td align="center"><%If ILG_STATUS = "S" Then%><b><a href="javascript:cancelGame('<%=ILG_NUM%>');">������</a></b><%Else%>&nbsp;<%End If%></td>
	<td align="center"><b>����</b></td>
</tr>
<%
		Next

	End If
%>

</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td width="700"><input type="button" value=" �� �� " onclick="javascript:goList();" style="border:1 solid;"></td></tr></table>



</body>
</html>