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

<%'==========================================================================================  홍 수정 ===========
' 수정일시 : 2017-08-07  완료
' 수 정 자 : 홍실장
'
' * 작업내용 :  체크박스를 만들어 일괄등록 구현, 핸디 일괄선택버튼, 오/언 일괄선택버튼
' * 기존 개별 버튼을 없애고 선택등록 버튼을 만듬
'
' 이하 수정내용
' line 30~ 93 추가 : 전체선택 체크박스용  Jquery
' line 260 <div> 추가 <--- 전체선택에 있어서 중요
' line 262 추가 :  새로 <form 을 만들고 넘겨주는페이지를 변경함  <form name="allFM" method="post" action="Game_7mRegist_ProcAll.asp" >
'
' <<<<<<<<<<<<<<<<<<<<<<<<<<< Game_7mRegist_ProcAll.asp 페이지 새로 만듬 >>>>>>>>>>>>>>>>>>>>>
'
' line 285 ~ 288 : 전체선택 체크박스 수정
' line 373 ~ 	' 기존  <input name에 <%= ii % > 추가해줌
' line 411 '아래 input 에 class="CheckBoxHandy" 추가
' line 442 '아래 input 에 class="CheckBoxOverUnder" 추가
' line 468 ~ 476 내용 수정 버튼 없애고 체크박스로 대체 & 기존에 있던 <form> 삭제
' line 470 		<input type="CheckBox" Class="CheckBoxRegist" name="chkb" value="<%= ii % >" > 체크박스 추가해줌
' line 493 ~ 494 </form></div> 추가
'  * 버그테스트를 하였으나 혹시모를 버그가 있을수 있음
'
' 추가수정 line 424~, 454~ 핸디캡 언오버 기본배당 1.88로 수정
'==========================================================================================  홍 수정 ===========%>
<%'================================================================================= 홍 추가 %>
<script src="/js/jquery-1.4.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

        $(document).ready(function() {
            //[1] 전체선택 체크박스 클릭시

        $('#chkAllHandy').click(function() {
                // 상위 Div 에 포함되어져 있는 모든 체크박스를 가져옴

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxHandy');

                // chkAll 체크되어져 있다면, "전체선택" -> "선택해제"
                if (this.checked) {
                    $(this).next().text("선택해제"); // <em>의 텍스트 "선택해제"로 변경
                    $checkboxes.attr('checked', 'true'); // 모든 체크박스에 checked속성을 추가
                }
                else {
                    $(this).next().text('전체선택');
                    $checkboxes.attr('checked', '');
                }
            });
        });
        $(document).ready(function() {
            //[1] 전체선택 체크박스 클릭시

        $('#chkAllOverUn').click(function() {
                // 상위 Div 에 포함되어져 있는 모든 체크박스를 가져옴

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxOverUnder');

                // chkAll 체크되어져 있다면, "전체선택" -> "선택해제"
                if (this.checked) {
                    $(this).next().text("선택해제"); // <em>의 텍스트 "선택해제"로 변경
                    $checkboxes.attr('checked', 'true'); // 모든 체크박스에 checked속성을 추가
                }
                else {
                    $(this).next().text('전체선택');
                    $checkboxes.attr('checked', '');
                }
            });
        });
        $(document).ready(function() {
            //[1] 전체선택 체크박스 클릭시

        $('#chkAllRegi').click(function() {
                // 상위 Div 에 포함되어져 있는 모든 체크박스를 가져옴

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxRegist');

                // chkAll 체크되어져 있다면, "전체선택" -> "선택해제"
                if (this.checked) {
                    $(this).next().text("선택해제"); // <em>의 텍스트 "선택해제"로 변경
                    $checkboxes.attr('checked', 'true'); // 모든 체크박스에 checked속성을 추가
                }
                else {
                    $(this).next().text('전체선택');
                    $checkboxes.attr('checked', '');
                }
            });
        });
    </script>
<%'================================================================================= 홍 추가 %>


<%

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    reqType            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("type")), 0, 0, 2)     
    reqLang            = Trim(dfRequest.Value("lang"))
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
    pageSize        = 150
    reqLang = "kr"
	'######### 배팅 리스트를 불러옴                 ################	
    IF reqLang = "kr" Then
	    Call dfgameSql.RetrieveINFO_7M_kr(dfDBConn.Conn,page, pageSize, reqType)
    Else
        Call dfgameSql.RetrieveINFO_7M(dfDBConn.Conn)
    End IF	    
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
	objPager.PageButtonCount = 10
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
<title>7m 게임 리스트</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
</head>


