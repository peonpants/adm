<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	LAC_GROUP = REQUEST("LAC_GROUP")
	LAC_GROUP1 = REQUEST("LAC_GROUP1")
	LAC_GROUP2 = REQUEST("LAC_GROUP2")
    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate")
        sEndDate =  REQUEST("sEndDate") 
    else           
    sStartDate = datevalue(now)  & " 00:00:00"
    sEndDate = datevalue(now) & " 23:59:59" 
    End If

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 관리자 접속 로그 부름                    ################	
    Call dfCpSql.RetrieveINFO_ADMIN_L2(dfDBConn.Conn, LAC_GROUP,LAC_GROUP1,LAC_GROUP2)

%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<script type="text/javascript" src="../includes/calendar1.js"></script>
<script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<table border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 관리자 실시간 정산</b></td>
</tr>
</table>
<form name="MainForm" action="/EPCenter/05_Account/CashCalMonth_L2.asp" method="post" align="center">
시작일자 :
<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'>
	종료일자 :
	<input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'>

	<button type="submit">검 색</button>
</form>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 관리자 접속 로그</b></td>
</tr>
</table>    


 <table  border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
		    본사코드
          </td>
		  <td align="center">
		    충전금액
          </td>
		  <td align="center">
		    환전금액
          </td>  
		  <td align="center">
		    합계금액
          </td> 
		</tr>
	
		<%		

            IF dfCpSql.RsCount <> 0 Then
                For i = 0 to dfCpSql.RsCount - 1
				IA_ID = dfCpSql.Rs(i, "IA_ID") 
				LAC_GROUP1 = dfCpSql.Rs(i, "IA_GROUP1")
				LAC_GROUP2 = dfCpSql.Rs(i, "IA_GROUP2")
				LAC_GROUP3 = dfCpSql.Rs(i, "IA_GROUP3")

				SQL = "SELECT sum(IB_IDX) as charge FROM LOG_ADMIN_CASHINOUT WHERE LAC_TYPE=1 and LAC_GROUP=2 and LAC_GROUP1 = " & LAC_GROUP1 & " and LAC_GROUP2 = " & LAC_GROUP2 & " and LAC_REGDATE>='"&sStartDate&"' AND LAC_REGDATE<='"&sEndDate&"'"
				SET RS1 = DbCon.Execute(SQL)

					If Not RS1.EOF Then
					charge = RS1("charge")
					End If
					If isnull(charge) Then
					charge = 0
					End if
				RS1.CLOSE
				SET RS1 = Nothing

				SQL = "SELECT sum(IB_IDX) as excharge FROM LOG_ADMIN_CASHINOUT WHERE LAC_TYPE=3 and LAC_GROUP=2 and LAC_GROUP1 = " & LAC_GROUP1 & " and LAC_GROUP2 = " & LAC_GROUP2 & " and LAC_REGDATE>='"&sStartDate&"' AND LAC_REGDATE<='"&sEndDate&"'"
				SET RS1 = DbCon.Execute(SQL)

					If Not RS1.EOF Then
					excharge = RS1("excharge")
					End If
					If isnull(excharge) Then
					excharge = 0
					End if
				RS1.CLOSE
				SET RS1 = NOTHING	
				
				totalch= charge + excharge
        %>
			<tr height="25" bgcolor="#FFFFFFF">
			  <td align="center" >
				<a href="CashCalMonth_L3.asp?IA_ID=<%=IA_ID%>&LAC_GROUP=<%=LAC_GROUP%>&LAC_GROUP1=<%=LAC_GROUP1%>&LAC_GROUP2=<%=LAC_GROUP2%>&LAC_GROUP3=<%=LAC_GROUP3%>&LAC_GROUP4=<%=LAC_GROUP4%>"><%= IA_ID %></a>
			  </td>
			  <td align="center" >
				<%=FormatNumber(charge,0)%>원
			  </td>		
			  <td align="center" >
				<%=FormatNumber(excharge,0)%>원
			  </td>		
			  <td align="center" >
				<%=FormatNumber(totalch,0)%>원
			  </td>				  
			</tr>
		<%
                Next               
            Else
        %>			
			<tr>
			  <td align="center" >
			    검색할 정산이 없습니다
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

