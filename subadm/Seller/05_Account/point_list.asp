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
<%
    page = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
    sStartDate = datevalue(now)  & " 00:00:00"
    sEndDate = datevalue(now) & " 23:59:59" 
    
    Group1 = Request("Group1")
    Group2 = Request("Group2") 
    Group3 = Request("Group3")

    SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)
	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_NICKNAME = RS2("IA_NICKNAME")
	IA_id = RS2("IA_id")
	RS2.CLOSE
	SET RS2 = Nothing
    
    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate") & " 00:00:00"
        sEndDate =  REQUEST("sEndDate") & " 23:59:59"  
        pageSize = 500                  
    End If
    
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()  
	SQL = "SELECT sum(IB_IDX) as totcharge FROM LOG_ADMIN_CASHINOUT WHERE ib_idx > 0 and LAC_GROUP1="&IA_GROUP1&" AND LAC_GROUP2="&IA_GROUP2&" AND LAC_GROUP3="&IA_GROUP3&" AND LAC_GROUP4="&IA_GROUP4&" AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

	SET RS1 = DbCon.Execute(SQL)
	If Not(RS1.Eof Or RS1.Bof) then 
		totcharge = RS1("totcharge")
	End If
	RS1.CLOSE
	SET RS1 = Nothing

	SQL = "SELECT sum(IB_IDX) as totexchange FROM LOG_ADMIN_CASHINOUT WHERE ib_idx < 0 and LAC_GROUP1="&IA_GROUP1&" AND LAC_GROUP2="&IA_GROUP2&" AND LAC_GROUP3="&IA_GROUP3&" AND LAC_GROUP4="&IA_GROUP4&" AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' GROUP BY LAC_SITE, LAC_GROUP1,LAC_GROUP2,LAC_GROUP3,LAC_GROUP4 ORDER BY LAC_SITE"

	SET RS1 = DbCon.Execute(SQL)
	If Not(RS1.Eof Or RS1.Bof) then 
		totexchange = RS1("totexchange")
	End If
	RS1.CLOSE
	SET RS1 = Nothing
%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color:#ffffff;padding:0px 3px 3px 3px;">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
	<tr>
		<td style="width:100%; background-color:#999999;  padding:5px;"><span style="color:white; font-size:14px;font-weight:bold;" >관리자 실시간 정산&nbsp;&nbsp;</td>
	</tr>
</table>    
<div style="border:1px solid #f0f0f0">



<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- 부트스트랩 추가테마 ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- 부트스트랩  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->


<script type="text/javascript" src="../includes/calendar1.js"></script>
<script type="text/javascript" src="../includes/calendar2.js"></script>

<form name="MainForm" action="point_list.asp" method="post" align="center">
시작일자 :
<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	
	종료일자 :
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'>
	<input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'>
	<input type="hidden" name="Group1" value="<%=Group1%>"><input type="hidden" name="Group2" value="<%=Group2%>"><input type="hidden" name="Group3" value="<%=Group3%>">
	<button type="submit">검 색</button>


<div style="height:10px;"></div>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >

<tr class="title-backgra">
		  <th align="center">
			파트너아이디
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
		</tr>
	    <tr height="25" bgcolor="#FFFFFFF">
		  <td align="center">
			<%=IA_ID%>(<font color="red"><%= IA_NICKNAME %></font>)
          </td>
		  <td align="center">
			<%=totcharge%>
          </td>
          <td align="center">
			<%=totexchange%>
          </td>
          <td align="center">
			<%=totcharge + totexchange %>
          </td>
		</tr>
	  </table>         
	</form>
</body>
</html>

