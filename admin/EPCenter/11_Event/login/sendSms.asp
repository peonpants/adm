<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/smsUtil.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>
<body>
<%
    
    '######### Request Check                    ################	    
    
    reqEL_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("EL_IDX")), 1, 1, 9999999) 
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	

	Call dfeventSql.GetEvent_Login(dfDBConn.Conn,  reqEL_IDX)
    IF dfeventSql.RsCount <> 0 Then
    
        
        EL_CODE = dfeventSql.RsOne("EL_CODE")
        EL_ID = dfeventSql.RsOne("EL_ID")
        EL_PHONE = dfeventSql.RsOne("EL_PHONE")
        
        Call dfeventSql.UpdateEvent_LoginByUsed(dfDBConn.Conn,  reqEL_IDX)
        phoneNum = EL_PHONE
	    smsMsg = "������-�̺�Ʈ��÷ 5000ĳ�� ���� http://news.com �����ڵ�:" & EL_CODE 
    	
        '####### ���ڸ� ������.
        arrPhoneNum = Split(phoneNum,",")
     
        strSmsVal = ""
        For ii = 0 To Ubound(arrPhoneNum)
            memberPhoneNum = Trim(arrPhoneNum(ii))
            IF NOT dfStringUtil.Pattern("MOBILE",memberPhoneNum) Then
                strSmsVal = strSmsVal & "<font color='red'>" & memberPhoneNum  & " ���� �ڵ��� ������ �ƴմϴ�.</font><br>"
            Else
                smsVal =  sendSms(memberPhoneNum, smsMsg)
                
                IF smsVal = "���ۼ���" Then
                    strSmsVal = strSmsVal & "<font color='blue'>" & memberPhoneNum & " �� ���� �����Ͽ����ϴ�.</font><br>"
                Else
                    strSmsVal = strSmsVal & "<font color='red'>" & memberPhoneNum & " �� ���� �����Ͽ����ϴ�.("& smsVal &")</font><br>"
                End IF
            End IF    
            
            response.Write "<br>" & strSmsVal        
        Next
                
    End IF        	

%>
<script type="text/javascript">
//alert("<%= EL_PHONE %>�� �޼����� �߼۵Ǿ����ϴ�.");
//parent.location.reload();
</script>
</body>
</html>