<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->
<!-- #include virtual="/_Global/functions.asp" -->
<!-- #include virtual="/_Global/ASocket.inc" -->

<%
	Dim smsVariant

	IG_IDX		= REQUEST("IG_IDX")

	UPDSQL = "UPDATE INFO_GAME SET IG_Status = 'C' "
	UPDSQL = UPDSQL & " WHERE IG_IDX = " & IG_IDX
	DbCon.Execute (UPDSQL)
	
	'�ܽİ��� ���
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT IB_IDX, IB_ID, IB_AMOUNT, IB_SITE FROM INFO_BETTING WHERE IB_TYPE = 'S' AND IB_STATUS = 0 AND IG_IDX = '"&IG_IDX&"' ORDER BY IB_IDX ASC", DbCon, 1

	IF NOT RS.EOF THEN
		
		DO UNTIL RS.EOF
			IB_IDX		= RS("IB_IDX")
			IB_ID		= RS("IB_ID")
			IB_AMOUNT	= RS("IB_AMOUNT")
			IB_SITE		= RS("IB_SITE")
			
			'����� ���ñݾ� ��ȯ
			UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
			DbCon.execute(UPDSQL)

			SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
			SET UMO = DbCon.Execute(SQLMSG)

			CIU_Cash	= UMO(0)

			UMO.Close
			Set UMO = Nothing

			'ĳ���α� ���
			INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
			INSSQL = INSSQL & IB_ID & "', "
			INSSQL = INSSQL & int(IB_Amount) & ","
			INSSQL = INSSQL & CIU_Cash & ", '�������', '"& IB_SITE &"')"
			DbCon.execute(INSSQL)
			
			'���ø���Ʈ ��������(IB_Status=9)
			UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 9 WHERE IB_IDX = "&IB_IDX
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
			
			'���ø���Ʈ���� �������� ��ҵƳ� Ȯ��
			CancelCnt = 0
			FOR i=0 TO arrLen

				SQLMSG = "SELECT IG_STATUS, IG_RESULT FROM INFO_GAME WHERE IG_IDX = '"& arr_IG_Idx(i) &"' "
				SET RS1 = DbCon.Execute(SQLMSG)

				IG_STATUS		= RS1(0)
				IG_RESULT		= RS1(1)

				IF IG_STATUS = "C" THEN
					CancelCnt = CancelCnt + 1
				END IF

				IF ProcFlag = "TRUE" AND ResultFlag = "TRUE" THEN
					IF IG_STATUS <> "C" THEN													'��� ��Ⱑ �ƴ� ���
						IF IG_STATUS = "F" THEN													'���� ����� ���
							IF Cint(arr_IB_Num(i)) = Cint(IG_RESULT) THEN						'��� ���ڸ� ������ ���
								TotalBenefit = Cdbl(TotalBenefit)  * Cdbl(arr_IB_Benefit(i)) 
							ELSE																'��� ���ڸ� �� ������ ���
								ResultFlag = "FALSE"
							END IF
						ELSE																	'���� ����� ���
							ProcFlag = "FALSE"
						END IF
					END IF
				END IF

			NEXT


			'��� ��Ⱑ ��ҵǾ��� ���
			IF Cint(CancelCnt) = Cint(arrlen)+1 THEN

				'����� ���ñݾ� ��ȯ
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				SET UMO = DbCon.Execute(SQLMSG)

				CIU_Cash	= UMO(0)

				UMO.Close
				Set UMO = Nothing
				
				'ĳ���α� ���
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & int(IB_Amount) & ","
				INSSQL = INSSQL & CIU_Cash & ", '�������', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)
				
				'���ø���Ʈ ��������(IB_Status=9)
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 9 WHERE IB_IDX = "&IB_IDX
				DbCon.execute(UPDSQL)


			'�ش� ��� �ּ� -> ��� ����� ����� ������ ���
			ELSE

				'// �������� ����������...
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
					
					'ĳ���α� ���
					INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
					INSSQL = INSSQL & IB_ID & "', "
					INSSQL = INSSQL & numdel2(BenefitAmount) & ","
					INSSQL = INSSQL & CIU_Cash & ",'���ù��', '"& IB_SITE &"')"
					DbCon.execute(INSSQL)
					
					'���ø���Ʈ ��������(IB_Status=9)
					UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_GOOD = 1 WHERE IB_IDX = "&IB_IDX
					DbCon.execute(UPDSQL)

				

				END IF

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
	alert("�����Ͻ� ������ ��ҵǾ����ϴ�.");
	top.ViewFrm.location.reload();
</script>