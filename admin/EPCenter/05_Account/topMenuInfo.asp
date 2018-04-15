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
		AdminPosition = "마스터관리자"
	ELSEIF request.Cookies("AdminLevel") = 2 THEN
		AdminLevel = 2
		AdminPosition = "리셀러"
	END IF
        
    IF AdminLevel = 1 THEN 

	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"
%>

<meta http-equiv="Content-Type" content="text/html;">
<table width="930" border="0" align="left" cellpadding='5' cellspacing='1' bgcolor="cccccc">
  <tr height="30" valign="center">
    <td width="45" bgcolor="#000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">충전</b>
      </div>
	</td>
    <a href="/EPCenter/05_Account/Charge_List.asp?Search=IC_STATUS&Find=0&sStartDate=20000101&sEndDate=29990101" target="ViewFrm">
		<% If TINPUT > 0 Then %>
	<td width="80" bgcolor="red" style="cursor:hand;" >
	  <div align="left" class="text04" style="color: white;">요청 :
	    <b><%=TINPUT%></b>
	  </div>
	</td>
		<% Else %>
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">요청 :
	    <b><%=TINPUT%></b>
	  </div>
	</td>
		<% End If %>
	</a>
    <a href="/EPCenter/05_Account/Charge_List.asp?Search=IC_STATUS&Find=2&sStartDate=20000101&sEndDate=29990101" target="ViewFrm">
		<% If INSUM_2 > 0 Then %>
	<td width="80" bgcolor="red" style="cursor:hand;" >
	  <div align="left" class="text04" style="color: white;">대기
	    <b><%=INSUM_2%></b>
	  </div>
	</td>
		<% Else %>
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">대기
	    <b><%=INSUM_2%></b>
	  </div>
	</td>
		<% End If %>
	</a>
    <a href="/EPCenter/05_Account/Charge_List.asp" target="ViewFrm">
    <td width="90" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">완료 :
	    <b><%=INSUM_1%></b>
	  </div>
	</td>
	</a>
    <td width="45" bgcolor="000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">환전</b>
	  </div>
	</td>
    <a href="/EPCenter/05_Account/Exchange_List.asp?Search=A.IE_STATUS&Find=0&sStartDate=20000101&sEndDate=29990101" target="ViewFrm">
		<% If TOUTPUT > 0 Then %>
	<td width="80" bgcolor="yellow" style="cursor:hand;" >
	  <div align="left" class="text04">요청 :
	    <b><%=TOUTPUT%></b>
      </div>
	</td>
		<% Else %>
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">요청 :
	    <b><%=TOUTPUT%></b>
      </div>
	</td>
		<% End If %>
	</a>
    <a href="/EPCenter/05_Account/Exchange_List.asp?Search=A.IE_STATUS&Find=2&sStartDate=20000101&sEndDate=29990101" target="ViewFrm">
		<% If OUTSUM_2 > 0 Then %>
	<td width="80" bgcolor="yellow" style="cursor:hand;" >
	  <div align="left" class="text04">대기
	    <b><%=OUTSUM_2%></b>
	  </div>
	</td>
		<% Else %>
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">대기
	    <b><%=OUTSUM_2%></b>
	  </div>
	</td>
		<% End If %>
	</a>
    <a href="/EPCenter/05_Account/Exchange_List.asp" target="ViewFrm">
    <td width="90" bgcolor="ffffff" style="cursor:hand;" >
    <div align="left" class="text04">완료:
	  <b><%=OUTSUM_1%></b>
	</div>
	</td>
	</a>
    <td width="80" bgcolor="000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">고객센터</b>
	  </div>
	</td>
	<% If TMSG > 0 Then %>
    <a href="/EPCenter/07_Customer/List2.asp" target="ViewFrm">
	<td width="80" bgcolor="48ff00" style="cursor:hand;" >
	  <div align="left" class="text04">요청 :
	    <b><%=TMSG%></b>
	  </div>
	</td>
	</a>
	<% Else %>
    <a href="/EPCenter/07_Customer/List2.asp" target="ViewFrm">
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">요청 :
	    <b><%=TMSG%></b>
	  </div>
	</td>
	</a>
	<% End If %>
	<% If TMSG_2 > 0 Then %>
    <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm">
	<td width="80" bgcolor="48ff00" style="cursor:hand;" >
	  <div align="left" class="text04">대기 :
	    <b><%=TMSG_2%></b>
	  </div>
	</td>
	</a>
	<% Else %>
    <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm">
	<td width="80" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="left" class="text04">대기 :
	    <b><%=TMSG_2%></b>
	  </div>
	</td>
	</a>
	<% End If %>
    <td width="45" bgcolor="000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">회원</b>
	  </div>
	</td>
	<a href="/EPCenter/02_Member/List.asp" target="ViewFrm">
    <td width="45" <% IF NEW_USER_NICKNAME <> "" Then %>bgcolor="FED457"<% Else %>bgcolor="ffffff"<% End IF %> style="cursor:hand;" >
	  <div align="center" class="text04">
	    <b>
	      <%=USER_IN%>
	    </b>
	 </div>
   </td>
    <td width="70" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="center" class="text04">
	    <b>
	      <%=Left(NEW_USER_NICKNAME,4)%>
	    </b>
	 </div>
   </td>   
   </a>
   <td width="40" >
   <div align="center" class="text04">
   <% IF WB > 0 THEN %>
   <b>위험</b>
   <% End IF %>
   </div>
   </td>
   <!--신규가입 시작-->
    <td width="45" bgcolor="000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">신규대기</b>
	  </div>
	</td>
	<a href="/EPCenter/02_Member/List.asp" target="ViewFrm">
    <td width="45" <% IF NEW_USER_NICKNAME1 <> "" Then %>bgcolor="FED457"<% Else %>bgcolor="ffffff"<% End IF %> style="cursor:hand;" >
	  <div align="center" class="text04">
	    <b>
	      <%=USER_IN1%>
	    </b>
	 </div>
   </td>
    <td width="70" bgcolor="ffffff" style="cursor:hand;" >
	  <div align="center" class="text04">
	    <b>
	      <%=Left(NEW_USER_NICKNAME1,4)%>
	    </b>
	 </div>
   </td>   
   </a>
   <td width="40" >
   <div align="center" class="text04">
   <% IF WB > 0 THEN %>
   <b>위험</b>
   <% End IF %>
   </div>
   </td>  
   <!--신규가입 끝-->
    <td width="45" bgcolor="000000">
	  <div align="center" class="text04">
	    <b style="color:#FFFFFF">정산자동</b>
	  </div>
	</td>
  <a href="/EPCenter/01_CP/Site_Setting.asp" target="ViewFrm">
   <td width="40" >
   <div align="center" class="text04">
   <% IF CAUTO > 0 THEN %>
   <b>YES</b>
   <% Else %>
   <b>NO</b>
   <% End IF %>
   </div>
   </td>  
  </a>
 </tr>
</table>
<% 
    '충전
	IF TINPUT > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
%>
<embed src='/midi/Charge.mid' hidden=true></embed>
<%
		End If 
	END If
%>
<% 
    '환전
	IF TOUTPUT > 0 THEN 
		If Request.Cookies("ins02") <> "no" Then
%>
<embed src='/midi/LogIn.mid' hidden=true>
<%
		End If 
	END If
%>
<% 
    '고객센터
	IF TMSG > 0 THEN 
		If Request.Cookies("ins01") <> "no" Then
%>
<embed src='/midi/cu.wav' volume=300 hidden=true>
<%
		End If 
	END If
	
	IF GAME_IN > 0 THEN 
		If Request.Cookies("ins03") <> "no" Then
%>
<!--<embed src='/midi/cu.wav' hidden=true volume=0>-->
<%
		End If 
	END If
		
   else
%>
<%end if%>

<% IF WB > 0 THEN %>
<embed src="/midi/toto.wav" volume=300 hidden=true>
<% END IF %>

