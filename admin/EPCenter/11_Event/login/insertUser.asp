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
    
    reqRound            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("round")), 1, 1, 9999999) 
    IGI_STARTTIME    = Trim(dfRequest.Value("IGI_STARTTIME"))
    IGI_ENDTIME    = Trim(dfRequest.Value("IGI_EVENTTIME"))
    	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    		
    Call dfeventSql.InsertEVENT_LOGIN(dfDBConn.Conn, reqRound, IGI_STARTTIME,IGI_ENDTIME)
%>
<script type="text/javascript">
alert("이벤트 회원이 등록되었습니다.");
parent.location.reload();
</script>