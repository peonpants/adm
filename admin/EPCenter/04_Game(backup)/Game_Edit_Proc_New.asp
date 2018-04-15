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
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")

	IG_IDX		= REQUEST("IG_IDX")
	IG_StartTime		= REQUEST("IG_STARTTIME")

	IG_Team1	= Trim(REQUEST("IG_Team1"))
	IG_Team2	= Trim(REQUEST("IG_Team2"))
	IG_STATUS   = Trim(REQUEST("IG_STATUS"))
	IG_SCORE1   = Trim(REQUEST("IG_SCORE1"))
	IG_SCORE2   = Trim(REQUEST("IG_SCORE2"))
	RL_LEAGUE   = Trim(REQUEST("RL_LEAGUE"))
	IG_SITE   = Trim(REQUEST("IG_SITE"))
	
	
	IG_Team1Benefit = formatnumber(Trim(REQUEST("IG_Team1Benefit")),2)
	IG_DrawBenefit = formatnumber(Trim(REQUEST("IG_DrawBenefit")),2)
	IG_Team2Benefit = formatnumber(Trim(REQUEST("IG_Team2Benefit")),2)
	IG_Handicap = formatnumber(Trim(REQUEST("IG_Handicap")),2)

	IG_Memo = Trim(REQUEST("IG_Memo"))
	IG_Event = Trim(REQUEST("IG_Event"))
	IG_SP = Trim(REQUEST("IG_SP"))
    I7_IDX   = Trim(REQUEST("I7_IDX"))

    IF NOT (IG_STATUS = "F" OR tIG_STATUS = "C") Then
	    SQLMSG = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, RL_KR_LEAGUE FROM Ref_League WHERE RL_League = '"& RL_LEAGUE &"' OR RL_KR_LEAGUE = '"& RL_LEAGUE &"' "
	    SET RS = DbCon.Execute(SQLMSG)

        IF RS.EOF Then
%>
    <script type="text/javascript">
    alert("리그명을 정확히 입력하세요.");
    </script>
<%    
            response.End
        End IF
    
	RL_IMAGE	= RS("RL_IMAGE")
	RL_SPORTS	= RS("RL_SPORTS")
	RL_IDX	    = RS("RL_IDX")

	RS.Close
	Set RS = Nothing
	End IF
	
    SQLMSG = "SELECT IG_Team1Benefit,IG_DrawBenefit,IG_Team2Benefit, IG_Handicap, IG_TYPE, IG_STATUS  FROM INFO_GAME WHERE IG_IDX=" & IG_IDX
    SET UMO = DbCon.Execute(SQLMSG)
		
	tIG_Team1Benefit	= Cdbl(UMO(0))
	tIG_DrawBenefit	    = Cdbl(UMO(1))
	tIG_Team2Benefit	= Cdbl(UMO(2))
	tIG_Handicap	    = Cdbl(UMO(3))	
	IG_TYPE	            = Cdbl(UMO(4))	
	tIG_STATUS	        = UMO(5)
            
	UMO.Close
	Set UMO = Nothing
	
	
	IF IG_STATUS <> "E" AND (tIG_STATUS = "F" OR tIG_STATUS = "C") Then
%>
<script type="text/javascript">
    alert("배팅마감으로 복원 후 다시 정산해주시기 바랍니다.");
    parent.location.reload();
