<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	'IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))
	
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
		Contents = "����������"
	ELSE
		Contents = "����������"
	END IF


	'// �����Ӵ� �߰�/����...
	IF CashFlag = "Cash" THEN
	
	
		UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash" & ProcFlag & Amount & " WHERE IU_ID = '"& IU_ID &"' "
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_Cash, IU_SITE FROM INFO_USER WHERE IU_ID = '"& IU_ID &"' "
		SET RS = DbCon.Execute(SQLMSG)

		CIU_Cash	= RS(0)
		CIU_SITE	= RS(1)

		RS.Close
		Set RS = Nothing
		
		INSSQL = "Insert into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, IC_CONTENTS1) values( '"
		INSSQL = INSSQL & IU_ID & "', "
		INSSQL = INSSQL & Amount1 & ","
		INSSQL = INSSQL & CIU_Cash & ", '"
		INSSQL = INSSQL & Contents & "', '"& CIU_SITE &"','"&IC_CONTENTS1&"')"
		DbCon.execute(INSSQL)
			
	END IF
	
	DbCon.Close
	Set DbCon=Nothing
	
%>
<script type="text/javascript">
alert("�����Ǿ����ϴ�.");
</script>