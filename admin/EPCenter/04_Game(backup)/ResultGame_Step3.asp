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
<!-- #include virtual="/_Global/smsUtil.Class.asp" -->
<%
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))	
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))

    'IG_IDX		= Trim(dfRequest("IG_IDX"))

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
	Dim dfgameSql1
    Set dfgameSql1 = new gameSql    	
	'######### 게임에 따른 배팅 내역을 불러옴                 ################	    
	Call dfgameSql.ExecGameResultStep2(dfDBConn.Conn,  0, 3)
	
    IF dfgameSql.RsCount = 0 Then
        response.write "<script>alert('적중된 경기가 없습니다.');history.back();</script> "
        response.end
    End IF

    
%>

<html>
<head>
    <title>결과입력</title>
    <link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
    <!--<script src="/Sc/Base.js"></script>-->

</head>
<body marginheight="0" marginwidth="0">
STEP3 - 정산하기 내역 <Br />
<%
    IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1
    totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 5 : 진행중 , 9 : 진행중
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "실패"
        txttotalIBD_RESULT(1) = "성공"
        txttotalIBD_RESULT(2) = "1배처리"
        txttotalIBD_RESULT(3) = "1배처리"
        txttotalIBD_RESULT(9) = "진행중"
       
    For ii = 0 to dfgameSql.RsCount - 1
        IG_IDX = dfgameSql.Rs(ii , "IG_LAST_IGX")
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
        IU_SMSCK   = dfgameSql.Rs(ii , "IU_SMSCK") 
        IA_Percent   = IA_Percent/100
                
       
        '#### 진행 중인지 체크한다.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        
        TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)        
                
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''                
   IF dfgameSql.RsCount-1 > ii Then        
        IF cStr(Trim(IB_IDX)) <> cStr(Trim(dfgameSql(ii+1,"IB_IDX")))  Then        
        
            BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
            BenefitAmount = numdel2(BenefitAmount)            
            
            IF CDbl(TotalBenefit) = 1 Then
                totalIBD_RESULT = 2
            ElseIF CDbl(TotalBenefit) = 0 Then                
                totalIBD_RESULT = 0
            Else                    
                IF CDbl(totalIBD_RESULT) = 9 Then               
                    totalIBD_RESULT = 9 
                Else
                    totalIBD_RESULT = 1 
                End IF                    
            End IF
            
            
            '진행 중인 경기가 아닌 경기 
            IF totalIBD_RESULT <> 9 Then
                '실패 프로세스
                IF totalIBD_RESULT = 0 Then      
                    IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                        RECOM_ID = ""
                        IUL_Recom_Percent = 0 
                    End IF
                                       
                    
                    '총판 지급액
                    IA_CASHBACK = 0
                    'IF cStr(IA_Type) = "2" Then
                    '    IA_CASHBACK = Cdbl(IB_Amount - (IB_CASHBACK + IB_RECOM_CASHBACK)/IA_Percent)
                    'End IF
'사다리 낙첨포인트 지급방지 로직추가
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='실시간')"
SET RSLIST = DbCon.Execute(SQLLIST)
if Not RSLIST.eof then
	IB_CASHBACK = IB_Amount*0
	IB_RECOM_CASHBACK = IB_Amount*0
else
                    '낙첨금 계산                
                    IB_CASHBACK = IB_Amount*IUL_Percent
                    IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent     
end if
	RSLIST.CLOSE
	SET RSLIST = NOTHING

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
                    Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH ,1, IU_NICKNAME)


					errMsg		= dfgameSql1.RsOne("errMsg")
					errCode		= dfgameSql1.RsOne("errCode")	
					
					If CStr(errCode) <> "1000" Then			
						With Response
						.Write "<script>" & vbcrlf
						.Write "alert('"&errMsg&"');" & vbcrlf				
						.Write "history.back();" & vbcrlf
						.Write "</script>"
						.end
						End With	
						response.end	
					End if				


                    
                    response.write IB_Idx & "<font color='blue'>낙첨 - " & IU_NICKNAME & "님 배팅금 : " & IB_Amount & "원 - 낙첨포인트 : "& IB_CASHBACK & "  -추천인("&RECOM_ID&") 지급액 :" & IB_RECOM_CASHBACK & "</font><br>" 
                    
                Else
'사다리 낙첨포인트 지급방지 로직추가
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='실시간')"
SET RSLIST = DbCon.Execute(SQLLIST)
if Not RSLIST.eof then
	IB_CASHBACK = IB_Amount*0
	IB_RECOM_CASHBACK = IB_Amount*0
else
                    '낙첨금 계산                
                    IB_CASHBACK = IB_Amount*IUL_Percent
                    IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent     
