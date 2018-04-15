<%
 Response.Expires = -1
 Response.Expiresabsolute = Now() - 1
 Response.AddHeader "pragma","no-cache"
 Response.AddHeader "chche-control", "private"
 Response.CacheControl = "no-cache"
%>

<%
 targetURL = "http://naver.com"

 Set xmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP") 
  xmlHttp.Open "GET", targetURL, False
  xmlHttp.Send 
  
 Set xmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.4.0")
  xmlDOM.async = False 
  xmlDOM.LoadXML xmlHttp.responseText
  
 Set xmlHttp = Nothing 
 
  Set rootNode = xmlDOM.selectNodes("---최상위엘리먼트명---")
   Set itemNode = rootNode(0).childNodes 

    DIM arr_MovieData()
    
    For i = 0 To itemNode.length-1    
   
     Set ChildNode = itemNode(i).childNodes     
      ChildNodeCNT = ChildNode.length-1    

      REDIM arr_MovieData(itemNode.length, ChildNode.length)  
      
      For j = 0 To ChildNode.length-1    
       
       arr_MovieData(i, j) = ChildNode(j).childNodes(0).Text
       Response.Write(arr_MovieData(i, j) & "   ")
       'insert job <================================== 루프돌면서 이부분에서 처리해준다.
      Next      
     Set ChildNode = Nothing 
     Response.Write("<br/>")
    Next  
   
   Set itemNode = Nothing 
  Set rootNode = Nothing 
 
 Set xmlDOM = Nothing  
%>
