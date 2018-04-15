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
<%    

    '######### 리퀘스트                    ################
    mode	          = Trim(dfRequest.Value("mode"))  	
    IE_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IE_IDX")), 0, 1, 1000)
	IE_TITLE	      = Trim(dfRequest.Value("IE_TITLE"))  
	IE_STARTDATE	  = Trim(dfRequest.Value("IE_STARTDATE")) 
	IE_ENDDATE	      = Trim(dfRequest.Value("IE_ENDDATE")) 
	IE_URL	          = Trim(dfRequest.Value("IE_URL")) 
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
    '######### 이벤트 등록 
    IF mode = "write" Then    
        Call dfeventSql.InsertINFO_EVENT(dfDBConn.Conn, IE_TITLE, IE_URL, IE_STARTDATE, IE_ENDDATE )
    ElseIF mode = "modify" Then            
        Call dfeventSql.UpdateINFO_EVENT(dfDBConn.Conn, IE_TITLE, IE_URL, IE_STARTDATE, IE_ENDDATE,  IE_IDX)
    ElseIF mode = "del" Then              
        Call dfeventSql.DeleteINFO_EVENT(dfDBConn.Conn, IE_IDX )
    End IF
	
%>
<script type="text/javascript">
location.href = "list.asp"
</script>