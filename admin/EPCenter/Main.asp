<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->

<html>
<head>
    <title>관리자</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <link rel="stylesheet" type="text/css" href="/EPCenter/css/style.css">
</head>
<frameset rows="60,*,0,0" frameborder="NO" border="0">
	<frame src="/epcenter/04_game/warninggame.asp" noresize marginwidth="0" marginheight="0">
		<frameset rows="90,*,0,0" frameborder="NO" border="0" >
			<frame src="Top.asp?tabM=<%= tabM %>" name="TopFrm" scrolling="auto" noresize marginwidth="0"  marginheight="0">
			<frameset cols="200,*" frameborder="NO" border="0" id="mainFrameSet">
				<frame src="MenuLeft.asp" name="MenuFrm" scrolling="auto" noresize marginwidth="0" marginheight="0">
				<frame src="ViewFrm.asp" name="ViewFrm" scrolling="auto" noresize>
			</frameset>
			<frame src="Blank.html" name="HiddenFrm" scrolling="no" noresize marginwidth="0"  marginheight="0">
			<frame src="Midi.asp" name="MidiFrm" scrolling="NO" noresize marginwidth="0"  marginheight="0">
		</frameset>
</frameset>
</html>