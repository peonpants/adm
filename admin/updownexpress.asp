<%@ Language=VBScript %>
<% Server.ScriptTimeout = 60 %>
<% Response.Expires = 0 %>

<%
dim xup, xattach

' ���ε� ��ü�� �����Ѵ�.
set xup = Server.CreateObject("UpDownExpress.FileUpload")

xup.InitControl
' ���޵� �Ķ���� ������ ����Ѵ�. - ���������� �����
'xup.ViewParam 

' ÷�� ���� ������ �����´�.
for each xattach in xup.Attachments
	xattach.SaveFile "/file/" & xattach.FileName, true '������ �����Ѵ�.
next


set xup = nothing


%>
