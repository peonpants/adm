<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ����Ʈ ���� �� �θ�                    ################	
   
	EMODE = REQUEST("EMODE")
	IF EMODE = "SB_OPEN1" THEN

		siteOpen = REQUEST("siteOpen")

		Call dfgameSql.UpdateSET_SADARI(dfDBConn.Conn, siteOpen)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('��ٸ� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Live_setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_OPEN2" THEN

		siteOpen = REQUEST("siteOpen")

		Call dfgameSql.UpdateSET_DAL(dfDBConn.Conn, siteOpen)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('������ ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Live_setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_OPEN3" THEN

		siteOpen = REQUEST("siteOpen")

		Call dfgameSql.UpdateSET_ALADIN(dfDBConn.Conn, siteOpen)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('�˶�� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Live_setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

	ELSEIF EMODE = "SB_OPEN4" THEN

		siteOpen = REQUEST("siteOpen")

		Call dfgameSql.UpdateSET_DARI(dfDBConn.Conn, siteOpen)

		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('�ٸ��ٸ� ������ �ٲ�����ϴ�.');" & vbcrlf
			.write "location.href='Live_setting.asp';" & vbcrlf
			.write "</script>"
			.end
		End With

			
	END IF 
	URL = "Live_setting.asp"
	Response.Redirect URL
%>