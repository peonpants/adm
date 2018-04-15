<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Response.Charset = "euc-kr"

	Page					= REQUEST("page")
	EditType				= REQUEST("edittype")
	IL_GUID					= REQUEST("IL_GUID")
	ILG_NUM					= REQUEST("ILG_NUM")
	IL_TITLE				= REQUEST("IL_TITLE")
	IL_TITLE				= Replace(IL_TITLE, "'", "&#39;")
	IL_DATE					= REQUEST("IL_DATE")
	IL_DEFAULT_PRIZE_MONEY	= REQUEST("IL_DEFAULT_PRIZE_MONEY")
	IL_ENABLE				= REQUEST("IL_ENABLE")

	If IL_GUID = "" Then
		Response.Write "<script>history.back();</script>"
		Response.End
	End If

	If EditType = "LOTTOMOD" Then	' 로또 수정
		UPDSQL = "UPDATE dbo.INFO_LOTTO SET IL_TITLE = '" & IL_TITLE & "', IL_DATE = '" & IL_DATE & "'"
		UPDSQL = UPDSQL & ", IL_DEFAULT_PRIZE_MONEY = " & IL_DEFAULT_PRIZE_MONEY & ", IL_ENABLE = '" & IL_ENABLE & "' "
		UPDSQL = UPDSQL & "WHERE IL_GUID = '" & IL_GUID & "'"

		DbCon.execute(UPDSQL)
	ElseIf EditType = "GAMECANCEL" Then
		If ILG_NUM = "" Then
			Response.Write "<script>history.back();</script>"
			Response.End
		End If

		UPDSQL = "UPDATE dbo.INFO_LOTTO_GAME SET ILG_SCORE1 = 0, ILG_SCORE2 = 0, ILG_RESULT = NULL, ILG_STATUS = 'C' "
		UPDSQL = UPDSQL & "WHERE IL_GUID = '" & IL_GUID & "' AND ILG_NUM = " & ILG_NUM

		DbCon.execute(UPDSQL)
	End If

	DbCon.Close
	Set DbCon=Nothing
%>
<script>
	location.href="Edit.asp?page=<%=page%>&IL_GUID=<%=IL_GUID%>";
</script>