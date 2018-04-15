<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
	FSql = "select * from info_game where ig_status = 'E' and ig_result > 0"
	SET FRs = Server.CreateObject("ADODB.Recordset")
	FRs.Open FSql, DbCon, 1
	
	If Not FRs.eof Then
		for  FR = 1 To FRs.RecordCount
		ESql = "update info_game set ig_status = 'F' where ig_idx ="&FRs("IG_IDX")
		DbCon.Execute (ESql)
		FRs.movenext
		next
	End If 

	FRs.Close
	Set FRs = Nothing 
%>
<%
	SETSIZE = 20
	PGSIZE = 30

	IF REQUEST("PAGE") = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(REQUEST("PAGE")) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END IF


	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " Info_Game Where 1=1 "

	sStartDate = REQUEST("sStartDate")&" 00:00:00"
	sEndDate = REQUEST("sEndDate")&" 23:59:59"
	IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" THEN
		SQLR = SQLR &" And IG_STARTTIME Between '"&sStartDate&"' And '"&sEndDate&"'"
	END If

	SRS_Sports = REQUEST("SRS_Sports")
	IF SRS_Sports <> "" THEN
		SQLR = SQLR & " AND RL_SPORTS = '"& SRS_Sports &"' "
	END IF

	SRL_League = REQUEST("SRL_League")
	IF SRL_League <> "" THEN
		SQLR = SQLR & " AND RL_LEAGUE = '"& SRL_League &"' "
	END IF

	SFlag = REQUEST("SFlag")
	IF SFlag = "" OR SFlag = "All" THEN

	ELSEIF Flag <> "All" THEN
		SQLR = SQLR & " AND IG_STATUS = '"& SFlag &"' "
	END IF

	box01 = request("box01")
	box02 = request("box02")
	box03 = request("box03")
	box04 = request("box04")
	box05 = request("box05")
	box06 = request("box06")
	box07 = request("box07")
	box08 = request("box08")
	box09 = request("box09")
	box10 = request("box10")
	box11 = request("box11")
	box12 = request("box12")
	box13 = request("box13")

	
	
	If box02 <> "" Then sqlr = sqlr & " And IG_STATUS = 'R' "
	If box03 <> "" Then sqlr = sqlr & " And IG_STATUS = 'S' "
	If box04 <> "" Then sqlr = sqlr & " And IG_STATUS = 'E' "
	If box05 <> "" Then sqlr = sqlr & " And IG_STATUS = 'F' "
	If box06 <> "" Then sqlr = sqlr & " And IG_STATUS = 'C' "
	If box07 <> "" Then sqlr = sqlr & " And IG_RESULT = 1 "
	If box08 <> "" Then sqlr = sqlr & " And IG_RESULT = 0 "
	If box09 <> "" Then sqlr = sqlr & " And IG_RESULT = 2 "
	If box11 <> "" Then sqlr = sqlr & " And IG_TYPE = 0 "
	If box12 <> "" Then sqlr = sqlr & " And IG_TYPE = 2 "
	If box13 <> "" Then sqlr = sqlr & " And IG_TYPE = 1 "

	Search = REQUEST("Search")
	Find = Trim(REQUEST("Find"))
	Search3 = Trim(REQUEST("Search3"))
	If find <> "" then
	If isnumeric(Find) then
	IF Search <> "" AND Find <> "" And Search3 <> "" Then
		If Search3 = "aaa" Then 
			SQLR = SQLR &" And "& Search &" = "&Find&""
		ElseIf Search3 = "bbb" Then
			SQLR = SQLR &" And "& Search &" >= "&Find&""
		ElseIf Search3 = "ccc" Then
			SQLR = SQLR &" And "& Search &" <= "&Find&""
		End If 
	END If
	Else
	response.write "<script>alert('숫자값을 입력해 주세요.');history.back(-1);</script>"
	End If 
	End If 
	
	Search4 = Trim(REQUEST("Search4"))
	Find2 = Trim(REQUEST("Find2"))

	If Search4 <> "" And find2 <> "" Then
		If Search4 = "LEAGUE" Then
			SQLR = SQLR &" And RL_LEAGUE LIKE '%"& Find2 & "%' "			
		ElseIf Search4 = "TEAM" Then
			SQLR = SQLR &" And IG_TEAM1 LIKE '%"& Find2 & "%' OR IG_TEAM2 LIKE '%"& Find2 & "%' "
		End If 

	End If 

	sameval = request("sameval")
	bigval = request("bigval")
	smallval = request("smallval")

	GSITE = REQUEST("GSITE")
	IF GSITE = "All" OR GSITE = "" THEN
	ELSE
		SQLR = SQLR & " AND (IG_SITE = 'All' OR IG_SITE = '"& GSITE &"') "
	END IF
	

	SQLLIST = "SELECT COUNT(*) AS TN From "& SQLR &""

	'response.write sqllist
	SET RSLIST = DbCon.Execute(SQLLIST)
	TN = CDbl(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	

	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END IF


	START_ROWNUM	=	CINT(CINT(CINT(PGSIZE) * CINT(CINT(PAGE) -1)) + 1)
	END_ROWNUM		=	CINT(CINT(PGSIZE) * CINT(PAGE))


	strSQL = "SELECT TOP " & PGSIZE & " IG_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, IG_STARTTIME, IG_TEAM1, IG_TEAM2, IG_HANDICAP, IG_TEAM1BENEFIT, IG_DRAWBENEFIT, IG_TEAM2BENEFIT, IG_TEAM1BETTING, IG_DRAWBETTING, IG_TEAM2BETTING, IG_SCORE1, IG_SCORE2, IG_RESULT, IG_STATUS, IG_TYPE, IG_VSPOINT, IG_MEMO, IG_SITE, IG_LIMIT FROM "& SQLR &" AND IG_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " IG_IDX  FROM "& SQLR &" ORDER BY IG_STARTTIME Desc, IG_TEAM1 ASC) ORDER BY IG_STARTTIME Desc, IG_TEAM1 ASC"

	'response.write strSQL
	DbRec.Open strSQL, DbCon


	IF NOT DbRec.EOF THEN
		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END IF
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>무제 문서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="styles/style.css" />
<script>

	function go_roll(val){
			if (!confirm("정말 변경하시겠습니까?")) return;	
		location.href="gameListNew_Proc.asp?val="+val;
	}

