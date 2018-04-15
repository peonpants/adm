<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    mode        = REQUEST("mode")
    v_data      = REQUEST("v_data")
	SRS_Sports	= REQUEST("SRS_Sports")	
	SRL_League	= REQUEST("SRL_League")
	SFlag		= REQUEST("SFlag")
	Page		= REQUEST("Page")
    
	'SelUser = Trim(Request("SelUser"))
	'TotalCount = Request("SelUser").Count
	SelUser = Split(v_data,",")
	TotalCount = ubound(SelUser)
	
	
	IF mode = "start" Then
	    FOR i = 0 TO TotalCount 
		    IG_IDX = SelUser(i)

		    SQLMSG = "SELECT IG_STATUS FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		    SET RS = DbCon.Execute(SQLMSG)

		    IG_STATUS		= RS(0)

		    RS.Close
		    Set RS = Nothing

		    'IF IG_STATUS = "R"  THEN
			    DELSQL = "update INFO_GAME set ig_status = 'S' WHERE IG_IDX = "& IG_IDX &""
			    'response.Write DELSQL & "<Br>"
			    DbCon.execute(DELSQL)
		    'END IF
	    Next	
	     SFlag = "R"  
        url = "List.asp?page="&Page&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&""	     
%>
<script type="text/javascript">
parent.location.href = "<%= url %>" ;
</script>
<%	     
    ElseIF mode = "end" Then '결과 입력 프로세스
    
        FOR i = 0 TO TotalCount 
		    IG_IDX = SelUser(i)

		    SQLMSG = "SELECT IG_HANDICAP, IG_TEAM1BENEFIT, IG_DRAWBENEFIT, IG_TEAM2BENEFIT, IG_TYPE, IG_Score1, IG_Score2, IG_STATUS FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		    SET RS = DbCon.Execute(SQLMSG)

	        IG_HANDICAP		= RS("IG_HANDICAP")
	        IG_TEAM1BENEFIT	= RS("IG_TEAM1BENEFIT")
	        IG_DRAWBENEFIT	= RS("IG_DRAWBENEFIT")
	        IG_TEAM2BENEFIT	= RS("IG_TEAM2BENEFIT")
	        IG_TYPE			= RS("IG_TYPE")
	        IG_Score1		= RS("IG_Score1")
	        IG_Score2		= RS("IG_Score2")
        	tIG_STATUS       = RS("IG_STATUS")
		    RS.Close
		    Set RS = Nothing


	IF (tIG_STATUS = "F" OR tIG_STATUS = "C") Then
	    url = "List.asp?page="&Page&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&""
%>
<script type="text/javascript">
    alert("정산 마감 된 경기가 존재합니다. \n배팅마감으로 복원 후 다시 정산해주시기 바랍니다.");
     parent.location.href = "<%= url %>" ;
</script>
<%  
        response.End      
	End IF
	
            
            IF IG_HANDICAP = "0" THEN
		        Score1 = IG_Score1
	        ELSE
		        IF IG_TYPE = "2" THEN 
			        Score1 = IG_Score1
		        ELSE 
			        Score1 = Cdbl(IG_Score1) + Cdbl(IG_HANDICAP)
		        END IF
	        END IF
        	
	        Score2 = IG_Score2
	        
	        IG_Draw = 1 
	        
            IF IG_TYPE = "2" THEN '오/언
		        IF Cdbl(IG_HANDICAP) < Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			        tempWinTeam = 1
		        ElseIf Cdbl(IG_HANDICAP) = Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			        tempWinTeam = 0
			        IG_Draw = 3
		        Else 
			        tempWinTeam = 2
		        END IF
	        ELSE
		        IF Cdbl(Score1) > Cdbl(Score2) THEN
			        tempWinTeam = 1
		        ELSEIF Cdbl(Score1) < Cdbl(Score2) THEN
			        tempWinTeam = 2
		        ElseIf Cdbl(Score1) = Cdbl(Score2) And IG_TYPE = "1"  THEN '핸디
			        tempWinTeam = 0
			        IG_Draw = 3
                ElseIf Cdbl(Score1) = Cdbl(Score2) And cStr(IG_DRAWBENEFIT) = "0"  THEN	'야구와 같은 경우 적특처리            
	                tempWinTeam = 0
	                IG_Draw = 3  			        
		        Else 
			        tempWinTeam = 0
		        END IF
	        END IF 
	    
            WinTeam = tempWinTeam
            
           
           '######### 디비 연결                    ################	
            dfDBConn.SetConn = Application("DBConnString")
	        dfDBConn.Connect()	
        	            
            Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, IG_Draw, WinTeam, IG_TYPE)
            
            '##### 정산 할 배팅 개수를 가져온다.
            Call dfgameSql.ExecGameResultStep1Cnt(dfDBConn.Conn)
            IF dfgameSql.RsCount <> 0 Then
                IB_CNT = dfgameSql.RsOne("IB_CNT")
            End IF
            
        NEXT		    	  

	IF IB_CNT <> 0 Then
	    url = "List.asp?page="&Page&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&""
%>
<script type="text/javascript">
    alert("마감 되었습니다.\n정산 마감 및 취소/적특의 경우 정산하기 페이지로 이동해주세요.정산건수(<%= IB_CNT %>)");
    //parent.location.href = "<%= url %>" ;
    window.open("/EPCenter/04_Game/ResultGame_Step2.asp");
</script>
<%
    Else
%>
<script type="text/javascript">
    alert("마감 되었습니다.");
    //parent.location.reload();
</script>
<%
    End IF

    ElseIF mode = "del" Then
    
	    FOR i = 0 TO TotalCount 
		    IG_IDX = SelUser(i)

		    SQLMSG = "SELECT IG_STATUS, IG_TEAM1BETTING, IG_DRAWBETTING, IG_TEAM2BETTING  FROM INFO_GAME WHERE IG_IDX = "& IG_IDX &" "
		    SET RS = DbCon.Execute(SQLMSG)

		    IG_STATUS		= RS(0)
		    IG_TEAM1BETTING = RS(1)
		    IG_DRAWBETTING	= RS(2)
		    IG_TEAM2BETTING	= RS(3)
		    RS.Close
		    Set RS = Nothing

			        
		    IF IG_STATUS = "R" OR IG_STATUS = "C" THEN
			    DELSQL = "DELETE INFO_GAME WHERE IG_IDX = "& IG_IDX &""
			    DbCon.execute(DELSQL)
            ElseIF IG_STATUS = "E" OR IG_STATUS = "S"  THEN
                IF IG_TEAM1BETTING + IG_DRAWBETTING + IG_TEAM2BETTING =  0 Then        			
			        DELSQL = "DELETE INFO_GAME WHERE IG_IDX = "& IG_IDX &""
			        DbCon.execute(DELSQL)            
                End IF
		    END IF

        NEXT		    
	End IF


	DbCon.Close
	Set DbCon=Nothing
		
	url = "List.asp?page="&Page&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&""
%>
<script type="text/javascript">
parent.location.href = "<%= url %>" ;
</script>