<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.CHK_BETTING_A(dfDBConn.Conn)
    	
    IF dfgameSql.RsCount <> 0 Then    	
%>


<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#aaaaaa">
    <tr bgcolor="#eeeeee">        
        <td align="center" >배팅조작</td>        
    </tr>
<%
    For ii = 0 to dfgameSql.RsCount - 1
%>    
    <tr bgcolor="#ffffff">        
        <td width="15%"  align="center" ><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=&sEndDate=&Search=IB_IDX&Find=<%= dfgameSql.Rs(ii,"IB_IDX") %>&IB_AMOUNT=0"><%= dfgameSql.Rs(ii,"IB_IDX") %></a></td>
        <td width="15%"  align="center" ><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=&sEndDate=&Search=IB_ID&Find=<%= dfgameSql.Rs(ii,"IB_ID") %>&IB_AMOUNT=0"><%= dfgameSql.Rs(ii,"IB_ID") %></a></td>        
    </tr>
<%
    Next
%>
</table>    
<%
    End IF
%>