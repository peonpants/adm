<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/Seller/05_Account/Money_Total_Proc.asp" -->
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
<table class="tableborderlightgray"   cellspacing="0" cellpadding="1" bgcolor="#FFFFFF" width="98%" align="center">
	<tr class="tableborderlightgray"><td align="center" bgcolor="e7e7e7" class="title-backgra padding-5"><b><font color="#000000" style="font-size:12px;">���� (<%= date() %>)</font></b></td></tr>
	<tr><td  class="p_t_5p">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">	
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">���Ա�</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(INSUM,0)%></font> &nbsp;</td></tr>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">�����</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(OUTSUM),0)%></font> &nbsp;</td></tr>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">��������</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(BINSUM)-BOUSUM,0)%></font> &nbsp;</td></tr>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">�������</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(BTOSUM,0)%></font> &nbsp;</td></tr>
        <tr><td>&nbsp; <font color="#000000" style="font-size:12px;">��������</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(NEW_BTOSUM,0)%></font> &nbsp;</td></tr>						
        <td>&nbsp; <font color="#000000" style="font-size:12px;">�����Ӵ�</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(SUSERMO,0)%></font> &nbsp;</td></tr>			
	</table>
	</td></tr>
</table>


<div class="h_5"></div>
<table class="tableborderlightgray" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF" width="98%" align="center">
	<tr  class="tableborderlightgray" ><td align="center" bgcolor="e7e7e7"  class="title-backgra padding-5"><b><font color="#000000" style="font-size:12px;">������Ȳ (<%= date() %>)</font></b></td></tr>
	<tr><td  class="p_t_5p"><table border="0" cellpadding="0" cellspacing="0" width="100%">	

<%
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_Type = RS2("IA_Type")

	If IA_LEVEL = 2 Then
	level = "�κ���"
	elseIf IA_LEVEL = 3 Then
	level = "����"
	elseIf IA_LEVEL = 4 Then
	level = "����"
	elseIf IA_LEVEL = 5 Then
	level = "���θ���"
	End if
%>

<% If ia_type = 1 Then %>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">Ŀ�̼ǿ���</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=PROSP%></font> &nbsp;%</td></tr>

<% Else %>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">������Ŀ�̼�</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=PROSP%></font> &nbsp;%</td></tr>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">�ǽð�Ŀ�̼�</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=PROLI%></font> &nbsp;%</td></tr>
<% End If %>
<% If IA_LEVEL = 2 Then %>
		<tr><td>&nbsp; <font color="#000000" style="font-size:12px;">�Ϻ����ǰ���</font></td>
			<td align="right"><font color="#000000" style="font-size:12px;"><%=CHONG1%></font> &nbsp;��</td></tr>

<% End If %>
			</table></td></tr>
</table>
</body>

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
