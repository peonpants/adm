<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/09_Etc/_Sql/etcSql.Class.asp"-->

<%
    
    '######### Request Check                    ################	        
    IF_TITLE = Trim(dfRequest.Value("IF_TITLE"))
    IF_IMAGE = Trim(dfRequest.Value("IF_IMAGE"))
    IF_SWF = Trim(dfRequest.Value("IF_SWF"))
 

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    	
	'######### ���� ����Ʈ�� �ҷ���                 ################
   
	Call dfEtcSql.InsertINFO_FlashGAme(dfDBConn.Conn, IF_IMAGE, IF_TITLE, IF_SWF)

	
%>	
<script>

alert("��ϵǾ����ϴ�.");
location.href("flashGAme_list.asp");
</script>