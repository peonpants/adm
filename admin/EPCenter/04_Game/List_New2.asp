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
    page        = Trim(dfRequest("page"))
	SRL_League  = Trim(dfRequest("SRL_League"))
	SRS_Sports  = Trim(dfRequest("SRS_Sports"))
	SFlag       = Trim(dfRequest("SFlag"))	
	Search      = Trim(dfRequest("Search"))
	Find        = Trim(dfRequest("Find"))
    IG_Type = REQUEST("IG_Type")
	
    IF SFlag = "" Then
        SFlag = "E"
    End IF

	
	IF IG_Type = "" Then
	    IG_Type =  9 
	End IF
	
	'##### 페이징 처리를 위한 변수 지정  ###############
    IF SFlag = "S"	Or SFlag = "E" Then
        pageSize        = 100
    Else
        pageSize        = 50        
    End IF        
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
    'GSITE = "aaaa"
	Call dfgameSql.RetrieveInfo_Game(dfDBConn.Conn,  page, pageSize, SRS_Sports, SRL_League, SFlag, Search, Find, GSITE, IG_Type)
    'dfgameSql.debug
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
<title>새로운 게임등록</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<script type="text/javascript" id="jsLiveScore" src="liveScore.js.asp?ver=<%= dfStringUtil.GetFullDate(now()) %>"></script>
<script type="text/javascript">
function goGameEnd(IG_IDX)
{
    IG_SCORE1 = document.getElementById("IG_SCORE1_" + IG_IDX).value ;
    IG_SCORE2 = document.getElementById("IG_SCORE2_" + IG_IDX).value ;
    if(IG_SCORE1 == "" ||  IG_SCORE2 == "" ) 
    {
        alert("스코어 입력이 잘못되었습니다.");
        return;
    }        
    window.open("GameResultPrevew_New.asp?IG_IDX=" + IG_IDX);
}
var STATE_ARR = ["", "전반전", "하프타임", "후반전", "경기종료", "Pause", "Cancel", "Extra", "Extra", "Extra", "120 Minutes", "Pen", "Finished", "Postponed", "Cut", "Undecided", "Gold", ""];

function showLiveScore(I7_IDX, IG_IDX)
{
    
    if(typeof(sDt2[I7_IDX]) != "object") return;
    scoreArray = sDt2[I7_IDX] ;
    
    formName = "gameEditForm" + IG_IDX
    
    document.getElementById(formName).IG_SCORE1.value = scoreArray[1] ;
    document.getElementById(formName).IG_SCORE2.value = scoreArray[2] ;
    
    document.getElementById("status" + IG_IDX).innerHTML = STATE_ARR[scoreArray[0]]
    
    if(scoreArray[0] < 4 && scoreArray[0] > 0 )
    {
        setScore(scoreArray[1], 1, IG_IDX);
        setScore(scoreArray[2], 2, IG_IDX);
    }    
}    
</script>
<script type="text/javascript">
function searchfrm()
{
    var frm = document.frm1;
    location.href = "List_New.asp?Search="+frm.Search.value+"&Find="+frm.Find.value;
}

function new_win(link)
{
	if(link!="#") location.href = ""+link+"";	
}
	
