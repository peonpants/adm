<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<html>
<head>
<title>Eproto Manager</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script language="javascript" src="Alditor/alditor.js" type="text/javascript"></script>
<script src="/Sc/Function.js"></script></head>
<body topmargin="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0">
<tr><td valign="top">
<%

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT * FROM POPOP02 order by p_idx desc", dbCon, 1
		
	nn = RS.RecordCount
	Do While Not rs.eof 
	
	
	    P_IDX		= RS("P_IDX")
	    P_SUB		= RS("P_SUB")
	    P_CONTENTS		= RS("P_CONTENTS")
	    P_WIDTH		= RS("P_WIDTH")
	    P_HEIGHT		= RS("P_HEIGHT")
	    P_TOP		= RS("P_TOP")
	    P_LEFT		= RS("P_LEFT")
	    P_SITE		= RS("P_SITE")
	    P_YN		= RS("P_YN")
	

%>
<script>
function mo<%=P_IDX%>(){
	document.frm<%=P_IDX%>.P_Type.value = "Mo";
	document.frm<%=P_IDX%>.p_contents.value = document.frm<%=P_IDX%>.p_contents_<%=P_IDX%>.value;
	document.frm<%=P_IDX%>.submit();
}
function del<%=P_IDX%>(){
	document.frm<%=P_IDX%>.P_Type.value = "Del";
	document.frm<%=P_IDX%>.submit();
}
function ins<%=P_IDX%>(){
	document.frm<%=P_IDX%>.P_Type.value = "Ins";
	document.frm<%=P_IDX%>.p_contents.value = document.frm<%=P_IDX%>.p_contents_<%=P_IDX%>.value;
	document.frm<%=P_IDX%>.submit();
}
</script>
	<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="900">
	<tr><td height="30" align="center" bgcolor="706E6E"><b><font color="FFFF00"><%=p_site%> 팝업관리</font></td></tr>
	</table>
	<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="900">
	<form name="frm<%=P_IDX%>" method="post" action="Pop_Proc.asp" >
	<input type="hidden" name="P_Type" value="Ins">
	<input type="hidden" name="p_contents" value="Ins">
	<input type="hidden" name="p_idx" value="<%=p_idx%>">
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>번호</b></td><td width="100%" align="center"><b><%=nn%></b></td></tr>
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>사이트선택</b></td>
	<td width="800"><input type="radio" name="p_site" value="All" <%If LCASE(P_SITE) = "all" Then %>checked<% End if%> > 전체노출
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="p_site" value="<%=SITE01%>" <%If site01 = p_site Then %>checked<% End if%>> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td></tr>
	<tr><td colspan="2" >
	<table border="0" cellspacing="0" cellpadding="0" >
	<td align="center" width="100" bgcolor="e7e7e7"><b>팝업 사이즈</b></td>
		<td align="center" width="350">
		가로 <input type="text" name="p_width" value="<%=p_width%>" style="border:1px solid;width:60px;height:16px;text-align:center;" onkeypress="keyCheck();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		세로 <input type="text" name="p_height" value="<%=p_height%>" style="border:1px solid;width:60px;height:16px;text-align:center;" onkeypress="keyCheck();"></td>
		<td align="center" width="100" bgcolor="e7e7e7"><b>팝업 좌표</b></td>
		<td align="center" width="350">
		TOP : <input type="text" name="p_top" value="<%=p_top%>" style="border:1px solid;width:40px;height:16px;text-align:center;" onkeypress="keyCheck();">&nbsp;&nbsp;&nbsp;
		LEFT : <input type="text" name="p_left" value="<%=p_left%>" style="border:1px solid;width:40px;height:16px;text-align:center;" onkeypress="keyCheck();">
		</table>
		</td></tr>
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>팝업제목</b></td>
	<td width="800"><input type="text" value="<%=p_sub%>" style="width:520px;" name="p_sub"></td></tr>
	<tr><td align="center" width="100" bgcolor="e7e7e7"><b>팝업내용</b></td><td width="800">
	<textarea name="p_contents_<%=P_IDX%>" rows="5" style="width:720px; height:400px; overflow:auto;"><%=p_contents%></textarea>
	</td></tr>
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>표시여부</b></td>
	<td width="800">
	<select name="p_yn" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="Y">표시함</option>
		<option value="N">표시안함</option>
	</select>
	<script>
		for (i=0;i < 2 ;i++ ){
			
			if (document.frm<%=P_IDX%>.p_yn.options[i].value == "<%=p_yn%>"){
				document.frm<%=P_IDX%>.p_yn.options[i].selected = true;
			}
		}
		
	</script>
	</td></tr>
	<tr><td colspan="2" width="100%" align="center"><input type="button" onclick="ins<%=p_idx%>();" value="등록" style="border:1 solid; background-color:#C5BEBD;">&nbsp;&nbsp;<input type="button" onclick="mo<%=p_idx%>();" value="수정" style="border:1 solid; background-color:#C5BEBD;">&nbsp;&nbsp;<input type="button" onclick="del<%=p_idx%>();" value="삭제" style="border:1 solid; background-color:#C5BEBD;"></td></tr>
	</form>
	</table>
</body>
</html>
<%
	    nn = nn - 1
	    RS.movenext
	loop
%>
<%
	RS.close
	Set rs = Nothing
	
	DbCon.Close
	Set DbCon=Nothing
%>