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
    Call dfCpSql.RetrieveINFO_ADMIN(dfDBConn.Conn, request.Cookies("GROUP"), request.Cookies("AdminLevel"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("�������� ���� �ٶ��ϴ�.");
    </script>
<%    
        response.End
    End IF
    
    Call dfCpSql.RetrieveAdminCashLog(dfDBConn.Conn, request.Cookies("AdminID"))
%>    
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
</head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">����������</font><font color="ffffff">&nbsp;&nbsp;��  ȯ�� ����Ʈ</font></td></tr></table><br>


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
		  <td align="center" bgcolor="706E6E">
		    <font color = "white"><b>ó��</b></font>
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
			  <td align="center" bgcolor="FFFFFF">
				<input type="button" value="�Ա�" onclick="hidden_page.location.href('Admin_CashOutProc.asp?type=modify&id=<%= dfCpSql.Rs(i, "id") %>');" />
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

