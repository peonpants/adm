<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ������ ���� �α� �θ�                    ################	
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, request.Cookies("AdminID"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("�������� ���� �ٶ��ϴ�.");
    </script>
<%    
        response.End
    End IF
    
    IA_CASH = dfCpSql.RsOne("IA_CASH") ' �������� ȯ���� ĳ�� �ݾ�
    IA_Percent = dfCpSql.RsOne("IA_Percent")/100 ' Ŀ�̼� ����
    IA_Type = dfCpSql.RsOne("IA_Type") ' 1:���� 2:����
    outCash = 0
    '######### �ش� ����Ʈ ĳ�� ������ ������                    ################	
    Call dfCpSql.GetAdminTotalCash(dfDBConn.Conn)
    
    IF dfCpSql.RsCount <> 0 Then
        For i = 0 to dfCpSql.RsCount -1 
            IF cStr(IA_Type) = "2" Then
                IF dfCpSql.Rs(i, "lc_contents") = "���ù��" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "��������" Then
                    tempCash2 = -dfCpSql.Rs(i, "lc_cash")
                End IF
                   
            ElseIF cStr(IA_Type) = "1" Then               
                IF dfCpSql.Rs(i, "lc_contents") = "ȯ������" Then
                    tempCash1 = dfCpSql.Rs(i, "lc_cash")
                ElseIF dfCpSql.Rs(i, "lc_contents") = "�Ӵ�����" Then
                    tempCash2 = -dfCpSql.Rs(i, "lc_cash")
                End IF                     
            End IF
        Next
        outCash = -(tempCash1 -(tempCash2))
    End IF
    'response.Write tempCash1  & "<br>"
    'response.Write (tempCash2) & "<br>"
    'response.Write (outCash)* IA_Percent & "<br>"

    outCash = (outCash) * IA_Percent
    outCash = outCash - IA_CASH
    
    //�ڽ��� �α׸� ������ �´�
    Call dfCpSql.RetrieveAdminCashLog(dfDBConn.Conn, request.Cookies("AdminID"))
%>    
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script type="text/javascript">

function isNumber(s) {
  s += ''; // ���ڿ��� ��ȯ
  s = s.replace(/^\s*|\s*$/g, ''); // �¿� ���� ����
  if (s == '' || isNaN(s)) return false;
  
  if(s < 1 || s > <%= outCash %>)  return false; 
  return true;
}

function checkNumber(s)
{
    if(!isNumber(s)) 
    {
        alert("���� 1 ~ <%= outCash %>���� �Է��ϼ���");
        frm1.cash.value = "" ;
    }        
}

function checkForm(form)
{
    if(form.cash.value == "" || form.cash.value == "0" )
    {
        alert("ȯ���ݾ��� �Է��ϼ���");
         form.cash.value = "" ;
        return false;
    }
    form.target = "hidden_page";   
}
</script>
</head>

<body topmargin="0" marginheight="0">

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">����������</font><font color="ffffff">&nbsp;&nbsp;��  ȯ�� ��û </font></td></tr></table><br>

<form name="frm1" method="post" action="Admin_CashOutProc.asp" onsubmit="return checkForm(this);">
<input type="hidden" name="type" value="add" />
<table  border="0"  cellspacing="1" cellpadding="3" bgcolor="AAAAAA"  width="100%">
<tr bgcolor="#FFFFFF" height="30">
    <td width="150">ȯ�����ɱݾ�</td>    
    <td width="350">
        <%= FormatNumber(outCash,0) %>��
    </td>    
</tr>
<tr bgcolor="#FFFFFF" height="30">
    <td width="150">ȯ���ݾ�</td>    
    <td width="350">
        <input type="text" name="cash" class="input1" value="<%= outCash %>"  onkeyup="checkNumber(this.value)" />��
    </td>    
</tr>
<tr bgcolor="#FFFFFF" height="30">
    <td colspan="2">
        <input type="submit" value='ȯ����û' />
    </td>    
</tr>
</table>      
</form>
<table  border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
	    <tr>

		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>������ID</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>ȯ����</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>����</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>��û�ð�</b></font>
          </td>
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>�Աݽð�</b></font>
          </td>                              
		</tr>
	
		<%		
            IF dfCpSql.RsCount <> 0 Then
                For i = 0 to dfCpSql.RsCount - 1
        %>
			<tr>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql.Rs(i, "adminID") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql.Rs(i, "OutCash") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%
				IF dfCpSql.Rs(i, "Status") = 0 Then
				    response.Write "ó����"
                ElseIF dfCpSql.Rs(i, "Status") = 1 Then
                    response.Write "ó���Ϸ�"
				End IF
				%>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				&nbsp;<%= dfCpSql.Rs(i, "regdate") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				&nbsp;<%= dfCpSql.Rs(i, "outDate") %>
			  </td> 			  
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" bgcolor="FFFFFF">
			    ȯ�� ���� �����ϴ�.
			  </td>
			</tr>
		<%
			End IF
	    %>
     
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

