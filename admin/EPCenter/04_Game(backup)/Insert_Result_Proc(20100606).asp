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
	
	'2 �������
	'1 �ڵ�ĸ
	'0 ������
	IF IG_TYPE = "2" THEN 
		IF Cdbl(IG_HANDICAP) < Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			WinTeam = 1
		ElseIf Cdbl(IG_HANDICAP) = Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			%><script>location.href="Game_Mo.asp?IG_IDX=<%=IG_IDX%>&page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";</script><%
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
			%><script>location.href="Game_Mo.asp?IG_IDX=<%=IG_IDX%>&page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";</script><%
			response.end
		Else 
			WinTeam = 0
		END IF
	END IF 


	'���Ӹ���Ʈ �¸����� �ݿ�
	UPDSQL = "Update Info_Game set IG_Score1=" & IG_Score1 & ", IG_Score2=" & IG_Score2 & ", IG_Result=" & WinTeam & ", IG_Status='F'"
	UPDSQL = UPDSQL & " where IG_Idx=" & IG_Idx
	DbCon.Execute (UPDSQL)



	'�ܽİ��� ���
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

				'����� ��÷�� ���
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
				INSSQL = INSSQL & CIU_Cash & ",'���ù��', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)

            ELSE
            '				
			END IF
			
			'���ø���Ʈ ��������(IB_Status=9)
			UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1 WHERE IB_IDX = "&IB_IDX
			DbCon.execute(UPDSQL)
			
		RS.MoveNext
		LOOP
	
	END IF




			
	'���İ��� ����
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

				IG_STATUS		= RS1(0)
				IG_RESULT		= RS1(1)

				IF IG_Status <> "C" THEN													'��� ��Ⱑ �ƴϸ�
					IF IG_Status = "F" THEN													'���� ����� ���
						IF Cint(arr_IB_Num(i)) = Cint(IG_RESULT) THEN						'��� ���ڸ� ������ ���
							TotalBenefit = Cdbl(TotalBenefit) * Cdbl(arr_IB_Benefit(i)) 
						ELSE																'��� ���ڸ� �� ������ ���
							ResultFlag = "FALSE"

							'���ø���Ʈ ��������(IB_Status=1)
							UPDSQL = "UPDATE INFO_BETTING SET IB_STATUS = 1 WHERE IB_IDX = "& IB_IDX
							DbCon.execute(UPDSQL)
							EXIT FOR
						END IF
					ELSE																	'���� ����� ���
						ProcFlag = "FALSE"
						Exit for
					END IF
				END IF

			NEXT


			'�������� �������� ���
			IF ProcFlag = "TRUE" and ResultFlag = "TRUE" THEN
				BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
				
				'����� ��÷�� ���
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
				INSSQL = INSSQL & CIU_Cash & ",'���ù��', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)
				
				'���ø���Ʈ ��������(IB_Status=9)
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1 WHERE IB_IDX = "&IB_IDX
				DbCon.execute(UPDSQL)

				
            Else
                '###### ���������� ����
			END IF
		
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
<script>
	var goUrl="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	opener.top.ViewFrm.location.href=goUrl;
	self.close();
</script>