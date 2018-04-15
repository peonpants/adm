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
<%
	mode        = REQUEST("mode")
    v_data      = REQUEST("v_data")
    SelUser = Split(v_data,",")
	TotalCount = ubound(SelUser)    
'######### 디비 연결                    ################	
dfDBConn.SetConn = Application("DBConnString")
dfDBConn.Connect()	
            
    
IF mode = "reg" Then
    FOR i = 0 TO TotalCount 
	    IG_IDX = SelUser(i)
	    rtn =  dfgameSql.InsertINFO_GAMEByIndexData(dfDBConn.Conn,  IG_IDX)            
	    
	    IF rtn = 0 Then
	    End IF
    Next	
ElseIF mode ="idx" Then
    IG_IDX      = REQUEST("IG_IDX")
    
    rtn =  dfgameSql.InsertINFO_GAMEByIndexData(dfDBConn.Conn,  IG_IDX)            

End IF	         
%>
<script type="text/javascript">
alert("등록되었습니다. \n리그가 등록되지 않은 경기는 등록되지 않습니다.<%= IG_IDX %>");
parent.location.reload();
</script>
