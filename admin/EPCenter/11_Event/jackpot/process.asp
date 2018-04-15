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

    IJ_CASH = dfRequest("IJ_CASH")
    IJ_PERCENT = dfRequest("IJ_PERCENT")
    
    IJ_CASH  = replace(IJ_CASH,",","")
    IJ_PERCENT = IJ_PERCENT/100
        
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	

	Call dfeventSql.UpdateINFO_JACKPOT(dfDBConn.Conn, IJ_CASH ,IJ_PERCENT)
   
%>
<script type="text/javascript">
alert("수정되었습니다.");
location.href ="event.asp";
</script>
