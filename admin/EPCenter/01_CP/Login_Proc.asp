<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	BIP			=	REQUEST("BIP")
	PAGE		=	REQUEST("PAGE")
	FLAG		=	REQUEST("FLAG")
	sStartDate	=	REQUEST("sStartDate")
	sEndDate	=	REQUEST("sEndDate")
	Search		=	REQUEST("Search")
	Find		=	REQUEST("Find")

	IF FLAG = "NO" THEN
		SQLSTR = "INSERT INTO BLOCK_IP ( BlockIP, BlockDate)"
		SQLSTR = SQLSTR& " VALUES ( '"& BIP &"', getdate())"
		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('선택하신 아이피가 차단되었습니다.');" & vbCrLf
			.Write "location.href='Login_List.asp?page="&PAGE&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="&Search&"&Find="&Find&"';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With

	ELSEIF FLAG = "YES" THEN
		SQLSTR = "DELETE BLOCK_IP WHERE BlockIP = '"& BIP &"'" 

		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('선택하신 아이피가 차단 해제되었습니다.');" & vbCrLf
			.Write "location.href='Login_List.asp?page="&PAGE&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="&Search&"&Find="&Find&"';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With
	END IF

	DbCon.Close
	Set DbCon=Nothing	%>