</script>
<%  
        response.End      
	End IF
    		
	'// DB 입력......
	UPDSQL = "UPDATE INFO_GAME SET IG_Team1Benefit=" & Cdbl(IG_Team1Benefit)
	UPDSQL = UPDSQL & ", IG_StartTime='" & IG_StartTime
	UPDSQL = UPDSQL & "', IG_DrawBenefit=" & Cdbl(IG_DrawBenefit)
	UPDSQL = UPDSQL & ", IG_Team2Benefit=" & Cdbl(IG_Team2Benefit)
	UPDSQL = UPDSQL & ", IG_Handicap=" & Cdbl(IG_Handicap)
	'UPDSQL = UPDSQL & ", IG_Memo='" & IG_Memo & "' "
	UPDSQL = UPDSQL & ", IG_Team1='" & IG_Team1 & "' "
	UPDSQL = UPDSQL & ", IG_Team2='" & IG_Team2 & "' "
	UPDSQL = UPDSQL & ", IG_STATUS='" & IG_STATUS & "' "
	UPDSQL = UPDSQL & ", IG_SITE='" & IG_SITE & "' "
	UPDSQL = UPDSQL & ", IG_SP='" & IG_SP & "' "
	UPDSQL = UPDSQL & ", I7_IDX='" & I7_IDX & "' "
	IF NOT (IG_STATUS = "F" OR tIG_STATUS = "C") Then
	    UPDSQL = UPDSQL & ", RL_IDX='" & RL_IDX & "' "		
	    UPDSQL = UPDSQL & ", RL_IMAGE='" & RL_IMAGE & "' "	
	    UPDSQL = UPDSQL & ", RL_SPORTS='" & RL_SPORTS & "' "
	End IF
	UPDSQL = UPDSQL & ", RL_LEAGUE='" & RL_LEAGUE & "' "	
	UPDSQL = UPDSQL & " WHERE IG_IDX=" & IG_IDX


	DbCon.Execute (UPDSQL)
	

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
    dfDBConn.Connect()	
    	
	'형이 싫어요
	
	IB_CNT = 0
	
	IF IG_STATUS = "E" AND (tIG_STATUS = "F" OR tIG_STATUS = "C") Then	    
	    Call dfgameSql.ExecGameResultRollBack(dfDBConn.Conn,  IG_IDX)
	ElseIF IG_STATUS = "C" Then
	    Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, 0, 0, 2, 0, IG_TYPE)
	ElseIF IG_STATUS = "F" Then
                
        IF Cdbl(IG_HANDICAP) = 0 THEN
            Score1 = IG_Score1
        ELSE
            IF cStr(IG_TYPE) = "2" THEN 
	            Score1 = IG_Score1
            ELSE 
	            Score1 = Cdbl(IG_Score1) + Cdbl(IG_HANDICAP)
            END IF
        END IF
    	
        Score2 = IG_Score2
        
        IG_Draw = 1 
        
        IF cStr(IG_TYPE) = "2" THEN '오/언
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
            ElseIf Cdbl(Score1) = Cdbl(Score2) And cStr(IG_TYPE) = "1"  THEN '핸디
	            tempWinTeam = 0
	            IG_Draw = 3
            ElseIf Cdbl(Score1) = Cdbl(Score2) And Cdbl(IG_DrawBenefit) = 0  THEN	'야구와 같은 경우 적특처리      '문제되는지 보기      
	            tempWinTeam = 0
	            IG_Draw = 3            
            Else 
	            tempWinTeam = 0
            END IF
        END IF 

        WinTeam = tempWinTeam

        Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, IG_Draw, WinTeam, IG_TYPE)
        
        '##### 정산 할 배팅 개수를 가져온다.
        Call dfgameSql.ExecGameResultStep1Cnt(dfDBConn.Conn)
        IF dfgameSql.RsCount <> 0 Then
            IB_CNT = dfgameSql.RsOne("IB_CNT")
        End IF
	End IF
	
	DbCon.Close
	Set DbCon=Nothing

	IF IB_CNT <> 0 Then
%>
<script type="text/javascript">
    alert("수정되었습니다.\n정산 마감 및 취소/적특의 경우 정산하기 페이지로 이동해주세요.정산건수(<%= IB_CNT %>)");
    window.open("/EPCenter/04_Game/ResultGame_Step2.asp");
    //parent.location.reload();
</script>
<%
    Else
%>
<script type="text/javascript">
    alert("수정되었습니다.");
    //parent.location.reload();
</script>
<%
    End IF
%>