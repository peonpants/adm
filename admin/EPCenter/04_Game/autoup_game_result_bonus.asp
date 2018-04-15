<!-- METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" NAME="ADODB Type Library" -->
<!-- 경기결과 리스트 사다리 -->
<%
    set db = Server.CreateObject("adodb.connection")
    db.Open "Provider=SQLOLEDB;UID=smam;PWD=cool1004!))$;Initial Catalog=DTEVIL;Data Source=(local)"
    sql1="select top 3 * from info_game where (ig_anal='1' or ig_anal='2') and ig_event='Y' and rl_idx = 514 order by ig_starttime desc"
		
	set rs=Server.CreateObject("adodb.recordset")
	rs.open sql1,db,0,1
%>
<%

Response.Charset="euc-kr" 'asp페이지 charset설정

%>
<table border="0"  cellspacing="1" cellpadding="3" bgcolor="FFFFFF" width="100%" id="tblGameList">
사다리결과 리스트
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
시작시간
</td>
<td align="center">
홈팀명
</td>
<td align="center">
원정팀명
</td>
<td align="center">
홈팀스코어
</td>
<td align="center">
원정팀스코어
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
								<td align="center" NAME="IG_STARTTIME"><%= ss %></td>    
								<td align="center" NAME="IG_TEAM1"><%=rs("IG_TEAM1") %></td> 
								<td align="center" NAME="IG_TEAM2"><%=rs("IG_TEAM2") %></td>
								<td align="center" NAME="IG_SCORE1"><%=rs("IG_SCORE1") %></td>
								<td align="center" NAME="IG_SCORE2"><%=rs("IG_SCORE2") %></td>	
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