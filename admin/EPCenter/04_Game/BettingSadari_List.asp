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
   
	Call dfgameSql.RetrieveInfo_Betting_NEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user,1)

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

	function AllChk() {
		var chkAll = document.frm1.chkAll;
		var cbox = document.frm1.SelUser;
		if (cbox.length) {
			for(var i=0; i<cbox.length; i++) {
				cbox[i].checked = chkAll.checked;
			}
		}
		else {
			cbox.checked = chkAll.checked;
		}
	}

	function go_update(form,st)
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
		
		if (!confirm("정말 삭제하시겠습니까?")) return;		
		form.action = "Update_bet.asp?page=<%=Page%>&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_update1(a)
	{
		if (!confirm("정말 삭제하시겠습니까?")) return;		
		
		goUrl = "Update_bet2.asp?IB_nm="+a;
		location.href=goUrl;
		
	}

</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" id="exeFrame" widht="0" height="0"></iframe>
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
<form name="MainForm" method="get" action="Betting_List.asp">
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
	<td><input type="submit" value="검 색" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="엑셀저장" onclick="location.href='Betting_List_Excel.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="eeeeee"> 
	<td align="center" height="30" width="40"><b>선택</b></td>
	<td align="center" width="50"><b>번호</b></td>
	<td align="center" width="40"><b>구분</b></td>
	<td align="center" width="30"><b>ID</b></td>
	<td align="center" width="60"><b>사이트</b></td>
	<td align="center" width="40"><b>게임수</b></td>
	<td align="center"><b>배팅진행내역</b></td>			
	<td align="center" width="60"><b>배당율</b></td>
	<td align="center" width="90"><b>배팅액</b></td>
	<td align="center" width="90"><b>배당적중금</b></td>
	<td align="center" width="120"><b>배팅시간</b></td>		
	<td align="center" width="60"><b>결과</b></td>
	<td align="center" width="60"><b>상세</b></td>
	<td align="center" width="60"><b>취소</b></td>
	<td align="center" width="50"><b>유저페이지<br>삭제유무</b></td>
	</tr>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">현재 등록된 배팅이 없습니다.</td></tr>

<%
	ELSE


IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1  ' 실제정중%
    TotalBenefit1        = 1 ' 예상적중%
    totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 5 : 진행중 , 9 : 진행중
    
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "<font color='red'>실패</font>"
        txttotalIBD_RESULT(1) = "<font color='yellow'>성공</font>"
        txttotalIBD_RESULT(2) = "<font color='f0f0f0'>취소</font>"
        txttotalIBD_RESULT(3) = "1배처리"        
        txttotalIBD_RESULT(9) = "<font color='blue'>진행중</font>"
        
        
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
		IB_ADMIN_CANCEL = dfgameSql.Rs(ii,"IB_ADMIN_CANCEL")	
		IB_CANCEL_DATE = dfgameSql.Rs(ii,"IB_CANCEL_DATE")	
		IB_BWIN = dfgameSql.Rs(ii,"IB_BWIN")	
		IB_CNT = dfgameSql.Rs(ii,"IB_CNT")	
		IB_CREGER = dfgameSql.Rs(ii,"IB_CREGER")	
 	
		
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)    
                
        IF IB_CNT = 1 Then
            strIB_TYPE = "단식"
        Else
            strIB_TYPE = "복식"
        End IF 
        
        IF IB_BWIN = "1" Then
            strIB_TYPE = strIB_TYPE &  "<Br>BWIN"
        End IF        
