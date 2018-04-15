<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
    BF_LEVEL    = Trim(REQUEST("BF_LEVEL"))
	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count
	
	FOR i = 1 TO TotalCount
		BF_Idx = Trim(Request("SelUser")(i))

		'SQL = "UPDATE Board_Free SET BF_Status = 0 WHERE BF_Idx = "&BF_Idx
		SQL = "DELETE Board_Free Where BF_Idx = "&BF_Idx
		DbCon.execute(SQL)

	Next

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Board_List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find & "&BF_LEVEL=" & BF_LEVEL
%>