<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<%
Response.CacheControl	= "no-cache"
Response.Expires		= -1
Response.Buffer			= true
Response.ContentType	="text/html"
Response.CharSet		= "euc-kr"
Response.AddHeader "pragma","no-cache"
%>
<!-- #include virtual="/EPCenter/05_Account/topMenuInfo.Code.asp" -->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp" --->
<%

	IF request.Cookies("AdminLevel") = 1 THEN
		AdminLevel = 1
		AdminPosition = "�����Ͱ�����"
	ELSEIF request.Cookies("AdminLevel") = 2 THEN
		AdminLevel = 2
		AdminPosition = "������"
	END IF
        
    IF AdminLevel = 1 THEN 

	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"
%>

<table>
 <tr>
  <td class="top_bar"><span></span></td>
  <td>
   <table class="top_box">
    <tr>
	 <td rowspan="2" class="sky" width="57"><span><b>�Ա�</span></td>
	 <td class="sky_title"><span>��û</span></td>
	 <td class="sky_title"><span>���</span></td>
	 <td class="sky_title"><span>�Ϸ�</span></td>
	</tr>
	<tr>
	 <td class="sky_white" <% IF TINPUT > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then %>style="background: #fff200;"<% End If
		End If %>><a href="/EPCenter/05_Account/Charge_List.asp" target="ViewFrm"><%=TINPUT%></a></td>
	 <td class="sky_white"><a href="/EPCenter/05_Account/Charge_List.asp?Search=IC_STATUS&Find=2&sStartDate=20000101&sEndDate=29990101" target="ViewFrm"><%=INSUM_2%></a></td>
	 <td class="sky_white"><a href="/EPCenter/05_Account/Charge_List.asp?Search=IC_STATUS&Find=1&sStartDate=20000101&sEndDate=29990101" target="ViewFrm"><%=INSUM_1%></a></td>
	</tr>
   </table>
  </td>
  <td class="top_bar"><span></span></td>
  <td>
   <table class="top_box">
    <tr>
	 <td rowspan="2" class="navy" width="57"><span><b>���</span></td>
	 <td class="navy_title"><span>��û</span></td>
	 <td class="navy_title"><span>���</span></td>
	 <td class="navy_title"><span>�Ϸ�</span></td>
	</tr>
	<tr>
	 <td class="navy_white" <% IF TOUTPUT > 0 THEN 
		If Request.Cookies("ins02") <> "no" Then %>style="background: #fff200;"<% End If
		End If %>><a href="/EPCenter/05_Account/Exchange_List.asp" target="ViewFrm"><%=TOUTPUT%></a></td>
	 <td class="navy_white"><a href="/EPCenter/05_Account/Exchange_List.asp?Search=A.IE_STATUS&Find=2&sStartDate=20000101&sEndDate=29990101" target="ViewFrm"><%=OUTSUM_2%></a></td>
	 <td class="navy_white"><a href="/EPCenter/05_Account/Exchange_List.asp?Search=A.IE_STATUS&Find=1&sStartDate=20000101&sEndDate=29990101" target="ViewFrm"><%=OUTSUM_1%></a></td>
	</tr>
   </table>
  </td>
  <td class="top_bar"><span></span></td>
  <td>
   <table class="top_box">
    <tr>
	 <td rowspan="2" class="sky" width="57"><span><b>����</span></td>
	 <td class="sky_title"><span>��û</span></td>
	 <td class="sky_title"><span>���</span></td>
	</tr>
	<tr>
	 <td class="sky_white" <% IF TMSG > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then %>style="background: #fff200;"<% End If
		End If %>><a href="/EPCenter/07_Customer/List.asp" target="ViewFrm"><%=TMSG%></a></td>
	 <td class="sky_white"><a href="/EPCenter/07_Customer/List.asp" target="ViewFrm"><%=TMSG_2%></a></td>
	</tr>
   </table>
  </td>
  <td class="top_bar"><span></span></td>
  <td>
   <table class="top_box">
    <tr>
	 <td rowspan="2" class="navy" width="57"><span><b>ȸ��</span></td>
	 <td class="navy_title"><span>ȸ����</span></td>
	 <td class="navy_title"><span>�ֱٽű�</span></td>
	 <td class="navy_title"><span>����</span></td>
	</tr>
	<tr>
	 <a href="/EPCenter/02_Member/List.asp" target="ViewFrm"><td class="navy_white" <% IF NEW_USER_NICKNAME <> "" Then %>style="background: #fff200;"<% End IF %>><%=USER_IN%></td></a>
	 <a href="/EPCenter/02_Member/List.asp" target="ViewFrm"><td class="navy_white"><%=Left(NEW_USER_NICKNAME,4)%></td></a>
	 <td class="navy_white"><% IF cStr(SET_EXE) = "1" Then %>
        <a href="SET_EXE_INC_Proc.asp?flag=0">����
    <% Else %>        
        <a href="SET_EXE_INC_Proc.asp?flag=1">����
    <% End IF %></td>
	</tr>
   </table>
  </td>
  <td class="top_bar"><span></span></td>
 </tr>
</table>

<div style="width: 0px; height: 0px; display: none;">
<%
    '����
	IF TINPUT > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
			Response.Write "<script language='javascript'>"
			Response.Write "alert('����!');"
			Response.Write "</script>"
		End If 
	END If
%>
<% 
    'ȯ��
	IF TOUTPUT > 0 THEN 
		If Request.Cookies("ins02") <> "no" Then
%>
<embed src='/midi/xylofun.wav' hidden=true>
<%
		End If 
	END If
%>
<% 
    '������
	IF TMSG > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
%>
<embed src='/midi/cu.wav' volume=300 hidden=true>
<%
		End If 
	END If
	
	IF GAME_IN > 0 THEN 
%>
<embed src='/midi/TAdUpd07.wav' hidden=true volume=300>
<%
	END If
		
   else
%>
<%end if%>

<% IF WB > 0 THEN %>
<embed src="/midi/toto.wav" volume=300 hidden=true>
<% END IF %>
</div>
<!--<% 
    '����
	IF TINPUT > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
%>
<embed src='/midi/charge.mid' hidden=true></embed>
<%
		End If 
	END If
%>
<% 
    'ȯ��
	IF TOUTPUT > 0 THEN 
		If Request.Cookies("ins02") <> "no" Then
%>
<embed src='/midi/xylofun.wav' hidden=true>
<%
		End If 
	END If
%>
<% 
    '������
	IF TMSG > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
%>
<embed src='/midi/cu.wav' volume=300 hidden=true>
<%
		End If 
	END If
	
	IF GAME_IN > 0 THEN 
%>
<embed src='/midi/TAdUpd07.wav' hidden=true volume=300>
<%
	END If
		
   else
%>
<%end if%>

<% IF WB > 0 THEN %>
<embed src="/midi/toto.wav" volume=300 hidden=true>
<% END IF %>
</div>
-->