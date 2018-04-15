<%
	REM process id : lta_object
	REM author : 류성수
	REM creation : 2007-07-01

	Class clsObject

		Private LoginStatus_
		Private DBc_

		Private mag_web_userid_
		Private mag_sys_userid_
		Private mag_name_
		Private mag_flag_

		Private web_userid_
		Private sys_userid_
		Private name_
		Private email_
		Private marry_fg_

		Private marry_date_
		Private address_1_
		Private address_2_
		Private mobile_
		Private phone_
		Private personal_id_


		Private cust_type_
		Private nation_fg_
		Private postcode_

		'_ File Upload
		Private return_path_
		Private return_url_

		'_ Monotor Auth Key
		Private monitor_key_

		'_ thumb 생성여부
		Private thumb_create_
		Private thumb_flag_


		Private Sub Class_Initialize()

			'Session 변환
			mag_web_userid_ = "" 'Session("MAGWEBID")
			mag_sys_userid_ = "" 'Session("MAGSYSID")
			mag_name_ = "" 'Session("MAGNAME")
			mag_flag_ = "" 'Session("MAGFLAG")

			name_ = HexToString(Request.Cookies("name"))
			web_userid_ = Base64Decode(Request.Cookies("login_id"))
			sys_userid_ = Request.Cookies("cust_id")
			email_ = Base64Decode(Request.Cookies("email"))
			personal_id_ = Base64Decode(Request.Cookies("personal_no"))
			address_1_ = HexToString(Request.Cookies("addr1"))
			address_2_ = HexToString(Request.Cookies("addr2"))
			marry_fg_ = Request.Cookies("marry_fg")
			cust_type_ = Request.Cookies("cust_type")
			nation_fg_ = Request.Cookies("nation_fg")
			marry_date_ = Request.Cookies("marry_date")
			mobile_ = Request.Cookies("celphone")
			phone_ = Request.Cookies("phone")
			postcode_ = Request.Cookies("postcode")
			
			'_ 모니터요원키 입니다.
			monitor_key_ = Request.Cookies("RIA")("monitor")

			thumb_create_ = False 
			thumb_flag_ = ""

			Set DBc_ = Nothing 
		End Sub

		Private Sub Class_Terminate()
			Set DBc_ = Nothing 
		End Sub

		Public Function Get_DB_Connection(GetLive)
			Set DBc_ = Server.CreateObject("ADODB.Connection")
			DBc_.Open GetLive
			Set Get_DB_Connection = DBc_
		End Function  

		Public Sub Get_DB_DisConnection()
			If IsObject(DBc_) Then Set DBc_ = Nothing
		End Sub 

		Public Sub Set_History(g_code)
		End Sub

		Public Function Make_Manager_Session(gRs)

			'session으로 변경
			Session("MAGGROUPIDX") = gRs("group_idx")
			Session("MAGWEBID") = gRs("web_userid")
			Session("MAGSYSID") = gRs("sys_userid")
			Session("MAGNAME") = gRs("name")
			Session("MAGFLAG") = gRs("login_flag")
			Session.Timeout = 120 '4시간

			mag_web_userid_ = Session("MAGWEBID")
			mag_sys_userid_ = Session("MAGSYSID")
			mag_name_ = Session("MAGNAME")
			mag_flag_ = Session("MAGFLAG")

			Make_Manager_Session = True
		End Function 

		Private Function Get_Mag_Status()
			Get_Mag_Status = False 
			If Len(Trim(mag_web_userid_)) > 0 Then Get_Mag_Status = True
		End Function 

		Public Sub Set_Mag_Session(e)
			If Get_Mag_Status = False Then 
				If e Then 
					Response.Redirect "/usr/login.asp"
					Response.End 
				Else 
					Response.End 
				End If 
			End If 
		End Sub 

		Public Sub Manager_Session_Check()
			If Get_Mag_Status = False Then 
				Response.Redirect "/usr/login.asp"
				Response.End 
			End If 
		End Sub 

		'_ 롯데리아관리자체크
		Public Sub Manager_Auth(authcode, gDBc, gRs, auth_flag)
			If Get_Mag_Status Then 
			Else 
				Response.Redirect "/usr/login.asp"
				Response.End 
			End If 
		End Sub 

		Public Function Set_Manager_Flag()
			Set_Manager_Flag = mag_flag_
		End Function 

		Public Sub Set_Content_Part(get_code)
			If IsNumeric(get_code) Then 
				Response.Cookies("ADMC") = get_code
			End If 
		End Sub 

		Public Function Get_Content_Part()
			Get_Content_Part = Request.Cookies("ADMC")
			If Not IsNumeric(Get_Content_Part) Then Get_Content_Part = "10000"
		End Function 

		Public Function Get_Mag_WebID()
			Get_Mag_WebID = mag_web_userid_
		End Function 

		Public Function Get_Mag_SysID()
			Get_Mag_SysID = mag_sys_userid_
		End Function
		
		Public Function Get_Mag_Name()
			Get_Mag_Name = mag_name_
		End Function 

		Public Function Get_Web_UserID()
			Get_Web_UserID = web_userid_
		End Function 

		Public Function Get_Sys_UserID()
			Get_Sys_UserID = sys_userid_
		End Function 

		Public Function Get_Cust_Type()
			Get_Cust_Type = cust_type_
		End Function 

		Public Function Get_Nation_FG()
			Get_Nation_FG = nation_fg_
		End Function 

		Public Function Get_Name()
			Get_Name = name_
		End Function 

		Public Function Get_Post_Code()
			Get_Post_Code = postcode_
		End Function 

		Public Function Get_Marry_Date()
			Get_Marry_Date = marry_date_
		End Function 

		Public Function Get_Mrd_St()
			Get_Mrd_St = marry_fg_
		End Function 

		Public Function Get_Adr_1()
			Get_Adr_1 = address_1_
		End Function 

		Public Function Get_Adr_2()
			Get_Adr_2 = address_2_
		End Function 

		Public Function Get_Mobile()
			Get_Mobile = mobile_
		End Function 

		Public Function Get_Phone()
			Get_Phone = phone_
		End Function 

		Public Function Get_Email()
			Get_Email = email_
		End Function  

		Public Function Get_IdNum()
			Get_IdNum = personal_id_
		End Function 

		Public Function Get_G_SessionID()
			Get_G_SessionID = Set_Guest_UserID()
		End Function 

		Public Function Get_SessionID()
			If Auth_Status() Then 
				Get_SessionID = sys_userid_
			Else
				Get_SessionID = Set_Guest_UserID()
			End If 
		End Function 

		Private Function Set_Guest_UserID()
			Set_Guest_UserID = Session.SessionID
		End Function 

		'_ 첨부파일저장경로 생성 및 반환
		Public Function Get_Upload_Path(savePath, saveUrl)
			Dim fso, curDate, FullPath(1), subPath
			curDate = Split(CStr(Date), "-")
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			subPath = savePath & "\" & curDate(0)
			On Error Resume Next
			If fso.FolderExists(subPath) = False Then fso.CreateFolder subPath
			subPath = subPath & "\" & curDate(1)
			If fso.FolderExists(subPath) = False Then fso.CreateFolder subPath
			subPath = subPath & "\" & curDate(2)
			If fso.FolderExists(subPath) = False Then fso.CreateFolder subPath
			Err.Clear
			Set fso = Nothing 
			return_path_ = subPath
			return_url_ = saveUrl & "/"  & curDate(0) & "/"  & curDate(1) & "/" & curDate(2)
			FullPath(0) = return_path_
			FullPath(1) = return_url_

			Get_Upload_Path = FullPath
		End Function 

		'_ 중복되지 않는 파일명 생성
		Private Function Set_Create_Name(gIdx, strExe, Domain)
			Dim strConvert, getExe
			getExe = Mid(strExe, InStrRev(strExe, "."))
			strConvert = gIdx & "_" & Hour(now) & Minute(now) & Second(now) & "@" & Domain & "_" & Session.SessionID & getExe
			Set_Create_Name = strConvert
		End Function 

		'_ 파일업로드 : 개체, 순번, 도메인, 반환유형, 경로, 지정경로에저장여부(True/False) False 인경우 지정한 경로에 저장함.
		Public Function Set_File_Upload(Fup, Idx, Domain, Rtn, Path, Crt)
			Dim save_name, convert_name, return_val(4)
			Dim file_info, file_size, file_type, file_name, result
			file_name = Fup.Form("set_file")(Idx).FileName
			file_size = Fup.Form("set_file")(Idx).FileSize
			file_type = Fup.Form("set_file")(Idx).ContentType
			file_name = Replace(file_name, " ", "")

			file_info = File_Infomation(file_name)
			save_name = Set_Create_Name(Idx, file_name, Domain)

			'_ 지정경로 저장여부
			If Crt Then 
				return_val(0) = return_url_
				convert_name = return_path_ & "\" & save_name
			Else
				'_ Custom 경로 지정이므로 반환 값 없음.
				return_val(0) = Null
				convert_name = Path & "\" & save_name
			End If 

			result = Fup("set_file")(Idx).SaveAs(convert_name, False)
			return_val(1) = Replace(file_name, " ", "")
			return_val(2) = save_name
			return_val(3) = file_size
			return_val(4) = file_type

			If thumb_create_ Then 
				Dim arr_flag(3), arr_width(3), arr_height(3)
				Dim m_thumb, xt : xt = 0
				If thumb_flag_ = "goods" Then 
					arr_flag(0) = "L" : arr_flag(1) = "C" : arr_flag(2) = "B" : arr_flag(3) = "T"
					arr_width(0) = 110 : arr_width(1) = 240 : arr_width(2) = 350 : arr_width(3) = 53
					arr_height(0) = 110 : arr_height(1) = 240 : arr_height(2) = 350 : arr_width(3) = 53
					For xt = 0 To 3 Step 1
						m_thumb = Make_Thumb_Img(save_name, Path, arr_width(xt), arr_height(xt), arr_flag(xt))
					Next 
				ElseIf thumb_flag_ = "product" Then 
					arr_flag(0) = "L" : arr_flag(1) = "C" : arr_flag(2) = "B"
					arr_width(0) = 48 : arr_width(1) = 150 : arr_width(2) = 420
					arr_height(0) = 48 : arr_height(1) = 150 : arr_height(2) = 420
					For xt = 0 To 2 Step 1
						m_thumb = Make_Thumb_Img(save_name, Path, arr_width(xt), arr_height(xt), arr_flag(xt))
					Next 
				ElseIf thumb_flag_ = "comment" Then 
					arr_flag(0) = "L"
					arr_width(0) = 53
					arr_height(0) = 53
					m_thumb = Make_Thumb_Img(save_name, return_path_, arr_width(0), arr_height(0), arr_flag(0))
				End If 
			End If 

			'_ GBL_RETURN_ARY (배열반환)
			'_ GBL_RETURN_XML (Xml반환)
			If Rtn = GBL_RETURN_ARY Then 
				Set_File_Upload = return_val
			ElseIf Rtn = GBL_RETURN_XML Then 
				Set_File_Upload = "<file_save_idx>"& Idx &"</file_save_idx>"
				Set_File_Upload = Set_File_Upload &"<file_name>"& file_name &"</file_name>"
				Set_File_Upload = Set_File_Upload &"<file_save_name>"& save_name &"</file_save_name>"
				Set_File_Upload = Set_File_Upload &"<file_type>"& file_type &"</file_type>"
				Set_File_Upload = Set_File_Upload &"<file_size>"& file_size &"</file_size>"
				Set_File_Upload = Set_File_Upload &"<file_save_url>"& return_url_ &"</file_save_url>"
			End If 
		End Function 

		Public Sub Create_Thumb(get_status)
			thumb_create_ = get_status 
		End Sub 

		Public Sub Thumb_Flag(get_flag)
			thumb_flag_ = get_flag
		End Sub 

		Public Function Make_Thumb_Img(SaveName, SavePath, ImgWidth, ImgHeight, SaveFlag)
			Dim get_name, get_path, get_height, get_width, get_flag
			get_name = SaveName
			get_path = SavePath
			get_width = ImgWidth
			get_height = ImgHeight
			get_flag = SaveFlag

			Dim getThumb : Set getThumb = Server.CreateObject("KMSThumb.Thumb")
			getThumb.FileName = SavePath & "\" & SaveName
			getThumb.Width = get_width
			getThumb.Width = get_height
			getThumb.Quality = 100
			getThumb.ImgGB = 1
			getThumb.FrontStr = get_flag
			getThumb.ImgScale = 2 '2이면 Scale Mode, 1이면 지정한 Height, Width로 썸네일 생성(default 1)

			getThumb.SaveThumb
			Set getThumb = Nothing
		End Function 

		'_ 업로드파일정보 반환
		Public Function File_Infomation(FileName)
			Dim FileInfo(2)
			If InstrRev(FileName, ".") > 0 Then
				FileInfo(0) = FileName : FileInfo(1) = Mid(FileName, InstrRev(FileName, ".") + 1) : FileInfo(2) = "."
			Else
				FileInfo(0) = FileName : FileInfo(1) = "" : FileInfo(2) = ""
			End  If 
			File_Infomation = FileInfo
		End Function 

		Function Set_File_Upload_Format()
			Set_File_Upload_Format = "<save_idx></save_idx>"
			Set_File_Upload_Format = Set_File_Upload_Format &"<display_name></display_name>"
			Set_File_Upload_Format = Set_File_Upload_Format &"<save_name></save_name>"
			Set_File_Upload_Format = Set_File_Upload_Format &"<file_type></file_type>"
			Set_File_Upload_Format = Set_File_Upload_Format &"<file_size></file_size>"
			Set_File_Upload_Format = Set_File_Upload_Format &"<save_path></save_path>"
		End Function 

		Public Function File_EXEFix(FileName)
			Dim CVName : CVName = FileName
			If InstrRev(CVName, ".") > 0 Then
				CVName = Left(CVName, InstrRev(CVName, ".")-1) & ".jpg"
			End  If 
			File_EXEFix = CVName
		End Function 

		Public Function Get_Unit_Page()
			Get_Unit_Page = Request.ServerVariables("SCRIPT_NAME")
		End Function 

	'_ 회원인증 유도 
		Sub Set_Login_Process(get_type, set_type)
			Dim MakeString, getString
			If Auth_Status() = False Then
				If set_type Then 
					MakeString = GBL_LOGIN
					getString = Get_Current_Page()
					If get_type = "SHOP" Then 
						getString = LTA_SHOP & getstring
					ElseIf get_type = "OFFICIAL" Then 
						getstring = LTA_OFFICIAL & getstring
					End If 
					If Len(getString) > 0 Then MakeString = MakeString & "?returnurl=" & Server.URLEncode(getString)
					Response.Redirect MakeString
				Else 
					Response.End 
				End If 
			End If 
		End Sub

		Function Get_Login_Process(get_type)
			Dim MakeString, getString
			If Auth_Status() = False Then
				MakeString = GBL_LOGIN
				getString = Get_Current_Page()
				If get_type = "SHOP" Then 
					getString = LTA_SHOP & getstring
				ElseIf get_type = "OFFICIAL" Then 
					getstring = LTA_OFFICIAL & getstring
				End If 
				If Len(getString) > 0 Then MakeString = MakeString & "?returnurl=" & Server.URLEncode(getString)
				Get_Login_Process = MakeString
			End If 
		End Function

		Sub Set_Login_Process_Idx(e)
			Dim MakeString, getString
			If Auth_Status() = False Then
				MakeString = GBL_LOGIN
				If Len(Trim(e)) > 0 Then MakeString = MakeString & "?returnurl=" & Server.URLEncode(Trim(e))
				Response.Redirect MakeString
			End If 
		End Sub

	'_ 현재 페이지 정보 반환
		Function Get_Current_Page()
			Dim MakeString : MakeString = Request.ServerVariables("URL")
			Dim TmpString : TmpString = Request.ServerVariables("QUERY_STRING")
			If Len(TmpString) > 0 Then MakeString = MakeString & "?"& TmpString
			Get_Current_Page = MakeString
		End Function 

		Function Get_Current_Page2(get_type)
			Dim MakeString : MakeString = Request.ServerVariables("URL")
			Dim TmpString : TmpString = Request.ServerVariables("QUERY_STRING")
			If Len(TmpString) > 0 Then MakeString = MakeString & "?"& TmpString
				If get_type = "SHOP" Then 
					MakeString = LTA_SHOP & MakeString
				ElseIf get_type = "OFFICIAL" Then 
					MakeString = LTA_OFFICIAL & MakeString
				End If 
			Get_Current_Page2 = MakeString
		End Function 

		Public Function Auth_Status()
			If Len(Trim(sys_userid_)) > 0 Then 
				Auth_Status = True 
			Else
				Auth_Status = False 
			End If 
		End Function 

		Public Sub Set_Web_UserID(e)
			web_userid_ = e
		End Sub 

		Public Sub Set_Sys_UserID(e)
			sys_userid_ = e
		End Sub 

		Public Sub Set_Name(e)
			name_ = e
		End Sub 

		Public Function Set_User_Info(e)
			Set_User_Info = True 
		End Function 

		Public Sub User_Destory()
			Response.Cookies("a_name") = ""
			Response.Cookies("a_addr1") = ""
			Response.Cookies("a_addr2") = ""

			Response.Cookies("RIA")("monitor") = ""
			Response.Cookies("RIA") = ""
		End Sub 

		Public Sub Manager_Destory()
