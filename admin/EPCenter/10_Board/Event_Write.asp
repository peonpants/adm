<!-- # Include virtual="/_Global/DBConn.asp" -->

<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
	<script src="/Sc/Base.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
		function Checkform()
		{
			var frm = document.frm1;
			
			if ((frm.BE_Title.value == "") || (frm.BE_Title.value.length < 4))
			{
				alert("공지 제목을 입력해주세요.");
				frm.BE_Title.focus()
				return false;
			}
			
			if ((frm.BE_Contents.value == "") || (frm.BE_Contents.value.length < 4))
			{
				alert("공지 내용을 입력해주세요.");
				frm.BE_Contents.focus()
				return false;
			}
			
			frm.submit();
		}
	</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post" action="Event_Write_Proc.asp">
	<input type="Hidden" name="Process" value="I">
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
	<tr>
		<td bgcolor="706E6E" style="padding-left:12" height="23">
			<b><font color="FFFF00">게시판관리</font><font color="ffffff">&nbsp;&nbsp;▶&nbsp;이벤트 등록</font></b>
		</td>
	</tr>
</table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
	<tr>
		<td bgcolor="e7e7e7" align="center" width="100" nowrap><b>제목</b></td>
    	<td colspan="3"><input type="text" name="BE_Title" style="width:500px;border:1px solid #999999;"></td>
	</tr>
	<tr>
		<td bgcolor="e7e7e7" align="center" width="100" nowrap><b>이벤트내용</b></td>
    	<td colspan="3"><textarea name="BE_Contents" style="width:500px;height:200px;border:1px solid #999999;"></textarea></td>
	</tr>
</table>
&nbsp;
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center"> 
			<input type="button" value=" 등 록 " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
			<input type="button" value=" 취소 "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;">
		</td>
	</tr>
</table>
</form>
</body>
</html>
