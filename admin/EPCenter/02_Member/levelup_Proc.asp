<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->


<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))

		UPDSQL = "UPDATE INFO_USER SET IU_level = IU_level + 1 WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

''''''''''''''''''''''''''''''''''������� ����'''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''������� ����'''''''''''''''''''''''''''''''''''



		BC_TITLE	= "�ڡ١ڵ���� ���ϵ帳�ϴ١ڡ١�"
		BC_MANAGER	= "������"
		BC_WRITER	= IU_ID
		BC_CONTENTS	= "&nbsp;&nbsp;<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;�ȳ��ϼ��� �̺�Ʈ ������ �Դϴ�<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;ȸ������ ������ؿ� �����Ͽ� �ڵ���� �Ǽ̽��ϴ�<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;��������� ���������� ���ο� ��������� �������ֽñ� �ٶ�� �����"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;���� ���ǻ����� �˷��帮�ڽ��ϴ�.<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;1. �������� ���� ���ο� ������ �ο�<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;- ����� �ǽø� ȸ������ �ڵ������� ���ο� �������� �ο��˴ϴ�.<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;���� �α��κ��ʹ� �ݵ�� �߱޹����� ���������� ���ã�� �� ������ �̿� ��Ź<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;�帳�ϴ�.<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;2. �������� ���� ���ο� ���ºο�<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;- ������ ����Ʈ ���ȸ����� �� ������ ���� ���°� �ڵ����� �߱޵˴ϴ�.<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;ȸ������ ������´� �����ϱ� �޴����� �������¹��� �������� Ŭ���Ͻø� ��<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;������ ȸ������ �������°� �߱޵ǿ��� ���ο� �������¸� �̿����ֽñ� �ٶ�<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;�ϴ�<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;���� �����·� �Աݽ� ����ó���� �����ɼ������� �����Ͻñ� �ٶ��ϴ�<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;3. �׿� ��÷����Ʈ ���޵��� ��޺� ������ ���������� ���ο� ��޺� ������ ��<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;���Ͻñ� �ٶ��ϴ�^^<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		JOBSITE		= JOBSITE


	
		SQL2 = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY,BC_TYPE) VALUES ( '������', "
		SQL2 = SQL2 & "'"&BC_WRITER&"','"&BC_TITLE&"','"&BC_CONTENTS&"','"&JOBSITE&"','"&BC_MANAGER&"', 1,2)"

		DbCon.execute(SQL2)

	
	DbCon.Close
	Set DbCon=Nothing

		        
''''''''''''''''''''''''''''''''''������� ����'''''''''''''''''''''''''''''''''''

'	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
	Response.Write "<script language=javascript>"
	Response.Write "history.back();"
	Response.Write "</script>"
	Response.End

%>