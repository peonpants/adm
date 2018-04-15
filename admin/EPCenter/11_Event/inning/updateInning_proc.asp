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
    
    IGI_IDX            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGI_IDX")), 1, 1, 999999) 
	IGID_INNING        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGID_INNING")), 1, 1, 10) 
	IGID_SCORE1        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGID_SCORE1")), 0, 1, 20) 
	IGID_SCORE2        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IGID_SCORE2")), 0, 1, 20) 
	IGI_RESULT          = Trim(dfRequest.Value("IGI_RESULT")) 
    IGID_RESULT = 2 
    
	IF IGID_SCORE1 = 0 And IGID_SCORE2 =0  Then
	    IGID_RESULT = 2 
    Else
    	  IGID_RESULT = IGID_SCORE1 + IGID_SCORE2  
    	  IF (IGID_RESULT mod 2) = 0 Then
    	    IGID_RESULT = 2
    	  Else
    	    IGID_RESULT = 1
    	  End IF
	End IF
	
    
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
	
	Call dfeventSql.updateINFO_GAME_INNING_DETAIL(dfDBConn.Conn, IGI_IDX, IGID_INNING, IGID_SCORE1,IGID_SCORE2, IGID_RESULT)
	
	
%>
<script type="text/javascript">
opener.location.reload();
window.close();

</script>