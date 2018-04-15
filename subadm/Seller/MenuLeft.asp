<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp" --->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html;">
<link href="Includes/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="./css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->

<script language="javascript" src="Includes/common.js"></script>
<script>
	function logOut() {
		if (confirm("로그아웃 하시겠습니까?")) {
			top.location.href="/Login/LogOut.asp";
		}
	}
	
	function openAlarm() {
		var openUrl = "./05_Account/AccountAlarm.asp";
		window.open(openUrl,'alarm','width=300,height=50');
	}
	
	function dbInit() {
		if (confirm("리그정보를 제외한 모든 데이터가 삭제됩니다.\n정말 DB를 초기화 하시겠습니까?")) {
			top.HiddenFrm.location.href="DB_Init.asp";
		}
	}
</script></head>
<script language="JavaScript"> 

function showHide(objId)
{
    dis = document.getElementById(objID).style.display == "none" ? "block" : "none";
    document.getElementById(objID).style.display = dis
}
</script>
<script language="javascript" type="text/javascript" src="Includes/common.js"></script>
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>

<BODY style="padding:0px 1px 10px 0px;">
<div class="MenuLeft_MainDiv" style="height:100%;">
	<div class="MenuLeft_MainInnerDiv">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr><td height="500" align="center" valign="top" bgcolor="#ffffff" style="color:#000000; padding-left:0px;">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr><td height="10"><img src="img/icon_arrow.gif" width="8" height="8" align="absmiddle"> <a href="javaScript:menu1func()"style="color:#3b3b3b; font-weight: bolder; font-size:13px;">회원관리</a></td></tr>
			<tr><td height="1" bgcolor="dbdbdb"></td></tr>
			<tr><td class="left14 line18">
				<div id="menu1" style = display:block>

				<div class="panel-body-admin-body-Hber">
					<ul> 
						<li ><a href="./02_Member/List.asp" target="ViewFrm">회원정보</a></li>
						<li ><a href="./01_CP/Login_List.asp" target="ViewFrm">로그인정보</a></li>   
						<li ><a href="./04_Game1/Betting_List.asp" target="ViewFrm" >배팅리스트</a></li>
					</ul>
				</div>
				</div>
				</td>
			</tr>

			<tr><td height="10"><img src="img/icon_arrow.gif" width="8" height="8" align="absmiddle"> <a href="javaScript:menu3func()" style="color:#3b3b3b; font-weight: bolder; font-size:13px;">충전/환전관리</a></td></tr>
			<tr><td height="1" bgcolor="dbdbdb"></td></tr>
			<tr><td class="left14 line18">
				<div id="menu3" style = display:block>
				<!--<a href="/Seller/05_Account/Charge_List.asp" target="ViewFrm" style="color:#000000; ">- 충전관리</a><br>
				<a href="/Seller/05_Account/Exchange_List.asp" target="ViewFrm" style="color:#000000; ">- 환전관리</a><br>
				<a href="/Seller/05_Account/Money_Log.asp" target="ViewFrm" style="color:#000000; ">- 날짜별현황</a><br>
				<a href="/Seller/05_Account/CashAccountMonth.asp" target="ViewFrm" style="color:#000000; ">- 날짜별현황(new)</a><br>-->

				<div class="panel-body-admin-body-Hber">
					<ul> 

		<%
			SQLLIST2 = "select * from [SET_SUBEXCHANGE_USE]"
			SET RS2 = DBCON.EXECUTE(SQLLIST2)
			EXCHANGE_USE = RS2("EXCHANGE_USE")

			If EXCHANGE_USE = 1 THEN
		%>
				<li><a href="/Seller/05_Account/CashAccount_Out_R.asp" target="ViewFrm" >마일리지 환전신청</a><br>
		<%
			End IF
			SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
			SET RS2 = DBCON.EXECUTE(SQLLIST2)

			IA_LEVEL = RS2("IA_LEVEL")
			IA_GROUP = RS2("IA_GROUP")
			IA_Type = RS2("IA_Type")

			If IA_LEVEL = 2 Then
			level = "본사"
			elseIf IA_LEVEL = 3 Then
			level = "부본사"
			elseIf IA_LEVEL = 4 Then
			level = "총판"
			elseIf IA_LEVEL = 5 Then
			level = "매장"
			End If
			ia_page = ia_level - 2
			If ia_page = 0 Then
			ia_page = ""
			End if
			%>
				<li><a href="/Seller/01_CP/masterList<%=ia_page%>.asp?master_id=<%= Session("rJOBSITE") %>" target="ViewFrm">파트너관리</a></li>
				

			<% If ia_level < 5 Then %>
				<li><a href="/Seller/05_Account/Money_Addadmin_new.asp" target="ViewFrm">실시간정산관리</a></li>
					<ul>
						<li><a href="/Seller/05_Account/Money_Addadmin_Summ_Day.asp" target="ViewFrm"> &nbsp;&nbsp;&nbsp;- 일자별 통계</a></li>
						<li><a href="/Seller/05_Account/Money_Addadmin_Summ_Mon.asp" target="ViewFrm"> &nbsp;&nbsp;&nbsp;- 월별 통계</a></li>
					</ul>

			<% Else %>
				<li><a href="/Seller/05_Account/point_list.asp" target="ViewFrm">실시간정산관리</a></li>
			<% End If %>
				<li><a href="/Seller/05_Account/Money_Addadmin_charge.asp" target="ViewFrm" >충전 관리</a></li>
				<li><a href="/Seller/05_Account/Money_Addadmin_exchange.asp" target="ViewFrm">환전 관리</a></li>
				<li><a href="/Seller/05_Account/Money_Addadmin.asp" target="ViewFrm" >충전/환전 관리</a></li>
				</ul>
				</div>
				</div></td></tr>
			<tr><td height="1" bgcolor="dbdbdb"></td></tr>
			<tr>
						<td id="Account">        
						</td>
					</tr>  
			<tr><td height="19" align="right">
				<input type=button class="btn Hberbtn-line-bLUE" onclick="javaScript:logOut();" value="로그아웃">
			</td></tr>
		</table>
					
		</td></tr>
	</table>
		<script type="text/javascript">
		new Ajax.PeriodicalUpdater("Account","/Seller/05_Account/Money_Total_Mini.asp",{frequency:30,decay:1})
		</script>  
	</div>
	<div class="h_5"></div>
	<div class="MenuLeft_MainInnerDiv title-backgra" style="position:absolute; width:180px; bottom:10px;font-size:12px;text-align:center;">
		<%=Session("rJOBSITE")%>관리자모드
	</div>
</div>
</BODY>
</html>