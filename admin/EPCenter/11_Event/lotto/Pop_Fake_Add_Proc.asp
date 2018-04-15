<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Response.Charset = "euc-kr"

	IL_GUID		= REQUEST("IL_GUID")
	cnt			= REQUEST("cnt")
	If IL_GUID = "" Or cnt = "" OR IsNumeric(cnt) = False Then
		Response.Write "<script>history.back();</script>"
		Response.End
	End If

	Dim arrRows1, arrRows2, iStart
	SQLMSG = "SELECT ISNULL(MAX(Convert(Int, REPLACE(IU_ID, '관리자', ''))), 0) FROM dbo.INFO_LOTTO_USER_BETTING WHERE IU_ID LIKE '관리자%' AND IL_GUID = '" & IL_GUID & "'"
	arrRows1 = OpenRsGet(SQLMSG)
	If IsArray(arrRows1) Then
		iStart = Int(arrRows1(0, 0))
	End If


	SQLMSG = "SELECT ILG_NUM, ISNULL(ILG_RESULT, '') AS ILG_RESULT FROM INFO_LOTTO_GAME WITH(NOLOCK) WHERE IL_GUID = '" & IL_GUID & "' ORDER BY ILG_NUM ASC"
	arrRows2 = OpenRsGet(SQLMSG)

	Dim strFakeWinnerSql1, strFakeWinnerSql2

	If IsArray(arrRows2) Then
		strFakeWinnerSql1 = "INSERT INTO dbo.INFO_LOTTO_USER_BETTING (IL_GUID, ILU_NUM, IU_ID"
		For i = 0 To UBound(arrRows2, 2)
			ILG_NUM		= arrRows2(0, i)
			ILG_RESULT	= Trim(arrRows2(1, i))
			
			If ILG_RESULT <> "" Then
				strFakeWinnerSql1 = strFakeWinnerSql1 & ", ILU_CHOICE" & ILG_NUM
			End If
		Next
		strFakeWinnerSql1 = strFakeWinnerSql1 & ") VALUES ('" & IL_GUID & "'"

		For i = 0 To UBound(arrRows2, 2)
			ILG_RESULT	= Trim(arrRows2(1, i))
			
			If ILG_RESULT <> "" Then
				strFakeWinnerSql2 = strFakeWinnerSql2 & ", '" & ILG_RESULT & "'"
			End If
		Next
		strFakeWinnerSql2 = strFakeWinnerSql2 & ")"
	End If

	For i = iStart To Int(cnt + iStart) - 1
		DbCon.Execute(strFakeWinnerSql1 & ", 1, '관리자" & (i+1) & "'" & strFakeWinnerSql2)
	Next

	DbCon.Close
	Set DbCon=Nothing


	Dim RsFunction1
	'----------- Recordset Create ------------
	Function OpenRs(rqSQL)
		If rqSQL = "" Then
			Response.End
		End If
			
		Set RsFunction1 = Server.createobject("ADODB.Recordset")
		RsFunction1.Open  rqSQL, DbCon, 1
		'Set Rs = Con.Execute(rqSQL)

			'If Rs.Errors.Count > 0 Then
			'		Set RsErr = Server.Createobject("ADODB.Error")
			'		For Each RsErr In Rs.Errors
			'				Response.Write "<p>SQL 상태 : " & Rs.SQLstate
			'		Next
			'		CloseAll()
			'		Set RsErr = Nothing
			'End If
		OpenRs = RsFunction1
	End Function
	'----------------------------------------

	'----------- Recordset 배열로 출력 !!!   ---
	Function OpenRsGet(rqSQL)
			Dim arrRows2
			If rqSQL = "" Then
				Response.End
			End If
			
			arrRows2 = ""
			OpenRs(rqSQL)
			If Not(RsFunction1.Eof) Then
					arrRows2 = RsFunction1.GetRows
			End IF
			
			RsFunction1.Close
			Set RsFunction1 = Nothing
			
			OpenRsGet = arrRows2
	End Function
	'----------------------------------------
%>
<script language="javascript">
<!--
	alert("입력되었습니다.");
	opener.location.reload();
	self.close();
//-->
</script>