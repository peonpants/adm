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
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">
function checkForm(form)
{
    if(form.IU_ID.value == "")
    {
        alert("���̵� �Է��ϼ���.");
        return false;
    }    
    if(form.LP_CONTENTS1.value.length > 80 )
    {
        alert("�޽����� 40�� �̸��� �Է��ϼ���.");
        return false;
    }         
}
</script>
</head>
<body topmargin="0" marginheight="0">
<form method="post" action="pointGift_proc.asp" onsubmit="return checkForm(this)">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  ȸ������ �� ����Ʈ ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table cellpadding=5 cellspacing=1 border=0 width=100% bgcolor="AAAAAA">
<tr>
    <td bgcolor="#EEEEEE" width="100">���̵�</td>
    <td bgcolor="#FFFFFF">
        <textarea name="IU_ID" id="IU_ID" class="textarea_basic" style="width:700px;height:150px"></textarea>
        <br />
        ��)sjrnfl2, betman2
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="100">����</td>
    <td bgcolor="#FFFFFF">
        <input type="input" name="LP_CONTENTS1" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="100">����Ʈ</td>
    <td bgcolor="#FFFFFF">
        <input type="input" name="Amount" />
    </td>
</tr>
</table>
<table width="100%">
<tr>
    <td align="center">
    <input type="submit" value="����Ʈ����" class="input2" />    
    </td>
</tr>
</table>
</form>
<iframe name="exeFrame" width="0" height="0" frameborder="0"></iframe>
</body>
</html> 