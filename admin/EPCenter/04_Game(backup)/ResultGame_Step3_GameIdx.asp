<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))	
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))

    IG_IDX		= Trim(dfRequest("IG_IDX"))

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
	Dim dfgameSql1
    Set dfgameSql1 = new gameSql    	
	'######### ���ӿ� ���� ���� ������ �ҷ���                 ################	    
	Call dfgameSql.ExecGameResultStep2(dfDBConn.Conn,  IG_IDX, 3)
	
    IF dfgameSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("���� ������ �������� �ʽ��ϴ�.");    
    top.window.close();      
    </script>
<%
        response.end
    End IF

    
%>

<html>
<head>
    <title>����Է�</title>
    <link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
    <!--<script src="/Sc/Base.js"></script>-->

</head>
<body marginheight="0" marginwidth="0">
STEP3 - �����ϱ� ���� <Br />
<%
    IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1
    totalIBD_RESULT     = 5 '0  : ����, 1  : ����, 2 : ���, 3 : ����Ư�� , 5 : ������ , 9 : ������
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "����"
        txttotalIBD_RESULT(1) = "����"
        txttotalIBD_RESULT(2) = "1��ó��"
        txttotalIBD_RESULT(3) = "1��ó��"
        txttotalIBD_RESULT(9) = "������"
       
    For ii = 0 to dfgameSql.RsCount - 1
        'IG_IDX = dfgameSql.Rs(ii , "IG_IDX")
        IB_IDX      = dfgameSql.Rs(ii , "IB_IDX")
        IB_ID       = dfgameSql.Rs(ii , "IB_ID") 
        IU_SITE     = dfgameSql.Rs(ii , "IU_SITE")         
        IU_CASH     = dfgameSql.Rs(ii , "IU_CASH")         
        IBD_RESULT  = dfgameSql.Rs(ii , "IBD_RESULT") 
        IBD_RESULT_BENEFIT = dfgameSql.Rs(ii , "IBD_RESULT_BENEFIT")   
        IBD_BENEFIT = dfgameSql.Rs(ii , "IBD_BENEFIT")       
        IB_Amount   = dfgameSql.Rs(ii , "IB_AMOUNT")         
        IU_NICKNAME   = dfgameSql.Rs(ii , "IU_NICKNAME") 
        IU_LEVEL   = dfgameSql.Rs(ii , "IU_LEVEL") 
        IU_MOBILE   = dfgameSql.Rs(ii , "IU_MOBILE") 
        RECOM_ID   = dfgameSql.Rs(ii , "RECOM_ID") 
        IUL_Percent   = dfgameSql.Rs(ii , "IUL_Percent") 
        IUL_Recom_Percent   = dfgameSql.Rs(ii , "IUL_Recom_Percent") 
        IA_Type   = dfgameSql.Rs(ii , "IA_Type")         
        IA_Percent   = IA_Percent/100
                
       
        '#### ���� ������ üũ�Ѵ�.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        
        TotalBenefit = TotalBenefit * IBD_RESULT_BENEFIT
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
                
   IF dfgameSql.RsCount-1 > ii Then        
        IF cStr(Trim(IB_IDX)) <> cStr(Trim(dfgameSql(ii+1,"IB_IDX")))  Then        
            IF cInt(TotalBenefit) = 1 Then
                totalIBD_RESULT = 2
            ElseIF cInt(TotalBenefit) = 0 Then                
                totalIBD_RESULT = 0
            Else                    
                IF cInt(totalIBD_RESULT) = 9 Then               
                    totalIBD_RESULT = 9 
                Else
                    totalIBD_RESULT = 1 
                End IF                    
            End IF
            '���� ���� ��Ⱑ �ƴ� ��� 
            IF totalIBD_RESULT <> 9 Then
                '���� ���μ���
                IF totalIBD_RESULT = 0 Then      
                    IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                        RECOM_ID = ""
                        IUL_Recom_Percent = 0 
                    End IF
                    '��÷�� ���                
                    IB_CASHBACK = IB_Amount*IUL_Percent
                    IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent                                            
                    
                    '���� ���޾�
                    IA_CASHBACK = 0
                    'IF cStr(IA_Type) = "2" Then
                    '    IA_CASHBACK = Cdbl(IB_Amount - (IB_CASHBACK + IB_RECOM_CASHBACK)/IA_Percent)
                    'End IF
                    
                    Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH)
                    response.write IG_IDX & "<font color='blue'>��÷ - " & IU_NICKNAME & "�� ���ñ� : " & IB_Amount & "�� - ��÷�� : "& IB_CASHBACK & "  -��õ��("&RECOM_ID&") ���޾� :" & IB_RECOM_CASHBACK & "</font><br>" 
                Else
                    Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH)
                    response.write IG_IDX &"<font color='red'>��÷ - " & IU_NICKNAME & "��" & IB_Amount & "�� - ��÷�� : " & BenefitAmount & "</font><Br>"
                End IF
            End IF
            
            TotalBenefit = 1
            BenefitAmount = 1
            totalIBD_RESULT     = 5                        
            
        End IF
    Else
        IF cInt(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
        ElseIF cInt(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
        Else                
            IF cInt(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
            Else
                totalIBD_RESULT = 1 
            End IF                    
        End IF       
                            
    '���� ���� ��Ⱑ �ƴ� ��� 
        IF totalIBD_RESULT <> 9 Then
            '���� ���μ���
            IF totalIBD_RESULT = 0 Then      
                IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                    RECOM_ID = ""
                    IUL_Recom_Percent = 0 
                End IF
                '��÷�� ���                
                IB_CASHBACK = IB_Amount*IUL_Percent
                IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent                                            
                
                '���� ���޾�
                IA_CASHBACK = 0
                IF cStr(IA_Type) = "2" Then
                    IA_CASHBACK = Cdbl(IB_Amount - (IB_CASHBACK + IB_RECOM_CASHBACK)/IA_Percent)
                End IF
                
                Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH)
                response.write IG_IDX &"<font color='blue'>��÷ - " & IU_NICKNAME & "�� ���ñ� : " & IB_Amount & "�� - ��÷�� : "& IB_CASHBACK & "  -��õ��("&RECOM_ID&") ���޾� :" & IB_RECOM_CASHBACK & "</font><br>"                
            Else
                Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH)
                response.write IG_IDX &"<font color='red'>��÷ - " & IU_NICKNAME & "��" & IB_Amount & "�� - ��÷�� : " & BenefitAmount & "</font><Br>"
            End IF
        End IF
        
        TotalBenefit = 1
        BenefitAmount = 1
        totalIBD_RESULT     = 5   
                                        
    End IF
    
    IB_IDX1 = IB_IDX
Next
%>

</body>
</html>
<script type="text/javascript">
	var goUrl="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	top.opener.top.ViewFrm.location.reload();
	//top.window.close();
</script>