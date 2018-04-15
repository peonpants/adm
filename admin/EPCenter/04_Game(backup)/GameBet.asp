<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	GIG_IDX		= REQUEST("IG_IDX")
	GIB_NUM		= REQUEST("IB_NUM")

	IF GIB_NUM = "0" THEN
		SQLMSG = "SELECT IG_TEAM1, IG_TEAM2, IG_DRAWBENEFIT, IG_DRAWBETTING FROM INFO_GAME WHERE IG_IDX = '"& GIG_IDX &"' "
		SET RS = DbCon.Execute(SQLMSG)

		TEAMNAME	= RS(0)&" : "&RS(1)
		BENEFIT		= RS(2)
		BETTING		= RS(3)
	ELSEIF GIB_NUM = "1" THEN
		SQLMSG = "SELECT IG_TEAM1, IG_TEAM1BENEFIT, IG_TEAM1BETTING FROM INFO_GAME WHERE IG_IDX = '"& GIG_IDX &"' "
		SET RS = DbCon.Execute(SQLMSG)

		TEAMNAME	= RS(0)&"승"
		BENEFIT		= RS(1)
		BETTING		= RS(2)
	ELSEIF GIB_NUM = "2" THEN
		SQLMSG = "SELECT IG_TEAM1, IG_TEAM2BENEFIT, IG_TEAM2BETTING FROM INFO_GAME WHERE IG_IDX = '"& GIG_IDX &"' "
		SET RS = DbCon.Execute(SQLMSG)

		TEAMNAME	= RS(0)&"패"
		BENEFIT		= RS(1)
		BETTING		= RS(2)
	END IF

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title>게임 배팅 내역</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!-- <script src="/Sc/Base.js"></script> --></head>

<body marginheight="0" marginwidth="0">
<a href="GameBet_New.asp?IG_IDX=<%= GIG_IDX %>" target="_blank">해당 경기 배팅 내역보기</a>
<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
<tr height="25"><td align="center" colspan="4"><b><% IF IB_NUM = "0" THEN %><%=TEAMNAME%> 무승부 배팅내역<% ELSE %><%=TEAMNAME%> 배팅내역<% END IF %></b></td></tr>
<tr height="25">
	<td width="25%" align="center">배 당 율</td>
	<td width="25%" align="right"><%=BENEFIT%> %&nbsp;</td>
	<td width="25%" align="center">배팅금액</td>
	<td width="25%" align="right"><%=FORMATNUMBER(BETTING,0)%> 원&nbsp;</td></tr></table><br clear="all">

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr bgcolor="e7e7e7"> 
	<td align="center" width="40"><b>번호</b></td>
	<td align="center"><b>아이디</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>배팅금액</b></td>
	<td align="center"><b>배당금액</b></td></tr>

<%
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT IB_TYPE, IB_IDX, IB_ID, IG_IDX, IB_NUM, IB_AMOUNT, IB_SITE  FROM INFO_BETTING WHERE IB_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL = 9) AND IG_IDX LIKE '%"&GIG_IDX&"%' ORDER BY IB_IDX ASC", DbCon, 1

	IF NOT RS.EOF THEN

		NN = 0
		BetMoney = 0
		TBetMoney = 0
		
		DO UNTIL RS.EOF

			IB_TYPE			= RS("IB_TYPE")
			IB_IDX			= RS("IB_IDX")
			IB_ID			= RS("IB_ID")
			IB_AMOUNT		= RS("IB_AMOUNT")
			IB_SITE			= RS("IB_SITE")

			IF IB_TYPE = "M" THEN
				arr_IG_Idx		= SPLIT(RS("IG_IDX"), ",")
				arrLen			= UBOUND(arr_IG_Idx)
				arr_IB_Num		= SPLIT(RS("IB_NUM"), ",")

				FOR i=0 TO arrLen
					IF cdbl(arr_IG_Idx(i)) = cdbl(GIG_IDX) THEN
						IF cdbl(arr_IB_Num(i)) = cdbl(GIB_NUM) THEN
							NN = NN + 1
							RESPONSE.WRITE "<tr><td bgcolor='FFFFFF' align='center'>"&NN&"</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_ID&"</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_SITE&"</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT,0)&" 원&nbsp;</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT * BENEFIT,0)&" 원&nbsp;</td></tr>"
							BetMoney  = BetMoney + IB_AMOUNT
							TBetMoney = TBetMoney + (IB_AMOUNT * BENEFIT)
						ELSE
							EXIT FOR
						END IF
					END IF
				NEXT
			ELSEIF IB_TYPE = "S" THEN
				IG_IDX		= RS("IG_IDX")
				IB_NUM		=RS("IB_NUM")

				IF GIB_NUM = IB_NUM THEN
					NN = NN + 1
					RESPONSE.WRITE "<tr><td bgcolor='FFFFFF' align='center'>"&NN&"</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_ID&"</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_SITE&"</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT,0)&" 원&nbsp;</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT * BENEFIT,0)&" 원&nbsp;</td></tr>"
					BetMoney  = BetMoney + IB_AMOUNT
					TBetMoney = TBetMoney + (IB_AMOUNT * BENEFIT)
				END IF
			END IF
			
		RS.MoveNext
		LOOP
	
	END IF	%>
<tr bgcolor="#FFFFFF" height="25">
<td colspan="3" bgcolor="#FFFFFF" align="center"><b>합&nbsp;&nbsp;&nbsp;계</b></td>
	<td bgcolor="#FFFFFF" align="right"><b><%=FORMATNUMBER(BetMoney,0)%> 원</b>&nbsp;</td>
	<td bgcolor="#FFFFFF" align="right"><b><%=FORMATNUMBER(TBetMoney,0)%> 원</b>&nbsp;</td></tr></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>