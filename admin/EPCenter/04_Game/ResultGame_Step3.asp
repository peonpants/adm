<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/smsUtil.Class.asp" -->
<%
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))	
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))

    'IG_IDX		= Trim(dfRequest("IG_IDX"))

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
	Dim dfgameSql1
    Set dfgameSql1 = new gameSql    	
	'######### ���ӿ� ���� ���� ������ �ҷ���                 ################	    
	Call dfgameSql.ExecGameResultStep2(dfDBConn.Conn,  0, 3)
	
    IF dfgameSql.RsCount = 0 Then
        response.write "<script>alert('���ߵ� ��Ⱑ �����ϴ�.');history.back();</script> "
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
        IUL_Percent_live   = dfgameSql.Rs(ii , "IUL_Percent_live")
        IUL_Recom_Percent   = dfgameSql.Rs(ii , "IUL_Recom_Percent") 
        IUL_Recom_Percent_live   = dfgameSql.Rs(ii , "IUL_Recom_Percent_live")
		'��õ�ο� ���� ��÷�����޴�� �Ѹ����� ���� �߰���(Ŭ����) ����
        IUL_BPercent   = dfgameSql.Rs(ii , "IUL_BPercent") 
        IUL_BPercent_live   = dfgameSql.Rs(ii , "IUL_BPercent_live")
        IUL_Recom_BPercent   = dfgameSql.Rs(ii , "IUL_Recom_BPercent") 
        IUL_Recom_BPercent_live   = dfgameSql.Rs(ii , "IUL_Recom_BPercent_live")
		'��õ�ο� ���� ��÷�����޴�� �Ѹ����� ���� �߰���(Ŭ����) ��
        IA_Type   = dfgameSql.Rs(ii , "IA_Type")         
        IU_SMSCK   = dfgameSql.Rs(ii , "IU_SMSCK") 
        IA_Percent   = IA_Percent/100
                
       
        '#### ���� ������ üũ�Ѵ�.
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
            
            
            '���� ���� ��Ⱑ �ƴ� ��� 
            IF totalIBD_RESULT <> 9 Then
                '���� ���μ���
                IF totalIBD_RESULT = 0 Then      
                    IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                        RECOM_ID = ""
                        IUL_Recom_Percent = 0 
                    End IF
                                       
                    
                    '���� ���޾�
                    IA_CASHBACK = 0

'��ٸ� ��÷����Ʈ ���޹��� �����߰�
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
SET RSLIST = DbCon.Execute(SQLLIST)
	if Not RSLIST.eof then
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent_live
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent_live
			End IF
			RSLIST.CLOSE
			SET RSLIST = NOTHING
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent
			End IF
			RSLIST.CLOSE
			SET RSLIST = NOTHING
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

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


                    
                    response.write IB_Idx & "<font color='blue'>a��÷ - " & IU_NICKNAME & "�� ���ñ� : " & IB_Amount & "�� - ��÷����Ʈ : "& IB_CASHBACK & "  -��õ��("&RECOM_ID&") ���޾� :" & IB_RECOM_CASHBACK & "</font><br>" 


