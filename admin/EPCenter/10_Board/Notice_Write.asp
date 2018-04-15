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
		var frm = document.frm1;
		
		if ((frm.BN_Title.value == "") || (frm.BN_Title.value.length < 4))
		{
			alert("공지 제목을 입력해주세요.");
			frm.BN_Title.focus();
			return false;
		}
		
		if ((frm.BN_Contents.value == "") || (frm.BN_Contents.value.length < 4))
		{
			alert("공지 내용을 입력해주세요.");
			frm.BN_Contents.focus();
			return false;
		}
		
		frm.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<form name="frm1" method="post" action="Notice_Write_Proc.asp">
<input type="Hidden" name="Process" value="I">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게시판관리</font><font color="ffffff">&nbsp;&nbsp;▶&nbsp;공지사항/이벤트 등록</font></b></td></tr></table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>구분</b></td>
    <td colspan="3">
	<select name="BN_Part">
	<option value="Notice">공지사항</option>
	<option value="Event">이벤트</option></select></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>제목</b></td>
    <td colspan="3"><input type="text" name="BN_Title" style="width:300px;border:1px solid #999999;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>공지내용</b></td>
	<td colspan="3"><textarea name="BN_Contents" style="width:500px;height:200px;border:1px solid #999999;"></textarea></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>고정설정</b></td>
    <td colspan="3">
	<select name="BN_Top">
	<option value="0" >일반공지</option>
	<% for i=1 to 10 %>
	<option value="<%=i%>"><%=i%>단계</option>
	<% next %>
	</select>&nbsp;*&nbsp; 10단계 가장 상위에 노출고정</td></tr></table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 등 록 " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 취소 "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>