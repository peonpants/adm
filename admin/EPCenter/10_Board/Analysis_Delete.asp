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
		BA_Idx = Trim(Request("SelUser")(i))
		UPDSQL = "UPDATE Board_Analysis SET BA_Status=0 WHERE BA_Idx=" & BA_Idx
		DbCon.execute(UPDSQL)
	Next

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Analysis_List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>