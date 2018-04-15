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
    
	RL_Sports = Trim(request("RL_Sports"))
	RL_League = Trim(request("RL_League"))		
	RL_KR_League = Trim(request("RL_KR_League"))		
	
    RL_Image  = Trim(request("uploadImgName"))	  
    RL_Image        = replace(RL_Image,"[IMG]","")
    RL_Image        = replace(RL_Image,"[/IMG]","")    		
	
    SQLMSG = "SELECT RL_IDX FROM Ref_League WHERE RL_LEAGUE = ? "	        
    reDim param(0)
    param(0) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)              'adInteger adVarWChar
        
    Set Rs = Dber.ExecSQLReturnRS(SQLMSG,param,nothing)            		
    	
	IF NOT RS.EOF Then
%>
<script type="text/javascript">
    alert("이미 있는 리그입니다.");
    parent.location.href =  "List.asp?RS_Sports=<%= RL_Sports %>";
</script>

<%
        response.End	
	End IF
	
    SQL = "Insert into Ref_League( RL_Sports, RL_League, RL_KR_League, RL_Image) values(?,?,?,?)"
	        
    reDim param(3)
    param(0) = Dber.MakeParam("@RL_Sports",adVarWChar,adParamInput,255,RL_Sports)              'adInteger adVarWChar
    param(1) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)                   'adInteger adVarWChar
    param(2) = Dber.MakeParam("@RL_KR_League",adVarWChar,adParamInput,255,RL_KR_League)                   'adInteger adVarWChar
    param(3) = Dber.MakeParam("@RL_Image",adVarWChar,adParamInput,255,RL_Image)                   'adInteger adVarWChar

    
    Dber.ExecSQL SQL,param,Nothing	 

	Dber.Dispose
	Set Dber = Nothing 		
%>

<script type="text/javascript">
    alert("등록되었습니다.");
    parent.location.href =  "List.asp?RS_Sports=<%= RL_Sports %>";
</script>







