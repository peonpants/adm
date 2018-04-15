<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count

	FOR i = 1 TO TotalCount
		BC_Idx = Trim(Request("SelUser")(i))

		SQL = "DELETE FROM Board_Customer WHERE BC_Idx = "&BC_Idx
		DbCon.execute(SQL)

	Next

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>