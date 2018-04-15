<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%

    BC_TITLE	= Trim(REQUEST("BC_TITLE"))
    BC_MANAGER	= Trim(REQUEST("BC_MANAGER"))
    BC_WRITER	= Trim(REQUEST("BC_WRITER"))
    BC_CONTENTS	= Trim(REQUEST("BC_CONTENTS"))
    BC_CONTENTS = replace(BC_CONTENTS,"'","''")
    JOBSITE		= Trim(REQUEST("BC_SITE"))
    bc_mode		= Trim(REQUEST("bc_mode"))
    bcl_mode	= Trim(REQUEST("bcl_mode"))

	IF JOBSITE = "all" then
		JOBSITE1 = "all"
		SJOBSITE = "1"
	elseIF JOBSITE = "first" then
		JOBSITE1 = "all"
		SJOBSITE = "1"
	ELSEIF JOBSITE = "second" then 
		JOBSITE1 = "SF"
		SJOBSITE = "2"
	Else
		JOBSITE1 = JOBSITE
		SJOBSITE = "2"
	END If
	
    IF bc_mode = "nowMem" Then	

		IF SJOBSITE = "1" then
			SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
			SQLSTR = SQLSTR& " SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_id IN (select iu_id from realtime_log)"

			DbCon.execute(SQLSTR)  
		Else

			SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
			SQLSTR = SQLSTR& " SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1 ,1, 2 from  info_user where iu_id IN (select iu_id from realtime_log)"

			DbCon.execute(SQLSTR)  
		end If

%>
<script type="text/javascript">
alert("傈价肯丰");
location.href = "nowMem.asp";
</script>
<%	    	

    ElseIF bc_mode = "allMem" Then
		
		IF SJOBSITE = "1" then
			If bcl_mode="alllevel" then
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1"
			ElseIf bcl_mode="1level" then 
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1 and iu_level=1"
			ElseIf bcl_mode="2level" then 
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1 and iu_level=2"
			ElseIf bcl_mode="3level" then 
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1 and iu_level=3"
			ElseIf bcl_mode="4level" then 
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1 and iu_level=4"
			ElseIf bcl_mode="5level" then 
				SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
				SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', iu_site, '"&BC_MANAGER&"', 1,1, 1 from  info_user where iu_status <> 9 and iu_gtype = 1 and iu_level=5"
			End if
			DbCon.execute(SQLSTR)  
		else
			SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY, BC_TYPE, BC_GTYPE)"
			SQLSTR = SQLSTR& "SELECT '包府磊', iu_id, '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE &"', '"&BC_MANAGER&"', 1,1, 2 from  info_user where iu_status <> 9 and iu_gtype = 2"

			DbCon.execute(SQLSTR)  
		end If

%>
<script type="text/javascript">
alert("傈价肯丰");
location.href = "nowMem.asp";
</script>
<%	   


    Else

	    
		SQLSTR = "INSERT INTO Board_Customer (BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY,BC_GTYPE)"
	    SQLSTR = SQLSTR& " SELECT TOP 1 '包府磊', '"& BC_WRITER &"', '"& BC_TITLE &"', '"& BC_CONTENTS &"', '"& JOBSITE &"', '"&BC_MANAGER&"', 1,Iu_GTYPE FROM INFO_user WHERE IU_id='"& BC_WRITER &"'"

	    DbCon.execute(SQLSTR)    
%>
<script type="text/javascript">
alert("傈价肯丰");
location.href = "list.asp";
</script>
<%	    
    End IF	    

	DbCon.Close
	Set DbCon=Nothing
	
%>
