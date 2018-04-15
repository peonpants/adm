<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	IU_Status	= Trim(REQUEST("IU_Status"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))
    IU_IDX      = Trim(REQUEST("IU_IDX"))
    

    IF IU_IDX = "" Then
	    TotalCount = Request("SelUser").Count

	    FOR i = 1 TO TotalCount 
		    IU_Idx = Trim(Request("SelUser")(i))
    		
    		IF cStr(IU_Status) <> "8" Then    		
		        SQL = "UPDATE INFO_USER SET IU_Status = "&IU_Status&" WHERE IU_IDX = "&IU_Idx
		        DbCon.execute(SQL)
            Else
		        SQL = "DELETE FROM INFO_USER WHERE IU_IDX = "&IU_Idx
		        DbCon.execute(SQL)                		        
            End IF
	    Next
    Else
        
        IF cStr(IU_Status) = "8" Then    		
	        SQL = "DELETE FROM INFO_USER WHERE IU_IDX = "&IU_Idx
	        
	        DbCon.execute(SQL)                		        
	    End IF 
	    
	    response.Write  SQL 
    End IF	    
    
	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>