<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%	IU_ID = Trim(REQUEST("IU_ID"))
	IU_NickName = Trim(REQUEST("IU_NickName"))
	JoinSite = Trim(REQUEST("IU_SITE"))

	IF IU_ID <> "" THEN

		SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = '" & IU_ID & "'"
		SET RS = Dbcon.Execute(SQL)
		
		IF RS.EOF THEN	%>

		<script>
			alert("사용가능한 아이디 입니다.");
			top.frm1.ChkID.value = 1;
			top.frm1.IU_PW.focus();
		</script>

	<%	ELSE  %>

		<script>
			alert("이미 사용중인 아이디 입니다.\다른 아이디로 다시 확인해주세요.");
			top.frm1.IU_ID.value = "";
		</script>

	<%	END IF

	ELSEIF IU_NickName <> "" THEN

		SQL = "SELECT IU_NICKNAME FROM Info_User WHERE IU_NICKNAME = '" & IU_NickName & "'"
		SET RS = Dbcon.Execute(SQL)
		
		IF RS.EOF THEN	%>

		<script>
			alert("사용가능한 닉네임 입니다.");
			top.frm1.ChkNN.value = 1;
			top.frm1.IU_Mobile2.focus();
		</script>

	<%	ELSE  %>

		<script>
			alert("이미 사용중인 닉네임 입니다.\다른 닉네임으로 다시 확인해주세요.");
			top.frm1.IU_NickName.value = "";
		</script>

	<%	END IF

	END IF

	RS.Close
	Set RS = Nothing %>