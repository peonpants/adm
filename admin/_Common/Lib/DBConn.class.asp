<%

' Data Base Connection을 맺어 주는 Class 


class DBConn 

	public mProvider	'Provider  
	public mUID			'UID
	public mPwd			'비밀번호
	public mCatalog		'카탈로그
	public mDataSource  'Data Source
	private mConn
	private mStrConn 

	' class 생성시 호출 된다. 
	private sub Class_initialize ()
		mStrConn = ""
	end sub
	
	' class 소멸시 호출 된다. 
	private sub Class_terminate ()
		'If not mConn is nothing Then
		'	Set mConn = nothing
		'End if
		Close()
	end sub
	
	
	' DataBase Connection정보를 넘겨주는 Property 
	
	Public Property Get Conn()
		
		Set Conn = mConn
		
	End Property
	
	
	' DataBase Connection정보를 넘겨주는 Property 
	
	Public Property Let SetConn( pConn )
		
		mStrConn = pConn
		
	End Property


	
	
	' 내부적으로 사용하는 Connection정보 만들기 
	
	Private Property Get ConnInfo()
		
		If Len(mStrConn) = 0 Then 
		
		
		mStrConn = "Provider="& mProvider & ";"
		mStrConn = mStrConn & "UID=" & mUID & ";"
		mStrConn = mStrConn & "PWD=" & mPwd & ";"
		mStrConn = mStrConn & "Initial Catalog=" & mCatalog & ";"
		mStrConn = mStrConn & "Data Source=" & mDataSource & ";"
		
		End If 
		
		ConnInfo = mStrConn
		
		'Response.Write tmpInfo
		
	End Property


	' Database 커넥션 정보를 가지고 온다. 
	
	Public function Connect()
		Set mConn = server.CreateObject ("Adodb.connection")
		Err.Clear	
		mConn.Open ConnInfo()
		TraceError( Err )
		
		
	End function
	
	
	' DB Connection을 사용을 다한 경우 닫아 준다. 
	
	Public Function Close()
		'mConn.Close
		'Set mConn = nothing
		If IsObject(mConn) Then
			If Not mConn is Nothing Then
				If mConn.State = adStateOpen Then
					mConn.Close
				End If
			End If
			Set mConn = nothing
		End if	
	End Function	
	
	' 오류 정보를 뿌려 준다. 
	
	Public function TraceError( pErr )
	
		
		If pErr.number <> 0 then
			with response
				.write "[오류 내용] : <font color='red'>" & Err.Description & "</font><br>"
				.write "[에러 소스] : <font color='red'>" & Err.Source & "</font><br>"
				.write "[파일 위치] : <font color='red'>" & request.ServerVariables ("SCRIPT_NAME") & "</font><br>"
			end with
			pErr.Clear ()
				
		end if
		
	end function
  
	Public Function Debug()
		Dim tmpInfo
		response.Write( "<font color=red>")
		response.Write ( ConnInfo )
		response.Write( "</font>")
		
		
	End Function

End class

Dim dfDBConn
Set dfDBConn = new DBConn


%>
