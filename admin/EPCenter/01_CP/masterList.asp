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
    Call dfCpSql.RetrieveINFO_ADMIN(dfDBConn.Conn, 0, request.Cookies("AdminLevel"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("�������� ���� �ٶ��ϴ�.");
    </script>
<%    
        response.End
    End IF
%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
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

</script>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ������ ���� �α�</b></td>
</tr>
</table>    
<div style="height:10px;"></div>


 <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
		    �����Ͱ�����
          </td>
		  <td align="center">
		    Password
          </td>
		  <td align="center">
		    �Աݰ���
          </td>
		  <td align="center">
		    �Ա�����
          </td>
		  <td align="center">
		    �� �� ��
          </td> 
		  <td align="center">
		    �����׷�
          </td>
		  <td align="center">
		    ����׷�
          </td>
		  <td align="center">
		    �κ���׷�
          </td>
		  <td align="center">
		    ���Ǳ׷�
          </td>
		  <td align="center">
		    ����׷�
          </td>
		  <td align="center">
		    ����Ʈ
          </td>

		  <td align="center">
		    ����Ʈ����
          </td>
		  <td align="center">
		    ������
          </td>
		  <td align="center">
		    ����ĳ��
          </td>
		  <td align="center">
		    Ŀ�̼�(������)
          </td>
		  <td align="center">
		    Ŀ�̼�(�ǽð�)
          </td>
		  <td align="center">
		    ����/����
          </td>                                        
		</tr>
	
		<%		
            IF dfCpSql.RsCount <> 0 Then
                For i = 0 to dfCpSql.RsCount - 1
        %>
			<tr height="25" bgcolor="#FFFFFFF">
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_ID") %>
			  </td>
			  <td align="center" >
				
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_BANKNUM") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_BANKNAME") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_BANKOWNER") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_GROUP") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_GROUP1") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_GROUP2") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_GROUP3") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_GROUP4") %>
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_SITE") %>
			  </td>

			  <td align="center" >
				<% IF dfCpSql.Rs(i, "IA_LEVEL") = "1" THEN%>
					�����
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "2" THEN%>
					����
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "3" THEN%>
					�κ���
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "4" THEN%>
					����
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "5" THEN%>
					����
				<% END IF%>
			  </td>
			  <td align="center" >
				<% IF dfCpSql.Rs(i, "IA_Type") = "1" THEN%>
					��������
				<% ELSEIF dfCpSql.Rs(i, "IA_Type") = "2" THEN%>
					�Ѹ�����
				<% END IF%>			  
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_CASH") %>��
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_SportsPercent") %>%
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_LivePercent") %>%
			  </td>
			  <td align="center" >
			  <%
			    IF dfCpSql.Rs(i,"IA_LEVEL") = 1 Then
			  %>
				<input type="button" value="����"  style="border:1 solid;" onclick="location.href('masterUpdate.asp?IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				<%
				    IF dfCpSql.Rs(i, "IA_ID") <> "admin" Then  
                %>
				<input type="button" value="����"  style="border:1 solid;" onclick="location.href('Info_Proc.asp?type=del&IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				
				<%			    
				    End IF
			    ElseIF request.Cookies("AdminLevel") <> dfCpSql.Rs(i,"IA_LEVEL") Then
			  %>
				<input type="button" value="����"  style="border:1 solid;" onclick="location.href('masterUpdate.asp?IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				<input type="button" value="����"  style="border:1 solid;" onclick="location.href('Info_Proc.asp?type=del&IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				<%
				Else
				    response.Write "&nbsp;"
				End IF
				%>
			  </td>						  
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" >
			    �߰��� �����ڰ� �����ϴ�.
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

