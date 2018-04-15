<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<style>
.td_right{
	text-align:right;
}
/*H 테이블 호버시 배경색*/
.trhover tr:not(:first-child):not(:last-child):hover{
    background-color:#ddf1ff !important;
}

.trhover tr table tr td:hover {
    background-color: #182755 !important;
    color:#ffffff;
    font-weight:bold;
}
/*H 테이블 호버시 배경색 끝*/

a:hover{
	font-color:blue;
	color:DarkBlue !important;
    background-color: #bbccdf !important;
}
</style>

<%

'lv 10 총판
'lv 9 관리자테스트 아이디
'lv 1~5 유저 레벨




	SumDownUserCount = 0		'H 하위가입 회원수 합계용
	SumDownUserCount2 = 0		'H 하위가입 총회원수 합계용
    page = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
    sStartDate = datevalue(now)  & " 00:00:00"
    sEndDate = datevalue(now) & " 23:59:59" 
    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate") & " 00:00:00"
        sEndDate =  REQUEST("sEndDate") & " 23:59:59"  
        pageSize = 500                  
    End If
    
    Group1 = Request("Group1")
    Group2 = Request("Group2") 
    Group3 = Request("Group3")

    SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)
	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	RS2.CLOSE
	SET RS2 = Nothing
    
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()  
	IF IA_LEVEL=2 then 'LAC_GROUP1'
	    SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE LAC_GROUP1="&IA_GROUP1&" AND LAC_GROUP2=0 GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

	    IF Group1<>Empty then
			condition2=" LAC_GROUP1="&IA_GROUP1&" AND LAC_GROUP2>0 AND LAC_GROUP3=0"
			If Group3 >0 then 
				condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3="&GROUP3&" AND LAC_GROUP4>0"
			ELSEIf Group2 >0 then 
				condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3>0 AND LAC_GROUP4=0"
			End If
			SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE "&condition2&" GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"
	    End If

	ElSEIF IA_LEVEL=3 then 'LAC_GROUP2'
		condition2=" LAC_GROUP1="&IA_GROUP1&" AND LAC_GROUP2="&IA_GROUP2&" AND LAC_GROUP3=0"
		IF Group2<>Empty then
			If Group3 >0 then 
				condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3="&GROUP3&" AND LAC_GROUP4>0"
			ElSE
				condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3>0 AND LAC_GROUP4=0"
			End If
		End If
		SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE "&condition2&" GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

	ELSEIF IA_LEVEL=4 then 'LAC_GROUP3'
		condition2=" LAC_GROUP1="&IA_GROUP1&" "&" AND LAC_GROUP2="&IA_GROUP2&" AND LAC_GROUP3="&IA_GROUP3&" AND LAC_GROUP4=0"
		If Group3<>Empty then condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3="&GROUP3&" "&" AND LAC_GROUP4>0"
		SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE "&condition2&" GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

	ELSEIF IA_LEVEL=4 then 'LAC_GROUP4'
		condition2=" LAC_GROUP1="&IA_GROUP1&" "&" AND LAC_GROUP2="&IA_GROUP2&" AND LAC_GROUP3="&IA_GROUP3&" AND LAC_GROUP4=0"
		If Group3<>Empty then condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2="&Group2&" AND LAC_GROUP3="&GROUP3&" "&" AND LAC_GROUP4>0"
		SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE "&condition2&" GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"
	ElSE
%>
<script>
	alert('not allowed');
	window.history.back();
</script>
<%
	END IF
%>

<%

	SET RS1 = DbCon.Execute(SQL)
	If Not(RS1.Eof Or RS1.Bof) then 
		Results = RS1.GetRows()
		resCount = Ubound(Results,2)+1
	End If

%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          

<script type="text/javascript" src="../includes/calendar1.js"></script>
<script type="text/javascript" src="../includes/calendar2.js"></script>


<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> ▶ </span>
		 관리자 실시간 정산
	</div>


<div style="height:10px;"></div>


 
<form name="MainForm" action="Money_Addadmin_NEW.asp" method="post" align="center">
	시작일자 :
	<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'>
	
	종료일자 :
	<input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'>
	<input type="hidden" name="Group1" value="<%=Group1%>"><input type="hidden" name="Group2" value="<%=Group2%>"><input type="hidden" name="Group3" value="<%=Group3%>">
	<button class="btn btn-default btn-xs" type="submit">검 색</button>


