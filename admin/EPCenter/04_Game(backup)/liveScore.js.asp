<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<%


    '######### XMLHTTP
    url = "http://free.7m.cn/datafile/sXl.js?" & dfStringUtil.GetFullDate(now())
    Set xmlHttp =  Server.CreateObject("msxml2.Xmlhttp.3.0") 
        xmlHttp.Open "get", url, false
        
        xmlHttp.Send      
        response.Write "var sDt2 = new Array();"
        response.write xmlHttp.ResponseText
    Set xmlHttp = Nothing
    
%>