<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	Page		= REQUEST("Page")
	BF_Idx		= REQUEST("BF_Idx")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	bType = request("bType")	
	SQLstr="UPDATE Board_Free SET BF_HITS=BF_HITS+3 WHERE BF_IDX = "& BF_IDX &" "
	DbCon.Execute(SQLstr)

	SQLMSG = "SELECT * FROM Board_Free WHERE BF_Idx = '"& BF_Idx &"' "
	SET RS = DbCon.Execute(SQLMSG)

	BF_Title	= Trim(RS("BF_Title"))
	BF_Writer	= RS("BF_Writer")
	BC_ID	= RS("BF_PW")
	IB_IDX  = RS("IB_IDX")
	 
	BF_Contents	= replace(Trim(RS("BF_Contents")),"#0b151b", "")
	
	BF_RegDate	= RS("BF_RegDate")
	BF_Hits		= RS("BF_Hits")
	BF_SITE		= RS("BF_SITE")
	BF_Level		= RS("BF_Level")

	RS.Close
	Set RS = Nothing
	
	
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script language="javascript" src="Alditor/alditor.js" type="text/javascript"></script>-->
<script>
	function goDelete(idx) {
		location.href="Board_Delete.asp?SelUser="+idx+"&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>&BF_LEVEL=<%= BF_LEVEL %>";
	}

	function goReply() {
		var frm = document.frm1;
		
		if ((frm.BFR_Contents.value == "") || (frm.BFR_Contents.value.length < 1))
		{
		  alert("댓글을 한글자이상 입력해주세요..");
		  frm.BFR_Contents.focus();
		  return false;
		}
		
		frm.submit();
	}
  function goMo (idx){
    document.frm.submit();
  }


  function goReplyDel(ridx,fidx) {
	//alert("댓글을 5자이상 입력해주세요..");
	top.HiddenFrm.location.href="Board_Free_Reply_Proc.asp?ProcFlag=D&BF_LEVEL=<%= BF_LEVEL %>&BFR_Idx="+ridx+"&BF_Idx="+fidx;
  }
</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 게시판 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table width="100%" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<form name="frm" action="Board_Write_Proc.asp" method="post" >
<input type="Hidden" name="Process" value="E">
<input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
<input type="hidden" name="bType" value="<%=bType%>">
<input type="hidden" name="page" value="<%=page%>">
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>글쓴이</b></td>
	<td colspan="3"><input type="text" name="BF_Writer"  maxlength="50" style="width:300px;border:1px solid #999999;" value="<%=BF_Writer%>"></td></tr>
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>공지적용</b></td>
	<td colspan="3">
	<select name="level">
	<option value="0" <%If BF_Level = "0" then%>selected<%End If %>>일반</option>
	<option value="1" <%If BF_Level = "1" then%>selected<%End If %>>공지사항</option>
	<option value="2" <%If BF_Level = "2" then%>selected<%End If %>>이 벤 트</option>
	<option value="3" <%If BF_Level = "3" then%>selected<%End If %>>흐르는공지</option>
	<option value="4" <%If BF_Level = "4" then%>selected<%End If %>>스포츠공지</option>
	<option value="5" <%If BF_Level = "5" then%>selected<%End If %>>실시간공지</option>
	</select>
	</td></tr>