function overMouse(obj){
	
	obj.bgColor = '#b8e1ff';	
}

function outMouse(obj){
	
	obj.bgColor = '#ffffff';
	
}
</script>
<style>
.tdbg {

	background-color: #b8e1ff;
}
A:link {
	color:#ffffff;
	;
	text-decoration:none;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:visited {
	color:#ffffff;
	;
	text-decoration:none;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:active {
	color:#ffffff;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:hover {
	color:#ffffff;
	font-family:verdana, "dotum";
	font-size:11px;
	text-decoration: underline
}
</style>
<script src="/Sc/Base.js"></script>
</head>
<!-- #include virtual="/Inc_Month.asp"-->
<body >
<form name="frm" method="post">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list0" style=table-layout:fixed>
    <tr><td align="left" width="40%"><strong>&nbsp;&nbsp;실시간 배당율</strong></td></tr>
	<tr><td><img src="blank.gif" border="0" width="5" height="5"></td></tr>
	<tr>
		<td><table><tr>

		</tr></table></td>
	</tr>
	<tr>
      <td > 
		<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" style=table-layout:fixed><tr><td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
		  <tr height="25">
		    <td width="70" align="right"><font color="#000000" style="font-size:12px;" ><strong>조건 : </strong>&nbsp;&nbsp;</font></td>
		    <td width="1005" colspan="3">
				<select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
					<option value="IG_TEAM1BETTING" <%if Search = "IG_TEAM1BETTING" then Response.Write "selected"%>>배팅금(승)</option>
					<option value="IG_DRAWBETTING" <%if Search = "IG_DRAWBETTING" then Response.Write "selected"%>>배팅금(무)</option>
					<option value="IG_TEAM2BETTING" <%if Search = "IG_TEAM2BETTING" then Response.Write "selected"%>>배팅금(패)</option>
				</select>
				<select name="Search3" style="width:70px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
					<option value="aaa" <%if Search3 = "aaa" then Response.Write "selected"%>>=</option>
					<option value="bbb" <%if Search3 = "bbb" then Response.Write "selected"%>>>=</option>
					<option value="ccc" <%if Search3 = "ccc" then Response.Write "selected"%>><=</option>
				</select>
				<input type="text" name="Find" size="10" maxlength="30" value="<%=Find%>" class="input">		
				
				<select name="Search4" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
					<option value="LEAGUE" <%if Search4 = "LEAGUE" then Response.Write "selected"%>>리그</option>
					<option value="TEAM" <%if Search4 = "TEAM" then Response.Write "selected"%>>팀명</option>
				</select>
				<input type="text" name="Find2" size="15" maxlength="30" value="<%=Find2%>" class="input">	

			</td>
		    
		  </tr>
		  <tr height="25">
		    <td width="70" align="right"><font color="#000000" style="font-size:12px;" ><strong>기간 : </strong>&nbsp;&nbsp;</font></td>
		    <td width="220">
			<font color="#000000" style="font-size:12px;" > 
			<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:135;display:none;position: absolute; z-index: 99"></div>
			<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
			<img src="blank.gif" border="0" width="1" height="1">
			~<img src="blank.gif" border="0" width="1" height="1">
			<input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input"></font>			
			</td>
		    <td width="720">
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td  align="right" width="50"><font color="#000000" style="font-size:12px;" ><strong>종류 :</strong>&nbsp;&nbsp;</font></td>
						<td width="225"><font color="#000000" style="font-size:12px;" >
							<input type="checkbox" name="box11" value="0" <%If box11 <> "" Then response.write "checked"%>> 프로토 
						    <input type="checkbox" name="box12" value="2" <%If box12 <> "" Then response.write "checked"%>> 오버언더
							<input type="checkbox" name="box13" value="1" <%If box13 <> "" Then response.write "checked"%>> 핸디캡
						  </td>
						<td align="right" width="50"><font color="#000000" style="font-size:12px;" ><strong>상태 :</strong>&nbsp;&nbsp;</font></td>
						<td width="260"><font color="#000000" style="font-size:12px;" >
						       <input type="checkbox" name="box02" value="R" <%If box02 <> "" Then response.write "checked"%>>대기 
							   <input type="checkbox" name="box03" value="S" <%If box03 <> "" Then response.write "checked"%>>배팅
							   <input type="checkbox" name="box04" value="E" <%If box04 <> "" Then response.write "checked"%>>종료
							   <input type="checkbox" name="box05" value="F" <%If box05 <> "" Then response.write "checked"%>>마감
							   <input type="checkbox" name="box06" value="C" <%If box06 <> "" Then response.write "checked"%>>취소
							   </font></td>
						<td align="right" width="50"><font color="#000000" style="font-size:12px;" ><strong>결과 :</strong>&nbsp;&nbsp;</font></td>
						<td width="125"><font color="#000000" style="font-size:12px;" >
							   <input type="checkbox" name="box07" value="1" <%If box07 <> "" Then response.write "checked"%>>승
							   <input type="checkbox" name="box08" value="0" <%If box08 <> "" Then response.write "checked"%>>무
							   <input type="checkbox" name="box09" value="2" <%If box09 <> "" Then response.write "checked"%>>패
							   </font>
						</td>					
					</tr>
				</table>
			</td>
		    <td width="65"><input name="Submit" type="submit" value="검색"></td>
		  </tr>
		</table>	
		</td></tr></table>
	</td>
    </tr>
	<tr><td><img src="blank.gif" border="0" width="5" height="5"></td></tr>
    <tr> 
      <td ><table width="" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" >
		  <tr align="center" bgcolor="#5d7b9e" height="25"> 
            <td width="40" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>번호</strong></font></td>
            <td width="110" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>경기일시</strong></font></td>
            <td width="35" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>종목</strong></font></td>
            <td width="110" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>리그</strong></font></td>
            <td width="130" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>홈팀</strong></font></td>
            <td width="130" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>원정팀</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>경기방식</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>배팅금(승)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>건수(승)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>배팅금(무)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>건수(무)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>배팅금(패)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>건수(패)</strong></font></td>
            <td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>상태</strong></font></td>
						<td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>배팅제한</strong></font></td>
						<td width="60" align="center"><font color="#FFFFFF" style="font-size:12px;"><strong>마감전</br>으로변경</strong></font></td>
          </tr>
		  
<%	IF TN = 0 THEN	%>

<tr><td align="center" colspan="14" height="25">현재 등록된 게임이 없습니다.</td></tr>
<%
	ELSE

	FOR i = 1 TO PGSIZE
		IF DbRec.EOF THEN
			EXIT FOR
		END IF

		IG_IDX			= DbRec(0)
		RL_SPORTS_i		= DbRec(1)
		RL_LEAGUE		= DbRec(2)
		RL_IMAGE		= DbRec(3)
		RL_IMAGE		= "<img src='/UpFile/League/" & RL_IMAGE & "' width='20' height='14' style='border:1px solid;' align='absmiddle'>"
		IG_STARTTIME	= DbRec(4)
		IG_TEAM1		= DbRec(5)
		IG_TEAM2		= DbRec(6)
		IG_HANDICAP		= CDbl(DbRec(7))
		IG_TEAM1BENEFIT = DbRec(8)
		IG_DRAWBENEFIT	= DbRec(9)
		IG_TEAM2BENEFIT = DbRec(10)
		IG_TEAM1BETTING = DbRec(11)
		IG_DRAWBETTING	= DbRec(12)
		IG_TEAM2BETTING	= DbRec(13)
		IG_SCORE1		= DbRec(14)
		IG_SCORE2		= DbRec(15)
		IG_RESULT		= Trim(DbRec(16))
		IG_STATUS		= DbRec(17)
		IG_TYPE			= DbRec(18)
		IG_VSPOINT		= DbRec(19)
		IG_MEMO			= DbRec(20)
		IG_SITE			= DbRec(21)
		IG_LIMIT		= DbRec(22)

		IF IG_RESULT = "0" THEN
			GameResult = "무"
		ELSEIF IG_RESULT = "1" THEN
			GameResult = "홈팀승"
		ELSEIF IG_RESULT = "2" THEN
			GameResult = "원정팀승"
		END IF	
		
		If ig_type = "0" Then
			ig_type = "프로토"
		ElseIf ig_type = "1" Then
			ig_type = "핸디캡"
		ElseIf ig_type="2" Then
			ig_type = "오버언더"
		End If 
%>
<%
	If i Mod 2 = 0 Then 
		color = "#d3d3d3"
	Else 
		color = ""
	End If 
%>
<%
	sql_bet = "select ib_idx, ig_idx, ib_num from info_betting where ig_idx like '%"&IG_IDX&"%' "
	SET betRs=Server.CreateObject("ADODB.Recordset") 
	betRs.Open sql_bet, DbCon

	r0 = 0
	r1 = 0
	r2 = 0
	IF NOT betRs.EOF Then
	
		Do While Not betRs.EOF
					
			ig_idx2 = betRs("ig_idx")
			ib_num = betRs("ib_num")
			ig_idx_s = Split(ig_idx2,",")
			ib_num_s = Split(ib_num,",")
			
			For o=0 To ubound(ig_idx_s)
				If Cdbl(ig_idx_s(o)) = Cdbl(ig_idx) Then
					ig_r = ig_idx_s(o)
					ib_r = ib_num_s(o)
					If ib_r = 0 Then
						r0 = r0 + 1
					ElseIf ib_r = 1 Then
						r1 = r1 + 1
					ElseIf ib_r = 2 Then
						r2 = r2 + 1
					End If 
				End If 
			Next 
		betRs.MoveNext
		loop 
	else	
		betcount = 0
	END IF

%>
          <tr align="center" height="25" name="tr01_<%=IG_IDX%>" id="tr01_<%=IG_IDX%>" onclick="detail_i('<%=IG_IDX%>'); " onMouseOver="overMouse(this)" onMouseOut="outMouse(this)" > 
            <td width="40" align="center"><font color="#000000" style="font-size:12px;" ><%=IG_IDX%></font></td>
            <td width="110" align="center"><font color="#000000" style="font-size:12px;"><%=IG_StartTime%></font></td>
            <td width="35" align="center"><font color="#000000" style="font-size:12px;"><%=RL_SPORTS_i%></font></td>
            <td width="110" align="center"><font color="#000000" style="font-size:12px;"><%=RL_LEAGUE%></font></td>
            <td width="130" align="center"><font color="#000000" style="font-size:12px;"><%=IG_TEAM1%></font></td>
            <td width="130" align="center"><font color="#000000" style="font-size:12px;"><%=IG_TEAM2%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=ig_type%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=IG_TEAM1BETTING%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=r1%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=IG_DRAWBETTING%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=r0%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=IG_TEAM2BETTING%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=r2%></font></td>
            <td width="60" align="center"><font color="#000000" style="font-size:12px;">
	<% IF IG_STATUS = "R" THEN %>
		대기
	<% END IF %>
	<% IF IG_STATUS = "S" THEN %>
		배팅
	<% END IF %>
	<% IF IG_STATUS = "E" THEN %>
		종료
	<% END IF %>
	<% IF IG_STATUS = "F" THEN %>
		<%=GameResult%>	
	<% END IF %>
	<% IF IG_STATUS = "C" THEN %>
		게임취소
	<% END IF %>			
			</font></td>
			<td width="60" align="center"><font color="#000000" style="font-size:12px;"><%=IG_LIMIT%></font></td>
			<td width="60" align="center"><font color="#000000" style="font-size:12px;"><input type="button" name="rollback" onclick="go_roll('<%=IG_IDX%>');" value="변경"></td>
          </tr>
	<%  NN = NN - 1 
		DbRec.MoveNext
		Next %>
		
	<% END IF %>

        </table></td>
		
    </tr>
	<tr><td>
	<iframe name="bet_detail" id="bet_detail" src="gameListDe.asp" marginwidth="0" marginheight="0" frameborder="0" scrolling=no width="100%" ></iframe>
	</td></tr>
<script>
	function SaveCookie(name, value, expire) {
		var eDate = new Date();
		eDate.setDate(eDate.getDate() + expire);
		document.cookie = name + "=" + value + "; expires=" +  eDate.toGMTString()+ "; path=/";
	}
	function GetCookie2( name ) {
		var nameOfCookie = name + "=";
		var x = 0;
		while ( x <= document.cookie.length ){
			var y = (x+nameOfCookie.length);
			if ( document.cookie.substring( x, y ) == nameOfCookie ) {
				if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
					endOfCookie = document.cookie.length;
					return unescape( document.cookie.substring( y, endOfCookie ) );
				}

				x = document.cookie.indexOf( " ", x ) + 1;

				if ( x == 0 )

				break;

			}

		return "";
	
	}

	function detail_i(num) {
		document.getElementById("bet_detail").src = "gameListDe.asp?viewidx="+num;
		var tdval = "tr01_"+num;
		var valold = "";
		valold = GetCookie2('td01');
		SaveCookie("td01", tdval, 300);
		if (valold != "" && valold != null){
		document.getElementById(valold).className = "";
		}
		document.getElementById(tdval).className = "tdbg";
	}
	SaveCookie("td01", "", 300);
</script>
  </table>
  <%	IF TN > 0 THEN	%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><table border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
		
		<%	IF STARTPAGE = 1 THEN
				Response.Write "<td valign=bottom><font color='#000000' style='font-size:12px;'>[이전 20개]</font><img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			ELSEIF STARTPAGE > SETSIZE THEN
				Response.Write "<td valign=bottom><a href=gameListNew.asp?page="&STARTPAGE-SETSIZE&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&box01="&box01&"&box02="&box02&"&box03="&box03&"&box04="&box04&"&box05="&box05&"&box06="&box06&"&box07="&box07&"&box08="&box08&"&box09="&box09&"&box10="&box10&"&box11="&box11&"&box12="&box12&"&box13="&box13&"&Search="& Search&"&Find="&Find&"&Search3="&Search3&"&Search4="&Search4&"&Find2="&Find2&"><font color='#000000' style='font-size:12px;'>[이전 20개]</font></a><img src=../images/sub/blank.gif border=0 width=5 height=1></td>"
			END IF %>

			<td valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0" height="20"><tr>
			<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1
		
				IF i > PGCOUNT THEN
					EXIT FOR
				END IF
	
			IF PAGE = i THEN
				Response.Write "<td width=20 bgcolor=#b8e1ff valign=bottom align=center><font color=#ffffff style='font-size:12px;'>"&i&"</font></td>"
			ELSE
				Response.Write "<td width=20 align=center valign=bottom><a name='123' href=gameListNew.asp?page="&i&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&box01="&box01&"&box02="&box02&"&box03="&box03&"&box04="&box04&"&box05="&box05&"&box06="&box06&"&box07="&box07&"&box08="&box08&"&box09="&box09&"&box10="&box10&"&box11="&box11&"&box12="&box12&"&box13="&box13&"&Search="& Search&"&Find="&Find&"&Search3="&Search3&"&Search4="&Search4&"&Find2="&Find2&"><font color='#000000' style='font-size:12px;'>"&i&"</font></a></td>"
			END IF
			
			NEXT %></tr></table></td>

		<%	IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1><font color='#000000' style='font-size:12px;'>[다음 20개]</font></td>"
			ELSEIF i > PGCOUNT THEN
				Response.write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1><font color='#000000' style='font-size:12px;'>[다음 20개]</font></td>"
			ELSE
				Response.Write "<td valign=bottom><img src=../images/sub/blank.gif border=0 width=5 height=1><a href=gameListNew.asp?page="&STARTPAGE+SETSIZE&"&SRS_Sports="&SRS_Sports&"&SRL_League="&SRL_League&"&SFlag="&SFlag&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&box01="&box01&"&box02="&box02&"&box03="&box03&"&box04="&box04&"&box05="&box05&"&box06="&box06&"&box07="&box07&"&box08="&box08&"&box09="&box09&"&box10="&box10&"&box11="&box11&"&box12="&box12&"&box13="&box13&"&Search="& Search&"&Find="&Find&"&Search3="&Search3&"&Search4="&Search4&"&Find2="&Find2&"><font color='#000000' style='font-size:12px;'>[다음 20개]</font></a></td>"
			END IF %></tr>
		<tr><td colspan="3" ><img src="../images/sub/blank.gif" border="0" width="1" height="10"></td></tr></table></tr></td></table>
<%	END IF	%>
</form>
</body>
</html>



<%
	betRs.Close
	Set betRs=Nothing
	
	DbRec.Close
	Set DbRec=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>