<script type="text/javascript">
function checkFormGame(form)
{
    var txtConfirm1 = txtConfirm = "";
    if(form.IG_TEAM1BENEFIT.value == "")
    {
        IG_TEAM1BENEFIT = (form.I7_C_TEAM1BENEFIT.value != "") ? form.I7_C_TEAM1BENEFIT.value : form.I7_TEAM1BENEFIT.value ;
        form.IG_TEAM1BENEFIT.value = IG_TEAM1BENEFIT; 
    }      
    if(form.IG_DRAWBENEFIT.value == "")
    {
        IG_DRAWBENEFIT = (form.I7_C_DRAWBENEFIT.value != "") ? form.I7_C_DRAWBENEFIT.value : form.I7_DRAWBENEFIT.value ;            
        form.IG_DRAWBENEFIT.value = IG_DRAWBENEFIT; 
    }        
    if(form.IG_TEAM2BENEFIT.value == "")
    {
        IG_TEAM2BENEFIT = (form.I7_C_TEAM2BENEFIT.value != "") ? form.I7_C_TEAM2BENEFIT.value : form.I7_TEAM2BENEFIT.value ;            
        form.IG_TEAM2BENEFIT.value = IG_TEAM2BENEFIT;   
    }        
    if(form.IG_Type02.checked)
        txtConfirm1 += "핸디캡"
    if(form.IG_Type03.checked)
        txtConfirm1 += " 오버언더"   
                 
    if(txtConfirm1 != "")
        txtConfirm = "(" + txtConfirm1 + " 포함 ) "
        
    var rtn = confirm("적용하시겠습니까?" + txtConfirm) ;
    if(!rtn)
    {
        return false;   
    }
       
}
       
    function getBenefit(BF)       
    {
        //BF = parseInt(BF,10);
        var min ;
        if(BF < 1.3)
            min = 0.01
        else if(BF >= 1.3 && BF < 1.4)
            min = 0.02
        else if(BF >= 1.4 && BF < 1.6)
            min = 0.03
        else if(BF >= 7 && BF < 8)                        
            min = 1                    
        else if(BF >= 8)                        
            min = 1.5
        else
            min = 0 
                  
        return (BF-min).toFixed(2);                        
    }
    function gameList()
    {
        window.open("/EPCenter/04_Game/List.asp?SRS_Sports=&SRL_League=&SFlag=R");
    }  
    
    function showHideLayer(divID)
    {
        var dis = document.getElementById(divID).style.display == "none" ? "block" : "none" ;
        document.getElementById(divID).style.display = dis ;
    }
    
    function goList(type)
    {        
        location.href = "Game_7mList.asp?type=" + type
    }
    
    function goHTML()
    {
        window.open("Game_7mListHtml.asp")
    }
</script>
<style>
.input3     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F5FDBD;}
.input4     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F4DAFE;}
.input5     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:C7CBFF;}
</style>
<body>
<table width="100%">
<tr>
    <td align="right">
        <input type="button" value="전체 경기보기" class="input4" onclick="goList(0)" />        
        <input type="button" value="미등록 경기보기" class="input5" onclick="goList(1)" />            
        <input type="button" value="등록 경기보기" class="input5" onclick="goList(2)" />  
        <a href="Game_7mListHtml.asp"  target="_blank">HTML 보기</a>
    </td>
</tr>
</table>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" height="30">
    [전체 경기 개수 : <%= nTotalCnt %> ]  
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
    </td>   
</tr>
</table>
<!-- paging End -->
<br />
<% '===============================  홍수정%>
<div>
<form name="allFM" method="post" action="Game_7mRegist_ProcAll.asp" >
<% '===============================  홍수정%>


<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%" id="tblGameList">
<tr bgcolor="eeeeee"  height="25"> 
    <td>리그</td>
    <td>게임일시</td>
    <td>IDX</td>   
    <td>홈팀</td>    
    <td>승</td>
    <td>무</td>
    <td>패</td>
    <td>승(변경)</td>
    <td>무(변경)</td>
    <td>패(변경)</td>
    <td>원정팀</td>
    <td>승(적용)</td>
    <td>무(적용)</td>
    <td>패(적용)</td>
	<% '===============================  홍수정%>
    <td>핸디 <br/><input type="checkbox" id="chkAllHandy"><em>전체선택</em></td>
    <td>오/언<br/><input type="checkbox" id="chkAllOverUn"><em>전체선택</em></td>
    <td>등록        <input type="submit" value="선택등록" />
	<br/><input type="checkbox" id="chkAllRegi"><em>전체선택</em></td>
	<% '===============================  홍수정%>
