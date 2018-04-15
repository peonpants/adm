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
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

    reqType1 = dfRequest.Value("type1")
    reqType2 = dfRequest.Value("type2")
    
    intStartMoney = 0 
    intEndMoney = 0 
  
   
    IF reqType1 = 10 Then
        intStartMoney = 1 
        intEndMoney = reqType1*10000           
    ElseIF reqType1 = 100 Then
        intStartMoney = 900000 
        intEndMoney = 900000000         
    Else
        intStartMoney = (reqType1-20)*10000   
        intEndMoney = reqType1*10000    
    End IF
    
    
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	
	Call dfgameSql.Get_Betting_MoneyList(dfDBConn.Conn, intStartMoney, intEndMoney, reqType2)
	
        'dfgameSql.debug
%>


<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">


<!--마우스 우클릭 막기-->
<!--<script src="/Sc/Base.js"></script>-->

<script type="text/javascript">
function openBetMoneyList(type1, type2)
{   
    var url = "Betting_MoneyList.asp?type1=" +  type1 + "&type2=" + type2;
    
    window.open(url, "betMoneyList","width=500,height=500")
}
</script>
</head>

<body topmargin="5" marginheight="5">

<b><%= formatNumber(intStartMoney,0) %>원 ~ <%= formatNumber(intEndMoney,0) %>원 경기 내역</b>
<table width="100%" cellpadding=5 cellspacing=1 border=0 bgcolor="#AAAAAA">
    <tr height="25" bgcolor="#eeeeee">
        <td>게임타입</td>
        <td>종류</td>
        <td>리그</td>
        <td>홈팀(배팅금)</td>
        <td>무승부(배팅금)</td>
        <td>원정(배팅금)</td>  
    </tr>
<%
    IF dfgameSql.RsCount <> 0 Then
        For i = 0 to dfgameSql.RsCount -1  
            'response.Write dfgameSql.Rs(i,"IG_TYPE")    
            IF cSTr(dfgameSql.Rs(i,"IG_TYPE")) = "0" Then
                strIG_TYPE = "승무패"
            ElseIF cSTr(dfgameSql.Rs(i,"IG_TYPE")) = "1" Then
                strIG_TYPE = "핸디캡"
            ElseIF cSTr(dfgameSql.Rs(i,"IG_TYPE")) = "2" Then
                strIG_TYPE = "오버/언더"
            End IF
%>
    <tr height="25" bgcolor="#ffffff">
        <td><%=  strIG_TYPE %></td>
        <td><%=  dfgameSql.Rs(i,"RL_SPORTS") %></td>
        <td><%=  dfgameSql.Rs(i,"RL_LEAGUE") %></td>
        <td><%=  dfgameSql.Rs(i,"IG_TEAM1") %>(<%= formatNumber(dfgameSql.Rs(i,"IG_TEAM1BETTING"),0) %>원)</td>
        <td><%= formatNumber(dfgameSql.Rs(i,"IG_DRAWBETTING"),0) %>원</td>
        <td><%=  dfgameSql.Rs(i,"IG_TEAM2") %>(<%= formatNumber(dfgameSql.Rs(i,"IG_TEAM2BETTING"),0) %>원)</td>                
    </tr> 
<%        
        Next
    End IF 
%>    
</table>
<table width="100%">
<tr>
    <td align="center"><input type="button" class="input2" value="닫기" onclick="window.close();" /></td>
</tr>
</table>
</body>
</html>


