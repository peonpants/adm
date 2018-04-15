<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

	Process = REQUEST("Process")
	bType = request("bType")
	
	
	IF Process = "I" THEN
	
		BF_Writer	= Trim(REQUEST("BF_Writer"))
		BF_Title	= Trim(REQUEST("BF_Title"))
        BF_PW       = "1111"
		BF_CONTENTS = REQUEST("BF_CONTENTS")

		BF_Level	= Trim(REQUEST("level"))
		BF_SITE		= Trim(REQUEST("BF_SITE"))
		BF_REGDATE	= Trim(REQUEST("BF_REGDATE"))

        
        IF BF_REGDATE = "" Then
            BF_REGDATE = dfStringUtil.GetFullDate(now())
        End IF            


    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 정보 입력                 ################	

	rtnVal =  dfboardSql.InsertBoard_Gate(dfDBConn.Conn, BF_TITLE, BF_CONTENTS,  BF_WRITER, BF_PW, BF_LEVEL, BF_SITE, BF_REGDATE)
	
		

		If rtnVal then
%>
		<script type="text/javascript">
			alert("작성하신 글이 등록되었습니다.");
			top.ViewFrm.location.href="Board_List.asp?btype=<%=bType%>";
		</script>	
<%
        end IF
        
		RESPONSE.END
	
	ELSEIF Process = "E" Then
		

		BF_Idx = Trim(REQUEST("BF_Idx"))
		BF_Title = Trim(REQUEST("BF_Title"))
		BF_REGDATE	= Trim(REQUEST("BF_REGDATE"))
		BF_SITE		= Trim(REQUEST("BF_SITE"))
		BF_Level	= Trim(REQUEST("level"))
		BF_Writer = Trim(REQUEST("BF_Writer"))
        BF_CONTENTS = Checkit(REQUEST("BF_CONTENTS"))
        
	        
        IF BF_REGDATE = "" Then
            BF_REGDATE = dfStringUtil.GetFullDate(now())
        End IF            


        '######### 디비 연결                    ################	
        dfDBConn.SetConn = Application("DBConnString")
	    dfDBConn.Connect()	
    	
	    '######### 정보 입력                 ################	

  	    rtnVal =  dfboardSql.updateBoard_Free(dfDBConn.Conn, BF_TITLE, BF_CONTENTS, BF_WRITER, BF_HITS, BF_LEVEL, BF_SITE, BF_REGDATE, BF_Idx,IB_IDX)
  
		r = "alert('글내용이 수정되었습니다.');"
		If rtnVal  then
		    With Response
			    .Write "<script>" & vbcrlf
			    .Write r & vbcrlf
			    .Write "top.ViewFrm.location.href='Board_View.asp?BF_Idx="&BF_Idx&"&bType="&bType&"';" & vbcrlf
			    .Write "</script>"
			    .END
		    End With
        end IF
		RESPONSE.END
		
	END IF
%>