<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
	SRL_League	= REQUEST("SRL_League")
	SFlag		= REQUEST("SFlag")
	Page		= REQUEST("Page")
    input_ea    = REQUEST("input_ea")


	SQLMSG = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, RL_KR_LEAGUE FROM Ref_League WHERE RL_League = '"& SRL_League &"' "
	SET RS = DbCon.Execute(SQLMSG)

	RL_IDX		= RS("RL_IDX")
	SRS_Sports	= RS("RL_SPORTS")
	RL_LEAGUE	= RS("RL_LEAGUE")
	RL_IMAGE	= RS("RL_IMAGE")
	RL_KR_LEAGUE	= RS("RL_KR_LEAGUE")
	
    IG_SITE     = "All"
	IF KR_LEAGUE Then
	    IF RS("RL_KR_LEAGUE") <> "" Then
	        SRL_League = RS("RL_KR_LEAGUE")
        End IF	        
    End IF    
	RS.Close
	Set RS = Nothing

    
	FOR i = 1 TO input_ea 
	
        IG_STARTTIME_date = Trim(REQUEST("IG_STARTTIME_date"&i))
        IG_STARTTIME_hour = Trim(REQUEST("IG_STARTTIME_hour"&i))
        IG_STARTTIME_second = Trim(REQUEST("IG_STARTTIME_second"&i))
        
        IG_StartTime = IG_STARTTIME_date & " " & right("0" & IG_STARTTIME_hour , 2) &":"& right("0" & IG_STARTTIME_second , 2)

	    'IG_StartTime	= Trim(REQUEST("IG_StartTime"&i))
	    IG_Team1		= Trim(REQUEST("IG_Team1"&i))
	    IG_Team2		= Trim(REQUEST("IG_Team2"&i))
	    
	    
	    '승무패 저장
	    IG_Type01		= Trim(REQUEST("IG_Type01"&i))

	    IG_SP		= Trim(REQUEST("IG_SP"&i))
	    If IG_SP <> "" Then
	    Else
		    IG_SP = "N"
	    End If 

	    If IG_StartTime = "" OR IG_Team1 = "" OR IG_Team2 = ""  Then
	    	response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
	    	response.end
	    End If 

	    IF IG_Type01 = "Yes" THEN

		    IG_HANDICAP		= 0
		    IG_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("01_Bet"&i)),2)
		    IG_DRAWBENEFIT = Trim(REQUEST("02_Bet"&i))
		    IF IG_DRAWBENEFIT = "" Then
		        IG_DRAWBENEFIT = 0
		    End IF
		    IG_DRAWBENEFIT	= FORMATNUMBER(IG_DRAWBENEFIT,2)
		    IG_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("03_Bet"&i)),2)

		    
		    IG_TYPE			= 0
		    IG_SITE			= Trim(REQUEST("01_SITE"&i))
		    IG_Memo			= Trim(REQUEST("IG_Memo"&i))

		    If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= ""  Then
			    response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
			    response.end
		    End If 

		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP,IG_STATUS) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','R') "
		    DbCon.Execute (SQL)

	    END IF


	    '핸디캡 저장
	    IG_Type02		= Trim(REQUEST("IG_Type02"&i))
	    IF IG_Type02 = "Yes" THEN

		    IG_HANDICAP		= Trim(REQUEST("05_Bet"&i))
		    IG_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("04_Bet"&i)),2)
		    IG_DRAWBENEFIT	= 0
		    IG_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("06_Bet"&i)),2)
		    IG_TYPE			= 1
		    IG_SITE			= Trim(REQUEST("02_SITE"&i))
		    IG_Memo			= Trim(REQUEST("IG_Memo"&i))

		    If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= ""  Then
			    response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
			    response.end
		    End If 

		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP,IG_STATUS) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','R') "

		    DbCon.Execute (SQL)

	    END IF


	    '오버언더 저장
	    IG_Type03		= Trim(REQUEST("IG_Type03"&i))
	    IF IG_Type03 = "Yes" THEN

		    IG_HANDICAP		= Trim(REQUEST("08_Bet"&i))
		    IG_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("07_Bet"&i)),2)
		    IG_DRAWBENEFIT	= 0
		    IG_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("09_Bet"&i)),2)
		    IG_TYPE			= 2
		    IG_SITE			= Trim(REQUEST("03_SITE"&i))
		    IG_Memo			= Trim(REQUEST("IG_Memo"&i))

		    If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= "" Then
			    response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
			    response.end
		    End If 

		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP,IG_STATUS) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','R') "
		    DbCon.Execute (SQL)

	    END IF
	    
        '점수맞추기
	    IG_Type04		= Trim(REQUEST("IG_Type04"&i))
	    IF IG_Type04 = "Yes" THEN

		    
		    IG_TEAM1BENEFIT = FORMATNUMBER(Trim(REQUEST("10_Bet"&i)),2)		    
		    IG_TEAM2BENEFIT = FORMATNUMBER(Trim(REQUEST("13_Bet"&i)),2)
		    IG_HANDICAP		= FORMATNUMBER(Trim(REQUEST("12_Bet"&i)),2)
		    IG_DRAWBENEFIT	= FORMATNUMBER(Trim(REQUEST("11_Bet"&i)),2)
		    IG_TYPE			= 3
		    IG_SITE			= "All"'Trim(REQUEST("04_SITE"&i))
		    IG_Memo			= Trim(REQUEST("IG_Memo"&i))

		    If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= "" Then
			    response.write "<script>alert('빈값이 있습니다.');history.back(-1);</script>"
			    response.end
		    End If 

		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		    SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE, IG_SP,IG_STATUS) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & SRL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		    SQL = SQL & IG_Type & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"','"& IG_SP&"','R') "
		    DbCon.Execute (SQL)

	    END IF
	    	    
    Next
    
	DbCon.Close
	Set DbCon=Nothing
    SFlag = "R"
%>
<script type="text/javascript">
location.href = "List.asp?SFlag=R" ;
</script>
<%    
	
	
Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If
	
    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")
	
    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")
	
    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If
	
    URLDecode = sOutput
End Function
	
%>