<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>사이트선택</b></td>
	<td><input type="radio" name="BF_SITE" value="All" checked> 전체노출
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="BF_SITE" value="<%=SITE01%>" <%If site01 = bf_site Then %>checked<% End if%>> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>제&nbsp;&nbsp;목</b></td>
	<td colspan="3" style="padding:10,10,10,10;"><input type="text" name="BF_Title"  maxlength="100" style="width:300px;border:1px solid #999999;" value="<%=BF_Title%>"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>베&nbsp;팅&nbsp;번&nbsp;호</b></td>
    <td colspan="3"><input type="text" name="IB_IDX"  maxlength="100" style="width:300px;border:1px solid #999999;" value="<%=ib_idx%>"></BR><FONT COLOR="RED">**아래쪽에 나오는 첨부내역은 관리자화면에서는 1개만 표시됩니다.</FONT></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>등록시간</b></td>
    <td colspan="3"><input type="text" name="BF_REGDATE"  maxlength="50" style="width:300px;border:1px solid #999999;" value="<%=dfStringUtil.GetFullDate(BF_REGDATE)%>"> 예) 2001-01-01 23시 21분 (2001년 1월 1일 오후 11시 21분) <br>미등록시 현재일로 등록</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>조회수</b></td>
    <td colspan="3"><input type="text" name="BF_Hits" style="width:50px;border:1px solid #999999;" value="<%=BF_HITS%>"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>내&nbsp;&nbsp;용</b></td>
	<td colspan="3" style="overflow:scroll; width:700px; white-space:-moz-pre-wrap;word-break:break-all; padding:10,10,10,10;"><textarea name="BF_CONTENTS" style="width:700; height:100" ><%=BF_Contents%></textarea></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>등록일</b></td>
	<td colspan="3">&nbsp;<%=BF_RegDate%></td></tr>

<!-- 배팅 내역 -->
<tr>
    <td colspan="2">
<%

    IF IB_IDX <> "" Then
    
        '######### 디비 연결                    ################	
        dfDBConn.SetConn = Application("DBConnString")
	    dfDBConn.Connect()	
    	    
        '######### 배팅 리스트를 불러옴                 ################	   
	    Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  1, 1, "IB_IDX", IB_IDX, sStartDate, sEndDate, "all", 0,0)

        'dfGameSql.debug
	    IF dfgameSql.RsCount <> 0 Then
	        nTotalCnt = dfgameSql.RsOne("TC")
	    Else
	        nTotalCnt = 0
	    End IF
    	    
        arrIB_IDX = Split(IB_IDX,",")                
        cntIB_IDX  = ubound(arrIB_IDX) 
        IF cntIB_IDX = 0 Then        
         
%>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

현재 등록된 배팅이 없습니다.

<%
	ELSE
%>

<%
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "낙첨"
        txttotalIBD_RESULT(1) = "당첨"
        txttotalIBD_RESULT(2) = "1배처리"
        txttotalIBD_RESULT(3) = "1배처리"
        txttotalIBD_RESULT(4) = "취소" ' 관리자 취소
        txttotalIBD_RESULT(9) = "진행중"
        

                
	FOR ii = 0 TO dfgameSql.RsCount -1
	
	    IB_ID		= dfgameSql.Rs(ii,"IB_ID")
        IB_IDX		= dfgameSql.Rs(ii,"IB_Idx")
        IB_TYPE		= dfgameSql.Rs(ii,"IB_Type")
        IG_IDX		= dfgameSql.Rs(ii,"IG_Idx")
        IB_NUM		= dfgameSql.Rs(ii,"IB_Num")
        IB_BENEFIT	= dfgameSql.Rs(ii,"IB_Benefit")
        IB_AMOUNT	= dfgameSql.Rs(ii,"IB_Amount")
        IB_STATUS	= dfgameSql.Rs(ii,"IB_Status")
        IB_REGDATE	= dfgameSql.Rs(ii,"IB_RegDate")
        IB_CANCEL   = dfgameSql.Rs(ii,"IB_CANCEL")
        IU_NICKNAME     = dfgameSql.Rs(ii,"IU_NICKNAME")
        	
        IB_IDX1             = 0 
        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 4: 관리자 취소,  5 : 진행중 , 9 : 진행중
        	
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)                        
%>
        
            <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4D4D4D">
                <tr bgcolor="#eeeeee">
                    <td width="12%"  align="center" > <b><%= IB_ID %>(<%= IU_NICKNAME %>)</b></td>
                    <td width="7%"  align="center" >방식</td>
                    <td align="center" >리그</td>
                    <td width="20%"  align="center" >승(홈팀)</td>
                    <td width="5%"  align="center" >무</td>
                    <td width="20%"  align="center" >패(원정팀)</td>
                    <td width="5%"  align="center" >점수</td>
                    <td width="5%"  align="center" >배팅</td>
                    <td width="8%"  align="center" >결과</td>                    
                </tr>
