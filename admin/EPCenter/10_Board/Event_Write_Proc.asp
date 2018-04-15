<!-- #include virtual="/_Global/DbCono.asp" -->

<%
	BE_Title = Checkit(request("BE_Title"))
	BE_Contents = Checkit(request("BE_Contents"))
	
	Call dbOpen(db)
	InsSql = "Insert into Board_Event(BE_Title, BE_Contents) values('"
	InsSql = InsSql &  BE_Title & "', '"
	InsSql = InsSql &  BE_Contents & "')"
	
	db.execute(InsSql)
	Call dbClose(db)
	
	response.redirect "Event_List.asp"
%>
