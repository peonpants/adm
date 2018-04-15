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
	SETSIZE = 20
	PGSIZE = 30

    PAGE = REQUEST("PAGE")
	Search = REQUEST("Search")
	Find = Trim(REQUEST("Find"))
    sStartDate = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    
    reqIB_AMOUNT = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IB_AMOUNT")), 0, 0, 3000000)
    real_user = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("real_user")), 0, 0, 1)
    
    site = "all" 'REQUEST("JOBSITE")
        
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE"

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing


    pageSize        = 50           
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting_NEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user,0)

    'dfGameSql.debug
	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 5
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
	
%>

<html>
<head>
<title>배팅 리스트</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
function go_delete(form)
{
	var v_cnt = 0;
	var v_data = "";
	
	for( var i=0; i<form.elements.length; i++) 
	{
		var ele = form.elements[i];
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			//if (v_cnt == 0)
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
		
	if (v_cnt == 0) 
	{ 
		alert("삭제할 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("정말 삭제하시겠습니까?")) return;		
	form.action = "Delete.asp?page=<%=page%>";
	form.submit();
}
	
	function SearchSports(ss) {
		document.frm1.action = "List.asp?RS_Sports="+ss;	
		document.frm1.submit();
	}
	
	function SearchLeague(ss,sl) {
		// document.frm1.action = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
		// document.frm1.submit();
		location.href = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
	}

	function goMyBetDetail(idx,pg,tt) {
		goUrl = "Betting_Detail.asp?IB_Idx="+idx+"&page="+pg+"&total="+tt;
		location.href=goUrl;
	}
	function goBatdel(gidx) {
		if (!confirm("정말 취소하시겠습니까?\n\n취소시 해당 배팅에 대한 환불처리가 이루어 집니다.")) return;		
		exeFrame.location.href="Bet_Cancel_Proc.asp?IB_Idx="+gidx;
	}
	
	function goDetail(IB_Idx, gameCnt)
	{
	    var url = "Betting_Detail.asp?IB_Idx="+IB_Idx;
	    dis = document.getElementById("tr"+IB_Idx).style.display == "none" ? "block" : "none" ;
	    document.getElementById("tr"+IB_Idx).style.display = dis ;
	    if(dis == "block")
	    {
	        
	        document.getElementById("iframe"+IB_Idx).style.width = "100%" ;
	        document.getElementById("iframe"+IB_Idx).style.height = (gameCnt*20) + 120 ;
	        document.getElementById("iframe"+IB_Idx).src = url ;
	    }
	}

    function ajaxRequestBet(ib_idx, e)
	{

        var E=window.event;
        var x =  E.clientX + document.body.scrollLeft ;
	    var y =  E.clientY + document.body.scrollTop;
    	
		document.getElementById("aaa").style.left = x ;
		document.getElementById("aaa").style.top = y ;	
		        
		var url = "ajaxBetting_Detail.asp";
		var pars = 'ib_idx=' + ib_idx
		
		var myAjax = new Ajax.Request(
			url, 
			{
				method: 'get', 
				parameters: pars, 
				onComplete: showResponse
			});

	
				
	}

	function showResponse(originalRequest)
	{
	
		document.getElementById("aaa").innerHTML = originalRequest.responseText;
        
	}


</SCRIPT>


</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" id="exeFrame" width="0" height="0"></iframe>
<div id="aaa" style="position:absolute;left:1;top:1;width:500px;"></div>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 게임 관리 &nbsp;&nbsp; ▶  배팅 리스트  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<iframe src="Betting_Money.asp" width="100%" height="50" frameborder="0"></iframe>
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Betting_DetailList.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="iu_nickname" <%if Search = "iu_nickname" then Response.Write "selected"%>>닉네임</option>
		<option value="IB_ID" <%if Search = "IB_ID" then Response.Write "selected"%>>아이디</option>
		<option value="IG_TEAM" <%if Search = "IG_TEAM" then Response.Write "selected"%>>팀명</option>
		<option value="IB_TYPE" <%if Search = "IB_TYPE" then Response.Write "selected"%>>게임구분</option>
		<option value="IB_CNT" <%if Search = "IB_CNT" then Response.Write "selected"%>>폴더수</option>
		<option value="IB_SITE" <%if Search = "IB_SITE" then Response.Write "selected"%>>사이트명</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="3" height="1"></td>
	<td>금액</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="IB_AMOUNT" size="20" maxlength="30" value="<%=reqIB_AMOUNT%>" class="input"></td>	
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>테스트회원포함<input type="checkbox" name="real_user" value="1" <% If real_user = "1" Then %>checked<% End If %> /></td>		
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="엑셀저장" onclick="location.href='Betting_List_Excel.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %></td></tr></form></table>

<table border="1" cellpadding="1" cellspacing="1" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="1"  cellspacing="1" cellpadding="3"  width="100%">
<form name="frm1" method="post">

<tr bgcolor="eeeeee">
	<td width="40" rowspan="2" align="center">NO</td>
    <td width="100" rowspan="2" align="center">경기일자</td>
	<td width="100" rowspan="2" align="center">ID</td>
    <td rowspan="2" align="center">리그</td>
    <td rowspan="2" align="center">홈 vs 원정</td>
    <td colspan="3" width="150" align="center"  class="white bold">배당률</td>
    <td width="50" rowspan="2" align="center"  >배팅내역</td>
    <td width="50" rowspan="2" align="center"  >스코어</td>
	<td width="80" rowspan="2" align="center"  >결과</td>
    <td width="80" rowspan="2" align="center"  >배팅일자</td></tr>
<tr  bgcolor="eeeeee"><!-- <td height="22" align="center"  class="white">승</td>
    <td align="center"  class="white">무</td>
    <td align="center"  class="white">패</td> -->
	<td width="40" height="22" align="center"  class="white">승</td>
	<td width="40" align="center"  class="white">무</td>
	<td width="40" align="center"  class="white">패</td>
</tr>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">현재 등록된 베팅이 없습니다.</td></tr>

<%
	ELSE

	FOR ii = 0 TO dfgameSql.RsCount -1

		IB_Idx		= dfgameSql.Rs(ii,"IB_Idx")
		IB_ID		= dfgameSql.Rs(ii,"IB_ID")
		IB_Type		= dfgameSql.Rs(ii,"IB_Type")
		IB_Num		= dfgameSql.Rs(ii,"IB_Num")
		IG_Idx		= dfgameSql.Rs(ii,"IG_Idx")
		IB_Benefit	= dfgameSql.Rs(ii,"IB_Benefit")
		IB_Amount	= dfgameSql.Rs(ii,"IB_Amount")
		IB_Status	= dfgameSql.Rs(ii,"IB_Status")
		IB_RegDate	= dfgameSql.Rs(ii,"IB_RegDate")
		IB_SITE		= dfgameSql.Rs(ii,"IB_SITE")
		IU_NICKNAME = dfgameSql.Rs(ii,"IU_NICKNAME")
		IBD_CNT		= dfgameSql.Rs(ii,"IBD_CNT")

		
		IF IB_Type = "M" THEN
			arr_IG_Idx = split(IG_Idx, ",")
			arrLen = UBound(arr_IG_Idx)
			GameCnt = arrLen+1
			arr_IB_Num = split(IB_Num, ",")
			arr_IB_Benefit = split(IB_Benefit,",")
		END IF

		IF IB_Type = "S" THEN

			SQLMSG = "SELECT RL_League,IG_Status, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Result, IG_Team1Benefit, IG_score1, IG_score2, IG_team1betting, ig_drawbetting, IG_team2betting, IG_team1bet_cnt, IG_drawbet_cnt, IG_team2bet_cnt, "
			SQLMSG = SQLMSG & " IG_DrawBenefit, IG_Team2Benefit, IG_TYPE FROM INFO_GAME WHERE IG_Idx = '"& IG_Idx &"' "
			SET RS1 = DbCon.Execute(SQLMSG)			
            IF NOT RS1.Eof Then
			    RL_League = rs1("RL_League")
			    IG_Team1 = rs1("IG_Team1")
			    IG_Team2 = rs1("IG_Team2")
			    IG_Status = rs1("IG_Status")
			    IG_Result = rs1("IG_Result")
			    IG_StartTime = rs1("IG_StartTime")
			    IG_Team1Benefit = rs1("IG_Team1Benefit")
			    IG_DrawBenefit = rs1("IG_DrawBenefit")
			    IG_Team2Benefit = rs1("IG_Team2Benefit")
			    IG_Handicap = rs1("IG_Handicap")
			    IG_TYPE = rs1("IG_TYPE")
			    IG_score1 = rs1("IG_score1")
			    IG_score2 = rs1("IG_score2")
			    IG_team1betting = rs1("IG_team1betting")
			    IG_drawbetting = rs1("IG_drawbetting")
			    IG_team2betting = rs1("IG_team2betting")
			    IG_team1bet_cnt = rs1("IG_team1bet_cnt")
			    IG_drawbet_cnt = rs1("IG_drawbet_cnt")
			    IG_team2bet_cnt = rs1("IG_team2bet_cnt")

				SQLMSG = "SELECT IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit FROM INFO_BETTING_DETAIL WHERE IG_Idx = '"& IG_Idx &"' and IB_Idx="& IB_Idx &""
				SET RS2 = DbCon.Execute(SQLMSG)			
			    IG_Team1Benefit = rs2("IG_Team1Benefit")
			    IG_DrawBenefit = rs2("IG_DrawBenefit")
			    IG_Team2Benefit = rs2("IG_Team2Benefit")
			    IG_Handicap = rs2("IG_Handicap")

				If IB_Num = 1 then
				    '// TotalBenefitRate = rs1("IG_Team1Benefit")
				    choice = "<span class='yellow bold'>승</span>"
			    Elseif IB_Num = 0 then
				    '// TotalBenefitRate = rs1("IG_DrawBenefit")
				    choice = "<span class='white bold'>무</span>"
			    Elseif IB_Num = 2 then
				    '//TotalBenefitRate = rs1("IG_Team2Benefit")
				    choice = "<span class='red bold'>패</span>"
			    End if
				
			    TotalBenefit = Cdbl(IB_Benefit) * Cdbl(IB_Amount)
    			
			    if IG_Status = "S" or IG_Status = "E" then
				    ProcFlag = "false"
				    ResultFlag = "false"
			    else							'// F(게임졀과 적용)...이면...
				    ProcFlag = "true"
				    if IG_Status = "C" then
					    ResultFlag = "true"
				    else
					    if Cint(IG_Result) = Cint(IB_Num) then
						    ResultFlag = "true"
					    else
						    ResultFlag = "false"
					    end if
				    end if
			    end if
    			
			    If IG_Status = "C" then
				    DspResult = "<td align='center'><span style='color:gray;font-weight:bold;'>취소</span></td>"
				    bgColor = "White"
			    Else	
				    If ProcFlag = "true" and ResultFlag = "true" then
					    DspResult = "<td align='center'><span style='color:orange;font-weight:bold;'>적중</span></td>"
					    bgColor = "Yellow"
				    Elseif ProcFlag = "true" and ResultFlag = "false" then
					    DspResult = "<td align='center'><span style='color:red;font-weight:bold;'>실패</span></td>"
					    bgColor = "Red"
				    Else
					    bgColor = "gray"
					    DspResult = "<td align='center'><span style='color:blud;font-weight:bold;'>진행중</span></td>"
				    End if
			    End if
			    
			    IF cStr(IG_TYPE) = "0" Then
			        txtIG_TYPE= "<b>승무패</b>"
                ElseIF cStr(IG_TYPE) = "1" Then			        
                    txtIG_TYPE= "<b>핸디캡</b>"
                ElseIF cStr(IG_TYPE) = "2" Then
                    txtIG_TYPE= "<b>오버/언더</b>"
                End IF
    			
			    '// TotalBenefit = Cdbl(TotalBenefitRate) * Cdbl(IB_Amount)
%>

<tr >
	<td rowspan="2" align="center"><%=IB_Idx%></td>
	<td height="20" align="center"><%=IG_StartTime%></td>
	<td height="20" align="center"><%=IB_ID%>(<%=iu_nickname%>)</td>
	
	<td>&nbsp;<%=RL_League%> - [<%= txtIG_TYPE %>] </td>
	<td align="center">
	<%=left(IG_Team1,15)%><font color=red><%=IG_team1betting%>원</font>
	<% if IG_Handicap <> 0 then %>
	(<font color="ff0000"><%=IG_Handicap%></font>)
	<% end if %>
	vs<font color=red><%=IG_drawbetting%>원</font>
	<%=left(IG_Team2,15)%><font color=red><%=IG_team2betting%>원</font>
	</td>
	<td align="center" <% if IG_Status="F" and IG_Result=1 then %> bgcolor="black" <% end if%>><% if IB_Num = 1 then response.write IB_Benefit else response.write IG_Team1Benefit end if %></td>
	<td align="center" <% if IG_Status="F" and IG_Result=0 then %> bgcolor="black" <% end if%>><% if IB_Num = 0 then response.write IB_Benefit else response.write IG_DrawBenefit end if %></td>
	<td align="center" <% if IG_Status="F" and IG_Result=2 then %> bgcolor="black" <% end if%>><% if IB_Num = 2 then response.write IB_Benefit else response.write IG_Team2Benefit end if %></td>

	<td align="center" ><%=choice%></td>
	<%
	IF IG_Status = "F" or IG_Status = "C" then
	%>
	<td align='center'><span style='color:gray;'><%=IG_score1 %>:<%=IG_score2 %></span></td>
	<% else %>
	<td align='center'><span style='color:gray;'>&nbsp</span></td>
	<% end if %>
	<%=DspResult%>
	<td align="center" class="td_game"><%=IB_RegDate%></td>
</tr>
<tr>
	<td height="22" align="center"  class="td_result" bgcolor="grey">배팅금액</td>
	<td align="center" bgcolor="grey"><%=formatnumber(IB_Amount,0)%></td>
	<td align="center" bgcolor="grey">예상배당률</td>
	<td colspan="3" align="center"  class="yellow bold" bgcolor="grey">
	<% If IG_Status = "C" then %>
		<font color=white>--</font>
	<% Else %>
		<%=formatnumber(IB_Benefit,2)%></td>
	<% End if %>
	<td align="center" bgcolor="grey">배당금</td>
	<td align="center" bgcolor="grey">
	<% if IG_Status = "C" then %>
		<font color=white>--</font>
	<% else %>
		<%=formatnumber(TotalBenefit,0)%>
	<% end if %>
	</td>
	<td align="center" bgcolor="grey">
	<%
	  If IG_Status = "S" or IG_Status = "E" then
		response.write "진행중"
	  Elseif IG_Status = "C" then
		response.write "<font color='gray'>게임취소</font>"
	  Elseif IG_Status = "F" then
		response.write "게임종료"
	  end if
	%>
	</td>
</tr>
<%
        End IF
	Else
		TotalBenefitRate = 1
						
		ProcFlag = "true"
		ResultFlag = "true"
						
		StrProc = ""
		StrResult = ""
		
		CancelCnt = 0
		for i=0 to arrLen

			SQLMSG = "SELECT RL_League,IG_Status, CONVERT(VARCHAR, IG_StartTime, 102) + ' ' + CONVERT(VARCHAR(5), IG_StartTime, 114) AS IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Result, IG_Team1Benefit, IG_score1, IG_score2, IG_team1betting, ig_drawbetting, IG_team2betting, IG_team1bet_cnt, IG_drawbet_cnt, IG_team2bet_cnt, "
			SQLMSG = SQLMSG & " IG_DrawBenefit, IG_Team2Benefit, IG_Type FROM INFO_GAME WHERE IG_Idx = '"& arr_IG_Idx(i) &"' "
			SET RS1 = DbCon.Execute(SQLMSG)
            IF NOT Rs1.Eof Then
				RL_League = rs1("RL_League")
				IG_Team1 = rs1("IG_Team1")
				IG_Team2 = rs1("IG_Team2")
				IG_Status = rs1("IG_Status")
				IG_Result = rs1("IG_Result")
				IG_StartTime = rs1("IG_StartTime")
				IG_Team1Benefit = rs1("IG_Team1Benefit")
				IG_DrawBenefit = rs1("IG_DrawBenefit")
				IG_Team2Benefit = rs1("IG_Team2Benefit")
				IG_Handicap = rs1("IG_Handicap")
				IG_Type = rs1("IG_Type")
				IG_score1 = rs1("IG_score1")
			    IG_score2 = rs1("IG_score2")
			    IG_team1betting = rs1("IG_team1betting")
			    IG_drawbetting = rs1("IG_drawbetting")
			    IG_team2betting = rs1("IG_team2betting")
			    IG_team1bet_cnt = rs1("IG_team1bet_cnt")
			    IG_drawbet_cnt = rs1("IG_drawbet_cnt")
			    IG_team2bet_cnt = rs1("IG_team2bet_cnt")

				SQLMSG = "SELECT IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit FROM INFO_BETTING_DETAIL WHERE IG_Idx = '"& arr_IG_Idx(i) &"' and IB_Idx="& IB_Idx &""
				SET RS2 = DbCon.Execute(SQLMSG)			
			    IG_Team1Benefit = rs2("IG_Team1Benefit")
			    IG_DrawBenefit = rs2("IG_DrawBenefit")
			    IG_Team2Benefit = rs2("IG_Team2Benefit")
			    IG_Handicap = rs2("IG_Handicap")

				If arr_IB_Num(i) = 1 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:orange;font-weight:bold;'>승</span>"
				Elseif arr_IB_Num(i) = 0 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:gray;font-weight:bold;'>무</span>"
				Elseif arr_IB_Num(i) = 2 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:red;font-weight:bold;'>패</span>"
				End if
								
				'// 게임이 아직 끝나지 않았으면...
				if IG_Status = "S" or IG_Status = "E" then
					ProcFlag = "false"
				else
					ProcFlag = "true"
					
					if IG_Status = "C" then
						ResultFlag = "true"
					else
						'// 게임종료...적중실패...
						if Cint(IG_Result) = Cint(arr_IB_Num(i)) then
							ResultFlag = "true"
						else
							ResultFlag = "false"
						end if
					end if
				end if
				
				if ProcFlag = "true" and ResultFlag = "true" then
					bgColor = "yellow"
					bgShape = "0"
				Elseif ProcFlag = "true" and ResultFlag = "false" then
					bgColor = "red"
					bgShape = "X"
				else
					bgColor = "gray"
					bgShape = "△"
				end if
				
				StrProc = StrProc & "," & ProcFlag
				
				If ProcFlag = "true" and ResultFlag = "true" then
					If IG_Status = "C" then
						DspResult = "<td align='center'><span style='color:gray;font-weight:bold;'>취소</span></td>"
					else
						DspResult = "<td align='center'><span style='color:orange;font-weight:bold;'>적중</span></td>"
					end if
				Elseif ProcFlag = "true" and ResultFlag = "false" then
					DspResult = "<td align='center'><span style='color:red;font-weight:bold;'>실패</span></td>"
				Else
					DspResult = "<td align='center'><span style='color:blue;font-weight:bold;'>진행중</span></td>"
				End if
				
				
			    IF cStr(IG_TYPE) = "0" Then
			        txtIG_TYPE= "<b>승무패</b>"
                ElseIF cStr(IG_TYPE) = "1" Then			        
                    txtIG_TYPE= "<b>핸디캡</b>"
                ElseIF cStr(IG_TYPE) = "2" Then
                    txtIG_TYPE= "<b>오버/언더</b>"
                End IF				
%>

			  
			  <tr>
				<% if i = 0 then %>
								<td rowspan="<%=arrLen+2%>" align="center" ><%=IB_Idx%></td>
							<% end if %>
				<td height="20" align="center" class="td_game"><%=IG_StartTime%></td>
				<% if i = 0 then %>
				<td rowspan="<%=arrLen+2%>" align="center">
				<%=IB_ID%>(<%=iu_nickname%>)				
				<% end if %>
				<td class="td_game"><%=RL_League%>[<%= txtIG_TYPE %>]</td>
				<td align="center" class="td_game bold">
								<%=left(IG_Team1,15)%><font color=red><%=IG_team1betting%>원</font>
								<% if IG_Handicap <> 0 then %>
								(<font color="ff0000"><%=IG_Handicap%></font>)
								<% end if %>
								vs<font color=red><%=IG_drawbetting%>원</font>
								<%=left(IG_Team2,15)%><font color=red><%=IG_team2betting%>원</font>
								</td>
				<td align="center"><% if arr_IB_Num(i) = 1 then response.write formatnumber(arr_IB_Benefit(i),2) else response.write formatnumber(IG_Team1Benefit,2) end if %></td>
				<td align="center"><% if arr_IB_Num(i) = 0 then response.write formatnumber(arr_IB_Benefit(i),2) else response.write formatnumber(IG_DrawBenefit,2) end if %></td>
				<td align="center"><% if arr_IB_Num(i) = 2 then response.write formatnumber(arr_IB_Benefit(i),2) else response.write formatnumber(IG_Team2Benefit,2) end if %></td>
				<td align="center" ><%=choice%></td>
				<%
				IF IG_Status = "F" or IG_Status = "C" then
				%>
				<td align='center'><span style='color:gray;'><%=IG_score1 %>:<%=IG_score2 %></span></td>
				<% else %>
				<td align='center'><span style='color:gray;'>&nbsp</span></td>
				<% end if %>
				<%=DspResult%>
			  <% if i = 0 then %>
				<td rowspan="<%=arrLen+1%>" align="center" class="td_game">
				<%
					ibregdate = split(IB_RegDate, " ")
				%>	
					<%=ibregdate(0)%><br><%=ibregdate(1)%>
				</td>
			  <% end if %>
			  </tr>
			  
<%
			    if IG_Status <> "C" then
				    TotalBenefitRate = Cdbl(TotalBenefitRate) * Cdbl(BenefitRate)
			    else
				    CancelCnt = CancelCnt + 1
			    end if
    			
            End IF			
		next
			TotalBenefit = int(TotalBenefitRate*100)/100 * Cdbl(IB_Amount)
		
		'// 최종 승패결과...
		find_proc = Instr(StrProc,"false")
		'// find_result = Instr(StrResult,"false")
%>
<tr>
	<td height="22" align="center"  class="td_result" bgcolor="grey">배팅금액</td>
	<td align="center"  class="yellow bold" bgcolor="grey"><%=formatnumber(IB_Amount,0)%></td>
	<td align="center"  class="td_result" bgcolor="grey">예상배당률</td>
	<td colspan="3" align="center"  class="yellow bold" bgcolor="grey">
	<% if Cint(CancelCnt) = Cint(arrLen)+1 then %>
		<font color=white>--</font>
	<% else %>
		<%=numdel(TotalBenefitRate)%>
	<% end if %>
	</td>
	<td align="center"  class="td_result" bgcolor="grey">배당금</td>
	<td align="center"  class="yellow bold" bgcolor="grey">
	<% if Cint(CancelCnt) = Cint(arrLen)+1 then %>
		<font style='color:#ffffff;'>--</font>
	<% else %>
		<%=formatnumber(TotalBenefit,0)%>
	<% end if %>
	</td>
	<td align="center"  class="yellow" bgcolor="grey">
	<%
		If Cint(CancelCnt) = Cint(arrLen)+1 then
			response.write "<font color=white>게임취소</font>"
		else
			If find_proc > 0 then
				response.write "진행중"
			Else
				response.write "게임종료"
			end if
		end if
	%>
	</td>
	<td align="center"  class="yellow" bgcolor="grey">
	<%
		If Cint(CancelCnt) = Cint(arrLen)+1 then
			response.write "<font color=white>게임취소</font>"
		else
			If find_proc > 0 then
				response.write "진행중"
			Else
				response.write "게임종료"
			end if
		end if
	%>
	</td>
</tr>
<%
	End if
%>
<tr id="tr<%= IB_Idx %>" style="display:none;" >
	<td colspan="13" bgcolor="ffffff">
		<iframe id="iframe<%= IB_Idx %>" frameborder="0" ></iframe>
	</td>
</tr>
	<%  
		Next 
	%>
		
	<% END IF %>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

</form>

</body>
</html>

