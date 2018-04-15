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
    Call dfcpSql1.RetrieveCHK_ADMIN(dfDBConn.Conn)
%>
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<script type="text/javascript">

    function addMaster()
    {
        location.href = "masterAdd.asp" ;
    }	  
    function goMasterList()
    {
        location.href = "masterList.asp" ;
    }
</script>

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
		    관리자 아이디[실패아이디 포함]
          </td>
		  <td align="center" bgcolor="eeeeee">
		    관리자 I.P
          </td>
		  <td align="center" bgcolor="eeeeee">
		    관리자 접속시간
          </td>
		  <td align="center" bgcolor="eeeeee">
		    성공실패
          </td>          
		</tr>
		<%		
            IF dfCpSql1.RsCount <> 0 Then
                For i = 0 to dfCpSql1.RsCount - 1
                
                    IF dfCpSql1.Rs(i, "AD_LOGIN") = 0 Then
                        txtAD_LOGIN = "실패"
                    Else
                        txtAD_LOGIN = "성공"
                    End IF                        
        %>
			<tr>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "SEQ") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "AD_ID") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "AD_IP") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= dfCpSql1.Rs(i, "AD_DATE") %>
			  </td>
			  <td align="center" bgcolor="FFFFFF">
				<%= txtAD_LOGIN %>
			  </td>			  
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" bgcolor="FFFFFF">
			    접속된 I.P가 없습니다.
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
<div align="right">
        <input type="button" value="  관리자 추가  " style="border:1 solid;" onclick="addMaster();" />
        <input type="button" value="  관리자 리스트보기  " style="border:1 solid;" onclick="goMasterList();" />
</div>
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

