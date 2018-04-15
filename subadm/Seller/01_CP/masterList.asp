<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	IA_SITE = Session("rJOBSITE")
	master_id = REQUEST("master_id")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&master_id&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_Type = RS2("IA_Type")
	IA_ID = RS2("IA_ID")
	'######### 관리자 접속 로그 부름                    ################	
    Call dfCpSql.RetrieveINFO_ADMIN_NEW(dfDBConn.Conn, IA_GROUP, IA_GROUP1, IA_LEVEL, IA_SITE)
    
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
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- 부트스트랩 추가테마 ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- 부트스트랩  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- 부트스트랩  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->




<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> ▶ </span>
		 파트너관리<span style="color:#777777;">
		 <% IF dfCpSql.Rs(i, "IA_LEVEL") = "1" THEN%>
					어드민
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "2" THEN%>
					본사
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "3" THEN%>
					부본사
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "4" THEN%>
					총판
				<% ELSEIF dfCpSql.Rs(i, "IA_LEVEL") = "5" THEN%>
					매장
				<% END IF%>(<%=master_id%>)
				</span>
	</div>


<div style="height:10px;"></div>
<div style="height:40px;"><font color="red"></div>



<div align="right">
        <input class="btn btn-success btn-sm" type="button" value="  파트너 추가  " style="border:1 solid;" onclick="addMaster();" />
</div>



 <div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >

 
  <tr bgcolor="e7e7e7" class="title-backgra">
		  <th align="center">
		    파트너아이디
          </th>
		  <th align="center">
		    파트너구분
          </th>
		  <th align="center">
		    정산방식
          </th>
<% If ia_type = 1 Then %>
		  <th align="center">
		    커미션
          </th>
<% Else %>
		  <th align="center">
		    커미션(스포츠)
          </th>
		  <th align="center">
		    커미션(실시간)
          </th>  
<% End If %>
		</tr>
		<%		
            IF dfCpSql.RsCount <> 0 Then
                For i = 0 to dfCpSql.RsCount - 1
					if i mod 2 = 0 Then
					%>			<tr height="25">
<%
					else%>			<tr height="25" style="background-color:#fafafa">

					<%End if
        %>
			  <td align="center" >
			  <% If dfCpSql.Rs(i, "IA_ID") = master_id Then %>
				<%= dfCpSql.Rs(i, "IA_ID") %>
			  <% ElseIf dfCpSql.Rs(i, "IA_LEVEL")=3 then %>
				<a href="/Seller/01_CP/masterList1.asp?master_id=<%= dfCpSql.Rs(i, "IA_ID") %>" target="ViewFrm" style="color:#000000; "><%= dfCpSql.Rs(i, "IA_ID") %></a>
			  <% ElseIf dfCpSql.Rs(i, "IA_LEVEL")=4 then %>
				<a href="/Seller/01_CP/masterList2.asp?master_id=<%= dfCpSql.Rs(i, "IA_ID") %>" target="ViewFrm" style="color:#000000; "><%= dfCpSql.Rs(i, "IA_ID") %></a>
			  <% ElseIf dfCpSql.Rs(i, "IA_LEVEL")=5 then %>
				<a href="/Seller/01_CP/masterList3.asp?master_id=<%= dfCpSql.Rs(i, "IA_ID") %>" target="ViewFrm" style="color:#000000; "><%= dfCpSql.Rs(i, "IA_ID") %></a>
			  <% End If %>
			  <font color="red">(<%= dfCpSql.Rs(i, "IA_NICKNAME") %>)</font>
			  </td>
			  <td align="center" >
				<% IF dfCpSql.Rs(i, "IA_LEVEL") = "1" THEN%>
					어드민
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
<% If ia_type = 1 Then %>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_SportsPercent") %>%
			  </td>
<% Else %>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_SportsPercent") %>%
			  </td>
			  <td align="center" >
				<%= dfCpSql.Rs(i, "IA_LivePercent") %>%
			  </td>
<% End If %>
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" >
			    파트너가 존재하지 않습니다.
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

