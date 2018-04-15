<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<%    
 
    	
    '######### 리퀘스트                    ################	
    IEG_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IEG_IDX")), 0, 1, 1000)
		
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
     
    IF IEG_IDX <> 0 Then    	
	    '######### 리그 리스트를 불러옴                 ################	
	    Call dfeventSql.GetINFO_EVENT_GAME(dfDBConn.Conn,  IEG_IDX)
	    'dfeventSql.debug
	    IF dfeventSql.RsCount = 0 Then
	        IEG_IDX = 0 
        Else
            IEG_TITLE = dfeventSql.RsOne("IEG_TITLE")
            IEG_STARTDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("IEG_STARTTIME"))
            IEG_ENDDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("IEG_ENDTIME"))
            IEG_AMOUNT = dfeventSql.RsOne("IEG_AMOUNT")
            IEG_CONTENT = dfeventSql.RsOne("IEG_CONTENT")
            
            Set dfeventSql = Nothing
            
            Set dfeventSql = new eventSql
            
            Call dfeventSql.RetrieveINFO_EVENT_GAME_DETAIL(dfDBConn.Conn,  IEG_IDX)
            
            Set dfeventSql1 = new eventSql
            
            Call dfeventSql1.RetrieveINFO_EVENT_GAME_USER(dfDBConn.Conn,  IEG_IDX)            
            
	    End IF
    End IF
    
    IF IEG_IDX = 0 Then
        mode = "write"
        strTitle = "등록"
    Else
        mode = "modify"
        strTitle = "수정"
    End IF

%>
<html>
<head>
<title>이닝 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css" />
<script type="text/javascript">
function goList()
{
    location.href = "list.asp";
}
function goInsert()
{
    location.href = "input.asp";
}
function goModify(IEG_IDX)
{
    location.href = "input.asp?IEG_IDX=" + IEG_IDX;
}
function goDeleteGame(IEGD_IDX)
{
    var rtn = confirm("정말로 삭제하시겠습니까?") ;
    if(rtn)
    {
        location.href = "process.asp?mode=gameDel&IEG_IDX=<%= IEG_IDX %>&IEGD_IDX=" + IEGD_IDX;
    }        
}
function checkInputForm(form)
{
    if(form.IEG_TITLE.value == "")
    {
        alert("제목을 입력하세요");
        form.IEG_TITLE.focus();
        return false;
    }
    if(form.IEG_CONTENT.value == "")
    {
        alert("내용을 입력하세요");
        form.IEG_CONTENT.focus();
        return false;
    }    
    if(form.IEG_AMOUNT.value == "")
    {
        alert("당첨금을 입력하세요");
        form.IEG_AMOUNT.focus();
        return false;
    }      
    if(form.IEG_STARTTIME.value == "")
    {
        alert("시작시간을 입력하세요");
        form.IEG_STARTTIME.focus();
        return false;
    }       
    if(form.IEG_ENDTIME.value == "")
    {
        alert("종료시간을 입력하세요");
        form.IEG_ENDTIME.focus();
        return false;
    }       
}

function checkInputGameForm(form)
{
    if(form.IEG_TEAM1.value == "")
    {
        alert("홈팀명을 입력하세요");
        form.IEG_TEAM1.focus();
        return false;
    }
    if(form.IEG_TEAM2.value == "")
    {
        alert("원정팀명을 입력하세요");
        form.IEG_TEAM2.focus();
        return false;
    }    
}
function addBetEvent()
{
    var userCount   = document.getElementById("userCount").value ; 
    var IEGU_RESULT = document.getElementById("IEGU_RESULT").value ; 
    window.open("addBetEvent_proc.asp?IEG_ENDDATE=<%= IEG_ENDDATE %>&IEG_IDX=<%= IEG_IDX %>&top=" + userCount + "&IEGU_RESULT=" +   IEGU_RESULT, "smp","width=200,height=200");
}
</script>
</head>
<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 승무패 이벤트 &nbsp;&nbsp; ▶ 이벤트 <%= strTitle %>
	      </b>
    </td>
</tr>
</table>   
<br />
<form name="inputForm" method="post" action="process.asp" onsubmit="return checkInputForm(this);">
<input type="hidden" name="mode" value="<%= mode %>" />
<input type="hidden" name="IEG_IDX" value="<%= IEG_IDX %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="150">제목</td>
    <td>
        <input type="text" name="IEG_TITLE" size="50"  class="input" value="<%= IEG_TITLE %>" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="150">내용</td>
    <td>
        <textarea name="IEG_CONTENT" style="width:90%;height:100px" class="input"><%= IEG_CONTENT %></textarea>
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" >당첨금</td>
    <td>
        <input type="text" name="IEG_AMOUNT" size="50"  class="input" value="<%= IEG_AMOUNT %>" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="350">시작시간</td>
    <td>
        <input type="text" name="IEG_STARTTIME" size="50"  class="input" value="<%= IEG_STARTDATE %>" />
    </td>
</tr>    
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="350">종료시간</td>
    <td>
        <input type="text" name="IEG_ENDTIME" size="50"  class="input" value="<%= IEG_ENDDATE %>" />
    </td>
</tr>    
</table>    
<table width="100%">
<tr>
    <td align="right">
    <input type="button" value="목록보기" class="input" onclick="goList();" />    
    <input type="submit" value="이벤트 <%= strTitle %>" class="input"/>    
    </td>
</tr>
</table>
</form>
<%
IF mode = "modify" Then
%>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 승무패 이벤트 &nbsp;&nbsp; ▶ 이벤트 게밈 등록
	      </b>
    </td>