<%        
        IF dfgameSql1.RsCount <> 0 Then              
            For  j = 0 to dfgameSql1.RsCount - 1
                IG_IDX		= dfgameSql1.Rs(j,"IG_IDX")
	            RL_League		= dfgameSql1.Rs(j,"RL_LEAGUE")
	            IG_Team1		= dfgameSql1.Rs(j,"IG_TEAM1")
	            IG_Team2		= dfgameSql1.Rs(j,"IG_TEAM2")
	            IG_Status		= dfgameSql1.Rs(j,"IG_STATUS")
	            IG_Result		= dfgameSql1.Rs(j,"IG_RESULT")
	            IG_StartTime	= dfgameSql1.Rs(j,"IG_STARTTIME")
	            IG_Team1Benefit = dfgameSql1.Rs(j,"IG_TEAM1BENEFIT")
	            IG_DrawBenefit	= dfgameSql1.Rs(j,"IG_DRAWBENEFIT")
	            IG_Team2Benefit	= dfgameSql1.Rs(j,"IG_TEAM2BENEFIT")
	            IG_Score1		= dfgameSql1.Rs(j,"IG_SCORE1")
	            IG_Score2		= dfgameSql1.Rs(j,"IG_SCORE2")
	            IG_Type			= dfgameSql1.Rs(j,"IG_TYPE")
	            IG_Handicap		= dfgameSql1.Rs(j,"IG_HANDICAP")
	            IG_Draw		    = dfgameSql1.Rs(j,"IG_DRAW")
	            IBD_NUM         = dfgameSql1.Rs(j,"IBD_Num")
	            IBD_RESULT      = dfgameSql1.Rs(j,"IBD_RESULT")
	            IBD_RESULT_BENEFIT = dfgameSql1.Rs(j,"IBD_RESULT_BENEFIT")
	            IBD_BENEFIT = dfgameSql1.Rs(j,"IBD_BENEFIT")
            
                IG_Result = Trim(IG_Result)
                
                df = DATEDIFF("s",now(),Cdate(IG_StartTime))

                
                IF boolBET_CANCEL2 AND CDBL(df) < 0 Then            
                    boolBET_CANCEL2 = False
                End IF     
                           
                            
                IF (IG_Status = "E") OR (IG_Status = "S") Then
                    IG_Result = 3
                End IF
                        

	            IF IG_Type <> "0" THEN 
		            IG_DrawBenefit = IG_Handicap
	            END IF
                

                
                IF IG_Type = "1" Then
                    txtIG_Type  = "핸디"   
                    IG_DRAWBENEFIT =  IG_HANDICAP
                ElseIF IG_Type = "2" Then
                    txtIG_Type  = "오/언"  
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
                

                IF IBD_RESULT = "0" Then    
                txtIBD_RESULT = "실패"
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                End IF                  
            ElseIF IBD_RESULT = "1" Then
                txtIBD_RESULT = "적중"
                
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                End IF                
            ElseIF IBD_RESULT = "2" Then '취소
                txtIBD_RESULT = "1배처리"
                IG_Result = 4
            ElseIF IBD_RESULT = "3" Then '적특
                txtIBD_RESULT = "1배처리"
                IG_Result = 4
            Else
                txtIBD_RESULT = "진행"
            End IF
            
            IF IBD_RESULT_BENEFIT = 1 Then
                txtIBD_RESULT = "1배처리"
                IG_Result = 4                    
            End IF
                
                IF IBD_RESULT_BENEFIT = 1 Then
                    txtIBD_RESULT = "<font color='orange'><b>1배처리</b></font>"
                    IG_Result = 4                    
                End IF
                
                SCORE = IG_SCORE1 & " : " & IG_SCORE2
                
                '#### 진행 중인지 체크한다.
                IF IBD_RESULT = 9  Then
                   totalIBD_RESULT = 9 
                   IBD_RESULT_BENEFIT = IBD_BENEFIT
                End IF            
                
                TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                TotalBenefitA = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                
                'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "---" & TotalBenefit &"<br>"
                
                
                
