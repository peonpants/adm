<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IL_GUID		= REQUEST("IL_GUID")

	SQLMSG = "SELECT ILG_NUM, ISNULL(ILG_RESULT, '') AS ILG_RESULT FROM INFO_LOTTO_GAME WITH(NOLOCK) WHERE IL_GUID = '" & IL_GUID & "' ORDER BY ILG_NUM ASC"
	SET RS = DbCon.Execute(SQLMSG)
	Dim strWinnerSql

	If Not RS.EOF Then
		strWinnerSql = "SELECT IU_ID, ILU_NUM, ILU_BET_DATE FROM dbo.INFO_LOTTO_USER_BETTING WITH(NOLOCK) WHERE IL_GUID = '" & IL_GUID & "' "
		Do While Not RS.EOF
			ILG_NUM		= RS("ILG_NUM")
			ILG_RESULT	= Trim(RS("ILG_RESULT"))
			
			If ILG_RESULT <> "" Then
				strWinnerSql = strWinnerSql & "AND ILU_CHOICE" & ILG_NUM & " = '" & ILG_RESULT & "' "
			End If

			RS.MoveNext
		Loop
		strWinnerSql = strWinnerSql & "ORDER BY ILU_BET_DATE ASC"
	End If
	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>로또 당첨자 보기</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
	<td width="50%" align="center"><b>아이디</b></td>
	<td width="50%" align="center"><b>배팅일시</b></td></tr>
<%
	If strWinnerSql <> "" Then
		Set RS = DbCon.Execute(strWinnerSql)
		If Not RS.Eof Then
			Do While Not RS.Eof
%>
<tr>
	<td width="50%" align="center"><%=RS("IU_ID")%></td>
	<td width="50%" align="center"><%=RS("ILU_BET_DATE")%></td></tr>
<%
				RS.MoveNext
			Loop
		Else
%>
<tr><td align="center" colspan="2">당첨자가 없습니다.</td>
<%
		End If
	Else
%>
<tr><td align="center" colspan="2">당첨자가 없습니다.</td>
<%
	End If
%>
</table>

<br>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center">
	<input type="button" value=" 닫 기 " style="height:18px;border:1px solid #999999;" onclick="javascript:self.close();"></td></tr></table></form>
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>