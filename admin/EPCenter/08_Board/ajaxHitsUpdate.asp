<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<% 
	Session.CodePage = 949
	Response.ChaRset = "euc-kr"
    
	BF_IDX			= Trim(REQUEST("BF_IDX"))
	BF_HITS		= Trim(REQUEST("BF_HITS"))

    
    IF BF_IDX ="" OR NOT IsNumeric(BF_HITS) Then
        response.Write "�Է°��� ���ڸ� �����մϴ�.."
        response.End
    End IF
    
	SQL = "UPDATE BOARD_FREE SET BF_HITS = "& BF_HITS
	SQL = SQL & " WHERE BF_IDX = '" & BF_IDX & "'"
	

		
	DbCon.execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
	
	response.Write "��ȸ���� ���� ��ϵǾ����ϴ�."
	
	
%>