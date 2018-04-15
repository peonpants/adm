<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	BA_Idx		= REQUEST("BA_Idx")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	SQLMSG = "SELECT * FROM Board_Analysis WHERE BA_Idx = '"& BA_Idx &"' "
	SET RS = DbCon.Execute(SQLMSG)

	BA_Title	= Trim(RS("BA_Title"))
	BA_Writer	= RS("BA_Writer")
	BA_Contents	= RS("BA_Contents")
	BA_RegDate	= Trim(RS("BA_RegDate"))
	BA_Hits		= RS("BA_Hits")

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script>
	function goDelete(idx,pg) {
		location.href="Analysis_Delete.asp?SelUser="+idx+"&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>;
	}
</script></head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">게시판 관리</font><font color="ffffff"> &nbsp;&nbsp;▶ 분석게시판 내용보기</font></b></td></tr></table>

<table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>끌쓴이</b></td>
   	<td colspan="3"><%=BA_Writer%></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>제목</b></td>
   	<td colspan="3"><%=BA_Title%></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>내 용</b></td>
	<td colspan="3" style="padding:10,10,10,10;"><%=BA_Contents%></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>등록일</b></td>
    <td colspan="3"><%=BA_RegDate%></td></tr></table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center">
	<input type="button" value=" 삭 제 " onclick="goDelete(<%=BA_Idx%>);" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
	<input type="reset" value=" 목 록 " onclick="window.location='Analysis_List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>