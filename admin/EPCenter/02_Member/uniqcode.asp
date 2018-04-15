<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<html>
<HEAD>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript">

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
		//main.asp페이지의 HiddenFrm 프레임에 아래의 url링크 호출
	    hidden_page.location.href="01_tempMember_Check.asp?IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";
    }
}
function rand() 
{
    var data=new Array('1','2','3','4','5','6','7','8','9','0');
    frm1.iu_code.value="";

    for (i=0 ;i < 6 ;i++)
    {
        frm1.iu_code.value=frm1.iu_code.value + data[Math.floor(Math.random()*10)];
    }
}
function commit()
{
    var frm = document.frm1;

    if (frm.ChkID.value != 1) {
        alert(" 아이디 중복체크를 해주세요.");
        frm.IU_ID.focus();
        return false;
    }

    if (frm.iu_code.value == "")
    {
        alert("유니크 코드를 생성해주세요");
        frm.iu_code.focus();
        return false;
    }
    else 
    {  
        hidden_page.location.href="01_tempMember_Proc.asp?IU_CODE="+frm.iu_code.value+"&IU_ID="+frm.IU_ID.value+"&IU_SITE="+frm.JoinSite.value+"";   
    }
}    

</script>

</HEAD>

 

<BODY leftMargin=0 topMargin=0>
<iframe name="hidden_page" width=0 height=0></iframe>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 회원관리 - 추천장 관리</b></td>
</tr>
</table>    


<FORM name=frm1 onsubmit="return FrmChk1();" method=post target="hidden_page">
<INPUT type=hidden value=0 name=ChkID> 

<table width="81%" border="0" cellspacing="1" cellpadding="5" bgcolor="#AAAAAA">
  <tr>
    <td width="24%" align="center" valign="middle" bgcolor="#eeeeee" class="text04"><strong>사 이 트 명</strong>
    </td>
    <td width="76%" align="left" valign="bottom" bgcolor="#ffffff">
      <select name="JoinSite">
      <% 
	    Set PML = Server.CreateObject("ADODB.Recordset")
	    PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

	    PMLC = PML.RecordCount         	    
	    IF PMLC > 0 THEN                   	      
	      FOR PM = 1 TO PMLC         	    
	        IF PML.EOF THEN
		        EXIT FOR
	        END IF        
	        SITE01=PML(0) 
	  %>
        <option value="<%=SITE01%>"><%=SITE01%></option>
        <%
            PML.Movenext
	        Next
	      END IF 
	    %>
	  </select>
     </td>
  </tr>			
  <tr>
    <td width="24%" align="center" valign="middle" bgcolor="#eeeeee" class="text04">
      <strong>회원 아이디</strong>
	</td>
    <td width="76%" align="left" valign="bottom" bgcolor="#ffffff">
      <input name="IU_ID" class="input" maxLength="12" class="box2">&nbsp;
	  <IMG onclick="idDblChk();" height=19 src="/images/btn_idcheck.gif" width=65 align=absMiddle border=0>
	</td>
  </tr>
  <tr>
    <td width="24%" align="center" valign="middle" bgcolor="#eeeeee" class="text04"><strong>유니크 코드</strong>
    </td>
    <td width="76%" align="left" valign="bottom" bgcolor="#ffffff">
      <input type="text" name="iu_code" class="input"><br>
      <input type="button" style="color:000000;" value="유니크 코드 생성" onclick="rand();">
    </td>
  </tr>  
  <tr>
    <td colspan=2 align=center bgcolor="#FFFFFF">
      <img src="/images/btn_enter.gif" border="0" onclick = "commit();">
      <img src="/images/btn_can.gif" border=0 onclick = "reset();">				
    </td>
  </tr>
</table>
</form>

<table width="500" bgcolor="#AAAAAA" cellpadding="2" cellspacing="1">
<tr bgcolor="#EEEEEE">
    <td>아이디</td>
    <td>닉네임</td>
    <td>코드</td>
</tr>
  <% 
    Set PML = Server.CreateObject("ADODB.Recordset")
    PML.Open "SELECT INFO_USER_CODE.IU_ID, IU_CODE, INFO_USER.IU_NICKNAME FROM INFO_USER_CODE left outer join info_user on INFO_USER_CODE.IU_ID = INFO_USER.IU_ID order by info_user_code.iu_id,IU_CODE asc", dbCon, 1

    PMLC = PML.RecordCount         	    
    IF PMLC > 0 THEN                   	      
      FOR PM = 1 TO PMLC         	    
        IF PML.EOF THEN
	        EXIT FOR
        END IF        

%>
<tr bgcolor="#FFFFFF">
    <td><%= PML(0) %></td>
    <td><%= PML(2) %></td>
    <td><%= PML(1) %></td>
</tr>
<%
        PML.Movenext
        Next
      END IF 
%>

</table>
</BODY>
</HTML>
