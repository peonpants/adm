<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
'=================================================================================   홍실장
' 2017-08-07
' 전체 선택 게임 일괄 등록
' 
'=================================================================================   홍실장


DIM chkb
DIM ARRrfq
DIM i
DIM j
DIM strDataPost
DIM SRL_League
DIM Process
DIM IG_IDX
DIM IG_TYPE
DIM IG_STATUS
DIM IG_TEAM1BENEFIT
DIM completcount
DIM completcountE

completcount = 0
completcountE = 0
	%>
	<html>
	<head>
		<title>7m 게임 리스트</title>
		<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
	</head>
	<body>
	 <b>체크박스 선택한 게임을 등록합니다.</b><br/>
</table>
	<hr>
	<table><tr><td>순서<td>리그<td>신규/수정<td>홈<td><td>원정<td>상태
	</tr>


	<%
	 for i = 1 to Request("chkb").COUNT 

	 NextRequestNum = Request("chkb")(i)
	 j = NextRequestNum +1
	
	SRL_League		= Trim(Request("SRL_League"&NextRequestNum))
	Process			= Trim(Request("Process"&NextRequestNum))
	IG_StartTime	= Trim(REQUEST("IG_StartTime"&NextRequestNum))
	IG_Team1		= Trim(REQUEST("IG_Team1"&NextRequestNum))
	IG_Team2		= Trim(REQUEST("IG_Team2"&NextRequestNum))

	I7_IDX			= Trim(REQUEST("I7_IDX"&NextRequestNum))

	IF Process = "add" THEN
		IG_IDX = ""
		IG_TYPE = ""
		IG_STATUS = ""
		ProcessMes = "신규"

	ELSE
		Process =  "modify"
			IG_IDX = Trim(REQUEST("IG_IDX"& NextRequestNum))
			IG_TYPE = Trim(REQUEST("IG_TYPE"& NextRequestNum))
			IG_STATUS = Trim(REQUEST("IG_STATUS"& NextRequestNum))
		ProcessMes = "수정"

	END IF


    IG_TEAM1BENEFIT = Trim(REQUEST("IG_TEAM1BENEFIT" & NextRequestNum))


	' 개별 등록버튼 누르면 자바프로그램으로 검색해서 내역있나 보고 채워주는 자바프로그램 다시 제작------------------시작-홍




	'승(적용)에 값이 없을 경우 승(변경) 에서 값을 가져오고 그것도 없을 경우 승에서 값을 가져온다
	if IG_TEAM1BENEFIT = "" then
		if Trim(REQUEST("I7_C_TEAM1BENEFIT"&NextRequestNum)) ="" then
			IG_TEAM1BENEFIT =Trim(REQUEST("I7_TEAM1BENEFIT"&NextRequestNum))
		else
			IG_TEAM1BENEFIT = Trim(REQUEST("I7_C_TEAM1BENEFIT"&NextRequestNum))
		end if
	else
	end if
    IG_TEAM1BENEFIT = FORMATNUMBER(IG_TEAM1BENEFIT,2)



	IG_DRAWBENEFIT = Trim(REQUEST("IG_DRAWBENEFIT"&NextRequestNum ))
	if IG_DRAWBENEFIT = "" then
		if Trim(REQUEST("I7_C_DRAWBENEFIT"&NextRequestNum)) ="" then
			IG_DRAWBENEFIT =Trim(REQUEST("I7_DRAWBENEFIT"&NextRequestNum))
		else
			IG_DRAWBENEFIT = Trim(REQUEST("I7_C_DRAWBENEFIT"&NextRequestNum))
		end if
	else
	end if
    IG_DRAWBENEFIT	= FORMATNUMBER(IG_DRAWBENEFIT,2)



	
	
	
	
	IG_TEAM2BENEFIT = Trim(REQUEST("IG_TEAM2BENEFIT"&NextRequestNum ))
	if IG_TEAM2BENEFIT = "" then
		if Trim(REQUEST("I7_C_TEAM2BENEFIT"&NextRequestNum)) ="" then
			IG_TEAM2BENEFIT =Trim(REQUEST("I7_TEAM2BENEFIT"&NextRequestNum))
		else
			IG_TEAM2BENEFIT = Trim(REQUEST("I7_C_TEAM2BENEFIT"&NextRequestNum))
		end if
	else
	end if

    IG_TEAM2BENEFIT	= FORMATNUMBER(IG_TEAM2BENEFIT,2)



	txtConfirm1 =""
	IG_Type02 = Trim(REQUEST("IG_Type02"&NextRequestNum))
	IF  IG_Type02 = "Yes" THEN
		txtConfirm1 = "핸디캡 "
	END IF

	IG_Type03 = Trim(REQUEST("IG_Type03"&NextRequestNum))
	IF  IG_Type03 = "Yes" THEN
		txtConfirm1  = txtConfirm1 & " 오버언더"
	END IF

	' 개별 등록버튼 누르면 검색해서 내역있나 보고 채워주는 프로그램 다시 제작------------------ 끝 -홍
		%>
		<tr>
		<td><%=j%>
		<td><%=SRL_League%>
		<td><%=ProcessMes%>
		<td><%=IG_Team1 %>
		<td> VS 
		<td><%=IG_Team2 %>
		<td><%=txtConfirm1 %>

		<%

    '######## 리그 체크
	SQLMSG = "SELECT TOP 1 RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE , RL_KR_LEAGUE FROM Ref_League WHERE RL_League = '"& SRL_League &"' ORDER BY RL_IDX DESC"
	SET RS = DbCon.Execute(SQLMSG)
    
    IF Rs.Eof Then
		%>
		<td colspan=3><b><font color=red>실패!</font> &nbsp;&nbsp;&nbsp; <%= SRL_League %></b> 는 등록되지 않은 리그입니다. <a href="../03_League/List.asp"><font color=red><b>리그 등록</font></a>을 먼저하세요</b></font>
		<%    
		'리그에 등록되어 있지 않으면
		else
		'리그에 등록되어 있으니 저장하자
    
	RL_IDX		= RS("RL_IDX")
	SRS_Sports	= RS("RL_SPORTS")
	RL_LEAGUE	= RS("RL_LEAGUE")
	RL_IMAGE	= RS("RL_IMAGE")
	
	IF KR_LEAGUE Then
	    IF RS("RL_KR_LEAGUE") <> "" Then
	        SRL_League = RS("RL_KR_LEAGUE")
        End IF	        
    End IF



    


    IG_H_TEAM1BENEFIT = Trim(REQUEST("IG_H_TEAM1BENEFIT"&NextRequestNum))
    IG_H_DRAWBENEFIT	= Trim(REQUEST("IG_H_DRAWBENEFIT"&NextRequestNum))
    IG_H_TEAM2BENEFIT = Trim(REQUEST("IG_H_TEAM2BENEFIT"&NextRequestNum))
 
    IG_O_TEAM1BENEFIT = Trim(REQUEST("IG_O_TEAM1BENEFIT"&NextRequestNum))
    IG_O_DRAWBENEFIT	= Trim(REQUEST("IG_O_DRAWBENEFIT"&NextRequestNum))
    IG_O_TEAM2BENEFIT = Trim(REQUEST("IG_O_TEAM2BENEFIT"&NextRequestNum))
    
    
    IG_SITE			= "ALL"
    IG_Memo			= ""
	        
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

		%><td colspan=3><font color=red><b>		    빈값이 있습니다(<%=IG_HANDICAP%> | <%=IG_TEAM1BENEFIT%> | <%=IG_DRAWBENEFIT%> | <%=IG_TEAM2BENEFIT%> | <%=IG_TYPE%> | <%=IG_SITE%> | <%=I7_IDX%>)</font></b>
		<%
		ELSE	'If IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= "" Or I7_IDX = "" Then

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
			completcount = completcount +1
			%><td><font color=blue>승무패완료</font><%
	    
	    '핸디캡 저장
	    IF IG_Type02 = "Yes" And IG_H_TEAM1BENEFIT <> "" And IG_H_TEAM2BENEFIT <> "" AND IG_H_DRAWBENEFIT <> "" THEN






            IG_H_DRAWBENEFIT = FORMATNUMBER(Trim(IG_H_TEAM2BENEFIT),2)
            IG_H_DRAWBENEFIT	= FORMATNUMBER(Trim(IG_H_DRAWBENEFIT),2)
            IG_H_TEAM2BENEFIT = FORMATNUMBER(Trim(IG_H_TEAM2BENEFIT),2)
            
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
			%>
			<td><font color=blue>핸디캡완료</font>
			<%

	    END IF
    		   
        '오버언더 저장
	    IF IG_Type03 = "Yes" And IG_O_TEAM1BENEFIT <> "" And IG_O_TEAM2BENEFIT <> "" AND IG_O_DRAWBENEFIT <> "" THEN

            IG_O_TEAM1BENEFIT = FORMATNUMBER(Trim(IG_O_TEAM1BENEFIT),2)
            IG_O_DRAWBENEFIT	= FORMATNUMBER(Trim(IG_O_DRAWBENEFIT),2)
            IG_O_TEAM2BENEFIT = FORMATNUMBER(Trim(IG_O_TEAM2BENEFIT),2)
            
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
		%>
		<td><font color=blue>오버언더완료</font>
		<%	    		    

	    END IF '오버언더 기록 완료

	
	End If  'IF IG_HANDICAP= "" Or IG_TEAM1BENEFIT = "" Or IG_DRAWBENEFIT= "" Or	IG_TEAM2BENEFIT= "" Or IG_TYPE= "" Or IG_SITE= "" Or I7_IDX = "" Then


    ElseIF cStr(Process) = "modify" Then         

        IG_STATUS = Trim(REQUEST("IG_STATUS"&NextRequestNum))        
    
        IF Trim(REQUEST("IG_TYPE"&NextRequestNum)) = "0" Then
            SQL = "UPDATE INFO_GAME SET"

            SQL = SQL & " IG_StartTime = '" & IG_StartTime
            SQL = SQL & "', IG_Team1Benefit = " & Cdbl(IG_Team1Benefit)  
            SQL = SQL & ", IG_DrawBenefit = " & Cdbl(IG_DrawBenefit)  
            SQL = SQL & ", IG_Team2Benefit = " & Cdbl(IG_Team2Benefit)              
            SQL = SQL & ", RL_League = '" & SRL_League 
            SQL = SQL & "', IG_STATUS = '" & IG_STATUS 
            SQL = SQL & "', IG_Team1 = '" & IG_Team1 
            SQL = SQL & "', IG_Team2 = '" & IG_Team2 
            SQL = SQL & "' WHERE IG_IDX = '" & IG_IDX & "' AND I7_IDX =" & I7_IDX
        Else
            SQL = "UPDATE INFO_GAME SET"
            SQL = SQL & " IG_StartTime = '" & IG_StartTime
            SQL = SQL & "', IG_Team1Benefit = " & Cdbl(IG_Team1Benefit)  
            SQL = SQL & ", IG_HANDICAP = " & Cdbl(IG_DrawBenefit)  
            SQL = SQL & ", IG_Team2Benefit = " & Cdbl(IG_Team2Benefit)  
            SQL = SQL & ", RL_League = '" & SRL_League 
            SQL = SQL & "', IG_STATUS = '" & IG_STATUS
            SQL = SQL & "', IG_Team1 = '" & IG_Team1 
            SQL = SQL & "', IG_Team2 = '" & IG_Team2            
            SQL = SQL & "'  WHERE IG_IDX = '" & IG_IDX & "' AND I7_IDX =" & I7_IDX        
        End IF   
	    DbCon.Execute (SQL)
		completcountE = completcountE + 1
			%>
			<td><font color=blue>수정완료</font>
			<%        
    End IF



End IF	'리그에 등록되어있나 확인 끝
	RS.Close
	Set RS = Nothing

NEXT '다음 체크박스 선택 으로 넘어가기

	DbCon.Close
	Set DbCon=Nothing
  
		






%>
</table>
<br/>
 <br/>
 <center>
 <h2>
 ======= 총 <b><%=completcount%></b>개 등록 완료 (<%=completcountE%>개 수정) =======
 </h2>
 <br/>
 <h3>
[  <a href="Game_7mGetData_Kr.asp">게임리스트로 돌아가기</a> ]
</h3>
</center>

</body>
</html>