<% 
injection_i=0

For each item in Request.QueryString 
	for injection_i = 1 to Request.QueryString(item).Count 

	strInjection	=	 strInjection & Request.QueryString(item)(injection_i)
	tmpstring		=	 replace(Request.QueryString(item)(injection_i)," ","") 
    if  instr(UCASE(tmpstring),"'OR")	> 0 or instr(UCASE(tmpstring),"'AND")	> 0 then
		%>
		<script>
			alert("SQL Injection hacking[page back]");
			history.back();
		</script>
		<%
		response.end
	end if

	strInjection	=	 strInjection & item
	next 
next 

injection_i=0

For each item in Request.Form 
	for injection_i = 1 to Request.Form(item).Count
	strInjection	=	strInjection & Request.form(item)(injection_i)

	tmpstring		=	 replace(Request.form(item)(injection_i)," ","") 
    if  instr(UCASE(tmpstring),"'OR")	> 0 or instr(UCASE(tmpstring),"'AND")	> 0 then
		%>
		<script>
			alert("SQL Injection hacking[page back]");
			history.back();
		</script>
		<%
		response.end
	end if
    strInjection	=	strInjection & item
	next 
next 



if instr(UCASE(strInjection),"CREATE")	> 0 or instr(UCASE(strInjection),"DROP")>0 or instr(UCASE(strInjection),"UPDATE")>0 or instr(UCASE(strInjection),"SELECT")>0 or instr(UCASE(strInjection),"'OR")>0 OR  instr(UCASE(strInjection),"'AND")>0  OR  instr(UCASE(strInjection),"EXEC")>0  OR instr(UCASE(strInjection),"INSERT")>0 OR instr(UCASE(strInjection),"DECLARE")>0 then
%>
<script>
	alert("SQL Injection hacking[page back]");
	history.back();
</script>
<%

response.end
end if

if     instr(UCASE(strInjection),"<SCRIPT")>0 	or instr(UCASE(strInjection),"</SCRIPT")>0  	or instr(UCASE(strInjection),"<HTML")>0 	or instr(UCASE(strInjection),"</HTML")>0 	or instr(UCASE(strInjection),"<META")>0 	or instr(UCASE(strInjection),"<LINK")>0 	or instr(UCASE(strInjection),"<HEAD")>0 	or instr(UCASE(strInjection),"</HEAD")>0 	or instr(UCASE(strInjection),"<BODYD")>0 	or instr(UCASE(strInjection),"</BODY")>0 	or instr(UCASE(strInjection),"<FORM")>0 	or instr(UCASE(strInjection),"</FORM")>0 	or instr(UCASE(strInjection),"<STYLE")>0 	or instr(UCASE(strInjection),"</STYLE")>0 	or instr(UCASE(strInjection),"COOKIE")>0	or instr(UCASE(strInjection),"<DOCUMENT.")>0  	or instr(UCASE(strInjection),"SCRIPT:")>0 	Then
%>
<script>
	alert("XSS hacking[page back]");
	history.back();
</script>
<%

response.end
end if

%>