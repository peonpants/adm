<!-- METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" NAME="ADODB Type Library" -->
<!-- 경기등록리스트 사다리만... -->
<%
    temp = REQUEST("temp")
    temp2 = REQUEST("temp2")
    temp3 = REQUEST("temp3")

    if temp2 = "" then
    temp2 = "local"
    end if  

    if temp3 = "1" then
    temp4 = "and rl_sports='축구'"
    elseif temp3 = "2" then
    temp4 = "and rl_sports='야구'"
    elseif temp3 = "3" then
    temp4 = "and rl_sports='농구'"
    elseif temp3 = "4" then
    temp4 = "and rl_sports='아이스하키'"
    elseif temp3 = "5" then
    temp4 = "and rl_sports='실시간'"
    else
    temp4 = "and (ig_status<>'F' and ig_status<>'C')"
    end if

    set db = Server.CreateObject("adodb.connection")
    db.Open "Provider=SQLOLEDB;UID=smam;PWD=cool1004!))$;Initial Catalog=" & temp & ";Data Source=(" & temp2 & ")"
    sql1="select * from info_game where (ig_anal IS NULL or ig_anal='') " & temp4 & " order by ig_starttime desc"
		
	set rs=Server.CreateObject("adodb.recordset")
	rs.open sql1,db,0,1
%>
<%

Response.Charset="euc-kr" 'asp페이지 charset설정

%>
<table border="0"  cellspacing="1" cellpadding="3" bgcolor="FFFFFF" width="100%" id="tblGameList">
경기등록리스트 시작전 경기와 마감된 경기 승무패/핸디캡/스페셜 사다리는 제외
<tr>
<td align="center">
구분자
</td>
<td align="center">
경기인덱스
</td>
<td align="center">
II인덱스(기준사이트)
</td>
<td align="center">
리그인덱스
</td>
<td align="center">
종목
</td>
<td align="center">
리그명
</td>
<td align="center">
리그이미지
</td>
<td align="center">
시작시간
</td>
<td align="center">
홈팀명
</td>
<td align="center">
원정팀명
</td>
<td align="center">
기준점
</td>
<td align="center">
홈팀배당
</td>
<td align="center">
무배당
</td>
<td align="center">
원정팀배당
</td>
<td align="center">
상태
</td>
<td align="center">
경기타입
</td>
<td align="center">
스페셜여부(Y/N)
</td>
<td align="center">
사다리(Y/N)
</td>
<td align="center">
사이트
</td>
<td align="center">
기준사이트결과(1/2/NULL)
</td>
<td align="center">
자동배당변경(Y/NULL)
</td>
<td align="center">
구분자
</td>
</tr>
					<%
						if not RS.EOF then
							do until RS.EOF
								startday = formatdatetime(rs("IG_STARTTIME"), 2)
								starttime = formatdatetime(rs("IG_STARTTIME"), 4)
								ss = startday & starttime
								ss = left(ss, 10) & " " & right(ss, 5) & ":00"
					%>
								<TR NAME="START">
								<td>start_gogo</td>
								<td align="center" NAME="IG_IDX"><%=rs("IG_IDX") %></td>
								<td align="center" NAME="II_IDX"><%=rs("II_IDX") %></td>
								<td align="center" NAME="RL_IDX"><%=rs("RL_IDX") %></td>
								<td align="center" NAME="RL_SPORTS"><%=rs("RL_SPORTS") %></td>
								<td align="center" NAME="RL_LEAGUE"><%=rs("RL_LEAGUE") %></td>
								<td align="center" NAME="RL_IMAGE"><%=rs("RL_IMAGE") %></td>
								<td align="center" NAME="IG_STARTTIME"><%= ss %></td>    
								<td align="center" NAME="IG_TEAM1"><%=rs("IG_TEAM1") %></td> 
								<td align="center" NAME="IG_TEAM2"><%=rs("IG_TEAM2") %></td>
								<td align="center" NAME="IG_HANDICAP"><%=rs("IG_HANDICAP") %></td>
								<td align="center" NAME="IG_TEAM1BENEFIT"><%=rs("IG_TEAM1BENEFIT") %></td>
								<td align="center" NAME="IG_DRAWBENEFIT"><%=rs("IG_DRAWBENEFIT") %></td>
								<td align="center" NAME="IG_TEAM2BENEFIT"><%=rs("IG_TEAM2BENEFIT") %></td>
								<td align="center" NAME="IG_STATUS"><%=rs("IG_STATUS") %></td>
								<td align="center" NAME="IG_TYPE"><%=rs("IG_TYPE") %></td>
								<td align="center" NAME="IG_SP"><%=rs("IG_SP") %></td>
								<td align="center" NAME="IG_EVENT"><%=rs("IG_EVENT") %></td>
								<td align="center" NAME="IG_SITE"><%=rs("IG_SITE") %></td>
								<td align="center" NAME="IG_ANAL"><%=rs("IG_ANAL") %></td>
								<td align="center" NAME="IG_BROD"><%=rs("IG_BROD") %></td>
								<td>end_gogo</td>
								</TR NAME="END">
					<%
							RS.movenext
							loop
						end if
					%>
</table>