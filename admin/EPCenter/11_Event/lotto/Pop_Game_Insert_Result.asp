<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IL_GUID		= REQUEST("IL_GUID")
	ILG_NUM		= REQUEST("ILG_NUM")

	SQLMSG = "SELECT * FROM INFO_LOTTO_GAME WHERE IL_GUID = '" & IL_GUID & "' AND ILG_NUM = " & ILG_NUM
	SET RS = DbCon.Execute(SQLMSG)

	RL_LEAGUE		= RS("RL_LEAGUE")
	ILG_STARTTIME	= RS("ILG_STARTTIME")
	ILG_TEAM1		= RS("ILG_TEAM1")
	ILG_TEAM2		= RS("ILG_TEAM2")
	ILG_HANDICAP	= RS("ILG_HANDICAP")
	ILG_STATUS		= RS("ILG_STATUS")
	ILG_Score1		= RS("ILG_Score1")
	ILG_Score2		= RS("ILG_Score2")
	ILG_TYPE		= RS("ILG_TYPE")

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>결과입력</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		if (frm.ILG_Score1.value == "") {
			alert("홈팀의 스코어를 적어주세요.");
			frm.ILG_Score1.focus();
			return false;
		}
		
		if (frm.ILG_Score2.value == "") {
			alert("원정팀의 스코어를 적어주세요.");
			frm.ILG_Score2.focus();
			return false;
		}
		
		if (!confirm("<%=ILG_TEAM1%> "+frm.ILG_Score1.value+" : "+frm.ILG_Score2.value+" <%=ILG_TEAM2%>\n결과 등록을 하시겠습니까?")) {
			return;
		}
		else
			frm.submit();
		
	}
</script></head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<form name="frm1" action="Pop_Game_Insert_Result_Proc.asp">
<input type="hidden" name="IL_GUID" value="<%=IL_GUID%>">
<input type="hidden" name="ILG_NUM" value="<%=ILG_NUM%>">
<tr><td width="50%" align="center"><%=RL_LEAGUE%></td>
	<td width="50%">&nbsp;<%=ILG_STARTTIME%></td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr><td align="center">홈:<%=ILG_TEAM1%></td>
	<td align="center"><%If ILG_TYPE = "0" Then%>승무패<%ElseIf ILG_TYPE = "1" Then%>핸디캡<%ElseIf ILG_TYPE = "2" Then%>언더/오버<%End If%></td>
	<td align="center">원정:<%=ILG_TEAM2%></td></tr>
<tr><td align="center">&nbsp;<input type="text" name="ILG_Score1" value="<%=ILG_Score1%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td>
	<td align="center"><%=ILG_HANDICAP%></td>
	<td align="center">&nbsp;<input type="text" name="ILG_Score2" value="<%=ILG_Score2%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td></tr></table><br>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="button" value="결과적용" style="height:18px;border:1px solid #999999;" onclick="FrmChk();"></td></tr></table></form>
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>