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
	IG_TEAM1BENEFIT	= formatnumber(RS("IG_TEAM1BENEFIT"),2)
	IG_DRAWBENEFIT	= formatnumber(RS("IG_DRAWBENEFIT"),2)
	IG_TEAM2BENEFIT	= formatnumber(RS("IG_TEAM2BENEFIT"),2)
	IG_STATUS		= RS("IG_STATUS")
	IG_MEMO			= RS("IG_MEMO")
    IG_Content      = RS("IG_Content")
	s_year = year(Cdate(IG_STARTTIME))
	s_month =  month(Cdate(IG_STARTTIME))
	s_day =  day(Cdate(IG_STARTTIME))
	s_hour =  hour(Cdate(IG_STARTTIME))
	s_min =  minute(Cdate(IG_STARTTIME))

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>게임수정</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		/*
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
		
		if (!confirm("결과 등록을 하시겠습니까?\n확인을 누르시면 결과가 모든 게임머니에 반영이 됩니다.")) {
			//self.close();
			return;
		}
		else
			frm.submit();
		*/
		
		frm.submit();
	}
</script></head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<form name="frm1" action="Game_Edit_go_Proc.asp">
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="SRS_Sports" value="<%=SRS_Sports%>">
<input type="hidden" name="SRL_League" value="<%=SRL_League%>">
<input type="hidden" name="SFlag" value="<%=SFlag%>">
<tr><td width="40%" align="center"><%=RL_League%></td>
	<td align="center" width="60%" height="30">
	<select name="s_year">
	<% for i=2008 to 2012 %>
	<option value="<%=i%>" <%if i=Cint(s_year) then response.write "selected"%>>&nbsp;<%=i%>&nbsp;</option>
	<% next %></select>년

	<select name="s_month">
	<% for i=1 to 12 %>
	<option value="<%=i%>" <%if i=cint(s_month) then%> selected <%end if%>>&nbsp;<%=i%>&nbsp;</option>
	<%next%></select>월

	<select name="s_day">
	<% for i=1 to 31 %>
	<option value="<%=i%>" <%if i=cint(s_day) then%> selected <%end if%>>&nbsp;<%=i%>&nbsp;</option>
	<%next%>
	</select>일	&nbsp;

	<select name="s_hour">
	<%
		for i=0 to 23
			If i < 10 then
				ii = "0" & i
			Else
				ii = i
			End if	%>
	<option value="<%=ii%>" <%if i=Cint(s_hour) then response.write "selected"%>>&nbsp;<%=ii%>&nbsp;</option>
	<%next%></select>시

	<select name="s_min">
	<%
		for i=0 to 59
			If i < 10 then
				ii = "0" & i
			Else
				ii = i
			End if	%>
	<option value="<%=ii%>" <%if i=Cint(s_min) then response.write "selected"%>>&nbsp;<%=ii%>&nbsp;</option>
	<%next%></select>분</td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr><td align="center">홈: <input type="text" name="IG_Team1" value="<%=IG_Team1%>" ></td>
	<td align="center">무승부</td>
	<td align="center">원정: <input type="text" name="IG_Team2" value="<%=IG_Team2%>" ></td>
	<td align="center">핸디캡/오버언더</td></tr><br>
<tr><td align="center"><input type="text" name="IG_Team1Benefit" value="<%=IG_Team1Benefit%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5"></td>
	<td align="center">
	<% IF IG_Handicap <> "0" THEN %>
	<input type="text" name="IG_DrawBenefit" value="<%=IG_DrawBenefit%>" readonly="yes" style="width:40px;border:0px ;text-align:center;" maxlength="5">
	<% ELSE %>
	<input type="text" name="IG_DrawBenefit" value="<%=IG_DrawBenefit%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5">
	<% END IF %></td>
	<td align="center"><input type="text" name="IG_Team2Benefit" value="<%=IG_Team2Benefit%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5"></td>
	<td align="center">
	<% IF IG_Handicap <> "0" THEN %>
	<input type="text" name="IG_Handicap" value="<%=IG_Handicap%>" style="width:40px;border:1px solid;text-align:center;" maxlength="5">
	<% ELSE %>
	<input type="text" name="IG_Handicap" value="<%=IG_Handicap%>" readonly="yes" style="width:40px;border:0px;text-align:center;" maxlength="5">
	<% END IF %></td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
<td>
    게임공지
</td>
<td align="center">
    <textarea name="IG_Memo" style="width:460px;height:50px;overflow:hidden" class="input"><%=IG_Memo%></textarea>
</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
    <td align="center">게임객관식</td>
    <td align="center">
    <input type="text" name="IG_Content" value="<%=IG_Content%>" class="input" style="width:460px;" />    
</td>
</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="button" value="&nbsp;수&nbsp;정&nbsp;" style="height:18px;border:1px solid #999999;" onclick="FrmChk();">
	<input type="button" value="&nbsp;취&nbsp;소&nbsp;" style="height:18px;border:1px solid #999999;" onclick="window.close();">
	</td></tr></table></form>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>