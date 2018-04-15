<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/style.css">
<script language="javascript" src="/js/jquery-1.4.1.min.js"></script>
<script language="javascript" src="/js/func.js"></script>
<script language="javascript">
<!--
	function sel_league(lname, tob, numi)
	{
		if (lname == "")
			document.getElementById(tob).innerHTML = "<select name='RL_League_" + numi + "' style='width:190px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px'></select>";
		else
			$("div#" + tob).load("/EPCenter/11_Event/lotto/sel_league.asp?lname=" + escape(lname) + "&num=" + numi);
	}

	function checkValue(frm)
	{
		if (frm.IL_TITLE.value == "")
		{
			alert("제목을 입력해 주세요.");
			return false;
		}
		if (frm.IL_DATE.value == "")
		{
			alert("일정을 입력해 주세요.");
			return false;
		}
		if (frm.IL_DEFAULT_PRIZE_MONEY.value == "")
		{
			alert("기본 당첨 금액을 입력해 주세요.");
			return false;
		}
		if (!chkNumEngComma(frm.IL_DEFAULT_PRIZE_MONEY.value))
		{
			alert("기본 당첨 금액은 숫자를 입력해 주세요.");
			return false;
		}
		if (frm.IL_BASIC_BET_MONEY.value == "")
		{
			alert("기본 배팅 금액을 입력해 주세요.");
			return false;
		}
		if (!chkNumEngComma(frm.IL_BASIC_BET_MONEY.value))
		{
			alert("기본 배팅 금액은 숫자를 입력해 주세요.");
			return false;
		}
		if (parseInt(frm.IL_BASIC_BET_MONEY.value) <= 0)
		{
			alert("기본 배팅 금액이 너무 작습니다.");
			return false;
		}
		
		var emptyCnt = 0;
		var ea = parseInt(frm["input_ea"].value);
		for (var i = 0; i < ea; i++)
		{
			if (frm["ILG_STARTTIME_" + (i+1)].value == "" 
				&& frm["RL_Sports_" + (i+1)].value == "" 
				&& frm["RL_League_" + (i+1)].value == "" 
				&& frm["ILG_TYPE_" + (i+1)].value == "" 
				&& frm["ILG_TEAM1_" + (i+1)].value == "" 
				&& frm["ILG_TEAM2_" + (i+1)].value == "")
			{
				emptyCnt++;
			}
		}

		if (emptyCnt == ea)
		{
			alert("게임을 입력해 주세요.");
			return false;
		}

		for (var i = 0; i < ea; i++)
		{
			if (frm["ILG_HANDICAP_" + (i+1)].value == "")
			{
				alert("무승부/핸디캡/합산점수 값을 입력해 주세요.\n\n승무패의 경우 무승부를 비활성화 하려면 0을\n활성화 하려면 0보다 큰 값을 입력해 주세요.");
				return false;
				break;
			}
		}

		return true;
	}

	function get_ea(v)	
    {
	    var cnt = parseInt(v);
		for (var i = 1; i <= 10; i++)
		{
			if (i <= cnt)
				document.getElementById("tr" + i.toString()).style.display = "block";
			else
				document.getElementById("tr" + i.toString()).style.display = "none";
		}
    }
//-->
</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 로또 이벤트 등록</b></td>
</tr>
</table>

<form name="frmInput" method="post" action="Regist_Proc.asp" onsubmit="return checkValue(this);">
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<%
	SQLMSG = "SELECT ISNULL(MAX(IL_NUM), 0) AS IL_NUM FROM dbo.INFO_LOTTO WITH(NOLOCK)"
	SET RS = DbCon.Execute(SQLMSG)
	IL_NUM = RS("IL_NUM")
	RS.Close
	Set RS = Nothing
%>
<tr><td width="200" bgcolor="e7e7e7" align="center">&nbsp;<b>최근 로또 차수</b></td>
	<td width="500"><%If IL_NUM = 0 Then %>없음<%Else%><%=IL_NUM%><%End If%></td></tr>
