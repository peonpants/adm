<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Status	= REQUEST("Status")
	PSITE	= REQUEST("PSITE")
	
	UPDSQL = "UPDATE PopUp SET STATUS = "& Status &" WHERE PSITE = '"& PSITE &"'"
	DbCon.execute(UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>

<script>
	location.href="Pop_View.asp";
</script>