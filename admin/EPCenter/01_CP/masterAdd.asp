<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script>
	function chgAdminInfo1() 
	  {
		document.frm1.submit();
	  }
	
	function chgAdminInfo2() 
	  {
		document.frm2.submit();
	  }
	
	function chgAdminInfo3() 
	  {
		document.frm3.submit();
	  }
	
    function rand() 
      {
        var data=new Array('Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K',

                           'L','Z','X','C','V','B','N','M','?','1','2','3','4','5','6','7','8','9','0');

        form.code.value="";

        for (i=0 ;i < 6 ;i++)
          {

            form.code.value=form.txt.value + data[Math.floor(Math.random()*37)];

          }

      }
    function commit()
	  {
	    top.HiddenFrm.location.href="board_excel.asp"
	  }


</script></head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">����������</font><font color="ffffff">&nbsp;&nbsp;��  �������߰�</font></td></tr>
</table><br>


<table>
  <tr>
    <td>
       
      <form name="frm1" method="post" action="Info_Proc.asp">
    <!--  <input type="hidden" name="IA_Level" value="<%= request.Cookies("AdminLevel")+1 %>">     --> 
      <input type="hidden" name="type" value="add">
	  <input type="hidden" name="IA_CalMethod" value=1>
	  <input type="hidden" name="IA_Percent" value=100>
	  <input type="hidden" name="IA_GROUP2" value="0">
	  <input type="hidden" name="IA_GROUP3" value="0">
	  <input type="hidden" name="IA_GROUP4" value="0">
      <table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="500">
        <tr>
		  <td colspan="2" height="30" align="center" bgcolor="706E6E"><font color="white"><b>������</b></font></td>
		</tr>
        <tr>
		  <td colspan="2" height="30" align="left" bgcolor="red"><font color="white"><b>**������������ ������ �ǽð� ���ϸ����� 0���� �����ؾ� �˴ϴ�(������ ���ϸ����� ���������������� �Է�)</br>**�����/����/�κ���/����/���� �ܰ�� ������ ���͸� �ǹ��մϴ�.</br>**������� �Ϻ������� ����׷��� 0���� ����, ����/�κ���/����/����׷��� 1���� ����(�׷��� ��ġ�� �ʰ� ����)</b></font></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>I D</b></td>
	      <td width="350"><input type="text" name="IA_ID" value="" style="width:200px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>Password</b></td>
	      <td>
		    <input type="password" name="IA_PW" value="" style="width:200px;border:1px solid #cacaca;">
	      </td>
		</tr>
        <tr>
		  <td colspan="2" height="5">&nbsp;</td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�Աݰ���</b></td>
	      <td>
		    <input type="text" name="IA_BankNum" value="" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�Ա�����</b></td>
	      <td>
		    <input type="text" name="IA_BankName" value="" style="width:330px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�� �� ��</b></td>
	      <td>
		    <input type="text" name="IA_BankOwner" value="" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�����ڵ�</b></td>
	      <td>
		    <input type="text" name="IA_Site" value="" style="width:330px;border:1px solid #cacaca;">
			������ �����ڵ�� ����Ʈ�������� ������ �����մϴ�
		  </td>
		</tr>		
		<tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>���η���</b></td>
	      <td>
		    <input type="text" name="IA_Level" style="width:330px;border:1px solid #cacaca;" value="4">
			�����1, ����2, �κ���3, ����4, ����5�� �Է�(�⺻�� ����)
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>����/����׷챸��</b></td>
	      <td>
		    <input type="text" name="IA_GROUP" style="width:330px;border:1px solid #cacaca;" value=1>
		    ����� �Ϻ������� 1��, ����� �Ϻ� ����� 2���� �Է�
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>����׷�</b></td>
	      <td>
		    <input type="text" name="IA_GROUP1" style="width:330px;border:1px solid #cacaca;" value=0>
		    ����� �Ϻ� �����Ͻ� �׷��� �����մϴ� 1������ ����/����� �Ϻ������� 0�� �Է�
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>���������ϸ���</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" value="0" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0�̻� 100���Ϸ� �Է��ϼ���(�Ҽ�������)</br>���������ΰ�� �������� ���ϸ����Է�, �ǽð����ϸ����� 0���� �Է�
		  </td>
		</tr>
		<tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�ǽð����ϸ���</b></td>
	      <td>
		    <input type="text" name="IA_LivePercent" value="0" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0�̻� 100���Ϸ� �Է��ϼ���(�Ҽ�������)</br>���������ΰ�� �������� ���ϸ����Է�, �ǽð����ϸ����� 0���� �Է�
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>���ϸ��� Ÿ��</b></td>
	      <td>
		    <select name="IA_type">
		        <option value=1>��������(�Ա�-���)</option>
		        <option value=2>�Ѹ�����(���� �ݾ�)</option>
		    </select>
		  </td>
		</tr>					
	  </table>
	  <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
		  <td>
		    <img src="blank.gif" border="0" width="1" height="10">
	      </td>
		</tr>
        <tr>
		  <td align="right">
		    <input type="button" value="  �������߰�  " style="border:1 solid;" onclick="chgAdminInfo1();" />
		  </td>
		</tr>
      </table>
	  </form>
    </td>
	
  </tr>

 </table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>
		  </td>
		</TR>
      </table>
	  
    </td>
    </td>
  </tr>
</table>

</body>
</html>

