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
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 500
	PGSIZE = 50
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = Trim(REQUEST("Search"))
	Find = Trim(REQUEST("Find"))
	site        = SESSION("rJOBSITE")

    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate") & " 00:00:00"
        sEndDate =  REQUEST("sEndDate") & " 23:59:59"  
        pageSize = 500                  
    End IF
    
    IF (Search = "LAC_ID" And Find <> "") Then
        sStartDate = ""
        sEndDate = ""    
        page        = 1
        pageSize    = 999999
    End IF
    
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

	'######### 충전 내역을 볼러옴                 ################	
	IA_SITE = Session("rJOBSITE")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_Type = RS2("IA_Type")
	RS2.CLOSE
	SET RS2 = Nothing
	If IA_LEVEL = "2" THEN
		Call dfAccountSql.RetrieveLog_AdminCashInOut_SUBNEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, IA_GROUP, IA_GROUP1)
	ELSEIf IA_LEVEL = "3" Then
		Call dfAccountSql.RetrieveLog_AdminCashInOut_SUBNEWs1(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, IA_GROUP, IA_GROUP1, IA_GROUP2)
	ELSEIf IA_LEVEL = "4" Then
		Call dfAccountSql.RetrieveLog_AdminCashInOut_SUBNEWs2(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3)
	ELSEIf IA_LEVEL = "5" Then
		Call dfAccountSql.RetrieveLog_AdminCashInOut_SUBNEWs3(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
	End If

	IF dfAccountSql.RsCount <> 0 Then
	    nTotalCnt = dfAccountSql.RsOne("TC")
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
<title>머니사용로그</title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/SELLER/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          

</head>


<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> ▶ </span>
		  정산관리&nbsp;&nbsp;▶ 총판 충전 관리
	</div>


<div style="height:10px;"></div>



<div style="height:40px;"><font color="red"><b>**적립률이 마이너스가 뜰경우 상위총판보다 프로테이지가 높은경우입니다</br>**0%는 상위총판과 동일한 프로테이지를 적용한 경우입니다</b></font></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Money_Addadmin_charge.asp">
<tr><td>시작 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolo역:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="IB_IDX" <%if Search = "IB_IDX" then Response.Write "selected"%>>베팅번호</option>
		<option value="LAC_ID" <%if Search = "LAC_ID" then Response.Write "selected"%>>아이디</option>		
		<option value="LAC_CONTENT" <%if Search = "LAC_CONTENT" then Response.Write "selected"%>>처리내역</option>
		<option value="LAC_SITE" <%if Search = "LAC_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input" style="width:100px;"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색" class="btn btn-info btn-xs"></td>
</tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >
<col width="40" />
<col width="100" />
<col width="60" />
<col width="60" />
<col width="60" />
<col width="70" />
<form name="frm" method="post">
  <tr bgcolor="e7e7e7" class="title-backgra">
	<!-- <th align="center"><b>선택</b></th> -->
	<th align="center" ><b>No.</b></th>
	<th align="center" ><b>충전아이디</b></th>	
	<th align="center" ><b>충전/환전</b></th>	
	<th align="center" ><b>충전/환전금액</b></th>
	<th align="center" ><b>총판코드</b></th>
	<th align="center" ><b>날짜</b></th>
	
	</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="8" height="35">현재 등록된 정보가 없습니다.</td></tr>

<%
	ELSE

	TotCash1 = 0
	TotCash2 = 0
	FOR i = 0 TO dfAccountSql.RsCount -1

		LAC_IDX		= dfAccountSql.Rs(i,"LAC_IDX")
		LAC_ID		= dfAccountSql.Rs(i,"LAC_ID")
		LAC_SITE		= dfAccountSql.Rs(i,"LAC_SITE")
		LAC_CASH	= dfAccountSql.Rs(i,"LAC_CASH")
		LAC_GCASH	= dfAccountSql.Rs(i,"LAC_GCASH")
		LAC_TYPE= dfAccountSql.Rs(i,"LAC_TYPE")
		LAC_CONTENT	= dfAccountSql.Rs(i,"LAC_CONTENT")
		IB_IDX	    = dfAccountSql.Rs(i,"IB_IDX")
		LAC_REGDATE	    = dfAccountSql.Rs(i,"LAC_REGDATE")


		IF LAC_CASH > 0 Then
		    tdCashStyle = "style='color:blue'"
		    plus = "+"
		Else
		    tdCashStyle = "style='color:red'"
		    plus = ""
		End IF
		If IB_IDX = "0" Then
			charge = "<b><font color=black>적립</font></b>"
		ElseIf IB_IDX > "0" Then
			charge = "<b><font color=#6666dd>충전</font></b>"
		ElseIf IB_IDX < "0" Then
			charge = "<b><font color=#dd6666>환전</font></b>"
		End If
		If LAC_TYPE = 1 then
		TotCash1 = Cdbl(TotCash1) + Cdbl(LAC_CASH)	
		TotCash2 = Cdbl(TotCash2) + Cdbl(IB_IDX)	

			SQLLIST3 = "select top 1 IA_NICKNAME from info_admin where ia_site = '"& LAC_SITE &"'"
			SET RS3 = DBCON.EXECUTE(SQLLIST3)

			IA_NICKNAME = RS3("IA_NICKNAME")

			RS3.CLOSE
			SET RS3 = Nothing

			SQLLIST4 = "select top 1 IU_NICKNAME from info_user where iu_id = '"& LAC_ID &"'"
			SET RS4 = DBCON.EXECUTE(SQLLIST4)

			IU_NICKNAME = RS4("IU_NICKNAME")

			RS4.CLOSE
			SET RS4 = Nothing
%>

<tr bgcolor="#FFFFFF" ><td align="center"><%=LAC_IDX%></td>
	<td>&nbsp;<a href="/seller/05_Account/Money_Addadmin_charge.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LAC_ID&Find=<%=LAC_ID%>"><%=LAC_ID%></a> (<font color="#6666bb"><b><%=IU_NICKNAME%></b></font>)</td>	
	<td align="center"><%=charge%></td>
	<td align="right"><%=FORMATNUMBER(IB_IDX,0)%>원</td>
	<td align='center'><a href="/seller/05_Account/Money_Addadmin_charge.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LAC_SITE&Find=<%=LAC_SITE%>"><%=LAC_SITE%></a> (<font color="#6666bb"><b><%=IA_NICKNAME%></b></font>)</td>
	<td align="center"><%=dfStringUtil.GetFullDate(LAC_REGDATE)%></td>
	</td>
	</tr>

	<% End If 
	Next %>

<tr bgcolor="#FFFFFF"><td colspan="3" align="center"><b>합 계</b></td>
	<td align="right"><b><%=FORMATNUMBER(TotCash2,0)%>&nbsp;원&nbsp;</b></td>
	<td align="right">&nbsp;</td>
	<td colspan="4" align="center">&nbsp;</td></tr>

	<% END IF %></table><br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

</body>
</html>
