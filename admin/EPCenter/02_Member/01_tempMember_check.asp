<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%	
	'항상 리퀘스트 체크 부터 NickName은 필요 없는 값인듯..
	IU_ID = Trim(REQUEST("IU_ID"))
	IU_NickName = Trim(REQUEST("IU_NickName"))
	JoinSite = Trim(REQUEST("IU_SITE"))

	IF IU_ID <> "" THEN

		SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = '" & IU_ID & "' "

		SET RS = Dbcon.Execute(SQL)
		
		IF RS.EOF THEN	
%>

		  <script>
			alert("존재하지 않는 아이디 입니다.\유니크코드 사용 불가");
			//main.asp페이지의 ViewFrm의 페이지(uniqcode.asp페이지) frm1 폼의 값 변경
			parent.frm1.ChkID.value = 1;
			parent.frm1.IU_ID.value = "";
		  </script>

<%	
		Else
%>

		  <script>
			//main.asp페이지의 ViewFrm의 페이지(uniqcode.asp페이지) frm1 폼의 값 변경
			alert("존재하는 아이디 입니다.\유니크코드 사용 가능");
			parent.frm1.ChkID.value = 1;
			//자바스크립트는 대소문자 구변함
			parent.frm1.iu_code.focus();			
			//top.ViewFrm.frm1.IU_code.focus();			
		  </script>

<%	
		END IF

	END IF

	RS.Close
	Set RS = Nothing %>