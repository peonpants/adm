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
		
		if (!confirm("<%=IG_TEAM1%> "+frm.IG_Score1.value+" : "+frm.IG_Score2.value+" <%=IG_TEAM2%>\n결과 등록을 하시겠습니까?\n확인을 누르시면 결과가 모든 게임머니에 반영이 됩니다.")) {
			//self.close();
			return;
		}
		else
			frm.submit();
		
	}
</script></head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<form name="frm1" action="Insert_Result_Proc.asp">
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="SRS_Sports" value="<%=SRS_Sports%>">
<input type="hidden" name="SRL_League" value="<%=SRL_League%>">
<input type="hidden" name="SFlag" value="<%=SFlag%>">
<tr><td width="50%" align="center"><%=RL_LEAGUE%></td>
	<td width="50%">&nbsp;<%=IG_STARTTIME%></td></tr></table>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr><td align="center">홈:<%=IG_TEAM1%></td>
	<td align="center">핸디캡</td>
	<td align="center">원정:<%=IG_TEAM2%></td></tr>
<tr><td align="center">&nbsp;<input type="text" name="IG_Score1" value="<%=IG_Score1%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td>
	<td align="center"><%=IG_HANDICAP%></td>
	<td align="center">&nbsp;<input type="text" name="IG_Score2" value="<%=IG_Score2%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td></tr></table><br>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="button" value="결과적용" style="height:18px;border:1px solid #999999;" onclick="FrmChk();"></td></tr></table></form>
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>