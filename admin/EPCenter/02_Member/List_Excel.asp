<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))

	SQLR = " INFO_USER WHERE 1=1 And IU_Level <> 9 "

	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And IU_REGDATE Between '"&sStartDate&"' And '"&sEndDate&"'"
	END IF

	IF Search <> "" AND Find <> "" THEN
		SQLR = SQLR &" And "& Search &" LIKE '%"&Find&"%'"
	END IF	
	Search2 = REQUEST("Search2")
	If Search2 <> "" And Search2 <> "All" Then
		SQLR = SQLR &" And IU_SITE LIKE '"&Search2&"'" 
	End If 


	Search6 = Trim(REQUEST("Search6"))
	If Search6 <> "" Then
		SQLR = SQLR &" And  iu_email != 'a@a.com' " 
	End If 

	Search5 = Trim(REQUEST("Search5"))
	If Search5 <> "" Then
		SQLR = SQLR &" And IU_Level = 2" 
	End If 

	Set RS = Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT * FROM "& SQLR &" ORDER BY IU_IDX Desc"
	rs.CursorLocation = 3
	rs.Open SQL, DbCon, 0, 1, &H0001
	TotalSql = SQL
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition", "attachment;filename=ȸ��List.xls" 
%>
<style>
	td{font-size:9pt;}
</style></head>

<body>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frmchk" method="post">
<tr><td align="center" height="30" bgcolor="e7e7e7" width="80"><b>���̵�</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="60"><b>���</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="80"><b>�г���</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="80"><b>����ó</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�̸���</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>��������</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�����Ӵ�</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����Ʈ</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�հ�</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�Ա�</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>���</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>�����</b></td>
	
	<td align="center" height="30" bgcolor="e7e7e7"><b>����Ʈ</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="40"><b>����</b></td></tr>
	<% If rs.eof then  %>
	<tr> 
		<td align="center" colspan="14" height="35">���� ��ϵ� ȸ���� �����ϴ�.</td>
	</tr>
	<%
		Else
		
			Do Until rs.EOF
				IU_Idx = rs("IU_Idx")
				IU_ID = rs("IU_ID")
				IU_PW = rs("IU_PW")
				IU_NickName = Trim(rs("IU_NickName"))
				IU_Mobile = Trim(rs("IU_Mobile"))
				IU_Email = Trim(rs("IU_Email"))

				IU_BANKNAME = Trim(rs("IU_BANKNAME"))
				IU_BANKNUM = Trim(rs("IU_BANKNUM"))
				IU_BANKOWNER = Trim(rs("IU_BANKOWNER"))
		        IU_CHARGE	        = Rs("IU_CHARGE")
		        IU_POINT	        = Rs("IU_POINT")
		        IU_EXCHANGE	    = Rs("IU_EXCHANGE")					

				IU_Cash = Trim(rs("IU_Cash"))
				IU_Level = rs("IU_Level")				'���
				'If IU_Level = 0 Then
					'LevelName = "��ȸ��"
				'ElseIf IU_Level = 1 Then
					'LevelName = "��ȸ��"
				'End If
				
				IU_RegDate = rs("IU_RegDate")			'�����
				IU_Status = Trim(rs("IU_Status"))				'����� ����
				IU_Site	= rs("IU_SITE")
				
				If cStr(IU_Status)  = "1" then
					sIU_Status = "<font color=blue>����</font>"
				elseif cStr(IU_Status) = "0" then	'����ȸ��
					sIU_Status = "<font color=gray>����</font>"
				elseif cStr(IU_Status) = "9" then
					sIU_Status = "<font color=red>Ż��</font>"
				end if
	%>
	<tr bgcolor="#FFFFFF" height="25">
		<td><%=IU_ID%></td>
		<td align="center"><%=IU_PW%></td>
		<td align="center"><%=IU_NickName%></td>
		<td align="center"><%=IU_Mobile%></td>
		<td><%=IU_Email%></td>
		<td><%=IU_BANKNAME%> : <%=IU_BANKNUM%> (������:<%=IU_BANKOWNER%>)</td>
		<td align="right"><%=formatnumber(IU_Cash,0)%></td>
		<td align="right"><%=formatnumber(IU_POINT,0)%></td>
		<td align="right"><%=formatnumber(IU_Cash + IU_POINT,0)%></td>
		<td align="right"><%=formatnumber(IU_CHARGE,0)%></td>
		<td align="right"><%=formatnumber(IU_EXCHANGE,0)%></td>
		<td align="center"><%=left(IU_RegDate,10)%></td>
		<td align="center"><%=IU_Site%></td>
		<td align="center"><%=sIU_Status%></td>
	</tr>
	<%
		total = total - 1
		i = i + 1

		rs.MoveNext
		Loop

		end if
	%>
</table>
</body>
</html>

<%  
    'srs.close
	'Set srs = Nothing
     
	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>