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
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, "admin")
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("�ʱ� ������ ���� �������� �ʾҽ��ϴ�.");
    </script>
<%    
        response.End
    End IF
    
    Set dfcpSql1 = new cpSql    
    Call dfcpSql1.RetrieveLOG_API(dfDBConn.Conn)
%>
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->



<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ������ ���� �α�</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

	  <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	    <tr>
		  <td align="center" bgcolor="eeeeee">
		    ��ȣ
          </td>
		  <td align="center" bgcolor="eeeeee">
		    Ÿ��
          </td>
		  <td align="center" bgcolor="eeeeee">
		    ���
          </td>

		  <td align="center" bgcolor="eeeeee">
		    ��ȯ��
          </td>          
		  <td align="center" bgcolor="eeeeee">
		    ��Ͻð�
          </td>    
		</tr>
		<%		
            IF dfCpSql1.RsCount <> 0 Then
                For i = 0 to dfCpSql1.RsCount - 1
                
                    IF dfCpSql1.Rs(i, "LA_RESULT") = "Fail" Then
                        txtLA_RESULT = "����"
                    Else
                        txtLA_RESULT = "����"
                    End IF                        
        %>
			<tr>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "LA_IDX") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "LA_TYPE") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "LA_RESULT") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "LA_CONTENTS") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "LA_REGDATE") %>
			  </td>			  
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" bgcolor="FFFFFF">
			    ��ϵ� API�αװ� �����ϴ�
			  </td>
			</tr>
		<%
			End IF
	    %>

	  </table>
	</td>
  </tr>
 </table>
<br />

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>
		  </td>
		</TR>
      </table>
	  </form>
    </td>
    </td>
  </tr>
</table>

</body>
</html>

