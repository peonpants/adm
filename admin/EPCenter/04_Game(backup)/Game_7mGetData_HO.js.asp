<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

    Dim url
    Dim data
    
    '######### XMLHTTP
    url = "http://crowns2.7m.cn/default/kr.js"

    Set xmlHttp =  Server.CreateObject("msxml2.Xmlhttp.3.0") 
        xmlHttp.Open "get", url, false
        
        xmlHttp.Send      
        
        data = xmlHttp.ResponseText
        
        'replaceStr1 =  mid(data, instr(xmlHttp.ResponseText,"var dateStr=") , instr(xmlHttp.ResponseText,";"))
        'replaceStr2 =  mid(data, instr(data,"var fn=") , Len(data))
        'replaceStr3 = "var datas="
        'data =  replace(data, replaceStr1,"")
        'data =  replace(data, replaceStr2,"")
        'data =  replace(data, replaceStr3,"")

        response.Write data
        'putJsArray(data)        
    Set xmlHttp = Nothing

    
%>    