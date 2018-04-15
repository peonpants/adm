<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
	
	
	FOR i = 1 TO TotalCount
		IE_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT IE_ID, IE_Amount, IE_Status FROM INFO_EXCHANGE WHERE IE_IDX = '"& IE_Idx &"' "
		SET RS = DbCon.Execute(SQLMSG)
		
		IF CDbl(RS("IE_Status")) = 1 THEN
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('환전 처리된 정보 입니다.\n다시 한번 확인 주세요.');" & VbCrLf
				RS.Close
				Set RS=Nothing

				DbCon.Close
				Set DbCon=Nothing
				.write "top.ViewFrm.location.reload();" & VbCrLf
				.write "</script>" & VbCrLf
				.end
			End With
			EXIT FOR
		END IF

		'IE_Status를 2(환전대기)로 변경		
		UPDSQL = "UPDATE Info_Exchange SET IE_Status=2 WHERE IE_Idx=" & IE_Idx &""
		DbCon.execute(UPDSQL)
	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('대기 처리가 완료되었습니다.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>