<%

' Data Base Connection�� �ξ� �ִ� Class 


class DBConn 

	public mProvider	'Provider  
	public mUID			'UID
	public mPwd			'��й�ȣ
	public mCatalog		'īŻ�α�
	public mDataSource  'Data Source
	private mConn
	private mStrConn 

	' class ������ ȣ�� �ȴ�. 
	private sub Class_initialize ()
		mStrConn = ""
	end sub
	
	' class �Ҹ�� ȣ�� �ȴ�. 
	private sub Class_terminate ()
		'If not mConn is nothing Then
		'	Set mConn = nothing
		'End if
		Close()
	end sub
	
	
	' DataBase Connection������ �Ѱ��ִ� Property 
	
	Public Property Get Conn()
		
		Set Conn = mConn
		
	End Property
	
	
	' DataBase Connection������ �Ѱ��ִ� Property 
	
	Public Property Let SetConn( pConn )
		
		mStrConn = pConn
		
	End Property


	
	
	' ���������� ����ϴ� Connection���� ����� 
	
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


	' Database Ŀ�ؼ� ������ ������ �´�. 
	
	Public function Connect()
		Set mConn = server.CreateObject ("Adodb.connection")
		Err.Clear	
		mConn.Open ConnInfo()
		TraceError( Err )
		
		
	End function
	
	
	' DB Connection�� ����� ���� ��� �ݾ� �ش�. 
	
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
	
	' ���� ������ �ѷ� �ش�. 
	
	Public function TraceError( pErr )
	
		
		If pErr.number <> 0 then
			with response
				.write "[���� ����] : <font color='red'>" & Err.Description & "</font><br>"
				.write "[���� �ҽ�] : <font color='red'>" & Err.Source & "</font><br>"
				.write "[���� ��ġ] : <font color='red'>" & request.ServerVariables ("SCRIPT_NAME") & "</font><br>"
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
