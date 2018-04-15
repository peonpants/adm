<%
const AUTHCHECK_COOKIEDOMAIN	    = ".netmarble.com"
const AUTHCHECK_COOKIENAME_CRED	    = "cred"
const AUTHCHECK_COOKIENAME_CPCRED	= "cpcred"
const AUTHCHECK_COOKIENAME_TS	    = "ts"
const AUTHCHECK_COOKIEPWD_CRED	    = "rmffhqjffh!*82@&"
const AUTHCHECK_COOKIEPWD_CPCRED	= "ekrkxdl100aks!@#"
const AUTHCHECK_COOKIEPWD_TS	    = "dlrjrmffhqjf!#82"
const AUTHCHECK_TIMEOUT			    = 360
'const AUTHCHECK_LOGOFFPAGE		    = "http://global.netmarble.com/login/logout.asp"


const AUTHCHECK_INFO_TIMEZONE	    = 1
const AUTHCHECK_INFO_CN			    = 2
const AUTHCHECK_INFO_LOGINID	    = 3
const AUTHCHECK_INFO_CERTIFICATE	= 4
const AUTHCHECK_INFO_ZIPCODE	    = 5
const AUTHCHECK_INFO_AGE	        = 6
const AUTHCHECK_INFO_GENDER	        = 7
const AUTHCHECK_INFO_REGIP	        = 8

Class AuthCheckCom

	private m_crypto
	private m_arr
	public m_popupCheck
	
	private sub class_initialize()
		set m_crypto = server.createobject("CJICryptography.SEED")
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
    <script language=javascript>
        top.location.href = "<%= NM_DOMAIN_LOGIN & "logout.asp" %>";
    </script>
<%	
		'call response.redirect(AUTHCHECK_LOGOFFPAGE)
		call response.end()
	end sub
	
	private sub popuplogoff()	
%>
    <script language=javascript>    
        try
        {
            top.opener.location.href = "<%= NM_DOMAIN_LOGIN & "logout.asp" %>";
            top.window.close();        
        }
        catch(e) 
        {
            top.window.open("<%= NM_DOMAIN_LOGIN & "logout.asp" %>","logoff","width=1024,height=768,menubar=yes,resizable=yes,scrollbars=yes,status=yes,titlebar=yes,toolbar=yes,location=yes");
            top.window.close();        
        }        
    </script>
