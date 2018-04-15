<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IB_IDX		= REQUEST("IB_IDX")
	PAGE		= REQUEST("Page")
	sStartDate	= REQUEST("sStartDate")
	sEndDate	= REQUEST("sEndDate")
	Search		= REQUEST("Search")
	Find		= REQUEST("Find")
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<!-- <script src="/js/Base.js"></script> -->

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
	form.action = "Delete.asp?page=<%=PAGE%>";
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
</SCRIPT>
<script>
	function goMyBetDetail(idx,pg,tt) {
		goUrl = "Betting_Detail.asp?IB_Idx="+idx+"&page="+pg+"&total="+tt;
		location.href=goUrl;
	}

function BetList(URL) 
{
	window.open(URL, 'BetList', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=500,height=500'); 
}
</script>

<!--마우스 우클릭 막기-->
<script src="/Sc/Base.js"></script>


</head>

<%
		SQLMSG = "SELECT IB_Type,IG_Idx,IB_Num,IB_Benefit,IB_Amount,CONVERT(VARCHAR, IB_RegDate, 102) + ' ' + CONVERT(VARCHAR(5), IB_RegDate, 114) AS IB_RegDate,IB_ID,IB_SITE FROM INFO_BETTING WHERE IB_Idx="& IB_Idx &""

		SET RS = DbCon.Execute(SQLMSG)

		IB_Type = rs("IB_Type")
		IG_Idx  =rs("IG_Idx")
		IB_Num = rs("IB_Num")
		IB_Benefit = rs("IB_Benefit")
		IB_Amount = rs("IB_Amount")
		IB_RegDate = rs("IB_RegDate")
		IB_ID = rs("IB_ID")
		IB_SITE = rs("IB_SITE")

%>

<body topmargin="25" marginheight="25">

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 배팅 상세 - [ 아이디 : <%=IB_ID%> / 사이트명 : <%=IB_SITE%> ]</font></b></td></tr></table>

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td width="40" rowspan="2" align="center">NO</td>
    <td width="100" rowspan="2" align="center">경기일자</td>
    <td rowspan="2" align="center">리그</td>
    <td rowspan="2" align="center">홈 vs 원정</td>
    <td colspan="3" width="150" align="center"  class="white bold">배당률</td>
    <td width="50" rowspan="2" align="center"  >배팅내역</td>
    <td width="50" rowspan="2" align="center"  >스코어</td>
	<td width="80" rowspan="2" align="center"  >결과</td>
    <td width="80" rowspan="2" align="center"  >배팅일자</td></tr>
<tr><!-- <td height="22" align="center"  class="white">승</td>
    <td align="center"  class="white">무</td>
    <td align="center"  class="white">패</td> -->
	<td width="40" height="22" align="center"  class="white">승</td>
	<td width="40" align="center"  class="white">무</td>
	<td width="40" align="center"  class="white">패</td></tr>

	<%
		IF IB_Type = "M" THEN
			arr_IG_Idx = split(IG_Idx, ",")
			arrLen = UBound(arr_IG_Idx)
			GameCnt = arrLen+1
			arr_IB_Num = split(IB_Num, ",")
			arr_IB_Benefit = split(IB_Benefit,",")
		END IF

		IF IB_Type = "S" THEN

			SQLMSG = "SELECT RL_League,IG_Status, IG_StartTime, IG_Team1, IG_Team2, IG_Result, IG_score1, IG_score2, IG_team1betting, ig_drawbetting, IG_team2betting, IG_team1bet_cnt, IG_drawbet_cnt, IG_team2bet_cnt, "
			SQLMSG = SQLMSG & "  IG_TYPE FROM INFO_GAME WHERE IG_Idx = '"& IG_Idx &"' "
			SET RS1 = DbCon.Execute(SQLMSG)			
            IF NOT RS1.Eof Then
			    RL_League = rs1("RL_League")
			    IG_Team1 = rs1("IG_Team1")
			    IG_Team2 = rs1("IG_Team2")
			    IG_Status = rs1("IG_Status")
			    IG_Result = rs1("IG_Result")
			    IG_StartTime = rs1("IG_StartTime")
			    IG_TYPE = rs1("IG_TYPE")
			    IG_score1 = rs1("IG_score1")
			    IG_score2 = rs1("IG_score2")
			    IG_team1betting = rs1("IG_team1betting")
			    IG_drawbetting = rs1("IG_drawbetting")
			    IG_team2betting = rs1("IG_team2betting")
			    IG_team1bet_cnt = rs1("IG_team1bet_cnt")
			    IG_drawbet_cnt = rs1("IG_drawbet_cnt")
			    IG_team2bet_cnt = rs1("IG_team2bet_cnt")

				SQLMSG = "SELECT IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IBD_Result, IBD_Result_benefit FROM INFO_BETTING_DETAIL WHERE IG_Idx = '"& IG_Idx &"' and IB_Idx="& IB_Idx &""
				SET RS2 = DbCon.Execute(SQLMSG)			
			    IG_Team1Benefit = rs2("IG_Team1Benefit")
			    IG_DrawBenefit = rs2("IG_DrawBenefit")
			    IG_Team2Benefit = rs2("IG_Team2Benefit")
			    IG_Handicap = rs2("IG_Handicap")
				IBD_Result = rs2("IBD_Result")
				IBD_Result_benefit = rs2("IBD_Result_benefit")
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
    			
			    If IBD_Result = 3 then
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

			  <tr>
				<td rowspan="2" align="center">1</td>
				<td height="20" align="center"><%=IG_StartTime%></td>
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
				<% if IBD_Result = 0 then %>
				<td align='center' bgcolor='grey'><span style='color:red;'>실패</span></td>
				<% elseif IBD_Result = 1 then %>
					<% if IBD_Result_benefit = 1 then %>
					<td align='center' bgcolor='grey'><span style='color:white;'>적중특례</span></td>
					<% else %>
					<td align='center' bgcolor='grey'><span style='color:yellow;'>적중</span></td>
					<% end if %>
				<% elseif IBD_Result = 2 then %>
				<td align='center' bgcolor='grey'><span style='color:white;'>경기취소</span></td>
				<% elseif IBD_Result = 3 then %>
				<td align='center' bgcolor='grey'><span style='color:white;'>적중특례</span></td>
				<% else %>
				<td align='center' bgcolor='grey'><span style='color:blue;'>진행중</span></td>
				<% end if %>
				<td align="center" class="td_game"><%=IB_RegDate%></td>
			  </tr>
			  <tr>
				<td height="22" align="center"  class="td_result">배팅금액</td>
				<td align="center"><%=formatnumber(IB_Amount,0)%></td>
				<td align="center">예상배당률</td>
				<td colspan="3" align="center"  class="yellow bold">
				<% If IG_Status = "C" then %>
					<font color=white>--</font>
				<% Else %>
					<%=formatnumber(IB_Benefit,2)%></td>
				<% End if %>
				<td align="center">배당금</td>
				<td align="center">
				<% if IG_Status = "C" then %>
					<font color=white>--</font>
				<% else %>
					<%=formatnumber(TotalBenefit,0)%>
				<% end if %>
				</td>
				<td align="center">
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

			SQLMSG = "SELECT RL_League,IG_Status, CONVERT(VARCHAR, IG_StartTime, 102) + ' ' + CONVERT(VARCHAR(5), IG_StartTime, 114) AS IG_StartTime, IG_Team1, IG_Team2, IG_Result, IG_score1, IG_score2, IG_team1betting, ig_drawbetting, IG_team2betting, IG_team1bet_cnt, IG_drawbet_cnt, IG_team2bet_cnt, "
			SQLMSG = SQLMSG & "   IG_Type FROM INFO_GAME WHERE IG_Idx = '"& arr_IG_Idx(i) &"' "
			SET RS1 = DbCon.Execute(SQLMSG)
            IF NOT Rs1.Eof Then
				RL_League = rs1("RL_League")
				IG_Team1 = rs1("IG_Team1")
				IG_Team2 = rs1("IG_Team2")
				IG_Status = rs1("IG_Status")
				IG_Result = rs1("IG_Result")
				IG_StartTime = rs1("IG_StartTime")
				IG_Type = rs1("IG_Type")
				IG_score1 = rs1("IG_score1")
			    IG_score2 = rs1("IG_score2")
			    IG_team1betting = rs1("IG_team1betting")
			    IG_drawbetting = rs1("IG_drawbetting")
			    IG_team2betting = rs1("IG_team2betting")
			    IG_team1bet_cnt = rs1("IG_team1bet_cnt")
			    IG_drawbet_cnt = rs1("IG_drawbet_cnt")
			    IG_team2bet_cnt = rs1("IG_team2bet_cnt")


				SQLMSG = "SELECT IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IBD_Result, IBD_Result_benefit FROM INFO_BETTING_DETAIL WHERE IG_Idx = '"& arr_IG_Idx(i) &"' and IB_Idx="& IB_Idx &""
				SET RS2 = DbCon.Execute(SQLMSG)			
			    IG_Team1Benefit = rs2("IG_Team1Benefit")
			    IG_DrawBenefit = rs2("IG_DrawBenefit")
			    IG_Team2Benefit = rs2("IG_Team2Benefit")
			    IG_Handicap = rs2("IG_Handicap")
				IBD_Result = rs2("IBD_Result")
				IBD_Result_benefit = rs2("IBD_Result_benefit")
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
						if Cint(IBD_Result) = Cint(arr_IB_Num(i)) then
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
					If IBD_Result = 0 then
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
								<td rowspan="<%=arrLen+2%>" align="center" >1</td>
							<% end if %>
				<td height="20" align="center" class="td_game"><%=IG_StartTime%></td>
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
				<% if IBD_Result = 0 then %>
				<td align='center' bgcolor='grey'><span style='color:red;'>실패</span></td>
				<% elseif IBD_Result = 1 then %>
					<% if IBD_Result_benefit = 1 then %>
					<td align='center' bgcolor='grey'><span style='color:white;'>적중특례</span></td>
					<% else %>
					<td align='center' bgcolor='grey'><span style='color:yellow;'>적중</span></td>
					<% end if %>
				<% elseif IBD_Result = 2 then %>
				<td align='center' bgcolor='grey'><span style='color:white;'>경기취소</span></td>
				<% elseif IBD_Result = 3 then %>
				<td align='center' bgcolor='grey'><span style='color:white;'>적중특례</span></td>
				<% else %>
				<td align='center' bgcolor='grey'><span style='color:blue;'>진행중</span></td>
				<% end if %>
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
				<td height="22" align="center"  class="td_result">배팅금액</td>
				<td align="center"  class="yellow bold"><%=formatnumber(IB_Amount,0)%></td>
				<td align="center"  class="td_result">예상배당률</td>
				<td colspan="3" align="center"  class="yellow bold">
				<% if Cint(CancelCnt) = Cint(arrLen)+1 then %>
					<font color=white>--</font>
				<% else %>
					<%=numdel(TotalBenefitRate)%>
				<% end if %>
				</td>
				<td align="center"  class="td_result">배당금</td>
				<td align="center"  class="yellow bold">
				<% if Cint(CancelCnt) = Cint(arrLen)+1 then %>
					<font style='color:#ffffff;'>--</font>
				<% else %>
					<%=formatnumber(TotalBenefit,0)%>
				<% end if %>
				</td>
				<td align="center"  class="yellow">
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
%></table>
<script type="text/javascript">
function goEmail(url)
{
    location.href = url ;
}
</script>
<table>
<tr><td>
<input type="button" value="목록으로" style="border:1px solid #999999;" onclick="location.href='Betting_List.asp?page=<%=PAGE%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>&Search=<%=Search%>&Find=<%=Find%>';">

</td></tr></table>
	
<%
	RS2.Close
	Set RS2 = Nothing	

	RS1.Close
	Set RS1 = Nothing	

	RS.Close
	Set RS = Nothing	

	DbCon.Close
	Set DbCon=Nothing
%>