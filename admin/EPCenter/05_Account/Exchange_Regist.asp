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
'�����۾��� �������� �Ӵ������� charge_regists.asp.bak�� �Űܳ��� 2017/09/15
    '######### ��� ����                    ################	
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
				.write "alert('ȯ�� ó���� ���� �Դϴ�.\n�ٽ� �ѹ� Ȯ�� �ּ���.');" & VbCrLf
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

		'���� �׷��� Ȯ��
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

			'����ȸ���� ����ý����϶�
			If IA_GROUP = 2 Then
				If IA_LEVEL = 2 Then		'���翡 ���ϸ��� ����
					IA_MILEAGE = IE_Amount * (IA_SportsPercent*0.01)
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "���� ��ȯ�����ϸ��� ����", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				ElseIf IA_LEVEL = 3 Then		'�κ��翡 ���ϸ��� ����
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

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent2*0.01)	'���翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent2, 4, "�Ϻ� �κ��� " & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_1GROUP, IA_1GROUP1, IA_1GROUP2, IA_1GROUP3, IA_1GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)	'�κ��翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "�κ��� ��ȯ�����ϸ��� ����", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)

				ElseIf IA_LEVEL = 4 Then		'���ǿ� ���ϸ��� ����
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

					IA_SportsPercent3 = IA_SportsPercent3 - IA_SportsPercent						'�κ���

					IA_SportsPercent2 = IA_SportsPercent2 - IA_SportsPercent3 - IA_SportsPercent	'����

					IA_MILEAGE3 = IE_AMOUNT * (IA_SportsPercent3*0.01)								'�κ��翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IE_ID, IA_MILEAGE3, IA_SportsPercent3, 4, "�Ϻ� ����" & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent2*0.01)								'���翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent2, 4, "�Ϻ� ����" & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)								'���ǿ� ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "���� ��ȯ�����ϸ��� ����", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				ElseIf IA_LEVEL = 5 Then		'���忡 ���ϸ��� ����
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

					IA_SportsPercent22 = IA_SportsPercent2 - (IA_SportsPercent3 - IA_SportsPercent4) - (IA_SportsPercent4 - IA_SportsPercent) - IA_SportsPercent	'�����ۼ�Ʈ

					IA_SportsPercent44 = IA_SportsPercent4 - IA_SportsPercent						'�����ۼ�Ʈ

					IA_SportsPercent33 = IA_SportsPercent3 - (IA_SportsPercent4 - IA_SportsPercent) - IA_SportsPercent	'�κ����ۼ�Ʈ

					IA_MILEAGE4 = IE_AMOUNT * (IA_SportsPercent44*0.01)								'���ǿ� ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE4, IE_ID, IA_MILEAGE4, IA_SportsPercent44, 4, "�Ϻ� ����" & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_4GROUP, IA_4GROUP1, IA_4GROUP2, IA_4GROUP3, IA_4GROUP4)

					IA_MILEAGE3 = IE_AMOUNT * (IA_SportsPercent33*0.01)								'�κ��翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE3, IE_ID, IA_MILEAGE3, IA_SportsPercent33, 4, "�Ϻ� ����" & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_3GROUP, IA_3GROUP1, IA_3GROUP2, IA_3GROUP3, IA_3GROUP4)

					IA_MILEAGE2 = IE_AMOUNT * (IA_SportsPercent22*0.01)								'���翡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE2, IE_ID, IA_MILEAGE2, IA_SportsPercent22, 4, "�Ϻ� ����" & IA_SITE & "�� ��ȯ�����ϸ��� ����", 0, IA_2GROUP, IA_2GROUP1, IA_2GROUP2, IA_2GROUP3, IA_2GROUP4)

					IA_MILEAGE = IE_AMOUNT * (IA_SportsPercent*0.01)								'���忡 ���ϸ��� ����
					Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "���� ��ȯ�����ϸ��� ����", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
				End If
			elseif IA_GROUP = 1 Then			'����ȸ���� ���ǽý����϶� ���� ���ϸ����� ���ǿ� ������Ʈ
				IA_MILEAGE = IE_Amount * (IA_SportsPercent*0.01)
				Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT(dfDBConn.Conn, IA_SITE, IE_ID, IA_MILEAGE, IA_SportsPercent, 3, "���� ��ȯ�����ϸ��� ����", IE_Amount, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
			End If
			UMO.Close
			Set UMO = Nothing
		End If
		
		'IE_Status�� 1(ȯ���Ϸ�)�� ����...
		UPDSQL = "UPDATE INFO_EXCHANGE SET IE_Status=1, IE_SetDate = getdate() where IE_Idx=" & IE_Idx
		DbCon.execute(UPDSQL)

		SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID='" & IE_ID & "' AND IU_SITE = '"& IE_SITE &"' "
		SET UMO = DbCon.Execute(SQLMSG)
		CIU_Cash	= UMO(0)
		UMO.Close
		Set UMO = Nothing
		
		UPDSQL = "UPDATE INFO_USER SET IU_EXCHANGE = IU_EXCHANGE + "& RS("IE_Amount") &" where IU_ID='" & IE_ID & "'"
		DbCon.execute(UPDSQL)
				
	

		'Log_CashInOut �� ȯ�� ���...
		INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) select top 1 '"
		INSSQL = INSSQL & IE_ID & "', "
		INSSQL = INSSQL & IE_Amount & ","
		INSSQL = INSSQL & CIU_Cash & ", N'ȯ������', '"& IE_SITE &"',iu_gtype from info_user where iu_id= '"& IE_ID &"'"
		DbCon.execute(INSSQL)

		
		BC_TITLE	= "ȸ���� ȯ���� �Ϸ�Ǿ����ϴ�."
		BC_MANAGER	= "������"
		BC_WRITER	= IE_ID
		BC_CONTENTS	= "&nbsp;&nbsp;<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;�ȳ��ϼ���. ����Դϴ�.<br>"
		BC_CONTENTS	= BC_CONTENTS & "ȯ���� ������ ���¿� ȸ������ ���Ƿ� �۱ݵ˴ϴ�."
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "��û�Ͻ� ȯ�� ó�� �Ϸ� �Ǿ����ϴ�. "

		BC_CONTENTS	= BC_CONTENTS & "&nbsp;�����ε� ���� �̿� ��Ź�帳�ϴ�.<br>�����մϴ�."
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;"
		
		JOBSITE		= IE_SITE
		            
	    SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE,BC_GTYPE)"
	    SQLSTR = SQLSTR& " select top 1 '������', '"& BC_WRITER &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE &"', '"&BC_MANAGER&"', 1, 1 ,iu_gtype from info_user where iu_id= '"& BC_WRITER &"'"
	    DbCon.execute(SQLSTR)    
		
	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('ȯ�� ó���� �Ϸ�Ǿ����ϴ�.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>