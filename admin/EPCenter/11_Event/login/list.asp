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
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    
    
    reqRound            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("round")), 1, 1, 9999999) 
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	

	Call dfeventSql.RetrieveEvent_Login(dfDBConn.Conn,  reqRound)
    
    IF dfeventSql.RsCount <> 0 Then
        EL_STARTDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("EL_STARTDATE"))
        EL_ENDDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("EL_ENDDATE"))
    End IF

%>		 
<html>
<head>
<title>로그인 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript">
function setCode(round)
{
    exeFrame.location.href = "setCode.asp?round=" + round ;
}
function setUser(round)
{
    exeFrame.location.href = "setCode.asp?round=" + round ;
}
function sendSms(EL_IDX)
{
    exeFrame.location.href = "sendSms.asp?EL_IDX=" + EL_IDX ;
}
</script>
</head>
<body>
로그인 이벤트 <br />
회차
<% For ii = 1 to 10  %>
<a href="list.asp?round=<%= ii %>"><%= ii %>회차</a> |
<% Next %>
<br />
<form name="addForm" method="post" target="exeFrame" action="insertUser.asp" >
<input type="hidden" name="round" value="<%= reqRound %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE" width="150">시작 시간</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_STARTTIME" class="input_box1" value="<%= EL_STARTDATE %>" />
          <br /> Ex) <%= date() %> 16:30:00
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">등록 시간</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_EVENTTIME" class="input_box1" value="<%= EL_ENDDATE %>" />
          <br /> Ex) <%= date() %> 16:30:00
    </td>
</tr>
</table>
<%
    IF dfeventSql.RsCount = 0 Then
%>    
<input type="submit" value=" 이벤트 회원 등록" /> <br />
<% End IF %>
</form>
<%
    IF dfeventSql.RsCount <> 0 Then
        IF dfeventSql.RsOne("EL_CODE") = "" Then
%>
<input type="button" value="  인증 번호 업데이트" onclick="setCode(<%= reqRound %>);" /> <br />
<%
        End IF
    End IF        
%>
<iframe name="exeFrame" width="100%" height="40"></iframe>
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#EEEEEE" height="25">
    <td>아이디</td>
    <td>닉네임</td>
    <td>캐쉬</td>
    <td>핸드폰</td>
    <td>인증번호</td>
    <td>발송</td>
    <td>참여시간</td>    
</tr>
<%
	IF dfeventSql.RsCount <> 0 Then
	    For i = 0 to dfeventSql.RsCount - 1
%>
<tr bgcolor="#FFFFFF"  height="25">
    <td><%= dfeventSql.Rs(i,"EL_ID") %></td>
    <td><%= dfeventSql.Rs(i,"IU_NICKNAME") %></td>
    <td><%= dfeventSql.Rs(i,"IU_CASH") %></td>
    <td><%= dfeventSql.Rs(i,"EL_PHONE") %></td>
    <td><%= dfeventSql.Rs(i,"EL_CODE") %></td>
    <td>
    <%     
    response.Write dfeventSql.Rs(i,"EL_USED")
    IF dfeventSql.Rs(i,"EL_USED") = 2 Then %>
    <input type="button" value=" 발송 " onclick="sendSms(<%= dfeventSql.Rs(i,"EL_IDX") %>);" />
    <% End IF %>
    </td>
    <td><%= dfeventSql.Rs(i,"EL_USEDDATE") %></td>    
</tr>
<%	
        Next
	End IF
%>
</table>

</body>
</html>