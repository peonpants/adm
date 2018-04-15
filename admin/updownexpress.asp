<%@ Language=VBScript %>
<% Server.ScriptTimeout = 60 %>
<% Response.Expires = 0 %>

<%
dim xup, xattach

' 업로드 객체를 생성한다.
set xup = Server.CreateObject("UpDownExpress.FileUpload")

xup.InitControl
' 전달된 파라메터 정보를 출력한다. - 디버깅용으로 사용함
'xup.ViewParam 

' 첨부 파일 정보를 가져온다.
for each xattach in xup.Attachments
	xattach.SaveFile "/file/" & xattach.FileName, true '파일을 저장한다.
next


set xup = nothing


%>