''''''''''''''''''''''''''''''''''''��������޽���(17-02-18)
		If totalIBD_RESULT <> 3 And totalIBD_RESULT <> 2 THEN
		SQLLIST = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & RECOM_ID & "' and IA_TYPE = 2;"
		SET RSLIST = DbCon.Execute(SQLLIST)

			if Not RSLIST.eof Then
		
				ia_sportspercent = RSLIST("ia_sportspercent")
				ia_livepercent = RSLIST("ia_livepercent")
				ia_site = RSLIST("ia_site")
				ia_level = RSLIST("ia_level")
				ia_gcash = RSLIST("ia_cash")
				site = Left(Right(ia_site,4),2)
				If ia_level = 3 then				'�����϶� �������縦 �˻��ؼ� �������簡 ������� ������� ������ �����Ѵ�
						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100) * CDbl(ia_livepercent)
								LC_CONTENT = "���ǽǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & " WHERE IA_ID = '" & RECOM_ID & "';"
							Else

								IA_CASH = (IB_Amount /100) * CDbl(ia_sportspercent)
								LC_CONTENT = "���ǽ������Ѹ� " & CDbl(ia_sportspercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, RECOM_ID, IA_CASH, IA_GCASH, 3, LC_CONTENT, IB_IDX)
						ia_cash=0

						''''''''''''''''''''���絵 �־���� �Ǵ� ������ �ۼ��������� �����´� ���簡 ������ �н�, ���簡 ���������̾ �н�
						SQLLIST11 = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & site & "admin' and IA_TYPE = 2;"
						SET RSLIST11 = DbCon.Execute(SQLLIST11)

								if Not RSLIST11.eof Then
									ia_sportspercent11 = RSLIST11("ia_sportspercent")
									ia_livepercent11 = RSLIST11("ia_livepercent")
									ia_site = RSLIST11("ia_site")
									ia_gcash = RSLIST11("ia_cash")
									SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
									SET RSLIST3 = DbCon.Execute(SQLLIST3)

									if Not RSLIST3.eof Then
										IA_CASH = (IB_Amount /100)* (CDbl(ia_livepercent11)-CDbl(ia_livepercent))
										LC_CONTENT = "����ǽð��Ѹ� " & (CDbl(ia_livepercent11)-CDbl(ia_livepercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									Else
										IA_CASH = (IB_Amount /100)* (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent))
										LC_CONTENT = "���罺�����Ѹ� " & (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									End If
								SET RSLIST111 = DbCon.Execute(SQLLIST111)
								IA_GCASH = IA_GCASH + IA_CASH
								Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, ia_site, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
								End If
				ElseIf ia_level = 2 Then			'�����϶��� ������� ������̵� �����Ѵ�(o)

						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100)* CDbl(ia_livepercent)
								LC_CONTENT = "����ǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� �������� ����"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							Else
								LC_CONTENT = "���罺�����Ѹ� " & CDbl(ia_sportspercent) & "%���� �������� ����"
								IA_CASH = (IB_Amount /100)* CDbl(ia_sportspercent)
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF

						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
				End If
			End If	
		End IF
'''''''''''''''''''''''''''''''''''��������޳�    
                Else
'��ٸ� ��÷����Ʈ ���޹��� �����߰�
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
SET RSLIST = DbCon.Execute(SQLLIST)
	if Not RSLIST.eof then
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent_live
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent_live
			End IF
			RSLIST.CLOSE
			SET RSLIST = Nothing
			Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH, 1,IU_NICKNAME)
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent
			End IF
			RSLIST.CLOSE
			SET RSLIST = Nothing
			
			Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH, 1,IU_NICKNAME)
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                    Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH , 0, IU_NICKNAME)
                    response.write IB_Idx &"<font color='red'>��÷ - " & IU_NICKNAME & "��" & IB_Amount & "�� - ��÷�� : " & BenefitAmount & "</font><Br>"
                    
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
				        smsMsg =  SITE_NAME & "-" & IU_NICKNAME & "�� ���߱� :"  & BenefitAmount & "��"
				        smsVal =  sendSms(IU_MOBILE, smsMsg)	

                    End IF 


''''''''''''''''''''''''''''''''''''��������޽���(17-02-18)
		If totalIBD_RESULT <> 3 And totalIBD_RESULT <> 2 THEN
		SQLLIST = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & RECOM_ID & "' and IA_TYPE = 2;"
		SET RSLIST = DbCon.Execute(SQLLIST)

			if Not RSLIST.eof Then
		
				ia_sportspercent = RSLIST("ia_sportspercent")
				ia_livepercent = RSLIST("ia_livepercent")
				ia_site = RSLIST("ia_site")
				ia_level = RSLIST("ia_level")
				ia_gcash = RSLIST("ia_cash")
				site = Left(Right(ia_site,4),2)
				If ia_level = 3 then				'�����϶� �������縦 �˻��ؼ� �������簡 ������� ������� ������ �����Ѵ�
						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100) * CDbl(ia_livepercent)
								LC_CONTENT = "���ǽǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & " WHERE IA_ID = '" & RECOM_ID & "';"
							Else

								IA_CASH = (IB_Amount /100) * CDbl(ia_sportspercent)
								LC_CONTENT = "���ǽ������Ѹ� " & CDbl(ia_sportspercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, RECOM_ID, IA_CASH, IA_GCASH, 3, LC_CONTENT, IB_IDX)
						ia_cash=0

						''''''''''''''''''''���絵 �־���� �Ǵ� ������ �ۼ��������� �����´� ���簡 ������ �н�, ���簡 ���������̾ �н�
						SQLLIST11 = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & site & "admin' and IA_TYPE = 2;"
						SET RSLIST11 = DbCon.Execute(SQLLIST11)

								if Not RSLIST11.eof Then
									ia_sportspercent11 = RSLIST11("ia_sportspercent")
									ia_livepercent11 = RSLIST11("ia_livepercent")
									ia_site = RSLIST11("ia_site")
									ia_gcash = RSLIST11("ia_cash")
									SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
									SET RSLIST3 = DbCon.Execute(SQLLIST3)

									if Not RSLIST3.eof Then
										IA_CASH = (IB_Amount /100)* (CDbl(ia_livepercent11)-CDbl(ia_livepercent))
										LC_CONTENT = "����ǽð��Ѹ� " & (CDbl(ia_livepercent11)-CDbl(ia_livepercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									Else
										IA_CASH = (IB_Amount /100)* (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent))
										LC_CONTENT = "���罺�����Ѹ� " & (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									End If
								SET RSLIST111 = DbCon.Execute(SQLLIST111)
								IA_GCASH = IA_GCASH + IA_CASH
								Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, ia_site, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
								End If
				ElseIf ia_level = 2 Then			'�����϶��� ������� ������̵� �����Ѵ�(o)

						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100)* CDbl(ia_livepercent)
								LC_CONTENT = "����ǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� �������� ����"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							Else
								LC_CONTENT = "���罺�����Ѹ� " & CDbl(ia_sportspercent) & "%���� �������� ����"
								IA_CASH = (IB_Amount /100)* CDbl(ia_sportspercent)
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF

						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
				End If
			End If	
		End IF
'''''''''''''''''''''''''''''''''''��������޳�					
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
                            
    '���� ���� ��Ⱑ �ƴ� ��� 
        IF totalIBD_RESULT <> 9 Then
            '���� ���μ���
            IF totalIBD_RESULT = 0 Then      
                IF RECOM_ID = "" OR RECOM_ID = "admin"  Then                                                        
                    RECOM_ID = ""
                    IUL_Recom_Percent = 0 
                End IF
                                     
                
                '���� ���޾�
                IA_CASHBACK = 0
                IF cStr(IA_Type) = "2" Then
                    IA_CASHBACK = Cdbl(IB_Amount - (IB_CASHBACK + IB_RECOM_CASHBACK)/IA_Percent)
                End IF
'��ٸ� ��÷����Ʈ ���޹��� �����߰�
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
SET RSLIST = DbCon.Execute(SQLLIST)
	if Not RSLIST.eof then
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent_live
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent_live
			End IF
			RSLIST.CLOSE
			SET RSLIST = NOTHING
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent
			End IF
			RSLIST.CLOSE
			SET RSLIST = NOTHING
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
		

                response.write IB_Idx &"<font color='blue'>b��÷ - " & IU_NICKNAME & "�� ���ñ� : " & IB_Amount & "�� - ��÷����Ʈ : "& IB_CASHBACK & "  -��õ��("&RECOM_ID&") ���޾� :" & IB_RECOM_CASHBACK & "</font><br>"         


''''''''''''''''''''''''''''''''''''��������޽���(17-02-18)
		If totalIBD_RESULT <> 3 And totalIBD_RESULT <> 2 THEN
		SQLLIST = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & RECOM_ID & "' and IA_TYPE = 2;"
		SET RSLIST = DbCon.Execute(SQLLIST)

			if Not RSLIST.eof Then
		
				ia_sportspercent = RSLIST("ia_sportspercent")
				ia_livepercent = RSLIST("ia_livepercent")
				ia_site = RSLIST("ia_site")
				ia_level = RSLIST("ia_level")
				ia_gcash = RSLIST("ia_cash")
				site = Left(Right(ia_site,4),2)
				If ia_level = 3 then				'�����϶� �������縦 �˻��ؼ� �������簡 ������� ������� ������ �����Ѵ�
						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100) * CDbl(ia_livepercent)
								LC_CONTENT = "���ǽǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & " WHERE IA_ID = '" & RECOM_ID & "';"
							Else

								IA_CASH = (IB_Amount /100) * CDbl(ia_sportspercent)
								LC_CONTENT = "���ǽ������Ѹ� " & CDbl(ia_sportspercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, RECOM_ID, IA_CASH, IA_GCASH, 3, LC_CONTENT, IB_IDX)
						ia_cash=0

						''''''''''''''''''''���絵 �־���� �Ǵ� ������ �ۼ��������� �����´� ���簡 ������ �н�, ���簡 ���������̾ �н�
						SQLLIST11 = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & site & "admin' and IA_TYPE = 2;"
						SET RSLIST11 = DbCon.Execute(SQLLIST11)

								if Not RSLIST11.eof Then
									ia_sportspercent11 = RSLIST11("ia_sportspercent")
									ia_livepercent11 = RSLIST11("ia_livepercent")
									ia_site = RSLIST11("ia_site")
									ia_gcash = RSLIST11("ia_cash")
									SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
									SET RSLIST3 = DbCon.Execute(SQLLIST3)

									if Not RSLIST3.eof Then
										IA_CASH = (IB_Amount /100)* (CDbl(ia_livepercent11)-CDbl(ia_livepercent))
										LC_CONTENT = "����ǽð��Ѹ� " & (CDbl(ia_livepercent11)-CDbl(ia_livepercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									Else
										IA_CASH = (IB_Amount /100)* (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent))
										LC_CONTENT = "���罺�����Ѹ� " & (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									End If
								SET RSLIST111 = DbCon.Execute(SQLLIST111)
								IA_GCASH = IA_GCASH + IA_CASH
								Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, ia_site, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
								End If
				ElseIf ia_level = 2 Then			'�����϶��� ������� ������̵� �����Ѵ�(o)

						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100)* CDbl(ia_livepercent)
								LC_CONTENT = "����ǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� �������� ����"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							Else
								LC_CONTENT = "���罺�����Ѹ� " & CDbl(ia_sportspercent) & "%���� �������� ����"
								IA_CASH = (IB_Amount /100)* CDbl(ia_sportspercent)
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF

						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
				End If
			End If		
		End IF
'''''''''''''''''''''''''''''''''''��������޳�				
            Else
'��ٸ� ��÷����Ʈ ���޹��� �����߰�
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
SQLLIST = "SELECT * FROM INFO_game where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
SET RSLIST = DbCon.Execute(SQLLIST)
	if Not RSLIST.eof then
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent_live
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent_live
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent_live
			End IF
			RSLIST.CLOSE
			SET RSLIST = Nothing
			Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH, 1,IU_NICKNAME)
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		'��õ���� �����Ҷ� �Ѹ��ݾ� ���޵Ǵ� ����(���н�)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RECOM_ID <> "" And (IUL_BPercent > 0 Or IUL_BPercent_live > 0 Or IUL_Recom_BPercent > 0 Or IUL_Recom_BPercent_live > 0) Then
			SQLLIST = "SELECT * FROM INFO_ADMIN WHERE IA_ID='" & RECOM_ID & "'"
			SET RSLIST = DbCon.Execute(SQLLIST)
			if RSLIST.eof Then
				'�Ѹ��ݾ� ���                
				IB_CASHBACK = IB_Amount*IUL_BPercent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_BPercent
			Else
				IB_CASHBACK = IB_Amount*IUL_Percent
				IB_RECOM_CASHBACK = IB_Amount*IUL_Recom_Percent
			End IF
			RSLIST.CLOSE
			SET RSLIST = Nothing
			
			Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID , 0, IA_Type, IA_CASHBACK, IU_CASH, 1,IU_NICKNAME)
		End IF
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                Call dfgameSql1.ExecGameResultStep3(dfDBConn.Conn, IB_IDX , IG_IDX, BenefitAmount, IB_ID, IU_SITE , 0, 0, "" ,  1,  0, 0, IU_CASH , 0, IU_NICKNAME)
                response.write IB_Idx &"<font color='red'>��÷ - " & IU_NICKNAME & "��" & IB_Amount & "�� - ��÷�� : " & BenefitAmount & "</font><Br>"
                
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
			        smsMsg =  SITE_NAME & " -" & IU_NICKNAME & "�� ���߱� :"  & BenefitAmount & "��"
			        smsVal =  sendSms(IU_MOBILE, smsMsg)	
		                        
                End IF	


''''''''''''''''''''''''''''''''''''��������޽���(17-02-18)
		If totalIBD_RESULT <> 3 And totalIBD_RESULT <> 2 THEN
		SQLLIST = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & RECOM_ID & "' and IA_TYPE = 2;"
		SET RSLIST = DbCon.Execute(SQLLIST)

			if Not RSLIST.eof Then
		
				ia_sportspercent = RSLIST("ia_sportspercent")
				ia_livepercent = RSLIST("ia_livepercent")
				ia_site = RSLIST("ia_site")
				ia_level = RSLIST("ia_level")
				ia_gcash = RSLIST("ia_cash")
				site = Left(Right(ia_site,4),2)
				If ia_level = 3 then				'�����϶� �������縦 �˻��ؼ� �������簡 ������� ������� ������ �����Ѵ�
						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100) * CDbl(ia_livepercent)
								LC_CONTENT = "���ǽǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & " WHERE IA_ID = '" & RECOM_ID & "';"
							Else

								IA_CASH = (IB_Amount /100) * CDbl(ia_sportspercent)
								LC_CONTENT = "���ǽ������Ѹ� " & CDbl(ia_sportspercent) & "%���� ���� ���̵�(" & site & "admin)"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, RECOM_ID, IA_CASH, IA_GCASH, 3, LC_CONTENT, IB_IDX)
						ia_cash=0

						''''''''''''''''''''���絵 �־���� �Ǵ� ������ �ۼ��������� �����´� ���簡 ������ �н�, ���簡 ���������̾ �н�
						SQLLIST11 = "SELECT ia_sportspercent, ia_livepercent, ia_site, ia_level, ia_cash FROM INFO_ADMIN WHERE IA_ID = '" & site & "admin' and IA_TYPE = 2;"
						SET RSLIST11 = DbCon.Execute(SQLLIST11)

								if Not RSLIST11.eof Then
									ia_sportspercent11 = RSLIST11("ia_sportspercent")
									ia_livepercent11 = RSLIST11("ia_livepercent")
									ia_site = RSLIST11("ia_site")
									ia_gcash = RSLIST11("ia_cash")
									SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"		'���Ǹ��� �����ϰ�
									SET RSLIST3 = DbCon.Execute(SQLLIST3)

									if Not RSLIST3.eof Then
										IA_CASH = (IB_Amount /100)* (CDbl(ia_livepercent11)-CDbl(ia_livepercent))
										LC_CONTENT = "����ǽð��Ѹ� " & (CDbl(ia_livepercent11)-CDbl(ia_livepercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									Else
										IA_CASH = (IB_Amount /100)* (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent))
										LC_CONTENT = "���罺�����Ѹ� " & (CDbl(ia_sportspercent11)-CDbl(ia_sportspercent)) & "%���� ���� ���̵�(" & RECOM_ID & ")"
										SQLLIST111 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & site & "admin'"
									End If
								SET RSLIST111 = DbCon.Execute(SQLLIST111)
								IA_GCASH = IA_GCASH + IA_CASH
								Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, ia_site, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
								End If
				ElseIf ia_level = 2 Then			'�����϶��� ������� ������̵� �����Ѵ�(o)

						SQLLIST3 = "SELECT * FROM INFO_game with(nolock) where ig_idx="& Ig_Idx &" and (rl_sports='�ǽð�')"
						SET RSLIST3 = DbCon.Execute(SQLLIST3)
							if Not RSLIST3.eof Then
								IA_CASH = (IB_Amount /100)* CDbl(ia_livepercent)
								LC_CONTENT = "����ǽð��Ѹ� " & CDbl(ia_livepercent) & "%���� �������� ����"
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							Else
								LC_CONTENT = "���罺�����Ѹ� " & CDbl(ia_sportspercent) & "%���� �������� ����"
								IA_CASH = (IB_Amount /100)* CDbl(ia_sportspercent)
								SQLLIST3 = "UPDATE INFO_ADMIN SET IA_CASH = IA_CASH + " & IA_CASH & "  WHERE IA_ID = '" & RECOM_ID & "';"
							End IF

						SET RSLIST3 = DbCon.Execute(SQLLIST3)
						IA_GCASH = IA_GCASH + IA_CASH
						Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IU_SITE, site & "admin", IA_CASH, IA_GCASH, 2, LC_CONTENT, IB_IDX)
				End If
			End If
		End IF
'''''''''''''''''''''''''''''''''''��������޳�				
            End IF
        End If


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