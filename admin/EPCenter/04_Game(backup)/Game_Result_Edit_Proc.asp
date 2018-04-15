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
	ig_type		= Trim(REQUEST("k2_ig_type"))


	If ig_type = "1" Then
		If CDbl(IG_Handicap)+ CDbl(IG_Score1) > CDbl(IG_Score2) then
			GameResult = 1
		Else
			GameResult = 2
		End If 
		'response.write "&nbsp;&nbsp;<strong>핸디캡</strong>"
	ElseIf ig_type = "2" Then
		If CDbl(IG_Score1)+ CDbl(IG_Score2) > CDbl(IG_Handicap) then
			GameResult = 1
		Else
			GameResult = 2
		End If 
		'response.write "&nbsp;&nbsp;<strong>오버언더</strong>"
	Else 
		If CDbl(IG_Score1) > CDbl(IG_Score2) Then 
			GameResult = 1
		ElseIf CDbl(IG_Score1) < CDbl(IG_Score2) Then 
			GameResult = 2
		Else 
			GameResult = 0
		End If 
		'response.write "&nbsp;&nbsp;<strong>승무패</strong>"
	End if 

	
	'// DB 입력......
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