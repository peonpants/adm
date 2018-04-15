<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	IG_IDX		= REQUEST("IG_IDX")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")


	SQLMSG = "SELECT *  FROM INFO_GAME WHERE IG_IDX = '"& IG_IDX &"' "

	SET RS = DbCon.Execute(SQLMSG)

	RL_LEAGUE		= RS("RL_LEAGUE")
	IG_STARTTIME	= RS("IG_STARTTIME")
	IG_TEAM1		= RS("IG_TEAM1")
	IG_TEAM2		= RS("IG_TEAM2")
	IG_HANDICAP		= RS("IG_HANDICAP")
	IG_SCORE1		= RS("IG_Score1")
	IG_SCORE2		= RS("IG_Score2")
	IG_STATUS		= RS("IG_STATUS")
	IG_MEMO			= RS("IG_MEMO")
	IG_TYPE			= RS("IG_TYPE")
	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>경기결과수정</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		if (frm.IG_Score1.value == "") {
			alert("홈팀의 스코어를 적어주세요.");
			frm.IG_Score1.focus();
			return false;
		}
		
		if (frm.IG_Score2.value == "") {
			alert("원정팀의 스코어를 적어주세요.");
			frm.IG_Score2.focus();
			return false;
		}
		
		if (!confirm("결과 수정을 하시겠습니까?")) {
			//self.close();
			return;
		}
		else
		
		frm.submit();
	}
</script></head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<form name="frm1" action="Game_Result_Edit_Proc.asp">
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="SRS_Sports" value="<%=SRS_Sports%>">
<input type="hidden" name="SRL_League" value="<%=SRL_League%>">
<input type="hidden" name="SFlag" value="<%=SFlag%>">
<input type="hidden" name="k2_ig_type" value="<%=IG_TYPE%>">

<tr><td width="40%" align="center"><%=RL_League%></td>
	<td align="center" width="60%" height="30"><%=IG_StartTime%></td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr><td align="center" colspan="3">
<%
	If ig_type = "1" Then
		response.write "&nbsp;&nbsp;<strong>핸디캡</strong>"
	ElseIf ig_type = "2" Then
		response.write "&nbsp;&nbsp;<strong>오버언더</strong>"
	Else 
		response.write "&nbsp;&nbsp;<strong>승무패</strong>"
	End if 
%>
</td></tr>
<tr><td align="center">홈 : <%=IG_Team1%></td>
	<td align="center">무</td>
	<td align="center">원정 : <%=IG_Team2%></td></tr><br>
<tr><td align="center" width="33%"><input type="text" name="IG_Score1" value="<%=IG_Score1%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5"></td>
	<td align="center">
	<% if IG_Handicap <> 0 then %>
	<input type="text" name="IG_Handicap" value="<%=IG_Handicap%>" readonly="yes" style="width:40px;border:1px solid;text-align:center;" maxlength="5">
	<% else %>
	<input type="text" name="IG_Handicap" value="<%=IG_Handicap%>" readonly="yes" style="width:40px;border:0px;text-align:center;" maxlength="5">
	<% end if %></td>
	<td align="center" width="33%"><input type="text" name="IG_Score2" value="<%=IG_Score2%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5"></td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr><td align="center">게임공지</td></tr>
<tr><td align="center"><textarea name="IG_Memo" style="width:560px;height:100px;overflow:hidden" class="input"><%=IG_Memo%></textarea></td></tr></table><br>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="button" value="&nbsp;결과수정&nbsp;" style="height:18px;border:1px solid #999999;" onclick="FrmChk();"></td></tr></table></form>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>