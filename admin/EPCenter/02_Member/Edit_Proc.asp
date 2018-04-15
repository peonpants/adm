<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DBHelper.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%

    mode			= REQUEST("mode")
	PAGE			= REQUEST("PAGE")
	IU_IDX			= Trim(REQUEST("IU_IDX"))
	IU_ID			= Trim(REQUEST("IU_ID"))
	IU_NICKNAME		= Trim(REQUEST("IU_NICKNAME"))
	IU_PW			= Trim(REQUEST("IU_PW"))
	IU_BANKNAME		= Trim(REQUEST("IU_BANKNAME"))
	IU_BANKNUM		= Trim(REQUEST("IU_BANKNUM"))
	IU_BANKOWNER	= Trim(REQUEST("IU_BANKOWNER"))
	IU_MOBILE		= Trim(REQUEST("IU_MOBILE"))
	IU_EMAIL		= Trim(REQUEST("IU_EMAIL"))
	IU_STATUS		= REQUEST("IU_STATUS")
	IU_Level		= Trim(REQUEST("IU_Level"))
	IU_SITE		    = Trim(REQUEST("IU_SITE"))
	RECOM_ID        = Trim(REQUEST("RECOM_ID"))
    IU_DETAIL        = RTrim(REQUEST("IU_DETAIL"))
    IUSITEBEFORE	= RTrim(REQUEST("IUSITEBEFORE"))
    IU_mooney_pw	= RTrim(REQUEST("IU_mooney_pw")) 
    'response.write IUSITEBEFORE
    'response.write IU_SITE
    'response.write IU_ID
    'response.end    	

    if mode = "level" then 
    
    
    SQL = "UPDATE INFO_USER SET "
	SQL = SQL & "IU_Level = '"& IU_Level&"'"
	SQL = SQL & " WHERE IU_IDX = '" & IU_IDX & "'"
    
    response.write sql
    response.end
    
    else

		Set Dber = new clsDBHelper

		SQL = "UP_USER_DATA_UPDATE"
			
		reDim param(1)
		param(0) = Dber.MakeParam("@uid",adVarWChar,adParamInput,20,IU_ID)
		param(1) = Dber.MakeParam("@IUSITE",adVarWChar,adParamInput,20,IU_SITE)
		
		Dber.ExecSp SQL,param,Nothing
		
		

	SQL = "UPDATE INFO_USER SET "
	SQL = SQL & "IU_PW = '"& IU_PW & "', "
	SQL = SQL & "IU_NICKNAME = '"& IU_NICKNAME & "', "
	SQL = SQL & "IU_BANKNAME = '"& IU_BANKNAME & "', "
	SQL = SQL & "IU_BANKNUM = '"& IU_BANKNUM & "', "
	SQL = SQL & "IU_BANKOWNER = '"& IU_BANKOWNER & "', "
	SQL = SQL & "IU_MOBILE = '"& IU_MOBILE & "', "
	SQL = SQL & "IU_EMAIL = '"& IU_EMAIL & "', "
	SQL = SQL & "IU_SITE = '"& IU_SITE & "', "
	SQL = SQL & "RECOM_ID = '"& RECOM_ID& "', "
	SQL = SQL & "IU_STATUS = "& IU_STATUS& ", "
	SQL = SQL & "IU_DETAIL = '"& IU_DETAIL& "', "
	SQL = SQL & "IU_mooney_pw = '"& IU_mooney_pw& "', "
	SQL = SQL & "IU_Level = "& IU_Level
	SQL = SQL & " WHERE IU_IDX = '" & IU_IDX & "'"
	end if
	
	DbCon.execute(SQL)

	DbCon.Close
	Set DbCon=Nothing
%>
	<script>
		alert("회원수정이 완료되었습니다.");
		location.href="list.asp?IU_IDX=<%=IU_IDX%>&page=<%=PAGE%>";
	</script>