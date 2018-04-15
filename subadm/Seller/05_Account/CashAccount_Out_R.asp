<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<%
	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"

	JOBSITE = SESSION("rJOBSITE")

    SQLLIST = "select * from INFO_ADMIN WITH(NOLOCK) where IA_site = '"& JOBSITE &"' "
	SET RSLIST = DbCon.Execute(SQLLIST)

	IA_CASH = RSLIST("IA_CASH")
	IA_SITE = RSLIST("IA_SITE")
	IA_ID =  RSLIST("IA_ID")
	IA_TYPE =  RSLIST("IA_TYPE")
	IA_LEVEL =  RSLIST("IA_LEVEL")
	IA_GROUP =  RSLIST("IA_GROUP")
	IA_GROUP1 =  RSLIST("IA_GROUP1")
	IA_GROUP2 =  RSLIST("IA_GROUP2")
	IA_GROUP3 =  RSLIST("IA_GROUP3")
	IA_GROUP4 =  RSLIST("IA_GROUP4")
	IA_SportsPercent =  Cdbl(RSLIST("IA_SportsPercent"))
	LC_TCASH = 0

	RSLIST.Close
	Set RSLIST = Nothing

	If IA_TYPE = 1 And IA_GROUP=1 THEN

		SQLLIST1 = "select sum(lc_cash) from log_cashinout where lc_site = '"& JOBSITE &"' and lc_contents='머니충전' "
		SQLLIST1 = SQLLIST1 & "AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		SET RSLIST1 = DbCon.Execute(SQLLIST1)

		If IsNull(RSLIST1(0)) then
		Else
			LC_TCASH=Cdbl(RSLIST1(0))
		End If
		LC_TCASH = LC_TCASH*IA_SportsPercent*0.01
		IA_Cash = IA_Cash-LC_TCASH

		RSLIST1.Close
		Set RSLIST1 = Nothing
	ELSEIf IA_TYPE = 1 And IA_GROUP=2 And IA_LEVEL=2 Then


		SQLLIST1 = "select sum(lc_cash) from log_cashinout where lc_contents='머니충전'"
		SQLLIST1 = SQLLIST1 & " AND IA_GROUP=2 AND IA_GROUP1=" & IA_GROUP1
		SQLLIST1 = SQLLIST1 & " AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		SET RSLIST1 = DbCon.Execute(SQLLIST1)

		If IsNull(RSLIST1(0)) then
		Else
			LC_TCASH= LC_TCASH + Cdbl(RSLIST1(0))
		End If

		LC_TCASH = LC_TCASH*IA_SportsPercent*0.01
		IA_Cash = IA_Cash-LC_TCASH

		RSLIST1.Close
		Set RSLIST1 = Nothing
	End If
%>

<html>
<head>
<script type="text/javascript">
    String.prototype.setComma = function() {
        var temp_str = String(this);
        for (var i = 0, retValue = String(), stop = temp_str.length; i < stop; i++) retValue = ((i % 3) == 0) && i != 0 ? temp_str.charAt((stop - i) - 1) + "," + retValue : temp_str.charAt((stop - i) - 1) + retValue;
        return retValue;
    }

    function inputAmount() {
        var chargeMoney = document.frm1.IA_CASH.value.replace(/,/gi, ''); // 불러온 값중에서 컴마를 제거 
        var s = chargeMoney;

        if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
            chargeMoney.value = '';
            return;
        }

        else {
            document.frm1.IAC_CASH.value = s.setComma();
        } 
    }

    function AmountChk() {
        var frm = document.frm1;

        if (frm.IAC_CASH.value == "") {
            alert("신청금액을 입력해주세요.");
            frm.IC_Amount.focus();
            return;
        }

        if (parseInt(frm.IAC_CASH.value.replace(/,/gi, '')) < 10000) {
            alert("신청금액은 10,000원 이상 입력해주세요.");
            frm.IAC_CASH.value = "";
            frm.IAC_CASH.focus();
            return;
        }

        if ((parseFloat(frm.IAC_CASH.value.replace(/,/gi,'')) % 10000) != 0 )	{
        	alert("신청금액은 10,000원 단위로 할 수 있습니다. 확인후 다시 신청해주세요.");
        	frm.IAC_CASH.value="";
        	frm.IAC_CASH.focus();
        	return;	}


        if (!confirm("마일리지를 환전신청하시겠습니까?")) return;

        frm.action = "CashAccount_Out_PROC.asp";
        frm.submit();
    }

    function selAmount(vl) {
        var frm = document.frm1;
        frm.IA_CASH.value = vl;
    }
    
    function InputCheck_new(obj, vl)
    {
        var frm = document.frm1;
        
        if(frm.IAC_CASH.value == "" || parseInt(vl,10) == 0) frm.IAC_CASH.value = 0        
        frm.IAC_CASH.value = parseInt(frm.IAC_CASH.value,10) +parseInt(vl,10);    
    }

	function price_click(n) {
	var amt = 0;
	if(n==0){
		$('#IAC_CASH').val(fn_add_comma('0'));
	}else{
		if($('#IAC_CASH').val() != "") {
				amt = parseInt(fn_remove_comma($('#IA_CASH').val()));
			}
		amt += parseInt(fn_remove_comma(n));

		$('#IAC_CASH').val(fn_add_comma(amt));
	}
}

