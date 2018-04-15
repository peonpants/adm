<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    
    IGI_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGI_IDX")), 1, 1, 999999) 
	IGID_INNING            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGID_INNING")), 1, 1, 10) 
	IGI_RESULT            = Trim(dfRequest.Value("IGI_RESULT")) 
%>	
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

</head>
<body>
<script type="text/javascript">
function checkAddForm(form)
{
    if(form.IGID_SCORE1.value == "")
    {
        alert("스코어를 입력하세요");
        return false;
    }
    if(form.IGID_SCORE2.value == "")
    {
        alert("스코어를 입력하세요");
        return false;    
    }    
}
</script>
<form name="addForm" method="post" action="updateInning_proc.asp" onsubmit="return checkAddForm(this);">
<input type="hidden" name="IGID_INNING" value="<%= IGID_INNING %>" />
<input type="hidden" name="IGI_IDX" value="<%= IGI_IDX %>" />
<input type="hidden" name="IGI_RESULT" value="<%= IGI_RESULT %>" />
<%= IGID_INNING %>이닝 결과 등록
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE" width="150">홈팀</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGID_SCORE1" class="input_box1" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">원정팀</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGID_SCORE2" class="input_box1" />
    </td>
</tr>
<tr>
    <td bgcolor="#FFFFFF" colspan="2" align="center">
          <input type="submit" value="            등록                  "  class="input2" />
    </td>
</tr>
</table>
</form>
</body>
</html>