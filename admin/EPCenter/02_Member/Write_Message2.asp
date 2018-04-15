<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		frm = document.frm1;
		if (frm.BC_TITLE.value == "") { alert("\n 제목을 입력하세요. \n"); frm.BC_TITLE.focus(); return false; }
		if (frm.BC_CONTENTS.value == "") { alert("\n 내용을 입력하세요. \n"); frm.BC_CONTENTS.focus(); return false; }
		frm.submit();	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<form name="frm1" method="post" action="Message_Proc2.asp">

<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">회원정보</font><font color="ffffff"> &nbsp;&nbsp;▶ 쪽지보내기</font></b></td></tr></table>
<table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>제&nbsp;&nbsp;목</b></td>
   	<td colspan="3">&nbsp;<input name="BC_TITLE" class=box2 style="WIDTH: 580px; HEIGHT: 17px"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>글쓴이</b></td>
   	<td colspan="3">&nbsp;<input name="BC_MANAGER" class=box2 style="WIDTH: 120px; HEIGHT: 17px" value="관리자" readonly></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>받는이</b></td>
   	<td colspan="3">
	parao24 : <input type="Checkbox" name="BC_SITE1" value="parao24" >
	parao24-a : <input type="Checkbox" name="BC_SITE2" value="parao24-a" >
	parao24-b : <input type="Checkbox" name="BC_SITE3" value="parao24-b" >
	parao24-c : <input type="Checkbox" name="BC_SITE4" value="parao24-c" >
	parao24-d : <input type="Checkbox" name="BC_SITE5" value="parao24-d" >
	parao24-e : <input type="Checkbox" name="BC_SITE6" value="parao24-e" >
	</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>내&nbsp;&nbsp;용</b></td>
    <td colspan="3" style="padding:10,10,10,10;"><textarea name="BC_CONTENTS" style="width:580px;height:300px;overflow:hidden" class="box2"></textarea></td>
</tr>
</table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 등 록 " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 취소 "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

</body>
</html>
