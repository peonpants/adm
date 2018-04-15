<!-- #include virtual="/_Global/DBConn.asp" --->

<%
	AdminChk()
	
	page = Trim(Request("Page"))
	if page = "" then page = 1

	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count
	
	Call dbOpen(db)
	for i = 1 to TotalCount 
		BE_Idx = Trim(Request("SelUser")(i))
		UpdSql = "update Board_Event set BE_Status=0 where BE_Idx=" & BE_Idx
		
		db.execute(UpdSql)
	Next
	Call dbClose(db)
	
	Response.Redirect("Event_List.asp?page=" & Page)
%>