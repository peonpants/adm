<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
	
	
	FOR i = 1 TO TotalCount
		IC_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT * FROM INFO_CHARGE WHERE IC_IDX = '"& IC_Idx &"' "
		SET RS = DbCon.Execute(SQLMSG)
		
		IF CDbl(RS("IC_Status")) = 1 THEN
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('입금 처리된 정보입니다.\n다시 한번 확인해 주세요.');" & VbCrLf
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
		
		IC_ID = RS("IC_ID")
		IC_Name = RS("IC_Name")
		IC_Amount = RS("IC_Amount")

		'IC_Status를 2(대기상태)로 변경...
		UPDSQL = "UPDATE Info_Charge SET IC_Status=2 WHERE IC_Idx = "& IC_Idx &""
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