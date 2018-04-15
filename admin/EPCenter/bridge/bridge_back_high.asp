<%@Language="VBScript" CODEPAGE="65001" %>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%> 

<%
function getHTML(url, data)
    Set xmlHttp = Server.Createobject("WinHttp.WinHttpRequest.5.1")
    xmlHttp.Open "POST", url, False
    xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    xmlhttp.Option(4) = 13056
    xmlHttp.Send Data
    getHTML = xmlHttp.responseText
    xmlHttp.abort()
    set xmlHttp = Nothing   
end function

url = "https://api.good-day.com/login.asp"
data = "id=cjstkd1&pwd=asas1133"

ajax = getHTML(url,data)
response.write(ajax)

%>