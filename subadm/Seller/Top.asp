<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Inc/top.inc.asp" -->
<link rel="stylesheet" href="./css/HberAdmin_Style.css" type="text/css" />			<!-- 운영자메뉴 스타일 테마  ----------------->

<script language="javascript" src="Includes/common.js"></script>
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>

<body style="background-color:#8c8f91">
<table width="100%" border="0" cellpadding='0' cellspacing='0' class="boxsh612">
<tr>
    <td style="height:2px; background-color:#aaaaaa">
    </td>
</tr>
<tr>
    <td style="height:1px; background-color:#666666">
    </td>
</tr>
  <tr>
    <td  height="40" align="left" class="padding-5 title-backgra-inver" style="background-color:#999999;">
		<div class="radi5p divinline-block" style="width:180px; height:16px; text-align:center; padding:10px;background-color:#000000; font-weight:bold; color:#cec; font-size:14px;"> ADMIN -
		<%
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
			End if
		%>
			<%= level %>
		</div>
		<div class="divinline-block">
			<span id="cashSms">
			   <%= now() %>
			</span>
			<script type="text/javascript">
			new Ajax.PeriodicalUpdater("cashSms","/Seller/now.asp",{frequency:5,decay:1})
			</script>   
		</div>
    </td>
  </tr>
</table>
<!-- #include virtual="/_Common/Inc/footer.inc.asp" -->
