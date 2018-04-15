<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
	SETSIZE = 20
	PGSIZE = 30

    PAGE = REQUEST("PAGE")
	Search = REQUEST("Search")
	Find = Trim(REQUEST("Find"))
    sStartDate = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    
    reqIB_AMOUNT = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IB_AMOUNT")), 0, 0, 3000000)
    real_user = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("real_user")), 0, 0, 1)
    
    site = "all" 'REQUEST("JOBSITE")
        
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE"

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing


    pageSize        = 50           
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting_NEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user,1)

    'dfGameSql.debug
	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 5
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
	
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="eeeeee"> 
	<!-- <td align="center" height="30" width="40"><b>선택</b></td> -->
	<td align="center" width="50"><b>번호</b></td>
	<td align="center" width="40"><b>구분</b></td>
	<td align="center" width="80"><b>ID</b></td>
	<td align="center" width="60"><b>사이트</b></td>
	<td align="center" width="40"><b>게임수</b></td>
	<td align="center" width="60"><b>베팅비교</b></td>
	<td align="center"><b>배팅진행내역</b></td>		
	<td align="center" width="60"><b>배당율</b></td>
	<td align="center" width="90"><b>배팅액</b></td>
	<td align="center" width="90"><b>배당적중금</b></td>
	<td align="center" width="120"><b>배팅시간</b></td>		
	<td align="center" width="60"><b>결과</b></td>	
	</tr>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">현재 등록된 베팅이 없습니다.</td></tr>

<%
	ELSE

	FOR ii = 0 TO dfgameSql.RsCount -1

		IB_Idx		= dfgameSql.Rs(ii,"IB_Idx")
		IB_ID		= dfgameSql.Rs(ii,"IB_ID")
		IB_Type		= dfgameSql.Rs(ii,"IB_Type")
		IB_Num		= dfgameSql.Rs(ii,"IB_Num")
		IG_Idx		= dfgameSql.Rs(ii,"IG_Idx")
		IB_Benefit	= dfgameSql.Rs(ii,"IB_Benefit")
		IB_Amount	= dfgameSql.Rs(ii,"IB_Amount")
		IB_Status	= dfgameSql.Rs(ii,"IB_Status")
		IB_RegDate	= dfgameSql.Rs(ii,"IB_RegDate")
		IB_SITE		= dfgameSql.Rs(ii,"IB_SITE")
		IU_NICKNAME = dfgameSql.Rs(ii,"IU_NICKNAME")
		IBD_CNT		= dfgameSql.Rs(ii,"IBD_CNT")

		IF IB_Type = "M" THEN
			arr_IG_Idx = split(IG_Idx, ",")
			arrLen = Ubound(arr_IG_Idx)
			GameCnt = arrLen+1
			arr_IB_Num = split(IB_Num, ",")
			arr_IB_Benefit = split(IB_Benefit,",")
			
			BenefitRate = 1
			FOR i=0 TO arr_Len
				BenefitRate = Cdbl(BenefitRate) * Cdbl(formatnumber(arr_IB_Benefit(i),2))
			NEXT
		ELSE
			GameCnt = 1
			BenefitRate = int(IB_Benefit*100)/100
		END IF
		
		Benefit = Cdbl(BenefitRate) * Cdbl(IB_Amount)	%>

