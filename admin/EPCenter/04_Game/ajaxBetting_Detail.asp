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

    IB_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IB_IDX")), 1, 1, 9999999) 

	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### 배팅 리스트를 불러옴                 ################	
   
	Call dfgameSql.CHK_BETTING(dfDBConn.Conn,  IB_IDX)
	

    	
%>

<input type='button' style="width:100px;background-color:#000000;color:#ffffff" value='닫기' onclick='document.getElementById("aaa").innerHTML = ""' />
<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#aaaaaa">
    <tr bgcolor="#eeeeee">
        <td width="7%"  align="center" >방식</td>
        <td width="15%"  align="center" >홈팀</td>
        <td width="15%"  align="center" >원정팀</td>
        <td width="8%"  align="center" >배팅내역</td>        
    </tr>
<%
    For ii = 0 to dfgameSql.RsCount - 1
        IG_Team1    = dfgameSql.Rs(ii , "IG_TEAM1") 
        IG_Team2    = dfgameSql.Rs(ii , "IG_TEAM2")     
        IBD_Num    = dfgameSql.Rs(ii , "IBD_Num") 
        IG_Type      = dfgameSql.Rs(ii , "IG_TYPE")
        
        IF IBD_NUM = "1" Then
            choice  = "승"    
        ElseIF IBD_NUM = "0" Then
            choice  = "무"    
        ElseIF IBD_NUM = "2" Then
            choice  = "패"    
        End IF
        
        IF IG_Type = "1" Then
            txtIG_Type  = "핸디캡"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "오버/언더"  
            IG_DRAWBENEFIT =  IG_HANDICAP  
        Else
            txtIG_Type  = "승무패"    
        End IF        
                
%>    
    <tr bgcolor="#ffffff">
        <td width="7%"  align="center" ><%= txtIG_Type %></td>
        <td width="15%"  align="center" ><%= IG_Team1 %></td>
        <td width="15%"  align="center" ><%= IG_Team2 %></td>
        <td width="8%"  align="center" ><%= choice %></td>        
    </tr>
<%
    Next
%>
</table>    