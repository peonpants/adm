<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page			= REQUEST("Page")
	RL_Idx			= REQUEST("RL_Idx")

	SQLMSG = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, RL_STATUS FROM Ref_League WHERE RL_IDX = '"& RL_Idx &"' "
	SET RS = DbCon.Execute(SQLMSG)

	RL_IDX			= RS(0)
	RL_SPORTS		= RS(1)
	RL_LEAGUE		= RS(2)
	RL_IMAGE		= RS(3)
	IF RL_IMAGE <> "" THEN
	RL_IMAGE = "<img src='/UpFile/League/"& RL_IMAGE &"' style='border:1px solid;'>"
	ELSE
	RL_Image = "<font color=red>등록된 리그 아이콘이 없습니다.</font>"
	END IF
	RL_STATUS		= RS(4)

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		if (frm.RL_League.value == "")
		{
			alert("수정할 리그명을 입력해주세요.");
			frm.RL_League.focus();
			return false;
		}
		
		frm.submit();
	}
</script></head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post" action="Edit_Proc.asp" enctype="multipart/form-data">
<input type="hidden" name="RL_Idx" value="<%=RL_Idx%>">
<input type="hidden" name="Process" value="U">
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임리그 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 게임리그 수정</font></b></td></tr></table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>게임 리그명</b></td>
	<td colspan="3"><input type="text" style="width:200px;border:1px solid;" maxlength="100" name="RL_League" value="<%=RL_League%>"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>리그 아이콘</b></td>
	<td colspan="3"><%=RL_Image%></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap>
	<% IF RL_IMAGE = "" THEN %>
	<b>아이콘 등록</b>
	<% ELSE %>
	<b>아이콘 수정</b>
	<% END IF %></td>
   	<td colspan="3"><input type="file" name="RL_Image" style="width:400px;border:1px solid #999999;"></td></tr></table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 수 정 " onclick="javascript:FrmChk();" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="reset" value=" 취 소 " onclick="javascript:document.frm1.reset();" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 목 록 "  onclick="window.location='List.asp?page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table></form>

</body>
</html>