<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<% 
	Session.CodePage = 949
	Response.ChaRset = "euc-kr"
    
	IU_IDX			= Trim(REQUEST("IU_IDX"))
	IU_LEVEL		= Trim(REQUEST("IU_LEVEL"))


    IF IU_IDX ="" OR NOT IsNumeric(IU_Level) Then
        response.Write "입력값은 숫자만 가능합니다.."
        response.End
    End IF
    
	SQL = "UPDATE INFO_USER SET IU_Level = "& IU_Level
	SQL = SQL & " WHERE IU_IDX = '" & IU_IDX & "'"
	

		
	DbCon.execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
	
	response.Write "레벨이 정상 등록되었습니다."
	
	
%>