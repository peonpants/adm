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

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    '######## 가정산 플래그 변경값을 넣는다.    ##############################
        	
	'######### 게임에 따른 배팅 내역을 불러옴                 ################	    
	Call dfgameSql.ExecGameResultStep2(dfDBConn.Conn,  0, 2 )
	'dfgameSql.debug

    IF IG_Type = 1 Then
        txtIG_Type  = "핸디캡"    
    ElseIF IG_Type = 2 Then
        txtIG_Type  = "오버/언더"    
    Else
        txtIG_Type  = "승무패"    
    End IF
    
%>
<html>
<head>
    <title>배팅 내역 보기</title>
    <link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
    <script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
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
<script type="text/javascript">
function goStep3()
{
    location.href = "ResultGame_Step3.asp"
}

function ajaxRequestBet(ib_idx, e)
{

    var E=window.event;
    var x =  E.clientX + document.body.scrollLeft ;
	var y =  E.clientY + document.body.scrollTop;
	
	document.getElementById("aaa").style.left = x ;
	document.getElementById("aaa").style.top = y ;	
	        
	var url = "ajaxBetting_Detail.asp";
	var pars = 'ib_idx=' + ib_idx
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: 'get', 
			parameters: pars, 
			onComplete: showResponse
		});


			
}

function showResponse(originalRequest)
{

	document.getElementById("aaa").innerHTML = originalRequest.responseText;
    
}


</script>    
</head>
<body marginheight="0" marginwidth="0">
<div id="aaa" style="position:absolute;left:1;top:1;width:500px;"></div>
<div align="center" >
<input type="button" value="정산하기" class="input" style="width:500px;height:50px;background:#000000;color:#ffffff;" onclick="goStep3();" />
</div>   
<br />
<%

    IF dfgameSql.RsCount = 0 Then
        response.write "적중된 경기가 없습니다. "
        response.end
    End IF
    
    IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1
    totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 5 : 진행중 , 9 : 진행중
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "실패"
        txttotalIBD_RESULT(1) = "성공"
        txttotalIBD_RESULT(2) = "1배처리"
        txttotalIBD_RESULT(3) = "1배처리"
        txttotalIBD_RESULT(9) = "진행중"
    
   
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
        
        'response.Write IB_IDX
        IF IG_Type = "1" Then
            txtIG_Type  = "핸디캡"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "오버/언더"  
            IG_DRAWBENEFIT =  IG_HANDICAP  
        Else
            txtIG_Type  = "승무패"    
        End IF
        
        IF IBD_NUM = "1" Then
            choice  = "승"    
        ElseIF IBD_NUM = "0" Then
            choice  = "무"    
        ElseIF IBD_NUM = "2" Then
            choice  = "패"    
        End IF
        
        resultBgColor = "#FFFFFF"
        IF IBD_RESULT = "0" Then    
            txtIBD_RESULT = "실패"
        ElseIF IBD_RESULT = "1" Then
            txtIBD_RESULT = "적중"
            resultBgColor = "#FFDB3C"
        ElseIF IBD_RESULT = "2" Then
            txtIBD_RESULT = "취소"
        ElseIF IBD_RESULT = "3" Then
            txtIBD_RESULT = "적특"
        Else
            txtIBD_RESULT = "진행"
        End IF
        
        SCORE = "<b style='color:red'>" & IG_SCORE1 & " : " & IG_SCORE2 & "</b>"
        
        '#### 진행 중인지 체크한다.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "<br>"
		'''여기작업중
         TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)        
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
II_PLUS_DR = ""
II_SAVE_DR = ""
II_TYPE = ""
II_SA = ""
SQLLIST = "SELECT * FROM INFO_item where ib_idx="& IB_Idx  

SET RSLIST = DbCon.Execute(SQLLIST)
if Not RSLIST.eof then
II_PLUS_DR = RSLIST("II_PLUS_DR") 
II_SAVE_DR = RSLIST("II_SAVE_DR") 
II_TYPE = RSLIST("II_TYPE") 
II_SA = RSLIST("II_SA") 
end if
	RSLIST.CLOSE
	SET RSLIST = NOTHING


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                
        IF IB_IDX1 <>  IB_IDX Then      
%>
               
            <table width="100%" border="0" cellpadding="5" cellspacing="1" class="baord_table_bg">
                <tr class="td_red_bold">
                    <td colspan="10">
                    <%= IU_NICKNAME %>(<%= IB_ID %>) 회원님의 배팅 내역&nbsp;<font color=red>
					<%if II_type = "IP" then%>플러스아이템<%=II_PLUS_DR%>%
					<%elseif II_type = "IS" then%>세이브아이템<%=II_SAVE_DR%>%
					<%elseif II_type = "ISA" then%>적특아이템(<%=II_SA%>)<%end if%></font>
                    <div onclick="ajaxRequestBet(<%=IB_Idx%>,event)" style="cursor:pointer"><%=IB_Idx%></div>
                    </td>
                </tr>
                <tr class="td_red_bold">
                    <td width="12%" align="center" >경기일시</td>
                    <td width="7%"  align="center" >방식</td>
                    <td width="10%" align="center" >리그</td>
                    <td width="15%"  align="center" >승(홈팀)</td>
                    <td width="5%"  align="center" >무</td>
                    <td width="15%"  align="center" >패(원정팀)</td>
                    <td width="8%"  align="center" >배팅내역</td>
                    <td width="5%"  align="center" >점수</td>
                    <td width="8%"  align="center" >결과</td>
                    <td width="12%" align="center" >배팅시간</td>
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
            
            BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100       
            BenefitAmount = numdel2(BenefitAmount)                    
            IF CDbl(TotalBenefit) = 1 Then
                totalIBD_RESULT = 2
                resultBgColor1 = "FFEDEF"
            ElseIF CDbl(TotalBenefit) = 0 Then                
                totalIBD_RESULT = 0
                resultBgColor1 = "#aaaaaa"
            Else                    
                IF CDbl(totalIBD_RESULT) = 9 Then               
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
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >배팅머니 : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%=FORMATNUMBER(IB_Amount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="20%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >예상배당(배) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(TotalBenefit,2) %></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="23%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >적중금(원) : </td>
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
    
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100    
        BenefitAmount = numdel2(BenefitAmount)
        IF CDbl(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
            resultBgColor1 = "FFEDEF"
        ElseIF CDbl(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "#aaaaaa"
        Else                    
            IF CDbl(totalIBD_RESULT) = 9 Then               
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
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >배팅머니 : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%=FORMATNUMBER(IB_Amount,0)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="20%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >예상배당(배) : </td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FORMATNUMBER(TotalBenefit,2)%></td>
                            </tr>
                        </table>    
                    </td>
                    
                    <td colspan=2  width="23%" align="center">
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" >적중금(원) : </td>
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
<br />
<div align="center" >
<input type="button" value="정산하기" class="input" style="width:500px;height:50px;background:#000000;color:#ffffff;" onclick="goStep3();" />
</div>   
</table>
</body>
</html>