'			Response.Cookies("LOTT")("MAGWEBID") = ""
'			Response.Cookies("LOTT")("MAGSYSID") = ""
'			Response.Cookies("LOTT")("MAGNAME") = ""
'			Response.Cookies("LOTT")("MAGFLAG") = ""
'			Response.Cookies("LOTT") = ""

			'Session으로 변경			
			session.abandon

			Response.Cookies("ADMC") = ""
		End Sub 

		Public Function Compare_Owner(gID)
			If sys_userid_ = "" Then 
				Compare_Owner = False 
			Else
				If sys_userid_ = gID Then 
					Compare_Owner = True 
				Else
					Compare_Owner = False 
				End If 
			End If 
		End Function 

		Public Sub Auth_Numeric(e)
			If e = "" Or Not IsNumeric(e) Then 
				Response.End 
			End If 
		End Sub 

		Public Sub Auth_i_Numeric(e)
			If Not IsNumeric(e) Then 
				Response.End 
			End If 
		End Sub 

		Public Function Set_Order_Idx(gDBc, gRs)
			Dim order_id, order_master_idx : order_master_idx = Get_Sequency("ria_order_master_idx", gDBc, gRs)
			order_master_idx = 100000000000+order_master_idx
			order_id = "LTA9-"& CStr(order_master_idx) &"-"& set_pos(Month(Date)) &"M-"& Year(Date)

			Set_Order_Idx = order_id
		End Function 

		Public Function Set_User_Auth_Code(gDBc, gRs, gDate)
			Dim get_idx, gSql, sDate
			If IsDate(gDate) Then 
				sDate = gDate
			Else
				sDate = CStr(Date)
			End If 
			gSql = "select ISNULL(count(*), 0) from ria_order_master where reg_date>CAST('"& sDate &"')"
			gRs.Open gSql, gDBc, adOpenForwardOnly, adLockReadOnly, adCmdText
			If IsNull(gRs(0)) Then 
				get_idx = 0
			Else
				get_idx = CDbl(gRs(0))
			End If 
			get_idx = get_idx + 1
			gRs.Close()
			Set_User_Auth_Code = get_idx
		End Function 

		Public Function Send_SMS(toPhone, rePhone, toContent, reCompany, seq)

			On Error Resume Next 

			Dim SMD : Set SMD = Server.CreateObject("ADODB.Connection")
			SMD.Open Application("DBConnString")

			Dim m_date : m_date = Right(Year(Date), 2) & set_pos(Month(Date)) & set_pos(Day(Date)) & seq
			tSql = "insert into sms_wait (serialno, destcallno, callbackno, type, smsdata, subject) values('"& m_date &"', '"& toPhone &"', '"& rePhone &"', '1', '"& toContent &"', '"& reCompany &"')"
			SMD.Execute tSql
			SMD.Close()
			Set SMD = Nothing 

			If Err.Number <> 0 Then 
				Send_SMS = False 
			Else
				Send_SMS = True 
			End If 

		End Function 



		Public Sub Check_Monitor_Auth()
			If Len(Trim(monitor_key_)) < 1 Then 
				Response.Redirect "/recruit/monitor/monitor_intro.asp"
				Response.End 
			End If 
		End Sub 
















		Public Function Get_TotalPageCount(gTotalCount, gViewCount)
			Dim tCount
			If gTotalCount = 0 Then
				Get_TotalPageCount = 1
			Else
				If gTotalCount < gViewCount+1 Then
					Get_TotalPageCount = 1
				Else
					tCount = gTotalCount/gViewCount
					If gTotalCount Mod gViewCount > 0 Then
						tCount = tCount + 1
					End If
				End If
			End If
		End Function 

		Public Function Count_Page(gTotalCount, gDivCount)
			Dim ReturnVal, ModValue
			If gTotalCount = 0 Then 
				ReturnVal = 0
			Else
				ModValue = gTotalCount Mod gDivCount
				ReturnVal = CInt(gTotalCount/gDivCount)
				If ModValue > 0 Then ReturnVal = ReturnVal + 1
			End If 

			Count_Page = ReturnVal
		End Function 











		Public Sub Set_Content_ViewCount(ContentNumber, TableName, SysUserID, gDBc, gRs)
			Dim view_status, view_count : view_status = False  
			Dim gSql : gSql = "select count(*) from ria_view_count where content_number="& ContentNumber &" and sys_userid='"& SysUserID &"' "
			gRs.Open gSql, gDBc, adOpenForwardOnly, adLockReadOnly, adCmdText
			If IsNull(gRs(0)) Then 
				view_status = True  
			Else
				view_count = CInt(tRs(0))
				If view_count < 1 Then view_status = True 
			End If 
			gRs.Close()
			If view_status Then 
				gSql = "insert into ria_view_count (sys_userid, content_number, reg_date) values('"& SysUserID &"', "& ContentNumber &", sysdate)"
				gDBc.Execute gSql
				gSql = "update "& TableName &" set view_count=view_count+1 where content_number="& ContentNumber
				gDBc.Execute gSql
			End If 
		End Sub 

		Public Function Set_Content_ViewCount2(ContentNumber, TableName, SysUserID, gDBc, gRs)
			Dim view_status, view_count : view_status = False  
			Dim gSql : gSql = "select count(*) from ria_view_count where content_number="& ContentNumber &" and sys_userid='"& SysUserID &"' "
			gRs.Open gSql, gDBc, adOpenForwardOnly, adLockReadOnly, adCmdText
			If IsNull(gRs(0)) Then 
				view_status = True  
			Else
				view_count = CInt(tRs(0))
				If view_count < 1 Then view_status = True 
			End If 
			gRs.Close()
			If view_status Then 
				gSql = "insert into ria_view_count (sys_userid, content_number, reg_date) values('"& SysUserID &"', "& ContentNumber &", sysdate)"
				gDBc.Execute gSql
				gSql = "update "& TableName &" set view_count=view_count+1 where content_number="& ContentNumber
				gDBc.Execute gSql
			End If 
			Set_Content_ViewCount2 = view_status
		End Function 

		Public Function Set_Visit_Count(c_code, tRs, DBc)
			On Error Resume Next 

			Dim TodayDate,TodayHour,PageCodeName
			TodayDate						= formatdatetime(date(),2)
			TodayHour						= "H"&hour(now)
			PageCodeName						= Replace(c_code,"'","''")

			tSql = "SELECT "&TodayHour&" FROM RIA_VISIT_PAGEVIEW WHERE WDATE ='"&TodayDate&"' AND PAGENAME='"&PageCodeName&"' "
			tRs.Open tSql,DBc,adOpenStatic, adLockReadOnly, adCmdText

			IF tRs.EOF THEN
				tSql = "INSERT INTO RIA_VISIT_PAGEVIEW(WDATE,PAGENAME,"&TodayHour&") values('"&TodayDate&"','"&PageCodeName&"',1) "		
			ELSE 
				Dim PageCodeNameCount
				PageCodeNameCount			= CDbl(tRs(0))+1

				tSql = "UPDATE RIA_VISIT_PAGEVIEW SET "&TodayHour&" = "&PageCodeNameCount&" WHERE WDATE ='"&TodayDate&"' AND PAGENAME='"&PageCodeName&"' "
			END IF

			tRs.Close

			DBc.Execute tSql
			Set_Visit_Count = True 			
		End Function 






	'-------------------------------------------------
	' 한글(2Byte) 문자를 지원하는 Base64 decoder 함수
	' 회원정보를 디코딩하는데 사용한다.
	'-------------------------------------------------
	Public Function Base64Decode(str)
	Dim vDecode, i
	Dim vDecode1, vDecode2

		str = Ucase(str)
		For i = 1 to Len(str) step i + 2
			vDecode1 = Mid(str, i, 2)
			'16진수를 10진수로
			'첫째자리 십진수로 변환

			if Mid(Mid(str, i, 2), 1, 1) = "A" then
				vDecode1 = 10 * 16
			elseif Mid(Mid(str, i, 2), 1, 1) = "B" then
				vDecode1 = 11 * 16
			elseif Mid(Mid(str, i, 2), 1, 1) = "C" then
				vDecode1 = 12 * 16
			elseif Mid(Mid(str, i, 2), 1, 1) = "D" then
				vDecode1 = 13 * 16
			elseif Mid(Mid(str, i, 2), 1, 1) = "E" then
				vDecode1 = 14 * 16
			elseif Mid(Mid(str, i, 2), 1, 1) = "F" then
				vDecode1 = 15 * 16
			else
				vDecode1 = clng(Mid(Mid(str, i, 2), 1, 1)) * 16
			end if

			'둘째자리 십진수로 변환
			if Mid(Mid(str, i, 2), 2, 1) = "A" then
				vDecode2 = 10
			elseif Mid(Mid(str, i, 2), 2, 1) = "B" then
				vDecode2 = 11
			elseif Mid(Mid(str, i, 2), 2, 1) = "C" then
				vDecode2 = 12
			elseif Mid(Mid(str, i, 2), 2, 1) = "D" then
				vDecode2 = 13
			elseif Mid(Mid(str, i, 2), 2, 1) = "E" then
				vDecode2 = 14
			elseif Mid(Mid(str, i, 2), 2, 1) = "F" then
				vDecode2 = 15
			else
				vDecode2 = clng(Mid(Mid(str, i, 2), 2, 1))
			end if

			vDecode = vDecode & chr(vDecode1 + vDecode2)
		next

		Base64Decode = vDecode
	End Function

	'## 숫자형 데이터를 16진수화 인코딩
	'## 닷컴과 통신을 위한 인코드함수
	'## 전체 인코딩함수는 개발필요
	'Public Function ToHexStringCon(str)
	'	Dim hexStr
	'	Dim i
	'	Dim tmstr
	'	
	'	hexStr = ""
	'	tmstr = str
	'	IF LEN(tmstr)>0 THEN
	'		For i = 1 To Len(tmstr)
	'			tmhex = Mid(tmstr,i,1)
	'			hexStr = hexStr + Cstr(Hex(ASC(tmhex)))
	'		Next
	'	ELSE
	'		hexStr = tmstr
	'	END IF
	'	ToHexStringCon = hexStr 
	'End Function

		Function HexToString(pHex)
			Dim one_hex, tmp_hex, i, retVal
				for i = 1 to len(pHex)
					one_hex = mid(pHex,i,1)
					if IsNumeric(one_hex) then
						tmp_hex = mid(pHex,i,2)
						i = i + 1
					else
						tmp_hex = mid(pHex,i,4)
						i = i + 3
					end if
					retVal = retVal & chr("&H" & tmp_hex)        
				next
				HexToString = retVal
		End Function

		Public Function Make_Positon(e)
			Dim cvt_value : cvt_value = e
			If cvt_value = "" Or IsNull(cvt_value) Then 
				cvt_value = "00"
			Else
				cvt_value = CLng(cvt_value)
				If cvt_value < 10 Then 
					cvt_value = "0"& CStr(cvt_value)
				Else
					cvt_value = CStr(cvt_value)
				End If 
			End If 
			Make_Positon = cvt_value
		End Function 

		Public Sub Write_Logs(get_path, get_content)
			Dim objFso : Set objFso = CreateObject("Scripting.FileSystemObject")
			Dim logName
			logName = Year(Date) & Make_Positon(Month(Date)) & Make_Positon(Day(Date))
			logName = get_path &"\"& logName &".txt"
			Set objLog = objFso.OpenTextFile(logName, ForAppending, True)
			objLog.WriteLine (get_content)
			objLog.Close
			Set objLog = Nothing
			Set objFso = Nothing
		End Sub 








	End Class 	
%>