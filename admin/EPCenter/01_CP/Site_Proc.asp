<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ����Ʈ ���� �� �θ�                    ################	
    Call dfCpSql.RetrieveSet_Site(dfDBConn.Conn)
    
	ListCount = dfCpSql.RsCount - 1

	EMODE = REQUEST("EMODE")
	IF EMODE = "SB_MODIFY" THEN

		SBCount = REQUEST("SBCount")

		FOR i = 0 TO SBCount

			SEQ		= REQUEST("SEQ_"&i&"")
			SITE01	= REQUEST("SITE01_"&i&"")
			SITE02	= REQUEST("SITE02_"&i&"")
			SITE03	= REQUEST("SITE03_"&i&"")
			SITE04	= REQUEST("SITE04_"&i&"")
			SITE05	= REQUEST("SITE05_"&i&"")
			SITE06	= REQUEST("SITE06_"&i&"")
			SITE07	= REQUEST("SITE07_"&i&"")

            Set dfCpSql1 = new CpSql

            Call dfCpSql1.updateSet_Site(dfDBConn.Conn, SITE01, SITE02, SITE03, SITE04, SITE05, SITE06, SITE07, SEQ)
            Set dfCpSql1 = Nothing

		NEXT

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('����Ʈ ������ �����Ǿ����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	
	ELSEIF EMODE = "SB_ADD" THEN
	
		SITE01		=	REQUEST("SITE01")
		SITE02		=	REQUEST("SITE02")
		SITE03		=	REQUEST("SITE03")
		SITE04		=	REQUEST("SITE04")
		SITE05		=	REQUEST("SITE05")
		SITE06		=	REQUEST("SITE06")
		SITE07		=	REQUEST("SITE07")

		Call dfCpSql.InsertSet_Site(dfDBConn.Conn, SITE01, SITE02, SITE03, SITE04, SITE05, SITE06, SITE07)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('����Ʈ ����� ����ó�� �Ǿ����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_DELETE" THEN

		SEQ = REQUEST("SEQ")

		Call dfCpSql.deleteSet_Site(dfDBConn.Conn, SEQ)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('����Ʈ ������ ����ó�� �Ǿ����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_OPEN" THEN

		siteOpen = REQUEST("siteOpen")

		Call dfCpSql.UpdateSET_SITE_OPEN(dfDBConn.Conn, siteOpen)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('����Ʈ ����� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

    ELSEIF EMODE = "DOMAIN" THEN

		ID_NAME = REQUEST("ID_NAME")
		ID_URL = REQUEST("ID_URL")
		ID_USE = REQUEST("ID_USE")

		Call dfCpSql.UpdateINFO_DOMAIN(dfDBConn.Conn, ID_NAME, ID_URL, ID_USE)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('������ ���� �˸� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

    ELSEIF EMODE = "SITE_LEVEL" THEN

		IUL_LEVEL = REQUEST("IUL_LEVEL")
		IUL_Percent = REQUEST("IUL_Percent")/100
		IUL_Percent_live = REQUEST("IUL_Percent_live")/100
		IUL_Recom_Percent = REQUEST("IUL_Recom_Percent")/100
		IUL_Recom_Percent_live = REQUEST("IUL_Recom_Percent_live")/100
		IUL_BPercent = REQUEST("IUL_BPercent")/100
		IUL_BPercent_live = REQUEST("IUL_BPercent_live")/100
		IUL_Recom_BPercent = REQUEST("IUL_Recom_BPercent")/100
		IUL_Recom_BPercent_live = REQUEST("IUL_Recom_BPercent_live")/100
		IUL_Charge_Percent = REQUEST("IUL_Charge_Percent")/100
		IUL_BETTINGMIN = REQUEST("IUL_BETTINGMIN")
		IUL_BETTINGMAX = REQUEST("IUL_BETTINGMAX")
		IUL_BENEFITMAX = REQUEST("IUL_BENEFITMAX")
		IUL_BETTING_ONE_MIN = REQUEST("IUL_BETTING_ONE_MIN")
        
		Call dfCpSql.UpdateINFO_USER_LEVEL(dfDBConn.Conn, IUL_LEVEL, IUL_Percent, IUL_Percent_live, IUL_Recom_Percent, IUL_Recom_Percent_live, IUL_BPercent, IUL_BPercent_live, IUL_Recom_BPercent, IUL_Recom_BPercent_live, IUL_Charge_Percent, IUL_BETTINGMIN, IUL_BETTINGMAX, IUL_BENEFITMAX, IUL_BETTING_ONE_MIN)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('ȸ���� ���� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With
		
        
    ELSEIF EMODE = "UCC" THEN

		SITE_UCC = REQUEST("SITE_UCC")


		Call dfCpSql.UpdateINFO_SITE_UCC(dfDBConn.Conn, SITE_UCC)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('������ ��ũ�� �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With		
    ELSEIF EMODE = "EXCHANGE" THEN

		siteExchange = REQUEST("siteExchange")


		Call dfCpSql.UpdateSET_SITE_EXCHANGE(dfDBConn.Conn, siteExchange)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('ȯ�� SMS ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With			
	ELSEIF EMODE = "7M" THEN

		int7M_USE = REQUEST("7M_USE")

		Call dfCpSql.UpdateSET_7M_USE(dfDBConn.Conn, int7M_USE)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('7M ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	ELSEIF EMODE = "EXCHANGE2" THEN

		EXCHANGE_USE = REQUEST("EXCHANGE_USE")

		Call dfCpSql.UpdateEXCHANGE_USE(dfDBConn.Conn, EXCHANGE_USE)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('ȯ�������� �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	ELSEIF EMODE = "CAUTO" THEN

		intCHAT_USE = REQUEST("CHAT_USE")

		Call dfCpSql.UpdateSET_CHAT_USE(dfDBConn.Conn, intCHAT_USE)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('�����ڵ� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	 		
	ELSEIF EMODE = "MAXAUTO" THEN

		S_CNT = REQUEST("S_CNT")
		P_CNT = REQUEST("P_CNT")
		H_CNT = REQUEST("H_CNT")
		L_CNT = REQUEST("L_CNT")
		A_CNT = REQUEST("A_CNT")
		D_CNT = REQUEST("D_CNT")		
		R_CNT = REQUEST("R_CNT")
		V_CNT = REQUEST("V_CNT")
		M_CNT = REQUEST("M_CNT")
		Call dfCpSql.UpdateSET_BET_MAX(dfDBConn.Conn, S_CNT,P_CNT,H_CNT,L_CNT,A_CNT,D_CNT,R_CNT,V_CNT,M_CNT,Request.Cookies("AdminID"))

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('���� ���� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With	
	
	ELSEIF EMODE = "SITE_JACKPOT" THEN

		IJ_CASH = REQUEST("IJ_CASH")
		IJ_PERCENT = REQUEST("IJ_PERCENT")

		Call dfCpSql.UpdateSITE_JACKPOT(dfDBConn.Conn, IJ_CASH, IJ_PERCENT)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('7M ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Site_Setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With		
	END IF 
	
	URL = "Site_Setting.asp"
	Response.Redirect URL
%>