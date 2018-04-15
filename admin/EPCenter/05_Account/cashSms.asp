<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<%
Response.CacheControl	= "no-cache"
Response.Expires		= -1
Response.Buffer			= true
Response.ContentType	="text/html"
Response.CharSet		= "euc-kr"
Response.AddHeader "pragma","no-cache"
%>
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/smsUtil.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%


    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 게임 설정 값 부름                    ################	
    Call dfCpSql.GetInfo_AdminSms(dfDBConn.Conn)
    
    Dim booSmsSend
    IF dfCpSql.RsCount <> 0 Then
        IAS_PHONE = dfCpSql.RsOne("IAS_PHONE")
        IAS_ENABLE =  dfCpSql.RsOne("IAS_ENABLE")
        IAS_IDX =  dfCpSql.RsOne("IAS_IDX")
        IF IAS_ENABLE = 1 Then
            booSmsSend = True
        Else
            booSmsSend = False
        End IF
    Else
        booSmsSend = False
    End IF        
    
    '설정이 되어 있지 않다면 sms를 보내지 않는다.
    IF NOT booSmsSend Then
        response.End
    End IF
    
    TINPUT = 0 
    TOUTPUT = 0 
    IAS_IDX1 = 0
    IAS_IDX2= 0
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLLIST = "SELECT IC_IDX, IC_NAME, IU_NICKNAME , IC_AMOUNT FROM Info_Charge A WITH(NOLOCK) INNER JOIN INFO_USER  B ON B.IU_ID = A.IC_ID  Where IC_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	IF NOT RSLIST.EOF Then
	    TINPUT = 1
	    IAS_IDX1 = RSLIST("IC_IDX")
	    ID = RSLIST("IC_NAME")
	    NAME = RSLIST("IU_NICKNAME")
	    CASH = FormatNumber(RSLIST("IC_AMOUNT"),0)
	    smsMsg = "페이지 확인|충|"
	End IF
	
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	
	SQLLIST = "select IE_IDX, IE_ID, IE_NICKNAME, IE_AMOUNT from Info_Exchange WITH(NOLOCK) Where IE_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	IF NOT RSLIST.EOF Then
	    TOUTPUT = 1
	    IAS_IDX2 = RSLIST("IE_IDX")
	    ID = RSLIST("IE_ID")
	    NAME = RSLIST("IE_NICKNAME")
	    CASH = FormatNumber(RSLIST("IE_AMOUNT"),0)
	    smsMsg = "페이지 확인|환|"
	End IF
		
	NAME = "00000"
	RSLIST.CLOSE
	SET RSLIST = NOTHING	
	
	

    IF (TINPUT > 0 AND cStr(IAS_IDX1) <> cStr(IAS_IDX)) OR (TOUTPUT > 0 AND cStr(IAS_IDX2) <> cStr(IAS_IDX)) THEN
        booSmsSend = True    
    Else        
        booSmsSend = False    
    End IF

    'response.Write IAS_IDX1 & "--" & IAS_IDX
	    
    IF NOT booSmsSend Then response.End
           
    IF request.Cookies("AdminLevel") <> 1 THEN  Response.End
    
	smsMsg = smsMsg & ID & "|" & NAME & "|" & CASH 
    '####### 문자를 보낸다.
    arrPhoneNum = Split(IAS_PHONE,",")
 
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
    Next    
    
    
    '######### 관리자 sms 업데이트함
    IAS_IDX = IAS_IDX1
    IF IAS_IDX1 = 0 Then
        IAS_IDX = IAS_IDX2
    End IF
    SQLLIST = "UPDATE INFO_ADMIN_SMS SET IAS_IDX = " & IAS_IDX
	
	DbCon.Execute(SQLLIST)
	    
%>

