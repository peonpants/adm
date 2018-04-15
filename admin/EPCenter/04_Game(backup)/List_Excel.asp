<!-- #include virtual="/_Global/DBConn.asp" --->

<%
	AdminChk()
	
	RS_Sports = request("RS_Sports")
	RL_League = request("RL_League")
	Flag = request("Flag")
	
	Call dbOpen(db)
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<%
		Response.ContentType = "application/vnd.ms-excel"
		Response.CacheControl = "public"
		Response.AddHeader "Content-Disposition", "attachment;filename=게임리스트.xls" 
	%>
	<style>
		td{font-size:9pt;}
	</style>
</head>

<body>
<%
	Sql_Select = "*,Convert(varchar(16), IG_StartTime, 120) as IG_StartTime"
	Sql_From = "Info_Game"
	Sql_Where = ""
	
	If Sel_Sports <> "" then
		Sql_Where = Sql_Where & " RL_Sports='" & Sel_Sports & "'"
	End if
	
	If Sel_League <> "" then
		If Sql_Where = "" then
			Sql_Where = Sql_Where & " RL_League='" & Sel_League & "'"
		Else
			Sql_Where = Sql_Where & "and RL_League='" & Sel_League & "'"
		End if
	End if
	
	If Flag <> "All" then
		If Sql_Where = "" then
			Sql_Where = Sql_Where & " IG_Status='" & Flag & "'"
		Else
			Sql_Where = Sql_Where & " and IG_Status='" & Flag & "'"
		End if
	End if
	
	If Sql_Where = "" then Sql_Where = null
	
	If Flag = "All" then
		Sql_OrderBy = "IG_StartTime Desc"
	Else
		Sql_OrderBy = "IG_StartTime Asc"
	End if
	
	'// response.write "Select " & Sql_Select & " from " & Sql_From & " where " & Sql_Where & " order by " & Sql_OrderBy
	Call rsOpen(rs, Sql_Select, Sql_From, Sql_Where, Sql_OrderBy, db)
%>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	<tr bgcolor="e7e7e7">
		<td align="center"><b>종목</b></td>
		<td align="center"><b>리그명</b></td>
		<td align="center"><b>경기시간</b></td>
		<td align="center"><b>홈팀</b></td>
		<td align="center"><b>무(핸디캡)</b></td>
		<td align="center"><b>원정팀</b></td>
		<td align="center"><b>Score</b></td>
		<td align="center"><b>결과</b></td>
	</tr>
	<%  If rs.recordcount < 1 then %>
	<tr><td align="center" colspan="12" height="35">현재 등록된 게임이 없습니다.</td></tr>
	<%
		else
			Do Until rs.EOF
				IG_Idx = rs("IG_Idx")
				RL_Idx = rs("RL_Idx")
				RL_Sports = rs("RL_Sports")
				RL_League = rs("RL_League")
				RL_Image = rs("RL_Image")
				RL_Image = "<img src='/UpFile/League/" & RL_Image & "' width='20' height='14' style='border:1px solid;' align='absmiddle'>"
				IG_StartTime = rs("IG_StartTime")
				IG_Team1 = rs("IG_Team1")
				IG_Team2 = rs("IG_Team2")
				IG_Handicap = rs("IG_Handicap")
				IG_Team1Benefit = rs("IG_Team1Benefit")
				IG_DrawBenefit = rs("IG_DrawBenefit")
				IG_Team2Benefit = rs("IG_Team2Benefit")
				IG_Team1Betting = rs("IG_Team1Betting")
				IG_DrawBetting = rs("IG_DrawBetting")
				IG_Team2Betting = rs("IG_Team2Betting")
				IG_Score1 = rs("IG_Score1")
				IG_Score2 = rs("IG_Score2")
				
				IG_Result = rs("IG_Result")
				If IG_Result = 0 then
					GameResult = "무"
				Elseif IG_Result = 1 then
					GameResult = "홈"
				Elseif IG_Result = 2 then
					GameResult = "패"
				End if
				
				IG_Status = rs("IG_Status")
	%>
	<tr bgcolor="#FFFFFF" height="25">
		<td align="center"><%=RL_Sports%></td>
		<td>&nbsp;<%=RL_Image%>&nbsp;<%=RL_League%></td>
		<td align="center">&nbsp;<%=IG_StartTime%></td>
		<td style="padding-left:5px;"><b><%=IG_Team1%></b>(<%=IG_Team1Benefit%>)&nbsp;&nbsp;&nbsp;&nbsp;배팅:<font color=red><%=formatnumber(IG_Team1Betting,0)%></font></td>
		<% 	If IG_Handicap = 0 then %>
		<td align="center"><b>무승부</b>(<%=IG_DrawBenefit%>)&nbsp;&nbsp;&nbsp;&nbsp;배팅:<font color=red><%=formatnumber(IG_DrawBetting,0)%></font></td>
		<% Else %>
		<td bgcolor="#ffff00" align="center"><b>핸디캡</b>(<%=IG_Handicap%>)</td>
		<% End if %>
		<td style="padding-left:5px;"><b><%=IG_Team2%></b>(<%=IG_Team2Benefit%>)&nbsp;&nbsp;&nbsp;&nbsp;배팅:<font color=red><%=formatnumber(IG_Team2Betting,0)%></font></td>
		<td align="center"><%=IG_Score1%> : <%=IG_Score2%></td>
		<td align="center">
			<%=GameResult%>	
		</td>
	</tr>
	<%
			rs.MoveNext
			Loop
		end if
	%>
</table>
</body>
</html>

<%
	Call rsClose(rs)
	Call dbClose(db)
%>