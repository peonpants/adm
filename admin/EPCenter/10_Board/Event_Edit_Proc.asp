<!-- #include virtual="/_Global/DBConn.asp" --->

<%
	Page = request("Page")
	BE_Idx = request("BE_Idx")
	BE_Title = Checkit(request("BE_Title"))
	BE_Contents = Checkit(request("BE_Contents"))
	
	Call dbOpen(db)
	
		UpdSql = "Update Board_Event set BE_Title='" & BE_Title & "', BE_Contents='" & BE_Contents & "' where BE_Idx=" & BE_Idx
		db.execute(UpdSql)
		
	Call dbClose(db)
	
	response.redirect "Event_List.asp?page="&Page
%>
