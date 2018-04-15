<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	page = Trim(Request("Page"))
	RS_Sports = Request("RS_Sports")
	
	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count

	FOR i = 1 TO TotalCount 
		Idx = Trim(Request("SelUser")(i))
		SQL = "Delete REF_SPORTS where RS_IDX =" & Idx 
		DbCon.execute(SQL)
	NEXT

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect("List.asp")
%>