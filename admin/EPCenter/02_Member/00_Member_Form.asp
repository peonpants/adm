<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<HTML>
<HEAD><TITLE>���ѹα� �ְ��� ���� ����Ʈ</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">
<LINK href="/_Common/inc/css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="/js/func.js" type=text/javascript></SCRIPT>
<SCRIPT src="/js/calendar.js" type=text/javascript></SCRIPT>
<META content="MSHTML 6.00.6000.16757" name=GENERATOR>
<script language="JavaScript" src="/Sc/Function.js"></script>
<script>
	function FrmChk1() {
		var frm = document.frm1;
		
		// id�ߺ�üũ
		if (frm.ChkID.value != 1) {
			alert(" ���̵� �ߺ�üũ�� ���ּ���.");
			frm.IU_ID.focus();
			return false;
		}
				
		// ���̵� üũ [���� üũ�ÿ��� ��] 
		if ((frm.IU_ID.value.length == 0) || (frm.IU_ID.value.length < 4) || (frm.IU_ID.value.length >12))	{
			alert(" ����Ͻ� ���̵� ��Ȯ�� �־��ּ���.\n���̵�� 4~12������ �Է��� �����մϴ�.");
			frm.IU_ID.focus();
			return false;
		}
		else if ( EnNumCheck(frm.IU_ID.value) == false)	{
			alert(" ���̵�� ������� ����� ���ڷθ� �Է��� �����մϴ�.");
			frm.IU_ID.focus();
			return false;
		}
		
		// ��й�ȣ üũ
		if ((frm.IU_PW.value.length == 0) || (frm.IU_PW.value.length < 4) || (frm.IU_PW.value.length > 10) )	{
			alert(" ����Ͻ� ��й�ȣ�� ��Ȯ�� �־��ּ���.\n��й�ȣ�� 4~10�� ������ �Է��� �����մϴ�.");
			frm.IU_PW.select();
			frm.IU_PW.focus();
			return false;
		}
		
		if (EnNumCheck(frm.IU_PW.value) == false)	{
			alert(" ��й�ȣ�� ������� ����� ���ڷθ� �Է��� �����մϴ�.");
			frm.IU_PW.focus();
			return false;
		}
		
		// �г���üũ
		if ((frm.IU_NickName.value.length == 0) || (frm.IU_NickName.value.length < 3) || (frm.IU_NickName.value.length >10))	{
			alert(" �г����� ��Ȯ�� �־��ּ���.\n�г����� 3~10������ �Է��� �����մϴ�.");
			frm.IU_NickName.focus();
			return false;
		}

		// �г����ߺ�üũ
		if (frm.ChkNN.value != 1) {
			alert(" ���̵� �ߺ�üũ�� ���ּ���.");
			frm.IU_NickName.focus();
			return false;
		}
		
		if (frm.IU_BankName.value == "" )	{
			alert("������� ��Ȯ�ϰ� �Է����ּ���.");
			frm.IU_BankName.focus();
			return false;
		}
		
		if ((frm.IU_BankNum.value == "" ) || (frm.IU_BankNum.value.length < 10))	{
			alert("���¹�ȣ�� ��Ȯ�ϰ� �Է����ּ���.");
			frm.IU_BankNum.focus();
			return false;
		}
		
		if (NumDash(frm.IU_BankNum.value) == false)		{
			alert("���¹�ȣ�� ���ڿ� '-' ���� ����ؼ� �Է����ּ���.");
			frm.IU_BankNum.value = "";
			frm.IU_BankNum.focus();
			return false;
		}
		
		if ((frm.IU_BankOwner.value == "" ) || (frm.IU_BankOwner.value.length < 2))	{
			alert("�����ָ�  ��Ȯ�ϰ� �Է����ּ���.");
			frm.IU_BankOwner.focus();
			return false;
		}
		
		// Email ����üũ
		if (frm.Email1.value == "" ) {
			alert("�̸����� ��Ȯ�ϰ� �Է����ּ���.");
			frm.Email1.focus();
			return false;
		}
		
		if (frm.Email3.value == "" ) {
			alert("�̸����� ��Ȯ�ϰ� �Է����ּ���.");
			frm.Email2.focus();
			return false;
		}
		
		// �ڵ��� üũ
		if (IsPhoneChek(frm.IU_Mobile2.value) == false) {
			alert(" �ڵ�����ȣ�� ��Ȯ�� �Է����ּ���.");
			frm.IU_Mobile2.value="";
			frm.IU_Mobile2.focus();
			return false;
		}
		if (IsPhoneChek(frm.IU_Mobile3.value) == false) {
			alert("�ڵ�����ȣ�� ��Ȯ�� �Է����ּ���.");
			frm.IU_Mobile3.value="";
			frm.IU_Mobile3.focus();
			return false;
		}
		
		frm.action = "00_Member_Proc.asp";
		return true;
	}
	
	function idDblChk() {
		var frm = document.frm1;
		
		if (frm.IU_ID.value == "" ) {
			alert("�ߺ�üũ�Ͻ� ���̵� �����ּ���.");
			frm.IU_ID.focus();
			return false;
		}
		else
		{
			top.hidden_page.location.href="00_Member_Check.asp?IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";
		}
	}

	function nnDblChk() {
		var frm = document.frm1;
		
		if (frm.IU_NickName.value == "" ) {
			alert("�ߺ�üũ�Ͻ� �г����� �����ּ���.");
			frm.IU_NickName.focus();
			return false;
		}
		else
		{
			top.hidden_page.location.href="00_Member_Check.asp?IU_NickName="+frm.IU_NickName.value+"&IU_SITE="+frm.JoinSite.value+"";
		}
	}

	function clickemail() {
		var frm = document.frm1;
		
		frm1.Email3.readOnly = true;
		frm1.Email3.value = frm1.Email2[frm1.Email2.selectedIndex].value;
		if (frm1.Email2[0].selected)
		{
			frm1.Email3.readOnly = false;
		}
	}
	
