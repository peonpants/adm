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

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### ���� ����Ʈ�� �ҷ���                 ################	
   
	Call dfgameSql.CHK_BETTING(dfDBConn.Conn,  IB_IDX)
	

    	
%>

<input type='button' style="width:100px;background-color:#000000;color:#ffffff" value='�ݱ�' onclick='document.getElementById("aaa").innerHTML = ""' />
<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#aaaaaa">
    <tr bgcolor="#eeeeee">
        <td width="7%"  align="center" >���</td>
        <td width="15%"  align="center" >Ȩ��</td>
        <td width="15%"  align="center" >������</td>
        <td width="8%"  align="center" >���ó���</td>        
    </tr>
<%
    For ii = 0 to dfgameSql.RsCount - 1
        IG_Team1    = dfgameSql.Rs(ii , "IG_TEAM1") 
        IG_Team2    = dfgameSql.Rs(ii , "IG_TEAM2")     
        IBD_Num    = dfgameSql.Rs(ii , "IBD_Num") 
        IG_Type      = dfgameSql.Rs(ii , "IG_TYPE")
        
        IF IBD_NUM = "1" Then
            choice  = "��"    
        ElseIF IBD_NUM = "0" Then
            choice  = "��"    
        ElseIF IBD_NUM = "2" Then
            choice  = "��"    
        End IF
        
        IF IG_Type = "1" Then
            txtIG_Type  = "�ڵ�ĸ"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "����/���"  
            IG_DRAWBENEFIT =  IG_HANDICAP  
        Else
            txtIG_Type  = "�¹���"    
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