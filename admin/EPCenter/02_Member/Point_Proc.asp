<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))
	
	Amount = REPLACE(TRIM(REQUEST("Amount")), ",", "")
	CashFlag = TRIM(REQUEST("CashFlag"))
	ProcFlag = REQUEST("ProcFlag")
	LP_CONTENTS1 = REQUEST("LP_CONTENTS1")


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




    dfDBConn.SetConn = Application("DBConnString")
    dfDBConn.Connect()	
    
    LP_POINT = Amount1
    
    SQL_SP = "UP_insertLOG_POINT"
    LP_POINT = ProcFlag & Amount
    Call dfaccountSql.insertLOG_POINT(dfDBConn.Conn, IU_ID, 1, LP_POINT, Contents, LP_CONTENTS1)

	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
%>