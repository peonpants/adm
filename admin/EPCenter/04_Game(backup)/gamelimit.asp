<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	viewidx = request("viewidx")
	limit = request("limit")
	If viewidx <> "" then
	updsql = "UPDATE INFO_GAME SET IG_LIMIT = '"&limit&"' where ig_idx = "&viewidx

	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
	End If 
%>
<script>
//parent.parent.location.href = "/EPCenter/04_Game/gameListNew.asp";
</script>