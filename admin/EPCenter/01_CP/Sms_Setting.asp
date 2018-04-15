<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 게임 설정 값 부름                    ################	
    Call dfCpSql.GetInfo_AdminSms(dfDBConn.Conn)
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("설정값이 존재하지 않습니다.");
    </script>
<%    
        response.End
    End IF
    
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script type="text/javascript">
function checkSmsForm(form)
{
    if(form.IAS_PHONE.value == "")
    {
        alert("전화번호를 입력하세요.\n다수의 전화번호는 , 로 구분합니다.");
        form.IAS_PHONE.focus();
        return false
    }        
}

</script>
</head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 사이트관리 &nbsp;&nbsp; ▶ 충환전 SMS알림 설정 </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>
<form name="smsForm" method="post" action="Sms_Setting_Proc.asp" onsubmit="return checkSmsForm(this)">

<table width="100%" border="0" cellspacing="1" cellpadding="5" bgcolor="#aaaaaa">
<tr height="25" bgcolor="e7e7e7">    
	<td width="220"  align="center">관리자 전화번호</td>
	<td bgcolor="ffffff" >
	    <input type="text" size="100" name="IAS_PHONE" class="input" value="<%= dfCpSql.RsOne("IAS_PHONE") %>" />
	</td>
</tr>
<tr height="25" bgcolor="e7e7e7">    
	<td width="220"  align="center">알림 설정</td>
	<td bgcolor="ffffff" >
	    <input type="radio" name="IAS_ENABLE" value="1" <% IF dfCpSql.RsOne("IAS_ENABLE") = 1 Then %>checked<% End IF %> />  알림
	    <input type="radio" name="IAS_ENABLE" value="0" <% IF dfCpSql.RsOne("IAS_ENABLE") = 0 Then %>checked<% End IF %>/>  비알림
	</td>
</tr>
<tr height="25" bgcolor="ffffff">    
	<td colspan="2"  align="center">
	    <input type="submit" value="정보 수정" />
	</td>
</tr>
</table>
</form>	

</body>
</html>