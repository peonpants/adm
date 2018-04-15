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

    '######### 리퀘스트                    ################	
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
	Call dfeventSql.RetrieveINFO_EVENT_GAME(dfDBConn.Conn,  page, pageSize)

%>
<html>
<head>
<title>이닝 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">
function goInsert()
{
    location.href = "input.asp";
}
function goModify(IEG_IDX)
{
    location.href = "input.asp?IEG_IDX=" + IEG_IDX;
}
function goDelete(IEG_IDX)
{
    var rtn = confirm("정말로 삭제하시겠습니까?") ;
    if(rtn)
    {
        location.href = "process.asp?mode=del&IEG_IDX=" + IEG_IDX;
    }        
}
</script>
</head>
<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 승무패 이벤트 &nbsp;&nbsp; ▶ 리스트
	      </b>
    </td>
</tr>
</table>   
<br />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE">제목</td>
    <td bgcolor="#EEEEEE" width="80">당첨금</td>
    <td bgcolor="#EEEEEE" width="350">이벤트 기간</td>
    <td bgcolor="#EEEEEE" width="50">수정</td>
    <td bgcolor="#EEEEEE" width="50">삭제</td>
</tr>
<%
IF dfeventSql.RsCount <> 0 Then
    For i = 0 to dfeventSql.RsCount - 1
%>
<tr bgcolor="#FFFFFF">
    <td >
        <a href="input.asp?IEG_IDX=<%= dfeventSql.Rs(i, "IEG_IDX") %>"><%=dfeventSql.Rs(i,"IEG_TITLE")  %></a>
    </td>
    <td >
        <%= formatNumber(dfeventSql.Rs(i,"IEG_AMOUNT"),0)  %>
    </td>    
    <td >
        <%=dfStringUtil.GetFullDate(dfeventSql.Rs(i,"IEG_STARTTIME"))  %> ~ <%= dfStringUtil.GetFullDate(dfeventSql.Rs(i,"IEG_ENDTIME"))  %>
    </td>
    <td align="right">
        <input type="button" value="수정" class="input" onclick="goModify(<%= dfeventSql.Rs(i, "IEG_IDX") %>);" />    
    </td>
    <td align="right">
        <input type="button" value="삭제" class="input" onclick="goDelete(<%= dfeventSql.Rs(i, "IEG_IDX") %>);" />    
    </td>        
</tr>
<%
    Next
Else
%>
<tr>
    <td colspan="5" height="150" align="center" bgcolor="#FFFFFF"> 등록된 이벤트가 존재하지 않습니다.</td>
</tr>
<%
End IF
%>
</table>    

<table width="100%">
<tr>
    <td align="right">
    <input type="button" value="이벤트 등록" class="input" onclick="goInsert();" />    
    </td>
</tr>
</table>
</body>
</html>