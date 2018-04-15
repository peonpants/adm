<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    

    
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 10000
	PGSIZE = 10
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = Trim(REQUEST("Search"))
	Find = Trim(REQUEST("Find"))
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
    
    IF Search = "" Then
        sStartDate = datevalue(now)
        sEndDate = sStartDate
        pageSize = 500            
    End IF
    
    IF sStartDate <> "" AND sEndDate <> "" Then
        sStartDate = sStartDate & " 00:00:00"
        sEndDate =  sEndDate & " 23:59:59"  
        pageSize = 500         
    End IF
    
    IF (Search = "LP_ID" And Find <> "") OR (Search = "IU_NICKNAME" And Find <> "") Then
        sStartDate = ""
        sEndDate = ""    
        page        = 1
        pageSize    = 500
    End IF
    
 

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    	
	'######### 정산 리스트를 불러옴                 ################
   
	Call dfAccountSql.RetrieveLOG_POINTINOUTByAdmin(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
'dfAccountSql.debug
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
<title>포인트 현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body >
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 정산관리&nbsp;&nbsp;▶ Point 정보</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="point_list.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<!--<option value="">---검색어---</option>-->
		<option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>닉네임</option>
		<option value="LP_ID" <%if Search = "LP_ID" then Response.Write "selected"%>>아이디</option>		
		<option value="LP_COMMENTS" <%if Search = "LP_COMMENTS" then Response.Write "selected"%>>처리내역</option>
		<option value="LP_CONTENTS1" <%if Search = "LP_CONTENTS1" then Response.Write "selected"%>>비고</option>
		<option value="LP_SITE" <%if Search = "LP_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="엑셀저장" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>
	
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#1F3E5A">
                               <tr bgcolor="#eeeeee">
                                    <td width="6%" height="27"  align="center" >번호</td>
                                    <td width="18%"  align="center" >ID(닉네임)</td>
                                    <td width="8%"  align="center" >사용내역</td>
                                    <td width="7%"  align="center" >포인트</td>
                                    <td width="18%"  align="center" >내용</td>
                                    <td width="7%" align="center" >타입</td>                                    
                                    <td width="11%"  align="center" >등록일시</td>
                                    <td align="center" >비고</td>
                                </tr>
<%
 
IF dfAccountSql.RsCount <> 0 Then
    For i = 0 to  dfAccountSql.RsCount - 1
    
			ROWNUMBER		= dfAccountSql.Rs(i,"ROWNUMBER")
			LP_IDX			= dfAccountSql.Rs(i,"LP_IDX")
			LP_ID		    = dfAccountSql.Rs(i,"LP_ID")
			LP_TYPE         = dfAccountSql.Rs(i,"LP_TYPE")
			LP_POINT        = dfAccountSql.Rs(i,"LP_POINT")
			LP_GPOINT        = dfAccountSql.Rs(i,"LP_GPOINT")
			LP_COMMENTS		= dfAccountSql.Rs(i,"LP_COMMENTS")
			LP_DATE		    = dfAccountSql.Rs(i,"LP_DATE")
			LP_CONTENTS1    = dfAccountSql.Rs(i,"LP_CONTENTS1")
		    IB_IDX	    = dfAccountSql.Rs(i,"IB_IDX")
		    IG_IDX	    = dfAccountSql.Rs(i,"IG_IDX")			
			IU_NICKNAME     = dfAccountSql.Rs(i,"IU_NICKNAME")
			TC		        = dfAccountSql.Rs(i,"TC")

			IF LP_TYPE = 1 THEN
				Status = "적립"				
				tdCashStyle = "style='color:blue'"
		        plus = "+"									
			ELSE
				Status = "차감"
				tdCashStyle = "style='color:red'"
		        plus = ""
			END IF	    
%> 
                                <tr bgcolor="#ffffff">
                                    <td align="center" ><%=LP_IDX%></td>
                                    <td  ><a href="point_list.asp?Search=LP_ID&Find=<%=LP_ID%>"><%= LP_ID %>(<%=IU_NICKNAME%>)</a></td>
                                    <td  <%= tdCashStyle %>><%= plus %><%=FORMATNUMBER(LP_POINT,0)%> P</td>
                                    <td  style="color:green;font-weight:bold;"><%=FORMATNUMBER(LP_GPOINT,0)%> P</td>
                                    <td  ><a href="point_list.asp?Search=LP_COMMENTS&Find=<%=LP_COMMENTS%>"><%=LP_COMMENTS%></a></td>
                                    <td align="center" ><%=Status%></td>
                                    <td align="center" ><%=dfStringUtil.GetFullDate(LP_DATE)%></td>
                                    <td  >
                                        <% IF IB_IDX <> "" AND cStr(IB_IDX) <> "0" Then %>
	                                    <a href="/EPCenter/05_Account/point_list.asp?Search=IB_IDX&Find=<%= IB_IDX %>">배팅번호:</a>
	                                    <a href="/EPCenter/04_Game/Betting_List1.asp?Search=IB_IDX&Find=<%=IB_IDX %>" target="_blank"><%= IB_IDX %></a> -- 
	                                    <a href="/EPCenter/05_Account/point_list.asp?Search=IG_IDX&Find=<%= IG_IDX %>">게임번호</a>:
	                                    <a href="/EPCenter/04_Game/GameBet_New.asp?IG_IDX=<%= IG_IDX %>" target="_blank"><%= IG_IDX  %></a>
	                                    <% End IF %>
	                                    <%
	                                        IF LP_CONTENTS1 <> "" Then
	                                            response.write LP_CONTENTS1
	                                        End IF
                                        %>                                    
                                    </td>
                                    
                                    
                                </tr>
<%
    Next
End IF
%>                                                               
</table>
<br />
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<table width=100% border=0>
<tr>
    <td align="center">
        <%= objPager.Render %>
    </td>
</tr>
</table>
<%	END IF	%>
<!-- paging End -->


</body>
      