<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
    BC_Type	    = Trim(REQUEST("BC_Type"))
	BC_Idx		= REQUEST("BC_Idx")
	BCR_Contents= Checkit(REQUEST("BCR_Contents"))


	SQLMSG = "SELECT BCR_RefNum FROM Board_Customer_Reply WHERE BCR_RefNum = " & BC_Idx &" "
	SET RS = DbCon.Execute(SQLMSG)

	IF RS.EOF THEN
		INSSQL = "Insert Into Board_Customer_Reply( BCR_RefNum, BCR_Contents) values( "
		INSSQL = INSSQL & BC_Idx & ", '"
		INSSQL = INSSQL & BCR_Contents & "')"
		DbCon.execute(INSSQL)
		
		UPDSQL = "Update Board_Customer set BC_Reply=1, BC_Type='"&BC_Type&"' where BC_Idx=" & BC_Idx
		DbCon.execute(UPDSQL)
	ELSE
	    UPDSQL = "Update Board_Customer set BC_Reply=1, BC_Type='"&BC_Type&"' where BC_Idx=" & BC_Idx
	    DbCon.execute(UPDSQL)
	    
		UPDSQL = "Update Board_Customer_Reply set BCR_Contents='" & BCR_Contents & "' where BCR_RefNum=" & BC_Idx
		DbCon.execute(UPDSQL)
	END IF

	RS.Close
	Set RS = Nothing

	DbCon.Close
	Set DbCon=Nothing
%>
	<script>
		location.href="View.asp?BC_Idx=<%= BC_Idx %>&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=<%= BC_Type %>";
	</script>