<div style="height:10px;"></div>

<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >


  <tr bgcolor="e7e7e7" class="title-backgra">
		  <th align="center">
			파트너 (정산률)
          </th>
		  <th align="center">
			충전
          </th>
          <th align="center">
			환전
          </th>
          <th align="center">
			정산
          </th>
          <th align="center">
          </th>
          <th align="center">
			배팅금액
          </th>
          <th align="center">
			당첨금액
          </th>
          <th align="center">
			가입인원
          </th>
          <th align="center">
		  총인원
          </th>
		</th>
		<%		
            IF resCount <> 0 Then
                For i = 0 to resCount-1
				if i mod 2 = 0 Then
					%>			<tr height="25">
<%
					else%>			<tr height="25" style="background-color:#fafafa">

					<%End if
        %>

			  <td align="center" >
			  	<%
			  	IF IA_LEVEL=2 then condition="LAC_GROUP1="&Results(1,i)
			  	IF IA_LEVEL=3 then condition="LAC_GROUP1="&Results(1,i)&" AND LAC_GROUP2="&Results(2,i)
			  	IF IA_LEVEL=4 then condition="LAC_GROUP1="&Results(1,i)&" AND LAC_GROUP2="&Results(2,i)&" AND LAC_GROUP3="&Results(3,i)

			  	If Group1<>Empty or Group2<>Empty or Group3<>Empty then
			  		if Group3>0 then 
			  			condition="LAC_GROUP1="&Results(1,i)&" AND LAC_GROUP2="&Results(2,i)&" AND LAC_GROUP3="&Results(3,i)&" AND LAC_GROUP4="&Results(4,i)
			  		elseif Group2>0 then 
			  			condition="LAC_GROUP1="&Results(1,i)&" AND LAC_GROUP2="&Results(2,i)&" AND LAC_GROUP3="&Results(3,i)
			  		elseif Group1>0 then 
			  			condition="LAC_GROUP1="&Results(1,i)&" AND LAC_GROUP2="&Results(2,i)
			  		end if
			  	End If

				sql_="SELECT sum(case when IB_IDX>=0 then IB_IDX End),sum(case when IB_IDX<0 then IB_IDX End), sum(IB_IDX) FROM LOG_ADMIN_CASHINOUT WHERE "&condition&" AND LAC_REGDATE>='"&sStartDate&"'AND LAC_REGDATE<='"&sEndDate&"'"
				%>
				<!-- <script type="text/javascript">alert("")</script> -->
				<%
				SET RS2 = DbCon.Execute(sql_)
				If Not(RS2.Eof Or RS2.Bof) then 
					res2 = RS2.GetRows()
				End If

				If isnull(res2(0, 0)) or res2(0, 0)=0 Then
					results1 = 0
				ElseIf res2(0, 0) > 0 then
					results1 = "<font color=blue>" & FormatNumber(res2(0, 0),0) & "</font>"
				ElseIf res2(0, 0) < 0 then
					results1 = "<font color=red>" & FormatNumber(res2(0, 0),0) & "</font>"
				End If
				
				If isnull(res2(1, 0)) or res2(1, 0)=0 Then
					results2 = 0
				ElseIf res2(1, 0) > 0 then
					results2 = "<font color=blue>" & FormatNumber(res2(1, 0),0) & "</font>"
				ElseIf res2(1, 0) < 0 then
					results2 = "<font color=red>" & FormatNumber(res2(1, 0),0) & "</font>"
				End If

				If isnull(res2(2, 0)) or res2(2, 0)=0 Then
					results3 = 0
				ElseIf res2(2, 0) > 0 then
					results3 = "<font color=blue>" & FormatNumber(res2(2, 0),0) & "</font>"
				ElseIf res2(2, 0) < 0 then
					results3 = "<font color=red>" & FormatNumber(res2(2, 0),0) & "</font>"
				End If
				sql1 = "select ia_nickname from info_admin where ia_id='" & Results(0, i) & "'"
				SET RS3 = DbCon.Execute(sql1)
				If Not(RS3.Eof Or RS3.Bof) then 
				IA_NICKNAME= RS3("IA_NICKNAME")
				End If	

				'H
					IA_UID = Results(0, i)	'H뒤에서 쓰기 위해서 아이디 변수로 남겨놓기
				'H
	%>

	<%
	HRNowG1	=Results(1,i)
	HRNowG2	=Results(2,i)
	HRNowG3	=Results(3,i)
	HRNowG4	=Results(4,i)



		'H 마지막 그룹이면 이름 링크를 일단 없애자
			if Results(4,i)  < 1 then %>
			  	<a href="?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Group1=<%=Results(1,i)%>&Group2=<%=Results(2,i)%>&Group3=<%=Results(3,i)%>&Group4=<%=Results(4,i)%>" title="<%=Results(0, i)%>님의 하위 매장 보기">

				<%else%><span style="color:#666666"><%
				end if%>
				<%=Results(0, i)%></a>(<font color="red"><%= IA_NICKNAME %></font>)
			  </td>
			  <td align="center" >
				<%=results1%> 원
			  </td>
			  <td align="center" >
				<%=results2%> 원
			  </td>
			  <td align="center" >
				<%=results3%> 원
			  </td>
			  <td align="center" >
			  </td>
