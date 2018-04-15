<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	BN_IDX		= REQUEST("BN_Idx")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	SQLMSG = "SELECT * FROM Board_Notice WHERE BN_IDX = '"& BN_IDX &"' "
	SET RS = DbCon.Execute(SQLMSG)

	BN_Title	= Trim(RS("BN_Title"))
	BN_Contents	= RS("BN_Contents")
	BN_RegDate	= Trim(RS("BN_RegDate"))
	BN_Hits		= RS("BN_Hits")
	BN_Top		= RS("BN_Top")

	RS.Close
	Set RS = Nothing
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

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<form name="frm1" method="post" action="Notice_Edit_Proc.asp">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="BN_Idx" value="<%=BN_Idx%>">
<input type="hidden" name="Find" value="<%=Find%>">
<input type="hidden" name="Search" value="<%=Search%>">
<input type="hidden" name="sStartDate" value="<%=sStartDate%>">
<input type="hidden" name="sEndDate" value="<%=sEndDate%>">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">게시판 관리</font><font color="ffffff"> &nbsp;&nbsp;▶ 공지사항 내용보기/수정</font></b></td></tr></table>

<table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>제 목</b></td>
   	<td colspan="3"><input type="text" name="BN_Title" value="<%=BN_Title%>" style="width:300px;border:1px solid #999999;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>내 용</b></td>
    <td colspan="3" style="padding:10,10,10,10;"><textarea name="BN_Contents" style="border:1px solid #999999;width:500px;height:300px;"><%=BN_Contents%></textarea></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>고정설정</b></td>
    <td colspan="3">&nbsp;&nbsp;
	<select name="BN_Top">
	<option value="0" <% if Cint(BN_Top) =0 then response.write "selected"%>>일반공지</option>
	<% for i=1 to 10 %>
	<option value="<%=i%>" <% if Cint(BN_Top) = Cint(i) then response.write "selected"%>><%=i%>단계</option>
	<% next %></select>&nbsp;*&nbsp; 10단계 가장 상위에 노출고정</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>등 록 일</b></td>
    <td colspan="3"><%=BN_RegDate%></td></tr></table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center">
	<input type="button" value=" 수 정 " onclick="Checkform();" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
	<input type="reset" value=" 목 록 " onclick="window.location='Notice_List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>