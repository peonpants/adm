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

    site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
        
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
            	
	'######### 리그 리스트를 불러옴                 ################	
    Set dfgameSql1 = new gameSql 
	Call dfgameSql1.Get_Betting_Money(dfDBConn.Conn, 1) '승
	
	'dfgameSql1.debug
	Set dfgameSql2 = new gameSql
	Call dfgameSql2.Get_Betting_Money(dfDBConn.Conn, 2) '패
	'dfgameSql2.debug
	
	Set dfgameSql3 = new gameSql
	Call dfgameSql3.Get_Betting_Money(dfDBConn.Conn, 3) '무
'dfgameSql3.debug

    set dicWin = server.CreateObject ("Scripting.Dictionary")
    set dicDraw = server.CreateObject ("Scripting.Dictionary")
    set dicLose = server.CreateObject ("Scripting.Dictionary")
    
    
    dicWin.Add 10, 0
    dicWin.Add 30, 0
    dicWin.Add 50, 0
    dicWin.Add 70, 0
    dicWin.Add 90, 0
    dicWin.Add 100, 0
    
    dicDraw.Add 10, 0
    dicDraw.Add 30, 0
    dicDraw.Add 50, 0
    dicDraw.Add 70, 0
    dicDraw.Add 90, 0
    dicDraw.Add 100, 0
    
    dicLose.Add 10, 0
    dicLose.Add 30, 0
    dicLose.Add 50, 0
    dicLose.Add 70, 0
    dicLose.Add 90, 0
    dicLose.Add 100, 0
            
    
    
    '## 승 경기 총합
    IF dfgameSql1.RsCount <> 0 Then
        For i = 0 to dfgameSql1.RsCount -1 
            IF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) > 0 And clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) < 100000  Then                
                dicWin.item(10) = clng(dicWin.item(10)) + clng(dfgameSql1.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) >= 100000 And clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) < 300000  Then
                dicWin.item(30) = clng(dicWin.item(30)) + clng(dfgameSql1.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) >= 300000 And clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) < 500000  Then
                dicWin.item(50) = clng(dicWin.item(50)) + clng(dfgameSql1.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) >= 500000 And clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) < 700000  Then            
                dicWin.item(70) = clng(dicWin.item(70)) + clng(dfgameSql1.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) >= 700000 And clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) < 900000  Then            
                dicWin.item(90) = clng(dicWin.item(90)) + clng(dfgameSql1.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql1.Rs(i,"IG_TEAM1BETTING")) >= 900000 Then
                dicWin.item(100) = clng(dicWin.item(100)) + clng(dfgameSql1.Rs(i,"cnt"))    
            End IF            
        Next 
    End IF
    
    '##  패 경기 총합
    IF dfgameSql2.RsCount <> 0 Then
        For i = 0 to dfgameSql2.RsCount -1 
            IF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) > 0 And clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) < 100000  Then                
                dicLose.item(10) = clng(dicLose.item(10)) + clng(dfgameSql2.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) >= 100000 And clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) < 300000  Then
                dicLose.item(30) = clng(dicLose.item(30)) + clng(dfgameSql2.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) >= 300000 And clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) < 500000  Then
                dicLose.item(50) = clng(dicLose.item(50)) + clng(dfgameSql2.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) >= 500000 And clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) < 700000  Then            
                dicLose.item(70) = clng(dicLose.item(70)) + clng(dfgameSql2.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) >= 700000 And clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) < 900000  Then            
                dicLose.item(90) = clng(dicLose.item(90)) + clng(dfgameSql2.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql2.Rs(i,"IG_TEAM2BETTING")) >= 900000 Then
                dicLose.item(100) = clng(dicLose.item(100)) + clng(dfgameSql2.Rs(i,"cnt"))    
            End IF 
        Next           
    End IF    
   
    '##  무 경기 총합
    IF dfgameSql3.RsCount <> 0 Then
        For i = 0 to dfgameSql3.RsCount -1 
            IF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) > 0 And clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) < 100000  Then                
                dicDraw.item(10) = clng(dicDraw.item(10)) + clng(dfgameSql3.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) >= 100000 And clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) < 300000  Then
                dicDraw.item(30) = clng(dicDraw.item(30)) + clng(dfgameSql3.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) >= 300000 And clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) < 500000  Then
                dicDraw.item(50) = clng(dicDraw.item(50)) + clng(dfgameSql3.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) >= 500000 And clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) < 700000  Then            
                dicDraw.item(70) = clng(dicDraw.item(70)) + clng(dfgameSql3.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) >= 700000 And clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) < 900000  Then            
                dicDraw.item(90) = clng(dicDraw.item(90)) + clng(dfgameSql3.Rs(i,"cnt"))    
            ElseIF clng(dfgameSql3.Rs(i,"IG_DRAWBETTING")) >= 900000 Then
                dicDraw.item(100) = clng(dicDraw.item(100)) + clng(dfgameSql3.Rs(i,"cnt"))    
            End IF            
        Next        
    End IF      
      
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
    
    window.open(url, "betMoneyList","width=700,height=500,scrollbars=yes,resizable=yes")
}
</script>
</head>

<body topmargin="0" marginheight="0">
<table cellpadding=2 cellspacing=1 border=0 bgcolor="#AAAAAA" width=100%>
    <tr height="25" bgcolor="#ffffff">
<%
For each aa in dicWin.Keys
%>    
        <td>
        <%
            IF aa = 10 Then
                response.Write "10미만"
            ElseIF aa = 100 Then
                response.Write "90이상" 
            Else
                response.Write aa - 20  & "~" & aa &"만"                                
            End IF
        %>
        
        <a href="javascript:openBetMoneyList(<%= aa %>,1);">승(<%= dicWin.item(aa)  %>)</a>
        <a href="javascript:openBetMoneyList(<%= aa %>,3);">무(<%= dicDraw.item(aa)  %>)</a>
        <a href="javascript:openBetMoneyList(<%= aa %>,2);">패(<%= dicLose.item(aa)  %>)</a>
        </td>
<%
Next
%>    
    </tr>    
</table>

</body>
</html>

