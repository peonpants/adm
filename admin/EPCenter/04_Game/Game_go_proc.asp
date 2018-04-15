<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%


	IG_IDX		= REQUEST("IG_IDX")

	IG_Content  = Replace(Trim(REQUEST("IG_Content")),"'","''")
	IG_Memo = Replace(Trim(REQUEST("IG_Memo")),"'","''")
	IG_ANAL = Replace(Trim(REQUEST("IG_ANAL")),"'","''")
	IG_BROD = Replace(Trim(REQUEST("IG_BROD")),"'","''")


	'// DB 입력
	UPDSQL = "UPDATE INFO_GAME SET " 

	UPDSQL = UPDSQL & " IG_Memo='" & IG_Memo & "' "
	UPDSQL = UPDSQL & ", IG_Content='" & IG_Content & "' "
	UPDSQL = UPDSQL & ", IG_ANAL='" & IG_ANAL & "' "
	UPDSQL = UPDSQL & ", IG_BROD='" & IG_BROD & "' "
	UPDSQL = UPDSQL & " WHERE IG_IDX=" & IG_IDX
	
	
	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script type="text/javascript">
    alert("수정 되었습니다.");
	//opener.location.reload();
	self.close();
</script>