<tr bgcolor="ffffff"><!-- <td align="center"><input type="checkbox" name="SelUser" value="<%=IB_Idx%>"></td> -->
	<td align="center">
	<div onclick="ajaxRequestBet(<%=IB_Idx%>,event)" style="cursor:pointer"><%=IB_Idx%></div>
	</td>
	<td align="center"><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_TYPE&Find=<%=IB_Type%>"><% IF IB_Type = "M" THEN response.write "복식" ELSE response.write "단식" END IF %></a></td>
	<td>&nbsp;<a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_ID&Find=<%=IB_ID%>"><%=IB_ID%>(<%=iu_nickname%>)</a></td>
	<%
	If IB_SITE = "Life" Then
		response.write "<td align='center' bgcolor='#ffcccc'>"
	elseIf IB_SITE = "Media" Then
		response.write "<td align='center' bgcolor='#648ba6'>"
	Else 
		response.write "<td align='center'>"
	End If 
	%>&nbsp;<a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_SITE&Find=<%=IB_SITE%>"><%=IB_SITE%></a></td>
	<td align="center"><%=GameCnt%></td>
	<td align="center"><% If CDbl(GameCnt) <> CDbl(IBD_CNT) Then %><font color="red">비정상</font><% Else %>정상<% End If %></td>
	<td align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<% 
			IF IB_Type = "S" THEN
				StrCancel = ""

				SQLMSG = "SELECT IG_Status, IG_Result, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit FROM INFO_GAME WHERE IG_IDX = "& IG_Idx &" "
				SET RS1 = DbCon.Execute(SQLMSG)

                IF Not Rs1.Eof Then
				    IG_Status = rs1("IG_Status")
				    IG_Result = rs1("IG_Result")
                Else
                	IG_Status = "C"			    
				End IF
				

				TotalBenefitRate = IB_Benefit
				TotalBenefit = Cdbl(IB_Benefit) * Cdbl(IB_Amount)
				
				IF IG_Status = "S" OR IG_Status = "E" THEN
					ProcFlag = "FALSE"
					ResultFlag = "FALSE"
				ELSEIF IG_Status = "C" THEN
					ProcFlag = "FALSE"
					ResultFlag = "FALSE"
				ELSE
					ProcFlag = "TRUE"
					IF NOT isNull(IG_Result) Then
					    IF CStr(Trim(IG_Result)) = CStr(Trim(IB_Num)) THEN
						    ResultFlag = "TRUE"
					    ELSE
						    ResultFlag = "FALSE"
					    END IF
					End IF
				END IF
					
				IF IG_Status <> "C" THEN
					IF ProcFlag = "TRUE" and ResultFlag = "TRUE" THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:yellow;font-weight:bold;'>적중</td>"
						bgColor = "Yellow"
						bgShape = "0"
					ELSEIF ProcFlag = "TRUE" and ResultFlag = "FALSE" THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:red;font-weight:bold;'>실패</td>"
						bgColor = "Red"
						bgShape = "X"
					ELSE
						DspResult = "<td align='center' bgcolor='#777777' style='color:blue;font-weight:bold;'>진행중</td>"
						bgColor = "gray"
						bgShape = "?"
					END IF
					
				ELSE
					StrCancel = "cancel"
					
					DspResult = "<td align='center' bgcolor='#777777' style='color:white;font-weight:bold;'>취소</td>"
					bgColor = "white"
					bgShape = "취소"
				END IF
                
                IF IB_Num = 1 Then
                    bgShape = "승"
                ElseIF IB_Num = 2 Then
                    bgShape = "패"
                ElseIF IB_Num = 0 Then
                    bgShape = "무"
                End IF
		%>
		<tr bgcolor="ffffff"><td width="100%" height="20" bgcolor=<%=bgColor%> style="border:1px solid #999999;color:#333333;" align="center"><%=bgShape%></td></tr>
		<%
			ELSE
		%>
		<tr>
		<%
			TotalBenefitRate = 1
			
			ProcFlag = "TRUE"
			ResultFlag = "TRUE"
			
			StrProc = ""
			StrResult = ""
			StrCancel = ""
			
			CancelCnt = 0
			
			FOR i=0 TO arrLen
			
				cellWidth = (100 / Cint(arrLen+1)) & "%"
				
				SQLMSG = "SELECT IG_Status, IG_Result, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Team1, IG_Team2 FROM INFO_GAME WHERE IG_IDX = "& arr_IG_Idx(i) &" "
				SET RS1 = DbCon.Execute(SQLMSG)

                IF Not Rs1.Eof Then
				    IG_Status = rs1("IG_Status")
				    IG_Result = rs1("IG_Result")
                Else
                	IG_Status = "C"			    
				End IF
				BenefitRate = arr_IB_Benefit(i)
				

				
				IF IG_Status <> "C" THEN
					
					'// 게임이 아직 끝나지 않았으면...
					IF IG_Status = "S" OR IG_Status = "E" THEN
						ProcFlag = "FALSE"
						ResultFlag = "TRUE"
					ELSE
						ProcFlag = "TRUE"
						'// 게임종료...적중실패...
						IF NOT isNull(IG_Result) Then
						    IF CStr(Trim(IG_Result)) <> CStr(Trim(arr_IB_Num(i))) THEN
							    ResultFlag = "FALSE"
						    ELSE
							    ResultFlag = "TRUE"
						    END IF
						End IF

										
					END IF
				ELSE
					ProcFlag = "TRUE"
					ResultFlag = "TRUE"
				END IF
					
				StrProc = StrProc & "," & ProcFlag
				StrResult = StrResult & "," & ResultFlag
				
				IF IG_Status <> "C" THEN
					IF ProcFlag = "TRUE" AND ResultFlag = "TRUE" THEN
						bgColor = "yellow"
						bgShape = "0"
					ELSEIF ProcFlag = "TRUE" AND ResultFlag = "FALSE" THEN
						bgColor = "red"
						bgShape = "X"
					ELSE
						bgColor = "gray"
						bgShape = "?"
					END IF
				ELSE
					'// StrCancel = "cancel"
					CancelCnt = CancelCnt+1					
					bgColor = "white"
					bgShape = "취소"
				END IF
				
                IF arr_IB_Num(i) = 1 Then
                    bgShape = "승"
                ElseIF arr_IB_Num(i) = 2 Then
                    bgShape = "패"
                ElseIF arr_IB_Num(i) = 0 Then
                    bgShape = "무"
                End IF
                				
		%>
			<td height="20" width="<%=cellWidth%>" bgcolor="<%=bgColor%>" style="border:1px solid #999999;color:#333333;" align="center"><%=bgShape%></td>
		<%
				IF IG_Status <> "C" THEN
					'// 취소된 경기의 배당율은 곱하지 않는다...
					TotalBenefitRate = Cdbl(TotalBenefitRate) * 100 * Cdbl(BenefitRate) * 100 / 10000
				END IF
			NEXT
			
			TotalBenefit = numdel(TotalBenefitRate) * Cdbl(IB_Amount)
									
			'// 최종 승패결과...
			find_proc = Instr(StrProc,"FALSE")
			find_result = Instr(StrResult,"FALSE")
			
			IF Cint(CancelCnt) = Cint(arrLen)+1 THEN
				DspResult = "<td align='center' bgcolor='#777777' style='color:white;font-weight:bold;'>취소</td>"
			ELSE
				IF find_result = 0 THEN 			'// 결과에 false가 없을때...
					IF find_proc = 0 THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:yellow;font-weight:bold;'>적중</td>"
					ELSE
						DspResult = "<td align='center' bgcolor='#777777' style='color:blue;font-weight:bold;'>진행중</td>"
					END IF
				ELSE
					DspResult = "<td align='center' bgcolor='#777777' style='color:red;font-weight:bold;'>실패</td>"
				END IF
			END IF
		%>
			</tr>
		<%
			RS1.Close
			Set RS1 = Nothing

			END IF
		%></table></td>		
	<td align="right"><%=numdel(TotalBenefitRate)%>&nbsp;</td>
	<td align="right"><%=formatnumber(IB_Amount,0)%>원&nbsp;</td>
	<td align="right"><%=formatnumber(int(TotalBenefit*100)/100,0)%>원&nbsp;</td>
	<td align="center"><%=dfStringUtil.GetFullDate(IB_RegDate)%></td>		
	<%=DspResult%>
	
	</tr>
<tr id="tr<%= IB_Idx %>" style="display:none;" >
    <td colspan="13" bgcolor="ffffff">
        <iframe id="iframe<%= IB_Idx %>" frameborder="0" ></iframe>
    </td>
</tr>
	<%  
		Next 
	%>
		
	<% END IF %>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

</form>

</body>
</html>