<%
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
'H 하위총판수 회원수 가져오기
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
	HWhereAdd  =" "	'총판 그룹넘버들
	HWhereAdd2 =" " '배팅 내역 찾기용
	HWhereLv = 2
	if HRNowG1 = 0 then
	else
		HWhereAdd = HWhereAdd + " AND a.ia_group1="&HRNowG1
		HWhereAdd2 = HWhereAdd2 + " AND ib_group1 = "&HRNowG1
		HWhereLv=3
	end if
	if HRNowG2 = 0 then
	else
		HWhereAdd = HWhereAdd + " AND a.ia_group2="&HRNowG2
		HWhereAdd2 = HWhereAdd2 + " AND ib_group2 = "&HRNowG2
		HWhereLv=4
	end if

	if HRNowG3 = 0 then
	else
		HWhereAdd = HWhereAdd + " AND a.ia_group3="&HRNowG3
		HWhereAdd2 = HWhereAdd2 + " AND ib_group3 = "&HRNowG3

		HWhereLv =5
	end if
	if HRNowG4 = 0 then
	else
		HWhereAdd = HWhereAdd + " AND a.ia_group4 ="&HRNowG4
		HWhereAdd2 = HWhereAdd2 + " AND ib_group4 ="&HRNowG4

	end if
'   AND LAC_REGDATE>='"&sStartDate&"'AND LAC_REGDATE<='"&sEndDate&"'"
'    SQLLISTCount2 = "select count(*) AS MCount2 FROM info_user AS u INNER JOIN info_admin AS a ON u.iu_site = a.ia_id WHERE a.ia_level >= "& HWhereLv &" and a.ia_Group ="&IA_GROUP &" "&HWhereAdd
'H 인원 날짜집계    SQLLISTCount2 = "select count(*) AS MCount2 FROM info_user AS u INNER JOIN info_admin AS a ON u.iu_site = a.ia_id WHERE u.iu_level =1 and a.ia_Group ="&IA_GROUP &" "&HWhereAdd
   SQLLISTCount2 = "select count(*) AS MCount2 FROM info_user AS u INNER JOIN info_admin AS a ON u.iu_site = a.ia_id WHERE a.ia_Group ="&IA_GROUP &" "&HWhereAdd &" AND U.IU_RegDate>='"&sStartDate&"'AND U.IU_RegDate<='"&sEndDate&"'"
	Set resCount2 = DbCon.Execute(SQLLISTCount2)
	UCount2 = resCount2(0)
	resCount2.CLOSE
	SET resCount2 = Nothing
	SumDownUserCount = SumDownUserCount + UCount2	'H 회원수 합계 표시용


'H 인원 총집계
	SQLLISTCount22 = "select count(*) AS MCount2 FROM info_user AS u INNER JOIN info_admin AS a ON u.iu_site = a.ia_id WHERE  a.ia_Group ="&IA_GROUP &" "&HWhereAdd
	Set resCount22 = DbCon.Execute(SQLLISTCount22)
	UCount22 = resCount22(0)
	resCount22.CLOSE
	SET resCount22 = Nothing
	SumDownUserCount2 = SumDownUserCount2 + UCount22	'H 총회원수 합계 표시용