function bt(id,after)
{
document.getElementById(id).filters.blendTrans.stop();
document.getElementById(id).filters.blendTrans.Apply();
document.getElementById(id).src=after;
document.getElementById(id).filters.blendTrans.Play();
}
 
function show_layer(div_name){
 
	document.all.div_01.style.display="none";
	document.all.div_02.style.display="none";
 
	switch(div_name)
	{
		case '1':
		document.all.div_01.style.display="";
		break;
		case '2':
		document.all.div_02.style.display="";
		break;
	}
}
</script>
<title>▒ 관리자 ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/seller/Css/Style.css">
<script src="/Sc/Base.js"></script>
</head>

<body topmargin="0" marginheight="0">

<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23"><b><font color="FFFF00">마일리지 출금관리</font><font color="ffffff">&nbsp;&nbsp;▶</font></b></td></tr></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr>
  <td colspan="2" height="30" align="left" bgcolor="red"><font color="white"><b>
<% If IA_TYPE=1 Then %>
  **당일 누적 마일리지는 익일이 지나야 토탈 누적마일리지에 합산됩니다.(하부포함)</br>
  **마일리지 환전신청은 10,000원이상 10,000원단위로 신청가능합니다</br>
<% Else %>
  **마일리지 환전신청은 10,000원이상 10,000원단위로 신청가능합니다</br>
<% End If %>
  </b></font></td>
</tr>
<% If IA_TYPE=1 Then %>
<tr height="30" bgcolor="e7e7e7"> 

<td align="left">당일 누적 마일리지:<%=formatnumber(LC_TCASH,0)%>원</td>
</tr>
<% End If %>
<tr height="30" bgcolor="e7e7e7"> 
<td align="left">토탈 누적 마일리지:<%=formatnumber(IA_Cash,0)%>원</td>
</tr>
</table>
<form name="frm1" method="post" target="ProcFrm">
<input type="hidden" name="IA_ID" value="<%=IA_ID%>">
<input type="hidden" name="IA_Cash" value="<%=IA_Cash%>">
<input type="hidden" name="IA_SITE" value="<%=IA_SITE%>">
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr height="30" bgcolor="e7e7e7"> 
	<% If ia_cash < 10000 Then %>
	<td align="center"><b><font color="red"><%=formatnumber(IA_CASH,0)%></font>원의 마일리지가 존재합니다. 출금신청은 10,000원 이상 가능합니다</b></td>
	<% Else %>
	<td align="center"><b><font color="red"><%=formatnumber(IA_CASH,0)%></font>원의 마일리지가 존재합니다. 출금신청을 원하시면 아래 출금버튼을 눌러주세요<font color="red">(만원단위로신청가능)</font></b></td>
</tr>
<tr>
<TD ALIGN="CENTER"><INPUT name="IAC_CASH" class="price" id="IAC_CASH" style="border: 1px solid rgb(102, 102, 102); border-image: none; width: 10%; height: 22px; text-align: right; padding-right: 10px; font-size: 16px; margin-right: 10px;" onkeyup="amount_onkeyup()" type="text"  value=""><A type="button" href="javascript:AmountChk();" ><font color="red"><B>마일리지출금신청</B></font></A></TD>


</tr>

</table>
</FORM>
<% End IF%> 
<iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
</body>
</html>