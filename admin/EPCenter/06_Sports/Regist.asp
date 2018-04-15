<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		var frm = document.frm1;
		
		if (frm.RL_League.value == "" )
		{
			alert("리그명을 입력하세요");
			frm.RL_League.focus();
			return;
		}
	
		frm.submit();
	}
</SCRIPT></head>

<%
	RS_Sports = request("RS_Sports")
	Page = request("Page")
%>

<body topmargin="0" marginheight="0">

<form name="frm1" method="post" action="Regist_Proc.asp" >
<input type="Hidden" name="Process" value="I">
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임리그 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 게임리그 등록</font></b></td></tr></table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>종목명</b></td>
	<td colspan="3"><input type="text" name="RL_League" style="width:400px;border:1px solid #999999;" maxlength="100"></td></tr>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 등 록 " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="reset" value=" 취 소 " onclick="javascript:document.frm1.reset();" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 목 록 "  onclick="window.location='List.asp?page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table></form>

</body>
</html>