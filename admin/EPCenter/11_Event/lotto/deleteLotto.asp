<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Response.Charset = "euc-kr"

	IL_GUID					= REQUEST("IL_GUID")

	If IL_GUID = "" Then
		Response.Write "<script>alert('������ �ζ� ������ �����ϴ�.');history.back();</script>"
		Response.End
	End If

	' �⺻���ñݾ� ��������
	SQL = "SELECT IL_BASIC_BET_MONEY FROM dbo.INFO_LOTTO WHERE IL_GUID = '" & IL_GUID & "'"
	Set sRs = DbCon.Execute(SQL)
	If NOT sRs.EOF Then
		IL_BASIC_BET_MONEY = sRs(0)
	Else
		Response.Write "<script>alert('�ζ� �⺻ ���� �ݾ��� �����ϴ�.');history.back();</script>"
		Response.End
	End If
	sRs.Close
	Set sRs = Nothing

	' ������ ����� ���̵� ��������
	Dim arrRows
	SQL = "SELECT IU_ID, ILU_SITE FROM dbo.INFO_LOTTO_USER_BETTING WHERE IL_GUID = '" & IL_GUID & "'"
	Set sRs = DbCon.Execute(SQL)
	IF Not sRs.EOF Then
		arrRows = sRs.GetRows
	End If
	sRs.Close
	Set sRs = Nothing

	If IsArray(arrRows) Then
		For i = 0 To UBound(arrRows, 2)
			' ����ĳ�� ����
			SQL = "UPDATE Info_User SET IU_Cash = IU_Cash + " & IL_BASIC_BET_MONEY & " WHERE IU_ID = '" & arrRows(0, i) & "' AND IU_SITE = '" & arrRows(1, i) & "'"
			DbCon.Execute(SQL)

			SQL = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = '" & arrRows(0, i) & "' AND IU_SITE = '" & arrRows(1, i) & "'"
			Set sRs = DbCon.Execute(SQL)
			If Not sRs.EOF Then
				CIU_Cash	= sRs(0)
			End If
			sRs.Close
			Set sRs = Nothing

			' �������� Log_CashInOut�� �Է�
			SQL = "INSERT INTO Log_CashInOut (LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_COMMENTS) VALUES ('" & arrRows(0, i) & "', " & IL_BASIC_BET_MONEY & ", " & CIU_Cash & ", '�ζ���ҹ��ñݾ׹�ȯ', '" & arrRows(1, i) & "', '�Ϲ�')"
			DbCon.Execute(SQL)
		Next
	End If

	' �ζ� ����
	SQL = "DELETE dbo.INFO_LOTTO WHERE IL_GUID = '" & IL_GUID & "'"
	DbCon.Execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script>
	alert("�����Ǿ����ϴ�.");
	location.href = "/EPCenter/11_Event/lotto/List.asp";
</script>