<%
	Set DbCon = Server.CreateObject("ADODB.Connection")
	
	DbCon.Open Application("DBConnString")

	JOBSITE = Session("rJOBSITE")

	'Ư������ �����ϱ�
	Function Checkot(CheckValue)
		CheckValue = replace(CheckValue, "&lt;", "<")
		CheckValue = replace(CheckValue, "&gt;", ">")	
		CheckValue = replace(CheckValue, "&amp;", "&" )
		Checkot = CheckValue
	End Function

	Function Checkit(CheckValue)
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "''")
		Checkit = CheckValue
	End Function

	Function numdel(var)
		If InStr(var,".") Then
			a = Split(var,".")(0)
			If Len(Left(Split(var,".")(1),2)) > 1 Then
				b = Left(Split(var,".")(1),2)
			ElseIf Len(Left(Split(var,".")(1),2)) > 0 Then 
				b = Left(Split(var,".")(1),2) & "0"
			Else 
				b = "00"
			End If 
			var = a & "." & b
		Else
			var = var & ".00"
		End If 

		numdel = var
	End Function 

	Function numdel2(var)
		If InStr(var,".") Then
			a = Split(var,".")(0)
			var = a 
		Else
			var = var 
		End If 

		numdel2 = var
	End Function 
%>
<%

  // �켱 ������ ���� �Լ��� �ۼ��մϴ�.

   FUNCTION GetResultFromURL(Xurl)

	Dim RStr
	Dim xmlHttp

	SET xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
	xmlHttp.open "GET", Xurl, False
	xmlHttp.setRequestHeader "Content-Type","text/xml"
	xmlHttp.setRequestHeader "Accept-Language","ko"
	xmlHttp.send

	if xmlHttp.status = 200 then
		RStr = xmlHttp.responseText
	Else
		RStr = "get_fail"
	End if

	SET xmlHttp = Nothing

	GetResultFromURL = RStr

   END FUNCTION

  // �� ��� ���� ���߿��� returnurl ���� ���ܽ��� �ּ���. 
  // �׸��� �ѱ��̳� Ư�����ڰ� ��� �ִ� ���� urlencode �� ���ּ���.Ư�� msg1 �� �Ǵ� resdate �� ���..
  'En_msg1 = Server.URLEncode("�ȳ��ϼ���.���ڿձ��Դϴ�.")
  'En_resdate = Server.URLEncode("2004-03-01 00:00:00")


  'Xurl = "http://sms.nicesms.co.kr/cpsms/cpsms.aspx?userid=nicesms&password=1234&msgcnt=1&msg1="&En_msg1&"&receivers=01022223333&sender=01022223333&resflag=Y&resdate="&En_resdate

  'Retval = GetResultFromURL(Xurl)

  'Response.write Retval      // "��� ��� ����" ����

%>