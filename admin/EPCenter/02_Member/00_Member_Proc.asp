<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	IF REQUEST.Form("EMODE") = "MEMADD" THEN

			IU_ID = Trim(REQUEST.Form("IU_ID"))
			IU_PW = Trim(REQUEST.Form("IU_PW"))
			IU_BankName = Trim(REQUEST.Form("IU_BankName"))
			IU_BankNum = Trim(REQUEST.Form("IU_BankNum"))
			IU_BankOwner = Trim(REQUEST.Form("IU_BankOwner"))
			
			IU_NickName = Trim(REQUEST.Form("IU_NickName"))
			IU_Mobile1	= REQUEST.Form("IU_Mobile1")
			IU_Mobile2	= REQUEST.Form("IU_Mobile2")
			IU_Mobile3	= REQUEST.Form("IU_Mobile3")
			JoinSite	= REQUEST.Form("JoinSite")

			IF LEN(IU_Mobile2) < 3 OR LEN(IU_Mobile3) < 4 THEN
				IU_Mobile = null
			ELSE
				IU_Mobile = IU_Mobile1&"-"&IU_Mobile2&"-"&IU_Mobile3
			END IF

			IU_Email = REQUEST.Form("Email1") & "@" & REQUEST.Form("Email3")


			SQL = "SELECT IU_Idx FROM Info_User WHERE IU_BankName='" & IU_BankName & "' AND REPLACE(IU_BankNum,'-','')='" & REPLACE(IU_BankNum,"-","") & "' AND IU_SITE='"& JoinSite &"'"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF THEN
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('ȸ�������� �Ұ����� ���������Դϴ�. �����ڿ��� �����ϼ���.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.END
				END With
			END IF



			SQL = "SELECT IU_Idx FROM Info_User WHERE IU_Mobile='" & IU_Mobile & "' AND IU_SITE = '"& JoinSite &"'"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF THEN
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('ȸ�������� �Ұ����� ����ó�����Դϴ�. �����ڿ��� �����ϼ���.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.END
				END With
			END IF



			SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = '" & IU_ID & "'"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF THEN
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('������� ���̵� �Դϴ�. �ٸ� ���̵� �Է����ּ���.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.END
				END With
			END IF



			SQL = "SELECT IU_ID FROM Info_User WHERE IU_NickName = '" & IU_NickName & "'"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF THEN
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('������� �г��� �Դϴ�. �ٸ� �г����� �Է����ּ���.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.END
				END With
			END IF
			

			SQL = "INSERT INTO Info_User (IU_ID,IU_PW,IU_NickName,IU_BankName, IU_BankNum, IU_BankOwner,IU_Mobile,IU_Email,IU_SITE) VALUES( '"
			SQL = SQL & IU_ID & "', '"
			SQL = SQL & IU_PW & "', '"
			SQL = SQL & IU_NickName & "', '"
			SQL = SQL & IU_BankName & "', '"
			SQL = SQL & IU_BankNum & "', '"
			SQL = SQL & IU_BankOwner & "', '"
			SQL = SQL & IU_Mobile & "', '"
			SQL = SQL & IU_Email & "','" & JoinSite & "')"
			DbCon.execute(SQL)
			
			RS.Close
			Set RS = Nothing
			
			Dbcon.Close
			Set Dbcon = Nothing

			WITH RESPONSE
				.WRITE "<script>" & vbcrlf
				.WRITE "alert(""ȸ������� ���������� �̷�������ϴ�."");" & vbcrlf
				.WRITE "opener.location.reload();" & vbcrlf
				.WRITE "self.close();" & vbcrlf
				.WRITE "</script>"
				.END
			END WITH

	ELSEIF REQUEST.Form("EMODE") = "MEMMOD" THEN



	END IF	%>