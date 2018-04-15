<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->

<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))
	IU_SITE		= Trim(REQUEST("IU_SITE"))
	smsnum			= Trim(REQUEST("smsnum"))
	sms_yn			= REQUEST("smsyn")

	If smsnum <> "" Then
		If InStr(smsnum,"-") Then
			smsnum = Replace(smsnum,"-","")						
		End If 
		
		If sms_yn <> "" Then
			sms_yn = "1"
		Else
			sms_yn = "0"		
		End If 
a = smsnum
a01 = ""
a02 = ""
a03 = ""
a04 = ""
a05 = ""
a06 = ""
a07 = ""
a08 = ""
a09 = ""
a10 = ""
a11 = ""
a12 = ""

a01 = Mid(a,4,1)
a02 = Mid(a,8,1)
a03 = Mid(a,2,1)
a04 = Mid(a,7,1)
a05 = Mid(a,3,1)
a06 = Mid(a,5,1)
a07 = Mid(a,9,1)
a08 = Mid(a,1,1)
a09 = Mid(a,10,1)
a10 = Mid(a,6,1)
a11 = Mid(a,11,1)

a = encode(a01 & a02 & a03 & a04 & a05 & a06 & a07 & a08 & a09 & a10 & a11,3)

sql = "select * from g_phone_ck where gpc_id = '"&IU_ID&"' and gpc_site = '"&IU_SITE&"'"
Set rs = DbCon.execute(SQL)
If Not rs.eof then
	memyn = "Y"
End if
rs.close
Set rs = Nothing

response.write memyn
If memyn = "Y" then
	sql = "update g_phone_ck set gpc_phone = '"&a&"', gpc_yn = "&sms_yn&" where gpc_id = '"&IU_ID&"' and gpc_site = '"&IU_SITE&"'"
	DbCon.execute(SQL)
Else

	sql = "INSERT INTO G_PHONE_CK (  GPC_PHONE, GPC_ID, GPC_SITE, GPC_YN) VALUES ( '"&a&"', '"&IU_ID&"', '"&IU_SITE&"', "&sms_yn&")"
	'response.write sql
	DbCon.execute(SQL)

End If 
	End If 


	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
%>