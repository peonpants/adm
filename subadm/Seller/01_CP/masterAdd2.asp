<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	IA_SITE = Session("rJOBSITE")
	master_id = REQUEST("master_id")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&master_id&"' order by IA_GROUP3 desc"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_Type = RS2("IA_Type")
	IA_ID = RS2("IA_ID")

	SQLLIST2 = "select top 1 * from info_admin where IA_GROUP3 = '"&IA_GROUP3&"' order by IA_GROUP4 desc"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)
	
	IA_GROUP4 = RS2("IA_GROUP4") + 1

%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="../Css/style1.css">
<script src="/Sc/Base.js"></script>
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- ��ڸ޴� ��Ÿ�� �׸�  ----------------->

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

</script></head>

<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> �� </span>
		 ��Ʈ�ʰ��� <span style="color:#666666">- ��Ʈ���߰�</span>
	</div>



	<div class="h_5"></div>
	<div class="h_5"></div>

<div class="panel panel-success">
  <div class="panel-heading">
	<font color="#666666"><b>��Ʈ���߰�(<% IF IA_LEVEL = "1" THEN%>
					����
				<% ELSEIF IA_LEVEL = "2" THEN%>
					����
				<% ELSEIF IA_LEVEL = "3" THEN%>
					�κ���
				<% ELSEIF IA_LEVEL = "4" THEN%>
					����
				<% ELSEIF IA_LEVEL = "5" THEN%>
					����
				<% END IF%><%=IA_ID%>)</b></font>
	</div>
  <div class="panel-body">
 
      <form name="frm1" method="post" action="Info_Proc.asp">
      <input type="hidden" name="type" value="add">
	  <input type="hidden" name="IA_CalMethod" value=1>
	  <input type="hidden" name="IA_Percent" value=100>
	  <input type="hidden" name="IA_GROUP"  value="<%=IA_GROUP%>">
	  <input type="hidden" name="IA_GROUP1" value="<%=IA_GROUP1%>">
	  <input type="hidden" name="IA_GROUP2" value="<%=IA_GROUP2%>">
	  <input type="hidden" name="IA_GROUP3" value="<%=IA_GROUP3%>">
	  <input type="hidden" name="IA_GROUP4" value="<%=IA_GROUP4%>">
	  <input type="hidden" name="IA_Level" value="<%=IA_Level+1%>">
	</div>
 

      <table class="table"> 
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>��Ʈ��I D</b></td>
	      <td width="350"><input type="text" name="IA_ID" value="" style="width:200px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>��Ʈ��Password</b></td>
	      <td>
		    <input type="password" name="IA_PW" value="" style="width:200px;border:1px solid #cacaca;">
	      </td>
		</tr>
        <tr>
		  <td colspan="2" height="5">&nbsp;</td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>��Ʈ�ʴг���</b></td>
	      <td>
		    <input type="text" name="IA_NICKNAME" value="" style="width:200px;border:1px solid #cacaca;">
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
<% If IA_TYPE = 1 Then %>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>Ŀ�̼�</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" style="width:330px;border:1px solid #cacaca;" value="0">
			<input type="hidden" name="IA_LivePercent" value="0">
			<input type="hidden" name="IA_type" value="1">
		    </br>0�̻� �Է�(�ڽ��� Ŀ�̼� �̻��� �����������ϴ�)</BR>
		  </td>
		</tr>
<% Else %>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>���������ϸ���</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0�̻� 100���Ϸ� �Է��ϼ���(�Ҽ�������)</br>���������ΰ�� �������� ���ϸ����Է�, �ǽð����ϸ����� 0���� �Է�
		  </td>
		</tr>
		<tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�ǽð����ϸ���</b></td>
	      <td>
		    <input type="text" name="IA_LivePercent" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0�̻� 100���Ϸ� �Է��ϼ���(�Ҽ�������)</br>���������ΰ�� �������� ���ϸ����Է�, �ǽð����ϸ����� 0���� �Է�
		  </td>
		</tr>
		<input type="hidden" name="IA_type" value="2">
<% End If %>	
	  </table>

  </div>
<div class="alert alert-danger" role="alert"><b>**��Ʈ�� �߰��� �Ϻ��� Ŀ�̼��� �ڽ��� Ŀ�̼��� �����������ϴ�</br>**�ڽ��� �������� ���������ϰ�� �Ϻδ� �ٸ��������� �����Ҽ������ϴ�</b></div>

<table>
  <tr>
    <td>



	  <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
		  <td>
		    <img src="blank.gif" border="0" width="1" height="10">
	      </td>
		</tr>
        <tr>
		  <td align="right">
		    <input type="button" value="<% IF IA_LEVEL = "2" THEN%>�κ���<% ELSEIF IA_LEVEL = "3" THEN%>����<% ELSEIF IA_LEVEL = "4" THEN%>����<% END IF%>�߰�" style="border:1 solid;" onclick="chgAdminInfo1();" class="btn btn-success btn-sm" />
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

