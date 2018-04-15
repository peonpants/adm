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
    TOP            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("TOP")), 1, 1, 2000) 
    IGI_STARTTIME            = Trim(dfRequest.Value("IGI_STARTTIME"))    
    IGI_STARTTIME = dfStringUtil.GetFullDate(IGI_STARTTIME) 
    
    IGI_TERM =  datediff("n", IGI_STARTTIME,now())
    IGI_TERM = IGI_TERM 
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	
    
	Call dfeventSql.RetrieveCHECK_NICKNAME(dfDBConn.Conn, TOP, IGI_IDX)
    
    
	IF dfeventSql.RsCount <> 0 Then
	    For ii = 0 to dfeventSql.RsCount - 1

            IGIU_RESULT = RandomNum()
            IGIU_REGDATE = RandomDate()
            'IGIU_RESULT ="00"
	        UPSQL = "INSERT INTO INFO_GAME_INNING_USER (IGI_IDX, IGIU_NAME, IGIU_RESULT, IGIU_CONTENT, IGIU_REGDATE) VALUES ("&IGI_IDX&",'"& dfeventSql.Rs(ii,"BF_WRITER") &"', '"&IGIU_RESULT&"', '100만원 기회를 잡아라!!!','"&IGIU_REGDATE&"')"
	     
            'response.Write UPSQL
	        DbCon.execute(UPSQL)

        Next
    End IF

    Function RandomNum()
        Dim rVal
        Randomize 
        For i = 1 to 10        
            random_number=int(rnd*2)+1	    
            rVal =  rVal & random_number
        Next
        RandomNum = rVal
    End Function 
    
    Function RandomDate()
        Randomize 
        num = Int((IGI_TERM*Rnd)+1) 
        
        BFR_RegDate  = dateadd("n", -num, now())
        
        BFR_RegDate = dfStringUtil.GetFullDate(BFR_RegDate)    
        RandomDate = BFR_RegDate
    End Function

%>	
<script type="text/javascript">
alert("게시글이 등록되었습니다.");
opener.location.reload();
window.close();
</script>
