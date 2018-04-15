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
    'dfRequest.debug
    mode	            = Trim(dfRequest.Value("mode"))  	
    IEG_IDX             = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IEG_IDX")), 0, 1, 999999)
	IEG_TITLE	        = Trim(dfRequest.Value("IEG_TITLE"))  
	IEG_CONTENT	        = Trim(dfRequest.Value("IEG_CONTENT")) 
	IEG_AMOUNT	        = Trim(dfRequest.Value("IEG_AMOUNT")) 
	IEG_STARTTIME	    = Trim(dfRequest.Value("IEG_STARTTIME")) 
	IEG_ENDTIME	        = Trim(dfRequest.Value("IEG_ENDTIME")) 
	IEG_TEAM1	        = Trim(dfRequest.Value("IEG_TEAM1")) 
	IEG_TEAM2	        = Trim(dfRequest.Value("IEG_TEAM2")) 
	IEGD_IDX	        = Trim(dfRequest.Value("IEGD_IDX"))   
	IEGD_RESULT	        = Trim(dfRequest.Value("IEGD_RESULT"))   
	         
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
    '######### 이벤트 등록 
    IF mode = "write" Then    
        Call dfeventSql.InsertINFO_EVENT_GAME(dfDBConn.Conn, IEG_TITLE, IEG_CONTENT, IEG_AMOUNT, IEG_STARTTIME, IEG_ENDTIME )
    ElseIF mode = "modify" Then            
        Call dfeventSql.UpdateINFO_EVENT_GAME(dfDBConn.Conn, IEG_TITLE, IEG_CONTENT, IEG_AMOUNT, IEG_STARTTIME, IEG_ENDTIME , IEG_IDX)
    ElseIF mode = "del" Then              
        Call dfeventSql.DeleteINFO_EVENT_GAME(dfDBConn.Conn, IEG_IDX )
    ElseIF mode = "gameWrite" Then    
        Call dfeventSql.InsertINFO_EVENT_GAME_DETAIL(dfDBConn.Conn, IEG_TEAM1, IEG_TEAM2, IEG_IDX)                
%>
<script type="text/javascript">
location.href = "input.asp?IEG_IDX=<%= IEG_IDX %>"
</script>
<%        
        response.End
    ElseIF mode = "gameModify" Then    
        Call dfeventSql.UpdateINFO_EVENT_GAME_DETAIL(dfDBConn.Conn, IEG_TEAM1, IEG_TEAM2, IEG_IDX, IEGD_RESULT, IEGD_IDX)                
%>
<script type="text/javascript">
location.href = "input.asp?IEG_IDX=<%= IEG_IDX %>"
</script>
<%        
        response.End     
    ElseIF mode = "gameDel" Then    
        Call dfeventSql.DeleteINFO_EVENT_GAME_DETAIL(dfDBConn.Conn, IEGD_IDX)             
%>
<script type="text/javascript">
location.href = "input.asp?IEG_IDX=<%= IEG_IDX %>"
</script>
<%        
        response.End             
    End IF
	
%>
<script type="text/javascript">
location.href = "list.asp"
</script>