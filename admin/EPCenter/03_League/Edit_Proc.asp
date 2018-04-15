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
   
   
	RL_Idx          = Trim(request("RL_Idx")) 
	RL_Sports       = Trim(request("RL_Sports"))
	RL_League       = Trim(request("RL_League"))
	RL_KR_League    = Trim(request("RL_KR_League"))
    RL_Image        = Trim(request("uploadImgName"))	
    RL_Image        = replace(RL_Image,"[IMG]","")
    RL_Image        = replace(RL_Image,"[/IMG]","")
    
	'// DB 입력......
	If RL_Image <> "" then

        UpdSql1 = " Update Ref_League set RL_Image= ? , RL_KR_League= ? , RL_League=? , RL_Sports = ? where RL_Idx= ? "
    	        
        reDim param(4)
        param(0) = Dber.MakeParam("@RL_Image",adVarWChar,adParamInput,255,RL_Image)              'adInteger adVarWChar
        param(1) = Dber.MakeParam("@RL_KR_League",adVarWChar,adParamInput,255,RL_KR_League)                   'adInteger adVarWChar
        param(2) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)                   'adInteger adVarWChar
        param(3) = Dber.MakeParam("@RL_Sports",adVarWChar,adParamInput,255,RL_Sports)                   'adInteger adVarWChar
        param(4) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,RL_Idx)                   'adInteger adVarWChar

        
        Dber.ExecSQL UpdSql1,param,Nothing	 

    	
	    UpdSql2 = " Update Info_Game set RL_Image=?, RL_League=?, RL_Sports = ? where RL_Idx= ? " 
    	        
        reDim param(3)
        param(0) = Dber.MakeParam("@RL_Image",adVarWChar,adParamInput,255,RL_Image)              'adInteger adVarWChar
        param(1) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)                   'adInteger adVarWChar
        param(2) = Dber.MakeParam("@RL_Sports",adVarWChar,adParamInput,255,RL_Sports)                   'adInteger adVarWChar
        param(3) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,RL_Idx)                   'adInteger adVarWChar

        
        Dber.ExecSQL UpdSql2,param,Nothing	 
		
	Else
	
        UpdSql1 = " Update Ref_League set  RL_KR_League= ? , RL_League=? , RL_Sports = ? where RL_Idx= ? "
    	        
        reDim param(3)
        
        param(0) = Dber.MakeParam("@RL_KR_League",adVarWChar,adParamInput,255,RL_KR_League)                   'adInteger adVarWChar
        param(1) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)                   'adInteger adVarWChar
        param(2) = Dber.MakeParam("@RL_Sports",adVarWChar,adParamInput,255,RL_Sports)                   'adInteger adVarWChar
        param(3) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,RL_Idx)                   'adInteger adVarWChar

        
        Dber.ExecSQL UpdSql1,param,Nothing	 

        UpdSql2 = " Update Info_Game set RL_League=?, RL_Sports = ? where RL_Idx= ? " 
    	        
        reDim param(2)
        param(0) = Dber.MakeParam("@RL_League",adVarWChar,adParamInput,255,RL_League)                   'adInteger adVarWChar
        param(1) = Dber.MakeParam("@RL_Sports",adVarWChar,adParamInput,255,RL_Sports)                   'adInteger adVarWChar
        param(2) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,RL_Idx)                   'adInteger adVarWChar

        
        Dber.ExecSQL UpdSql2,param,Nothing	 

	End if
		

	

	Dber.Dispose
	Set Dber = Nothing 		
%>

<script type="text/javascript">
	alert("리그 수정이 완료되었습니다.");
	parent.location.href="List.asp?RL_Idx=<%=RL_Idx%>&Find=<%= Find %>&RL_Sports=<%= RL_Sports %>&page=<%=PAGE%>";
</script>