</tr>
</table>   
<br />
<form name="inputGameForm" method="post" action="process.asp" onsubmit="return checkInputGameForm(this);">
<input type="hidden" name="mode" value="gameWrite" />
<input type="hidden" name="IEG_IDX" value="<%= IEG_IDX %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF" >
    <td bgcolor="#EEEEEE" height="25">홈팀</td>
    <td>
        <input type="text" name="IEG_TEAM1" size="20"  class="input" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" height="25">원정팀</td>
    <td>
        <input type="text" name="IEG_TEAM2" size="20"  class="input" />
    </td>
</tr>
</table>
<table width="100%">
<tr>
    <td align="right">
    <input type="submit" value="이벤트 게임등록" class="input"/>    
    </td>
</tr>
</table>
</form>
<%
End IF
%>
<%
    if mode = "modify"  Then
        IEG_RESULT = ""
        IF dfeventSql.RsCount <> 0 Then
            For i = 0 to dfEventSql.RsCount - 1 
%>
<form name="gameModifyForm<%= i %>" method="post" action="process.asp" onsubmit="return checkInputGameForm(this);">
<input type="hidden" name="mode" value="gameModify" />
<input type="hidden" name="IEG_IDX" value="<%= IEG_IDX %>" />
<input type="hidden" name="IEGD_IDX" value="<%= dfeventSql.Rs(i,"IEGD_IDX")  %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF" >
    <td bgcolor="#EEEEEE" height="25" width="5%">홈팀</td>
    <td width="40%">
        <input type="text" name="IEG_TEAM1" size="20"  class="input" value="<%= dfeventSql.Rs(i,"IEG_TEAM1")  %>" />
    </td>
    <td bgcolor="#EEEEEE" height="25  width="5%">원정팀</td>
    <td width="30%">
        <input type="text" name="IEG_TEAM2" size="20"  class="input" value="<%= dfeventSql.Rs(i,"IEG_TEAM2")  %>" />
    </td>
    <td width="10%">
        <select name="IEGD_RESULT">
            <option value="1" <% IF cStr(dfEventSql.Rs(i,"IEGD_RESULT")) = "1" Then %>selected<% End IF %>>승</option>
            <option value="0" <% IF cStr(dfEventSql.Rs(i,"IEGD_RESULT")) = "0" Then %>selected<% End IF %>>무</option>
            <option value="2" <% IF cStr(dfEventSql.Rs(i,"IEGD_RESULT")) = "2" Then %>selected<% End IF %>>패</option>
        </select>
    </td>    
    <td width="10%">
        <input type="submit" value="수정" class="input"/>    
        <input type="button" value="삭제" class="input" onclick="goDeleteGame(<%= dfeventSql.Rs(i,"IEGD_IDX")  %>);" />   
    </td>
</tr>
</table>
</form>
<%
                IEG_RESULT = IEG_RESULT & cStr(dfEventSql.Rs(i,"IEGD_RESULT"))
            Next
    
%>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 승무패 이벤트 &nbsp;&nbsp; ▶ 이벤트 참여 회원만들기
	      </b>
    </td>
</tr>
</table>  
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF" > 
    <td>
        <input type="text" id="IEGU_RESULT" value=""  />
        <input type="text" id="userCount" value="100"  />
        <input type="button" value="이벤트참가하기" class="input2" onclick="addBetEvent();" />
    </td>
</tr>
</table>
<%
        IF dfeventSql1.RsCount <> 0 Then
%>    
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 승무패 이벤트 &nbsp;&nbsp; ▶ 이벤트 참여 회원만들기
	      </b>
    </td>
</tr>
</table>  
<table width="100%">
<tr>
    <td width="50%" valign="top">
    <table width="100%">
<%
        
        For i = 0 to dfeventSql1.RsCount - 1
            IF Trim(dfeventSql1.Rs(i,"IGIU_RESULT")) = Trim(IEG_RESULT) Then
%>    
    <tr>
        <td>
            <%= dfeventSql1.Rs(i,"IGIU_NAME") %>    
        </td>
        <td>
            <%

                FOR jj = 1 to  Len( dfeventSql1.Rs(i,"IGIU_RESULT") )
                    fChar = Mid(dfeventSql1.Rs(i,"IGIU_RESULT")  ,jj,1)
                    IF cStr(fChar) = "1" Then
                        response.write "승 "
                    ElseIF cStr(fChar) = "0" Then
                        response.write "무 "            
                    ElseIF cStr(fChar) = "2" Then
                        response.write "패 "       
                    End IF
                Next               
            %>    
        </td>        
    </tr>
<%
            End IF
        Next
%>
    </table>
    </td>
    <td width="50%" valign="top">
    <table width="100%">
<%
        For i = 0 to dfeventSql1.RsCount - 1
            IF Trim(dfeventSql1.Rs(i,"IGIU_RESULT")) <> Trim(IEG_RESULT) Then
%>    
    <tr>
        <td>
            <%= dfeventSql1.Rs(i,"IGIU_NAME") %>    
        </td>
        <td>
            <%
                FOR jj = 1 to Len( dfeventSql1.Rs(i,"IGIU_RESULT") )
                    fChar = Mid(dfeventSql1.Rs(i,"IGIU_RESULT")  ,jj,1)
                    IF cStr(fChar) = "1" Then
                        response.write "승 "
                    ElseIF cStr(fChar) = "0" Then
                        response.write "무 "            
                    ElseIF cStr(fChar) = "2" Then
                        response.write "패 "    
                    End IF
                Next                
            %>
        </td>        
    </tr>
<%
            End IF
        Next
%>
    </table>
    </td>    
</tr>
</table>
<%
        End IF
    End IF            
End IF
%>

</body>
</html>