</script></HEAD>

<BODY bgColor=#ffffff leftMargin=0 topMargin=0>

<table width="760" border="0" cellspacing="0" cellpadding="0">
<form name="frm1" method="post" onsubmit="return FrmChk1();">
<input type="hidden" name="EMODE" value="MEMADD">
<input type="hidden" name="ChkID" value="0">
<input type="hidden" name="ChkNN" value="0">
  <tr>
    <td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
	  <table width="746" border=0 cellSpacing=1>
	    <tr>
		  <td height="25" align=left bgColor=#B9B9B9 style="PADDING-RIGHT: 20px; PADDING-LEFT: 20px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" class="text11">
		    <STRONG class="text12"><FONT COLOR="#FFFFFF">�� ȸ �� �� ��</FONT></STRONG>
	      </td>
		</tr>
	    <tr>
		  <td align=left style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
		    <table width="100%" border="2" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1">
		      <tr>
			    <td height="25" align=center bgColor=#ffffff style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
			      <table width="81%" border="0" cellspacing="2" cellpadding="5">
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>�� �� Ʈ ��</strong>
				      </td>
				      <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				        <select name="JoinSite">
				         
						<%'����Ʈ���� DB���� �ҷ��ͼ� ������ ���� ����Ʈ�� ���� 
						    'PML �� DB���� �ҷ��� ���ڵ� 
							'PMLC �� DB���� �ҷ��� ���ڵ��� ����
						   Set PML = Server.CreateObject("ADODB.Recordset")
					         PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

					         PMLC = PML.RecordCount
				   
					         IF PMLC > 0 THEN

					           FOR PM = 1 TO PMLC
				   
					             IF PML.EOF THEN
						         
								 EXIT FOR
					             END IF
                          'SITE01�� ù��° ���ڵ�
					      SITE01=PML(0) 
					    %>
				        <option value="<%=SITE01%>"><%=SITE01%></option>
				        <!--���ڵ��� ������ŭ ����Ʈ�� �ѷ��ش�.-->
						<%	PML.Movenext
					        Next
					       END IF %>
				      </select>
				      <!--<input type="radio" name="JoinSite" value="Eproto" Checked> �������� <input type="radio" name="JoinSite" value="Pluswin"> �÷�����-->
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>ȸ�� ���̵�</strong>
				      </td>
				      <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
					    <input name="IU_ID" style="WIDTH: 150px; HEIGHT: 20px" maxLength="12" class="box2">&nbsp;<IMG onclick="idDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;����,���� 4~12�� (Ư�����ںҰ�)
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>��й�ȣ</strong>
				      </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input type="password" class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_PW">
				      </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>��й�ȣȮ��</strong>
					  </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input type="password" class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_PW1">
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>�� �� ��</strong>
					  </td>
				      <td width="76%" bgcolor="#EAEAEA">
					    <input class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxLength="10" name="IU_NickName">&nbsp;
						<IMG onclick="nnDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;&nbsp;(�ѱ�,����,�������� 3~10���̳�)
					  </td>
					</tr>
			        <tr>
					  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
					    <strong>�޴�����ȣ</strong>
					</td>
				    <td width="76%" bgcolor="#EAEAEA">
				      <select name="IU_Mobile1" style="width:50px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
				        <OPTION>010</OPTION> 
				        <OPTION>011</OPTION>
				        <OPTION>016</OPTION> 
				        <OPTION>017</OPTION>
				        <OPTION>018</OPTION> 
				        <OPTION>019</OPTION>
					  </SELECT> - 
				        <input class=box2 style="WIDTH: 50px; HEIGHT: 20px" maxLength="4" name="IU_Mobile2" onkeypress="keyCheck();"> - 
				<input class=box2 style="WIDTH: 50px; HEIGHT: 20px" maxLength="4" name="IU_Mobile3" onkeypress="keyCheck();"></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>�� �� ��</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input name="Email1" type="text" size="15" maxlength="15" width="150px" class="box2"> @ 
				<SELECT size=1 name="Email2" class="SELECT" onChange="javascript:clickemail();">	
				<option value="" selected>�����Է�</OPTION>
				<OPTION value='yahoo.co.kr'>����</OPTION>
				<OPTION value='naver.com'>���̹�</OPTION>
				<OPTION value='nate.com'>����Ʈ</OPTION>
				<OPTION value='empal.com'>����</OPTION>
				<OPTION value='freechal.com'>����ÿ</OPTION>
				<OPTION value='paran.com'>�Ķ�</OPTION>
				<OPTION value='hanmail.net'>����</OPTION>
				<OPTION value='hitel.net'>������</OPTION>
				<OPTION value='hotmail.com'>�ָ���</OPTION>
				<OPTION value='korea.com'>�ڸ���</OPTION>
				<OPTION value='lycos.co.kr'>�����ڽ�</OPTION>
				<OPTION value='chollian.net'>õ����</OPTION>
				<OPTION value='dreamwiz.com'>�帲����</OPTION>
				<OPTION value='netian.com'>�׶��</OPTION>
				<option value="hanafos.com">�ϳ�����</option></SELECT> <input type="text" size=20 maxlength="30" name="Email3" class="box2"> </td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>�� �� ��</strong></td>
				<td width="76%" bgcolor="#EAEAEA">
				<select name="IU_BankName" class="box2">
				<option value="">����</option>
				<option value="��������">��������</option>
				<option value="��������">��������</option>
				<option value="�泲����">�泲����</option>
				<option value="�������">�������</option>
				<option value="����">����</option>
				<option value="�뱸����">�뱸����</option>
				<option value="����ġ����">����ġ����</option>
				<option value="�λ�����">�λ�����</option>
				<option value="�������">�������</option>
				<option value="��ȣ��������">��ȣ��������</option>
				<option value="�������ݰ�">�������ݰ�</option>
				<option value="����">����</option>
				<option value="��������">��������</option>
				<option value="��ȯ����">��ȯ����</option>
				<option value="�츮����">�츮����</option>
				<option value="��ü��">��ü��</option>
				<option value="��������">��������</option>
				<option value="��������">��������</option>
				<option value="��������">��������</option>
				<option value="�ϳ�����">�ϳ�����</option>
				<option value="�ѹ�����">�ѹ�����</option>
				<option value="����">����</option>
				<option value="�ѱ���Ƽ����">�ѱ���Ƽ����</option>
				<option value="HSBC����">HSBC����</option>
				<option value="SC��������">SC��������</option></select></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>���¹�ȣ</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input class=box2 style="WIDTH: 150px; HEIGHT: 20px" maxlength="16" name="IU_BankNum"></td></tr>
			<tr><td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>�� �� ��</strong></td>
				<td width="76%" bgcolor="#EAEAEA"><input class=box2 style="WIDTH: 150px; HEIGHT: 20px" name="IU_BankOwner"></td></tr></table></td></tr></table></td></tr>
	<tr><td style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 20px; PADDING-TOP: 0px" align=center>
		<input type="image" src="/images/btn_enter.gif" border="0">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:self.close();"><img src="/images/btn_can.gif" border=0></a></td></form></tr></table></td></tr>
<tr><td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px"></td></tr></table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>

</BODY>
</HTML>