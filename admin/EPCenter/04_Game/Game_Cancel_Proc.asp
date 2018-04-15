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
	
	'단식게임 취소
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT IB_IDX, IB_ID, IB_AMOUNT, IB_SITE FROM INFO_BETTING WHERE IB_TYPE = 'S' AND IB_STATUS = 0 AND IG_IDX = '"&IG_IDX&"' ORDER BY IB_IDX ASC", DbCon, 1

	IF NOT RS.EOF THEN
		
		DO UNTIL RS.EOF
			IB_IDX		= RS("IB_IDX")
			IB_ID		= RS("IB_ID")
			IB_AMOUNT	= RS("IB_AMOUNT")
			IB_SITE		= RS("IB_SITE")
			
			'사용자 배팅금액 반환
			UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
			DbCon.execute(UPDSQL)

			SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
			SET UMO = DbCon.Execute(SQLMSG)

			CIU_Cash	= UMO(0)

			UMO.Close
			Set UMO = Nothing

			'캐쉬로그 등록
			INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
			INSSQL = INSSQL & IB_ID & "', "
			INSSQL = INSSQL & int(IB_Amount) & ","
			INSSQL = INSSQL & CIU_Cash & ", '배팅취소', '"& IB_SITE &"')"
			DbCon.execute(INSSQL)
			
			'배팅리스트 정산종료(IB_Status=9)
			UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 9 WHERE IB_IDX = "&IB_IDX
			DbCon.execute(UPDSQL)
			
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
			
			'배팅리스트에서 모든게임이 취소됐나 확인
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
					IF IG_STATUS <> "C" THEN													'취소 경기가 아닐 경우
						IF IG_STATUS = "F" THEN													'종료 경기인 경우
							IF Cint(arr_IB_Num(i)) = Cint(IG_RESULT) THEN						'경기 승자를 맞췄을 경우
								TotalBenefit = Cdbl(TotalBenefit)  * Cdbl(arr_IB_Benefit(i)) 
							ELSE																'경기 승자를 못 맞췄을 경우
								ResultFlag = "FALSE"
							END IF
						ELSE																	'진행 경기인 경우
							ProcFlag = "FALSE"
						END IF
					END IF
				END IF

			NEXT


			'모든 경기가 취소되었을 경우
			IF Cint(CancelCnt) = Cint(arrlen)+1 THEN

				'사용자 배팅금액 반환
				UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				DbCon.execute(UPDSQL)

				SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
				SET UMO = DbCon.Execute(SQLMSG)

				CIU_Cash	= UMO(0)

				UMO.Close
				Set UMO = Nothing
				
				'캐쉬로그 등록
				INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
				INSSQL = INSSQL & IB_ID & "', "
				INSSQL = INSSQL & int(IB_Amount) & ","
				INSSQL = INSSQL & CIU_Cash & ", '배팅취소', '"& IB_SITE &"')"
				DbCon.execute(INSSQL)
				
				'배팅리스트 정산종료(IB_Status=9)
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 9 WHERE IB_IDX = "&IB_IDX
				DbCon.execute(UPDSQL)


			'해당 경기 최소 -> 모든 경기의 결과가 나왔을 경우
			ELSE

				'// 모든게임이 적중했으면...
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
					
					'캐쉬로그 등록
					INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( '"
					INSSQL = INSSQL & IB_ID & "', "
					INSSQL = INSSQL & numdel2(BenefitAmount) & ","
					INSSQL = INSSQL & CIU_Cash & ",'배팅배당', '"& IB_SITE &"')"
					DbCon.execute(INSSQL)
					
					'배팅리스트 정산종료(IB_Status=9)
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
	alert("선택하신 게임이 취소되었습니다.");
	top.ViewFrm.location.reload();
</script>