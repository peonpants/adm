<%

'
' ���ڿ� ���� �Լ� ( ���ڿ� ����, Type �� ) 
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
	' ���� üũ �Լ�
	' Pattern("HANGUL", "abcd�ѱ�")�� ���� param�� �ѱ�� instr�� ���� �ѱ��� ���� ��� true return
	'-------------------------------------------

	Public Function Pattern(pPattern, pStr)
	  Dim fObjReg, fRegPatte
	  Dim fRegPatten

	  Set fObjReg = new RegExp			' ���Խ��� ����ϴ�.
	  
	  Select Case UCase(pPattern)
		Case "NUM"
		  fRegPatten	= "^[0-9]+$"											' ���ڸ�
		Case "PHONE"
			fRegPatten	= "^[0-9]{2,4}-[0-9]{3,4}-[0-9]{4}$"				    ' ��ȭ��ȣ ���� : 033-1234-5678
		Case "MOBILE"  
            fRegPatten = "^01[016789]{1}(\-)?[0-9]{3,4}(\-)?[0-9]{4}$"          ' �ڵ��� ���� : 010-123-1234			
		Case "MAIL"
		  fRegPatten	= "^[_a-zA-Z0-9-]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$" '		' ����
		Case "DOMAIN"
		  fRegPatten	= "^[.a-zA-Z0-9-]+.[a-zA-Z]+$"							' ���� ���ڿ� . ������ ����
		Case "ENGNUM"
		  fRegPatten	= "^[a-zA-Z0-9]+$"										' ���ڿ� ���ڸ�
		Case "ENG"
		  fRegPatten	= "^[a-zA-Z]+$"											' ���ڸ�
		Case "HOST"
		  fRegPatten	= "^[a-zA-Z-]+$"										' ���� �� '-'
		Case "HANGUL"
		  fRegPatten	= "[��-�R]"												' �ѱ�����
		Case "HANGULENG"
		  fRegPatten	= "[��-�Ra-zA-Z]"										' �ѱۿ���
		Case "HANGULENGNUM"
		  fRegPatten	= "[��-�Ra-zA-Z0-9]"									' �ѱۿ������
		Case "HANGULONLY"
		  fRegPatten	= "^[��-�R]*$"											' �ѱ۸�
		Case "ID"
		  fRegPatten	= "^[a-zA-Z]{1}[a-zA-Z0-9_-]{4,15}$"					' ù���ڴ� ���� �׵ڿ� ������� 4�̻� 15�ڸ� ����
		Case "DATE"
		  fRegPatten	= "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"						' ���� : 2002-08-15
		Case "STATESTR"
		  fRegPatten	= "Y|N"													'Y�Ǵ�N
		Case "STATENUM"
		  fRegPatten	= "^0|1$"												'0or1 ���°�
		Case "ANSWERNUM"
		  fRegPatten	= "^0|1|2|3$"											'�亯 ���°�
        Case "NAME"            
		    fRegPatten = "^[��-�R]{2,6}$"                                       '�ѱ� �̸�(2~6�ڷ� �����Ѵ�.)
	  End Select


	  fObjReg.Pattern		= fRegPatten											' ������ �����մϴ�.
	  fObjReg.IgnoreCase	= True											' ��/�ҹ��ڸ� �������� �ʵ��� �����մϴ�.
	  fObjReg.Global		= True											' ���� ������ �����մϴ�.
	  
	  Pattern			= fObjReg.Test(pStr&"" )							' ã�⸦ �����մϴ�.

	End Function
	
	
	'-------------------------------------------
	' ���ڿ��� ���̸� ������ �´�..
	' ���ڿ������� ����� ��� ���̷� 0�� ��ȯ �Ѵ�.
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
	' ���ڿ��� Byte���� �����´�... �ѱ۹� ��Ÿ ����  2Byte ��� 
	'

	Function LenByte(ByVal pStr)

		Dim i, fChar, fLen
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' �� ���ھ� ���� �´�

				If Asc(fChar) < 0 Then	' asc ���� 0���� ������ �ѱ�, �ѹ� Ȥ�� �ѱ� Ư������.
					fLen = fLen + 2
				Else
					fLen = fLen + 1
				End If
			Next
			
			LenByte = fLen
			
		End If 
		
		
	End Function


	'
	' ���ڿ��� Byte���� �����´�... �ѱ۹� ��Ÿ ����  2Byte ��� 
	'

	Function LenCheck(ByVal pStr, ByVal pMaxSize)

		Dim i, fChar, fLen
		Dim isTrue
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' �� ���ھ� ���� �´�

				If Asc(fChar) < 0 Then	' asc ���� 0���� ������ �ѱ�, �ѹ� Ȥ�� �ѱ� Ư������.
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


    ' ������ ���̸� �ʰ��Ұ�� ������ ���� ��ŭ ���ڿ��� �߶� ��ȯ
    ' param :	int		pMaxLen	: �ִ� ��� ����
    '			string	pName	: ���ڿ�
    Public Function GetShortString(pName, pMaxLen, pMark)
    	
	    IF Len(pName) > pMaxLen Then
		    GetShortString = Left(pName, pMaxLen-1) & pMark
	    Else
		    GetShortString = pName
	    End IF

    End Function
    
    
    ' ������ ���̸� �ʰ��Ұ�� ������ ���� ��ŭ ���ڿ��� �߶� ��ȯ(Byte����)
    ' param :	int		pMaxLen	: �ִ� ��� ����(Byte ����)
    '			string	pName	: ���ڿ�
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
'�����߰��� �߰���(soso150302)
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
	    CASE "0" '�¹���
            IF Cdbl(IG_DrawBenefit) < 1 THEN	'// �󱸰���....���ºΰ� ���°��...(���� ������� 0�϶�...)
                team2Input = "<span class='red'>VS</span>"
            ELSE
                team2Input = IG_DrawBenefit
            END IF			        
	    CASE "1" '�ڵ�ĸ
            IF IG_Handicap = "0" Then
                team2Input = "<span class='red'>VS</span>"
            Else
	            IF IG_Handicap < 0 THEN 
                    team2Input = "(" & IG_Handicap & ")"
                ELSE
                    team2Input = "(+" & IG_Handicap & ")"
                END IF
            End IF
	    CASE "2" '�������
	        team2Input = IG_Handicap     		
	    END SELECT
	    getDrawValue =  team2Input
			        
    End Function 
    			
End Class


Dim dfStringUtil 
Set dfStringUtil = new StringUtil
%>