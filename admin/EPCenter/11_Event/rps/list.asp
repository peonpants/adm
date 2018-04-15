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

    '######### ������Ʈ                    ################	
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	
	Call dfeventSql.RetrieveINFO_EVENT_GAME(dfDBConn.Conn,  page, pageSize)

%>
<html>
<head>
<title>�̴� �̺�Ʈ</title>
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
    var rtn = confirm("������ �����Ͻðڽ��ϱ�?") ;
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
        <b class="text07"> �̺�Ʈ���� &nbsp;&nbsp; �� �¹��� �̺�Ʈ &nbsp;&nbsp; �� ����Ʈ
	      </b>
    </td>
</tr>
</table>   
<br />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE">����</td>
    <td bgcolor="#EEEEEE" width="80">��÷��</td>
    <td bgcolor="#EEEEEE" width="350">�̺�Ʈ �Ⱓ</td>
    <td bgcolor="#EEEEEE" width="50">����</td>
    <td bgcolor="#EEEEEE" width="50">����</td>
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
        <input type="button" value="����" class="input" onclick="goModify(<%= dfeventSql.Rs(i, "IEG_IDX") %>);" />    
    </td>
    <td align="right">
        <input type="button" value="����" class="input" onclick="goDelete(<%= dfeventSql.Rs(i, "IEG_IDX") %>);" />    
    </td>        
</tr>
<%
    Next
Else
%>
<tr>
    <td colspan="5" height="150" align="center" bgcolor="#FFFFFF"> ��ϵ� �̺�Ʈ�� �������� �ʽ��ϴ�.</td>
</tr>
<%
End IF
%>
</table>    

<table width="100%">
<tr>
    <td align="right">
    <input type="button" value="�̺�Ʈ ���" class="input" onclick="goInsert();" />    
    </td>
</tr>
</table>
</body>
</html>