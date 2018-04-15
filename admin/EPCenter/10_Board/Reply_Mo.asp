<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
		BF_Idx = Trim(REQUEST("BF_Idx"))
		BFR_Idx = Trim(REQUEST("BFR_Idx"))
		BFR_Writer = Trim(REQUEST("BFR_Writer")) 
		BFR_Contents = Trim(REQUEST("BFR_Contents"&BFR_Idx)) 
		BFR_REGDATE = Trim(REQUEST("BFR_REGDATE")) 

		'response.write BFR_REGDATE
		If Len(BFR_REGDATE) = 0 Then
			BFR_REGDATE = "getdate()"
        Else
            	BFR_REGDATE = "'" & BFR_REGDATE & "'"
		End If 	

		inssql = "update BOARD_GATE_reply Set BFR_Contents = '"&BFR_Contents&"', BFR_Writer = '"&BFR_Writer&"', BFR_REGDATE = "&BFR_REGDATE&" where BFR_Idx=" & BFR_Idx
		
		'response.write inssql
		DbCon.execute(INSSQL)
		
		DbCon.Close
		Set DbCon=Nothing

		With Response
			.Write "<script>" & vbcrlf
			.Write r & vbcrlf
			.Write "top.ViewFrm.location.href='board_view.asp?BF_Idx="&BF_Idx&"'; " & vbcrlf
			.Write "</script>"
			.END
		End With
%>