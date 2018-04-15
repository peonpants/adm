<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<html>
<head>
<title>새로운 7M 핸디/오버 게임등록</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<script type="text/javascript" id="jsLiveScore" src="Game_7mGetData_HO.js.asp?ver=<%= dfStringUtil.GetFullDate(now()) %>"></script>
<script type="text/javascript">
function BulidTable_live()
{	  
	if ( typeof(datas) != 'undefined' && datas != '' && ishide != 'true')
	{		
		datas = datas.replace("$$","$");
		data = datas.split('$');
		
	}
}
</script>
</head>

<body topmargin="0" marginheight="0">
<input type="button" value="   가져오기   " />
</body>

</html>