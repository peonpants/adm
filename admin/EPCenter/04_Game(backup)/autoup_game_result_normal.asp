<!-- METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" NAME="ADODB Type Library" -->

<%
    temp = REQUEST("temp")
    set db = Server.CreateObject("adodb.connection")
    db.Open "Provider=SQLOLEDB;UID=smam;PWD=cool1004!))$;Initial Catalog=" & temp & ";Data Source=(local)"
    sql1="select top 300 * from info_game where (ig_status='F' or ig_status='C') AND ig_event = 'N' and (rl_sports = '�౸' or rl_sports = '�߱�' or rl_sports='��' or rl_sports='���̽���Ű') order by ig_starttime desc"
		
	set rs=Server.CreateObject("adodb.recordset")
	rs.open sql1,db,0,1
%>
<%

Response.Charset="euc-kr" 'asp������ charset����

%>
<table border="0"  cellspacing="1" cellpadding="3" bgcolor="FFFFFF" width="100%" id="tblGameList">
����ϸ���Ʈ ������ ���� ������ ��� �¹���/�ڵ�ĸ/����� ��ٸ��� ����
<tr>
<td align="center">
������
</td>
<td align="center">
�����ε���
</td>
<td align="center">
����ε���
</td>
<td align="center">
II�ε���(���ػ���Ʈ)
</td>
<td align="center">
���۽ð�
</td>
<td align="center">
Ȩ����
</td>
<td align="center">
��������
</td>
<td align="center">
Ȩ�����ھ�
</td>
<td align="center">
���������ھ�
</td>
<td align="center">
����
</td>
<td align="center">
���Ÿ��
</td>
<td align="center">
����ȿ���(Y/N)
</td>
<td align="center">
��ٸ�(Y/N)
</td>
<td align="center">
����Ʈ
</td>
<td align="center">
���ػ���Ʈ���(1/2/NULL)
</td>
<td align="center">
������
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
								<td align="center" NAME="RL_IDX"><%=rs("RL_IDX") %></td>
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