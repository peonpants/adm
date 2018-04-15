<!-- #include virtual="/_Common/Inc/top.inc.asp" --->
<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    IF request.Cookies("AdminLevel")  <> 1 Then
        response.End
    End IF
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 관리자 접속 로그 부름                    ################	
    
    Set dfcpSql1 = new cpSql    
    Call dfcpSql1.RetrieveCHK_ADMIN(dfDBConn.Conn)
%>

	  <table  border="0" bgcolor="#AAAAAA" cellspacing="1" cellpadding="5"  width="100%">
	    <tr>
		  <td align="center" bgcolor="EEEEEE">
		    번호
          </td>
		  <td align="center" bgcolor="EEEEEE">
		    관리자 아이디[실패아이디 포함]
          </td>
		  <td align="center" bgcolor="EEEEEE">
		    관리자 I.P
          </td>
		  <td align="center" bgcolor="EEEEEE">
		    관리자 접속시간
          </td>
		  <td align="center" bgcolor="EEEEEE">
		    성공실패
          </td>          
		</tr>
		<%		
            IF dfCpSql1.RsCount <> 0 Then
                For i = 0 to dfCpSql1.RsCount - 1
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
				<%
				IF dfCpSql1.Rs(i, "AD_LOGIN") = 1 Then
				    response.Write "성공"
				Else
				    response.Write "실패"
				End IF
				%>
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

<!-- #include virtual="/_Common/Inc/footer.inc.asp" --->