%>
<tr bgcolor="ffffff"> 
	<td align="center">
	<input type="checkbox" name="SelUser" value="<%=ib_idx%>" onclick="changeTrColor(this.value)">
	</td>
	<td align="center">
	<%=ib_idx%>
	</td>
	<td align="center"><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_TYPE&Find=<%=IB_Type%>">
	<%= strIB_TYPE %></a></td>
	<td>&nbsp;<b><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_ID&Find=<%=IB_ID%>"><%=IB_ID%>(<%=iu_nickname%>)</a></b></td>
	<%
	siteColor = ""
	    IF IB_SITE = "None" Then
	        siteColor = "bgcolor=yellow"
	        IF cStr(IB_ADMIN_CANCEL) = "1" Then
	            siteColor = "bgcolor=skyblue"
	        End IF
	    End IF 
	%>
    <td align='center' <%= siteColor %>><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_SITE&Find=<%=IB_SITE%>"><%=IB_SITE%></a></td>
    <td align="center"><%=dfgameSql1.RsCount%></td>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <%
    
    
            
        For  j = 0 to dfgameSql1.RsCount - 1
            IG_IDX		= dfgameSql1.Rs(j,"IG_IDX")
            RL_League		= dfgameSql1.Rs(j,"RL_LEAGUE")
            IG_Team1		= dfgameSql1.Rs(j,"IG_TEAM1")
            IG_Team2		= dfgameSql1.Rs(j,"IG_TEAM2")
            IG_Status		= dfgameSql1.Rs(j,"IG_STATUS")
            IG_Result		= dfgameSql1.Rs(j,"IG_RESULT")
            IG_StartTime	= dfgameSql1.Rs(j,"IG_STARTTIME")
            IG_Team1Benefit = dfgameSql1.Rs(j,"IG_TEAM1BENEFIT")
            IG_DrawBenefit	= dfgameSql1.Rs(j,"IG_DRAWBENEFIT")
            IG_Team2Benefit	= dfgameSql1.Rs(j,"IG_TEAM2BENEFIT")
            IG_Score1		= dfgameSql1.Rs(j,"IG_SCORE1")
            IG_Score2		= dfgameSql1.Rs(j,"IG_SCORE2")
            IG_Type			= dfgameSql1.Rs(j,"IG_TYPE")
            IG_Handicap		= dfgameSql1.Rs(j,"IG_HANDICAP")
            IG_Draw		    = dfgameSql1.Rs(j,"IG_DRAW")
            IBD_NUM         = dfgameSql1.Rs(j,"IBD_Num")
            IBD_RESULT      = dfgameSql1.Rs(j,"IBD_RESULT")
            IBD_RESULT_BENEFIT = dfgameSql1.Rs(j,"IBD_RESULT_BENEFIT")
            IBD_BENEFIT = dfgameSql1.Rs(j,"IBD_BENEFIT")
            IG_TEAM = dfgameSql1.Rs(j,"IG_TEAM")
            IBD_AdminDEL = dfgameSql1.Rs(j,"IBD_AdminDEL")
            


        if cStr(IG_RESULT) = "" Then
            IG_RESULT  = 9 
        End if
        'response.Write IB_IDX
        IF IG_Type = "1" Then
            txtIG_Type  = "핸디캡"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "오버/언더"  
            IG_DRAWBENEFIT =  IG_HANDICAP  
        Else
            txtIG_Type  = "승무패"    
        End IF
        
       
        IF IBD_NUM = "1" Then
            choice  = "승"    
        ElseIF IBD_NUM = "0" Then
            choice  = "무"    
        ElseIF IBD_NUM = "2" Then
            choice  = "패"    
        End IF
        
    	                    
        IF IG_TYPE = 1 Then
            IF IBD_NUM = "1" Then
                choice  = "핸승"    
            ElseIF IBD_NUM = "2" Then
                choice  = "핸패"    
            End IF            				        
        ElseIF IG_TYPE = 2 Then
            IF IBD_NUM = "1" Then
                choice  = "오버"    
            ElseIF IBD_NUM = "2" Then
                choice  = "언더"    
            End IF                                
        End IF
               

                        
        resultBgColor = "#FFFFFF"
        cssSelected2 = "class='cancelChoice'"
        IF IBD_RESULT = "0" Then    
            txtIBD_RESULT = "실패"
            cssSelected2 = "class='noChoice'"
        ElseIF IBD_RESULT = "1" Then
             txtIBD_RESULT = "<font color='#000000'><b>적중</b></font>"
             cssSelected2 = "class='Choice'"
        ElseIF IBD_RESULT = "2" Then
            txtIBD_RESULT = "<font color='000000'><b>취소</b></font>"
            cssSelected2 = "class='cancelChoice'"
        ElseIF IBD_RESULT = "3" Then
            txtIBD_RESULT = "<font color='000000'><b>특례</b></font>"
            cssSelected2 = "class='cancelChoice'"
        Else
            txtIBD_RESULT = "진행"
            cssSelected2 = "class='ingChoice'"
        End IF
        
        IF IB_SITE = "None" Then
            txtIBD_RESULT = "<font color='000000'><b>취소</b></font>"
            cssSelected2 = "class='cancelChoice'"        
        End IF
        
        IF cStr(IB_BWIN) = "1" Then
            cssSelected2 = "class='cancelChoice'" 
            choice  = IG_TEAM                    
        End IF      
          
        IF IBD_AdminDEL = "Y" Then
            choice  = "<font color='B50D0D'>취소</font>"
            cssSelected2 = "class='cancelChoice'" 
        End IF
        
        
        SCORE = IG_SCORE1 & " : " & IG_SCORE2
        
        '#### 진행 중인지 체크한다.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        
         TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)                
         TotalBenefit1= Cdbl(TotalBenefit1) * Cdbl(IBD_BENEFIT)                
            
            cellWidth = (100 / Cint(dfgameSql1.RsCount)) & "%"
            GameCnt = dfgameSql1.RsCount	                
    %>
        <td height="20" width="<%=cellWidth%>" <%= cssSelected2 %>  align="center"><%=IG_Team1%><br><%=choice%></td>
    <%
        Next
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100    
        BenefitAmount1 = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit1*100))/100    
        BenefitAmount1 = numdel2(BenefitAmount1) 
        BenefitAmount = numdel2(BenefitAmount) 
         
        resultBgColor1 = ""
        IF cDbl(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
        ElseIF cDbl(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "ingChoice"
        Else                    
            IF cDbl(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
                resultBgColor1 = "cancelChoice"
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "Winner"
            End IF                    
        End IF
                
                
        IF IB_CANCEL <> 0 Then
            totalIBD_RESULT = 4
        End IF   
        
        IF IB_SITE = "None" Then
            txtIBD_RESULT = "<font color='000000'><b>취소</b></font>"
            cssSelected2 = "class='cancelChoice'"        
            totalIBD_RESULT = 2
        End IF
                               
    %>
    </tr>
    </table>
    </td>
	<td align="right">
    <% IF cDbl(TotalBenefit) = 0  Then %>	
	<%=numdel(TotalBenefit1)%>&nbsp;
	<% Else %>
	<%=numdel(TotalBenefit)%>&nbsp;
	<% End IF %>
    </td>
	<td align="right"><%=formatnumber(IB_Amount,0)%>원&nbsp;</td>
	<td align="right">	
	<% IF cDbl(TotalBenefit) = 0  Then %>	
	<%=formatnumber(BenefitAmount1,0)%>원&nbsp;
	<% Else %>
	<%=formatnumber(BenefitAmount,0)%>원&nbsp;
	<% End IF %>
	</td>
	<td align="center"><%=dfStringUtil.GetFullDate(IB_RegDate)%></td>			
	<td align="center" bgcolor="grey"><b>	
	<% if IB_CREGER <> "" then %>
		<% if IB_ID <> IB_CREGER then %>
		관리자 취소
		<% else %>
		유저 취소
		<% end if %>
	<% else %>
		<%=txttotalIBD_RESULT(totalIBD_RESULT)%>
	<% end if %></b></td>			
	<td align="center">
	<% IF cSTr(IB_BWIN) = "1" Then %>
	<a href="Betting_List.asp?Search=IB_IDX&Find=<%=IB_Idx%>">상세보기</a>
	<% Else %>
	<a href="Betting_Detail.asp?IB_Idx=<%=IB_Idx%>&Page=<%=Page%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>">상세보기</a>
	<% End IF %>
	<br />
	<% IF cSTr(IB_BWIN) = "1" Then %>
	<a href="javascript:goDetailBwin(<%=IB_Idx%>, <%= GameCnt %>);">바로보기</a>
	<% Else %>
	<a href="javascript:goDetail(<%=IB_Idx%>, <%= GameCnt %>);">바로보기</a>
	<% End IF %>	
	</td>
<%
	siteColor = ""
	    IF IB_SITE = "None" Then
	        siteColor = "bgcolor=yellow"
	        IF cStr(IB_ADMIN_CANCEL) = "1" Then
	            siteColor = "bgcolor=skyblue"
	        End IF
	    End IF 
	%>	
	<td align="center" <%= siteColor %>>
<%
	IF request.Cookies("AdminLevel") = 1 THEN 
	    IF  IB_SIte = "None" Then	         
	        IF IB_CANCEL_DATE = "" Then
                SQLMSG = "SELECT LC_REGDATE FROM LOG_CASHINOUt WHERE IB_IDX = "& IB_IDX
			    SET RS1 = DbCon.Execute(SQLMSG)	  
			    IF NOT RS1.Eof Then  
			        Cancel_Date = Rs1("LC_REGDATE")    
			    End IF
    	    Else
    	        Cancel_Date = IB_CANCEL_DATE
	        End IF
	        response.Write dfStringUtil.GetFullDate(Cancel_Date) 
        Else
%>
            <input type="button" value="취소" style="border:1px solid;height:16px;" onclick="goBatdel(<%=IB_Idx%>);">
<%        	        
	    End IF
	END IF
%>	    
	</td>   
	<td align="center">
	<% if IB_DEL = "Y" then%>
		<font color='red'>삭제</font>
	<% ELSE %>
		<font color='black'>정상</font>
	<% END IF %>
	</td>
</tr>
<tr id="tr<%= IB_Idx %>" style="display:none;" >
    <td colspan="13" bgcolor="ffffff">
        <iframe id="iframe<%= IB_Idx %>" frameborder="0" ></iframe>
    </td>
</tr>

<%

        BenefitAmount     = 1
        BenefitAmount1     = 1
        TotalBenefit1     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5
        
    Next 
END IF
%>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
	<tr>
        <td width="80"></td>
        <td width="*">&nbsp;</td>
		
        <td align="right" width="40"><input type="reset" value="선택삭제" onclick="javascript:go_update(document.frm1,1);" class="input"></td>  
		<%if Search = "IB_ID" and Find <> "" then %>
        <td align="right" width="40"><input type="reset" value="전체삭제" onclick="javascript:go_update1('<%=Find%>');" class="input"></td>
		<% end if %>
	</tr>
</form>
<iframe name="exeFrame" id="exeFrame" width=0 height=0 frameborder=0></iframe>
</body>
</html>
