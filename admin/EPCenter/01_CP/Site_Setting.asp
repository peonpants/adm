<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 사이트 설정 값 부름                    ################	
    Call dfCpSql.RetrieveSet_Site(dfDBConn.Conn)
    
	ListCount = dfCpSql.RsCount - 1
	
    Dim dfcpSql1
    Set dfcpSql1 = new cpSql	
    
    '비공개 설정
    Call dfCpSql1.GetSET_SITE_OPEN(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        SITE_OPEN = dfCpSql1.RsOne("SITE_OPEN")
    End IF
    
    '잭팟 설정
    Call dfCpSql1.GetSET_SITE_JACKPOT(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        IJ_CASH = dfCpSql1.RsOne("IJ_CASH")
        IJ_PERCENT = dfCpSql1.RsOne("IJ_PERCENT")
    End IF        
        
    '도메인 변경 알림         
    Call dfCpSql1.GetINFO_DOMAIN(dfDBConn.Conn)	
    IF dfCpSql1.RsCount <> 0  Then
	    ID_NAME = dfCpSql1.RsOne("ID_NAME")
        ID_URL = dfCpSql1.RsOne("ID_URL")
        ID_USE = dfCpSql1.RsOne("ID_USE")
    End IF    
   
    'UCC 동영상
    SITE_UCC = 0
    'Call dfCpSql1.GetINFO_SITE_UCC(dfDBConn.Conn)
    'IF dfCpSql1.RsCount <> 0  Then
    '    SITE_UCC = dfCpSql1.RsOne("SITE_UCC")
    'End IF     
    
    SITE_EXCHANGE = 0
    'Call dfCpSql1.GetINFO_SITE_EXCHANGE(dfDBConn.Conn)
    'IF dfCpSql1.RsCount <> 0  Then
    '    SITE_EXCHANGE = dfCpSql1.RsOne("SITE_EXCHANGE")
    'End IF     
    
    Call dfCpSql1.GetSET_7M_USE(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        int7M_USE = dfCpSql1.RsOne("A_7M_USE")
    End IF             
    
    Call dfCpSql1.GetSET_SUBEXCHANGE_USE(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        EXCHANGE_USE = dfCpSql1.RsOne("EXCHANGE_USE")
    End IF             
    
     Call dfCpSql1.GetSET_CHAT_USE(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        intCHAT_USE = dfCpSql1.RsOne("A_CHAT_USE")
    End IF  
	
	Call dfCpSql1.GetSET_BET_MAX(dfDBConn.Conn)
    IF dfCpSql1.RsCount <> 0  Then
        S_CNT = dfCpSql1.RsOne("scnt")
		P_CNT = dfCpSql1.RsOne("pcnt")
		H_CNT = dfCpSql1.RsOne("hcnt")
		L_CNT = dfCpSql1.RsOne("lcnt")
		A_CNT = dfCpSql1.RsOne("acnt")
		D_CNT = dfCpSql1.RsOne("dcnt")
		R_CNT = dfCpSql1.RsOne("rcnt")
		V_CNT = dfCpSql1.RsOne("vcnt")
		M_CNT = dfCpSql1.RsOne("mcnt")
    End IF 

    '회원 레벨별 낙첨금 설정
    Call dfCpSql1.RetrieveINFO_USER_LEVEL(dfDBConn.Conn)	
   
    	
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<!--<script src="/Sc/Base.js"></script>-->
<script language="javascript">

function selftest() {

	if (document.SBGame.SITE01.value == "") { alert("\n 등록하실 사이트명을 입력하세요. \n"); document.SBGame.SITE01.focus(); return false; }
	if (document.SBGame.SITE02.value == "") { alert("\n 사이트 URL을 입력하세요. \n"); document.SBGame.SITE02.focus(); return false; }
	if (document.SBGame.SITE03.value == "") { alert("\n 사이트 타이틀명을 입력하세요. \n"); document.SBGame.SITE03.focus(); return false; }

	return true
 }

function go_delete(SEQ) {
	if (!confirm("정말 삭제하시겠습니까?")) return;
	location.href = "Site_Proc.asp?EMODE=SB_DELETE&SEQ="+SEQ;
}

</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 사이트 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<form name="SBGameADD" method="post" action="Site_Proc.asp">
<input type="hidden" name="EMODE" value="SB_MODIFY">
<input type="hidden" name="SBCount" value="<%=ListCount%>">
<tr><td width="80" bgcolor="e7e7e7" align="center"><b>사이트명</b></td>
	<td width="200" bgcolor="e7e7e7" align="center"><b>사이트URL</b></td>
	<td width="300" bgcolor="e7e7e7" align="center"><b>사이트 타이틀명</b></td>
	<td width="120" bgcolor="e7e7e7" align="center"><b>은 행 명</b></td>
	<td width="120" bgcolor="e7e7e7" align="center"><b>은행계좌</b></td>
	<td width="120" bgcolor="e7e7e7" align="center"><b>예금주명</b></td>
	<!--<td width="120" bgcolor="e7e7e7" align="center"><b>지정번호</b></td>-->
	<td width="20" bgcolor="e7e7e7" align="center">&nbsp;</td></tr>

<%	IF dfCpSql.RsCount = 0 THEN %>

<tr height="40"><td align="center" colspan="7"><b>등록된 게임설정 내용이 없습니다.</b></td></tr>

<%	ELSE

	    FOR i = 0 TO dfCpSql.RsCount -1

	        SEQ = dfCpSql.Rs(i,"SEQ")
	        SITE01 = dfCpSql.Rs(i,"SITE01")
	        SITE02 = dfCpSql.Rs(i,"SITE02")
	        SITE03 = dfCpSql.Rs(i,"SITE03")
	        SITE04 = dfCpSql.Rs(i,"SITE04")
	        SITE05 = dfCpSql.Rs(i,"SITE05")
	        SITE06 = dfCpSql.Rs(i,"SITE06")		
	        SITE07 = dfCpSql.Rs(i,"SITE07")		
%>

<tr><td><input type="text" name="SITE01_<%=i%>" value="<%=SITE01%>" style="width:80px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SITE02_<%=i%>" value="<%=SITE02%>" style="width:200px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SITE03_<%=i%>" value="<%=SITE03%>" style="width:300px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SITE04_<%=i%>" value="<%=SITE04%>" style="width:120px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SITE05_<%=i%>" value="<%=SITE05%>" style="width:120px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SITE06_<%=i%>" value="<%=SITE06%>" style="width:120px;border:1px solid #cacaca;"></td>
	<!--<td><input type="text" name="SITE07_<%=i%>" value="<%=SITE07%>" style="width:120px;border:1px solid #cacaca;"></td>-->
	<td><input type="reset" value=" 삭제 " onclick="javascript:go_delete('<%=SEQ%>');" style="border: 1 solid; background-color: #C5BEBD;" id=reset1 name=reset1></td>
	<input type="hidden" name="SEQ_<%=i%>" value="<%=SEQ%>"></tr>

<%	
	    NEXT	
	END IF

%>
	</table>
<table width="1017" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td width="1017" align="right">
	<input type="submit" value=" 수 정 " style="border:1 solid;"></td></tr>
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table></form>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 사이트등록</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame" method="post" action="Site_Proc.asp" onsubmit="return selftest()">
<input type="hidden" name="EMODE" value="SB_ADD">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>1. 사이트명</b></td>
	<td width="500" align="center"><input type="text" name="SITE01" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>2. 사이트 URL</b></td>
	<td align="center"><input type="text" name="SITE02" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>3. 사이트 타이틀</b></td>
	<td align="center"><input type="text" name="SITE03" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>4. 관리자 은행명</b></td>
	<td align="center"><input type="text" name="SITE04" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>5. 관리자 은행계좌</b></td>
	<td align="center"><input type="text" name="SITE05" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>6. 관리자 예금주명</b></td>
	<td align="center"><input type="text" name="SITE06" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>
<!--<tr><td bgcolor="e7e7e7">&nbsp;<b>7. 관리자 지정번호(회원가입연동용)</b></td>
	<td align="center"><input type="text" name="SITE07" value="" style="width:495px;border:1px solid #cacaca;"></td></tr>-->
	</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" 등 록 " style="border:1 solid;"></td></tr></table></form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 비공개 설정</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame1" method="post" action="Site_Proc.asp" >
<input type="hidden" name="EMODE" value="SB_OPEN">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>사이트 비공개 설정</b></td>
	<td width="500" align="left">
	    <select name="siteOpen">
	        <option value="1" <% IF SITE_OPEN = "1" Then %>selected<% End IF %>>공개</option>
	        <option value="2" <% IF SITE_OPEN = "2" Then %>selected<% End IF %>>추천인가입</option>
	        <option value="3" <% IF SITE_OPEN = "3" Then %>selected<% End IF %>>추천장가입</option>	        
	        <option value="4" <% IF SITE_OPEN = "4" Then %>selected<% End IF %>>비공개</option>
	        <option value="5" <% IF SITE_OPEN = "5" Then %>selected<% End IF %>>핸드폰가입</option>
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" 수 정 " style="border:1 solid;"></td></tr></table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 회원별 레벨 설정</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr height="25" bgcolor="e7e7e7">
    <td >회원레벨</td>
    <td >최소배팅액</td>
    <td >최대배팅액</td>
    <td >상한가</td>
    <td >단폴더금액제한</td>    
    <td >회원(스포츠)낙첨금(%)</td>
    <td >회원(실시간)낙첨금(%)</td>
    <td >추천인(스포츠)낙첨금(%)</td>
    <td >추천인(실시간)낙첨금(%)</td>
    <td >회원(스포츠)배팅금(%)</td>
    <td >회원(실시간)배팅금(%)</td>
    <td >추천인(스포츠)배팅금(%)</td>
    <td >추천인(실시간)배팅금(%)</td>
    <td >하루 첫 충전시(%)</td>
    <td >수정</td>
</tr>
<%
    IF dfCpSql1.RsCount <> 0 Then
        For ii = 0 to dfCpSql1.RsCount  -1
%>
<form name="levelForm<%= ii %>" method="post"  action="Site_Proc.asp">
<input type="hidden" name="EMODE" value="SITE_LEVEL">
<input type="hidden" name="IUL_LEVEL" value=" <%= dfCpSql1.Rs(ii,"IUL_LEVEL") %>" />
<tr height="25">
    <td>
       <%= dfCpSql1.Rs(ii,"IUL_LEVEL") %>레벨
       <%
       IF dfCpSql1.Rs(ii,"IUL_LEVEL") = 9 Then
       %>
       관리자
       <% End IF %>
    </td>
    <td>
        <input type="text" name="IUL_BETTINGMIN" value="<%= dfCpSql1.Rs(ii,"IUL_BETTINGMIN") %>" size="8" class="input" />원
    </td>    
    <td>
        <input type="text" name="IUL_BETTINGMAX" value="<%= dfCpSql1.Rs(ii,"IUL_BETTINGMAX") %>" size="8" class="input" />원
    </td>    
    <td>
        <input type="text" name="IUL_BENEFITMAX" value="<%= dfCpSql1.Rs(ii,"IUL_BENEFITMAX") %>" size="8" class="input" />원
    </td>            
    <td>
        <input type="text" name="IUL_BETTING_ONE_MIN" value="<%= dfCpSql1.Rs(ii,"IUL_BETTING_ONE_MIN") %>" size="8" class="input" />원
    </td>    
    <td>
        <input type="text" name="IUL_Percent" value="<%= dfCpSql1.Rs(ii,"IUL_Percent")*100 %>" size="5" class="input" />%
    </td>
    <td>
        <input type="text" name="IUL_Percent_live" value="<%= dfCpSql1.Rs(ii,"IUL_Percent_live")*100 %>" size="5" class="input" />%
    </td>
    <td>
        <input type="text" name="IUL_Recom_Percent" value="<%= dfCpSql1.Rs(ii,"IUL_Recom_Percent")*100 %>" size="5" class="input" />%
    </td>   
    <td>
        <input type="text" name="IUL_Recom_Percent_live" value="<%= dfCpSql1.Rs(ii,"IUL_Recom_Percent_live")*100 %>" size="5" class="input" />%
    </td> 	


    <td>
        <input type="text" name="IUL_BPercent" value="<%= dfCpSql1.Rs(ii,"IUL_BPercent")*100 %>" size="5" class="input" />%
    </td>
    <td>
        <input type="text" name="IUL_BPercent_live" value="<%= dfCpSql1.Rs(ii,"IUL_BPercent_live")*100 %>" size="5" class="input" />%
    </td>
    <td>
        <input type="text" name="IUL_Recom_BPercent" value="<%= dfCpSql1.Rs(ii,"IUL_Recom_BPercent")*100 %>" size="5" class="input" />%
    </td>   
    <td>
        <input type="text" name="IUL_Recom_BPercent_live" value="<%= dfCpSql1.Rs(ii,"IUL_Recom_BPercent_live")*100 %>" size="5" class="input" />%
    </td> 	


    <td>
        <input type="text" name="IUL_Charge_Percent" value="<%= dfCpSql1.Rs(ii,"IUL_Charge_Percent")*100 %>" size="5" class="input" />%
    </td>                
    <td>
        <input type="submit" value="수정" class="input" />
    </td>            
</tr>
</form>
<%
    Next
End IF
%>
</table>




<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 총판관리자 환전기능설정</b></td>
</tr>
</table>    


<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame2" method="post" action="Site_Proc.asp" >
<input type="hidden" name="EMODE" value="EXCHANGE2">
<tr>
  <td colspan="2" height="30" align="left" bgcolor="red"><font color="white"><b>
  **총판관리자 페이지의 환전신청기능을 설정합니다</br>
  **환전가능시 총판관리자에 마일리지 환전신청메뉴가 추가되며 실시간의 환전이 가능합니다</br>
  </b></font></td>
</tr>
<div style="height:10px;"></div>
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>환전신청기능</b></td>
	<td width="500" align="left">
	    <select name="EXCHANGE_USE">
	        <option value="1" <% IF cStr(EXCHANGE_USE) ="1" Then %>selected<% End IF %>>사용</option>
	        <option value="0" <% IF cStr(EXCHANGE_USE) ="0" Then %>selected<% End IF %>>사용안함</option>
	    </select>
    </td>
</tr>
</table>	
	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" 수 정 " style="border:1 solid;"></td></tr></table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 자동 정산</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame8" method="post" action="Site_Proc.asp" >
<input type="hidden" name="EMODE" value="CAUTO">
<tr><td width="200" bgcolor="e7e7e7">&nbsp;<b>자동 유무</b></td>
	<td width="500" align="left">
	    <select name="CHAT_USE">
	        <option value="1" <% IF cStr(intCHAT_USE) ="1" Then %>selected<% End IF %>>사용</option>
	        <option value="0" <% IF cStr(intCHAT_USE) ="0" Then %>selected<% End IF %>>사용안함</option>
	    </select>
    </td>
</tr>
</table>	
	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" 수 정 " style="border:1 solid;"></td></tr></table>
</form>	

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 실시간 배팅제한</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame9" method="post" action="Site_Proc.asp" >
<input type="hidden" name="EMODE" value="MAXAUTO">
<font color="red">**실시간 경기 동일회차의 베팅횟수를 제한하는 설정입니다</br>
**사다리항목을 1로 바꾸시면 동일회차에 베팅할수있는 횟수는 1회입니다.</br>
**해당회차를 0으로 설정하면 해당메뉴의 베팅이 불가합니다.</br>
<tr>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>사다리</b></td>
	<td width="100" align="left">
	    <select name="S_CNT">
	        <option value="0" <% IF cStr(S_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(S_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(S_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(S_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>파워볼</b></td>
	<td width="100" align="left">
	    <select name="P_CNT">
	        <option value="0" <% IF cStr(P_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(P_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(P_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(P_CNT) ="3" Then %>selected<% End IF %>>3</option>
			<option value="4" <% IF cStr(P_CNT) ="4" Then %>selected<% End IF %>>4</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>로하이</b></td>
	<td width="100" align="left">
	    <select name="H_CNT">
	        <option value="0" <% IF cStr(H_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(H_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(H_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(H_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>주사위</b></td>
	<td width="100" align="left">
	    <select name="D_CNT">
	        <option value="0" <% IF cStr(D_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(D_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(D_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(D_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>알라딘사다리</b></td>
	<td width="100" align="left">
	    <select name="A_CNT">
	        <option value="0" <% IF cStr(A_CNT) ="0" Then %>selected<% End IF %>>0</option>
			<option value="1" <% IF cStr(A_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(A_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(A_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>실시간</b></td>
	<td width="100" align="left">
	    <select name="L_CNT" width="100">
	        <option value="0" <% IF cStr(L_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(L_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(L_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(L_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>다리다리</b></td>
	<td width="100" align="left">
	    <select name="R_CNT">
	        <option value="0" <% IF cStr(R_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(R_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(R_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(R_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>가상축구</b></td>
	<td width="100" align="left">
	    <select name="V_CNT" width="100">
	        <option value="0" <% IF cStr(V_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(V_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(V_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(V_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
	<td width="100" bgcolor="e7e7e7">&nbsp;<b>MGM홀짝</b></td>
	<td width="100" align="left">
	    <select name="M_CNT" width="100">
	        <option value="0" <% IF cStr(M_CNT) ="0" Then %>selected<% End IF %>>0</option>
	        <option value="1" <% IF cStr(M_CNT) ="1" Then %>selected<% End IF %>>1</option>
	        <option value="2" <% IF cStr(M_CNT) ="2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(M_CNT) ="3" Then %>selected<% End IF %>>3</option>
	    </select>
    </td>
</tr>
</table>	
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" 수 정 " style="border:1 solid;"></td></tr></table>
</form>	

<br />
<br />
<br />
<br />
</body>
</html>