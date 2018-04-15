<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- # include virtual="/_Global/AdminChk.asp" --->



<HEAD><TITLE>대한민국 최고의 배팅 사이트</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">
<LINK href="/style/style.css" type=text/css rel=stylesheet>
<SCRIPT src="/js/func.js" type=text/javascript></SCRIPT>
<SCRIPT src="/js/calendar.js" type=text/javascript></SCRIPT>
<META content="MSHTML 6.00.6000.16757" name=GENERATOR>
<script language="JavaScript" src="/Sc/Function.js"></script>
<script>
  function FrmChk1() 
    {
	  var frm = document.frm1;
		
	  // id중복체크
	    if (frm.ChkID.value != 1) 
	      {
		    alert(" 아이디 중복체크를 해주세요.");
			frm.IU_ID.focus();
			return false;
		  }
		//ID중복체크하는 페이지		
		frm.action = "01_tempMember_Proc.asp";
		return true;
	}
	
  function idDblChk() 
    {
	  var frm = document.frm1;
		
	    if (frm.IU_ID.value == "" ) 
		  {
		    alert("중복체크하실 아이디를 적어주세요.");
			frm.IU_ID.focus();
			return false;
		  }
		else
		  {
		    top.hidden_page.location.href="01_tempMember_Check.asp?IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";
		  }
	}

  function setUniqCode()
	{
	  var frm = document.frm1;
		
	    if (frm.IU_ID.value == "" ) 
		  {
		    alert("중복체크하실 아이디를 적어주세요.");
			frm.IU_ID.focus();
			return false;
		  }
		else
		  {
		    if(frm.ChkID.value != "1")
			  {
			    //alert("중복체크 후 사용가능합니다.");
				//return false;
			  }
			top.hidden_page.location.href="01_tempMember_Proc.asp?mode=uniqCode&IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";
		  }
	}
  
  function reset()
	{
	  var frm = document.frm1;
	  
	  frm.Joinsite.value == "";
	  frm.IU_ID.value == "";
      frm.IU_CODE.value == "";
	  return true;
	}
	
</script>
</HEAD>

<BODY bgColor=#ffffff leftMargin=0 topMargin=0>

<table width="760" border="0" cellspacing="0" cellpadding="0">
  <form name="frm1" method="post" onsubmit="return FrmChk1();" target="hidden_page">
  <input type="hidden" name="mode" value="addUniqCode">
  <input type="hidden" name="ChkID" value="0">
  <input type="hidden" name="ChkNN" value="0">
  <tr>
  <td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
	<table width="746" border=0 cellSpacing=1>
      <tr>
	    <td height="25" align=left bgColor=#B9B9B9 style="PADDING-RIGHT: 20px; PADDING-LEFT: 20px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" class="text11">
		  <STRONG class="text12"><FONT COLOR="#FFFFFF">◎ 추천인 아이디 생성</FONT></STRONG>
		</td>
      </tr>
	  <tr>
	    <td align=left style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
		  <table width="100%" border="2" cellpadding="0" cellspacing="0" bordercolor="#E1E1E1">
		    <tr>
			  <td height="25" align=center bgColor=#ffffff style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px">
			    <table width="81%" border="0" cellspacing="2" cellpadding="5">
                  <tr>
				    <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>사 이 트 명</strong>
				    </td>
				    <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				      <select name="JoinSite">
				      <% 
					    'PML변수에 레코드셋 저장
					    Set PML = Server.CreateObject("ADODB.Recordset")
					    PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1
                         'PMLC에 레코드셋의 개수를 저장
					    PMLC = PML.RecordCount
				         'PMLC 레코드셋의 개수가 하나라도 있다면
					    IF PMLC > 0 THEN
                          '1부터 레코드셋의 개수까지 FOR문으로 돌림
					      FOR PM = 1 TO PMLC
				         '레코드셋이 마지막이면 FOR문을 빠져나옴
					    IF PML.EOF THEN
						EXIT FOR
					    END IF
                        'SITE01부터 첫번째 레코드셋을 저장함
					    SITE01=PML(0) 
					  %>
				        <option value="<%=SITE01%>"><%=SITE01%></option>
				        <%PML.Movenext
					      Next
					      END IF 
					    %>
					  </select>
				      <!--<input type="radio" name="JoinSite" value="Eproto" Checked> 이프로토 <input type="radio" name="JoinSite" value="Pluswin"> 플러스윈-->
					</td>
			      </tr>			
			      <tr>
				    <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04">
				      <strong>회원 아이디</strong>
					</td>
				    <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				      <input name="IU_ID" style="WIDTH: 150px; HEIGHT: 20px" maxLength="12" class="box2">&nbsp;
					  <IMG onclick="idDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>&nbsp;영문,숫자 4~12자 (특수문자불가)
					</td>
			      </tr>
			      <tr>
				    <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>유니크 코드</strong>
			      </td>
				  <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				    <input name="IU_CODE" style="WIDTH: 300px; HEIGHT: 20px" class="box2" readonly>
				    <input type="button" style="color:000000;" value="유니크 코드 생성" onclick="setUniqCode();">
				  </td>
				</tr>	
			    <tr>
				  <td width="24%" align="center" valign="middle" bgcolor="#DFDFDF" class="text04"><strong>회원가입 URL</strong>
				  </td>
				  <td width="76%" align="left" valign="bottom" bgcolor="#EAEAEA">
				    <div id="returnURL" style="color:#000000;"></div>
				  </td>
				</tr>		
			   <tr>
			   <td colspan=2 align=center>
			     <input type="image" src="/images/btn_enter.gif" border="0">
		         <img src="/images/btn_can.gif" border=0 onclick = "reset();">				
			   </td>
			 </tr>
		   </table>
		 </td>
	   </tr>
	 </table>
   </td>
 </tr>
				
		</td></form></tr></table></td></tr>
<tr><td align="center" valign="top" bgcolor="#EAEAEA" class="text04" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px"></td></tr>

</table>

<iframe name="hidden_page" src="" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" style="display:';"></iframe>

</BODY>
</HTML>