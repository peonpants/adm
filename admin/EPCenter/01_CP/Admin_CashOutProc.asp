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

'######### 리퀘스트 체크    #############################
reqType = request("type")
reqCash = request("cash")
reqID = request("id")
	
IF reqType = "add"  Then
	'######### 관리자 접속 로그 부름                    ################	
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, request.Cookies("AdminID"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("정상적인 접근 바랍니다.1");
    </script>
<%    
        response.End
    End IF
    
    IA_CASH = dfCpSql.RsOne("IA_CASH") ' 이제까지 환전한 캐쉬 금액
    IA_Percent = dfCpSql.RsOne("IA_Percent")/100 ' 커미션 정보
   IA_Type = dfCpSql.RsOne("IA_Type") ' 1:정산 2:배팅
    outCash = 0
    '######### 해당 사이트 캐쉬 정보를 가져옴                    ################	
    Call dfCpSql.GetAdminTotalCash(dfDBConn.Conn)
    
    IF dfCpSql.RsCount <> 0 Then
        For i = 0 to dfCpSql.RsCount -1 
            IF cStr(IA_Type) = "2" Then
                IF dfCpSql.Rs(i, "lc_contents") = "배팅배당" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "배팅차감" Then
                    tempCash2 = -dfCpSql.Rs(i, "lc_cash")
                End IF
            ElseIF cStr(IA_Type) = "1" Then               
                IF dfCpSql.Rs(i, "lc_contents") = "환전차감" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "머니충전" Then
                    tempCash2 = -dfCpSql.Rs(i, "lc_cash")
                End IF            
            End IF
        Next
        outCash = -(tempCash1 -(tempCash2))
    End IF
    response.Write tempCash1
    response.Write tempCash2
    outCash = (outCash) * IA_Percent
    outCash = outCash - IA_CASH
    
    IF CDbl(reqCash) > CDbl(outCash) Then
%>
    <script type="text/javascript">
        alert("정상적인 접근 바랍니다.2 <%= outCash %> , <%= reqCash %>");
    </script>
<%    
        response.End
    End IF
    

    '######## 관리자 캐쉬 정보업데이트
     Call dfCpSql.UpdateAdminCashInfo(dfDBConn.Conn, reqCash, request.Cookies("AdminID"))
     
    '######## 관리자 환전 로그 생성
    Call dfCpSql.InsertAdminCashLog(dfDBConn.Conn, reqCash, request.Cookies("AdminID"))
%>
    <script type="text/javascript">
        alert("신청되었습니다.");
        parent.location.reload();
    </script>
<%    
        response.End    
ElseIF reqType = "modify"  Then

    '######## 관리자 환전 로그 생성
    Call dfCpSql.UpdateAdminCashLog(dfDBConn.Conn, reqID)
    
%>
    <script type="text/javascript">
        alert("처리되었습니다.");
        parent.location.reload();
    </script>
<%    
        response.End    
                
End IF    
%>    
