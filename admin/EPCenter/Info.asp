<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	'SQLMSG = "SELECT IA_BankNum, IA_BankName, IA_BankOwner FROM INFO_ADMIN WHERE IA_ID = '"& AdminID &"' AND IA_Level = 1 "
	'SET RS = DbCon.Execute(SQLMSG)

	'IA_BankNum		= RS(0)
	'IA_BankName		= RS(1)
	'IA_BankOwner	= RS(2)

	'RS.Close
	'Set RS = Nothing
%>

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
        var data=new Array('1','2','3','4','5','6','7','8','9','0');
          form.code.value="";

        for (i=0 ;i < 6 ;i++)
          {
            form.code.value=form.code.value + data[Math.floor(Math.random()*10)];
          }
      }  
	
</script>
</head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">����������</font><font color="ffffff">&nbsp;&nbsp;��  ������ ��������</font></td></tr></table><br>

<table><tr><td> * ��й�ȣ�� �����ʿ�� �Է��Ͻø�...������ �˴ϴ�.</td></tr></table>
<table>
  <tr>
    <td>
      <form name="frm1" method="post" action="Info_Proc.asp">
      <input type="hidden" name="IA_Level" value="1">
      <table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="500">
        <tr>
		  <td colspan="2" height="30" align="center" bgcolor="706E6E"><font color="white"><b>�����Ͱ�����</b></font></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>I D</b></td>
	      <td width="350"><input type="text" name="IA_ID" value="<%=AdminID%>" style="width:200px;border:1px solid #cacaca;"></td>
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
		    <input type="text" name="IA_BankNum" value="<%=IA_BankNum%>" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�Ա�����</b></td>
	      <td>
		    <input type="text" name="IA_BankName" value="<%=IA_BankName%>" style="width:330px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>�� �� ��</b></td>
	      <td>
		    <input type="text" name="IA_BankOwner" value="<%=IA_BankOwner%>" style="width:330px;border:1px solid #cacaca;">
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
		    <input type="button" value=" �� �� " onclick="chgAdminInfo1();" style="border:1 solid;">
		  </td>
		</tr>
		<TR>
		  <td>
		    <table width="760" border="0" cellspacing="0" cellpadding="0">
              <form name="frm1" method="post" onsubmit="return FrmChk1();" target="hidden_page">
              <input type="hidden" name="mode" value="addUniqCode">
              <input type="hidden" name="ChkID" value="0">
              <input type="hidden" name="ChkNN" value="0">
              <tr>
                <td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
	              <table width="746" border=0 cellSpacing=1>
                    <tr>
	                  <td height="25" align=left bgColor=#B9B9B9 style="PADDING-RIGHT: 20px; PADDING-LEFT: 20px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" class="text11">
		                <STRONG class="text12"><FONT COLOR="#FFFFFF">�� ��õ�� ���̵� ����</FONT></STRONG>
		              </td>
                    </tr>
	                <tr>
	                  <td align=left style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
		                <table width="100%" border="2" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1">
		                  <tr>
			                <td height="25" align=center bgColor=#ffffff style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
			                  <table width="81%" border="0" cellspacing="2" cellpadding="5">
                                <!--<input type="radio" name="JoinSite" value="Eproto" Checked> �������� <input type="radio" name="JoinSite" value="Pluswin"> �÷�����</td></tr>-->			
			                    <tr>
			                      <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
			                        <strong>ȸ�� ���̵�</strong>
			                      </td>
				                  <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				                    <input name="IU_ID" style="WIDTH: 150px; HEIGHT: 20px" maxLength="12" class="box2">&nbsp;
				                      <IMG onclick="idDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;����,���� 4~12�� (Ư�����ںҰ�)
				                  </td>
				                </tr>
			                    <tr>
			                      <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
			                        <strong>����ũ �ڵ�</strong>
			                      </td>
				                  <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				                    <input name="IU_CODE" style="WIDTH: 300px; HEIGHT: 20px" class="box2" readonly>
				                    <input type="button" style="color:000000;" value="����ũ �ڵ� ����" onclick="setUniqCode();">
				                  </td>
				                </tr>	
			                    <tr>
			                      <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
			                        <strong>ȸ������ URL</strong>
			                      </td>
				                  <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				                    <div id="returnURL" style="color:#000000;"></div>
				                  </td>
				                </tr>		
			                    <tr>
			                      <td colspan=2 align=center>
							        <input type="image" src="/images/btn_enter.gif" border="0">
		                            <a href="javascript:self.close();">
		                              <img src="/images/btn_can.gif" border=0>
		                            </a>				
				                  </td>
				                </tr>
				              </table>
				            </td>
				          </tr>
				        </table>
				      </td>
				    </tr>
				  </td>
				</form>
		      </tr>
		    </table>
		  </td>
		</tr>
        <tr>
          <td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
          </td>
        </tr>
        </table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>
		  </td>
		</TR>
      </table>
	  </form>
    </td>
	<td valign=top>
	  <table  border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="500">
	    <tr>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>��ȣ</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>������ ���̵�[���о��̵� ����]</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>������ I.P</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>������ ���ӽð�</b></font>
          </td>
		</tr>
		<%
			SQLMSG = " SELECT ROW_NUM, SEQ, AD_ID, AD_IP, AD_DATE FROM " & _
			"(" & _
			"SELECT ROWNUM ROW_NUM, SEQ, AD_ID, AD_IP, AD_DATE FROM " & _
			"(" & _
			"	SELECT " & _
			"		   SEQ, AD_ID, AD_IP, AD_DATE" & _
			"	FROM" & _
			"		CHK_ADMIN" & _
			"	ORDER BY SEQ DESC" & _
			")" & _
			")" & _
			"WHERE ROW_NUM <= 10 "
			
			SET srs = Server.CreateObject("ADODB.Recordset") 
			srs.Open SQLMSG, DbCon
			
				
				if Not srs.Bof Or srs.Eof Then
					Do Until sRs.Eof
			%>
			<tr>
			  <td align="center" bgcolor="FFFFFF">
				<%= sRs(0) %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= sRs(2) %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= sRs(3) %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= sRs(4) %>
			  </td>
			</tr>
			<%
			   sRs.MoveNext
			    Loop
				End IF
		   
	            DbCon.Close
	            Set DbCon=Nothing
		    %>
	      
	  </table>
	</td>
  </tr>
</table>

</body>
</html>

