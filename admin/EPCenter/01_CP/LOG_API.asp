<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 관리자 접속 로그 부름                    ################	
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, "admin")
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("초기 관리자 값이 설정되지 않았습니다.");
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
    <td><b class="text07"> 관리자 접속 로그</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

	  <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	    <tr>
		  <td align="center" bgcolor="eeeeee">
		    번호
          </td>
		  <td align="center" bgcolor="eeeeee">
		    타입
          </td>
		  <td align="center" bgcolor="eeeeee">
		    결과
          </td>

		  <td align="center" bgcolor="eeeeee">
		    반환값
          </td>          
		  <td align="center" bgcolor="eeeeee">
		    등록시간
          </td>    
		</tr>
		<%		
            IF dfCpSql1.RsCount <> 0 Then
                For i = 0 to dfCpSql1.RsCount - 1
                
                    IF dfCpSql1.Rs(i, "LA_RESULT") = "Fail" Then
                        txtLA_RESULT = "실패"
                    Else
                        txtLA_RESULT = "성공"
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
			    등록된 API로그가 없습니다
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

