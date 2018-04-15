<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IB_Idx		= REQUEST("IB_Idx")

	SSQL = "SELECT ib_idx, ib_id, ib_type, ig_idx, ib_num, ib_benefit, ib_amount, ib_status, ib_regdate, ib_site FROM info_betting where ib_idx = "& ib_idx

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SSQL, DbCon, 1

	IF NOT RS.EOF THEN
		 
			'배팅시간지나면 취소안됨.
			IG_IDX		= RS("ig_idx")
			
			SSSQL = "SELECT top 1 (CASE WHEN ig_starttime >= getdate() THEN 'T' ELSE 'F' END) AS r_grade FROM info_game where ig_idx in ("& ig_idx &") order by ig_starttime " 

			Set RS1 = Server.CreateObject("ADODB.Recordset")
			RS1.Open SSSQL, DbCon, 1
				IF NOT RS1.EOF THEN
			
					IG_STARTTIME = RS1("r_grade")
					
					'admin일 경우에는 배팅취소가능
					IF Request.Cookies("AdminID") <> "admin" Then
						IF (IG_STARTTIME = "F") THEN
							WITH RESPONSE
								.WRITE "<script>" & vbcrlf
								.WRITE "alert('경기 시간이 지나 배팅을 취소하실 수 없습니다.');" & vbcrlf
								.WRITE "parent.location.reload();" & vbcrlf
								.WRITE "</script>"
								.END
							END WITH
		
						END IF
					END IF
				END IF
			RS1.Close
			Set RS1 = Nothing

		DO UNTIL RS.EOF
			If CInt(RS("ib_status")) < 1 Then 
			    IB_IDX		= RS("IB_IDX")
			    IB_ID		= RS("IB_ID")
			    IB_AMOUNT	= RS("IB_AMOUNT")
			    IB_SITE		= RS("IB_SITE")

				igidx		= RS("ig_idx")
				ibnum		= RS("ib_num")
    			

    			
			    '사용자 배팅금액 반환
			    UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash + "&int(IB_AMOUNT)&" WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = N'"& IB_SITE &"'"
			    DbCon.execute(UPDSQL)

			    SQLMSG = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & IB_ID & "' AND IU_SITE = '"& IB_SITE &"'"
			    SET UMO = DbCon.Execute(SQLMSG)

			    CIU_Cash	= UMO(0)

			    UMO.Close
			    Set UMO = Nothing

			    '캐쉬로그 등록
			    INSSQL = "INSERT INTO LOG_CASHINOUT( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_GTYPE) SELECT TOP 1 '"
			    INSSQL = INSSQL & IB_ID & "', "
			    INSSQL = INSSQL & int(IB_Amount) & ","
			    INSSQL = INSSQL & CIU_Cash & ", N'배팅취소', N'"& IB_SITE &"',IU_GTYPE from info_user where iu_id= '"& IB_ID &"'"
			    DbCon.execute(INSSQL)
    			
			    '배팅리스트 정산종료(IB_Status=9)
			    'UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1, IB_SITE = 'None' WHERE IB_IDX = "&IB_IDX
				UPDSQL = "UPDATE INFO_BETTING SET IB_Status = 1,IB_CREGER = '" & AdminID & "', IB_SITE='None' WHERE IB_IDX = "&IB_IDX
			    DbCon.execute(UPDSQL)

				arrIG_Idx = SPLIT(igidx, ",")
				arrIB_NUM = SPLIT(ibnum, ",")
				TotalCnt	= ubound(arrIG_Idx)
'response.write TotalCnt & "<br>"
				FOR fi=0 to TotalCnt
					
					If Trim(arrIB_NUM(fi)) = "1" Then
						UPDSQL = "update info_game Set ig_team1betting = ig_team1betting - " & IB_AMOUNT & ", ig_team1bet_cnt = ig_team1bet_cnt-1 where ig_idx= "&arrIG_Idx(fi)
						DbCon.execute(UPDSQL)					
					ElseIf Trim(arrIB_NUM(fi)) = "0" Then
						UPDSQL = "update info_game Set IG_DRAWBETTING = IG_DRAWBETTING - " & IB_AMOUNT & ", IG_DRAWBET_CNT = IG_DRAWBET_CNT-1 where ig_idx= "&arrIG_Idx(fi)
						DbCon.execute(UPDSQL)	
					ElseIf Trim(arrIB_NUM(fi)) = "2" Then
						UPDSQL = "update info_game Set ig_team2betting = ig_team2betting - " & IB_AMOUNT & ", ig_team2bet_cnt = ig_team2bet_cnt-1 where ig_idx= "&arrIG_Idx(fi)
						DbCon.execute(UPDSQL)	
					END IF
					
					
					'Call dfgameSql.UpdateSET_CANCEL_GAME(dfDBConn.Conn, arrIG_Idx(fi),arrIB_NUM(fi),IB_IDX)
				'response.write arrIG_Idx(fi) & "<br>"	
				'response.write arrIB_NUM(fi) & "<br>"	
					
				NEXT
			End If 
		RS.MoveNext
		LOOP
	
	END IF
'response.end
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