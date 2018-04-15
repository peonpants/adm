<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<%	
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
		
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
		
	FOR i = 1 TO TotalCount 
	idx = Trim(Request("SelUser")(i))
		Call dfmemberSql.UpdateINFO_USERByDel( dfDBConn.Conn, idx) 
	Next
	
	Response.Redirect "List.asp?page="&Page&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="& Search&"&Find="&Find
%>