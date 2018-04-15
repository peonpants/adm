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
    IE_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IE_IDX")), 0, 1, 1000)
		
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
     
    IF IE_IDX <> 0 Then    	
	    '######### 리그 리스트를 불러옴                 ################	
	    Call dfeventSql.GetINFO_EVENT(dfDBConn.Conn,  IE_IDX)
	    IF dfeventSql.RsCount = 0 Then
	        IE_IDX = 0 
        Else
            IE_TITLE = dfeventSql.RsOne("IE_TITLE")
            IE_STARTDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("IE_STARTDATE"))
            IE_ENDDATE = dfStringUtil.GetFullDate(dfeventSql.RsOne("IE_ENDDATE"))
            IE_URL = dfeventSql.RsOne("IE_URL")
	    End IF
    End IF
    
    IF IE_IDX = 0 Then
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
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">
function goList()
{
    location.href = "list.asp";
}

function checkInputForm(form)
{
    if(form.IE_TITLE.value =="")
    {
        alert("이벤트 제목을 입력하세요");
        form.IE_TITLE.focus();
        return false;
    }
    if(form.IE_STARTDATE.value =="")
    {
        alert("이벤트 시작시간을 입력하세요");
        form.IE_STARTDATE.focus();
        return false;
    }
    if(form.IE_ENDDATE.value =="")
    {
        alert("이벤트 종료시간을 입력하세요");
        form.IE_ENDDATE.focus();
        return false;
    }
    if(form.IE_URL.value =="")
    {
        alert("이벤트 URL을 입력하세요");
        form.IE_URL.focus();
        return false;
    }            
}
</script>
</head>
<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 이벤트관리 &nbsp;&nbsp; ▶ 이벤트 <%= strTitle %>
	      </b>
    </td>
</tr>
</table>   
<br />
<form name="inputForm" action="inputEvent_Proc.asp" method="post" onsubmit="return checkInputForm(this);">
<input type="hidden" name="IE_IDX" value="<%= IE_IDX %>" />
<input type="hidden" name="mode" value="<%= mode %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE">제목</td>
    <td bgcolor="#FFFFFF">
        <input type="text" name="IE_TITLE" class="input" size="50" value="<%= IE_TITLE %>" />
    </td>
</tr>    
<tr>
    <td bgcolor="#EEEEEE">이벤트 시작시간</td>
    <td bgcolor="#FFFFFF">
        <input type="text" name="IE_STARTDATE" class="input" size="20" value="<%= IE_STARTDATE %>" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE">이벤트 종료시간</td>
    <td bgcolor="#FFFFFF">
        <input type="text" name="IE_ENDDATE" class="input" size="20" value="<%= IE_ENDDATE %>" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE">이벤트 URL</td>
    <td bgcolor="#FFFFFF">
        <input type="text" name="IE_URL" class="input" size="50" value="<%= IE_URL %>" />
    </td>
</tr>


</table>    

<table width="100%">
<tr>
    <td align="right">
    <input type="button" value="이벤트 목록" class="input" onclick="goList();" />    
    <input type="submit" value="이벤트 <%= strTitle %>" class="input" />    
    </td>
</tr>
</table>
</form>
</body>
</html>