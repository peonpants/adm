<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/03_League/_Sql/LeagueSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    '### ��� ���� Ŭ����(Command) ȣ��
    Set Dber = new clsDBHelper 
    
	RS_Sports = request("RS_Sports")
	Page = request("Page")
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		var frm = document.frm1;
		
		if (frm.RL_League.value == "" )
		{
			alert("���׸��� �Է��ϼ���");
			frm.RL_League.focus();
			return;
		}
        
        frm.action = "Regist_Proc.asp";
        frm.target    = "uploadIFm";
        frm.method = "post";
		frm.submit();
	}
    
    function ImageUpload()
  	{
  	
        document.getElementById("uploadImage").src = document.getElementById("uploadImgName").value ;   	        
        document.getElementById("uploadImage").style.display = "";
        
  	}    
  		
</SCRIPT>

</head>

<body topmargin="0" marginheight="0">

<form name="frm1" id="frm1" method="post" action="Regist_Proc.asp">
<input type="Hidden" name="Process" value="I">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">���Ӹ��� ����</font><font color="ffffff">&nbsp;&nbsp;�� ���Ӹ��� ���</font></b></td></tr></table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>���� ����</b></td>
	<td colspan="3">
	<select name="RL_Sports">
	
<%	
		    	    
    SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
        
    Set Rs = Dber.ExecSQLReturnRS(SQLR,nothing,nothing) 
    	    
		RSCount = RS.RecordCount

		FOR a =1 TO RSCount
		
			RLS = RS(0) 
	%>
	<option value="<%=RLS%>" <% IF REQUEST("RL_Sports") = RLS THEN%>SELECTED<% END IF %>><%=RLS%></option>
	<%
		RS.movenext
		NEXT
		
		RS.Close
		Set RS=Nothing	
	%>		
		</select></td></tr>
<tr>
    <td bgcolor="e7e7e7" align="center" width="120" nowrap><b>���� ���׸�</b></td>
	<td colspan="3"><input type="text" name="RL_League" style="width:400px;border:1px solid #999999;" maxlength="100"></td>
</tr>
<tr>
    <td bgcolor="e7e7e7" align="center" width="120" nowrap><b>���� ���׸�(�ѱ�)</b></td>
	<td colspan="3"><input type="text" name="RL_KR_League" style="width:400px;border:1px solid #999999;" maxlength="100"></td>
</tr>
<tr>
    <td bgcolor="e7e7e7" align="center" width="120" nowrap><b>���� ������</b></td>
	<td colspan="3">
	<input type="text" name="uploadImgName"  id="uploadImgName" value=""  onchange="ImageUpload();"  style="width:400px;border:1px solid #999999;" maxlength="70">
	<input type="button" onclick="window.open('http://imgur.com/')" value="�̹������ε�" />
	<br />
    <img src="" id="uploadImage" width="20" height="20" style="display:none;" />
	</td>
</tr>
</table>
<br>
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td align="center"> 
	    <input type="button" value=" �� �� " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	    <input type="reset" value=" �� �� " onclick="javascript:document.frm1.reset();" style="border: 1 solid; background-color: #C5BEBD;">
	    <input type="button" value=" �� �� "  onclick="window.location='List.asp?page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;">
    </td>
</tr>
</table>
</form>
<br />
<img src="guide.jpg" />
	
<iframe id="uploadIFm" name="uploadIFm" width="0" height="0" frameborder="0"></iframe>
</body>
</html>
<%
	Dber.Dispose
	Set Dber = Nothing 		
%>