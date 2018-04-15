<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IBD_IDX		= REQUEST("IBD_IDX")
	IB_IDX		= REQUEST("IB_IDX")
	IBD_NUM		= REQUEST("IBD_NUM")
	IB_ID		= REQUEST("IB_ID")
	
	IBD_RESULT		= REQUEST("IBD_RESULT")
    TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
    TotalBenefitA = Cdbl(TotalBenefitA) * Cdbl(IBD_BENEFIT)          	
	IB_REGDATE		= REQUEST("IB_REGDATE")
	
	IBD_NUM_ORI		= REQUEST("IBD_NUM_ORI")	
	IB_Amount		= REQUEST("IB_Amount")
    IG_IDX		= REQUEST("IG_IDX")
                	
	m		= REQUEST("m")
	LL_ID		= REQUEST("LL_ID")
	LL_IP		= REQUEST("LL_IP")
	
	
	
	IF m = "i" Then
        UPDSQL = "UPDATE dbo.LOG_LOGIN SET LL_IP =  '"& LL_IP &"'  WHERE LL_ID = '" & LL_ID & "'"
        DbCon.execute(UPDSQL)    	
	Else
	
	    IBD_RESULT_BENEFIT		= REQUEST("IBD_RESULT_BENEFIT")	
        IF IB_REGDATE <> "" Then
            '사용자 시간
            UPDSQL = "UPDATE dbo.INFO_BETTING SET IB_REGDATE =  '"& IB_REGDATE &"'  WHERE IB_IDX = '" & IB_IDX & "'"
            DbCon.execute(UPDSQL)    
        Else	   			
            
             
            IF cStr(IBD_NUM_ORI) = "1" Then
                aa = "IG_TEAM1BETTING = IG_TEAM1BETTING -" & IB_Amount
                
                SQLMSG = "SELECT IG_TEAM1BENEFIT FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_TEAM1BENEFIT	= RS(0)

		        RS.Close
		        Set RS = Nothing
		        
		        IBD_BENEFIT = IG_TEAM1BENEFIT
		        IBD_Result_BENEFIT = IG_TEAM1BENEFIT
                
            ElseIF cStr(IBD_NUM_ORI) = "0" Then
                aa = "IG_DRAWBETTING = IG_DRAWBETTING -" & IB_Amount
                
                SQLMSG = "SELECT IG_HANDICAP, IG_DRAWBENEFIT, IG_TYPE FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_HANDICAP	= RS(0)
		        IG_DRAWBENEFIT	= RS(1)
		        IG_TYPE	= RS(2)
		        
		        IF IG_TYPE = 0 THEN 
		        
		            IBD_BENEFIT = IG_DRAWBENEFIT
		            IBD_Result_BENEFIT = IG_DRAWBENEFIT
		        
		        ELSE 
		        
		            IBD_BENEFIT = IG_HANDICAP
		            IBD_Result_BENEFIT = IG_DRAWBENEFIT
		            
		        END IF            

		        RS.Close
		        Set RS = Nothing
                                
            ElseIF cStr(IBD_NUM_ORI) = "2" Then
                aa = "IG_TEAM2BETTING = IG_TEAM2BETTING -" & IB_Amount
                
                SQLMSG = "SELECT IG_TEAM2BENEFIT FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_TEAM2BENEFIT	= RS(0)

		        RS.Close
		        Set RS = Nothing
		        
		        IBD_BENEFIT = IG_TEAM2BENEFIT
		        IBD_Result_BENEFIT = IG_TEAM2BENEFIT
                                
            End IF

            IF cStr(IBD_NUM) = "1" Then
                bb = "IG_TEAM1BETTING = IG_TEAM1BETTING +" & IB_Amount
                
                SQLMSG = "SELECT IG_TEAM1BENEFIT FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_TEAM1BENEFIT	= RS(0)

		        RS.Close
		        Set RS = Nothing
		        
		        IBD_BENEFIT = IG_TEAM1BENEFIT
		        IBD_Result_BENEFIT = IG_TEAM1BENEFIT
                
            ElseIF cStr(IBD_NUM) = "0" Then
                bb = "IG_DRAWBETTING = IG_DRAWBETTING +" & IB_Amount
                
                SQLMSG = "SELECT IG_HANDICAP, IG_DRAWBENEFIT, IG_TYPE FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_HANDICAP	= RS(0)
		        IG_DRAWBENEFIT	= RS(1)
		        IG_TYPE	= RS(2)
		        
		        IF IG_TYPE = 0 THEN 
		        
		            IBD_BENEFIT = IG_DRAWBENEFIT
		            IBD_Result_BENEFIT = IG_DRAWBENEFIT
		        
		        ELSE 
		        
		            IBD_BENEFIT = IG_HANDICAP
		            IBD_Result_BENEFIT = IG_DRAWBENEFIT
		            
		        END IF            

		        RS.Close
		        Set RS = Nothing
                                
            ElseIF cStr(IBD_NUM) = "2" Then
                bb = "IG_TEAM2BETTING = IG_TEAM2BETTING +" & IB_Amount
                
                SQLMSG = "SELECT IG_TEAM2BENEFIT FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		        SET RS = DbCon.Execute(SQLMSG)

		        IG_TEAM2BENEFIT	= RS(0)

		        RS.Close
		        Set RS = Nothing
		        
		        IBD_BENEFIT = IG_TEAM2BENEFIT
		        IBD_Result_BENEFIT = IG_TEAM2BENEFIT
                                
            End IF
            
            UPDSQL = "UPDATE dbo.INFO_GAME SET " & aa & ", " & bb & "  WHERE IG_IDX = '" & IG_IDX & "'"
            
            response.Write UPDSQL & "<br><br>"
            DbCon.execute(UPDSQL)
                                    
            UPDSQL = "UPDATE dbo.INFO_BETTING_DETAIL SET IBD_NUM =  '"& IBD_NUM &"', IBD_RESULT =  '"& IBD_RESULT &"', IBD_BENEFIT = '"&IBD_RESULT_BENEFIT&"' , IBD_RESULT_BENEFIT = '"& IBD_RESULT_BENEFIT &"'  WHERE IBD_IDX = '" & IBD_IDX & "'"
            
            response.Write UPDSQL & "<br><br>"
            
            DbCon.execute(UPDSQL)
        End IF
    End IF
	DbCon.Close
	Set DbCon=Nothing
%>

<script type="text/javascript">
	parent.location.reload();
</script>

