<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<%
    '### ��� ���� Ŭ����(Command) ȣ��
    Set Dber = new clsDBHelper 
    
	SQLMSG = "UPDATE INFO_CHARGE SET IC_STATUS = 2 WHERE  IC_IDX IN (SELECT IC_IDX FROM INFO_CHARGE WHERE IC_STATUS = 0)"
	
    Dber.ExecSQL SQLMSG,Nothing,Nothing		

	Dber.Dispose
	Set Dber = Nothing 	
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('��� ó���� �Ϸ�Ǿ����ϴ�.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>