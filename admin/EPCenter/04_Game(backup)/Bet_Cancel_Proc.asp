<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IB_Idx		= REQUEST("IB_Idx")

	SSQL = "SELECT ib_idx, ib_id, ib_type, ig_idx, ib_num, ib_benefit, ib_amount, ib_status, ib_regdate, ib_site FROM info_betting where ib_idx = "& ib_idx

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SSQL, DbCon, 1

	IF NOT RS.EOF THEN
		 
		DO UNTIL RS.EOF
			If CInt(RS("ib_status")) < 1 Then 
			    IB_IDX		= RS("IB_IDX")
			    IB_ID		= RS("IB_ID")
			    IB_AMOUNT	= RS("IB_AMOUNT")
			    IB_SITE		= RS("IB_SITE")

    			
			    '사용자 배팅금액 반환
			    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = N'"& IB_SITE &"'"
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
			    INSSQL = INSSQL & CIU_Cash & ", N'배팅취소', N'"& IB_SITE &"')"
			    DbCon.execute(INSSQL)
    			
			    '배팅리스트 정산종료(IB_Status=9)
			    UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_SITE = 'None' WHERE IB_IDX = "&IB_IDX
			    DbCon.execute(UPDSQL)
			End If 
		RS.MoveNext
		LOOP
	
	END IF

	'DSQL = "delete info_betting where ib_idx= " & ib_idx
	'DbCon.Execute (DSQL)
	


	RS.Close
	Set RS = Nothing	

	DbCon.Close
	Set DbCon=Nothing
%>

<script>
	alert("선택하신 배팅이 취소되었습니다.");
	parent.location.reload();
</script>