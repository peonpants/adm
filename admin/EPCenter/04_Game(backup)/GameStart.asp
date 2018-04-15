<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    page = REQUEST("page")
	SRL_League = REQUEST("SRL_League")
	SRS_Sports = REQUEST("SRS_Sports")
	SFlag = REQUEST("SFlag")	
	Search = Trim(REQUEST("Search"))
	Find = Trim(REQUEST("Find"))
	GSITE = REQUEST("GSITE")
	IG_Type = REQUEST("IG_Type")
	
    IF SFlag = "" Then
        SFlag = "S"
    End IF
	
	IF IG_Type = "" Then
	    IG_Type =  9 
	End IF


	FSql = "select * from info_game"
	SET FRs = Server.CreateObject("ADODB.Recordset")
	FRs.Open FSql, DbCon, 0, 1
	
	FRs.Close
	Set FRs = Nothing 
	
    pageSize        = 1000  
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
   
	Call dfgameSql.RetrieveInfo_Game(dfDBConn.Conn,  page, pageSize, SRS_Sports, SRL_League, SFlag, Search, Find, GSITE, IG_Type)

	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
%>


<table border="0"  cellspacing="1" cellpadding="3" bgcolor="FFFFFF" width="100%" id="tblGameList">
  <%IF dfgameSql.RsCount = 0 THEN%>
  <tr>
    <td align="center" colspan="12" height="35">
	  현재 등록된 게임이 없습니다.
	</td>
  </tr>
    <%
	  ELSE
	%>

	<%
		
		FOR i = 0 TO dfgameSql.RsCount -1
		IG_IDX			= dfgameSql.Rs(i,"IG_IDX")
		RL_IDX			= dfgameSql.Rs(i,"RL_IDX")
		RL_SPORTS			= dfgameSql.Rs(i,"RL_SPORTS")
		RL_LEAGUE		= dfgameSql.Rs(i,"RL_LEAGUE")
		RL_IMAGE		= dfgameSql.Rs(i,"RL_IMAGE")
		IG_STARTTIME	= dfStringUtil.GetFullDate(dfgameSql.Rs(i,"IG_STARTTIME"))		
		IG_TEAM1		= dfgameSql.Rs(i,"IG_TEAM1")
		IG_TEAM2		= dfgameSql.Rs(i,"IG_TEAM2")
		IG_HANDICAP		= CDbl(dfgameSql.Rs(i,"IG_HANDICAP"))
		IG_TEAM1BENEFIT = dfgameSql.Rs(i,"IG_TEAM1BENEFIT")
		IG_DRAWBENEFIT	= dfgameSql.Rs(i,"IG_DRAWBENEFIT")
		IG_TEAM2BENEFIT = dfgameSql.Rs(i,"IG_TEAM2BENEFIT")
		IG_STATUS = dfgameSql.Rs(i,"IG_STATUS")
		IG_TYPE			= dfgameSql.Rs(i,"IG_TYPE")
		IG_SP			= dfgameSql.Rs(i,"IG_SP")
		IG_EVENT			= dfgameSql.Rs(i,"IG_EVENT")

	%>
	<TR NAME="START">
	<td>start_gogo</td>
	<td align="center" NAME="IG_IDX"><%=IG_IDX %></td>
	<td align="center" NAME="RL_IDX"><%=RL_IDX %></td>
	<td align="center" NAME="RL_SPORTS"><%=RL_SPORTS %></td>
	<td align="center" NAME="RL_LEAGUE"><%=RL_LEAGUE %></td>
	<td align="center" NAME="RL_IMAGE"><%=RL_IMAGE %></td>
    <td align="center" NAME="IG_STARTTIME"><%=IG_STARTTIME %></td>    
    <td align="center" NAME="IG_TEAM1"><%=IG_TEAM1 %></td> 
    <td align="center" NAME="IG_TEAM2"><%=IG_TEAM2 %></td>
    <td align="center" NAME="IG_HANDICAP"><%=IG_HANDICAP %></td>
    <td align="center" NAME="IG_TEAM1BENEFIT"><%=IG_TEAM1BENEFIT %></td>
    <td align="center" NAME="IG_DRAWBENEFIT"><%=IG_DRAWBENEFIT %></td>
    <td align="center" NAME="IG_TEAM2BENEFIT"><%=IG_TEAM2BENEFIT %></td>
    <td align="center" NAME="IG_STATUS"><%=IG_STATUS %></td>
	<td align="center" NAME="IG_TYPE"><%=IG_TYPE %></td>
    <td align="center" NAME="IG_SP"><%=IG_SP %></td>
    <td align="center" NAME="IG_EVENT"><%=IG_EVENT %></td>

	<td>end_gogo</td>
	</TR NAME="END">
	<%
		Next 
	  end if
	%>
	</TABLE>
