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

'######### ������Ʈ üũ    #############################
reqType = request("type")
reqCash = request("cash")
reqID = request("id")
	
IF reqType = "add"  Then
	'######### ������ ���� �α� �θ�                    ################	
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, request.Cookies("AdminID"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("�������� ���� �ٶ��ϴ�.1");
    </script>
<%    
        response.End
    End IF
    
    IA_CASH = dfCpSql.RsOne("IA_CASH") ' �������� ȯ���� ĳ�� �ݾ�
    IA_Percent = dfCpSql.RsOne("IA_Percent")/100 ' Ŀ�̼� ����
   IA_Type = dfCpSql.RsOne("IA_Type") ' 1:���� 2:����
    outCash = 0
    '######### �ش� ����Ʈ ĳ�� ������ ������                    ################	
    Call dfCpSql.GetAdminTotalCash(dfDBConn.Conn)
    
    IF dfCpSql.RsCount <> 0 Then
        For i = 0 to dfCpSql.RsCount -1 
            IF cStr(IA_Type) = "2" Then
                IF dfCpSql.Rs(i, "lc_contents") = "���ù��" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "��������" Then
                    tempCash2 = -dfCpSql.Rs(i, "lc_cash")
                End IF
            ElseIF cStr(IA_Type) = "1" Then               
                IF dfCpSql.Rs(i, "lc_contents") = "ȯ������" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "�Ӵ�����" Then
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
        alert("�������� ���� �ٶ��ϴ�.2 <%= outCash %> , <%= reqCash %>");
    </script>
<%    
        response.End
    End IF
    

    '######## ������ ĳ�� ����������Ʈ
     Call dfCpSql.UpdateAdminCashInfo(dfDBConn.Conn, reqCash, request.Cookies("AdminID"))
     
    '######## ������ ȯ�� �α� ����
    Call dfCpSql.InsertAdminCashLog(dfDBConn.Conn, reqCash, request.Cookies("AdminID"))
%>
    <script type="text/javascript">
        alert("��û�Ǿ����ϴ�.");
        parent.location.reload();
    </script>
<%    
        response.End    
ElseIF reqType = "modify"  Then

    '######## ������ ȯ�� �α� ����
    Call dfCpSql.UpdateAdminCashLog(dfDBConn.Conn, reqID)
    
%>
    <script type="text/javascript">
        alert("ó���Ǿ����ϴ�.");
        parent.location.reload();
    </script>
<%    
        response.End    
                
End IF    
%>    
