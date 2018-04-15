<%	IF Session("IU_ID") = "" OR isNull(Session("IU_ID")) THEN

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('로그인하신 후에 이용하세요.');" & vbCrLf
			.Write "location.href='Main.asp'" & vbCrLf
			.Write "</script>" & vbCrLf
			.END
		END With

	END IF	%>