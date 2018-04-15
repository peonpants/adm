<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
    <%
        Randomize 
        num = Int((8*Rnd))
        'iMod = (num mod 10)+ 1
    %>
<%

	bType = request("bType")	
	
	SQLstr="UPDATE Board_Free SET BF_HITS=BF_HITS+"&NUM&" WHERE BF_REGDATE > dateadd(hour,-4,getdate())"
	DbCon.Execute(SQLstr)
	
	
%>
<%  

    '######### Request Check                    ################	    

    
    pageSize        = 27            
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate      = Trim(dfRequest.Value("sStartDate"))
	sEndDate        = Trim(dfRequest.Value("sEndDate"))
	Search          = Trim(dfRequest.Value("Search"))
	Find            = Trim(dfRequest.Value("Find"))	
	reqBF_LEVEL        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BF_LEVEL")), 0, 0, 9) 		
	BF_SITE = Trim(request("bType"))
	IB_IDX  = Trim(request("IB_IDX"))


    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfboardSql.RetrieveBoard_Free(dfDBConn.Conn, page, pageSize,  Search, Find, sStartDate, sEndDate, reqBF_LEVEL)
    Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  1, 1, "IB_IDX", IB_IDX, sStartDate, sEndDate, "all", 0,0)

'dfboardSql.debug
	IF dfboardSql.RsCount <> 0 Then
	    nTotalCnt = dfboardSql.RsOne("TC")
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
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">

function changeLevel(BF_IDX)
    {
        BF_HITS = document.getElementById("BF_HITS" + BF_IDX).value;
        
        new Ajax.Request('ajaxHitsUpdate.asp?BF_IDX=' + BF_IDX + "&BF_HITS=" + BF_HITS ,
        {
            onFailure: function(){alert("조회수 입력 오류");} 
            ,onComplete : function(req)
            {                
               alert( req.responseText );
                                                             
            }
        }
    );   
            
    }


// 배팅번호 입력 비동기식
function changeLevel2(BF_IDX)
{
    IB_IDX = document.getElementById("IB_IDX" + BF_IDX).value;

    //alert(score + "--" + team + "--" + ig_idx);
    new Ajax.Request('ajaxIDXUpdate.asp?BF_IDX=' + BF_IDX + "&IB_IDX=" + IB_IDX ,
        {
            onFailure: function(){alert("입력 실패");} 
        }
    );    
}


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
	form.action = "Board_Delete.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>&BF_LEVEL=<%= reqBF_LEVEL %>";
	form.submit();
}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 게시판 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Board_List.asp">
<input type="hidden" name="BF_LEVEL" value="<%= reqBF_LEVEL %>"/>
<tr>
	<Td>사이트 : </td>
	<td>
		<select name="bType">
			<option value="" <%if BF_SITE = "" then Response.Write "selected"%>>모든 게시물</option>
			<option value="All" <%if BF_SITE = "All" then Response.Write "selected"%>>All</option>
			</select>
	</td>
<td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="BF_Writer" <%if Search = "BF_Writer" then Response.Write "selected"%>>작성자</option>
		<option value="BF_Title" <%if Search = "BF_Title" then Response.Write "selected"%>>글제목</option>
		<option value="BF_PW" <%if Search = "BF_PW" then Response.Write "selected"%>>아이디</option>
		<option value="BF_CONTENTS" <%if Search = "BF_CONTENTS" then Response.Write "selected"%>>글내용</option>
		<option value="IB_IDX" <%if Search = "IB_IDX" then Response.Write "selected"%>>배팅번호</option>
</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색" class="input"> 사이트명 전체 : All</td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="60%">
	<input type="reset" value="          등록          "  onclick="javascript:location.href='/EPCenter/08_Board/Board_Write.asp?BF_LEVEL=<%= reqBF_LEVEL %>';" style="border: 1 solid;width:200px;height:20px; background-color: #C5BEBD;">	
	</td>

</tr>
</table>	
<br />
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
<form name="frm1" method="post">
<tr><td align="center" height="30" bgcolor="e7e7e7"><b>선택</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>No.</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>사이트</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>제 목</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>작성자</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>작성일</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>조 회</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>배팅번호</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>상 태</b></td>
</tr>