'H 배팅머니 구하기
'H 총집계    SQLLISTCount3 = "select  sum(IB_Amount)  FROM INFO_BETTING WHERE ib_Group ="&IA_GROUP &" "&HWhereAdd2
    SQLLISTCount3 = "select  sum(IB_Amount)  FROM INFO_BETTING WHERE ib_Group ="&IA_GROUP &" "&HWhereAdd2 &" and IB_RegDate>='"&sStartDate&"'AND IB_RegDate<='"&sEndDate&"'"
	Set resCount3 = DbCon.Execute(SQLLISTCount3)
	UCount3 = resCount3(0)
			if isNull(UCount3) then
			UCount3 = 0
		end if


	resCount3.CLOSE
	SET resCount3 = Nothing

'당첨 머니 구하기
    SQLLISTCount4 = "select  sum(IB_Benefitamount)  FROM INFO_BETTING WHERE ib_Group ="&IA_GROUP &" "&HWhereAdd2 &" and IB_RegDate>='"&sStartDate&"'AND IB_RegDate<='"&sEndDate&"'"
	Set resCount4 = DbCon.Execute(SQLLISTCount4)

		UCount4 = resCount4(0)
			if isNull(UCount4) then
			UCount4 = 0
		end if

	resCount4.CLOSE
	SET resCount4 = Nothing
%>
			  <td align="right" >
			  	<%=formatnumber(UCount3,0)%> 원 

			  </td>
			  <td align="right" >
			  	<%=formatnumber(UCount4,0)%> 원
			  </td>

			  <td align="center" class="td_right">
			<a href="Money_Addadmin_NEW_MembeList.asp?g1=<%=HRNowG1%>&g2=<%=HRNowG2%>&g3=<%=HRNowG3%>&g4=<%=HRNowG4%>&Sdate=<%=sStartDate%>&Edate=<%=sEndDate%>" title="기간내 가입 명단보기"><%=UCount2%>명</a>
			</td>
			  <td align="center" class="td_right">
			<a href="Money_Addadmin_NEW_MembeListAll.asp?g1=<%=HRNowG1%>&g2=<%=HRNowG2%>&g3=<%=HRNowG3%>&g4=<%=HRNowG4%>&Sdate=<%=sStartDate%>&Edate=<%=sEndDate%>" title="가입 명단보기"><%=UCount22%>명</a>
			<br/><%'=SQLLISTCount3%>
			  </td>
<% 
'회원수 가져오기 끝
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH




				If isnull(res2(0, 0)) Then
				res2(0, 0) = 0
				ElseIf isnull(res2(1, 0)) Then
				res2(1, 0) = 0
				ElseIf isnull(res2(2, 0)) Then
				res2(2, 0) = 0 
				End If


				totcharge = totcharge + res2(0,0)
				totexchange = totexchange + res2(1,0)
				totjungsan = totjungsan + res2(2,0)
				If isnull(totcharge) Then
				totcharge = 0
				ElseIf isnull(totexchange) Then
				totexchange = 0
				ElseIf isnull(totjungsan) Then
				totjungsan = 0 
				End If
			%>
			</tr>
		<%
            Next 

			End IF
	    %>
  <tr bgcolor="e7e7e7" class="title-backgra">
		  <td align="center">
			<%=i%>개의 파트너
          </td>
		  <td align="center">
				<font color="blue"><%=FormatNumber(totcharge,0)%></font> 원
          </td>
          <td align="center">
				<font color="red"><%=FormatNumber(totexchange,0)%></font> 원
          </td>

          <td align="center">
		  				<% If totjungsan > 0 Then
					Response.write "<b><font color=blue>" & FormatNumber(totjungsan,0) & "</font>원</b>"
				ElseIf totjungsan < 0 Then
					Response.write "<b><font color=red>" & FormatNumber(totjungsan,0) & "</font>원</b>"
				Else
					Response.write "0 원"
				End If
				%>

          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
		  
          <td align="right">
								<font color="#666666"><%=FormatNumber(SumDownUserCount,0)%></font>명
			</td>
          <td align="right">
								<font color="#666666"><%=FormatNumber(SumDownUserCount2,0)%></font>명
          </td>
		</tr>
	</table>         

	</form>
</body>
</html>

