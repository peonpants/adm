<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->

	<html>
	<head>
	<title>관리자</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta name="robots" content="noindex,nofollow">
	<link rel=stylesheet type=text/css href="/img/shopstyle.css">
	<script type="text/javascript" src="/Sc/Base.js"></script>
	<script type="text/javascript">

	function Checkform(form)
	{
		if (form.AdminID.value == "" )
		{
			alert("아이디를 입력하세요");
			form.AdminID.focus();
			return false;
		}
		else if (form.AdminPW.value == "" )
		{
			alert("비밀번호를 입력하세요");
			form.AdminPW.focus();
			return false;
		}
	}


</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  bgColor=#737373 onload="document.LoginFrm.AdminID.focus();" >
<table border=0 cellSpacing=0 cellPadding=0 width="100%" height="100%">
<form name="LoginFrm" method="post" action="/Login/LoginChk.asp" onsubmit="return Checkform(this);">
  
  <tr>
    <td bgColor=#535353 rowSpan=4 width=10></td>
    <td bgColor=#8c8e8c rowSpan=4 width=1></td>
    <td height=70>
      <table border=0 cellSpacing=0 cellPadding=0 width="100%" height=70>
        
        <tr>
          <td style="PADDING-RIGHT: 20px" align=left><img src="/img/top_logo.gif" /></td></tr>
        <tr bgColor=#121212>
          <td height=1></td></tr>
        <tr bgColor=#8c8e8c>
          <td height=1></td></tr></table></td>
    <td bgColor=#8c8e8c rowSpan=4 width=1></td>
    <td bgColor=#535353 rowSpan=4 width=10></td></tr>
  <tr>
    <td height=248 align=left>
      <table border=0 cellSpacing=0 cellPadding=0 width=841 height=248>
        
        <tr>
          <td height=248 width=239><IMG 
            src="/img/login_thema.jpg" width=239 height=248></td>
          <td bgColor=#8c8e8c width=1></td>
          <td height=248 width=600>
            <table border=0 cellSpacing=0 cellPadding=0 width=500>
              
              <tr>
                <td width=94>&nbsp;</td>
                <td><IMG src="/img/admin_login.gif" width=187 
                  height=46></td></tr>
              <tr>
                <td width=94>&nbsp;</td>
                <td>
                  <table border=0 cellSpacing=0 cellPadding=0 width="71%">
                    
                    <tr>
                      <td>
                        <table border=0 cellSpacing=0 cellPadding=0>
                          
                          <tr>
                            <td height=25 width=207>
                                <IMG align=absMiddle src="/img/id.gif" width=57 height=17>
                                <INPUT class=input name=AdminID>
                            </td></tr>
                          <tr>
                            <td height=25 width=207>
                                <IMG align=absMiddle src="/img/passwd.gif" width=57 height=17>
                                <INPUT class=input type=password name=AdminPW>
                             </td></tr></table>
                          <td align=middle>
                            <input type="image" border=0 align=absMiddle  src="/img/bt_adminlogin.gif" >
                          </td>
                      </tr></table></td></tr></table></td>
          <td bgColor=#8c8e8c height=248 width=1></td></tr></table></td></tr>
  <tr>
    <td>
      <table border=0 cellSpacing=0 cellPadding=0 width="100%" height="100%">
        
        <tr bgColor=#8c8e8c>
          <td height=1 colSpan=5></td></tr>
        <tr>
          <td bgColor=#121212 height=1 colSpan=5></td></tr>
        <tr>
          <td width=239></td>
          <td bgColor=#8c8e8c width=1></td>
          <td vAlign=top width=600>
            <table border=0 cellSpacing=0 cellPadding=0 width=600>
              
              <tr height=15>
                <td height=15 width=94></td>
                <td height=15></td></tr>
              <tr>
                <td height=15 width=94></td>
                <td vAlign=top>
                  <table border=0 cellSpacing=0 cellPadding=0 width=350>
                    
                    <tr>
                      <td width=8></td>
                      <td class=menu vAlign=top><FONT color=#ffffff>※ 관리자 페이지로 
                        접속합니다<BR>※ 공공장소에서의 로그인시 정보 유출에 주의하시기 
                    바랍니다</FONT></td></tr></table></td></tr></table></td>
          <td bgColor=#8c8e8c width=1></td>
          <td bgColor=#6b696b></td></tr></table></td></tr>
  <tr>
    <td height=90>
      <table border=0 cellSpacing=0 cellPadding=0 width="100%" height=90>
        
        <tr>
          <td height=1></td>
          <td bgColor=#8c8e8c height=1 colSpan=4></td></tr>
        <tr>
          <td width=239></td>
          <td bgColor=#8c8e8c width=1></td>
          <td bgColor=#848684 width=600>
            <table border=0 cellSpacing=0 cellPadding=0 width=600>
              
              <tr>
                <td width=94>&nbsp;</td>
                <td class=cp><FONT color=#ffffff>...</FONT></td></tr></table></td>
          <td bgColor=#8c8e8c width=1></td>
          <td></td></tr></table></td></tr></table></form></body></html>

       