%>
                <tr bgcolor="ffffff" >
                    <td align="center" ><%=dfStringUtil.GetFullDate(IG_StartTime)%></td>
                    <td align="center" ><%=txtIG_Type%></td>
                    <td align="center" ><%=RL_League%></td>
                    <td align="center" <%=cssSelected1%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" ><% IF IG_TYPE = "2" Then response.Write OVER_IMAGE %><%=IG_Team1%></td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FormatNumber(IG_TEAM1BENEFIT,2) %></td>
                            </tr>
                        </table>    
                    </td>                    
                    <td style="padding-top:4;" align="center" <%=cssSelected0%>>
                    
                        <%= dfStringUtil.getDrawValue(IG_TYPE, dfgameSql1.Rs(j,"IG_DRAWBENEFIT") ,dfgameSql1.Rs(j,"IG_HANDICAP")) %>
                    </td>
                    <td align="center" <%=cssSelected2%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td align="left" width="71" style="padding-left:4" align="center" ><%= FormatNumber(IG_TEAM2BENEFIT,2) %></td>
                                <td width="80%" align="right"width="71" style="padding-right:4" align="center" ><%=IG_Team2%><% IF IG_TYPE = "2" Then response.write UNDER_IMAGE %></td>
                            </tr>
                        </table>                       
                    </td>                   
                    <td style="padding-top:4;" align="center" ><%=SCORE%></td>
                    <td style="padding-top:4;" align="center" ><%=choice%></td>
                    <td style="padding-top:4;" align="center" ><%=txtIBD_RESULT%></td>                    
                </tr>
