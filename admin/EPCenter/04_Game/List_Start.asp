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
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    page        = Trim(dfRequest("page"))
	SRL_League  = Trim(dfRequest("SRL_League"))
	SRS_Sports  = Trim(dfRequest("SRS_Sports"))
	SFlag       = Trim(dfRequest("SFlag"))	
	Search      = Trim(dfRequest("Search"))
	Find        = Trim(dfRequest("Find"))
    IG_Type = REQUEST("IG_Type")

	
	'##### 페이징 처리를 위한 변수 지정  ###############
    SFlag = "S"
    IG_Type =  9 	
    pageSize        = 9999
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

    	
	'######### 리그 리스트를 불러옴                 ################	
	Call dfgameSql.RetrieveInfo_Game(dfDBConn.Conn,  1, 9999, SRS_Sports, SRL_League, SFlag, Search, Find, GSITE, IG_Type)
    
	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
	
		
%>
<html>
<head>
<title>새로운 게임등록</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<style type="text/css">
.classBold {font-weight:bold;color:red;background:black}
.classBold td {font-weight:bold;color:red;background:black}
.classBold a {font-weight:bold;color:red;background:black}
.classBold a:hover {font-weight:bold;color:red;background:black}
.classBold a:link {font-weight:bold;color:red;background:black}
.classBold a:active {font-weight:bold;color:red;background:black}
.classBold a:visited {font-weight:bold;color:red;background:black}

</style>
</head>

<body topmargin="0" marginheight="0">

<table border="0" cellspacing="1" cellpadding="1" bgcolor="#AAAAAA" width="100%" id="Table2">
  <tr bgcolor="#CCCCCC" height="25"> 
	<td align="center">리그명</td>
	<td align="center">경기시간</td>
	<td align="center">타입</td>
	<td align="center">홈팀</td>
	<td align="center">원정팀</td>	
	<td align="center">기준치</td>	
	<td align="center">홈배당</td>
	<td align="center">금액(홈)</td>
	<td align="center">건(홈)</td>
	<td align="center">무배당</td>
	<td align="center">금액(무)</td>
	<td align="center">건(무)</td>
	<td align="center">원정배당</td>	
	<td align="center">금액(원정)</td>
	<td align="center">건(원정)</td>	
	<td align="center">사이트</td>	
  </tr>
  <%
  
    IF dfgameSql.RsCount <> 0 THEN
	  FOR i = 0 TO dfgameSql.RsCount -1
		
        SUM_COUNT  = 0
		IG_IDX			= dfgameSql.Rs(i,"IG_IDX")
		RL_LEAGUE		= dfgameSql.Rs(i,"RL_LEAGUE")
		RL_IMAGE		= dfgameSql.Rs(i,"RL_IMAGE")
		RL_IMAGE		= "<img src='/UpFile/League/" & RL_IMAGE & "' width='20' height='14' style='border:1px solid;' align='absmiddle'>"
		IG_STARTTIME	= dfStringUtil.GetFullDate(dfgameSql.Rs(i,"IG_STARTTIME"))		
		IG_TEAM1		= dfgameSql.Rs(i,"IG_TEAM1")
		IG_TEAM2		= dfgameSql.Rs(i,"IG_TEAM2")
		IG_HANDICAP		= CDbl(dfgameSql.Rs(i,"IG_HANDICAP"))
		
		IG_TEAM1BENEFIT = dfgameSql.Rs(i,"IG_TEAM1BENEFIT")
		IG_DRAWBENEFIT	= dfgameSql.Rs(i,"IG_DRAWBENEFIT")
		IG_TEAM2BENEFIT = dfgameSql.Rs(i,"IG_TEAM2BENEFIT")
		
		IG_TEAM1BETTING = dfgameSql.Rs(i,"IG_TEAM1BETTING")
		IG_DRAWBETTING	= dfgameSql.Rs(i,"IG_DRAWBETTING")
		IG_TEAM2BETTING	= dfgameSql.Rs(i,"IG_TEAM2BETTING")
		
		IG_TEAM1BET_CNT = dfgameSql.Rs(i,"IG_TEAM1BET_CNT")
		IG_TEAM2BET_CNT	= dfgameSql.Rs(i,"IG_TEAM2BET_CNT")
		IG_DRAWBET_CNT	= dfgameSql.Rs(i,"IG_DRAWBET_CNT")
				
		IG_SCORE1		= dfgameSql.Rs(i,"IG_SCORE1")
		IG_SCORE2		= dfgameSql.Rs(i,"IG_SCORE2")
		IG_RESULT		= Trim(dfgameSql.Rs(i,"IG_RESULT"))
		IG_STATUS		= dfgameSql.Rs(i,"IG_STATUS")
		IG_TYPE			= dfgameSql.Rs(i,"IG_TYPE")
		IG_VSPOINT		= dfgameSql.Rs(i,"IG_VSPOINT")
		IG_MEMO			= dfgameSql.Rs(i,"IG_MEMO")
		IG_SITE			= dfgameSql.Rs(i,"IG_SITE")
		IG_SP			= dfgameSql.Rs(i,"IG_SP")
		I7_IDX			= dfgameSql.Rs(i,"I7_IDX")
		II_STATUS		= dfgameSql.Rs(i,"II_STATUS")
		IG_EVENT		= dfgameSql.Rs(i,"IG_EVENT")
		IG_SITE		= dfgameSql.Rs(i,"IG_SITE")
		II_IDX		= dfgameSql.Rs(i,"II_IDX")


        
        tdColor = "" 
	    if IG_SP = "Y" Then tdColor = "8cafda" 

        color = "#EEEEEE"
        If i Mod 2 = 0 Then color = "#FFFFFF"
        	    
		IF IG_RESULT = "0" THEN
			GameResult = " "
		ELSEIF IG_RESULT = "1" THEN
			GameResult = "홈팀승"
		ELSEIF IG_RESULT = "2" THEN
			GameResult = "원정팀승"
		END IF	

	    IF IG_TYPE = "2" THEN 
		    VIEWCAP = "오언"
		    VIEWTDCOLOR = "EFAEE1"
	    ELSEIF IG_TYPE = "1" THEN 
		    VIEWCAP = "핸디"
		    VIEWTDCOLOR = "ffff00"
        ELSEIF IG_TYPE = "3" THEN 
		    VIEWCAP = "점수맞추기"
		    VIEWTDCOLOR = "ff0000"		    
        Else			    
            VIEWCAP = "승패"
            VIEWTDCOLOR = "ffffff"
	    END IF	
	    			    
	    SUM_COUNT = CDBL(IG_TEAM1BETTING) + CDBL(IG_DRAWBETTING) + CDBL(IG_TEAM2BETTING)
		
		IF SUM_COUNT > 500000 Then
		    bold = "classBold"
		Else
		    bold = ""
		End IF
		
        IF SUM_COUNT > 0 Then	
        		     
