<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	IU_Status	= Trim(REQUEST("IU_Status"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
	Search		= Trim(REQUEST("Search"))
	Find		= Trim(REQUEST("Find"))
    ib_idx      = Trim(REQUEST("ib_idx"))
    

    IF ib_idx = "" Then
	    TotalCount = Request("SelUser").Count

	    FOR i = 1 TO TotalCount 
		    ib_idx = Trim(Request("SelUser")(i))
    		
    		
		        SQL = "update info_betting set ib_Del='Y' where ib_status=1 and convert(varchar(10),ib_regdate,120) < convert(varchar(10),getdate(),120) and ib_idx = "&ib_idx
		        DbCon.execute(SQL)                		        
           
	    Next
    Else
        
        		
	        SQL = "update info_betting set ib_Del='Y' where ib_status=1 and ib_idx =  "&ib_idx
	        
	        DbCon.execute(SQL)                		        
	   
	    
	    response.Write  SQL 
    End IF	    
    
	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Betting_list.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>