<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	BFR_WRITER     = Trim(dfRequest.Value("BFR_WRITER"))
	mode     = Trim(dfRequest.Value("mode"))
	'######### 회원 리스트를 불러옴                 ################	
   
    IF mode = "add" Then
	    Call dfboardSql.insertBoard_disable(dfDBConn.Conn, BFR_WRITER)
	Else
	    Call dfboardSql.deleteBoard_disable(dfDBConn.Conn, BFR_WRITER)
	End IF
%>
<script>
alert("처리되었습니다.");
history.back();
</script>