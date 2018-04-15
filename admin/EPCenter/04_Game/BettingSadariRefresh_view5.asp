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
    real_user = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("real_user")), 1, 0, 1)
    
    site = "All" 'REQUEST("JOBSITE")
     
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE"

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing


    pageSize        = 25             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting_NEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user,7)

    'dfGameSql.debug
	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
	
%>

<html>
<head>
<title>배팅 리스트</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
    <style>
    .baord_table_bg {background-color:#AAAAAA}
    .td_red_bold {background-color:#EEEEEE}
    .trIngGame {background-color:#FFFFFF}

    .noChoice {vertical-align:middle;background:red;color:#FFFFFF; border: 1px solid #838383;}
    .noChoice table {color:#FFFFFF; }
    .Choice {vertical-align:middle;background:yellow;color:#000000;border: 1px solid #838383;}
    .Choice table {color:#000000; }

    .ingChoice {vertical-align:middle;background:#aaaaaa;color:#000000;border: 1px solid #838383;}
    .ingChoice table {color:#000000; }
    
    .cancelChoice {vertical-align:middle;background:#ffffff;color:#000000;border: 1px solid #838383;}
    .cancelChoice table {color:#E9BB5B; }
        
    </style>
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
<iframe name="exeFrame" id="exeFrame" widht="0" height="0"></iframe>
<div id="aaa" style="position:absolute;left:1;top:1;width:500px;"></div>   
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="eeeeee"> 
	<!-- <td align="center" height="30" width="40"><b>선택</b></td> -->
	<td align="center" width="30"><b>번호</b></td>
	<td align="center" width="30"><b>ID</b></td>
	<td align="center" width="60"><b>사이트</b></td>
	<td align="center" width="40"><b>게임수</b></td>
	<td align="center" width="400"><b>배팅진행내역</b></td>			
	<td align="center" width="40"><b>배당율</b></td>
	<td align="center" width="90"><b>배팅액</b></td>
	<td align="center" width="90"><b>배당적중금</b></td>
	<td align="center" width="120"><b>배팅시간</b></td>		
	<td align="center" width="60"><b>결과</b></td>
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
		
 	
		
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)    
                
        IF IB_CNT = 1 Then
            strIB_TYPE = "단식"
        Else
            strIB_TYPE = "복식"
        End IF 
       
%>
<tr bgcolor="ffffff"> 
	<td align="center">
	    <%= IB_Idx %>
	</td>
	<td>&nbsp;<a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_ID&Find=<%=IB_ID%>"><%=IB_ID%>(<%=iu_nickname%>)</a></td>
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
            choice  = ig_team1    
        ElseIF IBD_NUM = "0" Then
            choice  = "무"    
        ElseIF IBD_NUM = "2" Then
            choice  = ig_team2    
        End IF
        
    	                    
        IF IG_TYPE = 1 Then
            IF IBD_NUM = "1" Then
                choice  = ig_team1    
            ElseIF IBD_NUM = "2" Then
                choice  = ig_team2  
            End IF            				        
        ElseIF IG_TYPE = 2 Then
            IF IBD_NUM = "1" Then
                choice  = ig_team1    
            ElseIF IBD_NUM = "2" Then
                choice  = ig_team2    
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
        <td height="20" width="<%=cellWidth%>" <%= cssSelected2 %>  align="center"><%=choice%></td>
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
	<td align="center" bgcolor="grey"><b><%=txttotalIBD_RESULT(totalIBD_RESULT)%></b></td>			
<!--
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
	</td>
-->
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
</form>
<iframe name="exeFrame" id="exeFrame" width=0 height=0 frameborder=0></iframe>
</body>
</html>
