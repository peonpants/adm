<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%

	IAS_PHONE	 = request("IAS_PHONE")
	IAS_ENABLE  = request("IAS_ENABLE")
	
    IF IAS_PHONE = "" OR IAS_ENABLE = "" Then
%>
    <script type="text/javascript">
    alert("�������� ���ٹٶ��ϴ�.");
    </script>
<%    
        response.End
    End IF

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    	
	'######### ���� ���� �� �θ�                    ################	
    Call dfCpSql.UpdateInfo_AdminSms(dfDBConn.Conn, IAS_PHONE, IAS_ENABLE )
    
%>
    <script type="text/javascript">
    alert("�����Ǿ����ϴ�.");
    location.href = "Sms_Setting.asp"
    </script>