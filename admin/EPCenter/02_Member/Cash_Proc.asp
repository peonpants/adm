<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))
	
	Amount = REPLACE(TRIM(REQUEST("Amount")), ",", "")
	CashFlag = TRIM(REQUEST("CashFlag"))
	ProcFlag = REQUEST("ProcFlag")
	IC_CONTENTS1 = REQUEST("IC_CONTENTS1")


	IF ProcFlag = "-" THEN
		Amount1 = ProcFlag & Amount
	ELSE
		Amount1 = Amount
	END IF
	
	IF Cdbl(Amount1) < 0 THEN
		Contents = "관리자차감"
	ELSE
		Contents = "관리자증감"
	END IF


	'// 보유머니 추가/삭제...
	IF CashFlag = "Cash" THEN
		UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash" & ProcFlag & Amount & " WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_Cash, IU_SITE FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
		SET RS = DbCon.Execute(SQLMSG)

		CIU_Cash	= RS(0)
		CIU_SITE	= RS(1)

		RS.Close
		Set RS = Nothing
		
		INSSQL = "Insert into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, IC_CONTENTS1, LC_GTYPE) select top 1 '"
		INSSQL = INSSQL & IU_ID & "', "
		INSSQL = INSSQL & Amount1 & ","
		INSSQL = INSSQL & CIU_Cash & ", '"
		INSSQL = INSSQL & Contents & "', '"& CIU_SITE &"','"&IC_CONTENTS1&"',iu_gtype from info_user where iu_id= '"& IU_ID &"'"
		DbCon.execute(INSSQL)
		
	ELSEIF CashFlag = "GCash" THEN
		UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash" & ProcFlag & Amount & " WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_Cash, IU_SITE FROM INFO_USER WHERE IU_IDX = "& IU_IDX &" "
		SET RS = DbCon.Execute(SQLMSG)

		CIU_Cash	= RS(0)
		CIU_SITE	= RS(1)

		RS.Close
		Set RS = Nothing
		
		INSSQL = "Insert into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) select top 1 '"
		INSSQL = INSSQL & IU_ID & "', "
		INSSQL = INSSQL & Amount1 & ","
		INSSQL = INSSQL & CIU_Cash & ", '"
		INSSQL = INSSQL & Contents & "', '"& CIU_SITE &"',iu_gtype from info_user where iu_id= '"& IU_ID &"'"
		DbCon.execute(INSSQL)
	END IF
	
	DbCon.Close
	Set DbCon=Nothing

	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
%>