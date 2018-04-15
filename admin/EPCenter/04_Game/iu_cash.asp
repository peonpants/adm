<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	iu_id	= REQUEST("iu_id")	
	iu_site	= REQUEST("iu_site")
	iu_cash		= REQUEST("iu_cash")
	iu_cash_gi		= REQUEST("ProcFlag")
	iu_cash_mo = REQUEST("iu_cash_mo")


	SQLMSG = "update info_user set iu_cash = iu_cash "&iu_cash_gi&iu_cash_mo&" where iu_id ='"&iu_id&"' and iu_site='"&iu_site&"' "
	DbCon.Execute(SQLMSG)
%>
<script>alert("변경되었습니다.");
location.href="user_info.asp?val=<%=iu_id%>&site=<%=iu_site%>";
 
</script>

