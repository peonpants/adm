<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/01_CP/_Sql/cpSql.Class.asp"-->
<%
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '####### reqeust 값     #############

    
	IA_Level = REQUEST("IA_Level")
	IA_ID = Trim(REQUEST("IA_ID"))
	IA_PW = Trim(REQUEST("IA_PW"))
	IA_NICKNAME = Trim(REQUEST("IA_NICKNAME"))
	IA_BankName = Trim(REQUEST("IA_BankName"))
	IA_BankNum = Trim(REQUEST("IA_BankNum"))
	IA_BankOwner = Trim(REQUEST("IA_BankOwner"))
	IA_Site = Trim(REQUEST("IA_ID"))
	IA_GROUP = Trim(REQUEST("IA_GROUP"))
	IA_GROUP1 = Trim(REQUEST("IA_GROUP1"))
	IA_GROUP2 = Trim(REQUEST("IA_GROUP2"))
	IA_GROUP3 = Trim(REQUEST("IA_GROUP3"))
	IA_GROUP4 = Trim(REQUEST("IA_GROUP4"))
	IA_Percent = 100
	IA_Type = Trim(REQUEST("IA_Type"))
	types = Trim(REQUEST("type"))
	IA_SportsPercent = Trim(REQUEST("IA_SportsPercent"))
	IA_LivePercent = Trim(REQUEST("IA_LivePercent"))
	IA_CASH = Trim(REQUEST("IA_CASH"))
	IA_CalMethod = Trim(REQUEST("IA_CalMethod"))
    '####### 예외 처리     #############
    IF types <> "del" Then
		If IA_Level = "" Or IA_ID = "" Or IA_PW = "" Or IA_BankName = "" Or IA_BankNum = "" Or IA_BankOwner = "" Or IA_GROUP = "" Or IA_GROUP1 = "" Then 
			response.write "<script>alert('빈값이 있습니다.'); history.back(-1);</script>"
			response.end
		End If     
    End IF
    
    IF types = "modify" Then   

		SQL = "SELECT * FROM set_site WHERE site01 = '" & IA_Site & "'"
		SET RS = Dbcon.Execute(SQL)

		IF NOT RS.EOF Then
		else
			With Response
				RS.Close
				Set RS = Nothing
				Dbcon.Close
				Set Dbcon = Nothing
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('일치하는 총판코드(사이트명)이 존재하지 않습니다\n총판코드는 사이트설정에서 등록가능하며\n대소문자를 구분합니다');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		END If
		If IA_Level < 4 And IA_SSITE <> "" Then
			With Response
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('부본사와 총판은 상위사이트를 등록하실 필요가 없습니다');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		End if
		If IA_Level = 4 And IA_SSITE <> "" Then
			SQL = "SELECT * FROM INFO_ADMIN WHERE IA_SITE = '" & IA_SSite & "' AND IA_LEVEL=3"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF Then
			else
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('일치하는 총판코드(사이트명)이 존재하지 않습니다\n매장은 상위 총판의 총판코드(사이트명)을 넣어줘야 합니다');" & vbCrLf
					.Write "history.back(-1);</script>" & vbCrLf
					.END
				END With
			END If
		ElseIf IA_LEVEL=4 And IA_SSITE = "" Then
			With Response
				RS.Close
				Set RS = Nothing
				Dbcon.Close
				Set Dbcon = Nothing
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('매장은 상위사이트에 공란을 넣을수없습니다');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		End If

		If IA_Level = 5 And IA_SSITE <> "" Then
			SQL = "SELECT * FROM INFO_ADMIN WHERE IA_SITE = '" & IA_SSite & "' AND IA_LEVEL=4"
			SET RS = Dbcon.Execute(SQL)

			IF NOT RS.EOF Then
			else
				With Response
					RS.Close
					Set RS = Nothing
					Dbcon.Close
					Set Dbcon = Nothing
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('일치하는 총판코드(사이트명)이 존재하지 않습니다\n매장은 상위 총판의 총판코드(사이트명)을 넣어줘야 합니다');" & vbCrLf
					.Write "history.back(-1);</script>" & vbCrLf
					.END
				END With
			END If
		ElseIf IA_LEVEL=5 And IA_SSITE = "" Then
			With Response
				RS.Close
				Set RS = Nothing
				Dbcon.Close
				Set Dbcon = Nothing
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('개인매장은 상위사이트에 공란을 넣을수없습니다');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		End If
        IF request.Cookies("AdminLevel")  = 1 Then  
            Call dfCpSql.updateINFO_ADMIN(dfDBConn.Conn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_Percent, IA_Type, IA_SportsPercent, IA_LivePercent, IA_CASH, IA_SSite,IA_NICKNAME)        
        Else 
        
            If IA_Level = "" Or IA_ID = "" Or IA_PW = ""  Then 
	            response.write "<script>alert('빈값이 있습니다.'); history.back(-1);</script>"
	            response.end
	        End IF            
                Call dfCpSql.updateINFO_ADMINByPW(dfDBConn.Conn, IA_ID, IA_PW)        
%>
<script type="text/javascript">
	alert("관리자 정보변경이 완료되었습니다.");
	top.location.href="/";
</script>
<%            
            response.end
        End IF
    ElseIF types = "add" Then


		SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = '" & IA_ID & "'"
		SET RS = Dbcon.Execute(SQL)

		IF NOT RS.EOF THEN
			With Response
				RS.Close
				Set RS = Nothing
				Dbcon.Close
				Set Dbcon = Nothing
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('동일한 아이디의 회원이 존재합니다\n다른아이디를 입력하세요');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		END If

		SQL = "SELECT * FROM info_admin WHERE IA_ID = '" & IA_ID & "'"
		SET RS = Dbcon.Execute(SQL)

		IF NOT RS.EOF THEN
			With Response
				RS.Close
				Set RS = Nothing
				Dbcon.Close
				Set Dbcon = Nothing
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('동일한 아이디의 총판이 존재합니다\n총판아이디는 중복으로 신청이 불가합니다\n다른아이디를 입력하세요');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		END If

		SQL = "SELECT * FROM set_site WHERE site01 = '" & IA_Site & "'"
		SET RS = Dbcon.Execute(SQL)

		IF NOT RS.EOF Then
		else
			Call dfCpSql.InsertSet_Site(dfDBConn.Conn, IA_Site, IA_Site, IA_Site, IA_Site, IA_Site, IA_Site, IA_Site)
		END If

        Call dfCpSql.insertINFO_ADMIN_NEW(dfDBConn.Conn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_Percent, IA_Type,IA_SportsPercent,IA_LivePercent,IA_CalMethod,IA_NICKNAME)      
    ElseIF types = "del" Then 
        Call dfCpSql.deleteINFO_ADMIN(dfDBConn.Conn, IA_ID)      
    End IF	

%>

<script type="text/javascript">
	alert("관리자 정보변경이 완료되었습니다.");
	location.href="/seller/02_member/list.asp";
</script>
