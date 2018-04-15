<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->

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
<script type="text/javascript">
	function goBatdel(gidx) {
		if (!confirm("정말 취소하시겠습니까?\n\n취소시 해당 배팅에 대한 환불처리가 이루어 집니다.")) return;		
		exeFrame.location.href="Bet_Cancel_Proc.asp?IB_Idx="+gidx;
	}
</script>
<iframe name="exeFrame" id="Iframe1" width=0 height=0 frameborder=0></iframe>
<body marginheight="0" marginwidth="0">
<center>
<input type="button" value="해당 경기 배팅 내역보기" class="input" style="width:470px;height:50px;background:#000000;color:#ffffff;font-size:15px;" onclick="window.open('GameBet_New.asp?IG_IDX=<%= GIG_IDX %>')" />
</center>
<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
<tr height="25"><td align="center" colspan="4"><b><% IF IB_NUM = "0" THEN %><%=TEAMNAME%> 무승부 배팅내역<% ELSE %><%=TEAMNAME%> 배팅내역<% END IF %></b></td></tr>
<tr height="25">
	<td width="25%" align="center">배 당 율</td>
	<td width="25%" align="right"><%=BENEFIT%> %&nbsp;</td>
	<td width="25%" align="center">배팅금액</td>
	<td width="25%" align="right"><%=FORMATNUMBER(BETTING,0)%> 원&nbsp;</td>
</tr>
</table>
<br clear="all">
<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
<tr>
    <td height="25" align="center" >최초배팅</td>
    <td align="center">홈배당</td>
    <td align="center">무배당</td>
    <td align="center">기준점</td>
    <td align="center">원정배당</td>       
</tr>
<%
     SQLMSG =    "select " & _
                "(select isNull(sum(ib_amount),0) from info_betting  " & _
                "where IB_IDX >= A.MIN_IDX and IB_IDX < A.MAX_IDX  " & _
                "And IB_IDX IN (select IB_IDX from info_betting_detail where IG_IDX= "& GIG_IDX &" And IBD_NUM = 1 AND IG_TEAM1BENEFIT = A.IG_TEAM1BENEFIT AND IG_TEAM2BENEFIT = A.IG_TEAM2BENEFIT AND IG_DRAWBENEFIT = A.IG_DRAWBENEFIT AND IG_HANDICAP = A.IG_HANDICAP)   " & _
                "AND IB_SITE <> 'None' " & _
                ") AS TEAM1_AMOUNT , " & _
                "(select isNull(sum(ib_amount),0) from info_betting  " & _
                "where IB_IDX >= A.MIN_IDX and IB_IDX < A.MAX_IDX  " & _
                "And IB_IDX IN (select IB_IDX from info_betting_detail where IG_IDX=  "& GIG_IDX &" And IBD_NUM = 0 AND IG_TEAM1BENEFIT = A.IG_TEAM1BENEFIT AND IG_TEAM2BENEFIT = A.IG_TEAM2BENEFIT AND IG_DRAWBENEFIT = A.IG_DRAWBENEFIT AND IG_HANDICAP = A.IG_HANDICAP)   " & _
                "AND IB_SITE <> 'None' " & _
                ") AS DRAW_AMOUNT , " & _
                "(select isNull(sum(ib_amount),0) from info_betting  " & _
                "where IB_IDX >= A.MIN_IDX and IB_IDX < A.MAX_IDX  " & _
                "And IB_IDX IN (select IB_IDX from info_betting_detail where IG_IDX=  "& GIG_IDX &" And IBD_NUM = 2 AND IG_TEAM1BENEFIT = A.IG_TEAM1BENEFIT AND IG_TEAM2BENEFIT = A.IG_TEAM2BENEFIT AND IG_DRAWBENEFIT = A.IG_DRAWBENEFIT AND IG_HANDICAP = A.IG_HANDICAP)   " & _
                "AND IB_SITE <> 'None' " & _
                ") AS TEAM2_AMOUNT, " & _
                "  A.MIN_IDX, A.MAX_IDX, A.IG_TEAM1BENEFIT, A.IG_TEAM2BENEFIT, A.IG_DRAWBENEFIT, A.IG_HANDICAP , IB.IB_REGDATE from info_betting IB " & _
                " inner join" & _
                " (" & _
                " select  min(IB_IDX) as MIN_IDX , max(IB_IDX) as MAX_IDX, IG_TEAM1BENEFIT, IG_TEAM2BENEFIT, IG_DRAWBENEFIT, IG_HANDICAP " & _
                " from info_betting_detail " & _
                " where ig_idx =  " & GIG_IDX & _
                " group by IG_TEAM1BENEFIT, IG_TEAM2BENEFIT, IG_DRAWBENEFIT, IG_HANDICAP" & _
                " ) A " & _
                " ON IB.IB_IDX = A.MIN_IDX ORDER BY IB.IB_REGDATE " 
               
    
	SET RS = DbCon.Execute(SQLMSG)
	strIB_IDX = "0"
	IF NOT RS.EOF THEN
		DO UNTIL RS.EOF
		
		Team1_Amount = 0
		Draw_Amount = 0 
		Team2_Amount=0
        
        TEAM1_AMOUNT = RS("TEAM1_AMOUNT")
        DRAW_AMOUNT = RS("DRAW_AMOUNT")
        TEAM2_AMOUNT = RS("TEAM2_AMOUNT")
        				
		MIN_IDX = RS("MIN_IDX")
		MAX_IDX = RS("MAX_IDX")
		IB_REGDATE = dfStringUtil.getFulldate( RS("IB_REGDATE") )
		IG_TEAM1BENEFIT = RS("IG_TEAM1BENEFIT")
		IG_DRAWBENEFIT = RS("IG_DRAWBENEFIT")
		IG_HANDICAP = RS("IG_HANDICAP")
		IG_TEAM2BENEFIT = RS("IG_TEAM2BENEFIT")
		
		strIB_IDX = strIB_IDX & "," & MIN_IDX
		
		
				 			
