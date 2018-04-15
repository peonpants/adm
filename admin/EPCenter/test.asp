<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->


<%
			Response.Expires = -10000
			Server.ScriptTimeOut = 300000
		    SQLMSG = "SELECT IG_IDX, IG_HANDICAP, IG_TEAM1BENEFIT, IG_DRAWBENEFIT, IG_TEAM2BENEFIT, IG_TYPE, IG_Score1, IG_Score2, IG_STATUS FROM INFO_GAME with(nolock) WHERE IG_STATUS = 'E' and IG_ANAL = 1 order by IG_IDX"
		    SET RS = DbCon.Execute(SQLMSG)

		IF NOT RS.EOF THEN
			DO UNTIL RS.EOF
			IG_IDX       = RS("IG_IDX")
	        IG_HANDICAP		= RS("IG_HANDICAP")
	        IG_TEAM1BENEFIT	= RS("IG_TEAM1BENEFIT")
	        IG_DRAWBENEFIT	= RS("IG_DRAWBENEFIT")
	        IG_TEAM2BENEFIT	= RS("IG_TEAM2BENEFIT")
	        IG_TYPE			= RS("IG_TYPE")
	        IG_Score1		= RS("IG_Score1")
	        IG_Score2		= RS("IG_Score2")
        	tIG_STATUS       = RS("IG_STATUS")


			IF (tIG_STATUS = "F" OR tIG_STATUS = "C") Then  
			response.end	
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
			response.write ig_idx
		RS.MoveNext
		LOOP
	END IF
%>