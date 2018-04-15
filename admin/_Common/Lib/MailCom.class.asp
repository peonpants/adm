<%

Class MailCom
	Private objCdoConf
	Private objCdoMsg
	Private objFlds
	Private mServer
	Private mPort
	Private mSendUsing

	Private Sub Class_initialize 

		On Error Resume Next
		
		Call Err.Clear()

		mServer = "111.92.246.205"
		mPort = "25"
		mSendUsing = "1"

		Set objCdoConf = Server.CreateObject("CDO.Configuration")
		Set objCdoMsg = Server.CreateObject("CDO.Message")
		Set objFlds = objCdoConf.Fields

		With objFlds
			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = mServer '메일서버 지정
			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = mPort '포트
			.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = mSendUsing
			.Update		
		End With

	End Sub				
				
	Private Sub Class_terminate ()
		Set objFlds = Nothing
		Set objCdoMsg = Nothing
		Set objCdoConf = Nothing
	End Sub	

	Public Function MailSend(pTo, pFromName, pSubject, pContent, pHtmlFlag)
		
		Dim fFrom
		
		fFrom = pFromName
		
		On Error Resume Next
		
		If pHtmlFlag = False Then
			pContent = Replace(pContent, vbNewLine, "")
		End If

		With objCdoMsg
			Set .Configuration = objCdoConf
			.To = pTo
			.From = fFrom
			.Subject = pSubject
			.TextBody = pContent
            .TextBodyPart.Charset      = "utf-8"						
			'.HTMLBody = pContent
			'.BodyPart.Charset="utf-8"         
			'.HTMLBodyPart.Charset="utf-8" 
			.Configuration.Fields.Update
			.Send
		End With

		If Err.number <> 0 Then
			MailSend = False
		Else
		    MailSend = True
		End If		

	End Function

	Public Function MailSendWithEmail(pTo, pFrom, pFromName, pSubject, pContent, pHtmlFlag)
		
		Dim fFrom
		
		fFrom = pFromName & "<" & pFrom & ">"

		On Error Resume Next
		
		If pHtmlFlag = False Then
			pContent = Replace(pContent, vbNewLine, "")
		End If
		
		With objCdoMsg
			Set .Configuration = objCdoConf
			.To = pTo
			.From = fFrom
			.Subject = pSubject
			.TextBody = pContent
            .TextBodyPart.Charset      = "utf-8"						
			'.HTMLBody = pContent
			'.BodyPart.Charset="utf-8"         
			'.HTMLBodyPart.Charset="utf-8" 
			.Configuration.Fields.Update
			.Send
		End With

		If Err.number <> 0 Then
			MailSendWithEmail = False
		Else
		    MailSendWithEmail = True
		End If
		
	End Function


End Class

Dim dfMailCom
Set dfMailCom = new MailCom


%>
