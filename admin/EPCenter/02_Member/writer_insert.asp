<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/02_member/_Sql/memberSql.Class.asp"-->

<%
'######### ��� ����                    ################	
dfDBConn.SetConn = Application("DBConnString")
dfDBConn.Connect()	

'######### ������Ʈ üũ    #############################
	IU_ID	      = Trim(dfRequest.Value("IU_ID"))  
	BN_LEVEL	  = Trim(dfRequest.Value("BN_LEVEL")) 
	BN_SPORTS	      = Trim(dfRequest.Value("BN_SPORTS"))
	IU_NICKNAME	      = Trim(dfRequest.Value("IU_NICKNAME")) 
	
	'dfRequest.debug
	'response.end
	 	
   '######## ������ ĳ�� ����������Ʈ
     Call dfmemberSql.Recoverywriter_BOARD(dfDBConn.Conn, IU_ID, BN_LEVEL , BN_SPORTS , IU_NICKNAME)
     
'dfmemberSql.DEBUG
'RESPONSE.END
		

%>
	<script>
		alert("�Ϸ�Ǿ����ϴ�.");
		location.href="writer_list.asp";
	</script>