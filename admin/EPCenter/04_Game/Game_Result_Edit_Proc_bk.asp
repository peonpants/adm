<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")

	IG_IDX		= REQUEST("IG_IDX")
	IG_Score1	= Trim(REQUEST("IG_Score1"))
	IG_Score2	= Trim(REQUEST("IG_Score2"))
	IG_Handicap = Trim(REQUEST("IG_Handicap"))
	IG_Memo		= Trim(REQUEST("IG_Memo"))
	
	IF IG_Handicap <> "0" THEN
		Score1 = Cdbl(IG_Score1) + Cdbl(IG_Handicap)
	ELSE
		Score1 = IG_Score1
	END IF
	
	IF Cdbl(Score1) > Cdbl(IG_Score2) THEN
		GameResult = 1
	ELSEIF Cdbl(Score1) < Cdbl(IG_Score2) THEN
		GameResult = 2
	ELSE
		GameResult = 0
	END IF

	
	'// DB ют╥б......
	UPDSQL = "UPDATE INFO_GAME SET IG_Score1=" & IG_Score1
	UPDSQL = UPDSQL & ", IG_Score2=" & IG_Score2
	UPDSQL = UPDSQL & ", IG_Result=" & GameResult
	UPDSQL = UPDSQL & ", IG_Memo='" & IG_Memo & "' "
	UPDSQL = UPDSQL & " WHERE IG_IDX=" & IG_IDX
	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script>
	opener.top.ViewFrm.location.href="List.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	self.close();
</script>