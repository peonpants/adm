<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<!-- #include virtual="/_Global/smsUtil.Class.asp"-->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

</head>
<body topmargin="0" marginheight="0">
<%
    
    phoneNum = Trim(dfRequest("phoneNum"))
	smsMsg = Trim(dfRequest("msg"))
	
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
    Next
%>
<table width="100%">
<tr>
    <td align="left">
    <%= strSmsVal %>
    </td>
</tr>
<tr>
    <td align="center">
    <input type="button" value="������ �������� �̵�" class="input2" onclick="location.href='sendSms.asp'" />
    </td>
</tr>
</table>
</body>
</html> 