<%	
IF dfboardSql.RsCount = 0 THEN
%>

<tr><td align="center" colspan="8" height="35">현재 등록된 게시물이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfboardSql.RsCount -1

		BF_IDX		= dfboardSql.Rs(i,"BF_IDX")
		BF_TITLE	= dfboardSql.Rs(i,"BF_TITLE")
		BF_WRITER	= dfboardSql.Rs(i,"BF_WRITER")
		BF_REGDATE	= dfboardSql.Rs(i,"BF_REGDATE")
		BF_HITS		= dfboardSql.Rs(i,"BF_HITS")
		BF_STATUS	= CDbl(dfboardSql.Rs(i,"BF_STATUS"))
		BF_LEVEL	= CDbl(dfboardSql.Rs(i,"BF_LEVEL"))
		BF_REPLYCNT	= CDbl(dfboardSql.Rs(i,"BF_REPLYCNT"))
		BF_SITE		= dfboardSql.Rs(i,"BF_SITE")
		BF_TYPE		= dfboardSql.Rs(i,"BF_TYPE")
		IB_IDX		= dfboardSql.Rs(i,"IB_IDX")
		BF_PW		= dfboardSql.Rs(i,"BF_PW")

		If BF_TYPE = "1" Then
			BF_TYPE = "[ 일 반 ]&nbsp;"
		ElseIf BF_TYPE = "2" Then 
			BF_TYPE = "[ 분 석 ]&nbsp;"	
		End If
		IF BF_LEVEL = "1" THEN
			'BF_Part = "Notice"
			BF_TYPE = ""
		ELSEIF BF_LEVEL = "2" THEN
			'BF_Part = "Event"
			BF_TYPE = ""
		ELSEIF BF_LEVEL = "3" THEN
			'BF_Part = "Event"
			BF_TYPE = ""			
		END IF	

		IF BF_ReplyCnt <> 0 THEN 
			BF_ReplyCnt = "(" & BF_ReplyCnt & ")"
		ELSE
			BF_ReplyCnt = ""
		END IF

		IF BF_Level = 1 THEN 
			BF_Level = "[공지]"
		ELSEIF BF_Level = 2 THEN 
			BF_Level = "[이벤트]"
		ELSEIF BF_Level = 3 THEN 
			BF_Level = "[흐르는공지]"			
		ELSE
			BF_Level = ""
		END IF
		
		IF BF_Status = 0 THEN
			ViewType = "숨김"
		ELSE
			ViewType = "<font color= red>노출</font>"
		END IF		

%>

<tr <% IF BF_Status <> "1" THEN Response.Write "bgcolor='#d6f7fd'"%>>
	<td align="center"><input type="checkbox" name="SelUser" value="<%=BF_Idx%>"></td>
<%
SET DbRec2=Server.CreateObject("ADODB.Recordset") 

WSQL = "SELECT a.iu_id,a.iu_nickname FROM INFO_USER  a, BOARD_FREE b WHERE a.iu_nickname = '"&BF_Writer&"'"
DbRec2.Open WSQL, DbCon

If Not DbRec2.eof Then
bf_id = dbRec2("IU_ID")
Else 
bf_id = ""
End If 


%>
	<td align="center"><%=BF_IDX%></td>
	<td align="center"><%=BF_SITE%></td>
	<a href="Board_View.asp?BF_Idx=<%=BF_Idx%>&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>">
	<td style="cursor:hand;"><font color="#000000">&nbsp;<%=BF_Level%><%=BF_TYPE%><%=BF_Title%>&nbsp;<%=BF_ReplyCnt%></font></td></a>
<% If bf_pw<>BF_ID Then %>
	<td align="center"><a href="/EPCenter/08_Board/Board_List.asp?Search=BF_Writer&Find=<%=BF_Writer%>"><b><font color="red"><%=bf_id%>&nbsp;&nbsp;(<%=BF_Writer%>)</b></font></a></td>
<% Else %>
	<td align="center"><a href="/EPCenter/08_Board/Board_List.asp?Search=BF_Writer&Find=<%=BF_Writer%>"><%=bf_id%>&nbsp;&nbsp;(<%=BF_Writer%>)</a></td>
