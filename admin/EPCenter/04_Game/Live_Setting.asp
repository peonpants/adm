<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	
	
    Dim dfgameSql1
    Set dfgameSql1 = new gameSql    
	
   
	'��ٸ����࿩��
    Call dfgameSql1.GetSET_SADARI_LST(dfDBConn.Conn)
    IF dfgameSql1.RsCount <> 0  Then
        s_cnt = dfgameSql1.RsOne("s_cnt")
    End IF

	
	'���������࿩��
    Call dfgameSql1.GetSET_DAL_LST(dfDBConn.Conn)
    IF dfgameSql1.RsCount <> 0  Then
        d_cnt = dfgameSql1.RsOne("d_cnt")
    End IF
	
	
	'�˶�����࿩��
    Call dfgameSql1.GetSET_ALADIN_LST(dfDBConn.Conn)
    IF dfgameSql1.RsCount <> 0  Then
        a_cnt = dfgameSql1.RsOne("a_cnt")
    End If
   	
	'�ٸ��ٸ����࿩��
    Call dfgameSql1.GetSET_DARI_LST(dfDBConn.Conn)
    IF dfgameSql1.RsCount <> 0  Then
        r_cnt = dfgameSql1.RsOne("r_cnt")
    End If

%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<!--<script src="/Sc/Base.js"></script>-->

</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">��ٸ����� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame1" method="post" action="Live_Proc.asp" >
<input type="hidden" name="EMODE" value="SB_OPEN1">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>��ٸ����� ����</b></td>
	<td width="500" align="left">
	    <select name="siteOpen">
	        <!--<option value="1" <% IF SITE_OPEN = "1" Then %>selected<% End IF %>>����</option>-->
	        <option value="1" <% IF s_cnt = "1" Then %>selected<% End IF %>>������</option>
	        <option value="2" <% IF s_cnt = "2" Then %>selected<% End IF %>>�� ��</option>	        
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" �� �� " style="border:1 solid;"></td></tr></table>
</form>	


<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">�����̰��� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame2" method="post" action="Live_Proc.asp" >
<input type="hidden" name="EMODE" value="SB_OPEN2">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>�����̰��� ����</b></td>
	<td width="500" align="left">
	    <select name="siteOpen">
	        <!--<option value="1" <% IF SITE_OPEN = "1" Then %>selected<% End IF %>>����</option>-->
	        <option value="1" <% IF d_cnt = "1" Then %>selected<% End IF %>>������</option>
	        <option value="2" <% IF d_cnt = "2" Then %>selected<% End IF %>>�� ��</option>	        
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" �� �� " style="border:1 solid;"></td></tr></table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">�˶���ٸ����� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame3" method="post" action="Live_Proc.asp" >
<input type="hidden" name="EMODE" value="SB_OPEN3">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>�˶���ٸ����� ����</b></td>
	<td width="500" align="left">
	    <select name="siteOpen">
	        <!--<option value="1" <% IF SITE_OPEN = "1" Then %>selected<% End IF %>>����</option>-->
	        <option value="1" <% IF a_cnt = "1" Then %>selected<% End IF %>>������</option>
	        <option value="2" <% IF a_cnt = "2" Then %>selected<% End IF %>>�� ��</option>	        
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" �� �� " style="border:1 solid;"></td></tr></table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">�ٸ��ٸ����� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame4" method="post" action="Live_Proc.asp" >
<input type="hidden" name="EMODE" value="SB_OPEN4">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>�ٸ��ٸ����� ����</b></td>
	<td width="500" align="left">
	    <select name="siteOpen">
	        <!--<option value="1" <% IF SITE_OPEN = "1" Then %>selected<% End IF %>>����</option>-->
	        <option value="1" <% IF r_cnt = "1" Then %>selected<% End IF %>>������</option>
	        <option value="2" <% IF r_cnt = "2" Then %>selected<% End IF %>>�� ��</option>	        
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" �� �� " style="border:1 solid;"></td></tr></table>
</form>	

<br />
<br />
<br />
<br />
</body>
</html>