end if
	RSLIST.CLOSE
	SET RSLIST = NOTHING

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
                    Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH , 0, IU_NICKNAME)
                    response.write IB_Idx &"<font color='red'>당첨 - " & IU_NICKNAME & "님" & IB_Amount & "원 - 당첨금 : " & BenefitAmount & "</font><Br>"
                    
					errMsg		= dfgameSql1.RsOne("errmsg")
					errCode		= dfgameSql1.RsOne("errCode")	
					
					If CStr(errCode) <> "1000" Then			
						With Response
						.Write "<script>" & vbcrlf
						.Write "alert('"&errMsg&"');" & vbcrlf				
						.Write "history.back();" & vbcrlf
						.Write "</script>"
						.end
						End With	
						response.end	
					End if				
			


                    IF cStr(IU_SMSCK) = "1" AND IB_Amount <> BenefitAmount Then
				        smsMsg =  SITE_NAME & "-" & IU_NICKNAME & "님 적중금 :"  & BenefitAmount & "원"
				        smsVal =  sendSms(IU_MOBILE, smsMsg)	

                    End IF    				                    
                End IF
            End IF
            
            TotalBenefit = 1
            BenefitAmount = 1
            totalIBD_RESULT     = 5                        
            
        End IF
    Else
    
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmount = numdel2(BenefitAmount)            
        
        IF CDbl(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
        ElseIF CDbl(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
        Else                
            IF CDbl(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
            Else
                totalIBD_RESULT = 1 
            End IF                    
        End IF       
                            
    '진행 중인 경기가 아닌 경기 
        IF totalIBD_RESULT <> 9 Then
            '실패 프로세스
            IF totalIBD_RESULT = 0 Then      
                IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                    RECOM_ID = ""
                    IUL_Recom_Percent = 0 
                End IF
                                     
                
                '총판 지급액
                IA_CASHBACK = 0
                IF cStr(IA_Type) = "2" Then
                    IA_CASHBACK = Cdbl(IB_Amount - (IB_CASHBACK + IB_RECOM_CASHBACK)/IA_Percent)
                End IF
'사다리 낙첨포인트 지급방지 로직추가
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='실시간')"
SET RSLIST = DbCon.Execute(SQLLIST)
if Not RSLIST.eof then
	IB_CASHBACK = IB_Amount*0
	IB_RECOM_CASHBACK = IB_Amount*0
else
                    '낙첨금 계산                
                    IB_CASHBACK = IB_Amount*IUL_Percent
                    IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent     
end if
	RSLIST.CLOSE
	SET RSLIST = NOTHING

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''               
                Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH, 1,IU_NICKNAME)

				errMsg		= dfgameSql1.RsOne("errMsg")
					errCode		= dfgameSql1.RsOne("errCode")	
					
					If CStr(errCode) <> "1000" Then			
						With Response
						.Write "<script>" & vbcrlf
						.Write "alert('"&errMsg&"');" & vbcrlf				
						.Write "history.back();" & vbcrlf
						.Write "</script>"
						.end
						End With	
						response.end	
					End if				
		

                response.write IB_Idx &"<font color='blue'>낙첨 - " & IU_NICKNAME & "님 배팅금 : " & IB_Amount & "원 - 낙첨포인트 : "& IB_CASHBACK & "  -추천인("&RECOM_ID&") 지급액 :" & IB_RECOM_CASHBACK & "</font><br>"                
            Else
'사다리 낙첨포인트 지급방지 로직추가
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='실시간')"
SET RSLIST = DbCon.Execute(SQLLIST)
if Not RSLIST.eof then
	IB_CASHBACK = IB_Amount*0
	IB_RECOM_CASHBACK = IB_Amount*0
else
                    '낙첨금 계산                
                    IB_CASHBACK = IB_Amount*IUL_Percent
                    IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent     
end if
	RSLIST.CLOSE
	SET RSLIST = NOTHING

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
                Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH , 0, IU_NICKNAME)
                response.write IB_Idx &"<font color='red'>당첨 - " & IU_NICKNAME & "님" & IB_Amount & "원 - 당첨금 : " & BenefitAmount & "</font><Br>"
                
				errMsg		= dfgameSql1.RsOne("errMsg")
					errCode		= dfgameSql1.RsOne("errCode")	
					
					If CStr(errCode) <> "1000" Then			
						With Response
						.Write "<script>" & vbcrlf
						.Write "alert('"&errMsg&"');" & vbcrlf				
						.Write "history.back();" & vbcrlf
						.Write "</script>"
						.end
						End With	
						response.end	
					End if				
			


                IF cStr(IU_SMSCK) = "1" AND IB_Amount <> BenefitAmount  Then                
			        smsMsg =  SITE_NAME & " -" & IU_NICKNAME & "님 적중금 :"  & BenefitAmount & "원"
			        smsVal =  sendSms(IU_MOBILE, smsMsg)	
		                        
                End IF			        
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
	//var goUrl="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	//top.opener.top.ViewFrm.location.reload();
	//top.window.close();
</script>