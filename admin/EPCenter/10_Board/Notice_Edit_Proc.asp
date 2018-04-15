<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	BN_Idx		= REQUEST("BN_Idx")
	BN_Title	= Checkit(REQUEST("BN_Title"))
	BN_Contents = Checkit(REQUEST("BN_Contents"))
	BN_Top		= REQUEST("BN_Top")


	SQL = "UPDATE BOARD_NOTICE SET "
	SQL = SQL & "BN_Title = '"& BN_Title & "', "
	SQL = SQL & "BN_Contents = '"& BN_Contents & "', "
	SQL = SQL & "BN_Top = '"& BN_Top & "' "
	SQL = SQL & " WHERE BN_Idx = '" & BN_Idx & "'"
	DbCon.execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
%>
	<script>
		//alert("회원수정이 완료되었습니다.");
		location.href="Notice_List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>";
	</script>