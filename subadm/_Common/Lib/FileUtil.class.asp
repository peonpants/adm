<%
'
'  ȭ�� ó�� ���� Class 
'
'
Class FileUtil

	Public mFs
	Public mFileStream
	
	'
	' @desc �����ڷ� File ó�� ��ü�� �����Ѵ�.  
	'
	Private Sub Class_initialize ()
		set mFs = Server.CreateObject("Scripting.FileSystemObject")
	End Sub
	
	
	Private Sub Class_terminate ()
	End Sub

	'
	' �б� �������� ȭ���� ����. 
	'
	Public Function OpenRead( pUrl)
		
		Set mFileStream = mFs.OpenTextFile( pPath, 0 )
		
	End Function 
	
	'
	' ���� �������� ȭ���� ����, ȭ���� ������� �����Ѵ�. 
	'
	Public Function OpenWrite( pUrl)
		
		Set mFileStream = mFs.OpenTextFile( pPath, 2, true )
		
	End Function 
	
	'
	' ����� �߰��ϱ� �������� ȭ���� ����. ȭ���� ���� ��� �����Ѵ�.
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