function Move()
{
    if (event.keyCode == 13)
    {
        searchfrm();
        return false;
    } 
    else 
        return false;
}
function BetList(URL) 
{
	window.open(URL, 'BetList', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=500,height=500'); 
}
//전체선택 / 전체 해제 
function SelectCheckBox()
{
    var checkboxContainer = document.getElementById("Table2");
    var inputs = checkboxContainer.getElementsByTagName('input');    
    var chek = document.getElementById("Table2_SelectAllCheckbox").checked
          
        for (var i = 0; i < inputs.length; i++)
        {
            inputs.item(i).checked = chek;
        }           
}
//선택된 항목 종류에 따라 처리
function go_proc(mode) 
{
	var v_cnt = 0;
	var v_data = "";
	
	var checkboxContainer = document.getElementById("Table2");
	var inputs = checkboxContainer.getElementsByTagName('input');
	
	for( var i=0; i<inputs.length; i++) 
	{
		var ele = inputs.item(i);
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
	if(mode == "start") modeTxt = "시작"; 
	if(mode == "end") modeTxt = "마감"; 
	if(mode == "del") modeTxt = "삭제"; 
			
	if (v_cnt == 0) 
	{ 
		alert(modeTxt + "할 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	procForm.mode.value = mode; 
	procForm.v_data.value = v_data; 

	if (!confirm("정말 "+ modeTxt +"하시겠습니까?")) return;		
	procForm.action = "GameStatus_Proc.asp?page=<%=Page%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	procForm.submit();	
}
// 게임 정보를 바꾼다	
function checkGameEditInfoForm(form)
{
    form.action = "Game_Edit_Proc_New.asp?mode=info";
}

// 게임의 스코어값을 비동기식으로 바꾼다. 페이지 로딩 없음
function setScore(score, team, ig_idx)
{
    //alert(score + "--" + team + "--" + ig_idx);
    new Ajax.Request('gameScore_Proc.asp?score=' + score + '&team=' + team + "&ig_idx=" + ig_idx ,
        {
            onFailure: function(){alert("스코어 입력 실패");} 
        }
    );    
}

function openInsertResult(idx,pg,rs,rl) 
{
	var openUrl = "Insert_Result.asp?IG_Idx="+idx+"&page="+pg+"&SRS_Sports="+rs+"&SRL_League="+rl+"&SFlag=<%=SFlag%>&new=1";
	window.open(openUrl, '','left=400,top=400,width=400,height=300,0,0,0,0');
}
// 정산처리(F)전에...게임의 배당율을 수정...
function goGameEdit(gidx) 
{
	var ss = "<%=SRS_Sports%>";
	var sl = "<%=SRL_League%>";
	var fg = "<%=SFlag%>";
	var pg = "<%=Page%>";
	
	var openUrl = "Game_Edit.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
	window.open(openUrl, 'gameEdit','left=400,top=400,width=600,height=300,0,0,0,0');
}

// 게임결과를 잘못입력했을경우...정산 처리후 이므로...단순한 결과만 변경가능...
function goGameEdit1(gidx) 
{
	var ss = "<%=SRS_Sports%>";
	var sl = "<%=SRL_League%>";
	var fg = "<%=SFlag%>";
	var pg = "<%=Page%>";
	
	var openUrl = "Game_Result_Edit.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
	window.open(openUrl, 'gameEdit','left=600, top=50,width=600,height=300,0,0,0,0');
}
function gong(gidx){
			var ss = "<%=SRS_Sports%>";
			var sl = "<%=SRL_League%>";
			var fg = "<%=SFlag%>";
			var pg = "<%=Page%>";
			var openUrl = "Game_Edit_go.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
			window.open(openUrl, 'gong','left=400,top=400,width=600,height=300,0,0,0,0');			
		}	
function goGameCancel(gidx) 
{
	if (!confirm("정말 취소하시겠습니까?\n\n취소시 해당 배팅에 대한 환불처리가 이루어 집니다.")) return;		
	top.HiddenFrm.location.href="Game_Cancel_Proc.asp?IG_Idx="+gidx;
}		
</script>
<style>
.input_box1 { border: 1 solid; background-color: #C5BEBD;color:#000000 }
</style>
</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
<form name="procForm" method="post">
<input type="hidden" name="mode" />
<input type="hidden" name="v_data" />
</form>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  게임관리 ▶ 게임리스트</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<form name="frm1" method="get">
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
  <tr>
    
    <td width="80" bgcolor="e7e7e7" align="center">
	  <b>타입</b>
	</td>
	<td width="110" align="center">
	  <select name="IG_TYPE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List_New.asp?SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=9" <% IF IG_TYPE = "" THEN Response.write "SELECTED" %>>:: 전체타입 ::</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=0" <% IF cStr(IG_TYPE) = "0" THEN Response.write "SELECTED" %>>프로토</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=1" <% IF cStr(IG_TYPE) = "1" THEN Response.write "SELECTED" %>>핸디</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=2" <% IF cStr(IG_TYPE) = "2" THEN Response.write "SELECTED" %>>오버</option>

      </select>
	</td>  
	
    <td width="80" bgcolor="e7e7e7" align="center" >
	  <b>종목</b>
	</td>
	<td width="110" align="center">
	  <select name="SRS_Sports" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List_New.asp?SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRS_Sports = "" THEN Response.write "SELECTED" %>>:: 전체종목 ::</option>
	      <%
		    SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
		    SET RS = Server.CreateObject("ADODB.Recordset")
		      RS.Open SQLR, DbCon, 1

		      RSCount = RS.RecordCount

		    FOR a =1 TO RSCount
		
		      RLS = RS(0) 
	      %>
	    <option value="List_New.asp?SRS_Sports=<%=RLS%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRS_Sports = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	      <%	
		    RS.movenext
		    NEXT
		
		    RS.Close
		    Set RS=Nothing	
		  %>
      </select>
	</td>



	<td width="80" bgcolor="e7e7e7" align="center">
	  <b>리그</b>
	</td>
	<td width="210" align="center">
	  <select name="SRL_League" style="width:200px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRL_League = "" THEN Response.write "SELECTED"%>>:::::::::::::: 전체리그 ::::::::::::::</option>
	    <%	
		  IF SRS_Sports = "" THEN
		    SQLMSG = " RL_STATUS = 1 "
		  ELSE
		    SQLMSG = " RL_SPORTS = '"& SRS_Sports & "' "
		  END IF

		  SQLR = "SELECT RL_LEAGUE FROM Ref_League WHERE "& SQLMSG &" Order By RL_LEAGUE"
		    SET RS = Server.CreateObject("ADODB.Recordset")
		  RS.Open SQLR, DbCon, 1

		  RSCount = RS.RecordCount

		  FOR a =1 TO RSCount
		
		  RLS = RS(0) 
		%>
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=RLS%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRL_League = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	      <%	
		    RS.movenext
		    NEXT
		
		    RS.Close
		    Set RS=Nothing	
	      %>
      </select>
	</td>
    <td width="80" bgcolor="e7e7e7" align="center">
	  <b>진행</b>
	</td>
	<td width="110" align="center">
	
	  <select name="SFlag" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=All&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "" THEN Response.write "SELECTED" %>>:: 전체상황 ::</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=R&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "R" THEN Response.write "SELECTED" %>>&nbsp;게임등록&nbsp;</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=S&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "S" THEN Response.write "SELECTED" %>>&nbsp;배 팅 중&nbsp;</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=E&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "E" THEN Response.write "SELECTED" %>>&nbsp;배팅마감&nbsp;</option>
	    <!--<option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=D&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "P" THEN Response.write "SELECTED" %>>&nbsp;적중특례&nbsp;</option>	-->  	    
	    <!--<option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=P&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "P" THEN Response.write "SELECTED" %>>&nbsp;정산중&nbsp;</option>	    -->
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=F&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "F" THEN Response.write "SELECTED" %>>&nbsp;정산종료&nbsp;</option>
	    <option value="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=C&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "C" THEN Response.write "SELECTED" %>>&nbsp;게임취소/적중특례&nbsp;</option></select></td>
	<td width="80" bgcolor="e7e7e7" align="center">
	  <b>검색</b>
	</td>
	<td>
	  <select name="Search" style="width:110px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="RL_LEAGUE" <%if Search = "RL_LEAGUE" then Response.Write "selected"%>>리그</option>
		<option value="TEAM" <%if Search = "TEAM" then Response.Write "selected"%>>팀명</option>
      </select>
	</td>
	<td>
	  <input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input" >
	</td>
	<td>
	  <input type="button" class="input_box1"  value="검 색" onclick="searchfrm()">
	</td>
    <td align="center" bgcolor="e7e7e7" width="100">
	  <%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" class="input_box1"  value="엑셀저장" onclick="location.href='List_Excel.asp?RS_Sports=<%=Sel_Sports%>&RL_League=<%=Sel_League%>&Flag=<%=SFlag%>';"  id=button1 name=button2><% END IF %>
	</td>
  </tr>
</table>
</form>
<table>
  <tr>
    <td> * 
	  <a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=R"><img src="/img/btn/btn_r_on.gif" style="border:0;width:15px;" align="absmiddle" style="cursor:hand;">:게임등록 </a>/ 
	  <a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=S"><img src="/img/btn/btn_s_on.gif" style="border:0;width:15px;" align="absmiddle" style="cursor:hand;">:배팅가능</a> / 
	  <a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=E"><img src="/img/btn/btn_e_on.gif" style="border:0;width:15px;" align="absmiddle" style="cursor:hand;">:배팅마감 </a>/ 
	  <a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=F"><img src="/img/btn/btn_f_on.gif" style="border:0;width:15px;" align="absmiddle" style="cursor:hand;">:정산마감 </a> /
	  <!--<a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=P"><strong>P</strong>:정산중</a>/-->
	  <a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=C"><strong>C</strong>:게임취소/적중특례</a>
	  <!--<a href="List_New.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=D"><strong>D</strong>:적중특례</a>-->
	</td>
  </tr>
</table>

<div style="color:red">축구 게임의 경우 체크 박스 및 리그 클릭시 스코어를 가지고 옵니다.</div>

<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <a name="111"></a>
	    <input type="reset" class="input_box1" value="시작"  onclick="javascript:go_proc('start');" >&nbsp;
	    <input type="button" class="input_box1"  value="등록" onclick="window.location='Regist.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&page=<%=Page%>';" >&nbsp;
	    <input type="reset" class="input_box1" value="정산마감"  onclick="javascript:go_proc('end');" >&nbsp;
	    <input type="reset" class="input_box1" value="삭제"  onclick="javascript:go_proc('del');" >
    </td>
  </tr>
</table>
<% END IF %>
<table border="0" cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%" id="Table2">
  <tr bgcolor="#CCCCCC"> 
	<td align="center" height="25">
        <input type="checkbox" id="Table2_SelectAllCheckbox" onclick="SelectCheckBox();" />
	</td>
	<td align="center">리그명</td>
	<td align="center">경기시간</td>
	<td align="center">타입</td>
	<td align="center">홈팀</td>
	<td align="center">홈배당</td>
	<td align="center">무배당</td>
	<td align="center">기준치</td>
	<td align="center">원정배당</td>
	<td align="center">원정팀</td>	
	<td align="center">홈-점수</td>
	<td align="center">원정-점수</td>	
	<td align="center">상태</td>
	<td align="center">정보</td>
	<td align="center">정산하기</td>
	<td align="center">취소</td>	
	<td align="center">공지</td>	
  </tr>
  <%
  
    IF dfgameSql.RsCount <> 0 THEN
	  FOR i = 0 TO dfgameSql.RsCount -1
		

		IG_IDX			= dfgameSql.Rs(i,"IG_IDX")
		RL_LEAGUE		= dfgameSql.Rs(i,"RL_LEAGUE")
		RL_IMAGE		= dfgameSql.Rs(i,"RL_IMAGE")
		RL_IMAGE		= "<img src='/UpFile/League/" & RL_IMAGE & "' width='20' height='14' style='border:1px solid;' align='absmiddle'>"
		IG_STARTTIME	= dfStringUtil.GetFullDate(dfgameSql.Rs(i,"IG_STARTTIME"))		
		IG_TEAM1		= dfgameSql.Rs(i,"IG_TEAM1")
		IG_TEAM2		= dfgameSql.Rs(i,"IG_TEAM2")
		IG_HANDICAP		= CDbl(dfgameSql.Rs(i,"IG_HANDICAP"))
		IG_TEAM1BENEFIT = dfgameSql.Rs(i,"IG_TEAM1BENEFIT")
		IG_DRAWBENEFIT	= dfgameSql.Rs(i,"IG_DRAWBENEFIT")
		IG_TEAM2BENEFIT = dfgameSql.Rs(i,"IG_TEAM2BENEFIT")
		IG_TEAM1BETTING = dfgameSql.Rs(i,"IG_TEAM1BETTING")
		IG_DRAWBETTING	= dfgameSql.Rs(i,"IG_DRAWBETTING")
		IG_TEAM2BETTING	= dfgameSql.Rs(i,"IG_TEAM2BETTING")
		IG_SCORE1		= dfgameSql.Rs(i,"IG_SCORE1")
		IG_SCORE2		= dfgameSql.Rs(i,"IG_SCORE2")
		IG_RESULT		= Trim(dfgameSql.Rs(i,"IG_RESULT"))
		IG_STATUS		= dfgameSql.Rs(i,"IG_STATUS")
		IG_TYPE			= dfgameSql.Rs(i,"IG_TYPE")
		IG_VSPOINT		= dfgameSql.Rs(i,"IG_VSPOINT")
		IG_MEMO			= dfgameSql.Rs(i,"IG_MEMO")
		IG_SITE			= dfgameSql.Rs(i,"IG_SITE")
		IG_SP			= dfgameSql.Rs(i,"IG_SP")
		I7_IDX			= dfgameSql.Rs(i,"I7_IDX")
		II_STATUS			= dfgameSql.Rs(i,"II_STATUS")

        tdColor = "" 
	    if IG_SP = "Y" Then tdColor = "8cafda" 

        color = "#EEEEEE"
        If i Mod 2 = 0 Then color = "#FFFFFF"
        	    
		IF IG_RESULT = "0" THEN
			GameResult = " "
		ELSEIF IG_RESULT = "1" THEN
			GameResult = "홈팀승"
		ELSEIF IG_RESULT = "2" THEN
			GameResult = "원정팀승"
		END IF	

	    IF IG_TYPE = "2" THEN 
		    VIEWCAP = "오/언"
		    VIEWTDCOLOR = "ffff00"
	    ELSEIF IG_TYPE = "1" THEN 
		    VIEWCAP = "핸디캡"
		    VIEWTDCOLOR = "ffff00"
        Else			    
            VIEWCAP = "승무패"
            VIEWTDCOLOR = "ffffff"
	    END IF	
    %>
  <tr bgcolor="<%=color%>">
  <form name="gameEditForm<%= IG_IDX %>" id="gameEditForm<%= IG_IDX %>" method="post" target="exeFrame">
  <input type="hidden" name="IG_IDX" value="<%=IG_IDX%>" />
    <td align="center">
        <%
            response.Write II_STATUS           
        %>    
        <%
            IF SFlag = "E" THEN 
                IF IG_TEAM1BETTING + IG_TEAM2BETTING + IG_DRAWBETTING = 0 Then
        %>
            <input type="checkbox" name="SelUser" value="<%=IG_IDX%>"  <% IF I7_IDX <> "" And dfStringUtil.GetFullDate(IG_StartTime) > now() Then %> style="cursor:pointer" onclick="showLiveScore(<%= I7_IDX %>, <%= IG_IDX %>);"<% End IF %>/>
        <% 
                End IF
            Else
        %>
            <input type="checkbox" name="SelUser" value="<%=IG_IDX%>"  <% IF I7_IDX <> "" And dfStringUtil.GetFullDate(IG_StartTime) > now() Then %> style="cursor:pointer" onclick="showLiveScore(<%= I7_IDX %>, <%= IG_IDX %>);"<% End IF %>/>
        <% End IF %>        
    </td>
	<td bgcolor="<%= tdColor %>" <% IF I7_IDX <> "" And dfStringUtil.GetFullDate(IG_StartTime) > now() Then %> style="cursor:pointer" onclick="showLiveScore(<%= I7_IDX %>, <%= IG_IDX %>);"<% End IF %>>
	<%=RL_LEAGUE%>
	<span id="status<%= IG_IDX %>"></span>
	</td>
	<td align="center">
	    <input type="text"  class="input4" name="IG_STARTTIME" value="<%=IG_STARTTIME%>" size="17" />
	</td>
	<td bgcolor="<%= VIEWTDCOLOR %>">
	<%= VIEWCAP%>
	</td>
	<td>
	    <input type="text"  class="input4" name="IG_TEAM1" value="<%=IG_TEAM1%>" size="15"  />
	</td>
	<td>
	    <input type="text"  class="input4" name="IG_TEAM1BENEFIT" value="<%=IG_TEAM1BENEFIT%>" size="4" /><br />
	    <a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=1');"><font color=red><%=formatnumber(IG_TEAM1BETTING,0)%>원</font></a>
	    
	</td>			
	<td align="center">
	    <input type="text" class="input4" name="IG_DRAWBENEFIT" value="<%=IG_DRAWBENEFIT%>" size="4" /><br />
	    <a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=0');"><font color=red><%=formatnumber(IG_DRAWBETTING,0)%>원</font></a>
    </td>
    <td align="center" valign="top">    
    	<input type="text" class="input4" name="IG_HANDICAP" value="<%=IG_HANDICAP%>" size="4" />
    </td>
	<td>
	    <input type="text"  class="input4" name="IG_TEAM2BENEFIT" value="<%=IG_TEAM2BENEFIT%>" size="4" /><br />
	    <a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=2');"><font color=red><%=formatnumber(IG_TEAM2BETTING,0)%>원</font></a>
	</td>	
	<td>
	    <input type="text"  class="input4" name="IG_TEAM2" value="<%=IG_TEAM2%>" size="15" />
	</td>    		
	<td align="center"><input type="text" value="<%=IG_SCORE1%>" name ="IG_SCORE1" maxlength = "3" size="2" class="input1" onblur="setScore(this.value, 1, <%= IG_IDX %>);" /></td>
	<td align="center"><input type="text" value="<%=IG_SCORE2%>" name="IG_SCORE2" maxlength="3" size="2" class="input1" onblur="setScore(this.value,2,<%= IG_IDX %>);" /></td>	
	<td align="center">
	  <select name="IG_STATUS">
	    <option value="R" <% IF IG_STATUS = "R" THEN %>selected<% End IF %>>게임등록</option>
	    <option value="S" <% IF IG_STATUS = "S" THEN %>selected<% End IF %>>배팅시작</option>
	    <option value="E" <% IF IG_STATUS = "E" THEN %>selected<% End IF %>>배팅마감</option>
	    <!--<option value="F" <% IF IG_STATUS = "P" THEN %>selected<% End IF %>>정산중</option>-->
	    <option value="F" <% IF IG_STATUS = "F" THEN %>selected<% End IF %>>정산마감</option>
	    <option value="C" <% IF IG_STATUS = "C" THEN %>selected<% End IF %>>취소/적특</option>	    
	  </select> 
	</td>	
	<td align="center"><input type="submit" value="수정"  class="input_box1" onclick="checkGameEditInfoForm(this.form);" /></td>
	<td align="center" width="40">
	<%
	    'IF IG_STATUS = "F" OR IG_STATUS = "D" OR IG_STATUS = "C" Then
	%>
        <input type="button" class="input_box1"  value="정산하기" style="border:1px solid;" onclick="openInsertResult(<%=IG_IDX%>,<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');">  
    <%
        'End IF
    %>      
	</td>
	
	<td align="center" width="40">
	    <%IF request.Cookies("AdminLevel") = 1 THEN %>
	      <% IF IG_STATUS = "E" Or IG_STATUS = "P"   THEN %>
		    <input type="button" class="input_box1"  value="취소" style="border:1px solid;" onclick="goGameCancel(<%=IG_IDX%>);">
	      <% ELSE %>
		    &nbsp;
	      <% END IF %>
	    <% ELSE %>
	      불가
        <% END IF %>
	</td>
	<td align="center" width="40">
	  <%IF request.Cookies("AdminLevel") = 1 THEN %>
	      <% IF IG_STATUS = "R" OR IG_STATUS = "S" OR IG_STATUS = "P" THEN %>
		    <input type="button" class="input_box1"  value="공지" style="border:1px solid;" onclick="goGameEdit(<%=IG_IDX%>);">
	      <% ELSEIF IG_STATUS = "F" THEN %>
		    <input type="button" class="input_box1"  value="공지" style="border:1px solid;" onclick="goGameEdit1(<%=IG_IDX%>);">
	      <% ElseIf IG_STATUS = "E" Then %>
		    <input type="button" class="input_box1"  value="공지" style="border:1px solid;" onclick="gong(<%=IG_IDX%>);">
	      <% ELSE %>
		    불가
	      <% END IF %>
	  <% ELSE %>
		불가
	  <% END IF %>
	</td>		
  </form>	
  </tr>
  <%      	
	Next 
   %>
		
   <% END IF %>
 </table>
 
 <br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <a name="111"></a>
	    <input type="reset" class="input_box1" value="시작"  onclick="javascript:go_proc('start');" >&nbsp;
	    <input type="button" class="input_box1"  value="등록" onclick="window.location='Regist.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&page=<%=Page%>';" >&nbsp;
	    <input type="reset" class="input_box1" value="정산마감"  onclick="javascript:go_proc('end');" >&nbsp;
	    <input type="reset" class="input_box1" value="삭제"  onclick="javascript:go_proc('del');" >
    </td>
  </tr>
  <tr>
    <td>
	  <form name="frm_xls" method="post" action="Game_Xls.asp?IG_SITE=All" enctype="multipart/form-data">
		<input type="file" name="xls" >
		<input type="button" class="input_box1"  value="경기등록" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	  </form>
    </td>
  </tr>
</table>
<% END IF %>
<a href="#top">맨 위로</a>
</body>
</html>
