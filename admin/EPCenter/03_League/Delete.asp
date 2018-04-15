<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/03_League/_Sql/LeagueSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<%

  '### 디비 관련 클래스(Command) 호출
    Set Dber = new clsDBHelper 
    
	page = Trim(Request("Page"))
	RS_Sports = Request("RL_Sports")
	
	SelUser = Trim(Request("SelUser"))
	TotalCount = Request("SelUser").Count

	FOR i = 1 TO TotalCount 
		Idx = Trim(Request("SelUser")(i))
		
		SQL = "Delete REF_LEAGUE where RL_IDX = ? "
        reDim param(0)
        param(0) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,Idx)                   'adInteger adVarWChar
        Dber.ExecSQL SQL,param,Nothing	
        
	NEXT

	Dber.Dispose
	Set Dber = Nothing 			
	Response.Redirect("List.asp?page=" & page & "&RS_Sports=" & RS_Sports)
%>