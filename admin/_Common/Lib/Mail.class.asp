<%

Class SendMail 

    Private objMail
    
    Private Sub Class_initialize 
		set objMail = server.createobject("CDONTS.NewMail")
	End Sub		
	    	
    Private Sub Class_terminate ()
	    Set objMail = nothing
    End Sub	   
    
	Public Function MailSendEmail(pTo, pFrom, pSubject, pContent, pHtmlFlag)
	                      
		If pHtmlFlag = False Then		    
			pContent = Replace(pContent, vbNewLine, "<br>")
		End If
        		        
        objMail.From        = "info@localhost"
        objMail.To          = pTo
        objMail.Subject     = pSubject
        objMail.Body        = pContent
        objMail.importance  = 0
        'objMail.SetLocaleIDs(936) 
        objMail.Send
        
	End Function
    
end class

Dim dfSendMail
Set dfSendMail = new SendMail

%>
