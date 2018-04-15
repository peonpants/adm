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
		BN_Idx = Trim(Request("SelUser")(i))

		SQL = "UPDATE Board_Notice SET BN_Status = 0 WHERE BN_Idx = "&BN_Idx
		DbCon.execute(SQL)

	Next

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Notice_List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>