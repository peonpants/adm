<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<%
	ProcFlag = REQUEST("ProcFlag")
	BFR_Writer = request("BFR_Writer")
	BF_REGDATE = request("BFR_REGDATE")
	IU_LEVEL = request("IU_LEVEL")
	IF ProcFlag = "I" THEN

		BF_Idx = REQUEST("BF_Idx")
		BFR_Contents = Checkit(REQUEST("BFR_Contents"))
	
        IF BF_REGDATE = "" Then
            BF_REGDATE = dfStringUtil.GetFullDate(now())
        End IF     

		INSSQL = "Insert into Board_Free_Reply ( BF_Idx, BFR_Contents, BFR_Writer, BFR_REGDATE,BFR_WRITER_LEVEL) values( "
		INSSQL = INSSQL & BF_Idx & ", '"
		INSSQL = INSSQL & BFR_Contents & "', '"
		INSSQL = INSSQL & BFR_Writer &"','"&BF_REGDATE&"','"&IU_LEVEL&"')"

		DbCon.execute(INSSQL)
		
		'´ñ±Û°¹¼ö+1...
		UPDSQL= "Update Board_Free set BF_ReplyCnt=BF_ReplyCnt+1 where BF_Idx="&BF_Idx
		DbCon.execute(UPDSQL)

		DbCon.Close
		Set DbCon=Nothing

		With Response
			.Write "<script>" & vbcrlf
			.Write r & vbcrlf
			.Write "top.ViewFrm.location.reload(); " & vbcrlf
			.Write "</script>"
			.END
		End With
		
	ELSEIF ProcFlag = "D" THEN

		BF_Idx = REQUEST("BF_Idx")
		BFR_Idx = REQUEST("BFR_Idx")
		
		DELSQL = "Delete Board_Free_Reply where BFR_Idx=" & BFR_Idx
		DbCon.execute(DELSQL)
		
		'// ´ñ±Û°¹¼ö -1...
		UPDSQL= "Update Board_Free set BF_ReplyCnt=BF_ReplyCnt-1 where BF_Idx="&BF_Idx
		DbCon.execute(UPDSQL)

		DbCon.Close
		Set DbCon=Nothing

		With Response
			.Write "<script>" & vbcrlf
			.Write r & vbcrlf
			.Write "top.ViewFrm.location.reload(); " & vbcrlf
			.Write "</script>"
			.END
		End With

	END IF
%>