<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DBHelper.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Global/DbCono2.asp" -->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Common/Lib/request.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/smsUtil.Class.asp" -->
<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
'기존작업한 수익정산 머니적립은 charge_regists.asp.bak로 옮겨놨음 2017/09/15
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
	Dim dfgameSql1
    Set dfgameSql1 = new gameSql  
	
	FOR i = 1 TO TotalCount
		IC_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT * FROM INFO_CHARGE WHERE IC_IDX = "& IC_Idx &""
		SET RS = DbCon.Execute(SQLMSG)
		
		IF CDbl(RS("IC_Status")) = 1 THEN
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('입금 처리된 정보입니다.\n다시 한번 확인해 주세요.');" & VbCrLf
				RS.Close
				Set RS=Nothing

				DbCon.Close
				Set DbCon=Nothing
				'.write "top.ViewFrm.location.reload();" & VbCrLf
				.write "location.href='Charge_List.asp';" & VbCrLf
				.write "</script>" & VbCrLf
				.end
			End With
			EXIT FOR
		END IF
		
		IC_ID = RS("IC_ID")
		IC_Name = RS("IC_Name")
		IC_Amount = CDbl(RS("IC_Amount"))
		reqIC_Amount = replace(request("IC_Amount"&IC_Idx),",","")
		reqIC_BONUS_AMOUNT = replace(request("IC_BONUS_AMOUNT"&IC_Idx),",","")
		
        reqIC_Amount        = dfStringUtil.F_initNumericParam(Trim(reqIC_Amount), 0, 0, 100000000) 
        reqIC_BONUS_AMOUNT  = dfStringUtil.F_initNumericParam(Trim(reqIC_BONUS_AMOUNT), 0, 0, 100000000) 
		
		IC_SITE = RS("IC_SITE")
		IC_T_YN = RS("IC_T_YN")
		
		
		'총판 그룹을 확인
		SQLMSG = "SELECT IA_TYPE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE FROM INFO_ADMIN WHERE IA_SITE = '" & IC_SITE & "' and IA_STATUS = 1 And IA_TYPE = 1 "
		SET UMO = DbCon.Execute(SQLMSG)
		
		If Not UMO.EOF Then
		
			IA_LEVEL	=UMO("IA_LEVEL")
			IA_SportsPercent =CDbl(UMO("IA_SportsPercent"))
			IA_CASH		=UMO("IA_CASH")
			IA_GROUP	=UMO("IA_GROUP")
			IA_GROUP1	=UMO("IA_GROUP1")
			IA_GROUP2	=UMO("IA_GROUP2")
			IA_GROUP3	=UMO("IA_GROUP3")
			IA_GROUP4	=UMO("IA_GROUP4")
			IA_ID		=UMO("IA_ID")
			IA_STATUS	=UMO("IA_STATUS")
			IA_SITE		=UMO("IA_SITE")

			'충전회원이 본사시스템일때
			If IA_GROUP = 2 Then
				If IA_LEVEL = 2 Then		'본사에 마일리지 적립
					IA_MILEAGE = IC_AMOUNT * (IA_SportsPercent*0.01)
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IC_ID, IA_MILEAGE, IA_SportsPercent, 1, "본사 충환전마일리지 적립", IC_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				ElseIf IA_LEVEL = 3 Then		'부본사에 마일리지 적립
					SQLMSG1 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2=0 and IA_GROUP3=0 and IA_GROUP4=0 and IA_LEVEL = 2"
					SET UMO1 = DbCon.Execute(SQLMSG1)

					IA_LEVEL2	=UMO1("IA_LEVEL")
					IA_SportsPercent2 =CDbl(UMO1("IA_SportsPercent"))
					IA_CASH2		=UMO1("IA_CASH")
					IA_1GROUP	=UMO1("IA_GROUP")
					IA_1GROUP1	=UMO1("IA_GROUP1")
					IA_1GROUP2	=UMO1("IA_GROUP2")
					IA_1GROUP3	=UMO1("IA_GROUP3")
					IA_1GROUP4	=UMO1("IA_GROUP4")
					IA_ID2		=UMO1("IA_ID")
					IA_STATUS2	=UMO1("IA_STATUS")
					IA_SITE2	=UMO1("IA_SITE")

					UMO1.Close
					Set UMO1 = Nothing

					IA_SportsPercent2 = IA_SportsPercent2 - IA_SportsPercent

					IA_MILEAGE2 = IC_AMOUNT * (IA_SportsPercent2*0.01)	'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IC_ID, IA_MILEAGE2, IA_SportsPercent2, 2, "하부 부본사 " & IA_SITE & "의 충환전마일리지 적립", 0, IA_1GROUP, IA_1GROUP1, IA_1GROUP2, IA_1GROUP3, IA_1GROUP4)

					IA_MILEAGE = IC_AMOUNT * (IA_SportsPercent*0.01)	'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IC_ID, IA_MILEAGE, IA_SportsPercent, 1, "부본사 충환전마일리지 적립", IC_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)

				ElseIf IA_LEVEL = 4 Then		'총판에 마일리지 적립
					SQLMSG3 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2 = " & IA_GROUP2 & " and IA_GROUP3=0 and IA_GROUP4=0 and IA_LEVEL = 3"
					SET UMO3 = DbCon.Execute(SQLMSG3)

					IA_LEVEL3	=UMO3("IA_LEVEL")
					IA_SportsPercent3 =CDbl(UMO3("IA_SportsPercent"))
					IA_CASH3		=UMO3("IA_CASH")
					IA_3GROUP	=UMO3("IA_GROUP")
					IA_3GROUP1	=UMO3("IA_GROUP1")
					IA_3GROUP2	=UMO3("IA_GROUP2")
					IA_3GROUP3	=UMO3("IA_GROUP3")
					IA_3GROUP4	=UMO3("IA_GROUP4")
					IA_ID3		=UMO3("IA_ID")
					IA_STATUS3	=UMO3("IA_STATUS")
					IA_SITE3	=UMO3("IA_SITE")

					UMO3.Close
					Set UMO3 = Nothing

					SQLMSG1 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2=0 and IA_GROUP3=0 and IA_GROUP4=0 and IA_LEVEL = 2"
					SET UMO2 = DbCon.Execute(SQLMSG1)

					IA_LEVEL2	=UMO2("IA_LEVEL")
					IA_SportsPercent2 =CDbl(UMO2("IA_SportsPercent"))
					IA_CASH2		=UMO2("IA_CASH")
					IA_2GROUP	=UMO2("IA_GROUP")
					IA_2GROUP1	=UMO2("IA_GROUP1")
					IA_2GROUP2	=UMO2("IA_GROUP2")
					IA_2GROUP3	=UMO2("IA_GROUP3")
					IA_2GROUP4	=UMO2("IA_GROUP4")
					IA_ID2		=UMO2("IA_ID")
					IA_STATUS2	=UMO2("IA_STATUS")
					IA_SITE2	=UMO2("IA_SITE")

					UMO2.Close
					Set UMO2 = Nothing

					IA_SportsPercent3 = IA_SportsPercent3 - IA_SportsPercent						'부본사

					IA_SportsPercent2 = IA_SportsPercent2 - IA_SportsPercent3 - IA_SportsPercent	'본사

					IA_MILEAGE3 = IC_AMOUNT * (IA_SportsPercent3*0.01)								'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IC_ID, IA_MILEAGE3, IA_SportsPercent3, 2, "하부 총판" & IA_SITE & "의 충환전마일리지 적립", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IC_AMOUNT * (IA_SportsPercent2*0.01)								'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IC_ID, IA_MILEAGE2, IA_SportsPercent2, 2, "하부 총판" & IA_SITE & "의 충환전마일리지 적립", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IC_AMOUNT * (IA_SportsPercent*0.01)								'총판에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IC_ID, IA_MILEAGE, IA_SportsPercent, 1, "총판 충환전마일리지 적립", IC_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				ElseIf IA_LEVEL = 5 Then		'매장에 마일리지 적립
					SQLMSG4 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2 = " & IA_GROUP2 & " and IA_GROUP3 = " & IA_GROUP3 & " and IA_GROUP4=0 and IA_LEVEL = 4"
					SET UMO4 = DbCon.Execute(SQLMSG4)

					IA_LEVEL4	=UMO4("IA_LEVEL")
					IA_SportsPercent4 =CDbl(UMO4("IA_SportsPercent"))
					IA_CASH4		=UMO4("IA_CASH")
					IA_4GROUP	=UMO4("IA_GROUP")
					IA_4GROUP1	=UMO4("IA_GROUP1")
					IA_4GROUP2	=UMO4("IA_GROUP2")
					IA_4GROUP3	=UMO4("IA_GROUP3")
					IA_4GROUP4	=UMO4("IA_GROUP4")
					IA_ID4		=UMO4("IA_ID")
					IA_STATUS4	=UMO4("IA_STATUS")
					IA_SITE4	=UMO4("IA_SITE")

					UMO4.Close
					Set UMO4 = Nothing

					SQLMSG3 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2 = " & IA_GROUP2 & " and IA_GROUP3=0 and IA_GROUP4=0 and IA_LEVEL = 3"
					SET UMO3 = DbCon.Execute(SQLMSG3)

					IA_LEVEL3	=UMO3("IA_LEVEL")
					IA_SportsPercent3 =CDbl(UMO3("IA_SportsPercent"))
					IA_CASH3		=UMO3("IA_CASH")
					IA_3GROUP	=UMO3("IA_GROUP")
					IA_3GROUP1	=UMO3("IA_GROUP1")
					IA_3GROUP2	=UMO3("IA_GROUP2")
					IA_3GROUP3	=UMO3("IA_GROUP3")
					IA_3GROUP4	=UMO3("IA_GROUP4")
					IA_ID3		=UMO3("IA_ID")
					IA_STATUS3	=UMO3("IA_STATUS")
					IA_SITE3	=UMO3("IA_SITE")

					UMO3.Close
					Set UMO3 = Nothing

					SQLMSG1 = "SELECT IA_TYPE, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4 FROM INFO_ADMIN WHERE IA_GROUP = " & IA_GROUP & " and IA_GROUP1 = " & IA_GROUP1 & " and IA_GROUP2=0 and IA_GROUP3=0 and IA_GROUP4=0 and IA_LEVEL = 2"
					SET UMO2 = DbCon.Execute(SQLMSG1)

					IA_LEVEL2	=UMO2("IA_LEVEL")
					IA_SportsPercent2 =CDbl(UMO2("IA_SportsPercent"))
					IA_CASH2		=UMO2("IA_CASH")
					IA_2GROUP	=UMO2("IA_GROUP")
					IA_2GROUP1	=UMO2("IA_GROUP1")
					IA_2GROUP2	=UMO2("IA_GROUP2")
					IA_2GROUP3	=UMO2("IA_GROUP3")
					IA_2GROUP4	=UMO2("IA_GROUP4")
					IA_ID2		=UMO2("IA_ID")
					IA_STATUS2	=UMO2("IA_STATUS")
					IA_SITE2	=UMO2("IA_SITE")

					UMO2.Close
					Set UMO2 = Nothing

					IA_SportsPercent22 = IA_SportsPercent2 - (IA_SportsPercent3 - IA_SportsPercent4) - (IA_SportsPercent4 - IA_SportsPercent) - IA_SportsPercent	'본사퍼센트

					IA_SportsPercent44 = IA_SportsPercent4 - IA_SportsPercent						'총판퍼센트

					IA_SportsPercent33 = IA_SportsPercent3 - (IA_SportsPercent4 - IA_SportsPercent) - IA_SportsPercent	'부본사퍼센트

					IA_MILEAGE4 = IC_AMOUNT * (IA_SportsPercent44*0.01)								'총판에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE4, IC_ID, IA_MILEAGE4, IA_SportsPercent44, 2, "하부 매장" & IA_SITE & "의 충환전마일리지 적립", 0, IA_4GROUP, IA_4GROUP1, IA_4GROUP2, IA_4GROUP3, IA_4GROUP4)

					IA_MILEAGE3 = IC_AMOUNT * (IA_SportsPercent33*0.01)								'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IC_ID, IA_MILEAGE3, IA_SportsPercent33, 2, "하부 매장" & IA_SITE & "의 충환전마일리지 적립", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IC_AMOUNT * (IA_SportsPercent22*0.01)								'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IC_ID, IA_MILEAGE2, IA_SportsPercent22, 2, "하부 매장" & IA_SITE & "의 충환전마일리지 적립", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IC_AMOUNT * (IA_SportsPercent*0.01)								'매장에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IC_ID, IA_MILEAGE, IA_SportsPercent, 1, "매장 충환전마일리지 적립", IC_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				End If
				
			elseif IA_GROUP = 1 Then			'충전회원이 총판시스템일때 충전 마일리지를 총판에 업데이트
				IA_MILEAGE = IC_AMOUNT * (IA_SportsPercent*0.01)
				Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IC_ID, IA_MILEAGE, IA_SportsPercent, 1, "총판 충환전마일리지 적립", IC_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
			End If
			UMO.Close
			Set UMO = Nothing

		End IF


		If IC_T_YN <> "N" Then

		    'IC_Status를 1(충전완료)로 변경
		    UPDSQL = "UPDATE INFO_CHARGE SET IC_Status = 1, IC_SetDate = getdate() WHERE IC_Idx = "& IC_Idx
		    DbCon.execute(UPDSQL)

		    sql = "select iu_nickname from info_user where iu_id = '"&ic_id&"' and iu_site = 'Media'"
		    SET UMO = DbCon.Execute(sql)
		    If Not UMO.eof Then
			    cu_nick = umo("iu_nickname")
		    End If 
		    UMO.Close
		    Set UMO = Nothing

		    If cu_nick <> "" Then
		    Else
			    cu_nick = IC_Name
		    End If 

		    sql = "select * from info_user WHERE IU_ID='" & IC_ID & "' AND IU_SITE = 'Training'"
		    SET UMO = DbCon2.Execute(sql)
		    If Not UMO.eof Then
		    Else 
			    sql = "insert into info_user (  iu_id, iu_pw, iu_regdate, iu_nickname, iu_site ) values ( '" & IC_ID & "','1231231112',getdate(), '" & cu_nick & "','Training')"	
		    DbCon2.execute(SQL)
		    End If 
		    UMO.Close
		    Set UMO = Nothing




		    '사용자 머니 충전
		    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + 1000000 WHERE IU_ID = '"& IC_ID &"' AND IU_SITE = 'Training'"
		    DbCon2.execute(UPDSQL)

		    SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IC_ID & "' AND IU_SITE = '"& IC_SITE &"'"
		    SET UMO = DbCon.Execute(SQLMSG)
		    CIU_Cash	= UMO(0)
		    UMO.Close
		    Set UMO = Nothing

		    'Log_CashInOut 에 충전 기록
		    INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
		    INSSQL = INSSQL & IC_ID & "', "
		    INSSQL = INSSQL & IC_Amount & ","
		    INSSQL = INSSQL & CIU_Cash & ",  '머니충전', '"& IC_SITE &"')"
		    DbCon.execute(INSSQL)

		  


            '포인트 정보를 넣는다.
        
            dfDBConn.SetConn = Application("DBConnString")
	        dfDBConn.Connect()	
 
		Else
		


            '############ 입금액 머니 충전 프로세스 ####################
            DayCash = False
            dateVal = date() & " 00:00"   
	        SEL_SQL = "SELECT IC_IDX FROM INFO_CHARGE WHERE IC_Status = 1 AND IC_SetDate >= '" & dateVal & "' AND IC_ID ='"&IC_ID&"'"

	        
	        SET DayRs =  DbCon.execute(SEL_SQL)
            IF DayRs.Eof Then 
                DayCash = True                                    
            End IF
            
            DayRs.Close
		    Set DayRs = Nothing
		               
            '보너스 캐쉬 업데이트      			     
            'IC_Amount = CDbl(reqIC_Amount) + CDbl(reqIC_BONUS_AMOUNT)
       			                                
		    'IC_Status를 1(충전완료)로 변경
		    UPDSQL = "UPDATE INFO_CHARGE SET IC_Status = 1, IC_SetDate = getdate() , IC_AMOUNT = "&reqIC_Amount&" , IC_BONUS_AMOUNT = "&reqIC_BONUS_AMOUNT&" WHERE IC_Idx = "& IC_Idx
		    DbCon.execute(UPDSQL)

		    '사용자 머니 충전를 업데이트한다.
		    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&reqIC_Amount&" , IU_CHARGE= IU_CHARGE + "&reqIC_Amount&"  WHERE IU_ID = '"& IC_ID &"' AND IU_SITE = '"& IC_SITE &"'"
		    DbCon.execute(UPDSQL)

		    SQLMSG = "SELECT IU_Cash, B.IUL_Charge_Percent FROM INFO_USER A INNER JOIN INFO_USER_LEVEL B ON A.IU_LEVEL = B.IUL_LEVEL  WHERE IU_ID='" & IC_ID & "' AND IU_SITE = '"& IC_SITE &"'"
		    SET UMO = DbCon.Execute(SQLMSG)
		    CIU_Cash	= UMO("IU_Cash")
		    IUL_Charge_Percent	= UMO("IUL_Charge_Percent")
		    UMO.Close
		    Set UMO = Nothing

		    'Log_CashInOut 에 충전 기록
		    INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE, IA_LEVEL, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4) select top 1 '"
		    INSSQL = INSSQL & IC_ID & "', "
		    INSSQL = INSSQL & reqIC_Amount & ","
		    INSSQL = INSSQL & CIU_Cash & ",  '머니충전', '"& IC_SITE &"',iu_gtype, '" & IA_LEVEL & "','" & IA_GROUP & "', '" & IA_GROUP1 & "', '" & IA_GROUP2 & "', '" & IA_GROUP3 & "', '" & IA_GROUP4 & "' from info_user where iu_id= '"& IC_ID &"'"
			
		    DbCon.execute(INSSQL)		
		    
        	
        			    
		    '############ 보너스 머니 충전 프로세스 ####################
		    IF reqIC_BONUS_AMOUNT > 0 Then
		    		    
		        '사용자 머니 충전
		        UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&reqIC_BONUS_AMOUNT&" WHERE IU_ID = '"& IC_ID &"' AND IU_SITE = '"& IC_SITE &"'"
		        DbCon.execute(UPDSQL)

		        SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IC_ID & "' AND IU_SITE = '"& IC_SITE &"'"
		        SET UMO = DbCon.Execute(SQLMSG)
		        CIU_Cash	= UMO(0)
		        UMO.Close
		        Set UMO = Nothing

		        'Log_CashInOut 에 충전 기록
		        INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE ,LC_GTYPE) select top 1  '"
		        INSSQL = INSSQL & IC_ID & "', "
		        INSSQL = INSSQL & reqIC_BONUS_AMOUNT & ","
		        INSSQL = INSSQL & CIU_Cash & ",  '추가머니충전', '"& IC_SITE &"',iu_gtype from info_user where iu_id= '"& IC_ID &"'"
		        DbCon.execute(INSSQL)	
    		    		    		    
		    End IF


			bunusDay_Amount = reqIC_Amount*IUL_Charge_Percent

			if bunusDay_Amount > 100000 then
			bunusDay_Amount=100000
			end if		    		 
	    		 
            '############ 보너스 머니 충전 프로세스 ####################
		    IF bunusDay_Amount <> 0 AND DayCash Then
				
	            '사용자 머니 충전
	            UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&bunusDay_Amount&" WHERE IU_ID = '"& IC_ID &"' AND IU_SITE = '"& IC_SITE &"'"
	            DbCon.execute(UPDSQL)

	            SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IC_ID & "' AND IU_SITE = '"& IC_SITE &"'"
	            SET UMO = DbCon.Execute(SQLMSG)
	            CIU_Cash	= UMO(0)
	            UMO.Close
	            Set UMO = Nothing

	            'Log_CashInOut 에 충전 기록
	            INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) select top 1 '"
	            INSSQL = INSSQL & IC_ID & "', "
	            INSSQL = INSSQL & bunusDay_Amount & ","
	            INSSQL = INSSQL & CIU_Cash & ",  '하루첫입금보너스', '"& IC_SITE &"',iu_gtype from info_user where iu_id= '"& IC_ID &"'"
	            DbCon.execute(INSSQL)	
            
		    End IF
		    		    		    
		End If 

	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('입금 처리가 완료되었습니다.');" & VbCrLf
		'.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "top.ViewFrm.location.href='Charge_List.asp';" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>