<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	Response.CharSet  = "euc-kr"
	Response.Expires = 0 
	Response.AddHeader "pragma","no-cache" 
	Response.AddHeader "cache-control","private" 
	Response.CacheControl = "no-cache" 

	i = request("num")
	lname = unescape(request("lname"))
	nowval = unescape(request("nowval"))
%>


<select name="RL_League_<%=i%>"  style="width:190px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
	<option value="">선택하세요</option>
	<%	SQLMSG = " RL_SPORTS like '%"& lname & "%' "
		SQLR = "SELECT RL_LEAGUE, RL_KR_LEAGUE FROM Ref_League WHERE "& SQLMSG &" Order By RL_LEAGUE"
		SET RS = Server.CreateObject("ADODB.Recordset")
		RS.Open SQLR, DbCon, 1

		RSCount = RS.RecordCount
		
		
		FOR a =1 TO RSCount

			if nowval <> "" then
				SRL_League = nowval
			end if
			
			RLS = RS(0) 
			RLSKR = RS(1)
			%>
	<option value="<%=RLS%>" <% IF SRL_League = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	<%	RS.movenext
		NEXT

		RS.Close
		Set RS=Nothing	%>
</select>
