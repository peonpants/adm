<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->

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
	<b><font color="FFFF00">관리자정보</font><font color="ffffff">&nbsp;&nbsp;▶  리셀러추가</font></td></tr>
</table><br>


<table>
  <tr>
    <td>
       
      <form name="frm1" method="post" action="Info_Proc.asp">
    <!--  <input type="hidden" name="IA_Level" value="<%= request.Cookies("AdminLevel")+1 %>">     --> 
      <input type="hidden" name="type" value="add">
	  <input type="hidden" name="IA_CalMethod" value=1>
	  <input type="hidden" name="IA_Percent" value=100>
	  <input type="hidden" name="IA_GROUP2" value="0">
	  <input type="hidden" name="IA_GROUP3" value="0">
	  <input type="hidden" name="IA_GROUP4" value="0">
      <table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="500">
        <tr>
		  <td colspan="2" height="30" align="center" bgcolor="706E6E"><font color="white"><b>리셀러</b></font></td>
		</tr>
        <tr>
		  <td colspan="2" height="30" align="left" bgcolor="red"><font color="white"><b>**수익정산으로 생성시 실시간 마일리지는 0으로 설정해야 됩니다(스포츠 마일리지에 정산프로테이지를 입력)</br>**운영본사/본사/부본사/총판/매장 단계로 운영본사는 센터를 의미합니다.</br>**운영본사의 하부총판은 본사그룹의 0으로 설정, 본사/부본사/총판/매장그룹은 1부터 설정(그룹이 겹치기 않게 주의)</b></font></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>I D</b></td>
	      <td width="350"><input type="text" name="IA_ID" value="" style="width:200px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>Password</b></td>
	      <td>
		    <input type="password" name="IA_PW" value="" style="width:200px;border:1px solid #cacaca;">
	      </td>
		</tr>
        <tr>
		  <td colspan="2" height="5">&nbsp;</td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>입금계좌</b></td>
	      <td>
		    <input type="text" name="IA_BankNum" value="" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>입금은행</b></td>
	      <td>
		    <input type="text" name="IA_BankName" value="" style="width:330px;border:1px solid #cacaca;"></td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>예 금 주</b></td>
	      <td>
		    <input type="text" name="IA_BankOwner" value="" style="width:330px;border:1px solid #cacaca;">
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>총판코드</b></td>
	      <td>
		    <input type="text" name="IA_Site" value="" style="width:330px;border:1px solid #cacaca;">
			총판의 고유코드로 사이트설정에서 수정이 가능합니다
		  </td>
		</tr>		
		<tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>어드민레벨</b></td>
	      <td>
		    <input type="text" name="IA_Level" style="width:330px;border:1px solid #cacaca;" value="4">
			운영본사1, 본사2, 부본사3, 총판4, 매장5를 입력(기본값 총판)
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>총판/본사그룹구분</b></td>
	      <td>
		    <input type="text" name="IA_GROUP" style="width:330px;border:1px solid #cacaca;" value=1>
		    운영본사 하부총판은 1번, 운영본사 하부 본사는 2번을 입력
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>본사그룹</b></td>
	      <td>
		    <input type="text" name="IA_GROUP1" style="width:330px;border:1px solid #cacaca;" value=0>
		    운영본사 하부 본사일시 그룹을 설정합니다 1번부터 가능/운영본사 하부총판은 0을 입력
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>스포츠마일리지</b></td>
	      <td>
		    <input type="text" name="IA_SportsPercent" value="0" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0이상 100이하로 입력하세요(소수점포함)</br>수익정산인경우 스포츠에 마일리지입력, 실시간마일리지는 0으로 입력
		  </td>
		</tr>
		<tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>실시간마일리지</b></td>
	      <td>
		    <input type="text" name="IA_LivePercent" value="0" style="width:330px;border:1px solid #cacaca;" value="0">
		    </br>0이상 100이하로 입력하세요(소수점포함)</br>수익정산인경우 스포츠에 마일리지입력, 실시간마일리지는 0으로 입력
		  </td>
		</tr>
        <tr>
		  <td align="center" width="150" bgcolor="e7e7e7"><b>마일리지 타입</b></td>
	      <td>
		    <select name="IA_type">
		        <option value=1>수익정산(입금-출금)</option>
		        <option value=2>롤링정산(배팅 금액)</option>
		    </select>
		  </td>
		</tr>					
	  </table>
	  <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
		  <td>
		    <img src="blank.gif" border="0" width="1" height="10">
	      </td>
		</tr>
        <tr>
		  <td align="right">
		    <input type="button" value="  리셀러추가  " style="border:1 solid;" onclick="chgAdminInfo1();" />
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

