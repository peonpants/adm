<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    page = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
    sStartDate = datevalue(now)  & " 00:00:00"
    sEndDate = datevalue(now) & " 23:59:59" 
    Group1 = Request("Group1")
    Group2 = Request("Group2") 
    Group3 = Request("Group3") 
    
    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate") & " 00:00:00"
        sEndDate =  REQUEST("sEndDate") & " 23:59:59"  
        pageSize = 500                  
    End If
    
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()  

    SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE LAC_GROUP1 BETWEEN 1 and 3 AND LAC_GROUP2=0 GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

    IF Group1<>Empty then
		condition2=" LAC_GROUP1="&Group1&" AND LAC_GROUP2>0 AND LAC_GROUP3=0"
		If Group3 >0 then 
			condition2=" LAC_GROUP1="&Group1&" "&" AND LAC_GROUP2="&Group2&" "&" AND LAC_GROUP3="&GROUP3&" "&" AND LAC_GROUP4>0"
		ELSEIf Group2 >0 then 
			condition2=" LAC_GROUP1="&Group1&" "&" AND LAC_GROUP2="&Group2&" "&" AND LAC_GROUP3>0 AND LAC_GROUP4=0"
		End If
		SQL = "SELECT LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 FROM LOG_ADMIN_CASHINOUT WHERE "&condition2&" GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"
    End If
%>
    <!-- <script>alert("<%= SQL %>")</script> -->
<%    
	SET RS1 = DbCon.Execute(SQL)
	If Not(RS1.Eof Or RS1.Bof) then 
		Results = RS1.GetRows()
		resCount = Ubound(Results,2)+1
	End If

%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<script type="text/javascript" src="../includes/calendar1.js"></script>
<script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<table border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 관리자 실시간 정산</b></td>
</tr>
</table>
<form name="MainForm" action="/EPCenter/05_Account/Money_Addadmin_NEW.asp" method="post" align="center">
시작일자 :
<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'>
	종료일자 :
	<input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'>
	
	<input type="hidden" name="Group1" value="<%=Group1%>"><input type="hidden" name="Group2" value="<%=Group2%>"><input type="hidden" name="Group3" value="<%=Group3%>">
	<button type="submit">검 색</button>
</form>

<div style="height:10px;"></div>

 <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="70%" align="center">
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
			파트너 (정산률)
          </td>
		  <td align="center">
			충전
          </td>
          <td align="center">
			환전
          </td>
          <td align="center">
			정산
          </td>
          <td align="center">
			베팅금액
          </td>
		</tr>
		<%		
            IF resCount <> 0 Then
                For i = 0 to resCount-1
        %>
			<tr height="25" bgcolor="#FFFFFFF">
			  <td align="center" >
			  	<%
			  	condition="LAC_GROUP1="&Results(1,i)
			  	If Group1<>Empty then
			  		if Group3>0 then 
			  			condition="LAC_GROUP4="&Results(4,i)&" AND LAC_GROUP3="&Results(3,i)&" AND LAC_GROUP2="&Results(2,i)
			  		elseif Group2>0 then 
			  			condition="LAC_GROUP3="&Results(3,i)&" AND LAC_GROUP2="&Results(2,i)
			  		elseif Group1>0 then 
			  			condition="LAC_GROUP2="&Results(2,i)
			  		end if
			  	End If

				sql_="SELECT sum(case when IB_IDX>=0 then IB_IDX End),sum(case when IB_IDX<0 then IB_IDX End), sum(IB_IDX) FROM LOG_ADMIN_CASHINOUT WHERE "&condition&" AND LAC_REGDATE>='"&sStartDate&"' AND LAC_REGDATE<='"&sEndDate&"' "
	%>
	
	<%
				SET RS2 = DbCon.Execute(sql_)
				If Not(RS2.Eof Or RS2.Bof) then 
					res2 = RS2.GetRows()
				End If

				sql = "select sum(ib_amount) from info_betting where LAC_REGDATE>='"&sStartDate&"' AND LAC_REGDATE<='"&sEndDate&"' "
				SET RS3 = DbCon.Execute(sql)
				
				If Not RS3.EOF Then
				sumamount = RS3(0)
				End If

				If isnull(res2(0, 0)) Then
					results1 = 0
				ElseIf res2(0, 0) > 0 then
					results1 = "<font color=blue>" & FormatNumber(res2(0, 0),0) & "</font>"
				ElseIf res2(0, 0) < 0 then
					results1 = "<font color=red>" & FormatNumber(res2(0, 0),0) & "</font>"
				End If
				
				If isnull(res2(1, 0)) Then
					results2 = 0
				ElseIf res2(1, 0) > 0 then
					results2 = "<font color=blue>" & FormatNumber(res2(1, 0),0) & "</font>"
				ElseIf res2(1, 0) < 0 then
					results2 = "<font color=red>" & FormatNumber(res2(1, 0),0) & "</font>"
				End If

				If isnull(res2(2, 0)) Then
					results3 = 0
				ElseIf res2(2, 0) > 0 then
					results3 = "<font color=blue>" & FormatNumber(res2(2, 0),0) & "</font>"
				ElseIf res2(2, 0) < 0 then
					results3 = "<font color=red>" & FormatNumber(res2(2, 0),0) & "</font>"
				End If

			  	%>
			  	<a href="?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Group1=<%=Results(1,i)%>&Group2=<%=Results(2,i)%>&Group3=<%=Results(3,i)%>"><%=Results(0, i)%></a>
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
			<% 
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
			%>
			</tr>
		<%
            Next 
        %>			
			<tr>
			  <td align="center" height="1">
			    추가된 관리자가 없습니다.
			  </td>
			</tr>
		<%
			End IF
	    %>
	    <tr height="25" bgcolor="#EEEEEE">
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
				<font color="red"><%=FormatNumber(sumadmount,0)%></font> 원
          </td>
		</tr>
	  </table>         

</body>
</html>

