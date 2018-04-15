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
<%
    IU_LEVEL            = Trim(dfRequest.Value("IU_LEVEL"))
    IU_SITE            = Trim(dfRequest.Value("IU_SITE"))
    IU_CHARGE            = Trim(dfRequest.Value("IU_CHARGE"))
    

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '######### 총 회원수              ################	

    
    Call dfmemberSql.RetrieveInfo_UserByPhone(dfDBConn.Conn,  IU_LEVEL, IU_SITE, IU_CHARGE)
    strPhone = ""        
    IF dfMemberSql.RsCount <> 0 Then
        For i = 0 to dfMemberSql.RsCount -1
            IF i <> dfMemberSql.RsCount -1 Then
                strPhone = strPhone & dfmemberSql.Rs(i,"IU_MOBILE") & ", "        
            Else
                strPhone = strPhone & dfmemberSql.Rs(i,"IU_MOBILE")
            End IF                
        Next
    End IF
%> 
<script type="text/javascript">

    parent.document.getElementById("phoneNum").value = "<%= strPhone %>" ;
</script>
