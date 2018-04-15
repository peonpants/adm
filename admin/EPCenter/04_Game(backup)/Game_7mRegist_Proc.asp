<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SRL_League	= Trim(REQUEST("SRL_League"))
    Process  = Trim(Request("Process"))
    '######## 리그 체크
	SQLMSG = "SELECT TOP 1 RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE , RL_KR_LEAGUE FROM Ref_League WHERE RL_League = '"& SRL_League &"' ORDER BY RL_IDX DESC"
	SET RS = DbCon.Execute(SQLMSG)
    
    IF Rs.Eof Then
%>
    <script type="text/javascript">
    alert("<%= SRL_League %> 는 등록되지 않은 리그입니다. 리그 등록을 먼저하세요");
    </script>
<%    
        response.End
    End IF
    
	RL_IDX		= RS("RL_IDX")
	SRS_Sports	= RS("RL_SPORTS")
	RL_LEAGUE	= RS("RL_LEAGUE")
	RL_IMAGE	= RS("RL_IMAGE")
	
	IF KR_LEAGUE Then
	    IF RS("RL_KR_LEAGUE") <> "" Then
	        SRL_League = RS("RL_KR_LEAGUE")
        End IF	        
    End IF
	RS.Close
	Set RS = Nothing
	

	IG_StartTime	= Trim(REQUEST("IG_StartTime"))
	IG_Team1		= Trim(REQUEST("IG_Team1"))
	IG_Team2		= Trim(REQUEST("IG_Team2"))
	I7_IDX		= Trim(REQUEST("I7_IDX"))
	IG_IDX		= Trim(REQUEST("IG_IDX"))
    IG_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("IG_TEAM1BENEFIT")),2)
    IG_DRAWBENEFIT	= FORMATNUMBER(Trim(REQUEST("IG_DRAWBENEFIT")),2)
    IG_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("IG_TEAM2BENEFIT")),2)
    
    
    IG_H_TEAM1BENEFIT = Trim(REQUEST("IG_H_TEAM1BENEFIT"))
    IG_H_DRAWBENEFIT	= Trim(REQUEST("IG_H_DRAWBENEFIT"))
    IG_H_TEAM2BENEFIT = Trim(REQUEST("IG_H_TEAM2BENEFIT"))
 
    IG_O_TEAM1BENEFIT = Trim(REQUEST("IG_O_TEAM1BENEFIT"))
    IG_O_DRAWBENEFIT	= Trim(REQUEST("IG_O_DRAWBENEFIT"))
    IG_O_TEAM2BENEFIT = Trim(REQUEST("IG_O_TEAM2BENEFIT"))
    
    
    IG_SITE			= "ALL"
    IG_Memo			= Trim(REQUEST("IG_Memo"))
	        
    IF cStr(Process) = "add" Then
	    '######승무패 저장
        '스페셜 저장
	    IG_SP		= Trim(REQUEST("IG_SP"))
	    If IG_SP <> "" Then
	    Else
		    IG_SP = "N"
	    End If 

	    IG_HANDICAP		= 0
	    IG_TYPE			= 0	    

	    If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= "" Or I7_IDX = "" Then
		    response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
		    response.end
	    End If 

        IG_TEAM1BET_CNT = 0
        IG_TEAM2BET_CNT = 0           
        IG_DRAWBET_CNT = 0

	        
	    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
	    SQL = SQL & " IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP, I7_IDX) VALUES ( "
	    SQL = SQL & RL_Idx & ", '"
	    SQL = SQL & SRS_Sports & "', '"
	    SQL = SQL & SRL_League & "', '"
	    SQL = SQL & RL_IMAGE & "', '"
	    SQL = SQL & IG_StartTime & "', '"
	    SQL = SQL & replace(IG_Team1,"'","''") & "', '"
	    SQL = SQL & replace(IG_Team2,"'","''") & "', "
	    SQL = SQL & IG_Handicap & ", "
	    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
	    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
	    SQL = SQL & Cdbl(IG_Team2Benefit) & ", "
	    SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	    SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	    SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"	    
	    SQL = SQL & IG_Type & "', "
	    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
	    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','"& I7_IDX&"') "
	    DbCon.Execute (SQL)

	    IG_Type02		= Trim(REQUEST("IG_Type02"))
	    
	    '핸디캡 저장
	    IG_Type02		= Trim(REQUEST("IG_Type02"))
	    IF IG_Type02 = "Yes" And IG_H_TEAM1BENEFIT <> "" And IG_H_TEAM2BENEFIT <> "" AND IG_H_DRAWBENEFIT <> "" THEN

            IG_H_DRAWBENEFIT = FORMATNUMBER(Trim(REQUEST("IG_H_TEAM2BENEFIT")),2)
            IG_H_DRAWBENEFIT	= FORMATNUMBER(Trim(REQUEST("IG_H_DRAWBENEFIT")),2)
            IG_H_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("IG_H_TEAM2BENEFIT")),2)
            
		    IG_HANDICAP		= IG_H_DRAWBENEFIT 
		    IG_DRAWBENEFIT	= 0		    
		    IG_TYPE			= 1


	        IF IG_DRAWBENEFIT = 0 Then
                Randomize 
                num1 = Int((10*Rnd))    
                        
                Randomize 
                num2 = Int((10*Rnd))                            
                	        
	            IG_TEAM1BET_CNT = 0
	            IG_TEAM2BET_CNT = 0
	            IG_DRAWBET_CNT  = 0
	        End IF
	        
		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & " IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP, I7_IDX) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
	        SQL = SQL & replace(IG_Team1,"'","''") & "', '"
	        SQL = SQL & replace(IG_Team2,"'","''") & "', "
		    SQL = SQL & IG_HANDICAP & ", "
		    SQL = SQL & Cdbl(IG_H_TEAM1BENEFIT) & ", "
		    SQL = SQL & Cdbl(IG_DRAWBENEFIT) & ", "
		    SQL = SQL & Cdbl(IG_H_TEAM2BENEFIT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"			    
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','"& I7_IDX&"') "
		    DbCon.Execute (SQL)

	    END IF
    		   
        '오버언더 저장
	    IG_Type03		= Trim(REQUEST("IG_Type03"))
	    IF IG_Type03 = "Yes" And IG_O_TEAM1BENEFIT <> "" And IG_O_TEAM2BENEFIT <> "" AND IG_O_DRAWBENEFIT <> "" THEN

            IG_O_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("IG_O_TEAM1BENEFIT")),2)
            IG_O_DRAWBENEFIT	= FORMATNUMBER(Trim(REQUEST("IG_O_DRAWBENEFIT")),2)
            IG_O_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("IG_O_TEAM2BENEFIT")),2)
            
		    IG_HANDICAP		= IG_O_DRAWBENEFIT 
		    IG_DRAWBENEFIT	= 0
		    IG_TYPE			= 2

	        IF IG_DRAWBENEFIT = 0 Then
                Randomize 
                num1 = Int((10*Rnd))    
                        
                Randomize 
                num2 = Int((10*Rnd))                            
                	        
	            IG_TEAM1BET_CNT = 0
	            IG_TEAM2BET_CNT = 0
	            IG_DRAWBET_CNT  = 0

	        End IF
	        
		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & " IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP,I7_IDX) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
	        SQL = SQL & replace(IG_Team1,"'","''") & "', '"
	        SQL = SQL & replace(IG_Team2,"'","''") & "', "
		    SQL = SQL & IG_HANDICAP & ", "
		    SQL = SQL & Cdbl(IG_O_TEAM1BENEFIT) & ", "
		    SQL = SQL & Cdbl(IG_DRAWBENEFIT) & ", "
		    SQL = SQL & Cdbl(IG_O_TEAM2BENEFIT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"			    
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','"& I7_IDX&"') "
		    DbCon.Execute (SQL)

	    END IF
%>
<script type="text/javascript">
/*
    var rtn = confirm("새로고침하시겠습니까?") ;
    if(rtn)
    {
        parent.location.reload();
    }
*/
</script>
<%	    		    

    ElseIF cStr(Process) = "modify" Then         

        IG_STATUS = Trim(REQUEST("IG_STATUS"))        
    
        IF Trim(REQUEST("IG_TYPE")) = 0 Then
            SQL = "UPDATE INFO_GAME SET"

            SQL = SQL & " IG_StartTime = '" & IG_StartTime
            SQL = SQL & "', IG_Team1Benefit = " & Cdbl(IG_Team1Benefit)  
            SQL = SQL & ", IG_DrawBenefit = " & Cdbl(IG_DrawBenefit)  
            SQL = SQL & ", IG_Team2Benefit = " & Cdbl(IG_Team2Benefit)              
            SQL = SQL & ", RL_League = '" & SRL_League 
            SQL = SQL & ", IG_STATUS = '" & IG_STATUS 
            SQL = SQL & "', IG_Team1 = '" & IG_Team1 
            SQL = SQL & "', IG_Team2 = '" & IG_Team2 
            SQL = SQL & "' WHERE IG_IDX = " & IG_IDX & " AND I7_IDX =" & I7_IDX
        Else
            SQL = "UPDATE INFO_GAME SET"
            SQL = SQL & " IG_StartTime = '" & IG_StartTime
            SQL = SQL & "', IG_Team1Benefit = " & Cdbl(IG_Team1Benefit)  
            SQL = SQL & ", IG_HANDICAP = " & Cdbl(IG_DrawBenefit)  
            SQL = SQL & ", IG_Team2Benefit = " & Cdbl(IG_Team2Benefit)  
            SQL = SQL & ", RL_League = '" & SRL_League 
            SQL = SQL & ", IG_STATUS = '" & IG_STATUS
            SQL = SQL & "', IG_Team1 = '" & IG_Team1 
            SQL = SQL & "', IG_Team2 = '" & IG_Team2            
            SQL = SQL & "' WHERE IG_IDX = " & IG_IDX & " AND I7_IDX =" & I7_IDX        
        End IF        
	    DbCon.Execute (SQL)

%>
<script type="text/javascript">
/*
    var rtn = confirm("새로고침하시겠습니까?") ;
    if(rtn)
    {
        parent.location.reload();
    }
*/    
</script>
<%                
    End IF

	DbCon.Close
	Set DbCon=Nothing
    	
%>
