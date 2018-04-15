<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IB_nm		= REQUEST("IB_nm")
	Search		="IB_ID"

    
        
        		
	SQL = "update info_betting set ib_Del='Y' where ib_status=1  and ib_id =  '"&IB_nm&"'  and ib_Del='N'"
	
	DbCon.execute(SQL)                		        

	  
    
	DbCon.Close
	Set DbCon=Nothing
	
	Response.Redirect "Betting_list.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&IB_nm
%>