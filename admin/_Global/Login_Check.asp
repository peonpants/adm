<%	IF Session("IU_ID") = "" OR isNull(Session("IU_ID")) THEN

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('�α����Ͻ� �Ŀ� �̿��ϼ���.');" & vbCrLf
			.Write "location.href='Main.asp'" & vbCrLf
			.Write "</script>" & vbCrLf
			.END
		END With

	END IF	%>