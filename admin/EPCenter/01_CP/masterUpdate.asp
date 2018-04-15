<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
IA_ID = Trim(request("IA_ID"))

IF IA_ID = "" Then
%>
    <script type="text/javascript">
    alert("정상적인 접근 바랍니다.");
    </script>
<%    
    response.End
End IF

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 관리자 접속 로그 부름                    ################	
    Call dfCpSql.GetINFO_ADMIN(dfDBConn.Conn, IA_ID)

    IF dfCpSql.RsCount = 0 Then
%>
    <script type="text/javascript">
    alert("관리자 값이 설정되지 않았습니다.");
    </script>
<%    
        response.End
    End IF
    
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script>
	function chgAdminInfo1() 
	  {
		document.frm1.submit();
	  }
	
	function chgAdminInfo2() 
	  {
		document.frm2.submit();
	  }
	
	function chgAdminInfo3() 
	  {
		document.frm3.submit();
	  }
	
    function rand() 
      {
        var data=new Array('Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K',

                           'L','Z','X','C','V','B','N','M','?','1','2','3','4','5','6','7','8','9','0');

        form.code.value="";

        for (i=0 ;i < 6 ;i++)
          {

            form.code.value=form.txt.value + data[Math.floor(Math.random()*37)];

          }

      }
    function commit()
	  {
	    top.HiddenFrm.location.href="board_excel.asp"
	  }

</script></head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">관리자정보</font><font color="ffffff">&nbsp;&nbsp;▶  리셀러추가</font></td></tr></table><br>


<table>
  <tr>
    <td>
       
      <form name="frm1" method="post" action="Info_Proc.asp">
      <input type="hidden" name="type" value="modify">
      <input type="hidden" name="IA_LEVEL" value="<%=dfCpSql.RsOne("IA_LEVEL")%>">
      <input type="hidden" name="IA_GROUP" value="<%=dfCpSql.RsOne("IA_GROUP")%>">
      <input type="hidden" name="IA_GROUP1" value="<%=dfCpSql.RsOne("IA_GROUP1")%>">
      <input type="hidden" name="IA_GROUP2" value="<%=dfCpSql.RsOne("IA_GROUP2")%>">
      <input type="hidden" name="IA_GROUP3" value="<%=dfCpSql.RsOne("IA_GROUP3")%>">
      <input type="hidden" name="IA_GROUP4" value="<%=dfCpSql.RsOne("IA_GROUP4")%>">
      <table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="500">
        <tr>
		  <td colspan="2" height="30" align="center" bgcolor="706E6E"><font color="white"><b>마스터관리자</b></font></td>
		</tr>
        <tr>
		  <td colspan="2" height="30" align="left" bgcolor="red"><font color="white"><b>**정산방식은 수정이 불가하므로 새로생성해야 됩니다</BR>**수익정산은 상위 커미션률을 넘을수없으니 수정전에 반드시 확인하시기 바랍니다</BR></b></font></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>I D</b></td>
	      <td width="350"><input type="text" name="IA_ID" readonly value="<%=dfCpSql.RsOne("IA_ID")%>" style="width:200px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>Password</b></td>
	      <td>
		    <input type="password" name="IA_PW" value="<%=dfCpSql.RsOne("IA_PW")%>" style="width:200px;border:1px solid #cacaca;">
	      </td>
		</tr>
		<% IF request.Cookies("AdminLevel")  = 1 Then  %>
        <tr>
		  <td colspan="2" height="5">&nbsp;</td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>입금계좌</b></td>
	      <td>
		    <input type="text" name="IA_BankNum" value="<%=dfCpSql.RsOne("IA_BANKNUM")%>" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>입금은행</b></td>
	      <td>
		    <input type="text" name="IA_BankName" value="<%=dfCpSql.RsOne("IA_BANKNAME")%>" style="width:330px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>예 금 주</b></td>
	      <td>
		    <input type="text" name="IA_BankOwner" value="<%=dfCpSql.RsOne("IA_BANKOWNER")%>" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>사이트</b></td>
	      <td>
		    <input type="text" name="IA_Site"  value="<%=dfCpSql.RsOne("IA_SITE")%>" style="width:330px;border:1px solid #cacaca;" readonly>
		  </td>
		</tr>

		<% If dfCpSql.RsOne("IA_Type")=1 Then %>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>마일리지적립률</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" value="<%=dfCpSql.RsOne("IA_SportsPercent")%>" style="width:60px;border:1px solid #cacaca;">%
			<input type="hidden" name="IA_CASH" value="<%=dfCpSql.RsOne("IA_CASH")%>" style="width:330px;border:1px solid #cacaca;">
			<input type="hidden" name="IA_LivePercent" value="<%=dfCpSql.RsOne("IA_LivePercent")%>" style="width:130px;border:1px solid #cacaca;">
		  </td>
		</tr>
		<% ELSEIf dfCpSql.RsOne("IA_Type")=2 Then %>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>마일리지</b></td>
	      <td>
		    <input type="text" name="IA_CASH" value="<%=dfCpSql.RsOne("IA_CASH")%>" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>롤링스포츠적립률</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" value="<%=dfCpSql.RsOne("IA_SportsPercent")%>" style="width:60px;border:1px solid #cacaca;">%
		  </td>
		</tr>	
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>롤링실시간적립률</b></td>
	      <td>
		    <input type="text" name="IA_LivePercent" value="<%=dfCpSql.RsOne("IA_LivePercent")%>" style="width:60px;border:1px solid #cacaca;">%
		  </td>
		</tr>
		<% End If %>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>커미션 타입</b></td>
	      <td>

			<input type="text" name="IA_Type" value="<%=dfCpSql.RsOne("IA_Type")%>" style="width:330px;border:1px solid #cacaca;" readonly>
		  </td>
		</tr>	
		<% End IF %>				
	  </table>
	  <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
		  <td>
		    <img src="blank.gif" border="0" width="1" height="10">
	      </td>
		</tr>
        <tr>
		  <td align="right">
		    <input type="button" value=" 변 경 " onclick="chgAdminInfo1();" style="border:1 solid;">
		  </td>
		</tr>
      </table>
	  </form>
    </td>
	
  </tr>

 </table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>
		  </td>
		</TR>
      </table>
	  
    </td>
    </td>
  </tr>
</table>

</body>
</html>

