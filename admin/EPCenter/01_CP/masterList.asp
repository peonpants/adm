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
    Call dfCpSql.RetrieveINFO_ADMIN(dfDBConn.Conn, 0, request.Cookies("AdminLevel"))
    
    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
        alert("정상적인 접근 바랍니다.");
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
    <td><b class="text07"> 관리자 접속 로그</b></td>
</tr>
</table>    
<div style="height:10px;"></div>


 <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
		    마스터관리자
          </td>
		  <td align="center">
		    Password
          </td>
		  <td align="center">
		    입금계좌
          </td>
		  <td align="center">
		    입금은행
          </td>
		  <td align="center">
		    예 금 주
          </td> 
		  <td align="center">
		    운영본사그룹
          </td>
		  <td align="center">
		    본사그룹
          </td>
		  <td align="center">
		    부본사그룹
          </td>
		  <td align="center">
		    총판그룹
          </td>
		  <td align="center">
		    매장그룹
          </td>
		  <td align="center">
		    사이트
          </td>

		  <td align="center">
		    사이트구분
          </td>
		  <td align="center">
		    정산방식
          </td>
		  <td align="center">
		    적립캐쉬
          </td>
		  <td align="center">
		    커미션(스포츠)
          </td>
		  <td align="center">
		    커미션(실시간)
          </td>
		  <td align="center">
		    수정/삭제
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
					운영본사
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "2" THEN%>
					본사
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "3" THEN%>
					부본사
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "4" THEN%>
					총판
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "5" THEN%>
					매장
				<% END IF%>
			  </td>
			  <td align="center" >
				<% IF dfCpSql.Rs(i, "IA_Type") = "1" THEN%>
					수익정산
				<% ELSEIF dfCpSql.Rs(i, "IA_Type") = "2" THEN%>
					롤링정산
				<% END IF%>			  
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_CASH") %>원
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
				<input type="button" value="수정"  style="border:1 solid;" onclick="location.href('masterUpdate.asp?IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				<%
				    IF dfCpSql.Rs(i, "IA_ID") <> "admin" Then  
                %>
				<input type="button" value="삭제"  style="border:1 solid;" onclick="location.href('Info_Proc.asp?type=del&IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				
				<%			    
				    End IF
			    ElseIF request.Cookies("AdminLevel") <> dfCpSql.Rs(i,"IA_LEVEL") Then
			  %>
				<input type="button" value="수정"  style="border:1 solid;" onclick="location.href('masterUpdate.asp?IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
				<input type="button" value="삭제"  style="border:1 solid;" onclick="location.href('Info_Proc.asp?type=del&IA_ID=<%= dfCpSql.Rs(i, "IA_ID") %>');" />
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
			    추가된 관리자가 없습니다.
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

