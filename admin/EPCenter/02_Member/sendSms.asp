<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 그룹별 하위 사이트를 불러옴	################
        Call dfCpSql.RetrieveINFO_USER_LEVEL(dfDBConn.Conn)	
    
    Set dfcpSql1 = new cpSql  
    Call dfCpSql1.RetrieveSet_Site(dfDBConn.Conn)    
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">
function getMemberPhone()
{
    var IU_LEVEL = document.sendForm.IU_LEVEL.value  ;
    var IU_SITE = document.sendForm.IU_SITE.value ;
    var IU_CHARGE = document.sendForm.IU_CHARGE.value ;
    var url = "sendSms_phoneNum.asp?IU_LEVEL=" + IU_LEVEL + "&IU_SITE=" + IU_SITE  + "&IU_CHARGE=" + IU_CHARGE;
    alert(url);
    exeFrame.location.href = url ;
}
function checkForm(form)
{
    if(form.phoneNum.value == "")
    {
        alert("전화번호를 입력하세요.");
        return false;
    }    
    if(form.msg.value.length > 80 )
    {
        alert("메시지는 40자 미만만 입력하세요.");
        return false;
    }         
}
</script>
</head>
<body topmargin="0" marginheight="0">
<form name="sendForm" method="post" action="sendSms_proc.asp" onsubmit="return checkForm(this)">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  회원관리 ▶ SMS 보내기</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table cellpadding=5 cellspacing=1 border=0 width=100% bgcolor="AAAAAA">
<tr>
    <td bgcolor="#EEEEEE" width="100">전화번호</td>
    <td bgcolor="#FFFFFF">
        <textarea name="phoneNum" id="phoneNum" class="textarea_basic" style="width:700px;height:150px"></textarea>
        <br />
        예)010-0000-0000, 010-0000-0001, 010-0000-0002
        <br />
        <%
						IF dfCpSql.RsCount <> 0 Then
					%>
				<select name="IU_LEVEL">
				<option value=""  >모든레벨</option>
					<%
							For i = 0 to dfCpSql.RsCount - 1

					%>
						<option value="<%= dfCpSql.Rs(i,"IUL_LEVEL") %>"><%= dfCpSql.Rs(i,"IUL_LEVEL") %></option>
					<%
							Next
					%>
					</select>
					<%
							
						End IF
					%>
		            <%
						IF dfCpSql1.RsCount <> 0 Then
					%>
				<select name="IU_SITE">
				<option value=""  >모든사이트</option>
					<%
							For i = 0 to dfCpSql1.RsCount - 1

					%>
						<option value="<%= dfCpSql1.Rs(i,"SITE01") %>"><%= dfCpSql1.Rs(i,"SITE01") %></option>
					<%
							Next
					%>
					</select>
					<%
							
						End IF
					%>	
					<select name="IU_CHARGE">
					    <option value="">모든회원</option>
					    <option value="1">충전회원</option>
					</select>		
					<input type="button" value="명단가져오기" class="input2" onclick="getMemberPhone();" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="100">내용</td>
    <td bgcolor="#FFFFFF">
        <textarea name="msg" class="textarea_basic" style="width:700px;height:100px"></textarea>
    </td>
</tr>
</table>
<table width="100%">
<tr>
    <td align="center">
    <input type="submit" value="SMS 전송" class="input2" />
    <input type="reset" value="초기화" class="input2" />
    </td>
</tr>
</table>
</form>
<iframe name="exeFrame" width="0" height="0" frameborder="0"></iframe>
</body>
</html> 