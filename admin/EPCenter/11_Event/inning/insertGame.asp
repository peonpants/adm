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
    
    IGI_TEAM1    = Trim(dfRequest.Value("IGI_TEAM1"))
    IGI_TEAM2    = Trim(dfRequest.Value("IGI_TEAM2"))
    IGI_STARTTIME    = Trim(dfRequest.Value("IGI_STARTTIME"))
    IGI_EVENTTIME    = Trim(dfRequest.Value("IGI_EVENTTIME"))
    
    IGI_RESULT    = Trim(dfRequest.Value("IGI_RESULT"))

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	
	
	Call dfeventSql.InsertINFO_GAME_INNING(dfDBConn.Conn, IGI_TEAM1, IGI_TEAM2, IGI_STARTTIME,IGI_RESULT, IGI_EVENTTIME)
	 
%>
<script type="text/javascript">
alert("��ϵǾ����ϴ�.");
location.href = "list.asp?IGI_STARTDATE=<%= dateValue(IGI_STARTTIME) %>"
</script>