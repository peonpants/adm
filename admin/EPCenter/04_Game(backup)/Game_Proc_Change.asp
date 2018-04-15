<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")

	IG_IDX		= CDbl(REQUEST("IG_IDX"))
 	GameProc	= REQUEST("GameProc")

    IF GameProc = "R" THEN
		UPDSQL = "UPDATE INFO_GAME SET IG_Status = 'R' WHERE IG_IDX = "& IG_IDX &""
		DbCon.Execute (UPDSQL)
	ELSEIF GameProc = "S" THEN
		UPDSQL = "UPDATE INFO_GAME SET IG_Status = 'S' WHERE IG_IDX = "& IG_IDX &""
		DbCon.Execute (UPDSQL)
	ELSEIF GameProc = "E" THEN
		UPDSQL = "UPDATE INFO_GAME SET IG_Status = 'E' WHERE IG_IDX = "& IG_IDX &""
		DbCon.Execute (UPDSQL)

		DELSQL = "DELETE INFO_CART WHERE ICT_GameNum = "& IG_IDX &""
		DbCon.Execute (DELSQL)
	END IF

	DbCon.Close
	Set DbCon=Nothing
%>

<script>
	location.href="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
</script>