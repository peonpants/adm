<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	viewidx	= REQUEST("viewidx")	

	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count
	
	onoff = Trim(Request("onoff"))
	'response.write TotalCount
	If onoff = "on" then
	yn = "0"
	FOR i = 1 TO TotalCount 
		IG_IDX = Trim(Request("SelUser")(i))

		SQLMSG = " UPDATE INFO_BETTING SET ib_status = "&yn&" WHERE ib_idx = "& IG_IDX &" "
		DbCon.Execute(SQLMSG)

		response.write ig_idx&"<br>"


	Next

	Else
	yn = "1"
	FOR i = 1 TO TotalCount 
		IG_IDX = Trim(Request("SelUser")(i))

		SQLMSG = " UPDATE INFO_BETTING SET ib_status = "&yn&" WHERE ib_idx = "& IG_IDX &" "
		DbCon.Execute(SQLMSG)

		response.write ig_idx&"<br>"


	Next

	End If 

	DbCon.Close
	Set DbCon=Nothing
		
	Response.Redirect "gameListDe.asp?viewidx="&viewidx&""
%>