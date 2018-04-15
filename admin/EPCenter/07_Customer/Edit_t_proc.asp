<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/07_Customer/_Sql/customerSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	BCT_IDX		= Trim(REQUEST("BCT_IDX"))
	BCT_TITLE		= Trim(REQUEST("BCT_TITLE"))
	BCT_CONTENTS		= Trim(REQUEST("BCT_CONTENTS"))
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
    IF BCT_IDX = "" Then
	    Call dfcustomerSql.InsertBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn, BCT_TITLE , BCT_CONTENTS)
    Else
        Call dfcustomerSql.UpdateBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn, BCT_TITLE , BCT_CONTENTS, BCT_IDX)
    End IF	    
    

%>
<script type="text/javascript">
	location.href="List_t.asp";
</script>