<%	
		'call response.redirect(AUTHCHECK_LOGOFFPAGE)
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
    	
	    '######### Check L7 Remote Address      ###################
        remote = Request.ServerVariables("HTTP_CLIENT_IP")
        IF remote = "" then
            remote = Request.ServerVariables("REMOTE_ADDR")
        End IF
 		
		checkremote = true

		r = "|" & remote & "|"
		if (mid(ts, 34) = r) then
			checkremote = false
		end if
	end function
	
	public sub issuetimestamp(cn)
		dim tsck
	    Dim remote
    	
	    '######### Check L7 Remote Address      ###################
        remote = Request.ServerVariables("HTTP_CLIENT_IP")
        IF remote = "" then
            remote = Request.ServerVariables("REMOTE_ADDR")
        End IF

		tsck = timestamp & "|" & timezone & "|" & cn & "|" & remote & "|"
		
		response.cookies(AUTHCHECK_COOKIENAME_TS) = m_crypto.encryptstring(AUTHCHECK_COOKIEPWD_TS, tsck)
		response.cookies(AUTHCHECK_COOKIENAME_TS).domain = AUTHCHECK_COOKIEDOMAIN
		response.cookies(AUTHCHECK_COOKIENAME_TS).secure = false
		response.cookies(AUTHCHECK_COOKIENAME_TS).path   = "/"
		
	end sub
	
	public sub issuetimestampcred(cn)
		dim credck, cpcredck
	    
		credck = trim(request.cookies(AUTHCHECK_COOKIENAME_CRED))
		cpcredck = trim(request.cookies(AUTHCHECK_COOKIENAME_CPCRED))
	    credck = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CRED, credck)
	    cpcredck = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CPCRED, cpcredck)
	    credck = replace(credck, mid(credck, 1, 14), timestamp )
	    cpcredck = replace(cpcredck, mid(cpcredck, 1, 14), timestamp )
	    
	    call issuetimestamp(cn)

	    response.cookies(AUTHCHECK_COOKIENAME_CRED) = m_crypto.encryptstring(AUTHCHECK_COOKIEPWD_CRED, credck)
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).domain = AUTHCHECK_COOKIEDOMAIN
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).secure = false
	    response.cookies(AUTHCHECK_COOKIENAME_CRED).path   = "/"

	    response.cookies(AUTHCHECK_COOKIENAME_CPCRED) = m_crypto.encryptstring(AUTHCHECK_COOKIEPWD_CPCRED, cpcredck)
	    response.cookies(AUTHCHECK_COOKIENAME_CPCRED).domain = AUTHCHECK_COOKIEDOMAIN
	    response.cookies(AUTHCHECK_COOKIENAME_CPCRED).secure = false
	    response.cookies(AUTHCHECK_COOKIENAME_CPCRED).path   = "/"

	end sub
	
	public function checklogin()

		dim ts, cred, cpcred, loc
		
		checklogin = false
		             
		ts   = trim(request.cookies(AUTHCHECK_COOKIENAME_TS))
		cred = trim(request.cookies(AUTHCHECK_COOKIENAME_CRED))
		cpcred = trim(request.cookies(AUTHCHECK_COOKIENAME_CPCRED))
		
		if (len(ts) = 0 and len(cred) = 0 And len(cpcred) = 0) then
			exit function
		end if
		
		if (len(ts) = 0 or len(cred) = 0 Or len(cpcred) = 0) then
			call logoff()
		end if
		
		on error resume next
		err.clear
		
		ts   = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_TS, ts)
	    IF err.number <> 0 Then	        
	        call logoff()
	    End IF		
		cred = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CRED, cred)
	    IF err.number <> 0 Then	        
	        call logoff()
	    End IF		
		cpcred = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_CPCRED, cpcred)
	    IF err.number <> 0 Then	        
	        call logoff()
	    End IF		    
		
		on error goto 0
		
		m_arr = split(cred, "|")
		       		
	    IF ubound(m_arr) <> 30 Then
	        call logoff()
	    End IF
	    
	    IF ubound(split(cred, "|")) <> ubound(split(cpcred, "|")) Then
	        call logoff()
	    End IF
	    		
		IF NOT m_popupCheck Then
		    if (err.number <> 0) then
			    call logoff()
		    end if
    		
		    if (checktimeout(ts) or len(mid(ts, 22, 12)) <> 12 or (mid(ts, 22, 12) <> mid(cred, 22, 12))) then
			    call logoff()
		    end if
        Else
		    if (err.number <> 0) then
			    call popuplogoff()
		    end if
    		
		    if (checktimeout(ts) or len(mid(ts, 22, 12)) <> 12 or (mid(ts, 22, 12) <> mid(cred, 22, 12))) then
			    call popuplogoff()
		    end if        		    
        End IF		    
		
		call issuetimestamp(mid(ts, 22, 12))
		call issuetimestampcred(mid(ts, 22, 12))		
	    		       		
		checklogin = true
	
	end function
	
	'public function info(idx)
    '    
	'	if (vartype(m_arr) > 8192) then
	'		info = m_arr(idx)
	'	else
	'		info = ""
	'	end if
	'	
	'end function
	
	public function messagetimeout()

		dim ts
		
		ts   = trim(request.cookies(AUTHCHECK_COOKIENAME_TS  ))

		if len(ts) = 0 then
			exit function
		else
		    ts   = m_crypto.decryptstring(AUTHCHECK_COOKIEPWD_TS, ts)
	        messagetimeout = checktimeout(ts)
	    end if

	end function

end class

dim dfAuthCheckCom
set dfAuthCheckCom = new AuthCheckCom
dfAuthCheckCom.m_popupCheck = false
 %>