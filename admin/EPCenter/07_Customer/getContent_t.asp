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
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfcustomerSql.GetBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn , BCT_IDX)
    
IF dfcustomerSql.RsCount <> 0 THEN
		BCT_CONTENTS	= dfcustomerSql.Rs(0,"BCT_CONTENTS")
		BCT_CONTENTS = replace(BCT_CONTENTS,chr(13)&chr(10),"____")
End IF		
%>
<script type="text/javascript">
BCR_Contents = "<%= BCT_CONTENTS %>" ;
BCR_Contents = BCR_Contents.replace(/____/gi,"\n");
if(parent.frm1.BC_CONTENTS != null) parent.frm1.BC_CONTENTS.value = BCR_Contents;
if(parent.frm1.BCR_Contents != null) parent.frm1.BCR_Contents.value = BCR_Contents;

</script>
<%

	DbCon.Close
	Set DbCon=Nothing
%>