<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ���� �� �θ�                    ################	
    Call dfCpSql.RetrieveSet_Betting(dfDBConn.Conn)
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script src="/Sc/Base.js"></script>
<script language="javascript">

function selftest() {

	if (document.SBGame.New_SB_Site.value == "") { alert("\n ����Ͻ� ����Ʈ���� �Է��ϼ���. \n"); document.SBGame.New_SB_Site.focus(); return false; }
	if (document.SBGame.New_SB_BettingMin.value == "") { alert("\n��ȸ �ּ� ���þ��� �Է��ϼ���. \n"); document.SBGame.New_SB_BettingMin.focus(); return false; }
	if (document.SBGame.New_SB_BettingMax01.value == "") { alert("\n ��ȸ �ִ� ���þ�(������)�� �Է��ϼ���. \n"); document.SBGame.New_SB_BettingMax01.focus(); return false; }
	if (document.SBGame.New_SB_BenefitMax01.value == "") { alert("\n ��ȸ ���߷� ���Ѱ�(������)�� �Է��ϼ���. \n"); document.SBGame.New_SB_BenefitMax01.focus(); return false; }
	if (document.SBGame.New_SB_BettingMax02.value == "") { alert("\n ��ȸ �ִ� ���þ�(�ڵ�/����)�� �Է��ϼ���. \n"); document.SBGame.New_SB_BettingMax02.focus(); return false; }
	if (document.SBGame.New_SB_BenefitMax02.value == "") { alert("\n ��ȸ ���߷� ���Ѱ�(�ڵ�/����)�� �Է��ϼ���. \n"); document.SBGame.New_SB_BenefitMax02.focus(); return false; }

	return true
 }

 function selftest_m() {
<%
	FOR i = 1 TO ListCount
%>
	if (document.SBGame_m.SB_SITE_<%=i%>.value == "") { alert("\n ����Ͻ� ����Ʈ���� �Է��ϼ���. \n"); document.SBGame_m.SB_SITE_<%=i%>.focus(); return false; }
	if (document.SBGame_m.SB_BETTINGMIN_<%=i%>.value == "") { alert("\n��ȸ �ּ� ���þ��� �Է��ϼ���. \n"); document.SBGame_m.SB_BETTINGMIN_<%=i%>.focus(); return false; }
	if (document.SBGame_m.SB_BETTINGMAX01_<%=i%>.value == "") { alert("\n ��ȸ �ִ� ���þ�(������)�� �Է��ϼ���. \n"); document.SBGame_m.SB_BETTINGMAX01_<%=i%>.focus(); return false; }
	if (document.SBGame_m.SB_BENEFITMAX01_<%=i%>.value == "") { alert("\n ��ȸ ���߷� ���Ѱ�(������)�� �Է��ϼ���. \n"); document.SBGame_m.SB_BENEFITMAX01_<%=i%>.focus(); return false; }
	if (document.SBGame_m.SB_BETTINGMAX02_<%=i%>.value == "") { alert("\n ��ȸ �ִ� ���þ�(�ڵ�/����)�� �Է��ϼ���. \n"); document.SBGame_m.SB_BETTINGMAX02_<%=i%>.focus(); return false; }
	if (document.SBGame_m.SB_BENEFITMAX02_<%=i%>.value == "") { alert("\n ��ȸ ���߷� ���Ѱ�(�ڵ�/����)�� �Է��ϼ���. \n"); document.SBGame_m.SB_BENEFITMAX02_<%=i%>.focus(); return false; }
<%
	NEXT
%>
	return true
 }


function go_delete(IDX) {
	if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;
	location.href = "Setting_proc.asp?EMODE=SB_DELETE&SB_IDX="+IDX;
}

</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �����ѵ� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<form name="SBGame_m" method="post" action="Setting_Proc.asp" onsubmit="return selftest_m()">
<input type="hidden" name="EMODE" value="SB_MODIFY">
<input type="hidden" name="SBCount" value="<%=dfCpSql.RsCount -1 %>">
<tr><td width="100" bgcolor="e7e7e7" align="center"><b>����Ʈ��</b></td>
	<td width="130" bgcolor="e7e7e7" align="center"><b>��ȸ �ּ� ���þ�</b></td>
	<td width="160" bgcolor="e7e7e7" align="center"><b>��ȸ �ִ� ���þ�(������)</b></td>
	<td width="160" bgcolor="e7e7e7" align="center"><b>��ȸ ��� ���Ѱ�(������)</b></td>
	<td width="185" bgcolor="e7e7e7" align="center"><b>��ȸ �ִ� ���þ�(�ڵ�/����)</b></td>
	<td width="185" bgcolor="e7e7e7" align="center"><b>��ȸ ��� ���Ѱ�(�ڵ�/����)</b></td>
	<td width="20" bgcolor="e7e7e7" align="center">&nbsp;</td></tr>

