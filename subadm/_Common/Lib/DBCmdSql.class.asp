<%
' DB Query 생성및 실행 관련 Class 
' 
class DBCmdSql

	
	
	private mCmd	      ' Command 객체 변수 
	private mPreQuery	  ' SQL쿼리문 저장변수
		  
	public mResultSet     ' ResultSet Dictionary 변수 
	public mTmpResultSet  ' Return요 ResultSet Dic 변수 
	public mAffected	  ' Execut나 Patch 시 옵션 변수 
	
	
	
	' 
	' @name Class_initalalize()
	' @desc class 생성시 멤버 값을 초기화 한다. 
	' 
	private sub Class_initialize ()	
		set mResultSet = nothing
		set mTmpResultSet = nothing
		set mCmd	= nothing
		mAffected = null
	end sub
	
	'  
	' @name Init(0 
	' @desc ADO Command 객체를 생성하고, 옵션 값을 지정한다. 
	'
	
	private sub Init ()
		
		
		if IsObject( mCmd ) Then
			Set mCmd = CreateObject("ADODB.Command")
		end If

		mCmd.Prepared = true
		mCmd.CommandTimeout = 30 
		
		'mSql = ""
	
	
	end sub
	'
	' @name Class_terminate() 
	' @desc 클래스 소멸자, 사용하던 변수를 Reset 한다. 
	'
	private sub Class_terminate ()
		set mCmd	= nothing
		set mResultSet = nothing
		
	end sub
	
	
	'
	' @name Query(pQuery) Property 
	' @desc 일반 Sql Query를 Command Object 에 Setting 한다. 
	' @param pQuery String  Sql Query 문장 
	'
	public property let Query (pQuery)
	
		Init()
		mPreQuery = pQuery
		mCmd.CommandText = mPreQuery
		mCmd.Commandtype = adCmdText
	end property
		
	'
	' @name StoredProc(pQuery) Property 
	' @desc Stored Procedure 문을 Command Object 에 Setting 한다. 
	' @param pQuery String   Query 문장 
	'
	public property let StoredProc (pQuery)
		Init()
		mPreQuery = pQuery
		mCmd.CommandText = mPreQuery
		mCmd.Commandtype = adCmdStoredProc
	end property
	
	
	'
	' @name SetparamDecimal( pPos, pVal ) 
	' @desc Decimal 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetparamDecimal (pPos, pVal)
		
		If IsNull(pVal) or Len(pVal) = 0 Then 
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adDecimal, adParamInput, 1 , "")
			mCmd.Parameters("@InParam"&pPos).Precision    = 28
			mCmd.Parameters("@InParam"&pPos).NumericScale = 20
		Else
			
   	  		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adDecimal, adParamInput, len(pVal)*2, pVal)
   	  		mCmd.Parameters("@InParam"&pPos).Precision    = 28
			mCmd.Parameters("@InParam"&pPos).NumericScale = 20
    	End If
	end function
	
	
	'
	' @name SetparamWChar( pPos, pVal ) 
	' @desc NVarchar 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamWChar (pPos, pVal)
		
		If IsNull(pVal) or Len(pVal) = 0 Then 
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adWChar, adParamInput, 1 , "")
			'mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarWChar, adParamInput, 1 , "")
		Else
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adWChar, adParamInput, len(pVal)*2, pVal)
			'mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarWChar, adParamInput, len(pVal)*2, pVal)
    	End If
	end function
	
	'
	' @name SetparamWChar( pPos, pVal ) 
	' @desc NVarchar 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamVarWChar (pPos, pVal)		
		If IsNull(pVal) or Len(pVal) = 0 Then 
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarWChar, adParamInput, 1 , "")
		Else
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarWChar, adParamInput, len(pVal)*2, pVal)
    	End If
	end function
		
	'
	' @name SetparamVChar( pPos, pVal ) 
	' @desc Varchar 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamVChar (pPos, pVal)

		If IsNull(pVal) or Len(pVal) = 0 Then 
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarChar, adParamInput, 1 , "")
		Else
   	  		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adVarChar, adParamInput, len(pVal)*2, pVal)
    	End If
	end function
	
	'
	' @name SetparamText( pPos, pVal ) 
	' @desc text 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamText (pPos, pVal)
		
		If IsNull(pVal) or Len(pVal) = 0 Then 
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adWChar, adParamInput, 1 , "")
		Else
   	  		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adWChar, adParamInput, len(pVal)*2, pVal)
    	End If
	end function
	
	
	'
	' @name SetparamChar( pPos, pVal ) 
	' @desc Char 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	
	public function SetParamChar (pPos, pVal)
		If IsNull( pVal ) Then 		
			mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adChar, adParamInput, 1, pVal)
   	 	Else
   	 		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adChar, adParamInput, len(pVal)*2, pVal)
   	 	End If
    
	End function
	
	'
	' @name SetparamInt( pPos, pVal ) 
	' @desc Int 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamInt (pPos, pVal)
		
		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adInteger, adParamInput, , Int(pVal))
    
	End function
	
	'
	' @name SetparamTinyInt( pPos, pVal ) 
	' @desc Int 형의 Input 쿼리문의 파라미터를 Setting한다.
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetparamTinyInt (pPos, pVal)
		
		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adTinyInt, adParamInput, , Int(pVal))
    
	End function
	
	'
	' @name SetparamBigInt( pPos, pVal ) 
	' @desc BigInt 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	public function SetParamBigInt (pPos, pVal)

		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adBigInt, adParamInput, , pVal)
    
	End function
	
	'
	' @name SetparamDate( pPos, pVal ) 
	' @desc Date 형의 Input 쿼리문의 파라미터를 Setting한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	
	public function SetParamDate (pPos, pVal)
		
   	 mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, adDate, adParamInput, , pVal)
    
	End function
	
	
	'
	' @name SetparamType( pPos, pVal, pType ) 
	' @desc 일반형의 Input 쿼리문의 파라미터를 Setting 하고 파라메터를 지정한다. 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	' @param  pType  Int   파라메터 Type 지정 상수 ( adChar, adInteger, adVarChar, ... ) 
	'
	public function SetParamType ( pPos, pVal, pType)
		
   		mCmd.Parameters.Append mCmd.CreateParameter("@InParam"&pPos, pType, adParamInput, 100, pVal)
    
	end function
	
	' 
	' @name Setparam( pPos, pVal ) 
	' @desc Varchar 형의 Input 쿼리문의 파라미터를 Setting한다.(사용안함) 
	' @param  pPos  Int 파라메터 순서 
	' @param  pValue String 파라메터 Value  
	'
	
	public function SetParam ( pPos, pVal )
		
   		mCmd.Parameters.Append   mCmd.CreateParameter("@InParam"&pPos, adVarChar, adParamInput, len( pVal)*2 , pVal)
 
  	end function
	
  	public function SetInParam ( pPos, pVal )
		
   		mCmd.Parameters.Append   mCmd.CreateParameter( pPos, adInteger, adParamInput, 100, pVal)
 
  	End function
  	
  	
	'
	' @name SetOutParamInt( pPos ) 
	' @desc Integer 형의 Output  파라미터를 Setting 한다. 
	' @param  pName  Output 파라메터 이름 
	
	public function SetOutParamInt ( pName)
		
   	 	mCmd.Parameters.Append mCmd.CreateParameter( pName, adInteger, adParamOutput, 4)
    
	end function
	
	
	
	public function SetOutParam ( pName,  pType, pSize )
		
   		mCmd.Parameters.Append mCmd.CreateParameter( pName, pType, adParamOutput, pSize)
    
	end function
	
	public function SetReturnParam ( pName,  pType )
		
   	 	mCmd.Parameters.Append mCmd.CreateParameter( pName, pType, adParamReturnValue , 100 )
    
	end function
	
	
	
	'
	' @name GetOutParam( pPos ) 
	' @desc Output  파라미터에 할당된 값을 가지고 온다. 
	' @param  pName  Output 파라메터 이름 
	
	
	public function GetOutParam ( pName )
	
		GetOutParam = mCmd.Parameters( pName )
	
	end function
	
	
	'
	' @name Execute( byRef pConn  ) 
	' @desc INSERT/ UPDATE/ DELETE 쿼리처리
	' @param  pConn   DB Connection 
	' @return 성공일때 true를 돌려 준다. 
	'
	
	Public Function Execute (byRef pConn)
	
		if len(pConn) = 0  then 
				ErrorNotConnect()
				exit function
		end if   
			
		mCmd.ActiveConnection = pConn
		TraceError( Err ) 
	
		'Debug()

		mCmd.Execute mAffected, ,adExecuteNoRecords 
		
		TraceError( Err ) 
	    
		Execute = true
		
	End Function
	
	
	'
	' @name Patch( byRef pConn  ) 
	' @desc SELECT 쿼리처리를 하여 mResultSet객체에 Return값을 넣어준다.  
	' @param  pConn   DB Connection 
	' @return 성공일때 Select 한 Row 갯수를 돌려 준다. 
	'
	public function Patch (byRef pConn)
		dim strSql
		dim objRS, objMemVal
		
		if IsNull(pConn ) or len(pConn) = 0  then 
				ErrorNotConnect()
				exit function
		end if   
		
		mCmd.ActiveConnection = pConn
		
		'Debug()
		set objRs = mCmd.Execute ( mAffected )
		TraceError( Err ) 
	
		set mResultSet = nothing
		set mResultSet = server.CreateObject ("Scripting.Dictionary")
		
		Dim idx
		idx = 0  
		
		'response.write ( "BOF::"& objRs.BOF )
		'response.write ( "EOF::"& objRs.EOF )
		
		'On Error Resume Next 
		
		Do While not objRs.BOF and not objRs.EOF 
			dim objTmpDic, objElm
			set objTmpDic = server.CreateObject ("Scripting.Dictionary")
						for each objElm in objRS.Fields
							if isnull(objElm) then 
								objTmpDic.Add objElm.name, ""
							else	
								
								objTmpDic.Add objElm.name, Cstr(objElm)
							end if
						next
					
						mResultSet.Add  idx, objTmpDic
						set objTmpdic = nothing
						objRS.moveNext ()
						idx = idx + 1 
		Loop
		
		objRS.close
		set objRS = nothing
	
		Patch = idx 

	
	End Function
	
	
	'
	' @name PatchPage( byRef pConn, pStartRow, pSize  ) 
	' @desc SELECT 쿼리처리를 하여 mResultSet객체에 특정 순서 부터 특정 갯수 만큼 Return값을 넣어준다.  
	' @param  pConn   DB Connection 
	' @param  pStartRow  가져올 첫 Row 순서 
	' @param  pSize   	가져올 Row 갯수 
	' @return 성공일때 Select 한 Row 갯수를 돌려 준다. 
	'
	
	Public Function PatchPage (byRef pConn, pStartRow, pSize )
		dim strSql
		dim objRS, objMemVal
		
		if len(pConn) = 0  then 
				ErrorNotConnect()
				exit function
		end if   
		
		mCmd.ActiveConnection = pConn
		
		
		set objRs = mCmd.Execute ( mAffected )
			  	TraceError( Err ) 
			  	
		set mResultSet = nothing
		set mResultSet = server.CreateObject ("Scripting.Dictionary")
		
		Dim idx
		idx = 0  
		
		If pStartRow > 0 Then
			objRS.Move ( pStartRow )
		End If

		Do While not objRs.eof 
		
				dim objTmpDic, objElm
				set objTmpDic = server.CreateObject ("Scripting.Dictionary")
						for each objElm in objRS.Fields
						  if isNull(objElm) Or objElm = "" then 
								objTmpDic.Add objElm.name, ""
							Else
								'response.write objElm.name & "::" &objElm&"<br>"
								'objTmpDic.Add objElm.name, objElm
								
								objTmpDic.Add objElm.name, Cstr(objElm)
							end if
						next
					
						mResultSet.Add  idx, objTmpDic
					

					set objTmpdic = nothing
			idx = idx + 1 
				
			objRS.MoveNext ()

			
		Loop
		
		objRs.Close
		set objRS = nothing
	
		PatchPage = idx 
	End Function
	
	'
	' @name Patch( byRef pConn  ) 
	' @desc SELECT 쿼리처리를 하여 mResultSet객체에 넣지 않고 새로운 Return값을 생성하여 넘겨준다..  
	' @param  pConn   DB Connection 
	' @return 새로운 결과 객체로 된 결과를 반환한다. 
	'
	public function PatchRs (byRef pConn)
		dim strSql
		dim objRS, objMemVal
		
		if len(pConn) = 0  then 
				ErrorNotConnect()
				exit function
		end if   
		
		mCmd.ActiveConnection = pConn
		
		set objRs = mCmd.Execute ( mAffected )
		TraceError( Err ) 
	
		set mTmpResultSet = nothing 
		set mTmpResultSet = server.CreateObject ("Scripting.Dictionary")
		
		Dim idx
		idx = 0  
		
		Do While not objRs.eof 
			dim objTmpDic, objElm
			set objTmpDic = server.CreateObject ("Scripting.Dictionary")
						for each objElm in objRS.Fields
						  if isNull(objElm) then 
								objTmpDic.Add objElm.name, ""
							else
								objTmpDic.Add objElm.name, Cstr(objElm)
							end if
						next
					
						mTmpResultSet.Add  idx, objTmpDic
						set objTmpdic = nothing
						objRS.moveNext ()
						idx = idx + 1 
		Loop
		
		objRS.Close
		set objRS = nothing
	
		
		set PatchRs = mTmpResultSet  
	End Function
	
	
	'
	' @name PatchRsArray (byRef pConn , pCount)
	' @desc 다수의 SELECT 쿼리처리를 하여 Array로 Result값을 반환한다.  
	' @param  pConn   DB Connection 
	' @return 새로운 결과 객체로 된 결과를 반환한다. 
	'
	public function PatchRsArray (byRef pConn , pCount)
		Dim strSql
		Dim objRS, objMemVal
		
		Dim  fTmpResultSet
		Dim  fRsArray
		ReDim fRsArray(pCount)
		
		if len(pConn) = 0  then 
				ErrorNotConnect()
				exit function
		end if   
		
		mCmd.ActiveConnection = pConn
		
		set objRs = mCmd.Execute ( mAffected )
		'debug()
		TraceError( Err ) 
	
		Dim i
		For i=0 To pCount -1 
			
			set fTmpResultSet = nothing 
			set fTmpResultSet = server.CreateObject ("Scripting.Dictionary")
			
			Dim idx
			idx = 0  
			
			'Response.Write "RsArray ("&i&")"
			Do While not objRs.eof 
				dim objTmpDic, objElm
				set objTmpDic = server.CreateObject ("Scripting.Dictionary")
							for each objElm in objRS.Fields
							  if isNull(objElm) then 
									objTmpDic.Add objElm.name, ""
								else
									objTmpDic.Add objElm.name, Cstr(objElm)
								end if
							next
						
							fTmpResultSet.Add  idx, objTmpDic
							set objTmpdic = nothing
							objRS.moveNext ()
							idx = idx + 1 
			Loop
			
			If i = 0 Then 
				Set mResultSet = fTmpResultSet
			End If
			
			Set fRsArray(i) = fTmpResultSet
			
			Set objRs = objRs.NextRecordSet
			
		Next
		
		'objRs.Close
		Set objRS = nothing
	
		PatchRsArray = fRsArray 
		
	End Function
	
	
	'-------------------------------------------
	' Injection Code - "'" 만 처리 한다.
	'-------------------------------------------
	Public Function ReplaceQuery(ByVal pStr)
	
		ReplaceQuery		= Replace(Trim(pStr),"'","''")
	
	End Function
	
	
	
	'
	' DB 시스템 Error Trace 함수  
	'
	public function TraceError( pErr )
	
		
		If pErr.number <> 0 then
			with response
				.write "<br>[실행 쿼리] : <font color='blue'>" & mCmd.CommandText & "</font><br>"
				.write "[오류 내용] : <font color='red'>" & Err.Description & "</font><br>"
				.write "[에러 소스] : <font color='red'>" & Err.Source & "</font><br>"
				.write "[파일 위치] : <font color='red'>" & request.ServerVariables ("SCRIPT_NAME") & "</font><br>"
				.end
			end with
				Err.Clear ()
				
		end if
		
	end function
	public function ErrorNotConnect()
				Response.Write "[Error] : <font color='blue'>DB와 연결정보가 없습니다.</font><br>"
	end function
	
	'
	' 클래스 Debug 를 위한 함수 
	'
	public function Debug ()
		dim objElm, objElm2

		with response
			.Write "============== DEBUG VAR ==============<br>"
		
			.write "[PreQuery] : <font color='blue'>" & mPreQuery & "</font><br>"
			
			If  IsObject(mTmpResultSet) then 
				
				Dim i
				For i=0 to mCmd.Parameters.count-1 
					.Write  "Params [" & mCmd.Parameters(i).Name & "]::  "
					.Write  "<font color='blue'>" &  mCmd.Parameters(i).Value  & "</font><br> " 
				Next
			End If
					
			.Write "<br>[결과 값]<br>"
			.Write "<br>[mAffected] : <font color='blue'>" & mAffected & "</font><br>"
			DebugResult()
			DebugTmpResult()		
			
		end with
	end function
	
	Function DebugResult()
	
			if not IsObject(mResultSet) or mResultSet Is nothing then 
				Exit Function
			End if			
			
			Response.Write ( "<br><br>Result 갯수 :: ["& mResultSet.Count&"]<br>" )
			
			Dim key1, key2
			For Each key1 in mResultSet
				for each key2 in mResultSet(key1)

					Response.Write ( "Resultset [" & key1 & "][" & key2 &"]:: " &  Len(mResultSet(key1)(key2))  & "<br>") 
				next
			next
	
	
	End Function
	
	
	Function DebugTmpResult()
	
			
			if not IsObject(mTmpResultSet) or mTmpResultSet Is nothing then 
				Exit Function
			End if			
		    
			Response.Write ( "<br><br>tmpResult 갯수 :: ["& mTmpResultSet.Count&"]<br>" )
			
			Dim key1, key2
			for each key1 in mTmpResultSet
				for each key2 in mTmpResultSet(key1)
					Response.Write ( "TmpResultset [" & key1 & "][" & key2 &"]:: " &  mTmpResultSet(key1)(key2)  & "<br>") 
				next
			next
	
	
	End Function
	
	
End Class
' ####################################################################################################################
%>
