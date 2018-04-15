<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->
<!-- #include virtual="/_Global/functions.asp" -->
<!-- #include virtual="/_Global/ASocket.inc" -->

<%
	Dim smsVariant

	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	IG_IDX		= REQUEST("IG_IDX")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")

	IG_Score1	= REQUEST("IG_Score1")
	IG_Score2	= REQUEST("IG_Score2")


	SQLMSG = "SELECT IG_HANDICAP, IG_TEAM1BENEFIT, IG_DRAWBENEFIT, IG_TEAM2BENEFIT, IG_TYPE FROM INFO_GAME WHERE IG_IDX = '"& IG_IDX &"' "
	SET RS = DbCon.Execute(SQLMSG)
	
	IG_HANDICAP		= RS("IG_HANDICAP")
	IG_TEAM1BENEFIT	= RS("IG_TEAM1BENEFIT")
	IG_DRAWBENEFIT	= RS("IG_DRAWBENEFIT")
	IG_TEAM2BENEFIT	= RS("IG_TEAM2BENEFIT")
	IG_TYPE			= RS("IG_TYPE")

	
	IF IG_HANDICAP = "0" THEN
		Score1 = IG_Score1
	ELSE
		IF IG_TYPE = "2" THEN 
			Score1 = IG_Score1
		ELSE 
			Score1 = Cdbl(IG_Score1) + Cdbl(IG_HANDICAP)
		END IF
	END IF
	
	Score2 = IG_Score2
	

	'2 언더오버
	'1 핸디캡
	'0 프로토
	IF IG_TYPE = "2" THEN 
		IF Cdbl(IG_HANDICAP) < Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			WinTeam = 1
		ElseIf Cdbl(IG_HANDICAP) = Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			%>
			<script>
			    if (confirm("적특처리하시겠습니까?"))
			    {
			        location.href="Game_Mo.asp?IG_IDX=<%=IG_IDX%>&page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
                }			        
            </script>
			<%
			response.end
		Else 
			WinTeam = 2
		END IF
	ELSE
		IF Cdbl(Score1) > Cdbl(Score2) THEN
			WinTeam = 1
		ELSEIF Cdbl(Score1) < Cdbl(Score2) THEN
			WinTeam = 2
		ElseIf Cdbl(Score1) = Cdbl(Score2) And IG_TYPE = "1"  THEN
			%>
			<script>
			    if (confirm("적특처리하시겠습니까?"))
			    {
			        location.href="Game_Mo.asp?IG_IDX=<%=IG_IDX%>&page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
                }			        
            </script>
			<%
			response.end
		ElseIf Cdbl(Score1) = Cdbl(Score2) And IG_DRAWBENEFIT = "0"  THEN
			%>
			<script>
			    if (confirm("적특처리하시겠습니까?"))
			    {
			        location.href="Game_Mo.asp?IG_IDX=<%=IG_IDX%>&page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
                }			        
            </script>
			<%
			response.end			
		Else 
			WinTeam = 0
		END IF
	END IF 


	'게임리스트 승리팀을 반영
	UPDSQL = "Update Info_Game set IG_Score1=" & IG_Score1 & ", IG_Score2=" & IG_Score2 & ", IG_Result=" & WinTeam & ", IG_Status='F'"
	UPDSQL = UPDSQL & " where IG_Idx=" & IG_Idx
	DbCon.Execute (UPDSQL)



	'단식게임 취소
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT IB_IDX, IB_ID, IB_NUM, IB_BENEFIT, IB_AMOUNT, IB_SITE FROM INFO_BETTING WHERE IB_TYPE = 'S' AND IB_STATUS = 0 AND IG_IDX = '"&IG_IDX&"' ORDER BY IB_IDX ASC", DbCon, 1

	IF NOT RS.EOF THEN
		
		DO UNTIL RS.EOF
			IB_IDX		= RS("IB_IDX")
			IB_ID		= RS("IB_ID")
			IB_NUM		= RS("IB_NUM")
			IB_BENEFIT	= RS("IB_BENEFIT")
			IB_AMOUNT	= RS("IB_AMOUNT")
			IB_SITE		= RS("IB_SITE")
			
			IF Cint(WinTeam) = Cint(IB_NUM) THEN
				BenefitAmount = Cdbl(IB_AMOUNT) * Cdbl(IB_BENEFIT) 

				'사용자 당첨금 배당
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(BenefitAmount)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"' "
				SET UMO = DbCon.Execute(SQLMSG)

				CIU_Cash	= UMO(0)

				UMO.Close
				Set UMO = Nothing
				
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values('"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & numdel2(BenefitAmount) & ","
				INSSQL = INSSQL & CIU_Cash & ",'배팅배당', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)

			    '배팅리스트 정산종료(IB_Status=9)
			    UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_GOOD = 1 WHERE IB_IDX = "&IB_IDX
			    DbCon.execute(UPDSQL)	
			    			
            Else ' 실패 경우 낙첨금 지급

                SQLa = "SELECT IU_LEVEL FROM INFO_USER WHERE IU_ID = '" & IB_ID &"'" 
                Set RSa = Server.CreateObject("ADODB.Recordset")
                RSa.Open SQLa, DbCon, 1

                IF NOT RSa.EOF THEN
                    IU_LEVEL = Rsa(0)
 	            END IF  
	              
		        RSa.Close
		        Set RSa = Nothing	
        			            
	            IF IU_LEVEL = 1 Then
	                IU_Percent = 0.01
                ElseIF IU_LEVEL = 2 Then	                
                    IU_Percent = 0.03
                ElseIF IU_LEVEL = 3 Then	                
                    IU_Percent = 0.05   
                Else                    
                    IU_Percent = 0.05  
	            End IF
                		                
				IB_CASHBACK = IB_AMOUNT*IU_Percent
				
				'사용자 낙첨금 배당
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(IB_CASHBACK)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash, RECOM_ID, IU_NickName FROM INFO_USER WHERE IU_ID='" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"' "
				SET UMO = DbCon.Execute(SQLMSG)
                                
				CIU_Cash	= UMO(0)
				CRECOM_ID   = UMO(1)
				CIU_NickName   = UMO(2)

				UMO.Close
				Set UMO = Nothing
				 
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE,LC_BONUS) values('"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & numdel2(IB_CASHBACK) & ","
				INSSQL = INSSQL & CIU_Cash & ",'배팅낙첨금', '"& IB_SITE &"',1)"
				 
				DbCon.execute(INSSQL)
				
				'추천회원의 낙첨금 캐쉬백
				IF CRECOM_ID <> "admin" Then
				    'RECOM_Rercent = 0.03
				    RECOM_CASHBACK = IB_CASHBACK
				    
				    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(RECOM_CASHBACK)&" WHERE IU_ID = '" & CRECOM_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				    DbCon.execute(UPDSQL)
                    				    
				    SQLMSG = "SELECT IU_Cash, RECOM_ID, IU_NickName FROM INFO_USER WHERE IU_ID='" & CRECOM_ID & "'  "
				    SET UMO = DbCon.Execute(SQLMSG)
                                    
                    IF NOT UMO.EOF Then
				        RIU_Cash	= UMO(0)
        				                    				    
				        INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_BONUS) values('"
				        INSSQL = INSSQL & CRECOM_ID & "', "
				        INSSQL = INSSQL & numdel2(IB_CASHBACK) & ","
				        INSSQL = INSSQL & RIU_Cash & ",'"& CIU_NickName&"님의 배팅낙첨금', '"& IB_SITE &"',1)"
				        DbCon.execute(INSSQL)
                    End IF
                    
                	UMO.Close
			        Set UMO = Nothing
				        
                End IF	

			    '배팅리스트 정산종료(IB_Status=9)
			    UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_GOOD = 1 WHERE IB_IDX = "&IB_IDX
			    DbCon.execute(UPDSQL)	
			                                        			    
			END IF
			

			
		RS.MoveNext
		LOOP
	
	END IF




			
	'복식게임 정산
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT IB_IDX, IB_ID, IG_IDX, IB_NUM, IB_BENEFIT, IB_AMOUNT, IB_SITE FROM INFO_BETTING WHERE IB_TYPE = 'M' AND IB_STATUS = 0 AND IG_IDX LIKE '%"&IG_IDX&"%' ORDER BY IB_IDX ASC", DbCon, 1

	IF NOT RS.EOF THEN

		DO UNTIL RS.EOF
			IB_IDX			= RS("IB_Idx")
			IB_ID			= RS("IB_ID")
			arr_IG_Idx		= SPLIT(RS("IG_IDX"), ",")
			arrLen			= Ubound(arr_IG_Idx)
			arr_IB_Num		= SPLIT(RS("IB_NUM"), ",")
			arr_IB_Benefit	= SPLIT(RS("IB_BENEFIT"), ",")
			IB_AMOUNT		= RS("IB_AMOUNT")
			IB_SITE			= RS("IB_SITE")

			ProcFlag = "TRUE"
			ResultFlag = "TRUE"
			TotalBenefit = 1


			FOR i=0 TO arrLen

				SQLMSG = "SELECT IG_STATUS, IG_RESULT FROM INFO_GAME WHERE IG_IDX = '"& arr_IG_Idx(i) &"' "
				SET RS1 = DbCon.Execute(SQLMSG)
                IF NOT RS1.Eof Then
				    IG_STATUS		= RS1(0)
				    IG_RESULT		= RS1(1)
                Else
                    IG_Status = "C"    				    
                End IF
                
				IF IG_Status <> "C" THEN													'취소 경기가 아니면
					IF IG_Status = "F" THEN													'종료 경기인 경우
						IF Cint(arr_IB_Num(i)) = Cint(IG_RESULT) THEN						'경기 승자를 맞췄을 경우
							TotalBenefit = Cdbl(TotalBenefit) * Cdbl(arr_IB_Benefit(i)) 
						ELSE																'경기 승자를 못 맞췄을 경우
							ResultFlag = "FALSE"
                            ProcFlag = "TRUE"
							'배팅리스트 정산종료(IB_Status=1)
							UPDSQL = "UPDATE INFO_BETTING SET IB_STATUS = 1 WHERE IB_IDX = "& IB_IDX
							DbCon.execute(UPDSQL)
							EXIT FOR
						END IF
					ELSE																	'진행 경기인 경우
						ProcFlag = "FALSE"
						Exit for
					END IF
				END IF

			NEXT


			'모든게임이 적중했을 경우
			IF ProcFlag = "TRUE" and ResultFlag = "TRUE" THEN
				BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
				
				'사용자 당첨금 배당
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(BenefitAmount)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"' "
				SET UMO = DbCon.Execute(SQLMSG)

				CIU_Cash	= UMO(0)

				UMO.Close
				Set UMO = Nothing
				
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & numdel2(BenefitAmount) & ","
				INSSQL = INSSQL & CIU_Cash & ",'배팅배당', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)
				
				'배팅리스트 정산종료(IB_Status=9)
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_GOOD = 1 WHERE IB_IDX = "&IB_IDX
				DbCon.execute(UPDSQL)
			END IF
		    
		    '실패시 낙첨금 지급
		    IF ProcFlag = "TRUE" and ResultFlag = "FALSE" THEN
		    
                SQLa = "SELECT IU_LEVEL FROM INFO_USER WHERE IU_ID = '" & IB_ID &"'" 
                Set RSa = Server.CreateObject("ADODB.Recordset")
                RSa.Open SQLa, DbCon, 1

                IF NOT RSa.EOF THEN
                    IU_LEVEL = Rsa(0)
 	            END IF  
	              
		        RSa.Close
		        Set RSa = Nothing	
        			            
	            IF IU_LEVEL = 1 Then
	                IU_Percent = 0.01
                ElseIF IU_LEVEL = 2 Then	                
                    IU_Percent = 0.03
                ElseIF IU_LEVEL = 3 Then	                
                    IU_Percent = 0.05   
                Else                    
                    IU_Percent = 0.05
	            End IF
                		                
				IB_CASHBACK = IB_AMOUNT*IU_Percent
				
				'사용자 낙첨금 배당
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(IB_CASHBACK)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash, RECOM_ID, IU_NickName FROM INFO_USER WHERE IU_ID='" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"' "
				SET UMO = DbCon.Execute(SQLMSG)
                                
				CIU_Cash	= UMO(0)
				CRECOM_ID   = UMO(1)
				CIU_NickName   = UMO(2)

				UMO.Close
				Set UMO = Nothing
				
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE,LC_BONUS) values('"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & numdel2(IB_CASHBACK) & ","
				INSSQL = INSSQL & CIU_Cash & ",'배팅낙첨금', '"& IB_SITE &"',1)"
				
				
				DbCon.execute(INSSQL)
				
				'추천회원의 낙첨금 캐쉬백
				IF CRECOM_ID <> "admin" Then
				    'RECOM_Rercent = 0.03
				    RECOM_CASHBACK = IB_CASHBACK
				    
				    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&numdel2(RECOM_CASHBACK)&" WHERE IU_ID = '" & CRECOM_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				    DbCon.execute(UPDSQL)
                    				
				    SQLMSG = "SELECT isNull(IU_Cash,0), RECOM_ID, IU_NickName FROM INFO_USER WHERE IU_ID='" & CRECOM_ID & "'  "
				    SET UMO = DbCon.Execute(SQLMSG)
				    
                    IF NOT UMO.EOF Then
				        RIU_Cash	= UMO(0)
        				                    				    
				        INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_BONUS) values('"
				        INSSQL = INSSQL & CRECOM_ID & "', "
				        INSSQL = INSSQL & numdel2(IB_CASHBACK) & ","
				        INSSQL = INSSQL & RIU_Cash & ",'"& CIU_NickName&"님의 배팅낙첨금', '"& IB_SITE &"',1)"
				        DbCon.execute(INSSQL)
                    End IF				   
                    
			        UMO.Close
			        Set UMO = Nothing                         
                End IF			    

				'배팅리스트 정산종료(IB_Status=9)
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_GOOD = 1 WHERE IB_IDX = "&IB_IDX
				DbCon.execute(UPDSQL)
						    
		    End IF
		    
		RS.MoveNext
		LOOP

		RS1.Close
		Set RS1 = Nothing	
		
	END IF

	RS.Close
	Set RS = Nothing	

	DbCon.Close
	Set DbCon=Nothing
%>
<script type="text/javascript">
	//var goUrl="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	opener.top.ViewFrm.location.reload();
	self.close();
</script>