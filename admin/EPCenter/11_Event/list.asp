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
	Call dfeventSql.RetrieveINFO_EVENT(dfDBConn.Conn,  page, pageSize)

%>
<html>
<head>
<title>�̴� �̺�Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">
function goInsert()
{
    location.href = "inputEvent.asp";
}
function goModify(IE_IDX)
{
    location.href = "inputEvent.asp?IE_IDX=" + IE_IDX;
}
function goDelete(IE_IDX)
{
    var rtn = confirm("������ �����Ͻðڽ��ϱ�?") ;
    if(rtn)
    {
        location.href = "inputEvent_Proc.asp?mode=del&IE_IDX=" + IE_IDX;
    }        
}
</script>
</head>
<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> �̺�Ʈ���� &nbsp;&nbsp; �� ����Ʈ
	      </b>
    </td>
</tr>
</table>   
<br />
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE">����</td>
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
    <a href="inputEvent.asp?IE_IDX=<%= dfeventSql.Rs(i, "IE_IDX") %>"><%=dfeventSql.Rs(i,"IE_TITLE")  %></a>
    </td>
    <td ><%=dfStringUtil.GetFullDate(dfeventSql.Rs(i,"IE_STARTDATE"))  %> ~ <%= dfStringUtil.GetFullDate(dfeventSql.Rs(i,"IE_ENDDATE"))  %></td>
    <td align="right">
        <input type="button" value="����" class="input" onclick="goModify(<%= dfeventSql.Rs(i, "IE_IDX") %>);" />    
    </td>
    <td align="right">
        <input type="button" value="����" class="input" onclick="goDelete(<%= dfeventSql.Rs(i, "IE_IDX") %>);" />    
    </td>        
</tr>
<%
    Next
Else
%>
<tr>
    <td colspan="4" height="150" align="center" bgcolor="#FFFFFF"> ��ϵ� �̺�Ʈ�� �������� �ʽ��ϴ�.</td>
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