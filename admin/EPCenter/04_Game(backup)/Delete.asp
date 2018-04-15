<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SRS_Sports	= REQUEST("SRS_Sports")	
	SRL_League	= REQUEST("SRL_League")
	SFlag		= REQUEST("SFlag")
	Page		= REQUEST("Page")

	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count
	
	FOR i = 1 TO TotalCount 
		IG_IDX = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT IG_STATUS, IG_TEAM1BETTING , IG_TEAM2BETTING , IG_DRAWBETTING FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		SET RS = DbCon.Execute(SQLMSG)

		IG_STATUS		= RS(0)
        IG_TEAM1BETTING  = RS(1)
        IG_TEAM2BETTING  = RS(2)
        IG_DRAWBETTING = RS(3)
        
		RS.Close
		Set RS = Nothing

		IF IG_STATUS = "R" OR IG_STATUS = "C" THEN
		    
			DELSQL = "DELETE INFO_GAME WHERE IG_IDX = "& IG_IDX &""
			DbCon.execute(DELSQL)
        Else
            IF IG_TEAM1BETTING + IG_TEAM2BETTING + IG_DRAWBETTING = 0 Then
			    DELSQL = "DELETE INFO_GAME WHERE IG_IDX = "& IG_IDX &""
			    DbCon.execute(DELSQL)            
            End IF 			
		END IF
	Next

	DbCon.Close
	Set DbCon=Nothing
		
	Response.Redirect "List.asp?page="&Page&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&""
%>