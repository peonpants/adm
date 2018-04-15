<!-- #include virtual="/_Global/DBConn.asp" --->

<%
	AdminChk()
	
	page = Trim(Request("page"))
	if page = "" then page = 1
	
	Call dbOpen(db)
    Call rsOpen(rs, "BE_Idx, BE_Title, BE_RegDate, BE_Hits", "Board_Event", "BE_Status=1", "BE_Idx Desc", db)
%>

<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
	<script src="/Sc/Base.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	function go_delete(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				//if (v_cnt == 0)
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0) 
		{ 
			alert("삭제할 정보를 선택해 주세요."); 
			return;
		} 
		
		//alert(v_data);
		
		if (!confirm("정말 삭제하시겠습니까?")) return;		
		form.action = "Event_Delete.asp?page=<%=PAGE%>";
		form.submit();
	}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post">
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
	<tr>
		<td bgcolor="706E6E" style="padding-left:12" height="23">
			<b><font color="FFFF00">게시판 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 이벤트 리스트</font></b>
		</td>
	</tr>
</table>
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
	<tr> 
		<td align="center" height="30" bgcolor="e7e7e7" width="60"><b>선택</b></td>
		<td align="center" height="30" bgcolor="e7e7e7" width="60"><b>No.</b></td>
		<td align="center" height="30" bgcolor="e7e7e7"><b>제목</b></td>
		<td align="center" height="30" bgcolor="e7e7e7" width="100"><b>작성일</b></td>
		<td align="center" height="30" bgcolor="e7e7e7" width="60"><b>조회</b></td>
	</tr>
	<%
		If rs.Eof then
	%>
	<tr><td align="center" colspan="7" height="35">현재 등록된 이벤트가 없습니다.</td></tr>
	<%
		else
			Call PageNation_Setting(30)
			
			i=0
			total = rs.recordcount - (page * rs.PageSize) + rs.PageSize
			Do Until rs.EOF or i = rs.PageSize
				BE_Idx = rs("BE_Idx")
				BE_Title = Checkot(rs("BE_Title"))
				BE_RegDate = left(rs("BE_RegDate"),10)
				BE_Hits = rs("BE_Hits")
	%>
	<tr>
		<td align="center"><input type="checkbox" name="SelUser" value="<%=BE_Idx%>"></td>
		<td align="center"><%=total%></td>
		<td>&nbsp;<a href="Event_View.asp?BE_Idx=<%=BE_Idx%>&page=<%=PAGE%>"><%=BE_Title%></a></td>
		<td align="center"><%=BE_RegDate%></td>
		<td align="center">&nbsp;<%=BE_Hits%></td>
	</tr>
	<%
			total = total - 1
			i = i + 1
			rs.MoveNext
			Loop
		end if
	%>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
		<td align="center" height="30"><%=PageNation(rs, page, Request.ServerVariables("SCRIPT_NAME"), null)%></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="40%"><input type="reset" value="등록"  onclick="javascript:location.href='/EPCenter/08_Board/Event_Write.asp';" style="border: 1 solid; background-color: #C5BEBD;"></td>
		<td align="right" width="40%">
			<input type="reset" value="삭제"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;">
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