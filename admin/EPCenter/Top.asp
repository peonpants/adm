
<!-- #include virtual="/_Common/Inc/top.inc.asp" -->
<script language="javascript" src="Includes/common.js"></script>
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>

<table width="100%" border="0" cellpadding='0' cellspacing='0'>
<tr>
    <td colspan="3" height="25" bgcolor="737373">
    <img src="/img/top_logo.gif" />
    </td>
</tr>
  <tr>
    <td width="180" height="50" align="center">
        <table width="150" cellpadding=5 cellspacing=1 bgcolor="#000000">
        <tr>
            <td heigth="35" align="center" style="color:#FFF">
                <%IF request.Cookies("AdminLevel") = 1 THEN %> 마스터관리자 <% ELSE %> 리셀러 <% END IF %>                
            </td>
        </tr>
        </table>
    </td>
    <td>
    <table width="100" cellpadding=5 cellspacing=1 bgcolor="#000000">
        <tr>
            <td heigth="35" align="center" >
                <a href="/EPCenter/04_Game/List.asp" target="_blank" style="color:#FFF"><b>게임관리</b></a>
            </td>
        </tr>
        </table>
    </td>        
    <td id="Account2" name="Account2" valign="center" style="padding-left:10px;">
    </td>
  </tr>
</table>
<span id='alramMsg'></span>
<script type="text/javascript">
new Ajax.PeriodicalUpdater("Account2","/EPCenter/05_Account/topMenuInfo.asp",{frequency:10,decay:1})
</script>
<span id="cashSms">
</span>
<script type="text/javascript">
new Ajax.PeriodicalUpdater("cashSms","/EPCenter/05_Account/cashSms.asp",{frequency:120,decay:1})

</script>

<!--<script type="text/javascript">
new Ajax.PeriodicalUpdater("alramMsg","/EPCenter/alram.asp",{frequency:1200,decay:1})
</script>-->

<!-- #include virtual="/_Common/Inc/footer.inc.asp" -->
