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
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '####### reqeust ��     #############

    
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
    '####### ���� ó��     #############
    IF types <> "del" Then
		If IA_Level = "" Or IA_ID = "" Or IA_PW = "" Or IA_BankName = "" Or IA_BankNum = "" Or IA_BankOwner = "" Or IA_GROUP = "" Or IA_GROUP1 = "" Then 
			response.write "<script>alert('���� �ֽ��ϴ�.'); history.back(-1);</script>"
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
				.Write "alert('��ġ�ϴ� �����ڵ�(����Ʈ��)�� �������� �ʽ��ϴ�\n�����ڵ�� ����Ʈ�������� ��ϰ����ϸ�\n��ҹ��ڸ� �����մϴ�');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		END If
		If IA_Level < 4 And IA_SSITE <> "" Then
			With Response
				.Write "<script language=javascript>" & vbCrLf
				.Write "alert('�κ���� ������ ��������Ʈ�� ����Ͻ� �ʿ䰡 �����ϴ�');" & vbCrLf
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
					.Write "alert('��ġ�ϴ� �����ڵ�(����Ʈ��)�� �������� �ʽ��ϴ�\n������ ���� ������ �����ڵ�(����Ʈ��)�� �־���� �մϴ�');" & vbCrLf
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
				.Write "alert('������ ��������Ʈ�� ������ �����������ϴ�');" & vbCrLf
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
					.Write "alert('��ġ�ϴ� �����ڵ�(����Ʈ��)�� �������� �ʽ��ϴ�\n������ ���� ������ �����ڵ�(����Ʈ��)�� �־���� �մϴ�');" & vbCrLf
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
				.Write "alert('���θ����� ��������Ʈ�� ������ �����������ϴ�');" & vbCrLf
				.Write "history.back(-1);</script>" & vbCrLf
				.END
			END With
		End If
        IF request.Cookies("AdminLevel")  = 1 Then  
            Call dfCpSql.updateINFO_ADMIN(dfDBConn.Conn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_Percent, IA_Type, IA_SportsPercent, IA_LivePercent, IA_CASH, IA_SSite,IA_NICKNAME)        
        Else 
        
            If IA_Level = "" Or IA_ID = "" Or IA_PW = ""  Then 
	            response.write "<script>alert('���� �ֽ��ϴ�.'); history.back(-1);</script>"
	            response.end
	        End IF            
                Call dfCpSql.updateINFO_ADMINByPW(dfDBConn.Conn, IA_ID, IA_PW)        
%>
<script type="text/javascript">
	alert("������ ���������� �Ϸ�Ǿ����ϴ�.");
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
				.Write "alert('������ ���̵��� ȸ���� �����մϴ�\n�ٸ����̵� �Է��ϼ���');" & vbCrLf
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
				.Write "alert('������ ���̵��� ������ �����մϴ�\n���Ǿ��̵�� �ߺ����� ��û�� �Ұ��մϴ�\n�ٸ����̵� �Է��ϼ���');" & vbCrLf
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
	alert("������ ���������� �Ϸ�Ǿ����ϴ�.");
	location.href="/seller/02_member/list.asp";
</script>
