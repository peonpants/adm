<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/09_Etc/_Sql/etcSql.Class.asp"-->

<%
    
       
    IF_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IF_IDX")), 1, 1, 9999999) 
    
 

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    	
	'######### 정산 리스트를 불러옴                 ################
   
	Call dfEtcSql.GetINFO_FlashGAme(dfDBConn.Conn, IF_IDX)

	IF dfEtcSql.RsCount <> 0 Then
        IF_SWF          = dfEtcSql.RsOne("IF_SWF")
	End IF


		
%>

<html>
<head>
<title>날짜별 현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/_Common/inc/Css/Style2.css">
<script type="text/javascript">
function flashGame(FlashIDName, FlashFileName, FlashWidth, FlashHeight, DNSSetting, WMODESetting, FlashBGColor, QSetting, FlashAlign) {	
	document.write('<OBJECT CLASSID="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
	document.write('CODEBASE="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=9,0,0,0" ');
	document.write(' ID="'+FlashIDName+'" WIDTH="' + FlashWidth + '" HEIGHT="' + FlashHeight + '" ALIGN="wmode">');
	document.write('<PARAM NAME="movie" VALUE="'+ FlashFileName +'">');
	document.write('<PARAM NAME="quality" VALUE="high">');
	document.write('<PARAM NAME="bgcolor" VALUE="'+FlashBGColor+'">');
	document.write('<PARAM NAME="wmode" VALUE="">');
	document.write('<PARAM NAME="allowScriptAccess" VALUE="always">');
	document.write('<PARAM NAME="volume" VALUE="70">');
	document.write('<EMBED SRC="'+ FlashFileName +'"  NAME="'+FlashIDName+'"');
	document.write(' WIDTH="' + FlashWidth + '" HEIGHT="' + FlashHeight + '" QUALITY="high" BGCOLOR="'+FlashBGColor+'"');
	document.write(' ALLOWSCRIPTACCESS="always" ALIGN="wmode" WMODE="" TYPE="application/x-shockwave-flash" VOLUME="70"');
	document.write(' PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer" >');
	document.write('</EMBED>');
	document.write('</OBJECT>');
}
</script>
</head>

<body >
<script type="text/javascript">flashGame("swf", "<%= IF_SWF %>", "500px", "375px");</script>



</body>
      
</html>

