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
		IE_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT IE_ID, IE_Amount, IE_Status, IE_SITE FROM INFO_EXCHANGE WHERE IE_IDX = '"& IE_Idx &"' "
		SET RS = DbCon.Execute(SQLMSG)
		
		IF CDbl(RS("IE_Status")) = 1 THEN
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "alert('환전 처리된 정보 입니다.\n다시 한번 확인 주세요.');" & VbCrLf
				RS.Close
				Set RS=Nothing

				DbCon.Close
				Set DbCon=Nothing
				.write "top.ViewFrm.location.reload();" & VbCrLf
				.write "</script>" & VbCrLf
				.end
			End With
			EXIT FOR
		END IF
		
		IE_ID = RS("IE_ID")
		IE_Amount = Cdbl("-" & RS("IE_Amount"))
		IE_SITE	= RS("IE_SITE")

		'총판 그룹을 확인
		SQLMSG = "SELECT IA_TYPE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL, IA_SportsPercent, IA_STATUS, IA_ID, IA_CASH, IA_SITE FROM INFO_ADMIN WHERE IA_SITE = '" & IE_SITE & "' and IA_STATUS = 1 And IA_TYPE = 1 "
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
					IA_MILEAGE = IE_Amount * (IA_SportsPercent*0.01)
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "본사 충환전마일리지 차감", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
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

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent2*0.01)	'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent2, 4, "하부 부본사 " & IA_SITE & "의 충환전마일리지 차감", 0, IA_1GROUP, IA_1GROUP1, IA_1GROUP2, IA_1GROUP3, IA_1GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)	'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "부본사 충환전마일리지 차감", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)

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

					IA_MILEAGE3 = IE_AMOUNT * (IA_SportsPercent3*0.01)								'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IE_ID, IA_MILEAGE3, IA_SportsPercent3, 4, "하부 총판" & IA_SITE & "의 충환전마일리지 차감", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent2*0.01)								'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent2, 4, "하부 총판" & IA_SITE & "의 충환전마일리지 차감", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)								'총판에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "총판 충환전마일리지 차감", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
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

					IA_MILEAGE4 = IE_AMOUNT * (IA_SportsPercent44*0.01)								'총판에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE4, IE_ID, IA_MILEAGE4, IA_SportsPercent44, 4, "하부 매장" & IA_SITE & "의 충환전마일리지 차감", 0, IA_4GROUP, IA_4GROUP1, IA_4GROUP2, IA_4GROUP3, IA_4GROUP4)

					IA_MILEAGE3 = IE_AMOUNT * (IA_SportsPercent33*0.01)								'부본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IE_ID, IA_MILEAGE3, IA_SportsPercent33, 4, "하부 매장" & IA_SITE & "의 충환전마일리지 차감", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent22*0.01)								'본사에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent22, 4, "하부 매장" & IA_SITE & "의 충환전마일리지 차감", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)								'매장에 마일리지 적립
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "매장 충환전마일리지 차감", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				End If
			elseif IA_GROUP = 1 Then			'충전회원이 총판시스템일때 충전 마일리지를 총판에 업데이트
				IA_MILEAGE = IE_Amount * (IA_SportsPercent*0.01)
				Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "총판 충환전마일리지 차감", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
			End If
			UMO.Close
			Set UMO = Nothing
		End If
		
		'IE_Status를 1(환전완료)로 변경...
		UPDSQL = "UPDATE INFO_EXCHANGE SET IE_Status=1, IE_SetDate = getdate() where IE_Idx=" & IE_Idx
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IE_ID & "' AND IU_SITE = '"& IE_SITE &"' "
		SET UMO = DbCon.Execute(SQLMSG)
		CIU_Cash	= UMO(0)
		UMO.Close
		Set UMO = Nothing
		
		UPDSQL = "UPDATE INFO_USER SET IU_EXCHANGE = IU_EXCHANGE + "& RS("IE_Amount") &" where IU_ID='" & IE_ID & "'"
		DbCon.execute(UPDSQL)
				
	

		'Log_CashInOut 에 환전 기록...
		INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) select top 1 '"
		INSSQL = INSSQL & IE_ID & "', "
		INSSQL = INSSQL & IE_Amount & ","
		INSSQL = INSSQL & CIU_Cash & ", N'환전차감', '"& IE_SITE &"',iu_gtype from info_user where iu_id= '"& IE_ID &"'"
		DbCon.execute(INSSQL)

		
		BC_TITLE	= "회원님 환전이 완료되었습니다."
		BC_MANAGER	= "관리자"
		BC_WRITER	= IE_ID
		BC_CONTENTS	= "&nbsp;&nbsp;<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;안녕하세요. 운영진입니다.<br>"
		BC_CONTENTS	= BC_CONTENTS & "환전은 고객님의 계좌에 회원님의 명의로 송금됩니다."
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "신청하신 환전 처리 완료 되었습니다. "

		BC_CONTENTS	= BC_CONTENTS & "&nbsp;앞으로도 많은 이용 부탁드립니다.<br>감사합니다."
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;"
		
		JOBSITE		= IE_SITE
		            
	    SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE,BC_GTYPE)"
	    SQLSTR = SQLSTR& " select top 1 '관리자', '"& BC_WRITER &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE &"', '"&BC_MANAGER&"', 1, 1 ,iu_gtype from info_user where iu_id= '"& BC_WRITER &"'"
	    DbCon.execute(SQLSTR)    
		
	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('환전 처리가 완료되었습니다.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>