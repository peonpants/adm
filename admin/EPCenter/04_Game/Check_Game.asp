<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<body topmargin="0" marginheight="0">
<table border="1" cellpadding="2" cellspacing="1">
<tr><td>���ӹ�ȣ</td>
	<td>�� �� ��</td>
	<td>��������</td>
	<td>����Ÿ��</td>
	<td>�� �� ĸ</td>
	<td>���ھ�(Ȩ)</td>
	<td>���ھ�(��)</td>
	<td>�ǰ����</td>
	<td>���������</td>
	<td><!--���ÿ���--></td></tr>

<%
	SET List = Server.CreateObject("ADODB.Recordset")
	List.Open "SELECT IG_IDX, IG_HANDICAP, IG_Score1, IG_Score2, IG_Result, IG_TYPE, RL_SPORTS, RL_LEAGUE, IG_STARTTIME, IG_TEAM1, IG_TEAM2 FROM Info_Game Where IG_Status = 'F' order by IG_IDX", dbCon, 1
	ListCount = List.RecordCount

	FOR i = 1 TO ListCount

	IG_IDX		= List(0)
	IG_HANDICAP = CDbl(List(1))
	IG_Score1	= CDbl(List(2))
	IG_Score2	= CDbl(List(3))
	IG_Result	= List(4)
	IG_TYPE		= CDbl(List(5))


	IF IG_TYPE = 0 THEN
		IF IG_Score1 > IG_Score2 THEN
			GFALG = 1
		ELSEIF IG_Score1 = IG_Score2 THEN
			GFALG = 0
		ELSEIF IG_Score1 < IG_Score2 THEN
			GFALG = 2
		END IF
	ELSEIF IG_TYPE = 1 THEN
		IF (IG_Score1+IG_HANDICAP) > IG_Score2 THEN
			GFALG = 1
		ELSEIF (IG_Score1+IG_HANDICAP) = IG_Score2 THEN
			GFALG = 0
		ELSEIF (IG_Score1+IG_HANDICAP) < IG_Score2 THEN
			GFALG = 2
		END IF
	ELSEIF IG_TYPE = 2 THEN
		IF IG_HANDICAP < CDbl((IG_Score1+IG_Score2)) THEN
			GFALG = 1
		ELSEIF IG_HANDICAP = CDbl((IG_Score1+IG_Score2)) THEN
			GFALG = 0
		ELSEIF IG_HANDICAP > CDbl((IG_Score1+IG_Score2)) THEN
			GFALG = 2
		END IF
	END IF


	'SQLLIST = "SELECT COUNT(*) FROM INFO_BETTING WHERE IB_STATUS = 1 AND IG_IDX LIKE '%"&IG_IDX&"%'"
	'SET RSLIST = DbCon.Execute(SQLLIST)
	'BETCOUNT = CDBL(RSLIST(0))
	'RSLIST.CLOSE
	'SET RSLIST = NOTHING


	IF CDbl(IG_Result) <> CDbl(GFALG) THEN	%>
		<tr><td><%=IG_IDX%></td>
			<td><%=List("RL_SPORTS")%> / <%=List("RL_LEAGUE")%> / <%=List("IG_TEAM1")%>:<%=List("IG_TEAM2")%></td>
			<td><%=List("IG_STARTTIME")%></td>
			<td><% IF IG_TYPE = 0 THEN %>�Ϲݰ��<% ELSEIF IG_TYPE = 1 THEN %>�ڵ�ĸ<% ELSEIF IG_TYPE = 2 THEN %>�������<% END IF %></td>
			<td><%=IG_HANDICAP%></td>
			<td><%=IG_Score1%></td>
			<td><%=IG_Score2%></td>
			<td><% IF GFALG = 0 THEN %>���º�<% ELSEIF GFALG = 1 THEN %>��<% ELSEIF GFALG = 2 THEN %>��<% END IF %></td>
			<td><% IF IG_Result = 0 THEN %>���º�<% ELSEIF IG_Result = 1 THEN %>��<% ELSEIF IG_Result = 2 THEN %>��<% END IF %></td>
			<td><!--<%=BETCOUNT%> ��--></td></tr>	<%
	END IF

	
	List.Movenext
	NEXT
	
	List.close
	Set List = Nothing

	DbCon.Close
	Set DbCon = Nothing	%></table>

</body>
</html>