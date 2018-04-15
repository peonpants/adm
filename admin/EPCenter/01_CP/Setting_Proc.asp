<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 게임 설정 값 부름                    ################	
    Call dfCpSql.RetrieveSet_Betting(dfDBConn.Conn)
%>
<%
	EMODE = REQUEST("EMODE")

	IF EMODE = "SB_MODIFY" THEN

		SBCount = REQUEST("SBCount")

		FOR i = 0 TO SBCount

			SB_IDX			= REQUEST("SB_IDX_"&i&"")
			SB_SITE			= REQUEST("SB_SITE_"&i&"")
			SB_BETTINGMIN	= REQUEST("SB_BETTINGMIN_"&i&"")
			SB_BETTINGMAX01 = REQUEST("SB_BETTINGMAX01_"&i&"")
			SB_BENEFITMAX01 = REQUEST("SB_BENEFITMAX01_"&i&"")
			SB_BETTINGMAX02 = REQUEST("SB_BETTINGMAX02_"&i&"")
			SB_BENEFITMAX02 = REQUEST("SB_BENEFITMAX02_"&i&"")

			If Not IsNumeric(SB_BETTINGMIN) or Not IsNumeric(SB_BETTINGMAX01) Or Not IsNumeric(SB_BENEFITMAX01) Or Not IsNumeric(SB_BETTINGMAX02) Or Not IsNumeric(SB_BENEFITMAX02)  Then 
				response.write "<script>alert('숫자를 입력해 주세요.'); history.back(-1);</script>"
				response.end
			End If 
			
            Set dfCpSql1 = new CpSql

            Call dfCpSql1.UpdateSet_Betting(dfDBConn.Conn, SB_IDX, SB_SITE, SB_BETTINGMIN, SB_BETTINGMAX01, SB_BENEFITMAX01, SB_BETTINGMAX02, SB_BENEFITMAX02)

            Set dfCpSql1 = Nothing

		NEXT

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('배팅한도가 수정되었습니다.');" & vbcrlf
			.write "location.href='Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	
	ELSEIF EMODE = "SB_ADD" THEN
	
		SB_Site				=	REQUEST("New_SB_Site")				'사이트명
		SB_BettingMin		=	REQUEST("New_SB_BettingMin")
		SB_BettingMax01		=	REQUEST("New_SB_BettingMax01")		'일회 최소 배팅금액(프로토)
		SB_BenefitMax01		=	REQUEST("New_SB_BenefitMax01")		'일회 최대 배팅금액(프로토)
		SB_BettingMax02		=	REQUEST("New_SB_BettingMax02")		'일회 최소 배팅금액(핸디/오버)
		SB_BenefitMax02		=	REQUEST("New_SB_BenefitMax02")		'일회 최대 배팅금액(핸디/오버)

        Call dfCpSql.InsertSet_Betting(dfDBConn.Conn, SB_SITE, SB_BETTINGMIN, SB_BETTINGMAX01, SB_BENEFITMAX01, SB_BETTINGMAX02, SB_BENEFITMAX02)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('배팅한도 등록이 정상처리 되었습니다.');" & vbcrlf
			.write "location.href='Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_DELETE" THEN

		SB_IDX = REQUEST("SB_IDX")

        Call dfCpSql.DeleteSet_Betting(dfDBConn.Conn, SB_IDX)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('배팅한도가 삭제처리 되었습니다.');" & vbcrlf
			.write "location.href='Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	END IF 
	
	URL = "Setting.asp"
	Response.Redirect URL
%>