<% End if%>
	<td align="center"><%=bf_regdate%></td>
    <td align="center">
	    <input type="text" name="BF_Hits<%= BF_IDX %>"  id="BF_Hits<%= BF_IDX %>" value="<%= BF_Hits %>" size="4" maxlength="4" class="input" onblur="changeLevel(<%= BF_IDX %>);" />
	</td>
	<td align="left"><%= IB_IDX %>&nbsp;</td>
	<td align="center"><%=ViewType%></td>
</tr>

<%  
    Next 
END IF
%>

</table><br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="60%">
	<input type="reset" value="등록"  onclick="javascript:location.href='/EPCenter/08_Board/Board_Write.asp?BF_LEVEL=<%= reqBF_LEVEL %>';" style="border: 1 solid;width:50px; background-color: #C5BEBD;">
	<input type="reset" value="삭제"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid;width:50px; background-color: #C5BEBD;"></form>	
	</td>
	<td width="40%">
	<form name="frm_dis" method="post" action="Board_disable.asp">	
	    <input type="hidden" name="mode" value="add" />	
	    <input type="text" name="BFR_WRITER" value="" />	
		<input type="button" value="게시판 사용 제재" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	</form>
	<form name="frm_dis1" method="post" action="Board_disable.asp">	
	    <input type="hidden" name="mode" value="del" />	
	    <input type="text" name="BFR_WRITER" value="" />	
		<input type="button" value="게시판 사용 해제" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	</form>	
	</td>
	</tr></table>

</body>
</html>

<%


	DbCon.Close
	Set DbCon=Nothing

%>

<%
    pageSize        = 27            
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate      = Trim(dfRequest.Value("sStartDate"))
	sEndDate        = Trim(dfRequest.Value("sEndDate"))
	Search          = Trim(dfRequest.Value("Search"))
	Find            = Trim(dfRequest.Value("Find"))	
	reqBF_LEVEL        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BF_LEVEL")), 0, 0, 9) 		
	BF_SITE = Trim(request("bType"))
	IB_IDX  = Trim(request("IB_IDX"))

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

    Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  1, 1, "IB_IDX", IB_IDX, sStartDate, sEndDate, "all", 0,0)
    site = "all" 'REQUEST("JOBSITE")
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE AND B.IU_LEVEL = 9 "

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""

		'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting_ADMINLEVEL(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, 0,0)

%>
<html>
<head>
<title>배팅 리스트</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"><font color="red">베팅시간 왼쪽의 숫자가 베팅번호입니다</font>
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="0" cellpadding="0" cellspacing="0" align="center">
</table>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

현재 등록된 배팅이 없습니다.

<%
	ELSE
%>

<%
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "낙첨"
        txttotalIBD_RESULT(1) = "당첨"
        txttotalIBD_RESULT(2) = "1배처리"
        txttotalIBD_RESULT(3) = "1배처리"
        txttotalIBD_RESULT(4) = "취소" ' 관리자 취소
        txttotalIBD_RESULT(9) = "진행중"
        

                
	FOR ii = 0 TO dfgameSql.RsCount -1
	
	    IB_ID		= dfgameSql.Rs(ii,"IB_ID")
        IB_IDX		= dfgameSql.Rs(ii,"IB_Idx")
        IB_TYPE		= dfgameSql.Rs(ii,"IB_Type")
        IG_IDX		= dfgameSql.Rs(ii,"IG_Idx")
        IB_NUM		= dfgameSql.Rs(ii,"IB_Num")
        IB_BENEFIT	= dfgameSql.Rs(ii,"IB_Benefit")
        IB_AMOUNT	= dfgameSql.Rs(ii,"IB_Amount")
        IB_STATUS	= dfgameSql.Rs(ii,"IB_Status")
        IB_REGDATE	= dfgameSql.Rs(ii,"IB_RegDate")
        
        IB_CANCEL   = dfgameSql.Rs(ii,"IB_CANCEL")
        IU_NICKNAME     = dfgameSql.Rs(ii,"IU_NICKNAME")
        	
        IB_IDX1             = 0 
        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 4: 관리자 취소,  5 : 진행중 , 9 : 진행중
        	
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)                        
%>
        
            <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4D4D4D">
                <tr bgcolor="#eeeeee">
                    <td width="12%"  align="center" > <b><%= IB_ID %>(<%= IU_NICKNAME %>)</b></td>
                    <td width="7%"  align="center" >방식</td>
                    <td width="20%"  align="center" >승(홈팀)</td>
                    <td width="5%"  align="center" >무</td>
                    <td width="20%"  align="center" >패(원정팀)</td>
                    <td width="5%"  align="center" >점수</td>
                    <td width="15%"  align="center" >배팅</td>
                    <td width="8%"  align="center" >결과</td>                    
                </tr>
