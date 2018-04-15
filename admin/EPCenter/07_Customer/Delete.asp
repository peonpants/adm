<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
	delType	    = Trim(REQUEST("delType"))
	BC_Type	    = Trim(REQUEST("BC_Type"))

	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count

    IF delType = "2" Then
	    SQL = "DELETE FROM Board_Customer WHERE BC_Type = 1"
	    DbCon.execute(SQL)
    Else    
	    FOR i = 1 TO TotalCount
		    BC_Idx = Trim(Request("SelUser")(i))
            IF delType = "1" Then
                SQL = "DELETE FROM Board_Customer WHERE BC_Idx = "&BC_Idx
		        DbCon.execute(SQL)
            Else		    
		        SQL = "UPDATE Board_Customer SET BC_Status = 0 WHERE BC_Idx = "&BC_Idx
		        DbCon.execute(SQL)        
		    End IF
	    Next
    End IF
        
	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find&"&BC_Type=" & BC_Type
%>