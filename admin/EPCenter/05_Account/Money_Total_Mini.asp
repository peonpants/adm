<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/EPCenter/05_Account/Money_Total_Proc.asp" -->
<%
	Response.Charset = "euc-kr"
	
	JOBSITE = request.Cookies("JOBSITE")
	
	JOBSITE = "all"
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html;">
<BODY >
<% IF JOBSITE = "all" THEN %>		
<table border="1"  bordercolorlight="#000000" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF" width="98%" align="center">
<tr><td align="center" bgcolor="e7e7e7"><b><font color="#000000" style="font-size:12px;">종합 (<%= date() %>)</font></b></td></tr>
<tr><td><table border="0" cellpadding="0" cellspacing="0" width="100%">	
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">총입금</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(INSUM,0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">총출금</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(OUTSUM),0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">남은배팅</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(NEW_BTOSUM,0)%></font></td></tr>						
        <tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">유저머니</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(SUSERMO,0)%></font></td></tr>
        <tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">보유포인트</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(SUSERMOP,0)%></font></td></tr>
		<tr><td colspan="2"><FONT COLOR=RED>--------------------------------</FONT></td></tr>		
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배팅(토탈)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(BINSUM)-BOUSUM,0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배팅(SP)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(BINSUM1)-BOUSUM1,0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배팅(LI)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(BINSUM2)-BOUSUM2,0)%></font></td></tr>
		<tr><td colspan="2"><FONT COLOR=RED>--------------------------------</FONT></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배당(토탈)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(BTOSUM,0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배당(SP)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(BTOSUM1,0)%></font></td></tr>
		<tr><td width="100" valign="top">&nbsp; <font color="#000000" style="font-size:12px;">누적배당(LI)</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(BTOSUM2,0)%></font></td></tr>

			</table></td></tr>
</table>
</body>
<% END IF %>
</html>

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

<% IF TREY > 0 THEN %><embed src="/midi/Reply.mid" hidden=true><% END IF %>
