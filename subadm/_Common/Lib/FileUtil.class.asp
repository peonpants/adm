<%
'
'  화일 처리 관련 Class 
'
'
Class FileUtil

	Public mFs
	Public mFileStream
	
	'
	' @desc 생성자로 File 처리 객체를 생성한다.  
	'
	Private Sub Class_initialize ()
		set mFs = Server.CreateObject("Scripting.FileSystemObject")
	End Sub
	
	
	Private Sub Class_terminate ()
	End Sub

	'
	' 읽기 전용으로 화일을 연다. 
	'
	Public Function OpenRead( pUrl)
		
		Set mFileStream = mFs.OpenTextFile( pPath, 0 )
		
	End Function 
	
	'
	' 쓰기 전용으로 화일을 연다, 화일이 없을경우 생성한다. 
	'
	Public Function OpenWrite( pUrl)
		
		Set mFileStream = mFs.OpenTextFile( pPath, 2, true )
		
	End Function 
	
	'
	' 쓰기와 추가하기 권한으로 화일을 연다. 화일이 없을 경우 생성한다.
	'
	Public Function OpenAppend( pUrl)
		
		Set mFileStream = mFs.OpenTextFile( pPath, 8, true )
		
	End Function 
	
	
	Public Function GetContent()
	
		GetContent = mFileStream.ReadAll
	
	End Function
	
		
	
End Class

Dim dfFileUtil 
set dfFileUtil = new FileUtil



%>