<%	IF dfCpSql.RsCount = 0 THEN %>

<tr height="40"><td align="center" colspan="7"><b>��ϵ� ���Ӽ��� ������ �����ϴ�.</b></td></tr>

<%	ELSE
	    FOR i = 0 TO dfCpSql.RsCount - 1

	        SB_IDX = dfCpSql.Rs(i,"SB_IDX")
	        SB_SITE = dfCpSql.Rs(i,"SB_SITE")
	        SB_BETTINGMIN = dfCpSql.Rs(i,"SB_BETTINGMIN")
	        SB_BETTINGMAX01 = dfCpSql.Rs(i,"SB_BETTINGMAX01")
	        SB_BENEFITMAX01 = dfCpSql.Rs(i,"SB_BENEFITMAX01")
	        SB_BETTINGMAX02 = dfCpSql.Rs(i,"SB_BETTINGMAX02")
	        SB_BENEFITMAX02 = dfCpSql.Rs(i,"SB_BENEFITMAX02")		
%>

<tr><td><input type="text" name="SB_SITE_<%=i%>" value="<%=SB_SITE%>" style="width:100px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SB_BETTINGMIN_<%=i%>" value="<%=SB_BETTINGMIN%>" style="width:130px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SB_BETTINGMAX01_<%=i%>" value="<%=SB_BETTINGMAX01%>" style="width:160px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SB_BENEFITMAX01_<%=i%>" value="<%=SB_BENEFITMAX01%>" style="width:160px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SB_BETTINGMAX02_<%=i%>" value="<%=SB_BETTINGMAX02%>" style="width:185px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="SB_BENEFITMAX02_<%=i%>" value="<%=SB_BENEFITMAX02%>" style="width:185px;border:1px solid #cacaca;"></td>
	<td><input type="reset" value=" ���� " onclick="javascript:go_delete('<%=SB_IDX%>');" style="border: 1 solid; background-color: #C5BEBD;" id=reset1 name=reset1></td>
	<input type="hidden" name="SB_IDX_<%=i%>" value="<%=SB_IDX%>"></tr>

<%	
	    NEXT	
	END IF
%>
</table>
<table width="998" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="5"></td></tr>
<tr><td width="998" align="right">
	<input type="submit" value=" �� �� " style="border:1 solid;"></td></tr>
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table></form>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �����ѵ� ���</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<form name="SBGame" method="post" action="Setting_Proc.asp" onsubmit="return selftest()">
<input type="hidden" name="EMODE" value="SB_ADD">
<tr><td width="300" bgcolor="e7e7e7">&nbsp;<b>1. ����Ʈ��</b></td>
	<td width="400" align="center"><input type="text" name="New_SB_Site" value="" style="width:395px;border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>2. ��ȸ �ּ� ���þ� ����</b></td>
	<td align="center"><input type="text" name="New_SB_BettingMin" value="" style="width:380px;border:1px solid #cacaca;text-align:right;"> ��</td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>3. ��ȸ �ִ� ���þ� ����(������)</b></td>
	<td align="center"><input type="text" name="New_SB_BettingMax01" value="" style="width:380px;border:1px solid #cacaca;text-align:right;"> ��</td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>4. ��ȸ ���߷� ���Ѱ�(������)</b></td>
	<td align="center"><input type="text" name="New_SB_BenefitMax01" value="" style="width:380px;border:1px solid #cacaca;text-align:right;"> ��</td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>3. ��ȸ �ִ� ���þ� ����(�ڵ�/����)</b></td>
	<td align="center"><input type="text" name="New_SB_BettingMax02" value="" style="width:380px;border:1px solid #cacaca;text-align:right;"> ��</td></tr>
<tr><td bgcolor="e7e7e7">&nbsp;<b>4. ��ȸ ���߷� ���Ѱ�(�ڵ�/����)</b></td>
	<td align="center"><input type="text" name="New_SB_BenefitMax02" value="" style="width:380px;border:1px solid #cacaca;text-align:right;"> ��</td></tr></table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td width="700" align="right"><input type="submit" value=" �� �� " style="border:1 solid;"></td></tr></table></form>	

</body>
</html>