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
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	

	Call dfeventSql.GetEvent_Login(dfDBConn.Conn,  reqEL_IDX)
    IF dfeventSql.RsCount <> 0 Then
    
        
        EL_CODE = dfeventSql.RsOne("EL_CODE")
        EL_ID = dfeventSql.RsOne("EL_ID")
        EL_PHONE = dfeventSql.RsOne("EL_PHONE")
        
        Call dfeventSql.UpdateEvent_LoginByUsed(dfDBConn.Conn,  reqEL_IDX)
        phoneNum = EL_PHONE
	    smsMsg = "말보로-이벤트당첨 5000캐쉬 지급 http://news.com 인증코드:" & EL_CODE 
    	
        '####### 문자를 보낸다.
        arrPhoneNum = Split(phoneNum,",")
     
        strSmsVal = ""
        For ii = 0 To Ubound(arrPhoneNum)
            memberPhoneNum = Trim(arrPhoneNum(ii))
            IF NOT dfStringUtil.Pattern("MOBILE",memberPhoneNum) Then
                strSmsVal = strSmsVal & "<font color='red'>" & memberPhoneNum  & " 번은 핸드폰 형식이 아닙니다.</font><br>"
            Else
                smsVal =  sendSms(memberPhoneNum, smsMsg)
                
                IF smsVal = "전송성공" Then
                    strSmsVal = strSmsVal & "<font color='blue'>" & memberPhoneNum & " 번 전송 성공하였습니다.</font><br>"
                Else
                    strSmsVal = strSmsVal & "<font color='red'>" & memberPhoneNum & " 번 전송 실패하였습니다.("& smsVal &")</font><br>"
                End IF
            End IF    
            
            response.Write "<br>" & strSmsVal        
        Next
                
    End IF        	

%>
<script type="text/javascript">
//alert("<%= EL_PHONE %>에 메세지가 발송되었습니다.");
//parent.location.reload();
</script>
</body>
</html>