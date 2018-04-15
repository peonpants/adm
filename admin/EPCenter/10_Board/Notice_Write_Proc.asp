<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	BN_Title	= Checkit(REQUEST("BN_Title"))
	BN_Contents = Checkit(REQUEST("BN_Contents"))
	BN_Top		= REQUEST("BN_Top")
	BN_Part		= REQUEST("BN_Part")
	

	INSSQL = "Insert into Board_Notice (BN_Title, BN_Contents, BN_Top, BN_Part) values('"
	INSSQL = INSSQL &  BN_Title & "', '"
	INSSQL = INSSQL &  BN_Contents & "', "
	INSSQL = INSSQL &  BN_Top & ", '"
	INSSQL = INSSQL &  BN_Part & "')"
	DbCon.execute(INSSQL)

	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Notice_List.asp"
%>