%>
<tr>
    <td height="25"  align="center"><%= IB_REGDATE %></td>
    <td align="center"><%= IG_TEAM1BENEFIT %>
    <% IF Team1_Amount > 0 Then %>
    <br /> <font color="red" style='font-size:11px'><%= FORMATNUMBER(Team1_Amount,0) %>원</font>
    <% End IF %>
    </td>
    <td align="center"><%= IG_DRAWBENEFIT %>
    <% IF Draw_Amount > 0 Then %>
    <br /> <font color="red" style='font-size:11px'><%= FORMATNUMBER(Draw_Amount,0) %>원</font>
    <% End IF %>
    </td>
    <td align="center"><%= IG_HANDICAP %></td>
    <td align="center"><%= IG_TEAM2BENEFIT %>
    <% IF Team2_Amount > 0 Then %>
    <br /> <font color="red" style='font-size:11px'><%= FORMATNUMBER(Team2_Amount,0) %>원</font>
    <% End IF %>
    </td>       
</tr>
<%		
            
		    RS.MoveNext
		LOOP
    End IF
	RS.Close
	Set RS = Nothing    
	
	
	arr_IB_Idx		= SPLIT(strIB_IDX, ",") 				
%>
</table>
<br clear="all">
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr bgcolor="e7e7e7"> 
	<td align="center" width="100"><b>배팅시간</b></td>
	<td align="center"><b>아이디</b></td>
	<td align="center"><b>사이트</b></td>
	<td align="center"><b>배팅금액</b></td>
	<td align="center"><b>배당금액</b></td>
	<td align="center"><b>취소</b></td>
	</tr>

<%
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open "SELECT  IU_NICKNAME, IB_TYPE, IB_IDX, IB_ID, IG_IDX, IB_NUM, IB_AMOUNT, IB_SITE, IB_REGDATE  FROM INFO_BETTING INNER JOIN INFO_USER ON IB_ID = IU_ID WHERE IB_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL = 9) AND IG_IDX LIKE '%"&GIG_IDX&"%' ORDER BY IB_REGDATE ASC", DbCon, 1

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
			IB_REGDATE			= RS("IB_REGDATE")
			IU_NICKNAME			= RS("IU_NICKNAME")
			
            
            For ii = 0 To ubound(arr_IB_Idx)
                IF cdbl(arr_IB_Idx(ii)) = cdbl(IB_IDX) Then
 
                    response.Write "<tr><td colspan=6 height=10 bgcolor=red></td></tr>"
                End IF
            Next
			IF IB_TYPE = "M" THEN
				arr_IG_Idx		= SPLIT(RS("IG_IDX"), ",")
				arrLen			= UBOUND(arr_IG_Idx)
				arr_IB_Num		= SPLIT(RS("IB_NUM"), ",")

				FOR i=0 TO arrLen
					IF cdbl(arr_IG_Idx(i)) = cdbl(GIG_IDX) THEN
						IF cdbl(arr_IB_Num(i)) = cdbl(GIB_NUM) THEN
							NN = NN + 1
							RESPONSE.WRITE "<tr><td bgcolor='FFFFFF' align='center'><a href='Betting_List.asp?sStartDate=&sEndDate=&Search=IB_IDX&Find="&IB_IDX&"&IB_AMOUNT=0' target='_blank'>"&dfStringUtil.GetFullDate(IB_RegDate)&"</a></td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_ID&" ("&IU_NICKNAME&")</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_SITE&"</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT,0)&" 원&nbsp;</td>"
							RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT * BENEFIT,0)&" 원&nbsp;</td>"
%>
<td align="center" bgcolor='FFFFFF'><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="취소" style="border:1px solid;height:16px;" onclick="goBatdel(<%=IB_Idx%>);"><% ELSE %>불가<% END IF %></td></tr>
<%					
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
					RESPONSE.WRITE "<tr><td bgcolor='FFFFFF' align='center'><a href='Betting_List.asp?sStartDate=&sEndDate=&Search=IB_IDX&Find="&IB_IDX&"&IB_AMOUNT=0' target='_blank'>"&dfStringUtil.GetFullDate(IB_RegDate)&"</a></td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_ID&" ("&IU_NICKNAME&")</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='center'>"&IB_SITE&"</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT,0)&" 원&nbsp;</td>"
					RESPONSE.WRITE "<td bgcolor='FFFFFF' align='right'>"&FORMATNUMBER(IB_AMOUNT * BENEFIT,0)&" 원&nbsp;</td>"
%>
<td align="center" bgcolor='FFFFFF'><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="취소" style="border:1px solid;height:16px;" onclick="goBatdel(<%=IB_Idx%>);"><% ELSE %>불가<% END IF %></td></tr>
<%					
					
					BetMoney  = BetMoney + IB_AMOUNT
					TBetMoney = TBetMoney + (IB_AMOUNT * BENEFIT)
				END IF
			END IF
			
		RS.MoveNext
		LOOP
	
	END IF	%>
<tr bgcolor="#FFFFFF" height="25">
<td colspan="2" bgcolor="#FFFFFF" align="center"><b>합&nbsp;&nbsp;&nbsp;계</b></td>
	<td bgcolor="#FFFFFF" align="right" colspan="2"><b><%=FORMATNUMBER(BetMoney,0)%> 원</b>&nbsp;</td>
	<td bgcolor="#FFFFFF" align="right" colspan="2"><b><%=FORMATNUMBER(TBetMoney,0)%> 원</b>&nbsp;</td></tr></table>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>
