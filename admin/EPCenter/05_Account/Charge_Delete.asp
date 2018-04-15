<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
	
	
	FOR i = 1 TO TotalCount
		IC_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT * FROM INFO_CHARGE WHERE IC_IDX = "& IC_Idx
		SET RS = DbCon.Execute(SQLMSG)
			IC_STATUS=  RS("IC_STATUS")
			IC_ID =  RS("IC_ID") 
			IC_AMOUNT =   RS("IC_AMOUNT") 

			If IC_STATUS = 1 Then
			SQL1 = "UPDATE INFO_USER SET IU_CASH= IU_CASH - " & IC_AMOUNT & " WHERE IU_ID='" & IC_ID & "'"
			DbCon.execute(SQL1)

				SQLMSG1 = "SELECT TOP 1 LC_IDX FROM LOG_CASHINOUT WHERE LC_ID = '"& IC_ID & "' AND LC_CONTENTS = '머니충전' AND LC_CASH = " & IC_AMOUNT & " ORDER BY LC_REGDATE DESC"
				SET RS = DbCon.Execute(SQLMSG1)
					LC_IDX = RS("LC_IDX")

						SQL1 = "UPDATE LOG_CASHINOUT SET LC_GCASH= LC_GCASH - " & IC_AMOUNT & ", LC_CASH=0, LC_CONTENTS='충전취소' WHERE LC_IDX='" & LC_IDX & "'"
						DbCon.execute(SQL1)

			End if

			SQL1 = "insert Info_Charge_log (IC_IDX, IC_ID, IC_NAME, IC_AMOUNT, IC_REGDATE, IC_SETDATE, IC_STATUS, IC_SITE,IC_KIND,IC_EVENT,IC_T_MONEY,IC_T_YN,IC_DEL,IC_BONUS_AMOUNT) select IC_IDX, IC_ID, IC_NAME, IC_AMOUNT, IC_REGDATE, getdate(), IC_STATUS, IC_SITE,IC_KIND,IC_EVENT,IC_T_MONEY,IC_T_YN,IC_DEL,IC_BONUS_AMOUNT from Info_Charge WHERE IC_Idx ="&IC_Idx 
			DbCon.execute(SQL1)

		'IF CDbl(RS("IC_Status")) <> 1 THEN
			SQL = "Delete Info_Charge WHERE IC_Idx ="&IC_Idx 
			DbCon.execute(SQL)
		'END IF
	
	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('삭제 처리가 완료되었습니다.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>