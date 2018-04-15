<%
const AUTHCHECK_COOKIEDOMAIN	    = ".netmarble.com"
const AUTHCHECK_COOKIENAME_CRED	    = "cred"
const AUTHCHECK_COOKIENAME_TS	    = "ts"
const AUTHCHECK_COOKIEPWD_CRED	    = "rmffhqjffh!*82@&"
const AUTHCHECK_COOKIEPWD_TS	    = "dlrjrmffhqjf!#82"
const AUTHCHECK_TIMEOUT			    = 120

Class AuthCheckCom

	private m_crypto
	private m_arr
	private m_isLogin
	
	private sub class_initialize()

        dim ts, cred, cpcred, loc
        
        m_isLogin = false		
        		
		IF trim(request.ServerVariables("SCRIPT_NAME")) <> "" Then
		     IF trim(lcase(request.ServerVariables("SCRIPT_NAME")))  = "/login/logout.asp" Then
		        exit sub
		     End IF
		End IF	      
			             
		ts   = trim(request.cookies(AUTHCHECK_COOKIENAME_TS))
		cred = trim(request.cookies(AUTHCHECK_COOKIENAME_CRED))		
		
		if (len(ts) = 0 and len(cred) = 0) then		    
			exit sub
		end if
		
		if (len(ts) = 0 or len(cred) = 0) then
			call logoff()
		end if
						
        on error resume next
		err.clear
        
        checkCrypto()
                				
		ts   = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_TS, ts)
		cred = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CRED, cred)
			
		on error goto 0
		
	    if (err.number <> 0) then
		    call logoff()
	    end if
		
	    if (checktimeout(ts) or (mid(ts, 22, 12) <> mid(cred, 22, 12))) then
		    call logoff()
	    end if        	    
		
		call issuetimestamp(mid(ts, 22, 12))
		call issuetimestampcred(mid(ts, 22, 12))
		
		m_arr = split(cred, "|")
		m_isLogin = true		
	end sub

	private sub class_terminate()
		set m_crypto = nothing
	end sub

	private property get timestamp
		dim dt
		dt = now()
		timestamp = right("0" & second(dt), 2) & _
			right("0" & minute(dt), 2) & _
			right("0" & hour(dt), 2) & _
			right("0" & day(dt) , 2) & _
			right("0" & month(dt) , 2) & _
			right("000" & year(dt)  , 4)
	end property
	
	private property get timezone
 %>
        <script language='javascript' runat='server'>var TimezoneOffset = new Date().getTimezoneOffset();</script>
 <%		
        dim nowGMT, strHour, strMin
        nowGMT = DateAdd("n", TimezoneOffset, Now)
        strHour = right("0" & abs(cint(TimezoneOffset) \ 60), 2)
        strMin = right("0" & abs(cint(TimezoneOffset) mod 60), 2)
        if TimezoneOffset > 0 then
            timezone = "-" & strHour & "" & strMin
        else
            timezone = "+" & strHour & "" & strMin
        end if
	end property
	
	private sub logoff()
%>
    <script language="javascript" type="text/javascript">
        top.location.href = "<%= NM_DOMAIN_LOGIN & "logout.asp" %>";
    </script>
<%	
		call response.end()
	end sub
	
	private function checktimeout(ts)
		dim dt
		
		checktimeout = true
		
		dt = dateserial(mid(ts, 11, 4), mid(ts, 9, 2), mid(ts, 7, 2))
		dt = dateadd("h", mid(ts, 5 , 2), dt)
		dt = dateadd("n", mid(ts, 3, 2), dt)
		dt = dateadd("s", left(ts, 2), dt)
		dt = dateadd("n", AUTHCHECK_TIMEOUT, dt)
		
		if (dt > now()) then
			checktimeout = false
		end if
	end function
	
	private function checkremote(ts)
		dim r
	    Dim remote
    		    
        remote = Request.ServerVariables("REMOTE_ADDR")
 		
		checkremote = true

		r = "|" & remote & "|"
		if (mid(ts, 34) = r) then
			checkremote = false
		end if
	end function
	
	public sub issuetimestamp(cn)
		dim tsck
	    Dim remote
    	    	
        checkCrypto()

        remote = Request.ServerVariables("REMOTE_ADDR")

		tsck = timestamp & "|" & timezone & "|" & cn & "|" & remote & "|"
		
		response.cookies(AUTHCHECK_COOKIENAME_TS) = m_crypto.encryptstring(AUTHCHECK_COOKIEPWD_TS, tsck)
		response.cookies(AUTHCHECK_COOKIENAME_TS).domain = AUTHCHECK_COOKIEDOMAIN
		response.cookies(AUTHCHECK_COOKIENAME_TS).secure = false
		response.cookies(AUTHCHECK_COOKIENAME_TS).path   = "/"
		
	end sub
	
	public sub issuetimestampcred(cn)
		dim credck, cpcredck
	    
        checkCrypto()
        	    
		credck = trim(request.cookies(AUTHCHECK_COOKIENAME_CRED))
	    credck = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CRED, credck)
	    credck = replace(credck, mid(credck, 1, 14), timestamp )
	    
	    call issuetimestamp(cn)

	    response.cookies(AUTHCHECK_COOKIENAME_CRED) = m_crypto.encryptstring(AUTHCHECK_COOKIEPWD_CRED, credck)
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).domain = AUTHCHECK_COOKIEDOMAIN
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).secure = false
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).path   = "/"

	end sub
	
	public function checklogin()
      
		checklogin = m_isLogin		
	
	end function
	
	public function messagetimeout()

		dim ts
		
		ts   = trim(request.cookies(AUTHCHECK_COOKIENAME_TS  ))

		if len(ts) = 0 then
			exit function
		else
            checkCrypto()
		    ts   = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_TS, ts)
	        messagetimeout = checktimeout(ts)
	    end if

	end function

    private Sub checkCrypto()
	    IF isEmpty(m_crypto) Then 
	        set m_crypto = server.createobject("CJICryptography.SEED")	
        End IF                		                
    End Sub
    
end class

dim dfAuthCheckCom
set dfAuthCheckCom = new AuthCheckCom
dfAuthCheckCom.m_popupCheck = false
 %>