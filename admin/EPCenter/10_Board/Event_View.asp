<!-- #include virtual="/_Global/DBConn.asp" --->

<%
	AdminChk()
	
	page = Trim(Request("Page"))
	if page = "" then page = 1
	BE_Idx = request("BE_Idx")
	
	Call dbOpen(db)
	Call rsOpen(rs, "*", "Board_Event", "BE_Idx="&BE_Idx, null, db)
		BE_Idx = Trim(rs("BE_Idx"))
		BE_Title = Trim(rs("BE_Title"))
		BE_Contents = rs("BE_Contents")
		BE_RegDate = Trim(rs("BE_RegDate"))
		BE_Hits = rs("BE_Hits")
%>

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
				alert("�̺�Ʈ ������ �Է����ּ���.");
				frm.BE_Title.focus()
				return false;
			}
			
			if ((frm.BE_Contents.value == "") || (frm.BE_Contents.value.length < 4))
			{
				alert("�̺�Ʈ ������ �Է����ּ���.");
				frm.BE_Contents.focus()
				return false;
			}
			
			frm.submit();
		}
	</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post" action="Event_Edit_Proc.asp">
	<input type="hidden" name="BE_Idx" value="<%=BE_Idx%>">
	<input type="hidden" name="Page" value="<%=Page%>">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
	<tr> 
    	<td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">�Խ��� ����</font><font color="ffffff"> &nbsp;&nbsp;�� �̺�Ʈ ���뺸��/����</font></b></td>
	</tr>
</table>
<table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
	<tr>  
   	 	<td bgcolor="e7e7e7" align="center" width="120" nowrap><b>����</b></td>
   	 	<td colspan="3"><input type="text" name="BE_Title" value="<%=BE_Title%>" style="width:500px;"></td>
	</tr>
	<tr> 
		<td bgcolor="e7e7e7" align="center" width="120" nowrap><b>�� ��</b></td>
    	<td colspan="3" style="padding:10,10,10,10;"><textarea name="BE_Contents" style="border:1px solid #999999;width:500px;height:300px;"><%=BE_Contents%></textarea></td>
	</tr>
	<tr>  
    	<td bgcolor="e7e7e7" align="center" width="120" nowrap><b>�����</b></td>
    	<td colspan="3"><%=BE_RegDate%></td>
	</tr>
</table>
<br>
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
    	<td align="center">
		<input type="button" value=" �� �� " onclick="Checkform();" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
		<input type="reset" value=" �� �� " onclick="window.location='Notice_List.asp?page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;"> 
		</td>
	</tr>
</table>
</form>
</body>
</html>

<%
	Call rsClose(rs)
	Call dbClose(db)
%>