</tr>    
<%	
    IF  dfgameSql.RsCount = 0 THEN	
%>
<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">등록된 게임이 없습니다. .</td></tr>
<%
	ELSE
	    FOR ii = 0 TO dfgameSql.RsCount -1
            
           
            IF ii mod 2 = 0 Then
                bgColor = "#FFFFFF"
            Else
                bgColor = "#EEEEEE"
            End IF   
            
            IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                bgColor = "#FCEAEA"
            End IF    
            
            IF  dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") <= 1.6 OR  dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") >= 5 Or dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") <= 1.6 OR  dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") >= 5 Then
                fontColor = "red"
                className = "input_boxred"
            Else
                fontColor = "#000000"
                className = "input_box"
            End IF
            
            IG_STARTTIME = dfGameSql.Rs(ii,"I7_STARTTIME") 
            
            checkTime = ""
            IF isNull(dfGameSql.Rs(ii,"IG_STARTTIME")) Or dfGameSql.Rs(ii,"IG_STARTTIME") <> "" Then
                IF dfGameSql.Rs(ii,"I7_STARTTIME") <> dfGameSql.Rs(ii,"IG_STARTTIME") Then
                   checkTime = "<b><font color='red'>[시간변경]</font></b>"
                End IF
            End IF
            
            '등록 유무
            IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                trClass = "reg"
            Else
                trClass = "noreg"
            End IF
            
            '위험 유무
            IF fontColor = "red" Then
                trClass2 = "war"
            Else
                trClass2 = "nowar"
            End IF
            
            ' 추후 변경 작업 진행
            IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") 
            IG_DRAWBENEFIT = dfGameSql.Rs(ii,"I7_DRAWBENEFIT") 
            IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") 

            IF NOT isNull(dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT")) AND dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") <> "" Then
                IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") 
                IG_DRAWBENEFIT = dfGameSql.Rs(ii,"I7_C_DRAWBENEFIT") 
                IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"I7_C_TEAM2BENEFIT")                 
            End IF
            
            IF NOT isNull(dfGameSql.Rs(ii,"IG_TEAM1BENEFIT")) AND dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                IF dfGameSql.Rs(ii,"IG_TYPE") <> 0 Then
                    IG_DRAWBENEFIT = dfGameSql.Rs(ii,"IG_HANDICAP")
                Else
                    IG_DRAWBENEFIT =  dfGameSql.Rs(ii,"IG_DRAWBENEFIT")
                End IF            
                IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") 
                IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") 
            End IF
                        
'      <form name="frm<%= ii % >" method="post" action="Game_7mRegist_Proc.asp" target="exeFrame" onsubmit="return checkFormGame(this);">      
            
%>

<% IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT")  = "" Then %>
<input type="Hidden" name="Process<%= ii %>" value="add">
<% 
Else
%>
	<% '===============================  홍수정
	'
	' 기존  input 들에  name 뒤에 <%= ii % > 추가해줌
	'
	'===============================  홍수정%>

<input type="Hidden" name="Process<%= ii %>" value="modify">
<input type="Hidden" name="IG_IDX<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_IDX") %>">
<input type="Hidden" name="IG_TYPE<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_TYPE") %>">
<input type="hidden" name="IG_STATUS<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_STATUS")  %>" />
<% End IF %>
<input type="hidden" name="SRL_League<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_LEAGUE") %>" />


<input type="hidden" name="IG_StartTime<%= ii %>" value="<%= dfStringUtil.GetFullDate(dfGameSql.Rs(ii,"I7_STARTTIME")) %>" />
<tr bgcolor="<%= bgColor %>" height="25" class="<%= trClass %>" useAtt="<%= trClass2 %>" style="display:block"> 
    <td style="color:<%= fontColor %>"><%= dfGameSql.Rs(ii,"I7_LEAGUE") %></td>
    <td><%= dfStringUtil.GetFullDate(IG_STARTTIME) %> <%= checkTime %></td>
    <td><input type="text" class="<%= className %>" size="7" name="I7_IDX<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_IDX") %>" readonly /></td>    
    <td><input type="text" class="<%= className %>" name="IG_Team1<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_TEAM1") %>"  /></td>    
    <td><input type="text" class="<%= className %>" name="I7_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_DRAWBENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_DRAWBENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") %>"  readonly/></td>
    <td><input type="text" class="<%= className %>" name="I7_C_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_C_DRAWBENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_DRAWBENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_C_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_TEAM2BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="IG_Team2<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_TEAM2") %>"  /></td>
    <td>
        <input type="text" class="input_box1" name="IG_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") %>" />
    </td>
    <td>
        <input type="text" class="input_box1" name="IG_DRAWBENEFIT<%= ii %>" size="5" value="<%= IG_DRAWBENEFIT %>" />
    </td>
    <td>
        <input type="text" class="input_box1" name="IG_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") %>" />
    </td>     
           
    <td>    
    <% IF dfGameSql.Rs(ii,"IG_TYPE") = 0 AND  dfGameSql.Rs(ii,"IG_IDX") = "" Then %>
