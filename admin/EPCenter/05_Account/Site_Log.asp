<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/EPCenter/05_Account/Money_Total_Proc.asp" -->
<%
	Response.Charset = "euc-kr"
%>
<html>
<head>
<title>사이트별 현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/_Common/inc/Css/Style2.css">
<script src="/Sc/Base.js"></script>
</head>
<BODY >

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list0" style=table-layout:fixed> 
    <tr><td align="left" width="40%"><strong>&nbsp;&nbsp;사이트별 현황</strong></td></tr>

    <tr> 
      <td>
      <br />
        <!-- 테이블 목록 시작 -->
        <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#6C6C6C">
            <tr>
                <td width="40"  height="31" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>번호</td>
                <td style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>사이트</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>총입금</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>총출금</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>총배팅</td>
                <td width="100"style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>총배당</td>
                <td width="100"style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>유저총머니</td>
            </tr>

            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>1</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1)-BOUSUM1,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO,0)%></td>
            </tr>
            
            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>2</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission-a</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1A,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1A),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1A)-BOUSUM1A,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1A,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO02,0)%></td>
            </tr>

            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>3</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission-b</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1B,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1B),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1B)-BOUSUM1B,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1B,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO03,0)%></td>
            </tr>

            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>4</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission-c</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1C,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1C),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1C)-BOUSUM1C,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1C,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO04,0)%></td>
            </tr>

            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>5</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission-d</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1D,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1D),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1D)-BOUSUM1D,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1D,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO05,0)%></td>
            </tr>

            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="31" style="padding-top:3;" align="center" class=text4>6</td>
                <td bgcolor="#FFFFFF" style="padding-top:3;" align="center" class=text4>mission-e</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(INSUM1E,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(OUTSUM1E),0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(ABS(BINSUM1E)-BOUSUM1E,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(BTOSUM1E,0)%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:3;" align="center" class=text4><%=FORMATNUMBER(USERMO06,0)%></td>
            </tr>
            
            <tr>
                <td bgcolor="#CC8800" style="padding-top:3;" align="center" class=text2 colspan=2>종합</td>
                <td bgcolor="#668800" width="100" style="padding-top:3;" align="center" class=text2><%=FORMATNUMBER(INSUM,0)%></td>
                <td bgcolor="#668800" width="100" style="padding-top:3;" align="center" class=text2><%=FORMATNUMBER(ABS(OUTSUM),0)%></td>
                <td bgcolor="#668800" width="100" style="padding-top:3;" align="center" class=text2><%=FORMATNUMBER(ABS(BINSUM)-BOUSUM,0)%></td>
                <td bgcolor="#668800" width="100" style="padding-top:3;" align="center" class=text2><%=FORMATNUMBER(BTOSUM,0)%></td>
                <td bgcolor="#668800" width="100" style="padding-top:3;" align="center" class=text2><%=FORMATNUMBER(USERMO06+USERMO05+USERMO04+USERMO03+USERMO02+USERMO,0)%></td>
            </tr>

        </table>
        <!-- 테이블 목록 끝 -->
        
      </td>
    </tr>
</table>
<br clear="all">

</form>
</body>

<%  
	IF TBOD01 > 0 THEN 
		If Request.Cookies("ins04") <> "no" Then
%>
<embed src='/midi/jecica.wav' volume=300 hidden=true>
<%
		End If 
	END If
%>
<% 
	IF TBOD02 > 0 THEN 
		If Request.Cookies("ins04") <> "no" Then
%>
<embed src='/midi/bal.wav' volume=300 hidden=true>
<%
		End If 
	END If
%>
<% 
	IF TBOD03 > 0 THEN 
		If Request.Cookies("ins04") <> "no" Then
%>
<embed src='/midi/toto.wav' volume=300 hidden=true>
<%
		End If 
	END If
%>

<% 'IF TREY > 0 THEN %><!-- <embed src="/midi/Reply.mid" hidden=true> --><% 'END IF %>