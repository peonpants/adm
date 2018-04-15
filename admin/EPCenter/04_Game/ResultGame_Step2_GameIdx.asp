<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/request.class.asp"-->
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
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))	
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))

    IG_IDX		= Trim(dfRequest("IG_IDX"))

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    '######## ������ �÷��� ���氪�� �ִ´�.    ##############################
        	
	'######### ���ӿ� ���� ���� ������ �ҷ���                 ################	    
	Call dfgameSql.ExecGameResultStep2(dfDBConn.Conn,  IG_IDX, 2 )
	'dfgameSql.debug
    IF dfgameSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("���� ������ �������� �ʽ��ϴ�.");  
    top.window.close();  
    </script>
<%
        response.end
    End IF
    IF IG_Type = 1 Then
        txtIG_Type  = "�ڵ�ĸ"    
    ElseIF IG_Type = 2 Then
        txtIG_Type  = "����/���"    
    Else
        txtIG_Type  = "�¹���"    
    End IF
    
%>

<html>
<head>
    <title>���� ���� ����</title>
    <link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
    <!--<script src="/Sc/Base.js"></script>-->    
    <style>
    .baord_table_bg {background-color:#AAAAAA}
    .td_red_bold {background-color:#EEEEEE}
    .trIngGame {background-color:#FFFFFF}

    .noChoice {vertical-align:middle;background:#000000;color:#FFFFFF; }
    .noChoice table {color:#FFFFFF; }
    .Choice {vertical-align:middle;background:#FFDB3C;color:#000000;}
    .Choice table {color:#000000; }

    .ingChoice {vertical-align:middle;background:#000000;color:#E9BB5B;}
    .ingChoice table {color:#E9BB5B; }
    
    .cancelChoice {vertical-align:middle;background:#000000;color:#E9BB5B;}
    .cancelChoice table {color:#E9BB5B; }
        
    </style>
</head>
<body marginheight="0" marginwidth="0">

    

<%
    IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1
    totalIBD_RESULT     = 5 '0  : ����, 1  : ����, 2 : ���, 3 : ����Ư�� , 5 : ������ , 9 : ������
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "����"
        txttotalIBD_RESULT(1) = "����"
        txttotalIBD_RESULT(2) = "1��ó��"
        txttotalIBD_RESULT(3) = "1��ó��"
        txttotalIBD_RESULT(9) = "������"
    
   
    For ii = 0 to dfgameSql.RsCount - 1
        IG_IDX = dfgameSql.Rs(ii , "IG_IDX")
        IG_StartTime = dfgameSql.Rs(ii , "IG_STARTTIME")
        IG_Type      = dfgameSql.Rs(ii , "IG_TYPE")
        IB_IDX      = dfgameSql.Rs(ii , "IB_IDX")
        IB_ID       = dfgameSql.Rs(ii , "IB_ID") 
        RL_League   = dfgameSql.Rs(ii , "RL_LEAGUE") 
        IG_Team1    = dfgameSql.Rs(ii , "IG_TEAM1") 
        IG_Team2    = dfgameSql.Rs(ii , "IG_TEAM2") 
        IG_TEAM1BENEFIT = dfgameSql.Rs(ii , "IG_TEAM1BENEFIT") 
        IG_TEAM2BENEFIT = dfgameSql.Rs(ii , "IG_TEAM2BENEFIT") 
        IG_DRAWBENEFIT = dfgameSql.Rs(ii , "IG_DRAWBENEFIT") 
        IG_HANDICAP = dfgameSql.Rs(ii , "IG_HANDICAP") 
        IBD_NUM = dfgameSql.Rs(ii , "IBD_NUM") 
        IG_SCORE1 = dfgameSql.Rs(ii , "IG_SCORE1") 
        IG_SCORE2 = dfgameSql.Rs(ii , "IG_SCORE2") 
        IG_STATUS   = dfgameSql.Rs(ii , "IG_STATUS") 
        IG_DRAW   = dfgameSql.Rs(ii , "IG_DRAW") 
        IBD_RESULT  = dfgameSql.Rs(ii , "IBD_RESULT") 
        IBD_RESULT_BENEFIT = dfgameSql.Rs(ii , "IBD_RESULT_BENEFIT") 
        IBD_BENEFIT = dfgameSql.Rs(ii , "IBD_BENEFIT") 
        IB_REGDATE  = dfgameSql.Rs(ii , "IB_REGDATE") 
        IB_Amount   = dfgameSql.Rs(ii , "IB_AMOUNT") 
        IB_BENEFIT   = dfgameSql.Rs(ii , "IB_BENEFIT") 
        IU_NICKNAME   = dfgameSql.Rs(ii , "IU_NICKNAME") 
        IU_LEVEL   = dfgameSql.Rs(ii , "IU_LEVEL") 
        
        
        IF IG_Type = "1" Then
            txtIG_Type  = "�ڵ�ĸ"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "����/���"  
            IG_DRAWBENEFIT =  IG_HANDICAP  
        Else
            txtIG_Type  = "�¹���"    
        End IF
        
        IF IBD_NUM = "1" Then
            choice  = "��"    
        ElseIF IBD_NUM = "0" Then
            choice  = "��"    
        ElseIF IBD_NUM = "2" Then
            choice  = "��"    
        End IF
        
        resultBgColor = "#FFFFFF"
        IF IBD_RESULT = "0" Then    
            txtIBD_RESULT = "����"
        ElseIF IBD_RESULT = "1" Then
            txtIBD_RESULT = "����"
            resultBgColor = "#FFDB3C"
        ElseIF IBD_RESULT = "2" Then
            txtIBD_RESULT = "���"
        ElseIF IBD_RESULT = "3" Then
            txtIBD_RESULT = "��Ư"
        Else
            txtIBD_RESULT = "����"
        End IF
        
        SCORE = IG_SCORE1 & " : " & IG_SCORE2
        
        '#### ���� ������ üũ�Ѵ�.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "<br>"
        TotalBenefit = TotalBenefit * IBD_RESULT_BENEFIT
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
                
        IF IB_IDX1 <>  IB_IDX Then      
%>
               
            <table width="100%" border="0" cellpadding="5" cellspacing="1" class="baord_table_bg">
                <tr class="td_red_bold">
                    <td colspan="10">
                    <%= ii+1 %><%= IU_NICKNAME %>(<%= IB_ID %>) ȸ������ ���� ����
                    </td>
                </tr>
                <tr class="td_red_bold">
                    <td width="12%" align="center" >����Ͻ�</td>
                    <td width="7%"  align="center" >���</td>
                    <td width="10%" align="center" >����</td>
                    <td width="15%"  align="center" >��(Ȩ��)</td>
                    <td width="5%"  align="center" >��</td>
                    <td width="15%"  align="center" >��(������)</td>
                    <td width="8%"  align="center" >���ó���</td>
                    <td width="5%"  align="center" >����</td>
                    <td width="8%"  align="center" >���</td>
                    <td width="12%" align="center" >���ýð�</td>
                </tr>
<%
        End IF
%>                
                <tr class="trIngGame">
                    <td width="12%"  align="center" ><%=dfStringUtil.GetFullDate(IG_StartTime)%>(<%= IG_IDX %>)</td>
                    <td width="5%"  align="center" ><%=txtIG_Type%></td>
                    <td width="10%"  align="center" ><%=RL_League%></td>
                    <td width="15%"  align="center" >
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" ><%=IG_Team1%></td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= IG_TEAM1BENEFIT %></td>
                            </tr>
                        </table>    
                    </td>                    
                    <td width="5%"  style="padding-top:4;" align="center" >
                        <%= IG_DRAWBENEFIT %>
                    </td>
                    <td width="15%"  align="center" >
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td align="left" width="71" style="padding-left:4" align="center" ><%= IG_TEAM2BENEFIT %></td>
                                <td width="80%" align="right"width="71" style="padding-right:4" align="center" ><%=IG_Team2%></td>
                            </tr>
                        </table>    
                   
                    </td>
                    <td width="8%"  align="center" ><%=choice%></td>
                    <td width="5%"  style="padding-top:4;" align="center" ><%=SCORE%></td>
                    <td width="8%"  style="padding-top:4;" align="center"  bgcolor="<%= resultBgColor %>"><%= IBD_RESULT %><%=txtIBD_RESULT%>(<%= IBD_RESULT_BENEFIT %>)</td>
                    <td width="12%"  align="center" ><%=dfStringUtil.GetFullDate(IB_REGDATE) %></td>
                </tr>
<%     
                     
    IF dfgameSql.RsCount-1 > ii Then        
        IF cStr(Trim(IB_IDX)) <> cStr(Trim(dfgameSql(ii+1,"IB_IDX")))  Then        
                    
            IF cInt(TotalBenefit) = 1 Then
                totalIBD_RESULT = 2
                resultBgColor1 = "FFEDEF"
            ElseIF cInt(TotalBenefit) = 0 Then                
                totalIBD_RESULT = 0
                resultBgColor1 = "#aaaaaa"
            Else                    
                IF cInt(totalIBD_RESULT) = 9 Then               
                    totalIBD_RESULT = 9 
                    resultBgColor1 = "#ffffff"
                Else
                    totalIBD_RESULT = 1 
                    resultBgColor1 = "#FFDB3C"
                End IF                    
            End IF
            
                    
%>               
                <tr class="trIngGame">
                    <td colspan=3  width="27%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >���øӴ� : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%=FORMATNUMBER(IB_Amount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="20%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >������(��) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(TotalBenefit,2) %></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="23%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >���߱�(��) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(BenefitAmount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    <td colspan=3 class="Selected" width="25%" style="padding-top:4;" align="center" bgcolor="<%= resultBgColor1 %>"><%=txttotalIBD_RESULT(totalIBD_RESULT)%></td>
                </tr> 
                </table>    
                <br />           
<%
            TotalBenefit = 1
            BenefitAmount = 1
            totalIBD_RESULT     = 5
        End IF
    Else    
        IF cInt(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
            resultBgColor1 = "FFEDEF"
        ElseIF cInt(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "#aaaaaa"
        Else                    
            IF cInt(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9
                resultBgColor1 = "#ffffff" 
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "#FFDB3C"
            End IF                    
        End IF    
%>
                <tr class="trIngGame">
                    <td colspan=3  width="27%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >���øӴ� : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%=FORMATNUMBER(IB_Amount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="20%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >������(��) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(TotalBenefit,2)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="23%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >���߱�(��) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(BenefitAmount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    <td colspan=3 class="Selected" width="25%" style="padding-top:4;" align="center" bgcolor="<%= resultBgColor1 %>"><%=txttotalIBD_RESULT(totalIBD_RESULT)%></td>
                </tr>    
                </table> 
                <br />           
<%          
        TotalBenefit = 1
        BenefitAmount = 1  
        totalIBD_RESULT     = 5        
    End IF
    
    IB_IDX1 = IB_IDX
Next
%>
</table>
</body>
</html>
