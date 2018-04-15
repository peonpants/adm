<%@ Codepage=949  Language="VBScript"%>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
 bType = request("bType")
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript" src="Alditor/alditor.js" type="text/javascript"></script>
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function Checkform() {
	var frm = document.frm1;

	if ((frm.BF_Writer.value == "") || (frm.BF_Writer.value.length < 2))
	{
		alert("작성자를 적어주세요.");
		frm.BF_Writer.focus();
		return ;	
	}
	
	if (frm.BF_Title.value == "")
	{
		alert("게시판 제목을 입력해주세요.");
		frm.BF_Title.focus();
		return ;	
	}
	
	if (frm.BF_Contents.value == "")
	{
		alert("게시판 내용을 입력해주세요.");
		frm.BF_Contents.focus();
		return ;	
	}
	

	frm.submit();
}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
<form name="frm1" action="Board_Write_Proc.asp" method="post" >
<input type="Hidden" name="Process" value="I">
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>공지적용</b></td>
	<td colspan="3">
	<select name="level">
	<option value="0">일반</option>
	<option value="1">공지사항</option>
	<option value="2">이 벤 트</option>
	<option value="3">흐르는공지</option>
	</select>
	</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>사이트선택</b></td>
	<td>
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="BF_SITE" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %>
			<input type="radio" name="BF_SITE" value="All" > 전체노출</td></tr>
			<script>
		document.frm1.BF_SITE[0].checked = true;		
			</script>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>글쓴이(아이디)</b></td>
    <td colspan="3"><input type="text" name="BF_Writer" style="width:300px;border:1px solid #999999;" value="관리자" ></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>제&nbsp;&nbsp;목</b></td>
    <td colspan="3"><input type="text" name="BF_Title"  maxlength="100" style="width:300px;border:1px solid #999999;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>등록시간</b></td>
    <td colspan="3"><input type="text" name="BF_REGDATE"  maxlength="50" style="width:300px;border:1px solid #999999;">  2010/01/01 12:21 (2010년 1월 1일 12시 21분) <br>미등록시 현재일로 등록</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>내&nbsp;&nbsp;용</b></td>
    <td colspan="3">
		<textarea name="BF_Contents" style="width:100%; height:500" class=input></textarea></td></tr></table>
<input type="hidden" name="bType" value="<%=bType%>">
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