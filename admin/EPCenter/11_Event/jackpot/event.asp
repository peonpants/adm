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
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	

	Call dfeventSql.GetINFO_JACKPOT(dfDBConn.Conn)

    IJ_CASH = dfeventSql.RsOne("IJ_CASH")
    IJ_PERCENT = dfeventSql.RsOne("IJ_PERCENT")
    IJ_PERCENT = IJ_PERCENT*100
%>
<html>
<head>
<title>�̺�Ʈ - ���� �̺�Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>
<body>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �̺�Ʈ - ���� �̺�Ʈ </b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<form name="inputForm" method="post" action="process.asp">
<input type="hidden" name="mode" value="<%= mode %>" />
<input type="hidden" name="IEG_IDX" value="<%= IEG_IDX %>" />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="150">�����ݾ�</td>
    <td>
        <input type="text" name="IJ_CASH" size="50"  class="input" value="<%= formatNumber(IJ_CASH,0) %>"/>��
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td bgcolor="#EEEEEE" width="150">�ۼ�Ʈ</td>
    <td>
        <input type="text" name="IJ_PERCENT" size="50"  class="input" value="<%= IJ_PERCENT %>"/>%
    </td>
</tr>
</table>
<table width="100%">
<tr>
    <td align="right">
        <input type="submit" value="     ����     " class="input"/>    
    </td>
</tr>
</table>
</form>
</body>
</html>