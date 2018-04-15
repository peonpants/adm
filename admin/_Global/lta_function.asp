<%
	Function SqlFilter(e)
		Dim str_search(5), str_replace(5), cnt, data
		str_search(0) = "'"
		str_search(1) = """"
		str_search(2) = "\"
		str_search(3) = "#"
		str_search(4) = "--"
		str_search(5) = ";"

		str_replace(0) = "''"
		str_replace(1) = """"""
		str_replace(2) = "\\"
		str_replace(3) = "\#"
		str_replace(4) = "\--"
		str_replace(5) = "\;"

		data = e
		For cnt = 0 to 5
			data = replace(data, LCase(str_search(cnt)), str_replace(cnt))
		Next
		SqlFilter = data
	End Function 

	Function ResetString(str, cutLen)
		Dim strLen, strByte, strCut, strRes, char, i
		strLen = 0 : strByte = 0 : strLen = Len(str)
		If IsNull(str) Then str = ""
		If IsNull(strLen) Then strLen = 0
		For i = 1 To strLen
			char = ""
			strCut = Mid(str, i, 1)	
			char = Asc(strCut)		
			char = Left(char, 1)
			If char = "-" Then	
				strByte = strByte + 2.3
			Else 
				strByte = strByte + 1
			End If 
			If cutLen < strByte Then 
				strRes = strRes & ".."
				Exit For 
			Else 
				strRes = strRes & strCut
			End If 
		Next 
		ResetString = strRes
	End Function

	Function useText(CheckValue)
		If IsNull(CheckValue) Then CheckValue = ""
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "''")
		useText = CheckValue
	End Function

	Function UseReText(CheckValue)
		CheckValue = replace(CheckValue, "&amp" , "&;")
		CheckValue = replace(CheckValue, "&lt;", "<")
		CheckValue = replace(CheckValue, "&gt;", ">")
		CheckValue = replace(CheckValue, "''", "'")
		UseReText = CheckValue
	End Function

	Function ReplaceDblQuota(CheckValue)
		ReplaceDblQuota = Replace(CheckValue, " ", "")
		ReplaceDblQuota = Replace(CheckValue, Chr(34), "&#34;")
	End Function 

	Function ReplaceOnlyDblQuota(CheckValue)
		If IsNull(CheckValue) Then CheckValue = ""
		ReplaceOnlyDblQuota = Replace(CheckValue, Chr(34), "&#34;")
	End Function 

	Function ReplaceSglQuota(CheckValue)
'		ReplaceSglQuota = Replace(CheckValue, " ", "")
		ReplaceSglQuota = Replace(CheckValue, "'", "''")
	End Function 
	
	Function ReplaceBlank(CheckValue)
		If IsNull(CheckValue) Then CheckValue = ""
		ReplaceBlank = Replace(CheckValue, " ", "")
	End Function 

	Function ReplaceContents(CheckValue)
		If IsNull(CheckValue) Then CheckValue = ""
		ReplaceContents = Replace(CheckValue, "'", "''")
	End Function 

	'_ 차후 삭제 예정 (?)
	Function Content_Listing(cur_page, dis_count)
		Dim rtn_count(1)
		rtn_count(0) = ((page-1)*dis_count)+1
		rtn_count(1) = page*dis_count
		Content_Listing = rtn_count
	End Function 

	Function Content_Numbering(cur_page, dis_count, total_count)
		On Error Resume Next 
		Content_Numbering = total_count - (cur_page-1)*dis_count
		If Err.Number <> 0 Then 
			Content_Numbering = 0
		End If 
	End Function 
	

	Function Validation_Number(e, pos, flag)
		Dim ce : ce = Trim(e)
		If IsNumeric(ce) Then 
			If flag Then 
				If CLng(e) < pos Then 
					Validation_Number = True 
				Else
					Validation_Number = False  
				End If 
			Else 
				Validation_Number = True 
			End If 
		Else
			Validation_Number = False 
		End If 
	End Function 

'	Function Validation_String(e, pos, type)
'	End Function 

	Function Get_Page_Info(getPage, getTotalCount, getPageCount)
		Dim top_cnt, remain_cnt, all_cnt, page_cnt
		Dim cnt_info(2)
		remain_cnt = Cint(getTotalCount Mod getPageCount)
		page_cnt = Int(getTotalCount / getPageCount)
		all_cnt = getPageCount * getPage
		top_cnt = getPageCount
		If remain_cnt > 0 Then page_cnt = page_cnt + 1
		If (Clng(getPage) = Clng(page_cnt)) And remain_cnt > 0 Then top_cnt = remain_cnt
		cnt_info(0) = page_cnt : cnt_info(1) = all_cnt : cnt_info(2) = top_cnt
		Get_Page_Info = cnt_info
	End Function 

	Function set_pos(e)
		Dim c_date : c_date = e
		If c_date = "" Or IsNull(c_date) Then 
			c_date = "00"
		Else
			c_date = CLng(c_date)
			If c_date < 10 Then 
				c_date = "0"& CStr(c_date)
			Else
				c_date = CStr(c_date)
			End If 
		End If 
		set_pos = c_date
	End Function 

	Function Get_Shop_Flag(e)
		If e = "C" Then 
			Get_Shop_Flag = "가맹점"
		ElseIf e = "D" Then 
			Get_Shop_Flag = "직영점"
		Else
			Get_Shop_Flag = ""
		End If 
	End Function 

	Function Set_MarkStar(make_star, empty_star, get_score)
		Dim tmp_star, xs
		For xs = 2 To 10 Step 2
			If xs <= get_score Then 
				tmp_star = tmp_star & make_star
			Else
				tmp_star = tmp_star & empty_star
			End If 
		Next 
		Set_MarkStar = tmp_star
	End Function 

	Function Get_SaleStatus(e)
		If e = "Y" Then 
			Get_SaleStatus = "판매중"
		ElseIf e = "N" Then 
			Get_SaleStatus = "품절"
		End If 
	End Function 

	Function Get_Party_Type(e)
		If IsNull(e) Then 
			Get_Party_Type = "-"
		ElseIf e = "A" Then 
			Get_Party_Type = "로디형"
		ElseIf e = "B" Then 
			Get_Party_Type = "로이형"
		End If 
	End Function
	
	Function Get_Order_Status(e)
		If e="" Then Exit Function 
		Select Case e
			Case "00":
				Get_Order_Status = "주문완료"
			Case "11":
				Get_Order_Status = "결제확인"
			Case "20":
				Get_Order_Status = "배송준비중"
			Case "21":
				Get_Order_Status = "배송중"
			Case "22":
				Get_Order_Status = "배송완료"
			Case "44":
				Get_Order_Status = "주문취소"'(영업부)"
			Case "45":
				Get_Order_Status = "주문취소"'(고객이 직접)"
'			Case "55":
'				Get_Order_Status = "예약구매"
			Case "66":
				Get_Order_Status = "반품요청"
			Case "67":
				Get_Order_Status = "환불완료"
			Case "99":
				Get_Order_Status = "삭제"
		End Select
	End Function

	Function Get_rtpgResource(e)
		Select Case e
			Case "11":
				Get_rtpgResource = "카드"
			Case "22":
				Get_rtpgResource = "무통장"
			Case "23":
				Get_rtpgResource = "계좌이체"
			Case "88" : 
				Get_rtpgResource = "포인트"
			Case Else 
				Get_rtpgResource = ""
		End Select
	End Function

	Function get_bank_name(e)
		Select Case e
			Case  "04" : get_bank_name = "국민은행"
			Case  "11" : get_bank_name = "농협(중앙)"
			Case  "26" : get_bank_name = "신한은행"
			Case  "20" : get_bank_name = "우리은행"
			Case  "23" : get_bank_name = "제일은행"
			Case  "03" : get_bank_name = "중소기업은행"
			Case  "88" : get_bank_name = "신한은행"
			Case  "48" : get_bank_name = "신용협동조합"
			Case  "53" : get_bank_name = "시티은행"
			Case  "81" : get_bank_name = "하나은행"
			Case  "21" : get_bank_name = "조흥은행"
			Case  "05" : get_bank_name = "외환은행"
			Case  "39" : get_bank_name = "경남은행"
			Case  "31" : get_bank_name = "대구은행"
			Case  "35" : get_bank_name = "제주은행"
			Case  "12" : get_bank_name = "단위농협"
			Case  "06" : get_bank_name = "국민은행(구:주택은행)"
			Case  "27" : get_bank_name = "한미은행"
			Case  "37" : get_bank_name = "전북은행"
			Case  "71" : get_bank_name = "우체국"
			Case  "25" : get_bank_name = "서울은행"
			Case  "07" : get_bank_name = "수협"
			Case  "32" : get_bank_name = "부산은행"
			Case  "45" : get_bank_name = "새마을금고"
			Case  "34" : get_bank_name = "광주은행"
		End Select 
	End Function 

	Function get_card_name(e)
		Select Case e
			Case "CHB" : get_card_name = "조흥은행"
			Case "KJB" : get_card_name = "신한은행"
			Case "SHB" : get_card_name = "신한은행"
			Case "KEC" : get_card_name = "외환카드"
			Case "JBB" : get_card_name = "전북은행"
			Case "JJB" : get_card_name = "제주은행"
			Case "KMC", "KMF" : get_card_name = "국민카드"
			Case "SUH" : get_card_name = "수형"
			Case "CHH" : get_card_name = "농협(축협)"
			Case "HMB" : get_card_name = "한미은행"
			Case "PHB" : get_card_name = "우리(평화,한빛) 은행"
			Case "SSCP" : get_card_name = "삼성캐피탈"
			Case "KTF" : get_card_name = "KTF 전자상품권"
			Case "KWP" : get_card_name = "KT 월드패스"
			Case "BCC", "BCF" : get_card_name = "BC 카드사"
			Case "HDC", "HDF" : get_card_name = "현대 카드사"
			Case "LGC", "LGF" : get_card_name = "LG 카드사"
			Case "SSC", "SSF" : get_card_name = "삼성 카드사"
			Case "HHD" : get_card_name = "인천정유"
			Case "SWD" : get_card_name = "신원"
			Case "HYD" : get_card_name = "한양 유통"
			Case "CTB" : get_card_name = "씨티 은행"
			Case "SMC" : get_card_name = "SK 모네타 캐시"
			Case "LGJ" : get_card_name = "LG 정유"
			Case "HDD" : get_card_name = "현대 백화점"
			Case "KRD" : get_card_name = "코오롱"
			Case "SKM" : get_card_name = "SK 모네타 모네타 상품권"
			Case "LES" : get_card_name = "여가문화 상품권"
			Case "SKT" : get_card_name = "SK Telecom 카드"
			Case "AGP" : get_card_name = "농협 전자상품권"
			Case "LDCARD" : get_card_name = "신롯데 카드사"
			Case "AMX" : get_card_name = "롯데(동양) 카드사"
		End Select 
	End Function 

	Function useLineReplace(e)
		useLineReplace = Replace(e,Chr(13),"<br>")
	End Function

	Function OutVAT(gSum)

		Dim rtn_value(2)
		'_ 총금액, 부가세, 봉사료
		Dim t_sum, o_sum, v_sum, s_sum : s_sum = 0
		t_sum = gSum
		v_sum = (t_sum/11)
		o_sum = v_sum*10

		If InStr(CStr(o_sum), ".")>0 Then 
			o_sum = Fix(o_sum)+1
		End If 

		rtn_value(0) = o_sum
		rtn_value(1) = Fix(v_sum)
		rtn_value(2) = 0

		OutVAT = rtn_value
	End Function 




	'_ 포인트 -----------------------------
	Function Get_Point_Cause(e)
		If e = "S" Then 
			Get_Point_Cause = "적립"
		ElseIf e = "U" Then 
			Get_Point_Cause = "사용"
		ElseIf e = "D" Then
			Get_Point_Cause = "적립취소"
		ElseIf e = "C" Then
			Get_Point_Cause = "사용취소"
		End If 
	End Function 

function XSS_T( get_String)

   'get_String = REPLACE( get_String, "&", "&amp;" )
   'get_String = REPLACE( get_String, "&amp;nbsp;", "&nbsp;" )

   get_String = REPLACE( get_String, "<xmp", "<x-xmp", 1, -1, 1 )
   get_String = REPLACE( get_String, "javascript", "x-javascript", 1, -1, 1 )
   get_String = REPLACE( get_String, "script", "x-script", 1, -1, 1 )
   get_String = REPLACE( get_String, "iframe", "x-iframe", 1, -1, 1 )
   get_String = REPLACE( get_String, "document", "x-document", 1, -1, 1 )
   get_String = REPLACE( get_String, "vbscript", "x-vbscript", 1, -1, 1 )
   get_String = REPLACE( get_String, "applet", "x-applet", 1, -1, 1 )
   get_String = REPLACE( get_String, "embed", "x-embed", 1, -1, 1 )
   get_String = REPLACE( get_String, "object", "x-object", 1, -1, 1 )
   get_String = REPLACE( get_String, "frame", "x-frame", 1, -1, 1 )
   get_String = REPLACE( get_String, "frameset", "x-frameset", 1, -1, 1 )
   get_String = REPLACE( get_String, "layer", "x-layer", 1, -1, 1 )
   get_String = REPLACE( get_String, "bgsound", "x-bgsound", 1, -1, 1 )
   get_String = REPLACE( get_String, "alert", "x-alert", 1, -1, 1 )

   get_String = REPLACE( get_String, "onblur", "x-onblur", 1, -1, 1 )
   get_String = REPLACE( get_String, "onchange", "x-onchange", 1, -1, 1 )
   get_String = REPLACE( get_String, "onclick", "x-onclick", 1, -1, 1 )
   get_String = REPLACE( get_String, "ondblclick", "x-ondblclick", 1, -1, 1 )
   get_String = REPLACE( get_String, "onerror", "x-onerror", 1, -1, 1 )
   get_String = REPLACE( get_String, "onfocus", "x-onfocus", 1, -1, 1 )
   get_String = REPLACE( get_String, "onload", "x-onload", 1, -1, 1 )
   get_String = REPLACE( get_String, "onmouse", "x-onmouse", 1, -1, 1 )
   get_String = REPLACE( get_String, "onscroll", "x-onscroll", 1, -1, 1 )
   get_String = REPLACE( get_String, "onsubmit", "x-onsubmit", 1, -1, 1 )
   get_String = REPLACE( get_String, "onunload", "x-onunload", 1, -1, 1 )

   'if not get_HTML then
   '   get_String = REPLACE( get_String, "<", "&lt;" )
   '   get_String = REPLACE( get_String, ">", "&gt;" )
   'end if
	
	XSS_T = get_String
	'XSS_T = SQL_Injection_T(XSS_T)
	'XSS_T = htmlspecialchars(XSS_T)
end Function

function SQL_Injection_T( get_String )

   get_String = REPLACE( get_String, "'", "''" )
   'get_String = REPLACE( get_String, ";", "" )
   get_String = REPLACE( get_String, "--", "" )
   get_String = REPLACE( get_String, "select", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "insert", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "update", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "delete", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "drop", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "union", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "and", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "or", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "1=1", "", 1, -1, 1 )

   get_String = REPLACE( get_String, "sp_", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "xp_", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "@variable", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "@@variable", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "exec", "", 1, -1, 1 )
   get_String = REPLACE( get_String, "sysobject", "", 1, -1, 1 )

   SQL_Injection_T = get_String

end Function

Function htmlspecialchars(sStr)

 htmlspecialchars = Replace( sStr, "&", "&amp;" )
 htmlspecialchars = Replace( htmlspecialchars, ">", "&gt;" )
 htmlspecialchars = Replace( htmlspecialchars, "<", "&lt;" )
 htmlspecialchars = Replace( htmlspecialchars, """", "&quot;" )
 htmlspecialchars = Replace( htmlspecialchars, "'", "&#039;" )

End Function

Function viewstr(sStr)

 viewstr = Replace( sStr, "&amp;", "&" )
 viewstr = Replace( viewstr, "&gt;", ">" )
 viewstr = Replace( viewstr, "&lt;", "<" )
 viewstr = Replace( viewstr, "&quot;", """" )
 viewstr = Replace( viewstr, "&#039;", "'" )
 'viewstr = Replace( viewstr, "&amp;nbsp;", "&nbsp;" )
 'viewstr = Replace( viewstr, "&nbsp;", "" )
 'viewstr = Replace( viewstr, "<br>&nbsp;", "" )
 'viewstr = Replace( viewstr, "<br>", "" )
End Function


%>