<tr><td width="200" bgcolor="e7e7e7" align="center">&nbsp;<b>제 목</b></td>
	<td width="500"><input type="text" name="IL_TITLE" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>일 정</b></td>
	<td><input type="text" name="IL_DATE" value="" style="border:1px solid #cacaca;"> <input type="button" value="<%= dfStringUtil.GetStartDate(now()) %>" onclick="frmInput.IL_DATE.value=this.value;" class="input" style="width:120px;" /></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>기본 당첨 금액</b></td>
	<td><input type="text" name="IL_DEFAULT_PRIZE_MONEY" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>기본 배팅 금액</b></td>
	<td><input type="text" name="IL_BASIC_BET_MONEY" value="" style="border:1px solid #cacaca;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center">&nbsp;<b>활성 상태</b></td>
	<td><select name="IL_ENABLE" style="width:80px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"><option value="0">비활성</option><option value="1">활성</option></select> </td></tr>
	</table>

<div style="height:10px;"></div>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 로또 게임 등록</b></td>
</tr>
</table>

<table width="1070">
<tr>    
	<td align="right">
	    등록 게임 리스트 수
		<select name="input_ea" onchange="get_ea(this.value)">
			<option value="1" selected>1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
		</select>
	</td>
  </tr>
</table>

<table width="1070">
	<tr><td><font color="red">게임구분이 승무패일 경우 "무/핸/합"의 값에 0보다 큰 값을 입력하면 무승부를 선택할 수 있게 설정됩니다.(0인 경우는 승과 패만 선택 가능)</font></td></tr>
</table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td width="250" bgcolor="e7e7e7" align="center"><b>게임일시</b></td>
	<td width="130" bgcolor="e7e7e7" align="center"><b>종목선택</b></td>
	<td width="200" bgcolor="e7e7e7" align="center"><b>리그선택</b></td>
	<td width="90" bgcolor="e7e7e7" align="center"><b>게임구분</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>홈팀명</b></td>
	<td width="150" bgcolor="e7e7e7" align="center"><b>원정팀명</b></td>
	<td width="55" bgcolor="e7e7e7" align="center"><b>무/핸/합</b></td>
</tr>

<%
	For i = 1 To 10
%>

<tr id="tr<%=i%>" style="display:<%If i = 1 Then%>block;<%Else%>none;<%End If%>"><td><input type="text" name="ILG_STARTTIME_<%=i%>" class="input" /> <input type="button" value="<%= dfStringUtil.GetStartDate(now()) %>" onclick="frmInput.ILG_STARTTIME_<%=i%>.value=this.value;" class="input" style="width:120px;" /></td>
	<td>
		<select name="RL_Sports_<%=i%>" style="width:120px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="javascript:sel_league(this.value, 'divLeague<%=i%>', '<%=i%>');">
			<option value=""></option>
<%
	SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	RSCount = RS.RecordCount

	FOR a =1 TO RSCount
		
		RLS = RS(0)
%>
			<option value="<%=RLS%>"><%=RLS%></option>
<%
		RS.movenext
	NEXT
		
	RS.Close
	Set RS=Nothing
%>
		</select>
	</td>
	<td><div id="divLeague<%=i%>"><select name="RL_League_<%=i%>" style="width:190px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"></div></td>
	<td><select name="ILG_TYPE_<%=i%>" style="width:80px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px"><option value=""></option><option value="0">승무패</option><option value="1">핸디캡</option><option value="2">언더오버</option></select></td>
	<td><input type="text" name="ILG_TEAM1_<%=i%>" value="" style="width:145px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="ILG_TEAM2_<%=i%>" value="" style="width:145px;border:1px solid #cacaca;"></td>
	<td><input type="text" name="ILG_HANDICAP_<%=i%>" value="" style="width:60px;border:1px solid #cacaca;"></td>
</tr>

<%
	Next
%>

</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr>
<tr><td width="700"><input type="submit" value=" 등 록 " style="border:1 solid;"> <input type="button" value=" 취 소 "  onclick="history.back(-1);" style="border:1 solid;"></td></tr></table>
</form>	



</body>
</html>