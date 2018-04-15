<%

Class CookieUser

    private m_crypto
    private m_arr
    private m_arrcp    

	'-------------------- CRED MEMBER VARIABLES --------------------
    Private mTimeStamp          ' Time Stamp
	Private mLogin              ' Login Check 
	Private mUserNo             ' User No(CN)
	Private mUserID             ' User ID
	Private mCertificate  		' Certificate
	Private mLoginIP  		    ' Login IP
	Private mUserIP  		    ' User IP

	
	'class 생성시 호출 된다. 
	private sub Class_initialize ()
		Call SetUserInfo()
	end sub
	
	'class 소멸시 호출 된다. 
	private sub Class_terminate ()
		set m_crypto = nothing
	end sub
	
	'-------------------- GET PROPERTIES --------------------
	Public Property Get TimeStamp()
		TimeStamp = mTimeStamp
	End Property
	
	Public Property Get UserNo()
		UserNo = mUserNo
	End Property

	Public Property Get UserID()
		UserID = mUserID
	End Property

	Public Property Get CertifiCAST()
		Certificate = mCertificate
	End Property

	Public Property Get UserIP()
		UserIP = mUserIP
	End Property

	Public Property Get LoginIP()
		LoginIP = mLoginIP
	End Property
	
	Public Function SetUserInfo()
		
		dim ts, cred, cpcred
       
		set m_crypto = server.createobject("CJICryptography.SEED")

		ts   = trim(request.cookies(AUTHCHECK_COOKIENAME_TS))
		cred = trim(request.cookies(AUTHCHECK_COOKIENAME_CRED))
        
		if (len(ts) = 0) then
			exit Function
		end if

		if (len(cred) = 0) then
			exit Function
		end if
			       
        on error resume next
		err.clear
				
	    ts   = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_TS, ts)        
	    IF err.number <> 0 Then	        
	        exit Function
	    End IF
	    
	    cred = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CRED, cred)
	    IF err.number <> 0 Then	        
	        exit Function
	    End IF	    
	    	    
	    on error goto 0
	    
        'get cookie info	    
        m_arr = split(cred, "|")
	    IF ubound(m_arr) <> 5 Then
	        exit Function
	    End IF
	    
        mTimeStamp   	= m_arr(0)
        mUserNo      	= m_arr(1)
        mUserID      	= m_arr(2)
        mCertificate 	= m_arr(3)
        mUserIP   		= m_arr(4)
        mLoginIP   		= m_arr(5)
                
    End Function

	Public Function Debug()

		Response.Write( "----- UserInfo Class Debug() -----<br>" )
        Response.Write( "TimeStamp:"&mTimeStamp&"<br>" )
        Response.Write( "UserNo:"&mUserNo&"<br>" )
        Response.Write( "UserID:"&mUserID&"<br>" )
        Response.Write( "Certificate:"&mCertificate&"<br>" )
        Response.Write( "UserIP:"&mUserIP&"<br>" )
        Response.Write( "LoginIP:"&mLoginIP&"<br>" )

	end Function 

End Class

Dim dfCookieUser
Set dfCookieUser = new CookieUser

'response.Write dfCookieUser.Debug

%>