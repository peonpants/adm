<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%	
	'�׻� ������Ʈ üũ ���� NickName�� �ʿ� ���� ���ε�..
	IU_ID = Trim(REQUEST("IU_ID"))
	IU_NickName = Trim(REQUEST("IU_NickName"))
	JoinSite = Trim(REQUEST("IU_SITE"))

	IF IU_ID <> "" THEN

		SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = '" & IU_ID & "' "

		SET RS = Dbcon.Execute(SQL)
		
		IF RS.EOF THEN	
%>

		  <script>
			alert("�������� �ʴ� ���̵� �Դϴ�.\����ũ�ڵ� ��� �Ұ�");
			//main.asp�������� ViewFrm�� ������(uniqcode.asp������) frm1 ���� �� ����
			parent.frm1.ChkID.value = 1;
			parent.frm1.IU_ID.value = "";
		  </script>

<%	
		Else
%>

		  <script>
			//main.asp�������� ViewFrm�� ������(uniqcode.asp������) frm1 ���� �� ����
			alert("�����ϴ� ���̵� �Դϴ�.\����ũ�ڵ� ��� ����");
			parent.frm1.ChkID.value = 1;
			//�ڹٽ�ũ��Ʈ�� ��ҹ��� ������
			parent.frm1.iu_code.focus();			
			//top.ViewFrm.frm1.IU_code.focus();			
		  </script>

<%	
		END IF

	END IF

	RS.Close
	Set RS = Nothing %>