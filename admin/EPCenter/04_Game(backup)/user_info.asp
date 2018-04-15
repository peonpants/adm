<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<head>
<title>배팅상세내역</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/Css/style.css" />
<%
	val	= Trim(REQUEST("val"))	
	site = Trim(REQUEST("site"))	
	
	SQLLIST = "select * from info_user where iu_id = '"&val&"' and iu_site = '"&site&"'"
	'response.write sqllist
	SET RSLIST = DbCon.Execute(SQLLIST)
%>
</head>
<style>
td {
text-align:center;
background-color:#b8e1ff;
}
input{
text-align:center;
}
.aaaa {
background-color:#ffffff;
}
</style>
<body>
<form name="frm1" method="post" action="iu_cash.asp">
<table width="300"  align="center" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" class="list0">
  <tr>
    <td width="100">아이디</td>
    <td width="200" class="aaaa"><input type="text" name="iu_id" style='width:150px;' value="<%=val%>" readonly></td>
  </tr>
  <tr>
    <td>닉네임</td>
    <td class="aaaa"><%=RSLIST("iu_nickname")%></td>
  </tr  ><tr>
    <td>사이트</td>
    <td class="aaaa"><input type="text" name="iu_site" style='width:150px;' value="<%=site%>" readonly></td>
  </tr>
   <tr>
    <td>보유금액</td>
    <td class="aaaa"><input type="text" name="iu_cash" style='width:150px;' value="<%=RSLIST("iu_cash")%>" readonly></td>
  </tr> 
   <tr>
    <td>금액변경</td>
    <td class="aaaa">+<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					-<input type="Radio" name="ProcFlag" value="-"><input type="text" name="iu_cash_mo" style='width:150px;' ></td>
  </tr> 
   <tr>
    <td colspan="2" class="aaaa"><input type="submit" value="변경">&nbsp;&nbsp;&nbsp;<input type="button" value="닫기" onclick="window.close();"></td>
  </tr> 
  </table>
	</form>
<body>
</html>
<%
	RSLIST.CLOSE
	SET RSLIST = Nothing
%>