<%                            
		    Next
        End IF
        
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmountA = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmount = numdel2(BenefitAmount)
        BenefitAmountA = numdel2(BenefitAmountA)
        IF cInt(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
            resultBgColor1 = "Cancel"
        ElseIF cInt(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "Looser"
        Else                    
            IF cInt(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
                resultBgColor1 = "noSelected"
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "Winner"
            End IF                    
        End IF
                
                
        IF IB_CANCEL <> 0 Then
            totalIBD_RESULT = 4
            resultBgColor1 = "failGame"
        End IF 
%>
                <tr <tr bgcolor="#eeeeee">
                    <td colspan="7">
                        <table width="100%">
                        <tr>
                            <td>
                                배팅시간 : <B style='color:#7ACCC8'><%=dfStringUtil.GetFullDate(IB_REGDATE)%> </B>
                            </td>
                            <td>
                                배팅금액 : <B style='color:#7ACCC8'><%=FORMATNUMBER(IB_Amount,0)%></B> 원
                            </td>
                            <td>
                                배당률 : <B style='color:#7ACCC8'><%= FORMATNUMBER(TotalBenefit,2) %></B>
                            </td>                            
                            <td>
                                예상 적중금 :<B style='color:#7ACCC8'> <%= FORMATNUMBER(BenefitAmountA,0) %></B> 원
                            </td>                                                        
                            <td>
                                적중금액 : <B style='color:#7ACCC8'><%= FORMATNUMBER(BenefitAmount,0) %></B> 원
                            </td>                                                                                    
                        </tr>
                        </table>
                    </td>
                    <td  class="<%= resultBgColor1 %>" style="padding-top:4;" align="center" >
                    <%=txttotalIBD_RESULT(totalIBD_RESULT)%>&nbsp;
                    </td>
                    <td align="center">
                    
                    </td>
                </tr>
                </table>
                
                <div style="height:5px;"></div>
<%         

        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5
           
	Next 

		
END IF
%>	
<%
        End IF
    End IF
%>    
    </td>
</tr>
<!-- 배팅 내역 -->
<tr><td>&nbsp;</td>
	<td colspan="3" align="right">
	<table border="0" cellspacing="0" cellpadding="0">
	<tr><td align="center">
<input type="reset" value="등록"  onclick="javascript:location.href='/EPCenter/08_Board/Board_Write.asp?bType=<%=bType%>&BF_LEVEL=<%= BF_LEVEL %>';" style="border: 1 solid;width:50px; background-color: #C5BEBD;">	
		<input type="button" value=" 수 정 " onclick="goMo(<%=BF_Idx%>)" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
		<input type="button" value=" 삭 제 " onclick="goDelete(<%=BF_Idx%>);" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
		<input type="reset" value=" 목 록 " onclick="window.location='Board_List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table></td></tr>

<!-- 댓글입력폼... -->
<%
BFR_RegDate =""
IF cStr(bType) = "1" OR cStr(bType) = "2" OR cStr(bType) = "" Then
    Set PMLs = Server.CreateObject("ADODB.Recordset")
    PMLs.Open "select top 1 BN_NICKNAME, BN_LEVEL,BN_SPORTS from BOARD_NICKNAME  ORDER BY NEWID()", dbCon, 1
    IF NOT PMLs.EOF Then
        BFR_Writer=PMLs(0)
        BN_LEVEL=PMLs(1)
        BN_SPORTS=PMLs(2)
    End IF
End IF			

%>
<tr>
<form name="frm1" method="post" action="Board_Free_Reply_Proc.asp" target="HiddenFrm">
    <td colspan="4">
        <table border='0'>
            
            <input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
            <input type="hidden" name="ProcFlag" value="I">
            <input type="hidden" name="IU_LEVEL" value="<%=BN_LEVEL %>">
<!--------------------------------자동댓글------------------------------>
<!--------------------------------자동댓글------------------------------->
                <tr>	
		            <td height="25" width="70"><input type="text" name="BFR_Writer" style="width:100px;"value="<%= BFR_Writer %>" >
		            <Br /><%=BN_SPORTS  %> Lv. <%=BN_LEVEL %>
		            </td>
		            <td ><textarea name="BFR_Contents" rows="2" style="width:520px; overflow:auto;"></textarea></td>
		            <td width="150"> <input type="text" name="BFR_REGDATE"  maxlength="50"  value="<%= BFR_RegDate %>"></td>
		            <td width="50"><input type="button" onclick="goReply();" value="입 력" style="border: 1 solid; background-color: #C5BEBD; cursor:hand"></td>
                    
                </tr>
        </table>
	</td>
	
</form>	
</tr>
</table></td></tr>


<!--덧글 리스트-->

<%
	SQLMSG = "SELECT * FROM Board_Free_Reply WHERE BF_Idx = '"& BF_Idx &"' Order By BFR_Idx Desc"
	SET RS1 = DbCon.Execute(SQLMSG)

	IF NOT RS1.EOF THEN

		DO UNTIL RS1.EOF
			BFR_Idx			= RS1("BFR_Idx")
			BFR_WRITER		= RS1("BFR_WRITER")
			BFR_CONTENTS	= Trim(RS1("BFR_CONTENTS"))
            BFR_CONTENTS   = RePlace(BFR_CONTENTS,"<script","")
			BFR_REGDATE		= RS1("BFR_REGDATE")	%>
<table ><tr><td>
<tr><td colspan="4"><table><form name="re_<%=BFR_Idx%>" method="post" action="Reply_Mo.asp">
	<input type="hidden" name="BFR_Idx" value="<%=BFR_Idx%>">
	<input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
	<tr><td height="25" width="100"><input type="text" name="BFR_Writer" style="width:100px;"value="<%=BFR_Writer%>" ></td>
		<td style="overflow:scroll; width:545px; white-space:-moz-pre-wrap;word-break:break-all;">		
		    <textarea name="BFR_Contents<%=BFR_Idx%>" rows="3" style="width:520px; overflow:auto;"><%=BFR_Contents%></textarea>		
		</td>
		<td width="150"><input type="text" name="BFR_REGDATE"  maxlength="50"  value="<%=dfStringUtil.GetFullDate(BFR_REGDATE)%>"></td>
		<td width="50"><a href="javascript:goReplyDel('<%=BFR_Idx%>','<%=BF_Idx%>');" class="bold white">X</a></td>
		<td width="50"><input type="submit" value="수정"></td></tr></form></table></td></tr>

<%
		RS1.MoveNext
		LOOP

	END IF

	RS1.Close
	Set RS1 = Nothing	%>
	

</form>	

<script>

	function FrmChk1()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm2;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm2.submit();
		}
	}
	
	function FrmChk2()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm3;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm3.submit();
		}
	}	
		
	function f_addPoin()
	{	    
	    document.getElementById("addCost").value =  parseInt((document.getElementById("cost").value/100) * document.getElementById("per").value,10)
	}
</script>

<iframe width=0 height=0 frameborder=0 name="frmConent"></iframe>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>
