<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
	
	
	FOR i = 1 TO TotalCount
		IE_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT IE_ID, IE_Amount, IE_Status, IE_SITE FROM INFO_EXCHANGE WHERE IE_IDX = '"& IE_Idx &"' "
		SET RS = DbCon.Execute(SQLMSG)
		
		IF CDbl(RS("IE_Status")) = 3 THEN
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('환전 취소된 정보 입니다.\n다시 한번 확인 주세요.');" & VbCrLf
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

		IE_ID = RS("IE_ID")
		IE_Amount = Cdbl(RS("IE_Amount"))
		IE_SITE	= RS("IE_SITE")
		IE_STATUS	= RS("IE_STATUS")

		If IE_STATUS = 1 Then
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('환전완료처리된 내역은 취소가 불가합니다.');" & VbCrLf
				.write "top.ViewFrm.location.reload();" & VbCrLf
				.write "</script>" & VbCrLf
				.end
			End With
		Else
			UPDSQL = "Update Info_Exchange set IE_Status=3, IE_SetDate = getdate() where IE_Idx=" & IE_Idx
			DbCon.execute(UPDSQL)
			
			UPDSQL = "UPDATE Info_User SET IU_CASH = IU_CASH + "& IE_Amount &" WHERE IU_ID = '"& IE_ID &"' AND IU_SITE = '"& IE_SITE &"'"
			DbCon.execute(UPDSQL)

			SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IE_ID & "' AND IU_SITE = '"& IE_SITE &"' "
			SET UMO = DbCon.Execute(SQLMSG)
			CIU_Cash	= UMO(0)
			UMO.Close
			Set UMO = Nothing

			'// Log_CashInOut 에 환전 기록...
			INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) select top 1 '"
			INSSQL = INSSQL & IE_ID & "', "
			INSSQL = INSSQL & IE_Amount & ","
			INSSQL = INSSQL & CIU_Cash & ", N취소환전', '"& IE_SITE &"',iu_gtype from info_user where iu_id= '"& IE_ID &"'"
			DbCon.execute(INSSQL)
		End IF

	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('취소 처리가 완료되었습니다.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>