<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	IG_IDX		= REQUEST("IG_IDX")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")


	SQLMSG = "SELECT * FROM INFO_GAME WHERE IG_IDX = '"& IG_IDX &"' "
	SET RS = DbCon.Execute(SQLMSG)

	RL_LEAGUE		= RS("RL_LEAGUE")
	IG_STARTTIME	= RS("IG_STARTTIME")
	IG_TEAM1		= RS("IG_TEAM1")
	IG_TEAM2		= RS("IG_TEAM2")
	IG_HANDICAP		= RS("IG_HANDICAP")
	IG_STATUS		= RS("IG_STATUS")
	IG_Score1		= RS("IG_Score1")
	IG_Score2		= RS("IG_Score2")
	IG_Type         = RS("IG_TYPE")

    IF IG_Type = 1 Then
        txtIG_Type  = "�ڵ�ĸ"    
    ElseIF IG_Type = 2 Then
        txtIG_Type  = "����/���"    
    Else
        txtIG_Type  = "�¹���"    
    End IF
    
	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>����Է�</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		if (frm.IG_Score1.value == "") {
			alert("Ȩ���� ���ھ �����ּ���.");
			frm.IG_Score1.focus();
			return false;
		}
		
		if (frm.IG_Score2.value == "") {
			alert("�������� ���ھ �����ּ���.");
			frm.IG_Score2.focus();
			return false;
		}
		
		if (!confirm("<%=IG_TEAM1%> "+frm.IG_Score1.value+" : "+frm.IG_Score2.value+" <%=IG_TEAM2%>\n��� ����� �Ͻðڽ��ϱ�?\nȮ���� �����ø� ����� ��� ���ӸӴϿ� �ݿ��� �˴ϴ�.")) {
			return;
		}
		else
			frm.submit();
		
	}
</script></head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="1" border="0" bgcolor="#AAAAAA">
<form name="frm1" action="Insert_Result_Proc.asp">
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="SRS_Sports" value="<%=SRS_Sports%>">
<input type="hidden" name="SRL_League" value="<%=SRL_League%>">
<input type="hidden" name="SFlag" value="<%=SFlag%>">
<tr height="25" bgcolor="#FFFFFF">
    <td align="center"><b><%= txtIG_Type %></b>-<%=RL_LEAGUE%></td>
	<td colspan="2">&nbsp;<%=IG_STARTTIME%></td>
</tr>
<tr height="25" bgcolor="#FFFFFF">
    <td width="33%"  align="center">Ȩ:<%=IG_TEAM1%></td>
	<td width="33%"  align="center">������</td>
	<td width="33%"  align="center">����:<%=IG_TEAM2%></td>
</tr>
<tr height="25" bgcolor="#FFFFFF">
<td align="center">&nbsp;<input type="text" name="IG_Score1" value="<%=IG_Score1%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td>
	<td align="center"><%=IG_HANDICAP%></td>
	<td align="center">&nbsp;<input type="text" name="IG_Score2" value="<%=IG_Score2%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3">
</td>
</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="" border="0" bgcolor="#AAAAAA">
<tr height="25" bgcolor="#FFFFFF">
    <td align="center">
	    <input type="button" value="�������"       class="input" onclick="FrmChk();">
	    <input type="button" value="���ó�������"   class="input" onclick="FrmChk();">
        <input type="button" value="�����ϱ�"       class="input" onclick="FrmChk();">
	</td>
</tr>
</table>
</form>
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>