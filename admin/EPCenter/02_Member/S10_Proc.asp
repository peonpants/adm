<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))
	ProcFlag = REQUEST("ProcFlag")

	IF ProcFlag = "-" THEN
		
		Contents = "관리자S10차감"
		UPDSQL = "UPDATE INFO_USER SET IU_iS10 = IU_iS10 - 1 WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_iS10, IU_SITE FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
		SET RS = DbCon.Execute(SQLMSG)

		CIU_Cash	= RS(0)
		CIU_SITE	= RS(1)

		RS.Close
		Set RS = Nothing
		
		INSSQL = "Insert into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, IC_CONTENTS1) values( '"
		INSSQL = INSSQL & IU_ID & "', "
		INSSQL = INSSQL & -1 & ","
		INSSQL = INSSQL & CIU_Cash & ", '"
		INSSQL = INSSQL & Contents & "', '"& CIU_SITE &"','"&IC_CONTENTS1&"')"
		DbCon.execute(INSSQL)
	ELSE
		Contents = "관리자S10추가"
		UPDSQL = "UPDATE INFO_USER SET IU_iS10 = IU_iS10 + 1 WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_iS10, IU_SITE FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
		SET RS = DbCon.Execute(SQLMSG)

		CIU_Cash	= RS(0)
		CIU_SITE	= RS(1)

		RS.Close
		Set RS = Nothing
		
		INSSQL = "Insert into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, IC_CONTENTS1) values( '"
		INSSQL = INSSQL & IU_ID & "', "
		INSSQL = INSSQL & 1 & ","
		INSSQL = INSSQL & CIU_Cash & ", '"
		INSSQL = INSSQL & Contents & "', '"& CIU_SITE &"','"&IC_CONTENTS1&"')"
		DbCon.execute(INSSQL)
		
	END IF
	
	
	DbCon.Close
	Set DbCon=Nothing

	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
%>