<%        
        IF dfgameSql1.RsCount <> 0 Then              
            For  j = 0 to dfgameSql1.RsCount - 1
                IG_IDX		= dfgameSql1.Rs(j,"IG_IDX")
                IBD_IDX		= dfgameSql1.Rs(j,"IBD_IDX")
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
            
                IG_Result = Trim(IG_Result)
                
                df = DATEDIFF("s",now(),Cdate(IG_StartTime))

                
                IF boolBET_CANCEL2 AND CDBL(df) < 0 Then            
                    boolBET_CANCEL2 = False
                End IF     
                           
                            
                IF (IG_Status = "E") OR (IG_Status = "S") Then
                    IG_Result = 3
                End IF
                        

	            IF IG_Type <> "0" THEN 
		            IG_DrawBenefit = IG_Handicap
	            END IF
                

                
                IF IG_Type = "1" Then
                    txtIG_Type  = "핸디"   
                    IG_DRAWBENEFIT =  IG_HANDICAP
                ElseIF IG_Type = "2" Then
                    txtIG_Type  = "오/언"  
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
                

                IF IBD_RESULT = "0" Then    
                txtIBD_RESULT = "실패"
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                End IF                  
            ElseIF IBD_RESULT = "1" Then
                txtIBD_RESULT = "적중"
                
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                End IF                
            ElseIF IBD_RESULT = "2" Then '취소
                txtIBD_RESULT = "1배처리"
                IG_Result = 4
            ElseIF IBD_RESULT = "3" Then '적특
                txtIBD_RESULT = "1배처리"
                IG_Result = 4
            Else
                txtIBD_RESULT = "진행"
            End IF
            
            IF IBD_RESULT_BENEFIT = 1 Then
                txtIBD_RESULT = "1배처리"
                IG_Result = 4                    
            End IF
                
                IF IBD_RESULT_BENEFIT = 1 Then
                    txtIBD_RESULT = "1배처리"
                    IG_Result = 4                    
                End IF
                
                SCORE = IG_SCORE1 & " : " & IG_SCORE2
                
                '#### 진행 중인지 체크한다.
                IF IBD_RESULT = 9  Then
                   totalIBD_RESULT = 9 
                   IBD_RESULT_BENEFIT = IBD_BENEFIT
                End IF            
                
                TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                TotalBenefitA = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                
                'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "---" & TotalBenefit &"<br>"
            
                                            
