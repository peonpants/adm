<%
	Response.Cookies("AdminID") = ""
	Response.Cookies("AdminPW") = ""
	Response.Cookies("AdminLevel") = ""
%>
<script type="text/javascript">
top.location.href = "/";
</script>