<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<html>
<head>
<title>Eproto Manager</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script src="/Sc/Function.js"></script></head>

<body topmargin="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0">
<tr><td valign="top">

	<%
		SQLMSG = "SELECT FILENAME, FILESIZEX, FILESIZEY, MAP1, MAP2, STATUS FROM POPUP WHERE PSITE = 'parao24' "
		SET RS = DbCon.Execute(SQLMSG)

		FILENAME	= RS(0)
		FILESIZEX	= RS(1)
		FILESIZEY	= RS(2)
		MAP1		= RS(3)
		MAP2		= RS(4)
		STATUS		= CDbl(RS(5))

		RS.Close
		Set RS = Nothing
	%>

	<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="400">
	<form name="frm1" method="post" action="Pop_Edit_Proc.asp" enctype="multipart/form-data">
	<input type="hidden" name="PSITE" value="Truepo">
	<tr><td colspan="2" height="30" align="center" bgcolor="706E6E"><b><font color="FFFF00">팝업관리</font><font color="ffffff">&nbsp;&nbsp;▶  parao24</font></td></tr>
	<tr><td colspan="2" width="100%" align="center">
	<tr><td colspan="2" width="100%" align="center"><img src="/UpFile/PopUp/<%=FILENAME%>" width="<%=FILESIZEX%>" height="<%=FILESIZEY%>"></td></tr>
	<tr><td width="100%" colspan="2" align="center"><input type="file" name="Photo" style="border:1px solid;width:390px;"></td></tr> 
	<tr><td align="center" width="150" bgcolor="e7e7e7"><b>이미지 사이즈</b></td>
		<td align="center" width="250">
		SizeX <input type="text" name="FileSizeX" value="<%=FILESIZEX%>" style="border:1px solid;width:60px;height:16px;text-align:center;" onkeypress="keyCheck();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		SizeY <input type="text" name="FileSizeY" value="<%=FILESIZEY%>" style="border:1px solid;width:60px;height:16px;text-align:center;" onkeypress="keyCheck();"></td></tr>
	<tr><td align="center" width="150" bgcolor="e7e7e7"><b>팝업 좌표</b></td>
		<td align="center" width="250">
		TOP : <input type="text" name="Map1" value="<%=MAP1%>" style="border:1px solid;width:40px;height:16px;text-align:center;" onkeypress="keyCheck();">&nbsp;&nbsp;&nbsp;
		LEFT : <input type="text" name="Map2" value="<%=MAP2%>" style="border:1px solid;width:40px;height:16px;text-align:center;" onkeypress="keyCheck();">
		</td></tr></table>

	<table width="400" border="0" cellspacing="0" cellpadding="1">
	<tr><td width="400" align="right"><input type="submit" value=" UpLoad " style="border:1 solid; background-color:#C5BEBD;"></td></tr></table></form>

	<form name="frm2" method="post" action="Pop_Status_Proc.asp">
	<input type="hidden" name="PSITE" value="Truepo">
	<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="400">
	<tr><td align="center" width="150" bgcolor="e7e7e7"><b>사용상태</b></td>
		<td align="center" width="250">
		<select name="Status" style="border:1px solid;width:80px;height:16px;">
		<option value=0 <% if Status=0 then response.write "selected" %>>사용안함</option>
		<option value=1 <% if Status=1 then response.write "selected" %>>사 용 중</option>
		</select>&nbsp;
		<input type="submit" value=" 변경 " style="border:1 solid; background-color:#C5BEBD;"></td></tr></table></form></td>
	<td width="10"><img src="blank.gif" border="0" width="10" height="1"></td>
	</tr></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>