<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SETSIZE = 20
	PGSIZE = 30


	IF REQUEST("PAGE") = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(REQUEST("PAGE")) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END IF


	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " Board_Notice Where 1=1 "

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing


	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And BN_RegDate Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF

	Search = REQUEST("Search")
	Find = REQUEST("Find")
	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF


	SQLLIST = "SELECT COUNT(*) AS TN From "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TN = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing
	

	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END IF


	LISTSQL = " SELECT TOP "&PGSIZE*PAGE&" BN_Idx, BN_Title, BN_RegDate, BN_Hits, BN_Status, BN_Top, BN_Part FROM "& SQLR &" ORDER BY BN_Idx DESC"
	DbRec.Open LISTSQL, DbCon


	IF NOT DbRec.EOF THEN
		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END IF
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
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
		alert("������ ������ ������ �ּ���."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;		
	form.action = "Notice_Delete.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>";
	form.submit();
}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<%=Search%>

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">�Խ��� ����</font><font color="ffffff">&nbsp;&nbsp;�� ��������/�̺�Ʈ ����Ʈ</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Notice_List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---�˻���---</option>
		<option value="BN_Part" <%if Search = "BN_Part" then Response.Write "selected"%>>����</option>
		<option value="BN_Title" <%if Search = "BN_Title" then Response.Write "selected"%>>������</option>
		<option value="BN_CONTENTS" <%if Search = "BN_CONTENTS" then Response.Write "selected"%>>�۳���</option>		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
<form name="frm1" method="post">
<tr><td align="center" height="30" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>No.</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�ۼ���</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>��ȸ</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����</b></td></tr>

<%	IF TN = 0 THEN	%>

<tr><td align="center" colspan="7" height="35">���� ��ϵ� ���������� �����ϴ�.</td></tr>

<%
	ELSE

	DbRec.Move PGSIZE * (PAGE-1)
	FOR i = 1 TO PGSIZE
		IF DbRec.EOF THEN
			EXIT FOR
		END IF

		BN_Idx		= DbRec(0)
		BN_Title	= DbRec(1)
		BN_RegDate	= DbRec(2)
		BN_Hits		= DbRec(3)
		BN_Status	= DbRec(4)
		BN_Top		= DbRec(5)
		IF BN_Top <> 0 THEN
			NType = "<font color= red>����</font>"
		ELSE
			NType = "�Ϲ�"
		END IF

		IF BN_Status = 0 THEN
			ViewType = "����"
		ELSE
			ViewType = "<font color= red>����</font>"
		END IF
		BN_Part		= DbRec(6)	%>

<tr <% IF BN_Status <> "1" THEN Response.Write "bgcolor='#d6f7fd'"%>><td align="center" width="30"><input type="checkbox" name="SelUser" value="<%=BN_Idx%>"></td>
	<td align="center" width="50"><%=NN%></td>
	<td align="center" width="80"><a href="/EPCenter/08_Board/Notice_List.asp?Search=BN_Part&Find=<%=BN_Part%>"><%=BN_Part%></a></td>
	<td>&nbsp;<a href="Notice_View.asp?BN_Idx=<%=BN_Idx%>&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>"><%=BN_Title%></a></td>
	<td align="center" width="150"><%=BN_RegDate%></td>
	<td align="center" width="50"><%=NType%></td>
	<td align="center" width="50"><%=BN_Hits%></td>
	<td align="center" width="50"><%=ViewType%></td></tr>

	<%  NN = NN - 1 
		DbRec.MoveNext
		Next %>
		
	<% END IF %>

</table><br clear="all">

<%	IF TN > 0 THEN	%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><table border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
		
		<%	IF STARTPAGE = 1 THEN
				Response.Write "<td valign=bottom>[���� 10��]<img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			ELSEIF STARTPAGE > SETSIZE THEN
				Response.Write "<td valign=bottom><a href=Notice_List.asp?page="&STARTPAGE-SETSIZE&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&">[���� 10��]</a><img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			END IF %>

			<td valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0" height="20"><tr>
			<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1
		
				IF i > PGCOUNT THEN
					EXIT FOR
				END IF
	
			IF PAGE = i THEN
				Response.Write "<td width=20 bgcolor=#ff0000 align=center><font color=#ffffff size=2><b>"&i&"</b></font></td>"
			ELSE
				Response.Write "<td width=20 align=center valign=bottom><a href=Notice_List.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&">"&i&"</a></td>"
			END IF
			
			NEXT %></tr></table></td>

		<%	IF PGCOUNT < SETSIZE  THEN '���� �������� ������ ��ũ�⺸�� ���ų� ����������Ʈ�� ��ü���������� ������
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1>[���� 10��]</td>"
			ELSEIF i > PGCOUNT THEN
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1>[���� 10��]</td>"
			ELSE
				Response.Write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1><a href=Notice_List.asp?page="&STARTPAGE+SETSIZE&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&">[���� 10��]</a></td>"
			END IF %></tr>
		<tr><td colspan="3"><img src="../images/sub/blank.gif" border="0" width="1" height="10"></td></tr></table></tr></td></table>
<%	END IF	%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%"><input type="reset" value="���"  onclick="javascript:location.href='/EPCenter/08_Board/Notice_Write.asp';" style="border: 1 solid; background-color: #C5BEBD;"></td>
	<td align="right" width="40%"><input type="reset" value="����"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

</body>
</html>

<%
	DbRec.Close
	Set DbRec=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>