<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
	
  '######### Request Check                    ################	    

	Search     = Trim(dfRequest.Value("Search"))
	Find     = Trim(dfRequest.Value("Find"))
	
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    
    	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfCpSql.RetrieveLOG_LOGINByCheckID(dfDBConn.Conn,  Search , Find)

%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
</head>

<body topmargin="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm1" method="get" action="Login_ListById.asp">
<tr align="right">
	<td>
	    중복 IP 의심자 검사 : 
	    <select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="LL_ID">아이디</option>
		<option value="LL_NICKNAME">닉네임</option>
	</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	</tr></form></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frmchk" method="post">
	<td align="center" height="30" bgcolor="e7e7e7" width=""><b>아이디</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width=""><b>닉네임</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width=""><b>IP</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>Login Time</b></td>
	</tr>
	

<%
IF dfCpSql.RsCount = 0 THEN	
%>

<tr><td align="center" colspan="6" height="35">로그인 정보가 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfCpSql.RsCount -1


		LL_ID			= dfCpSql.Rs(i,"LL_ID")
		LL_IP			= dfCpSql.Rs(i,"LL_IP")
		LL_NICKNAME 	= dfCpSql.Rs(i,"LL_NICKNAME")
		LL_REGDATE			= dfCpSql.Rs(i,"LL_REGDATE")

%>

<tr bgcolor="#FFFFFF">
    <td align="center"><%=LL_ID%></td>
    <td align="center"><%=LL_NICKNAME%></td>
    <td align="center"><%=LL_IP%></td>
    <td align="center"><%=LL_RegDate%></td>
</tr>
<%  
	Next 
END IF 
%>

</table>

</body>
</html>
