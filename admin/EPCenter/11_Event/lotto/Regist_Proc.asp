<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
	SQLMSG = "SELECT REPLACE(NEWID(), '-', '') AS IL_GUID, (ISNULL(MAX(IL_NUM), 0) + 1) AS IL_NUM FROM dbo.INFO_LOTTO WITH(NOLOCK)"
	SET RS = DbCon.Execute(SQLMSG)
	IL_GUID		= RS("IL_GUID")
	IL_NUM	= RS("IL_NUM")
	RS.Close
	Set RS = Nothing

	IL_SITE					= "All"
	IL_TITLE				= REQUEST("IL_TITLE")
	IL_TITLE				= Replace(IL_TITLE, "'", "&#39;")
	IL_DATE					= REQUEST("IL_DATE")
	IL_DEFAULT_PRIZE_MONEY	= REQUEST("IL_DEFAULT_PRIZE_MONEY")
    IL_BASIC_BET_MONEY		= REQUEST("IL_BASIC_BET_MONEY")
	IL_ENABLE				= REQUEST("IL_ENABLE")
	input_ea				= REQUEST("input_ea")

	' 빈값 확인
	For i = 1 TO input_ea
		If Request("ILG_StartTime_"&i) = "" Or Request("RL_Sports_"&i) = "" Or Request("RL_League_"&i) = "" Or Request("ILG_Type_"&i) = "" Or Request("ILG_Team1_"&i) = "" Or Request("ILG_Team2_"&i) = "" Or Request("ILG_Handicap_"&i) = "" Then
			Response.Write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
			Response.End
			Exit For
		End If
	Next

	' 로또 입력
	SQL = "		INSERT INTO dbo.INFO_LOTTO "
	SQL = SQL & "(IL_GUID, IL_NUM, IL_TITLE, IL_DEFAULT_PRIZE_MONEY, IL_ACCRUE_BET_MONEY, IL_BASIC_BET_MONEY, IL_ENABLE, IL_DATE, IL_SITE, IL_BET_COUNT, IL_REGDATE) "
	SQL = SQL & "VALUES "
	SQL = SQL & "('" & IL_GUID & "', " & IL_NUM & ", '" & IL_TITLE & "', " & IL_DEFAULT_PRIZE_MONEY & ", 0, " 
	SQL = SQL & IL_BASIC_BET_MONEY & ", '" & IL_ENABLE & "', '" & IL_DATE & "', '" & IL_SITE & "', 0, getDate())"
	DbCon.Execute (SQL)  
	
	' 로또 게임 입력
	FOR i = 1 TO input_ea 
	
	    ILG_StartTime	= Trim(REQUEST("ILG_StartTime_"&i))
		RL_Sports		= Trim(REQUEST("RL_Sports_"&i))
		RL_League		= Trim(REQUEST("RL_League_"&i))
		ILG_Type		= Trim(REQUEST("ILG_Type_"&i))
	    ILG_Team1		= Trim(REQUEST("ILG_Team1_"&i))
		ILG_Team1		= Replace(ILG_Team1, "'", "&#39;")
	    ILG_Team2		= Trim(REQUEST("ILG_Team2_"&i))
		ILG_Team2		= Replace(ILG_Team2, "'", "&#39;")
		ILG_Handicap	= Trim(REQUEST("ILG_Handicap_"&i))
		IF ILG_Handicap = "" Then
			ILG_Handicap = 0
		End If

		' 리그 이미지
		SQLMSG = "SELECT RL_IMAGE FROM Ref_League WHERE RL_League = '" & RL_League & "'"
		SET RS = DbCon.Execute(SQLMSG)
		RL_Image = RS("RL_IMAGE")
		RS.Close
		Set RS = Nothing

		' 입력
		SQL = "		INSERT INTO dbo.INFO_LOTTO_GAME "
        SQL = SQL & "(IL_GUID, ILG_NUM, RL_SPORTS, RL_LEAGUE, RL_IMAGE, ILG_STARTTIME, ILG_TEAM1, ILG_TEAM2, ILG_HANDICAP, ILG_SCORE1, ILG_SCORE2, ILG_RESULT ,ILG_TYPE, ILG_STATUS) "
		SQL = SQL & "VALUES "
		SQL = SQL & "('" & IL_GUID & "', " & i & ", '" & RL_Sports & "', '" & RL_League & "', '" & RL_Image & "', '" & ILG_StartTime & "'"
		SQL = SQL & ", '" & ILG_Team1 & "', '" & ILG_Team2 & "', " & ILG_Handicap & ", 0, 0, NULL, '" & ILG_Type & "', 'S')"

		DbCon.Execute (SQL)  
    Next
    
	DbCon.Close
	Set DbCon=Nothing

	Response.redirect "list.asp"	
%>