<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	RL_League = Checkit(request("RL_League"))
	
	InsSql = "INSERT INTO REF_SPORTS ( RS_SPORTS, RS_STATUS) VALUES ( '"&RL_League&"',1 )"
	
	DbCon.Execute (InsSql)

	DbCon.Close
	Set DbCon=Nothing
	
	response.redirect "List.asp"
%>