%>  
                
                <tr bgcolor="ffffff" >
                <form name="form<%= i %>" action="Betting_Proc_new.asp" target="exeFrame">                
                <input type="hidden" name="IB_ID" value="<%= IB_ID %>" />
                <input type="hidden" name="IBD_IDX" value="<%= IBD_IDX %>" />
                <input type="hidden" name="IG_IDX" value="<%= IG_IDX %>" />
                <input type="hidden" name="IBD_NUM_ORI" value="<%= IBD_NUM %>" />
                <input type="hidden" name="IB_Amount" value="<%= IB_Amount %>" />                
                    <td align="center" ><%=dfStringUtil.GetFullDate(IG_StartTime)%></td>
                    <td align="center" ><%=txtIG_Type%></td>
                    <td align="center" <%=cssSelected1%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" ><% IF IG_TYPE = "2" Then response.Write OVER_IMAGE %><%=IG_Team1%></td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FormatNumber(IG_TEAM1BENEFIT,2) %></td>
                            </tr>
                        </table>    
                    </td>                    
                    <td style="padding-top:4;" align="center" <%=cssSelected0%>>
                        <%= dfStringUtil.getDrawValue(IG_TYPE, dfgameSql1.Rs(j,"IG_DRAWBENEFIT") ,dfgameSql1.Rs(j,"IG_HANDICAP")) %>
                    </td>
                    <td align="center" <%=cssSelected2%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td align="left" width="71" style="padding-left:4" align="center" ><%= FormatNumber(IG_TEAM2BENEFIT,2) %></td>
                                <td width="80%" align="right"width="71" style="padding-right:4" align="center" ><%=IG_Team2%><% IF IG_TYPE = "2" Then response.write UNDER_IMAGE %></td>
                            </tr>
                        </table>                       
                    </td>                   
                    <td style="padding-top:4;" align="center" ><%=SCORE%></td>
                    <td style="padding-top:4;" align="center">
                    <select name="IBD_NUM">
                        <option value="1" <% IF cStr(IBD_NUM) = "1" Then %>selected<% End IF %>>승</option>
                        <option value="0" <% IF cStr(IBD_NUM) = "0" Then %>selected<% End IF %>>무</option>
                        <option value="2" <% IF cStr(IBD_NUM) = "2" Then %>selected<% End IF %>>패</option>
                    </select>                    
                    <select name="IBD_RESULT">
                        <option value="1" <% IF cStr(IBD_RESULT) = "1" Then %>selected<% End IF %>>적중</option>
                        <option value="0" <% IF cStr(IBD_RESULT) = "0" Then %>selected<% End IF %>>실패</option>
                    </select>                                        
                    <input type="text" name="IBD_RESULT_BENEFIT" value="<%= IBD_RESULT_BENEFIT %>" size="4" />
                    </td>
                    <td style="padding-top:4;" align="center" >                    
                        <input type="submit" value="<%=txtIBD_RESULT%>" />
                    </td>                    
                </form>                    
                </tr>
<%                            
		    Next
        End IF
        
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmountA = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmount = numdel2(BenefitAmount)
        BenefitAmountA = numdel2(BenefitAmountA)
        IF cInt(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
            resultBgColor1 = "Cancel"
        ElseIF cInt(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "Looser"
        Else                    
            IF cInt(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
                resultBgColor1 = "noSelected"
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "Winner"
            End IF                    
        End IF
                
                
        IF IB_CANCEL <> 0 Then
            totalIBD_RESULT = 4
            resultBgColor1 = "failGame"
        End IF 
        
        
        
%>
    <form name="form111<%= i %>" action="Betting_Proc_new.asp" target="exeFrame">
    <input type="hidden" name="IB_IDX" value="<%= IB_IDX %>" />
                <tr bgcolor="#eeeeee">
                    <td colspan="6">
                        <table width="100%">
                        <tr>
                            <td>
                                <b style="font-size:15px"><font color="red">베팅번호 :
                                <%= IB_IDX %></font></br></b><input type="text" name="IB_REGDATE" value="<%=dfStringUtil.GetFullDate(IB_REGDATE)%>" />
                            </td>
                            <td>
                                배팅금액 : <B style='color:red'><%=FORMATNUMBER(IB_Amount,0)%></B> 원
                            </td>
                            <td>
                                배당률 : <B style='color:red'><%= FORMATNUMBER(TotalBenefit,2) %></B>
                            </td>                            
                            <td>
                                예상 적중금 :<B style='color:red'> <%= FORMATNUMBER(BenefitAmountA,0) %></B> 원
                            </td>                                                        
                            <td>
                                적중금액 : <B style='color:red'><%= FORMATNUMBER(BenefitAmount,0) %></B> 원
                            </td>                                                                                    
                        </tr>
                        </table>
                    </td>
                    <td  class="<%= resultBgColor1 %>" style="padding-top:4;" align="center" >
                    <%=txttotalIBD_RESULT(totalIBD_RESULT)%>&nbsp;
                    </td>
                    <td align="center">
                        <input type="submit" value="시간수정" />                        
                    </td>
                </tr>
</form>                
                </table>
                
                <div style="height:5px;"></div>
<%         

        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5
           
	Next 

		
END IF
%>


<br clear="all">
<table width="100%">
<tr>
    <td align="center">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
</td>
</tr>
</table>


</body>
</html>