<% ' ================================================================= 홍추가 ========
'아래 input 에 class="CheckBoxHandy" 추가
%>
	<input type="CheckBox" class="CheckBoxHandy" name="IG_Type02<%= ii %>" value="Yes" onclick="showHideLayer('divHandi<%= ii %>');"> 핸디캡

	
	<div id="divHandi<%= ii %>" style="position:relative;display:none;">
       <div style="position:absolute;background:#FFF;left:-60px;">
        <table width="100%" cellpadding="2" cellspacing=1  bgcolor="#AAAAAA">
        <tr bgcolor="EEEEEE" height="30"> 
            <td>승 </td>
            <td>핸디</td>
            <td>패</td>     
        </tr>                
        <tr bgcolor="ffffff" height="25">
            <td><input type="text" class="input_box1" name="IG_H_TEAM1BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' 기본배당 변경 --------------------------홍%>
            <td><input type="text" class="input_box1" name="IG_H_DRAWBENEFIT<%= ii %>" size="4" value="1.0" /></td>   <%' 기본배당 변경 --------------------------홍%>
            <td><input type="text" class="input_box1" name="IG_H_TEAM2BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' 기본배당 변경 --------------------------홍%>  
        </tr>
        </table>

        </div>        

    </div>        
    <% ElseIF dfGameSql.Rs(ii,"IG_TYPE") = 1 Then  %>
        <font color="blue">핸디캡</font>
    <% End IF %>
    </td>
    <td>
    <% IF dfGameSql.Rs(ii,"IG_TYPE") = 0 AND  dfGameSql.Rs(ii,"IG_IDX") = "" Then %>

<% ' ================================================================= 홍추가 ========
'아래 input 에 class="CheckBoxOverUnder" 추가
%>
    <input type="CheckBox" class="CheckBoxOverUnder" name="IG_Type03<%= ii %>" value="Yes" onclick="showHideLayer('divOver<%= ii %>');"> 오버언더
    <div id="divOver<%= ii %>" style="position:relative;display:none;">
        <div style="position:absolute;background:#FFF;left:5px;">
        <table width="100%" cellpadding="2" cellspacing=1  bgcolor="#AAAAAA">
        <tr bgcolor="EEEEEE" height="30"> 
            <td>승 </td>
            <td>합산</td>
            <td>패</td>     
        </tr>                
        <tr bgcolor="ffffff" height="25"> <%' 기본배당 변경 --------------------------홍%>
            <td><input type="text" class="input_box1" name="IG_O_TEAM1BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' 기본배당 변경 --------------------------홍%>
            <td><input type="text" class="input_box1" name="IG_O_DRAWBENEFIT<%= ii %>" size="4" value="1.0" /></td>   <%' 기본배당 변경 --------------------------홍%>
            <td><input type="text" class="input_box1" name="IG_O_TEAM2BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' 기본배당 변경 --------------------------홍%>  
        </tr>
        </table>
        </div>        
    </div>   
   <% ElseIF dfGameSql.Rs(ii,"IG_TYPE") = 2 Then  %>
        <font color="blue">오버언더</font>
    <% End IF %>     
    </td>    
    <td>

<% ' ================================================================= 홍수정 ========%>
    <% IF dfGameSql.Rs(ii,"IG_STATUS") = "" Then%>신규

    <% ElseIF dfGameSql.Rs(ii,"IG_STATUS") = "R" Or dfGameSql.Rs(ii,"IG_STATUS") = "S" Then %>                
         <b>수정</b>

    <% Else %>        
         <b>수정2</b>
 
	<% End IF %>   
<% ' ================================================================= 홍수정 ========%>
<% ' ================================================================= 홍추가 ========%>
		<input type="CheckBox" Class="CheckBoxRegist" name="chkb" value="<%= ii %>"  class="input2"  >
<% ' ================================================================= 홍추가 ========%>


	
    </td>
</tr> 

<%	    
	    Next
    End IF	    
%>	 
</table>
<% ' ================================================================= 홍추가 ========%>
</form>
</div>
<% ' ================================================================= 홍추가 ========%>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" height="30">
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
    </td>   
</tr>
</table>
<!-- paging End -->
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
</body>
</html>