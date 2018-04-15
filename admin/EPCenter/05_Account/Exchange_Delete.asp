<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
	
	
	FOR i = 1 TO TotalCount
		IE_Idx = Trim(Request("SelUser")(i))

		SQLMSG = "SELECT * FROM INFO_EXCHANGE WHERE IE_IDX = "& IE_Idx
		SET RS = DbCon.Execute(SQLMSG)
		
		'IF CDbl(RS("IE_Status")) = 0 OR CDbl(RS("IE_Status")) = 2 THEN
			IE_ID = RS("IE_ID")
			IE_Amount = Cdbl(RS("IE_Amount"))
			IE_SITE	= RS("IE_SITE")
			


			SQL1 = "insert into info_exchange_log (IE_Idx,IE_ID,IE_NickName,IE_Amount,IE_REGDATE,IE_SETDATE,IE_STATUS,IE_SITE,IE_KIND,IE_DEL) select IE_Idx,IE_ID,IE_NickName,IE_Amount,IE_REGDATE,getdate(),IE_STATUS,IE_SITE,IE_KIND,IE_DEL from Info_Exchange WHERE IE_IDX ="&IE_Idx 
			DbCon.execute(SQL1)
			
			SQL = "Delete INFO_EXCHANGE WHERE IE_IDX ="&IE_Idx 
			DbCon.execute(SQL)
			
			
		'END IF
	Next

	RS.Close
	Set RS=Nothing

	DbCon.Close
	Set DbCon=Nothing
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('삭제 처리가 완료되었습니다.');" & VbCrLf
		.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>