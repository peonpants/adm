<%

'
' 문자열 관련 함수 ( 문자열 길이, Type 등 ) 
' 
Class StringUtil


	Private Sub Class_initialize ()
	End Sub	
	
	Private Sub Class_terminate ()
	End Sub

	
	'-------------------------------------------
	' Text Check Code
	'-------------------------------------------

	Public Function IsEmptyStr(ByVal pStr)

		Dim fFlag
		
		If IsNull(pStr) or pStr = "" Then 
			fFlag = true
		Else
			fFlag = false
		End If

		IsEmptyStr = fFlag
 
	End Function


	'-------------------------------------------
	' Numeric Check Code
	'-------------------------------------------

	Public Function ExistIsNumeric(ByVal pNum)

		If IsNumeric(pNum) Then 
			IsTrue = True
		Else
			IsTrue = False
		End If

		ExistIsNumeric	= IsTrue
 
	End Function


	'-------------------------------------------
	' 패턴 체크 함수
	' Pattern("HANGUL", "abcd한글")과 같이 param을 넘기면 instr과 같이 한글이 있을 경우 true return
	'-------------------------------------------

	Public Function Pattern(pPattern, pStr)
	  Dim fObjReg, fRegPatte
	  Dim fRegPatten

	  Set fObjReg = new RegExp			' 정규식을 만듭니다.
	  
	  Select Case UCase(pPattern)
		Case "NUM"
		  fRegPatten	= "^[0-9]+$"											' 숫자만
		Case "PHONE"
			fRegPatten	= "^[0-9]{2,4}-[0-9]{3,4}-[0-9]{4}$"				    ' 전화번호 형식 : 033-1234-5678
		Case "MOBILE"  
            fRegPatten = "^01[016789]{1}(\-)?[0-9]{3,4}(\-)?[0-9]{4}$"          ' 핸드폰 형식 : 010-123-1234			
		Case "MAIL"
		  fRegPatten	= "^[_a-zA-Z0-9-]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$" '		' 메일
		Case "DOMAIN"
		  fRegPatten	= "^[.a-zA-Z0-9-]+.[a-zA-Z]+$"							' 영자 숫자와 . 다음도 영자
		Case "ENGNUM"
		  fRegPatten	= "^[a-zA-Z0-9]+$"										' 영자와 숫자만
		Case "ENG"
		  fRegPatten	= "^[a-zA-Z]+$"											' 영자만
		Case "HOST"
		  fRegPatten	= "^[a-zA-Z-]+$"										' 영자 와 '-'
		Case "HANGUL"
		  fRegPatten	= "[가-힣]"												' 한글인지
		Case "HANGULENG"
		  fRegPatten	= "[가-힣a-zA-Z]"										' 한글영어
		Case "HANGULENGNUM"
		  fRegPatten	= "[가-힣a-zA-Z0-9]"									' 한글영어숫자
		Case "HANGULONLY"
		  fRegPatten	= "^[가-힣]*$"											' 한글만
		Case "ID"
		  fRegPatten	= "^[a-zA-Z]{1}[a-zA-Z0-9_-]{4,15}$"					' 첫글자는 영자 그뒤엔 영어숫자 4이상 15자리 이하
		Case "DATE"
		  fRegPatten	= "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"						' 형식 : 2002-08-15
		Case "STATESTR"
		  fRegPatten	= "Y|N"													'Y또는N
		Case "STATENUM"
		  fRegPatten	= "^0|1$"												'0or1 상태값
		Case "ANSWERNUM"
		  fRegPatten	= "^0|1|2|3$"											'답변 상태값
        Case "NAME"            
		    fRegPatten = "^[가-힣]{2,6}$"                                       '한글 이름(2~6자로 간주한다.)
	  End Select


	  fObjReg.Pattern		= fRegPatten											' 패턴을 설정합니다.
	  fObjReg.IgnoreCase	= True											' 대/소문자를 구분하지 않도록 설정합니다.
	  fObjReg.Global		= True											' 전역 적용을 설정합니다.
	  
	  Pattern			= fObjReg.Test(pStr&"" )							' 찾기를 실행합니다.

	End Function
	
	
	'-------------------------------------------
	' 문자열의 길이를 가지고 온다..
	' 문자열변수가 비었을 경우 길이로 0을 반환 한다.
	'-------------------------------------------

	Public Function LenStr(ByVal pStr)

		
		If  IsNull(pStr) or pStr = "" Then 
			Response.Write ("dsfasdf")
			LenStr = 0
		Else
			LenStr = Len(pStr)
		End If
 
	End Function

	
	
	'
	' 문자열의 Byte수를 가져온다... 한글및 기타 문자  2Byte 취급 
	'

	Function LenByte(ByVal pStr)

		Dim i, fChar, fLen
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' 한 글자씩 끊어 온다

				If Asc(fChar) < 0 Then	' asc 값이 0보다 작으면 한글, 한문 혹은 한글 특수문자.
					fLen = fLen + 2
				Else
					fLen = fLen + 1
				End If
			Next
			
			LenByte = fLen
			
		End If 
		
		
	End Function


	'
	' 문자열의 Byte수를 가져온다... 한글및 기타 문자  2Byte 취급 
	'

	Function LenCheck(ByVal pStr, ByVal pMaxSize)

		Dim i, fChar, fLen
		Dim isTrue
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' 한 글자씩 끊어 온다

				If Asc(fChar) < 0 Then	' asc 값이 0보다 작으면 한글, 한문 혹은 한글 특수문자.
					fLen = fLen + 2
				Else
					fLen = fLen + 1
				End If
			Next
			
			'LenByte = fLen
			
		End If 

		If Not IsNumeric(pMaxSize) Then
			isTrue = False
		End If

		If fLen > pMaxSize Then
			isTrue	= False
		End If

		LenCheck	= isTrue
		
	End Function

	'-------------------------------------------
	' ReplaceFrom
	'-------------------------------------------
	Public Function ReplaceFrom(ByVal pStr)


		pStr		= Replace(pStr,"<","&lt;")
		pStr		= Replace(pStr,">","&gt;")

		ReplaceFrom	=  pStr
 
	End Function

	'-------------------------------------------
	' ReplaceTo
	'-------------------------------------------
	Public Function ReplaceTo(ByVal pStr)


		pStr		= Replace(pStr,"&lt;","<")
		pStr		= Replace(pStr,"&gt;",">")

		ReplaceTo	=  pStr
 
	End Function


    ' 정해진 길이를 초과할경우 정해진 길이 만큼 문자열을 잘라서 반환
    ' param :	int		pMaxLen	: 최대 허용 길이
    '			string	pName	: 문자열
    Public Function GetShortString(pName, pMaxLen, pMark)
    	
	    IF Len(pName) > pMaxLen Then
		    GetShortString = Left(pName, pMaxLen-1) & pMark
	    Else
		    GetShortString = pName
	    End IF

    End Function
    
    
    ' 정해진 길이를 초과할경우 정해진 길이 만큼 문자열을 잘라서 반환(Byte단위)
    ' param :	int		pMaxLen	: 최대 허용 길이(Byte 단위)
    '			string	pName	: 문자열
    Public Function GetShortStringByte(pName, pMaxLen, pMark)
    	
	    Dim fNI, fByte, fRet, fLit
	    Dim fMaxLen

        If LenByte(pName) > pMaxLen Then
	        for fNI = 0 to Len (pName) - 1
		        fLit	= mid (pName, fNI + 1, 1)
		        fRet	= fRet & fLit
		        fByte	= fByte + 1
    		    
		        if Asc (fLit) < 0 then	fByte = fByte + 1

		        if fByte >= pMaxLen-2 then
			        if fByte > pMaxLen AND Asc (fLit) < 0 then
				        fRet = mid (fRet, 1, Len (fRet) - 1)
			        end if
    			    
			        fRet = fRet & pMark
			        exit for
		        end if
	        next
	        
    	    GetShortStringByte = fRet	    
        Else
            GetShortStringByte = pName
        End If
	    

    End Function    


    '----------------------------------------------------------------------
    'Desc      : String -> DEC
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function GetStrToDec(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(32), "&nbsp;")
          fTmp = replace(fTmp, """", "&#34;")
          fTmp = replace(fTmp, "%", "&#37;")
          fTmp = replace(fTmp, "'", "&#39;")
          'fTmp = replace(fTmp, "<", "&#60;")
          'fTmp = replace(fTmp, ">", "&#62;")
          fTmp = replace(fTmp, "<", "&lt;")
          fTmp = replace(fTmp, ">", "&gt;")
          fTmp = replace(fTmp, "(", "&#40;")
          fTmp = replace(fTmp, ")", "&#41;")
        End IF
        GetStrToDec = fTmp
    End Function
    
    '----------------------------------------------------------------------
    'Desc      : DEC -> String 
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function GetDecToStr(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, "&nbsp;", chr(32))
          fTmp = replace(fTmp, "&#34;", """")
          fTmp = replace(fTmp, "&#37", "%")
          fTmp = replace(fTmp, "&#39;", "'")
          'fTmp = replace(fTmp, "&#60;", "<")
          'fTmp = replace(fTmp, "&#62;", ">")
          fTmp = replace(fTmp, "&lt;", "<")
          fTmp = replace(fTmp, "&gt;", ">")
          fTmp = replace(fTmp, "&#40;", "(")
          fTmp = replace(fTmp, "&#41;", ")")
        End IF
        GetDecToStr = fTmp
    End Function
    
    
    '----------------------------------------------------------------------
    'Desc      : nl2br
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function Getnl2br(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(13)&chr(10), "<br>")
        End IF
        Getnl2br = fTmp
    End Function
    
    '----------------------------------------------------------------------
    'Desc      : nl2nbsp
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function Getnl2nbsp(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(13)&chr(10), "&nbsp;")
        End IF
        F_nl2nbsp = fTmp
    End Function    

	Public Function F_initNumericParam(strParam, nDefault, nMinVal, nMaxVal)

		Dim nRtnVal
		If not IsNumeric(strParam) Then
		        nRtnVal = nDefault
		Else
		        nRtnVal = Int(strParam)
		        If nRtnVal < nMinVal Then nRtnVal = nDefault
		        If nRtnVal > nMaxVal Then nRtnVal = nDefault
		End If

		F_initNumericParam = nRtnVal

	End Function    

	Public Function GetFullDate(dt)
        
        Dim rtnVal
            				
        rtnVal = right("000" & year(dt)  , 4) & "-" & _		    
        right("0" & month(dt) , 2) & "-" & _
        right("0" & day(dt) , 2) & " " & _
        right("0" & hour(dt), 2) & ":" & _
        right("0" & minute(dt), 2)			

        GetFullDate = rtnVal
	
	End Function 
		
	Public Function GetStartDate(dt)
        
        Dim rtnVal
            				
        rtnVal = right("000" & year(dt)  , 4) & "-" & _		    
        right("0" & month(dt) , 2) & "-" & _
        right("0" & day(dt) , 2) & " " & _
        right("0" & hour(dt), 2) & ":00" 
        		

        GetStartDate = rtnVal
	
	End Function 
'리그추가로 추가됨(soso150302)
    Function GetLeagueImage(pRL_Image)
            Dim rtnValue
            IF inStr(pRL_Image,"http") = 0  Then 
                rtnValue  = "/League/" & pRL_Image 
            Else
                rtnValue  = pRL_Image 
            End IF    
            GetLeagueImage = rtnValue
    End Function

    Public Function getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap)
	    SELECT CASE cStr(IG_TYPE) 
	    CASE "0" '승무패
            IF Cdbl(IG_DrawBenefit) < 1 THEN	'// 농구경기등....무승부가 없는경기...(무의 배당율이 0일때...)
                team2Input = "<span class='red'>VS</span>"
            ELSE
                team2Input = IG_DrawBenefit
            END IF			        
	    CASE "1" '핸디캡
            IF IG_Handicap = "0" Then
                team2Input = "<span class='red'>VS</span>"
            Else
	            IF IG_Handicap < 0 THEN 
                    team2Input = "(" & IG_Handicap & ")"
                ELSE
                    team2Input = "(+" & IG_Handicap & ")"
                END IF
            End IF
	    CASE "2" '오버언더
	        team2Input = IG_Handicap     		
	    END SELECT
	    getDrawValue =  team2Input
			        
    End Function 
    			
End Class


Dim dfStringUtil 
Set dfStringUtil = new StringUtil
%>