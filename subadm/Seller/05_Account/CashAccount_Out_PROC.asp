<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/seller/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/seller/05_Account/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->


<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
	Dim dfgameSql1
    Set dfgameSql1 = new gameSql    	

Dim IA_CASH
Dim IA_SITE
Dim IA_ID
Dim IAC_CASH
'request �� ������ ���
IA_CASH = trim(request("IA_CASH"))
IA_SITE = trim(request("IA_SITE"))
IA_ID = trim(request("IA_ID"))
IAC_CASH = trim(request("IAC_CASH"))

If Cdbl(IA_CASH) < Cdbl(IAC_CASH) Then
	With Response
		.write "<script type='text/javascript'>" & vbcrlf
		.write "alert('��û�Ͻ� �ݾ��� ����ĳ������ �ݾ��� �����ϴ�. �ݾ��� Ȯ�����ּ���.');" & vbcrlf
		.WRITE "parent.location.reload();" & vbcrlf
		.write "</script>" & vbcrlf
		.End
	End With
End IF

If Cdbl(IA_CASH) > Cdbl(IAC_CASH) Or  Cdbl(IA_CASH) = Cdbl(IAC_CASH) Then
	Response.Write "<script>alert('����ĳ�� " & IA_CASH & "������ " & IAC_CASH & "���� ��ݽ�û �Ǿ����ϴ�.');</script>" 
	IA_CASH=IA_CASH-IAC_CASH
	Call dfgameSql1.InsertLOG_ADMIN_CASHINOUT_SUB(dfDBConn.Conn, IA_SITE, IA_ID, IAC_CASH, IA_CASH, 2, "����ĳ��ȯ��", 0)
	With Response
		.write "<script type='text/javascript'>" & vbcrlf
		.write "alert('��ݽ�û �Ϸ�');" & vbcrlf
		.WRITE "parent.location.reload();" & vbcrlf
		.write "</script>" & vbcrlf
		.End
	End With
End If

%>