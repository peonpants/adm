<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<html>
<head>
    <title>������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />  
</head>
<script type="text/javascript">

function goIns()
{
	
	var frm = document.insertForm;	

	if (frm.ip1.value == "" )
	{
		alert("�����Ǹ� �Է����ּ���.");
		frm.ip1.focus();
		return false;
	}
	else if (frm.ip2.value == "" )
	{
		alert("�����Ǹ� �Է����ּ���.");
		frm.ip2.focus();
		return false;
	}
	else if (frm.ip3.value == "" )
	{
		alert("�����Ǹ� �Է����ּ���.");
		frm.ip3.focus();
		return false;
	}
	else if (frm.ip4.value == "" )
	{
		alert("�����Ǹ� �Է����ּ���.");
		frm.ip4.focus();
		return false;
	}
	
	frm.action = "blockip_proc.asp?mode=add";
	

}

function goDel(idx)
{	
	var frm = document.delForm;
	
    frm.seq.value = idx;
	
	if (!confirm("�����ϸ� �ش�����Ǵ� ������ �Ұ��մϴ�\n�����Ͻðڽ��ϱ�?")) return;	

	frm.action = "blockip_proc.asp";
	

}
</script>
<body>
<table>
	<form name="insertForm"  method="post">
	
	<tr>
		<td>
		<input type="text" name="ip1" size="5" maxlength="3" value="<%=ip1%>" >.
		<input type="text" name="ip2" size="5" maxlength="3" value="<%=ip2%>" >.
		<input type="text" name="ip3" size="5" maxlength="3" value="<%=ip3%>" >.
		<input type="text" name="ip4" size="5" maxlength="3" value="<%=ip4%>" >
		</td>	
		<td><input type="submit" value="�� ��" onClick="goIns();"></td>
		</td>
	</tr>
	</form>
</table>
<br><br><br><br>
<table border="1">
<form name="delForm"  method="post">
<input type="hidden" name="seq"   value="">
<%
		
	SQLMSG = "select IAI_IDX,IAI_IP,IAI_REGDATE from INFO_ADMINIP with(nolock) where IAI_DELYN='N' order by IAI_REGDATE desc "
	SET RS1 = DbCon.Execute(SQLMSG)	

		
		
	If Not RS1.eof Then
		Do Until RS1.eof		

		

%>

	<tr>
		<td><%=rs1("IAI_IP")%>
		</td>
		<td><%=rs1("IAI_REGDATE")%>
		</td>
		<td><input type="submit" value="�� ��" onClick="goDel(<%=rs1("IAI_IDX")%>);">
		</td>
	</tr>	
<%

		RS1.MoveNext
		Loop
	ELSE
%>	
	
<tr>
	<td> ��ϵ� �����ǰ� �����ϴ�.
	</td>
</tr>	

<% END If %>

</form>
</table>
</body>
</html>