%>
  <tr  height="25" bgcolor="<%= color %>" class="<%= bold %>">

	<td bgcolor="<%= tdColor %>" >
    	<a href="Betting_List1.asp?IG_IDX=<%= IG_IDX %>" target="_blank"><%=RL_LEAGUE%></a>
	</td>
	<td align="center">
	    <%=IG_STARTTIME%>
	</td>
	<td bgcolor="<%= VIEWTDCOLOR %>">
	<%= VIEWCAP%>
	</td>
	<td>
	    <a href="Betting_List1.asp?IG_IDX=<%= IG_IDX %>" target="_blank"><%=IG_TEAM1%></a>
	</td>	
	<td>
	    <a href="Betting_List1.asp?IG_IDX=<%= IG_IDX %>" target="_blank"><%=IG_TEAM2%></a>
	</td>    			
    <td align="center" valign="top">    
    	<%=IG_HANDICAP%>
    </td>
	<td bgcolor='#eeeeee'><%=IG_TEAM1BENEFIT%></td>			
	<td align="center"><%=formatnumber(IG_TEAM1BETTING,0)%></td>
	<td align="center"><%=formatnumber(IG_TEAM1BET_CNT,0)%></td>	
	<td bgcolor='#eeeeee'><%=IG_DRAWBENEFIT%></td>    	
	<td align="center"><%=formatnumber(IG_DRAWBETTING,0)%></td>	
	<td align="center"><%=formatnumber(IG_DRAWBET_CNT,0)%></td>	
	<td bgcolor='#eeeeee'><%=IG_TEAM2BENEFIT%></td>		
	<td align="center"><%=formatnumber(IG_TEAM2BETTING,0)%></td>
	<td align="center"><%=formatnumber(IG_TEAM2BET_CNT,0)%></td>	
	<td align="center"><%= IG_SITE %></td>
  </tr>
  <%      	
        End IF
    Next 
END IF
%>
 </table>
</body>
</html>
