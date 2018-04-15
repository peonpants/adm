<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	val	= REQUEST("val")	

	SQLMSG = "update info_game set ig_score1 = 0 , ig_score2 = 0, ig_result = '', ig_status = 'E' where ig_idx = "&val
	response.write SQLMSG
	DbCon.Execute(SQLMSG)

		
	Response.Redirect "GameListNew.asp?viewidx="&viewidx&""
%>